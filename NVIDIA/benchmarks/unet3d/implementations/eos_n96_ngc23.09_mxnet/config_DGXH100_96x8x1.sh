## DL params
export OPTIMIZER="nag"
export BATCHSIZE="1"
export VAL_BATCHSIZE="1"
export LR="1.5"
export LR_WARMUP_EPOCHS="1500"
export MAX_EPOCHS=${MAX_EPOCHS:-10000}
export START_EVAL_AT=1000
export EVALUATE_EVERY=20
export QUALITY_THRESHOLD="0.908"
export INPUT_BATCH_MULTIPLIER=4
export NUM_WORKERS=4
export ASYNC_PARAMS=" --nodes_for_eval 12 -sgs 8 -ucl -sts --eval_mode sharded"
export EXTRA_PARAMS=${EXTRA_PARAMS:-" --use_nvshmem"}
export PRECISION=${PRECISION:-"--static_cast -sls 512 -gpf 512 --loss_scale_inc_cycles 70 --fp16in "}

export SBATCH_NETWORK=sharp
export HCOLL_ENABLE_MCAST=0
export CUDA_DEVICE_MAX_CONNECTIONS=1
export MXNET_SPATIALCONV_TUNING_DELAY_COUNT=2

export MXNET_CUDNN_NHWC_BN_ADD_HEURISTIC_GBN=3
export MXNET_CUDNN_NHWC_BN_HEURISTIC_GBN=3

#export OMP_NUM_THREADS=1
export HOROVOD_CYCLE_TIME=0.1
#export MXNET_HOROVOD_NUM_GROUPS=20
export OMPI_MCA_btl=^openib
#export NCCL_MAX_RINGS=8
#export NCCL_BUFFSIZE=2097152
#export NCCL_NET_GDR_READ=1
#export HOROVOD_FUSION_THRESHOLD=67108864
#export HOROVOD_NUM_NCCL_STREAMS=1
export HOROVOD_BATCH_D2D_MEMCOPIES=1
export HOROVOD_GROUPED_ALLREDUCES=1
export MXNET_SPATIALCONV_TUNING_DELAY_COUNT=2
export CUDA_DEVICE_MAX_CONNECTIONS=1
export CUDNN_FORCE_KERNEL_INIT=1

## System run parms
export DGXNNODES=96
export DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )

WALLTIME_MINUTES=3
if [[ ${MLPERF_POWER_TRAIN_AFTER_RUN_STOP} -gt 0 ]]; then
  WALLTIME_MINUTES=$((${WALLTIME_MINUTES} + 10))
  export EXTRA_PARAMS="${EXTRA_PARAMS} -stt 10 "
  export MAX_EPOCHS=100000
fi
export WALLTIME=$(( 20 + (${NEXP:-1} * ${WALLTIME_MINUTES}) ))

## System config params
export DGXNGPU=8
export DGXSOCKETCORES=64
export DGXNSOCKET=2
export DGXHT=2  # HT is on is 2, HT off is 1
