Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8A3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF45206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZnp+NqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgHJMsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:48:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57713 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgHJMsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597063689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=elUAYENYZnu1EZu3LiEjTqoKeDvH3BX6nsYhm9sum60=;
        b=gZnp+NqKJmZ7MKbvT6E1cpcxpdZLIi35LQ/JtaWKj/dgEdKkbuQwxudcG8ipK5bTVUIt9g
        tWLpN8SauLz8sWVjfZyy6qmT4OF7B9uBdXeZqkRtsIH1jCJYkF+iyZBMe9EnaGGV5K7us/
        x3PiknBF3kNO9p1K/FJ/gQmRY0+u7zI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-6nNU7BpaM2ef3PNVdqQcBg-1; Mon, 10 Aug 2020 08:48:05 -0400
X-MC-Unique: 6nNU7BpaM2ef3PNVdqQcBg-1
Received: by mail-wm1-f69.google.com with SMTP id p184so2741059wmp.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elUAYENYZnu1EZu3LiEjTqoKeDvH3BX6nsYhm9sum60=;
        b=My9z0xwFJulr4J8CaM5kW6+VDyY6QzQZvS6OpfuLwcefJuE+FxgfBWlmLDzDY+dYyc
         Fzf4EgBCB3tLRLOcGJmIO/OWRRcUuV5xiHBv3jhj24XO2WCLBLetRYEdRdiYp0onAWnI
         p8+AIgmLW+iAvDXCvw/vhQd0F6yWLmrn2Cngrn0YPCK8p4rD7/Dr45DRTevuht4UJdAi
         7YjomNoaqEQdcVW3vvwre6c96Q/gn5fz3vhWJbHWD2UM93tX3Td+ITLWzZtR2Phqh/5d
         7ztDHOgOJ29qMTsr4KYCJBY//o7tmoXBIdDWzV2ebWRypsHGaUQ5Q7upP8gc88fWmvQd
         RRRQ==
X-Gm-Message-State: AOAM530BOLw1yLy93V7u20gEELN7Wouqjk8HszbxXvr4sgSbbJCowXjP
        U0U61PggAlajlyohtoXQIeiepQ3IuGhKhg7W1lDNVY10AlAwSvFmW8DG9O2xu3ovIcPngOq+n7h
        gU2hT92da1KFTQYc/cueyb04k
X-Received: by 2002:adf:e647:: with SMTP id b7mr1430196wrn.220.1597063683365;
        Mon, 10 Aug 2020 05:48:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Z5SspKSFyp/b61joqAwqFDRR2bqCPDlsX3NUfcIFZt4kqTru7coM/YT1kvSboCUs043Kcg==
X-Received: by 2002:adf:e647:: with SMTP id b7mr1430034wrn.220.1597063681885;
        Mon, 10 Aug 2020 05:48:01 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id y16sm20264069wrr.83.2020.08.10.05.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:48:00 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:47:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, Jason Wang <jasowang@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [vdpasim] 0ea9ee430e: INFO:trying_to_register_non-static_key
Message-ID: <20200810084720-mutt-send-email-mst@kernel.org>
References: <20200810025516.GG1538@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810025516.GG1538@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:55:16AM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 0ea9ee430e74b16c6b17e70757d1c26d8d140e1f ("vdpasim: protect concurrent access to iommu iotlb")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> 
> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +----------------------------------------+------------+------------+
> |                                        | 6234f80574 | 0ea9ee430e |
> +----------------------------------------+------------+------------+
> | boot_successes                         | 7          | 0          |
> | boot_failures                          | 0          | 12         |
> | INFO:trying_to_register_non-static_key | 0          | 12         |
> +----------------------------------------+------------+------------+
> 

OK, that is because the lock here is not initialized properly.
Sending a patch now.
Thanks!

> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [    3.762722] INFO: trying to register non-static key.
> [    3.762830] the code is fine but needs lockdep annotation.
> [    3.762830] turning off the locking correctness validator.
> [    3.762830] CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-00043-g0ea9ee430e74b #1
> [    3.762830] Call Trace:
> [    3.762830]  dump_stack+0x1b/0x1e
> [    3.762830]  register_lock_class+0x597/0x5a0
> [    3.762830]  ? sched_clock_cpu+0xd5/0xf0
> [    3.762830]  __lock_acquire+0x36/0x4f0
> [    3.762830]  lock_acquire+0x3e/0x70
> [    3.762830]  ? vdpasim_set_status+0x142/0x190
> [    3.762830]  _raw_spin_lock+0x28/0x70
> [    3.762830]  ? vdpasim_set_status+0x142/0x190
> [    3.762830]  vdpasim_set_status+0x142/0x190
> [    3.762830]  virtio_vdpa_reset+0x20/0x30
> [    3.762830]  register_virtio_device+0x72/0xe0
> [    3.762830]  virtio_vdpa_probe+0x9f/0xe0
> [    3.762830]  vdpa_dev_probe+0x18/0x30
> [    3.762830]  really_probe+0xd5/0x270
> [    3.762830]  driver_probe_device+0x44/0xa0
> [    3.762830]  __device_attach_driver+0x54/0x80
> [    3.762830]  ? driver_allows_async_probing+0x50/0x50
> [    3.762830]  bus_for_each_drv+0x4e/0x80
> [    3.762830]  __device_attach+0xa7/0x100
> [    3.762830]  ? driver_allows_async_probing+0x50/0x50
> [    3.762830]  device_initial_probe+0xd/0x10
> [    3.762830]  bus_probe_device+0x6f/0x80
> [    3.762830]  device_add+0x31a/0x6a0
> [    3.762830]  ? virtio_vdpa_driver_init+0x11/0x11
> [    3.762830]  vdpa_register_device+0x8/0x10
> [    3.762830]  vdpasim_dev_init+0x12d/0x15e
> [    3.762830]  ? virtio_vdpa_driver_init+0x11/0x11
> [    3.762830]  do_one_initcall+0x36/0x130
> [    3.762830]  ? parse_args+0x100/0x270
> [    3.762830]  ? do_initcalls+0x78/0xc0
> [    3.762830]  do_initcalls+0x9d/0xc0
> [    3.762830]  kernel_init_freeable+0x77/0xc1
> [    3.762830]  ? rest_init+0xf9/0xf9
> [    3.762830]  kernel_init+0x8/0xe7
> [    3.762830]  ret_from_fork+0x1c/0x28
> [    3.786853] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    3.787487] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    3.788823] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [    3.795236] MOXA Intellio family driver version 6.0k
> [    3.795613] SyncLink GT
> [    3.795786] SyncLink GT, tty major#234
> [    3.796108] SyncLink GT no devices found
> [    3.796418] SyncLink MultiPort driver $Revision: 4.38 $
> [    3.800879] SyncLink MultiPort driver $Revision: 4.38 $, tty major#511
> [    3.801358] SyncLink serial driver $Revision: 4.38 $
> [    3.805478] SyncLink serial driver $Revision: 4.38 $, tty major#510
> [    3.806029] sonypi: Sony Programmable I/O Controller Driver v1.26.
> [    3.806473] toshiba: not a supported Toshiba laptop
> [    3.806891] scx200_gpio: no SCx200 gpio present
> [    3.807200] nsc_gpio initializing
> [    3.807434] telclk_interrupt = 0xf non-mcpbl0010 hw.
> [    3.807784] smapi::smapi_init, ERROR invalid usSmapiID
> [    3.808132] mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is not available on this machine
> [    3.808750] mwave: mwavedd::mwave_init: Error: Failed to initialize board data
> [    3.809234] mwave: mwavedd::mwave_init: Error: Failed to initialize
> [    3.809653] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
> [    3.810557] random: get_random_u32 called from test_drm_mm_init+0x13/0xab with crng_init=0
> [    3.810559] drm_mm: Testing DRM range manger (struct drm_mm), with random_seed=0x63ffe4ab max_iterations=8192 max_prime=128
> [    3.811865] drm_mm: igt_sanitycheck - ok!
> [    3.812159] igt_debug 0x0000000000000000-0x0000000000000200: 512: free
> [    3.812595] igt_debug 0x0000000000000200-0x0000000000000600: 1024: used
> [    3.813068] igt_debug 0x0000000000000600-0x0000000000000a00: 1024: free
> [    3.813508] igt_debug 0x0000000000000a00-0x0000000000000e00: 1024: used
> [    3.813970] igt_debug 0x0000000000000e00-0x0000000000001000: 512: free
> [    3.814415] igt_debug total: 4096, used 2048 free 2048
> [   50.319538] [drm] amdgpu kernel modesetting enabled.
> [   50.320388] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
> [   50.321024] [drm] Found bochs VGA, ID 0xb0c0.
> [   50.321327] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
> [   50.321889] [TTM] Zone  kernel: Available graphics memory: 915974 KiB
> [   50.322331] [TTM] Initializing pool allocator
> [   50.322634] [TTM] Initializing DMA pool allocator
> [   50.323136] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 1
> [   50.324697] bochs-drm 0000:00:02.0: fb0: bochs-drmdrmfb frame buffer device
> [   50.326243] usbcore: registered new interface driver gm12u320
> [   50.326745] dummy-irq: no IRQ given.  Use irq=N
> [   50.327085] Phantom Linux Driver, version n0.9.8, init OK
> [   50.327476] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
> [   50.328024] c2port c2port0: C2 port uc added
> [   50.328312] c2port c2port0: uc flash has 30 blocks x 512 bytes (15360 bytes total)
> [   50.328958] Guest personality initialized and is inactive
> [   50.329355] VMCI host device registered (name=vmci, major=10, minor=60)
> [   50.329795] Initialized host personality
> [   50.330115] usbcore: registered new interface driver rtsx_usb
> [   50.330802] usbcore: registered new interface driver viperboard
> [   50.331237] usbcore: registered new interface driver dln2
> [   50.331667] dma-buf: Running sanitycheck
> [   50.331951] dma-buf: Running dma_fence
> [   50.332204] sizeof(dma_fence)=44
> [   50.332428] dma-buf: Running dma_fence/sanitycheck
> [   50.332751] dma-buf: Running dma_fence/test_signaling
> [   50.333091] dma-buf: Running dma_fence/test_add_callback
> [   50.333446] dma-buf: Running dma_fence/test_late_add_callback
> [   50.333833] dma-buf: Running dma_fence/test_rm_callback
> [   50.334182] dma-buf: Running dma_fence/test_late_rm_callback
> [   50.334559] dma-buf: Running dma_fence/test_status
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.8.0-00043-g0ea9ee430e74b .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong Chen
> 

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/i386 5.8.0 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=90300
> CONFIG_LD_VERSION=235000000
> CONFIG_CLANG_VERSION=0
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> # CONFIG_KERNEL_GZIP is not set
> CONFIG_KERNEL_BZIP2=y
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> CONFIG_WATCH_QUEUE=y
> # CONFIG_CROSS_MEMORY_ATTACH is not set
> CONFIG_USELIB=y
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_INJECTION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> CONFIG_GENERIC_IRQ_DEBUGFS=y
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> 
> #
> # Timers subsystem
> #
> CONFIG_HZ_PERIODIC=y
> # CONFIG_NO_HZ_IDLE is not set
> # CONFIG_NO_HZ is not set
> # CONFIG_HIGH_RES_TIMERS is not set
> # end of Timers subsystem
> 
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> CONFIG_PSI=y
> CONFIG_PSI_DEFAULT_DISABLED=y
> # end of CPU/Task time and stats accounting
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> CONFIG_PREEMPT_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_IKHEADERS=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # end of Scheduler features
> 
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CGROUPS=y
> CONFIG_PAGE_COUNTER=y
> CONFIG_MEMCG=y
> CONFIG_MEMCG_KMEM=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_CFS_BANDWIDTH=y
> CONFIG_RT_GROUP_SCHED=y
> # CONFIG_CGROUP_PIDS is not set
> # CONFIG_CGROUP_RDMA is not set
> # CONFIG_CGROUP_FREEZER is not set
> CONFIG_CGROUP_DEVICE=y
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_CGROUP_PERF is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_NAMESPACES=y
> # CONFIG_UTS_NS is not set
> CONFIG_TIME_NS=y
> CONFIG_IPC_NS=y
> # CONFIG_USER_NS is not set
> # CONFIG_PID_NS is not set
> CONFIG_NET_NS=y
> # CONFIG_CHECKPOINT_RESTORE is not set
> CONFIG_SCHED_AUTOGROUP=y
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> # CONFIG_RD_BZIP2 is not set
> # CONFIG_RD_LZMA is not set
> # CONFIG_RD_XZ is not set
> # CONFIG_RD_LZO is not set
> CONFIG_RD_LZ4=y
> CONFIG_BOOT_CONFIG=y
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_BPF=y
> CONFIG_EXPERT=y
> # CONFIG_UID16 is not set
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_PRINTK_NMI=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> # CONFIG_PCSPKR_PLATFORM is not set
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> # CONFIG_AIO is not set
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> # CONFIG_BPF_SYSCALL is not set
> # CONFIG_USERFAULTFD is not set
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> # CONFIG_RSEQ is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_USE_VMALLOC=y
> # CONFIG_PC104 is not set
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> CONFIG_DEBUG_PERF_USE_VMALLOC=y
> # end of Kernel Performance Events And Counters
> 
> CONFIG_VM_EVENT_COUNTERS=y
> # CONFIG_COMPAT_BRK is not set
> CONFIG_SLAB=y
> # CONFIG_SLUB is not set
> # CONFIG_SLOB is not set
> CONFIG_SLAB_MERGE_DEFAULT=y
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> # CONFIG_PROFILING is not set
> # end of General setup
> 
> CONFIG_X86_32=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf32-i386"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_X86_32_LAZY_GS=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=3
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> # CONFIG_ZONE_DMA is not set
> # CONFIG_SMP is not set
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_X86_MPPARSE=y
> # CONFIG_GOLDFISH is not set
> CONFIG_RETPOLINE=y
> # CONFIG_X86_CPU_RESCTRL is not set
> # CONFIG_X86_EXTENDED_PLATFORM is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=y
> CONFIG_IOSF_MBI_DEBUG=y
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_X86_32_IRIS=y
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> # CONFIG_XEN is not set
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> # CONFIG_PVH is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_M486SX is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> CONFIG_M686=y
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MELAN is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MGEODE_LX is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_MVIAC7 is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_X86_GENERIC=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=6
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> # CONFIG_PROCESSOR_SELECT is not set
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_CYRIX_32=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_TRANSMETA_32=y
> CONFIG_CPU_SUP_UMC_32=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_HPET_TIMER=y
> # CONFIG_DMI is not set
> CONFIG_NR_CPUS_RANGE_BEGIN=1
> CONFIG_NR_CPUS_RANGE_END=1
> CONFIG_NR_CPUS_DEFAULT=1
> CONFIG_NR_CPUS=1
> CONFIG_UP_LATE_INIT=y
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> # CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
> CONFIG_X86_MCE=y
> CONFIG_X86_MCELOG_LEGACY=y
> # CONFIG_X86_MCE_INTEL is not set
> # CONFIG_X86_MCE_AMD is not set
> CONFIG_X86_ANCIENT_MCE=y
> # CONFIG_X86_MCE_INJECT is not set
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=y
> # CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
> CONFIG_PERF_EVENTS_AMD_POWER=y
> # end of Performance monitoring
> 
> CONFIG_X86_LEGACY_VM86=y
> CONFIG_VM86=y
> CONFIG_X86_IOPL_IOPERM=y
> CONFIG_TOSHIBA=y
> # CONFIG_I8K is not set
> # CONFIG_X86_REBOOTFIXUPS is not set
> # CONFIG_MICROCODE is not set
> CONFIG_X86_MSR=y
> # CONFIG_X86_CPUID is not set
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_VMSPLIT_3G is not set
> CONFIG_VMSPLIT_2G=y
> # CONFIG_VMSPLIT_1G is not set
> CONFIG_PAGE_OFFSET=0x80000000
> CONFIG_X86_PAE=y
> # CONFIG_X86_CPA_STATISTICS is not set
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ILLEGAL_POINTER_VALUE=0
> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> CONFIG_X86_RESERVE_LOW=64
> CONFIG_MTRR=y
> # CONFIG_MTRR_SANITIZER is not set
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> # CONFIG_ARCH_RANDOM is not set
> # CONFIG_X86_SMAP is not set
> CONFIG_X86_UMIP=y
> # CONFIG_X86_INTEL_TSX_MODE_OFF is not set
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> CONFIG_X86_INTEL_TSX_MODE_AUTO=y
> # CONFIG_EFI is not set
> CONFIG_SECCOMP=y
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> CONFIG_HZ_1000=y
> CONFIG_HZ=1000
> # CONFIG_KEXEC is not set
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> # CONFIG_RANDOMIZE_BASE is not set
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_COMPAT_VDSO=y
> # CONFIG_CMDLINE_BOOL is not set
> # CONFIG_MODIFY_LDT_SYSCALL is not set
> # end of Processor type and features
> 
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> # CONFIG_SUSPEND_SKIP_SYNC is not set
> CONFIG_PM_SLEEP=y
> # CONFIG_PM_AUTOSLEEP is not set
> CONFIG_PM_WAKELOCKS=y
> CONFIG_PM_WAKELOCKS_LIMIT=100
> # CONFIG_PM_WAKELOCKS_GC is not set
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> # CONFIG_PM_ADVANCED_DEBUG is not set
> CONFIG_PM_TEST_SUSPEND=y
> CONFIG_PM_SLEEP_DEBUG=y
> CONFIG_PM_TRACE=y
> CONFIG_PM_TRACE_RTC=y
> CONFIG_PM_CLK=y
> CONFIG_PM_GENERIC_DOMAINS=y
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
> CONFIG_PM_GENERIC_DOMAINS_OF=y
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> CONFIG_ACPI_SLEEP=y
> # CONFIG_ACPI_PROCFS_POWER is not set
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_TAD is not set
> # CONFIG_ACPI_DOCK is not set
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_PROCESSOR=y
> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_CUSTOM_DSDT_FILE=""
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_DEBUG is not set
> # CONFIG_ACPI_PCI_SLOT is not set
> # CONFIG_ACPI_CONTAINER is not set
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> # CONFIG_ACPI_SBS is not set
> # CONFIG_ACPI_HED is not set
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> # CONFIG_ACPI_APEI is not set
> # CONFIG_DPTF_POWER is not set
> # CONFIG_PMIC_OPREGION is not set
> # CONFIG_ACPI_CONFIGFS is not set
> CONFIG_X86_PM_TIMER=y
> # CONFIG_SFI is not set
> # CONFIG_APM is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> # CONFIG_CPU_IDLE_GOV_MENU is not set
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> 
> # CONFIG_INTEL_IDLE is not set
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_GOBIOS=y
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> # CONFIG_PCI_GOANY is not set
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_CNB20LE_QUIRK=y
> # CONFIG_ISA_BUS is not set
> CONFIG_ISA_DMA_API=y
> CONFIG_ISA=y
> CONFIG_SCx200=y
> CONFIG_SCx200HR_TIMER=y
> CONFIG_ALIX=y
> # CONFIG_NET5501 is not set
> CONFIG_AMD_NB=y
> CONFIG_X86_SYSFB=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_COMPAT_32=y
> # end of Binary Emulations
> 
> CONFIG_HAVE_ATOMIC_IOMAP=y
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> # CONFIG_FIRMWARE_MEMMAP is not set
> # CONFIG_FW_CFG_SYSFS is not set
> CONFIG_GOOGLE_FIRMWARE=y
> CONFIG_GOOGLE_COREBOOT_TABLE=y
> CONFIG_GOOGLE_MEMCONSOLE=y
> CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT=y
> CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
> # CONFIG_GOOGLE_VPD is not set
> CONFIG_EFI_EARLYCON=y
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> CONFIG_HAVE_KVM=y
> # CONFIG_VIRTUALIZATION is not set
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_HAVE_OPROFILE=y
> CONFIG_OPROFILE_NMI_TIMER=y
> # CONFIG_KPROBES is not set
> # CONFIG_JUMP_LABEL is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_32BIT_OFF_T=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP_FILTER=y
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> # CONFIG_STACKPROTECTOR is not set
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=8
> CONFIG_HAVE_COPY_THREAD_TLS=y
> CONFIG_ISA_BUS_API=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> CONFIG_ARCH_USE_MEMREMAP_PROT=y
> CONFIG_LOCK_EVENT_COUNTS=y
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> # CONFIG_MODULE_FORCE_LOAD is not set
> # CONFIG_MODULE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> # CONFIG_MODULE_COMPRESS is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_UNUSED_SYMBOLS=y
> CONFIG_MODULES_TREE_LOOKUP=y
> # CONFIG_BLOCK is not set
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=y
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_MEMORY_BALLOON=y
> # CONFIG_BALLOON_COMPACTION is not set
> CONFIG_COMPACTION=y
> CONFIG_PAGE_REPORTING=y
> CONFIG_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> # CONFIG_MEMORY_FAILURE is not set
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> CONFIG_NEED_PER_CPU_KM=y
> CONFIG_CLEANCACHE=y
> CONFIG_CMA=y
> CONFIG_CMA_DEBUG=y
> # CONFIG_CMA_DEBUGFS is not set
> CONFIG_CMA_AREAS=7
> CONFIG_ZPOOL=y
> # CONFIG_ZBUD is not set
> # CONFIG_Z3FOLD is not set
> # CONFIG_ZSMALLOC is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> # CONFIG_IDLE_PAGE_TRACKING is not set
> CONFIG_HMM_MIRROR=y
> CONFIG_FRAME_VECTOR=y
> CONFIG_PERCPU_STATS=y
> CONFIG_GUP_BENCHMARK=y
> CONFIG_GUP_GET_PTE_LOW_HIGH=y
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_MAPPING_DIRTY_HELPERS=y
> # end of Memory Management options
> 
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> # CONFIG_PACKET is not set
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> # CONFIG_UNIX_DIAG is not set
> # CONFIG_TLS is not set
> # CONFIG_XFRM_USER is not set
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=y
> # CONFIG_IPV6_SIT_6RD is not set
> CONFIG_IPV6_NDISC_NODETYPE=y
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_NETLABEL is not set
> # CONFIG_MPTCP is not set
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> CONFIG_HAVE_NET_DSA=y
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=m
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_QRTR is not set
> # CONFIG_NET_NCSI is not set
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> # CONFIG_BPF_JIT is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # end of Network testing
> # end of Networking options
> 
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_WIRELESS=y
> # CONFIG_CFG80211 is not set
> 
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_WIMAX is not set
> # CONFIG_RFKILL is not set
> CONFIG_NET_9P=y
> CONFIG_NET_9P_VIRTIO=y
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> # CONFIG_FAILOVER is not set
> CONFIG_ETHTOOL_NETLINK=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> CONFIG_EISA=y
> CONFIG_EISA_VLB_PRIMING=y
> CONFIG_EISA_PCI_EISA=y
> CONFIG_EISA_VIRTUAL_ROOT=y
> # CONFIG_EISA_NAMES is not set
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_PCIEASPM=y
> # CONFIG_PCIEASPM_DEFAULT is not set
> # CONFIG_PCIEASPM_POWERSAVE is not set
> CONFIG_PCIEASPM_POWER_SUPERSAVE=y
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PTM=y
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> CONFIG_PCI_STUB=y
> # CONFIG_PCI_PF_STUB is not set
> CONFIG_PCI_ATS=y
> CONFIG_PCI_ECAM=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> CONFIG_PCI_IOV=y
> # CONFIG_PCI_PRI is not set
> # CONFIG_PCI_PASID is not set
> CONFIG_PCI_LABEL=y
> CONFIG_HOTPLUG_PCI=y
> CONFIG_HOTPLUG_PCI_COMPAQ=y
> # CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
> CONFIG_HOTPLUG_PCI_IBM=y
> # CONFIG_HOTPLUG_PCI_ACPI is not set
> CONFIG_HOTPLUG_PCI_CPCI=y
> CONFIG_HOTPLUG_PCI_CPCI_ZT5550=y
> CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
> # CONFIG_HOTPLUG_PCI_SHPC is not set
> 
> #
> # PCI controller drivers
> #
> CONFIG_PCI_FTPCI100=y
> CONFIG_PCI_HOST_COMMON=y
> CONFIG_PCI_HOST_GENERIC=y
> # CONFIG_PCIE_XILINX is not set
> 
> #
> # DesignWare PCI Core Support
> #
> CONFIG_PCIE_DW=y
> CONFIG_PCIE_DW_HOST=y
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> # CONFIG_PCIE_INTEL_GW is not set
> CONFIG_PCI_MESON=y
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> CONFIG_PCIE_CADENCE=y
> CONFIG_PCIE_CADENCE_HOST=y
> CONFIG_PCIE_CADENCE_PLAT=y
> CONFIG_PCIE_CADENCE_PLAT_HOST=y
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> CONFIG_PCI_SW_SWITCHTEC=y
> # end of PCI switch controller drivers
> 
> CONFIG_PCCARD=y
> # CONFIG_PCMCIA is not set
> # CONFIG_CARDBUS is not set
> 
> #
> # PC-card bridges
> #
> # CONFIG_YENTA is not set
> CONFIG_PCMCIA_PROBE=y
> CONFIG_RAPIDIO=y
> CONFIG_RAPIDIO_DISC_TIMEOUT=30
> CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
> # CONFIG_RAPIDIO_DMA_ENGINE is not set
> # CONFIG_RAPIDIO_DEBUG is not set
> CONFIG_RAPIDIO_ENUM_BASIC=y
> # CONFIG_RAPIDIO_CHMAN is not set
> CONFIG_RAPIDIO_MPORT_CDEV=y
> 
> #
> # RapidIO Switch drivers
> #
> # CONFIG_RAPIDIO_TSI57X is not set
> CONFIG_RAPIDIO_CPS_XX=y
> CONFIG_RAPIDIO_TSI568=y
> CONFIG_RAPIDIO_CPS_GEN2=y
> CONFIG_RAPIDIO_RXS_GEN3=y
> # end of RapidIO Switch drivers
> 
> #
> # Generic Driver Options
> #
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> # CONFIG_STANDALONE is not set
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> CONFIG_FW_LOADER_COMPRESS=y
> # CONFIG_FW_CACHE is not set
> # end of Firmware loader
> 
> CONFIG_ALLOW_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SLIMBUS=y
> CONFIG_REGMAP_SPI=y
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_DMA_SHARED_BUFFER=y
> CONFIG_DMA_FENCE_TRACE=y
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> CONFIG_MOXTET=y
> CONFIG_SIMPLE_PM_BUS=y
> CONFIG_MHI_BUS=y
> # end of Bus devices
> 
> # CONFIG_CONNECTOR is not set
> # CONFIG_GNSS is not set
> CONFIG_MTD=y
> # CONFIG_MTD_TESTS is not set
> 
> #
> # Partition parsers
> #
> # CONFIG_MTD_AR7_PARTS is not set
> CONFIG_MTD_CMDLINE_PARTS=y
> # CONFIG_MTD_OF_PARTS is not set
> CONFIG_MTD_REDBOOT_PARTS=y
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> # end of Partition parsers
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_OOPS=y
> # CONFIG_MTD_PARTITIONED_MASTER is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=y
> CONFIG_MTD_JEDECPROBE=y
> CONFIG_MTD_GEN_PROBE=y
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> CONFIG_MTD_CFI_INTELEXT=y
> CONFIG_MTD_CFI_AMDSTD=y
> CONFIG_MTD_CFI_STAA=y
> CONFIG_MTD_CFI_UTIL=y
> CONFIG_MTD_RAM=y
> CONFIG_MTD_ROM=y
> CONFIG_MTD_ABSENT=y
> # end of RAM/ROM/Flash chip drivers
> 
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> CONFIG_MTD_PHYSMAP=y
> CONFIG_MTD_PHYSMAP_COMPAT=y
> CONFIG_MTD_PHYSMAP_START=0x8000000
> CONFIG_MTD_PHYSMAP_LEN=0
> CONFIG_MTD_PHYSMAP_BANKWIDTH=2
> CONFIG_MTD_PHYSMAP_OF=y
> # CONFIG_MTD_PHYSMAP_VERSATILE is not set
> # CONFIG_MTD_PHYSMAP_GEMINI is not set
> CONFIG_MTD_SCx200_DOCFLASH=y
> CONFIG_MTD_AMD76XROM=y
> CONFIG_MTD_ICHXROM=y
> CONFIG_MTD_ESB2ROM=y
> CONFIG_MTD_CK804XROM=y
> # CONFIG_MTD_SCB2_FLASH is not set
> # CONFIG_MTD_NETtel is not set
> CONFIG_MTD_L440GX=y
> # CONFIG_MTD_INTEL_VR_NOR is not set
> CONFIG_MTD_PLATRAM=y
> # end of Mapping drivers for chip access
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> CONFIG_MTD_DATAFLASH=y
> CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
> # CONFIG_MTD_DATAFLASH_OTP is not set
> CONFIG_MTD_MCHP23K256=y
> CONFIG_MTD_SST25L=y
> CONFIG_MTD_SLRAM=y
> CONFIG_MTD_PHRAM=y
> # CONFIG_MTD_MTDRAM is not set
> 
> #
> # Disk-On-Chip Device Drivers
> #
> CONFIG_MTD_DOCG3=y
> CONFIG_BCH_CONST_M=14
> CONFIG_BCH_CONST_T=4
> # end of Self-contained MTD device drivers
> 
> CONFIG_MTD_NAND_CORE=y
> CONFIG_MTD_ONENAND=y
> # CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
> CONFIG_MTD_ONENAND_GENERIC=y
> CONFIG_MTD_ONENAND_OTP=y
> CONFIG_MTD_ONENAND_2X_PROGRAM=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING=y
> # CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
> CONFIG_MTD_RAW_NAND=y
> CONFIG_MTD_NAND_ECC_SW_BCH=y
> 
> #
> # Raw/parallel NAND flash controllers
> #
> CONFIG_MTD_NAND_DENALI=y
> CONFIG_MTD_NAND_DENALI_PCI=y
> CONFIG_MTD_NAND_DENALI_DT=y
> # CONFIG_MTD_NAND_CAFE is not set
> CONFIG_MTD_NAND_CS553X=y
> CONFIG_MTD_NAND_MXIC=y
> CONFIG_MTD_NAND_GPIO=y
> # CONFIG_MTD_NAND_PLATFORM is not set
> # CONFIG_MTD_NAND_CADENCE is not set
> CONFIG_MTD_NAND_ARASAN=y
> 
> #
> # Misc
> #
> CONFIG_MTD_SM_COMMON=y
> CONFIG_MTD_NAND_NANDSIM=y
> CONFIG_MTD_NAND_RICOH=y
> # CONFIG_MTD_NAND_DISKONCHIP is not set
> CONFIG_MTD_SPI_NAND=y
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=y
> CONFIG_MTD_QINFO_PROBE=y
> # end of LPDDR & LPDDR2 PCM memory drivers
> 
> CONFIG_MTD_SPI_NOR=y
> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
> CONFIG_SPI_INTEL_SPI=y
> CONFIG_SPI_INTEL_SPI_PCI=y
> CONFIG_SPI_INTEL_SPI_PLATFORM=y
> # CONFIG_MTD_UBI is not set
> # CONFIG_MTD_HYPERBUS is not set
> CONFIG_DTC=y
> CONFIG_OF=y
> # CONFIG_OF_UNITTEST is not set
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_KOBJ=y
> CONFIG_OF_DYNAMIC=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_NET=y
> CONFIG_OF_RESOLVE=y
> CONFIG_OF_OVERLAY=y
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> CONFIG_PNP=y
> CONFIG_PNP_DEBUG_MESSAGES=y
> 
> #
> # Protocols
> #
> CONFIG_ISAPNP=y
> CONFIG_PNPBIOS=y
> # CONFIG_PNPBIOS_PROC_FS is not set
> CONFIG_PNPACPI=y
> 
> #
> # NVME Support
> #
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=y
> CONFIG_AD525X_DPOT=y
> CONFIG_AD525X_DPOT_I2C=y
> CONFIG_AD525X_DPOT_SPI=y
> CONFIG_DUMMY_IRQ=y
> # CONFIG_IBM_ASM is not set
> CONFIG_PHANTOM=y
> CONFIG_TIFM_CORE=y
> # CONFIG_TIFM_7XX1 is not set
> CONFIG_ICS932S401=y
> # CONFIG_ENCLOSURE_SERVICES is not set
> CONFIG_CS5535_MFGPT=y
> CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
> # CONFIG_CS5535_CLOCK_EVENT_SRC is not set
> # CONFIG_HP_ILO is not set
> CONFIG_APDS9802ALS=y
> CONFIG_ISL29003=y
> # CONFIG_ISL29020 is not set
> CONFIG_SENSORS_TSL2550=y
> # CONFIG_SENSORS_BH1770 is not set
> # CONFIG_SENSORS_APDS990X is not set
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> CONFIG_VMWARE_BALLOON=y
> CONFIG_PCH_PHUB=y
> CONFIG_LATTICE_ECP3_CONFIG=y
> CONFIG_SRAM=y
> CONFIG_PCI_ENDPOINT_TEST=y
> # CONFIG_XILINX_SDFEC is not set
> CONFIG_MISC_RTSX=y
> # CONFIG_PVPANIC is not set
> CONFIG_C2PORT=y
> CONFIG_C2PORT_DURAMAR_2150=y
> 
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=y
> CONFIG_EEPROM_AT25=y
> CONFIG_EEPROM_LEGACY=y
> CONFIG_EEPROM_MAX6875=y
> CONFIG_EEPROM_93CX6=y
> CONFIG_EEPROM_93XX46=y
> CONFIG_EEPROM_IDT_89HPESX=y
> CONFIG_EEPROM_EE1004=y
> # end of EEPROM support
> 
> CONFIG_CB710_CORE=y
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
> 
> CONFIG_SENSORS_LIS3_I2C=y
> CONFIG_ALTERA_STAPL=y
> CONFIG_INTEL_MEI=y
> CONFIG_INTEL_MEI_ME=y
> CONFIG_INTEL_MEI_TXE=y
> # CONFIG_INTEL_MEI_HDCP is not set
> CONFIG_VMWARE_VMCI=y
> 
> #
> # Intel MIC & related support
> #
> # CONFIG_VOP_BUS is not set
> # end of Intel MIC & related support
> 
> CONFIG_ECHO=y
> # CONFIG_MISC_ALCOR_PCI is not set
> CONFIG_MISC_RTSX_PCI=y
> CONFIG_MISC_RTSX_USB=y
> CONFIG_HABANA_AI=y
> CONFIG_UACCE=y
> # end of Misc devices
> 
> CONFIG_HAVE_IDE=y
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> # end of SCSI device support
> 
> CONFIG_FUSION=y
> CONFIG_FUSION_MAX_SGE=128
> # CONFIG_FUSION_LOGGING is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
> 
> CONFIG_MACINTOSH_DRIVERS=y
> # CONFIG_MAC_EMUMOUSEBTN is not set
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NTB_NETDEV is not set
> # CONFIG_RIONET is not set
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> # CONFIG_VIRTIO_NET is not set
> # CONFIG_NLMON is not set
> # CONFIG_ARCNET is not set
> 
> #
> # Distributed Switch Architecture drivers
> #
> # end of Distributed Switch Architecture drivers
> 
> CONFIG_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_EL3 is not set
> # CONFIG_3C515 is not set
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_ENA_ETHERNET is not set
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_LANCE is not set
> # CONFIG_PCNET32 is not set
> # CONFIG_NI65 is not set
> # CONFIG_AMD_XGBE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> CONFIG_NET_VENDOR_AURORA=y
> # CONFIG_AURORA_NB8800 is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CIRRUS=y
> # CONFIG_CS89x0 is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> # CONFIG_GEMINI_ETHERNET is not set
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> # CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_GOOGLE=y
> # CONFIG_GVE is not set
> CONFIG_NET_VENDOR_HUAWEI=y
> # CONFIG_HINIC is not set
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> # CONFIG_E1000E is not set
> # CONFIG_IGB is not set
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> # CONFIG_IXGBE is not set
> # CONFIG_IXGBEVF is not set
> # CONFIG_I40E is not set
> # CONFIG_I40EVF is not set
> # CONFIG_ICE is not set
> # CONFIG_FM10K is not set
> # CONFIG_IGC is not set
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> # CONFIG_VXGE is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> # CONFIG_NFP is not set
> CONFIG_NET_VENDOR_NI=y
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_NE2000 is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_ULTRA is not set
> # CONFIG_WD80x3 is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_PCH_GBE is not set
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCA7000_SPI is not set
> # CONFIG_QCA7000_UART is not set
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_SMC9194 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> # CONFIG_MDIO_DEVICE is not set
> # CONFIG_PHYLIB is not set
> # CONFIG_MICREL_KS8995MA is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> CONFIG_USB_NET_DRIVERS=y
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_RTL8152 is not set
> # CONFIG_USB_LAN78XX is not set
> # CONFIG_USB_USBNET is not set
> # CONFIG_USB_IPHETH is not set
> CONFIG_WLAN=y
> # CONFIG_WIRELESS_WDS is not set
> CONFIG_WLAN_VENDOR_ADMTEK=y
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K_PCI is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> CONFIG_WLAN_VENDOR_BROADCOM=y
> CONFIG_WLAN_VENDOR_CISCO=y
> CONFIG_WLAN_VENDOR_INTEL=y
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> # CONFIG_PRISM54 is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_WLAN_VENDOR_REALTEK=y
> CONFIG_WLAN_VENDOR_RSI=y
> CONFIG_WLAN_VENDOR_ST=y
> CONFIG_WLAN_VENDOR_TI=y
> CONFIG_WLAN_VENDOR_ZYDAS=y
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> 
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
> #
> # CONFIG_WAN is not set
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_USB4_NET is not set
> # CONFIG_NETDEVSIM is not set
> # CONFIG_NET_FAILOVER is not set
> # CONFIG_ISDN is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=y
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_POLLDEV=y
> CONFIG_INPUT_SPARSEKMAP=y
> CONFIG_INPUT_MATRIXKMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=y
> # CONFIG_INPUT_EVDEV is not set
> CONFIG_INPUT_EVBUG=y
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ADP5588=y
> CONFIG_KEYBOARD_ADP5589=y
> CONFIG_KEYBOARD_ATKBD=y
> CONFIG_KEYBOARD_QT1050=y
> CONFIG_KEYBOARD_QT1070=y
> CONFIG_KEYBOARD_QT2160=y
> CONFIG_KEYBOARD_DLINK_DIR685=y
> # CONFIG_KEYBOARD_LKKBD is not set
> CONFIG_KEYBOARD_GPIO=y
> CONFIG_KEYBOARD_GPIO_POLLED=y
> CONFIG_KEYBOARD_TCA6416=y
> CONFIG_KEYBOARD_TCA8418=y
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> CONFIG_KEYBOARD_MAX7359=y
> CONFIG_KEYBOARD_MCS=y
> CONFIG_KEYBOARD_MPR121=y
> CONFIG_KEYBOARD_NEWTON=y
> CONFIG_KEYBOARD_OPENCORES=y
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> CONFIG_KEYBOARD_SUNKBD=y
> CONFIG_KEYBOARD_STMPE=y
> CONFIG_KEYBOARD_OMAP4=y
> CONFIG_KEYBOARD_TM2_TOUCHKEY=y
> CONFIG_KEYBOARD_TWL4030=y
> CONFIG_KEYBOARD_XTKBD=y
> CONFIG_KEYBOARD_CROS_EC=y
> # CONFIG_KEYBOARD_CAP11XX is not set
> CONFIG_KEYBOARD_BCM=y
> # CONFIG_INPUT_MOUSE is not set
> CONFIG_INPUT_JOYSTICK=y
> # CONFIG_JOYSTICK_ANALOG is not set
> CONFIG_JOYSTICK_A3D=y
> # CONFIG_JOYSTICK_ADI is not set
> CONFIG_JOYSTICK_COBRA=y
> CONFIG_JOYSTICK_GF2K=y
> # CONFIG_JOYSTICK_GRIP is not set
> # CONFIG_JOYSTICK_GRIP_MP is not set
> CONFIG_JOYSTICK_GUILLEMOT=y
> CONFIG_JOYSTICK_INTERACT=y
> CONFIG_JOYSTICK_SIDEWINDER=y
> CONFIG_JOYSTICK_TMDC=y
> # CONFIG_JOYSTICK_IFORCE is not set
> # CONFIG_JOYSTICK_WARRIOR is not set
> # CONFIG_JOYSTICK_MAGELLAN is not set
> CONFIG_JOYSTICK_SPACEORB=y
> CONFIG_JOYSTICK_SPACEBALL=y
> CONFIG_JOYSTICK_STINGER=y
> CONFIG_JOYSTICK_TWIDJOY=y
> CONFIG_JOYSTICK_ZHENHUA=y
> CONFIG_JOYSTICK_AS5011=y
> CONFIG_JOYSTICK_JOYDUMP=y
> # CONFIG_JOYSTICK_XPAD is not set
> CONFIG_JOYSTICK_PSXPAD_SPI=y
> # CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
> # CONFIG_JOYSTICK_PXRC is not set
> # CONFIG_JOYSTICK_FSIA6B is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_AD714X=y
> CONFIG_INPUT_AD714X_I2C=y
> CONFIG_INPUT_AD714X_SPI=y
> # CONFIG_INPUT_ATMEL_CAPTOUCH is not set
> CONFIG_INPUT_BMA150=y
> # CONFIG_INPUT_E3X0_BUTTON is not set
> CONFIG_INPUT_MAX77693_HAPTIC=y
> CONFIG_INPUT_MAX8997_HAPTIC=y
> # CONFIG_INPUT_MC13783_PWRBUTTON is not set
> CONFIG_INPUT_MMA8450=y
> CONFIG_INPUT_APANEL=y
> CONFIG_INPUT_GPIO_BEEPER=y
> CONFIG_INPUT_GPIO_DECODER=y
> CONFIG_INPUT_GPIO_VIBRA=y
> CONFIG_INPUT_CPCAP_PWRBUTTON=y
> CONFIG_INPUT_WISTRON_BTNS=y
> # CONFIG_INPUT_ATLAS_BTNS is not set
> CONFIG_INPUT_ATI_REMOTE2=y
> CONFIG_INPUT_KEYSPAN_REMOTE=y
> CONFIG_INPUT_KXTJ9=y
> CONFIG_INPUT_POWERMATE=y
> CONFIG_INPUT_YEALINK=y
> CONFIG_INPUT_CM109=y
> CONFIG_INPUT_REGULATOR_HAPTIC=y
> # CONFIG_INPUT_RETU_PWRBUTTON is not set
> CONFIG_INPUT_TPS65218_PWRBUTTON=y
> # CONFIG_INPUT_TWL4030_PWRBUTTON is not set
> CONFIG_INPUT_TWL4030_VIBRA=y
> # CONFIG_INPUT_TWL6040_VIBRA is not set
> CONFIG_INPUT_UINPUT=y
> # CONFIG_INPUT_PALMAS_PWRBUTTON is not set
> # CONFIG_INPUT_PCF50633_PMU is not set
> CONFIG_INPUT_PCF8574=y
> # CONFIG_INPUT_PWM_BEEPER is not set
> # CONFIG_INPUT_PWM_VIBRA is not set
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
> CONFIG_INPUT_DA9052_ONKEY=y
> CONFIG_INPUT_DA9063_ONKEY=y
> CONFIG_INPUT_PCAP=y
> # CONFIG_INPUT_ADXL34X is not set
> CONFIG_INPUT_IMS_PCU=y
> CONFIG_INPUT_IQS269A=y
> CONFIG_INPUT_CMA3000=y
> # CONFIG_INPUT_CMA3000_I2C is not set
> CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
> # CONFIG_INPUT_SOC_BUTTON_ARRAY is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> CONFIG_INPUT_DRV2667_HAPTICS=y
> CONFIG_INPUT_STPMIC1_ONKEY=y
> CONFIG_RMI4_CORE=y
> CONFIG_RMI4_I2C=y
> # CONFIG_RMI4_SPI is not set
> # CONFIG_RMI4_SMB is not set
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> # CONFIG_RMI4_F34 is not set
> # CONFIG_RMI4_F54 is not set
> # CONFIG_RMI4_F55 is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> CONFIG_SERIO_CT82C710=y
> CONFIG_SERIO_PCIPS2=y
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=y
> # CONFIG_SERIO_ALTERA_PS2 is not set
> CONFIG_SERIO_PS2MULT=y
> CONFIG_SERIO_ARC_PS2=y
> CONFIG_SERIO_APBPS2=y
> CONFIG_SERIO_GPIO_PS2=y
> CONFIG_USERIO=y
> CONFIG_GAMEPORT=y
> CONFIG_GAMEPORT_NS558=y
> # CONFIG_GAMEPORT_L4 is not set
> CONFIG_GAMEPORT_EMU10K1=y
> CONFIG_GAMEPORT_FM801=y
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> # CONFIG_VT is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_FOURPORT=y
> CONFIG_SERIAL_8250_ACCENT=y
> CONFIG_SERIAL_8250_ASPEED_VUART=y
> # CONFIG_SERIAL_8250_BOCA is not set
> CONFIG_SERIAL_8250_EXAR_ST16C554=y
> CONFIG_SERIAL_8250_HUB6=y
> # CONFIG_SERIAL_8250_SHARE_IRQ is not set
> CONFIG_SERIAL_8250_DETECT_IRQ=y
> # CONFIG_SERIAL_8250_RSA is not set
> # CONFIG_SERIAL_8250_DW is not set
> CONFIG_SERIAL_8250_RT288X=y
> # CONFIG_SERIAL_8250_LPSS is not set
> CONFIG_SERIAL_8250_MID=y
> CONFIG_SERIAL_OF_PLATFORM=y
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> CONFIG_SERIAL_MAX310X=y
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> CONFIG_SERIAL_SIFIVE=y
> # CONFIG_SERIAL_SIFIVE_CONSOLE is not set
> CONFIG_SERIAL_LANTIQ=y
> CONFIG_SERIAL_LANTIQ_CONSOLE=y
> CONFIG_SERIAL_SCCNXP=y
> # CONFIG_SERIAL_SCCNXP_CONSOLE is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_TIMBERDALE is not set
> CONFIG_SERIAL_ALTERA_JTAGUART=y
> CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
> CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_IFX6X60 is not set
> CONFIG_SERIAL_PCH_UART=y
> # CONFIG_SERIAL_PCH_UART_CONSOLE is not set
> CONFIG_SERIAL_XILINX_PS_UART=y
> CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
> CONFIG_SERIAL_ARC=y
> CONFIG_SERIAL_ARC_CONSOLE=y
> CONFIG_SERIAL_ARC_NR_PORTS=1
> CONFIG_SERIAL_RP2=y
> CONFIG_SERIAL_RP2_NR_UARTS=32
> CONFIG_SERIAL_FSL_LPUART=y
> # CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
> # CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
> CONFIG_SERIAL_SPRD=y
> # CONFIG_SERIAL_SPRD_CONSOLE is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> CONFIG_SERIAL_NONSTANDARD=y
> # CONFIG_ROCKETPORT is not set
> # CONFIG_CYCLADES is not set
> CONFIG_MOXA_INTELLIO=y
> # CONFIG_MOXA_SMARTIO is not set
> CONFIG_SYNCLINK=y
> CONFIG_SYNCLINKMP=y
> CONFIG_SYNCLINK_GT=y
> # CONFIG_ISI is not set
> # CONFIG_N_HDLC is not set
> # CONFIG_N_GSM is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_NULL_TTY is not set
> CONFIG_TRACE_ROUTER=y
> CONFIG_TRACE_SINK=y
> CONFIG_HVC_DRIVER=y
> CONFIG_SERIAL_DEV_BUS=y
> # CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
> CONFIG_TTY_PRINTK=y
> CONFIG_TTY_PRINTK_LEVEL=6
> CONFIG_VIRTIO_CONSOLE=y
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_IPMB_DEVICE_INTERFACE=y
> CONFIG_HW_RANDOM=y
> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> # CONFIG_HW_RANDOM_INTEL is not set
> CONFIG_HW_RANDOM_AMD=y
> # CONFIG_HW_RANDOM_GEODE is not set
> CONFIG_HW_RANDOM_VIA=y
> # CONFIG_HW_RANDOM_VIRTIO is not set
> CONFIG_HW_RANDOM_CCTRNG=y
> # CONFIG_DTLK is not set
> # CONFIG_APPLICOM is not set
> CONFIG_SONYPI=y
> CONFIG_MWAVE=y
> CONFIG_SCx200_GPIO=y
> # CONFIG_PC8736x_GPIO is not set
> CONFIG_NSC_GPIO=y
> # CONFIG_DEVMEM is not set
> # CONFIG_DEVKMEM is not set
> # CONFIG_NVRAM is not set
> CONFIG_DEVPORT=y
> # CONFIG_HPET is not set
> CONFIG_HANGCHECK_TIMER=y
> CONFIG_TCG_TPM=y
> CONFIG_HW_RANDOM_TPM=y
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> # CONFIG_TCG_TIS_SPI is not set
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> CONFIG_TCG_TIS_I2C_INFINEON=y
> CONFIG_TCG_TIS_I2C_NUVOTON=y
> # CONFIG_TCG_NSC is not set
> # CONFIG_TCG_ATMEL is not set
> CONFIG_TCG_INFINEON=y
> CONFIG_TCG_CRB=y
> CONFIG_TCG_VTPM_PROXY=y
> CONFIG_TCG_TIS_ST33ZP24=y
> CONFIG_TCG_TIS_ST33ZP24_I2C=y
> CONFIG_TCG_TIS_ST33ZP24_SPI=y
> CONFIG_TELCLOCK=y
> # CONFIG_XILLYBUS is not set
> # end of Character devices
> 
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_MUX=y
> 
> #
> # Multiplexer I2C Chip support
> #
> CONFIG_I2C_ARB_GPIO_CHALLENGE=y
> # CONFIG_I2C_MUX_GPIO is not set
> CONFIG_I2C_MUX_GPMUX=y
> CONFIG_I2C_MUX_LTC4306=y
> # CONFIG_I2C_MUX_PCA9541 is not set
> # CONFIG_I2C_MUX_PCA954x is not set
> CONFIG_I2C_MUX_PINCTRL=y
> CONFIG_I2C_MUX_REG=y
> CONFIG_I2C_DEMUX_PINCTRL=y
> # CONFIG_I2C_MUX_MLXCPLD is not set
> # end of Multiplexer I2C Chip support
> 
> # CONFIG_I2C_HELPER_AUTO is not set
> # CONFIG_I2C_SMBUS is not set
> 
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCF=y
> CONFIG_I2C_ALGOPCA=y
> # end of I2C Algorithms
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_ALI1535=y
> CONFIG_I2C_ALI1563=y
> CONFIG_I2C_ALI15X3=y
> CONFIG_I2C_AMD756=y
> # CONFIG_I2C_AMD756_S4882 is not set
> CONFIG_I2C_AMD8111=y
> # CONFIG_I2C_AMD_MP2 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_ISCH is not set
> CONFIG_I2C_ISMT=y
> CONFIG_I2C_PIIX4=y
> CONFIG_I2C_NFORCE2=y
> # CONFIG_I2C_NFORCE2_S4985 is not set
> CONFIG_I2C_NVIDIA_GPU=y
> CONFIG_I2C_SIS5595=y
> CONFIG_I2C_SIS630=y
> # CONFIG_I2C_SIS96X is not set
> CONFIG_I2C_VIA=y
> # CONFIG_I2C_VIAPRO is not set
> 
> #
> # ACPI drivers
> #
> # CONFIG_I2C_SCMI is not set
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=y
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> # CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
> CONFIG_I2C_DESIGNWARE_PCI=y
> # CONFIG_I2C_EG20T is not set
> CONFIG_I2C_EMEV2=y
> # CONFIG_I2C_GPIO is not set
> CONFIG_I2C_OCORES=y
> CONFIG_I2C_PCA_PLATFORM=y
> CONFIG_I2C_PXA=y
> CONFIG_I2C_PXA_PCI=y
> # CONFIG_I2C_RK3X is not set
> CONFIG_I2C_SIMTEC=y
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_DIOLAN_U2C=y
> # CONFIG_I2C_DLN2 is not set
> CONFIG_I2C_ROBOTFUZZ_OSIF=y
> CONFIG_I2C_TAOS_EVM=y
> # CONFIG_I2C_TINY_USB is not set
> # CONFIG_I2C_VIPERBOARD is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_ELEKTOR=y
> # CONFIG_I2C_PCA_ISA is not set
> CONFIG_I2C_CROS_EC_TUNNEL=y
> # CONFIG_SCx200_ACB is not set
> CONFIG_I2C_FSI=y
> # end of I2C Hardware Bus support
> 
> # CONFIG_I2C_STUB is not set
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=y
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> # CONFIG_I3C is not set
> CONFIG_SPI=y
> CONFIG_SPI_DEBUG=y
> CONFIG_SPI_MASTER=y
> CONFIG_SPI_MEM=y
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> CONFIG_SPI_AXI_SPI_ENGINE=y
> CONFIG_SPI_BITBANG=y
> # CONFIG_SPI_CADENCE is not set
> CONFIG_SPI_DESIGNWARE=y
> # CONFIG_SPI_DW_DMA is not set
> CONFIG_SPI_DW_PCI=y
> CONFIG_SPI_DW_MMIO=y
> CONFIG_SPI_DLN2=y
> # CONFIG_SPI_FSI is not set
> CONFIG_SPI_NXP_FLEXSPI=y
> CONFIG_SPI_GPIO=y
> CONFIG_SPI_FSL_LIB=y
> CONFIG_SPI_FSL_SPI=y
> CONFIG_SPI_OC_TINY=y
> # CONFIG_SPI_PXA2XX is not set
> CONFIG_SPI_ROCKCHIP=y
> # CONFIG_SPI_SC18IS602 is not set
> CONFIG_SPI_SIFIVE=y
> CONFIG_SPI_MXIC=y
> CONFIG_SPI_TOPCLIFF_PCH=y
> CONFIG_SPI_XCOMM=y
> CONFIG_SPI_XILINX=y
> CONFIG_SPI_ZYNQMP_GQSPI=y
> CONFIG_SPI_AMD=y
> 
> #
> # SPI Multiplexer support
> #
> CONFIG_SPI_MUX=y
> 
> #
> # SPI Protocol Masters
> #
> CONFIG_SPI_SPIDEV=y
> # CONFIG_SPI_LOOPBACK_TEST is not set
> # CONFIG_SPI_TLE62X0 is not set
> CONFIG_SPI_SLAVE=y
> CONFIG_SPI_SLAVE_TIME=y
> CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
> CONFIG_SPMI=y
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> CONFIG_NTP_PPS=y
> 
> #
> # PPS clients support
> #
> CONFIG_PPS_CLIENT_KTIMER=y
> # CONFIG_PPS_CLIENT_LDISC is not set
> CONFIG_PPS_CLIENT_GPIO=y
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> # CONFIG_PTP_1588_CLOCK is not set
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> # CONFIG_PTP_1588_CLOCK_PCH is not set
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_GENERIC_PINCTRL_GROUPS=y
> CONFIG_PINMUX=y
> CONFIG_GENERIC_PINMUX_FUNCTIONS=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> CONFIG_DEBUG_PINCTRL=y
> # CONFIG_PINCTRL_AMD is not set
> # CONFIG_PINCTRL_DA9062 is not set
> # CONFIG_PINCTRL_MCP23S08 is not set
> CONFIG_PINCTRL_SINGLE=y
> # CONFIG_PINCTRL_SX150X is not set
> CONFIG_PINCTRL_STMFX=y
> CONFIG_PINCTRL_PALMAS=y
> # CONFIG_PINCTRL_OCELOT is not set
> # CONFIG_PINCTRL_BAYTRAIL is not set
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_LYNXPOINT is not set
> # CONFIG_PINCTRL_BROXTON is not set
> # CONFIG_PINCTRL_CANNONLAKE is not set
> # CONFIG_PINCTRL_CEDARFORK is not set
> # CONFIG_PINCTRL_DENVERTON is not set
> # CONFIG_PINCTRL_GEMINILAKE is not set
> # CONFIG_PINCTRL_ICELAKE is not set
> # CONFIG_PINCTRL_JASPERLAKE is not set
> # CONFIG_PINCTRL_LEWISBURG is not set
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> # CONFIG_PINCTRL_TIGERLAKE is not set
> CONFIG_PINCTRL_EQUILIBRIUM=y
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_OF_GPIO=y
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_GENERIC=y
> CONFIG_GPIO_MAX730X=y
> 
> #
> # Memory mapped GPIO drivers
> #
> CONFIG_GPIO_74XX_MMIO=y
> CONFIG_GPIO_ALTERA=y
> # CONFIG_GPIO_AMDPT is not set
> CONFIG_GPIO_CADENCE=y
> CONFIG_GPIO_DWAPB=y
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_FTGPIO010 is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> CONFIG_GPIO_GRGPIO=y
> CONFIG_GPIO_HLWD=y
> CONFIG_GPIO_ICH=y
> CONFIG_GPIO_LOGICVC=y
> CONFIG_GPIO_MB86S7X=y
> CONFIG_GPIO_SAMA5D2_PIOBU=y
> # CONFIG_GPIO_SIFIVE is not set
> # CONFIG_GPIO_SIOX is not set
> CONFIG_GPIO_SYSCON=y
> CONFIG_GPIO_VX855=y
> # CONFIG_GPIO_WCD934X is not set
> CONFIG_GPIO_XILINX=y
> CONFIG_GPIO_AMD_FCH=y
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> CONFIG_GPIO_F7188X=y
> CONFIG_GPIO_IT87=y
> # CONFIG_GPIO_SCH is not set
> # CONFIG_GPIO_SCH311X is not set
> CONFIG_GPIO_WINBOND=y
> CONFIG_GPIO_WS16C48=y
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> CONFIG_GPIO_ADP5588=y
> CONFIG_GPIO_ADP5588_IRQ=y
> # CONFIG_GPIO_ADNP is not set
> # CONFIG_GPIO_GW_PLD is not set
> # CONFIG_GPIO_MAX7300 is not set
> CONFIG_GPIO_MAX732X=y
> CONFIG_GPIO_MAX732X_IRQ=y
> CONFIG_GPIO_PCA953X=y
> # CONFIG_GPIO_PCA953X_IRQ is not set
> CONFIG_GPIO_PCF857X=y
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_BD70528=y
> CONFIG_GPIO_BD71828=y
> CONFIG_GPIO_CS5535=y
> CONFIG_GPIO_DA9052=y
> # CONFIG_GPIO_DLN2 is not set
> CONFIG_GPIO_JANZ_TTL=y
> CONFIG_GPIO_LP3943=y
> CONFIG_GPIO_LP873X=y
> CONFIG_GPIO_PALMAS=y
> CONFIG_GPIO_RC5T583=y
> CONFIG_GPIO_STMPE=y
> CONFIG_GPIO_TIMBERDALE=y
> # CONFIG_GPIO_TPS65086 is not set
> CONFIG_GPIO_TPS6586X=y
> # CONFIG_GPIO_TPS65910 is not set
> # CONFIG_GPIO_TPS65912 is not set
> # CONFIG_GPIO_TQMX86 is not set
> CONFIG_GPIO_TWL4030=y
> # CONFIG_GPIO_TWL6040 is not set
> CONFIG_GPIO_WM8350=y
> CONFIG_GPIO_WM8994=y
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> CONFIG_GPIO_AMD8111=y
> CONFIG_GPIO_BT8XX=y
> CONFIG_GPIO_ML_IOH=y
> CONFIG_GPIO_PCH=y
> CONFIG_GPIO_PCI_IDIO_16=y
> CONFIG_GPIO_PCIE_IDIO_24=y
> CONFIG_GPIO_RDC321X=y
> # CONFIG_GPIO_SODAVILLE is not set
> # end of PCI GPIO expanders
> 
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_74X164 is not set
> CONFIG_GPIO_MAX3191X=y
> CONFIG_GPIO_MAX7301=y
> # CONFIG_GPIO_MC33880 is not set
> CONFIG_GPIO_PISOSR=y
> CONFIG_GPIO_XRA1403=y
> CONFIG_GPIO_MOXTET=y
> # end of SPI GPIO expanders
> 
> #
> # USB GPIO expanders
> #
> # CONFIG_GPIO_VIPERBOARD is not set
> # end of USB GPIO expanders
> 
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_MOCKUP is not set
> CONFIG_W1=y
> 
> #
> # 1-wire Bus Masters
> #
> # CONFIG_W1_MASTER_MATROX is not set
> # CONFIG_W1_MASTER_DS2490 is not set
> CONFIG_W1_MASTER_DS2482=y
> CONFIG_W1_MASTER_DS1WM=y
> # CONFIG_W1_MASTER_GPIO is not set
> CONFIG_W1_MASTER_SGI=y
> # end of 1-wire Bus Masters
> 
> #
> # 1-wire Slaves
> #
> CONFIG_W1_SLAVE_THERM=y
> # CONFIG_W1_SLAVE_SMEM is not set
> # CONFIG_W1_SLAVE_DS2405 is not set
> CONFIG_W1_SLAVE_DS2408=y
> # CONFIG_W1_SLAVE_DS2408_READBACK is not set
> CONFIG_W1_SLAVE_DS2413=y
> CONFIG_W1_SLAVE_DS2406=y
> # CONFIG_W1_SLAVE_DS2423 is not set
> CONFIG_W1_SLAVE_DS2805=y
> CONFIG_W1_SLAVE_DS2430=y
> # CONFIG_W1_SLAVE_DS2431 is not set
> # CONFIG_W1_SLAVE_DS2433 is not set
> CONFIG_W1_SLAVE_DS2438=y
> # CONFIG_W1_SLAVE_DS250X is not set
> CONFIG_W1_SLAVE_DS2780=y
> CONFIG_W1_SLAVE_DS2781=y
> CONFIG_W1_SLAVE_DS28E04=y
> CONFIG_W1_SLAVE_DS28E17=y
> # end of 1-wire Slaves
> 
> CONFIG_POWER_AVS=y
> # CONFIG_QCOM_CPR is not set
> CONFIG_POWER_RESET=y
> # CONFIG_POWER_RESET_GPIO is not set
> # CONFIG_POWER_RESET_GPIO_RESTART is not set
> # CONFIG_POWER_RESET_LTC2952 is not set
> # CONFIG_POWER_RESET_RESTART is not set
> CONFIG_POWER_RESET_SYSCON=y
> CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> CONFIG_REBOOT_MODE=y
> CONFIG_SYSCON_REBOOT_MODE=y
> # CONFIG_NVMEM_REBOOT_MODE is not set
> CONFIG_POWER_SUPPLY=y
> CONFIG_POWER_SUPPLY_DEBUG=y
> # CONFIG_POWER_SUPPLY_HWMON is not set
> CONFIG_PDA_POWER=y
> CONFIG_WM8350_POWER=y
> # CONFIG_TEST_POWER is not set
> CONFIG_CHARGER_ADP5061=y
> CONFIG_BATTERY_CW2015=y
> CONFIG_BATTERY_DS2760=y
> CONFIG_BATTERY_DS2780=y
> CONFIG_BATTERY_DS2781=y
> CONFIG_BATTERY_DS2782=y
> # CONFIG_BATTERY_SBS is not set
> CONFIG_CHARGER_SBS=y
> # CONFIG_MANAGER_SBS is not set
> CONFIG_BATTERY_BQ27XXX=y
> CONFIG_BATTERY_BQ27XXX_I2C=y
> # CONFIG_BATTERY_BQ27XXX_HDQ is not set
> CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
> CONFIG_BATTERY_DA9052=y
> # CONFIG_BATTERY_DA9150 is not set
> # CONFIG_BATTERY_MAX17040 is not set
> CONFIG_BATTERY_MAX17042=y
> # CONFIG_BATTERY_MAX1721X is not set
> CONFIG_CHARGER_PCF50633=y
> CONFIG_CHARGER_ISP1704=y
> CONFIG_CHARGER_MAX8903=y
> CONFIG_CHARGER_LP8727=y
> CONFIG_CHARGER_GPIO=y
> CONFIG_CHARGER_MANAGER=y
> CONFIG_CHARGER_LT3651=y
> CONFIG_CHARGER_MAX14577=y
> CONFIG_CHARGER_DETECTOR_MAX14656=y
> CONFIG_CHARGER_MAX77693=y
> # CONFIG_CHARGER_MAX8997 is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24190 is not set
> CONFIG_CHARGER_BQ24257=y
> CONFIG_CHARGER_BQ24735=y
> CONFIG_CHARGER_BQ25890=y
> CONFIG_CHARGER_SMB347=y
> # CONFIG_CHARGER_TPS65217 is not set
> CONFIG_BATTERY_GAUGE_LTC2941=y
> CONFIG_BATTERY_RT5033=y
> CONFIG_CHARGER_RT9455=y
> # CONFIG_CHARGER_CROS_USBPD is not set
> CONFIG_CHARGER_UCS1002=y
> # CONFIG_CHARGER_BD70528 is not set
> CONFIG_CHARGER_BD99954=y
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_AD7314=y
> # CONFIG_SENSORS_AD7414 is not set
> CONFIG_SENSORS_AD7418=y
> CONFIG_SENSORS_ADM1021=y
> # CONFIG_SENSORS_ADM1025 is not set
> CONFIG_SENSORS_ADM1026=y
> # CONFIG_SENSORS_ADM1029 is not set
> CONFIG_SENSORS_ADM1031=y
> CONFIG_SENSORS_ADM1177=y
> # CONFIG_SENSORS_ADM9240 is not set
> CONFIG_SENSORS_ADT7X10=y
> CONFIG_SENSORS_ADT7310=y
> CONFIG_SENSORS_ADT7410=y
> CONFIG_SENSORS_ADT7411=y
> CONFIG_SENSORS_ADT7462=y
> CONFIG_SENSORS_ADT7470=y
> # CONFIG_SENSORS_ADT7475 is not set
> CONFIG_SENSORS_AS370=y
> # CONFIG_SENSORS_ASC7621 is not set
> CONFIG_SENSORS_AXI_FAN_CONTROL=y
> # CONFIG_SENSORS_K8TEMP is not set
> # CONFIG_SENSORS_K10TEMP is not set
> # CONFIG_SENSORS_FAM15H_POWER is not set
> CONFIG_SENSORS_AMD_ENERGY=y
> # CONFIG_SENSORS_APPLESMC is not set
> CONFIG_SENSORS_ASB100=y
> CONFIG_SENSORS_ASPEED=y
> # CONFIG_SENSORS_ATXP1 is not set
> CONFIG_SENSORS_DS620=y
> CONFIG_SENSORS_DS1621=y
> # CONFIG_SENSORS_DELL_SMM is not set
> # CONFIG_SENSORS_DA9052_ADC is not set
> # CONFIG_SENSORS_I5K_AMB is not set
> # CONFIG_SENSORS_F71805F is not set
> CONFIG_SENSORS_F71882FG=y
> CONFIG_SENSORS_F75375S=y
> CONFIG_SENSORS_GSC=y
> # CONFIG_SENSORS_MC13783_ADC is not set
> CONFIG_SENSORS_FSCHMD=y
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_G760A is not set
> CONFIG_SENSORS_G762=y
> CONFIG_SENSORS_GPIO_FAN=y
> CONFIG_SENSORS_HIH6130=y
> # CONFIG_SENSORS_I5500 is not set
> CONFIG_SENSORS_CORETEMP=y
> CONFIG_SENSORS_IT87=y
> # CONFIG_SENSORS_JC42 is not set
> CONFIG_SENSORS_POWR1220=y
> # CONFIG_SENSORS_LINEAGE is not set
> # CONFIG_SENSORS_LTC2945 is not set
> CONFIG_SENSORS_LTC2947=y
> CONFIG_SENSORS_LTC2947_I2C=y
> CONFIG_SENSORS_LTC2947_SPI=y
> # CONFIG_SENSORS_LTC2990 is not set
> CONFIG_SENSORS_LTC4151=y
> CONFIG_SENSORS_LTC4215=y
> # CONFIG_SENSORS_LTC4222 is not set
> CONFIG_SENSORS_LTC4245=y
> # CONFIG_SENSORS_LTC4260 is not set
> CONFIG_SENSORS_LTC4261=y
> CONFIG_SENSORS_MAX1111=y
> # CONFIG_SENSORS_MAX16065 is not set
> CONFIG_SENSORS_MAX1619=y
> # CONFIG_SENSORS_MAX1668 is not set
> CONFIG_SENSORS_MAX197=y
> # CONFIG_SENSORS_MAX31722 is not set
> CONFIG_SENSORS_MAX31730=y
> # CONFIG_SENSORS_MAX6621 is not set
> CONFIG_SENSORS_MAX6639=y
> CONFIG_SENSORS_MAX6642=y
> CONFIG_SENSORS_MAX6650=y
> CONFIG_SENSORS_MAX6697=y
> CONFIG_SENSORS_MAX31790=y
> CONFIG_SENSORS_MCP3021=y
> CONFIG_SENSORS_MLXREG_FAN=y
> CONFIG_SENSORS_TC654=y
> CONFIG_SENSORS_ADCXX=y
> CONFIG_SENSORS_LM63=y
> CONFIG_SENSORS_LM70=y
> # CONFIG_SENSORS_LM73 is not set
> CONFIG_SENSORS_LM75=y
> CONFIG_SENSORS_LM77=y
> CONFIG_SENSORS_LM78=y
> CONFIG_SENSORS_LM80=y
> CONFIG_SENSORS_LM83=y
> CONFIG_SENSORS_LM85=y
> CONFIG_SENSORS_LM87=y
> CONFIG_SENSORS_LM90=y
> # CONFIG_SENSORS_LM92 is not set
> CONFIG_SENSORS_LM93=y
> CONFIG_SENSORS_LM95234=y
> # CONFIG_SENSORS_LM95241 is not set
> # CONFIG_SENSORS_LM95245 is not set
> CONFIG_SENSORS_PC87360=y
> # CONFIG_SENSORS_PC87427 is not set
> # CONFIG_SENSORS_NTC_THERMISTOR is not set
> # CONFIG_SENSORS_NCT6683 is not set
> # CONFIG_SENSORS_NCT6775 is not set
> # CONFIG_SENSORS_NCT7802 is not set
> CONFIG_SENSORS_NPCM7XX=y
> CONFIG_SENSORS_PCF8591=y
> CONFIG_PMBUS=y
> CONFIG_SENSORS_PMBUS=y
> # CONFIG_SENSORS_ADM1275 is not set
> CONFIG_SENSORS_BEL_PFE=y
> CONFIG_SENSORS_IBM_CFFPS=y
> # CONFIG_SENSORS_INSPUR_IPSPS is not set
> CONFIG_SENSORS_IR35221=y
> CONFIG_SENSORS_IR38064=y
> CONFIG_SENSORS_IRPS5401=y
> CONFIG_SENSORS_ISL68137=y
> # CONFIG_SENSORS_LM25066 is not set
> # CONFIG_SENSORS_LTC2978 is not set
> CONFIG_SENSORS_LTC3815=y
> CONFIG_SENSORS_MAX16064=y
> CONFIG_SENSORS_MAX16601=y
> CONFIG_SENSORS_MAX20730=y
> # CONFIG_SENSORS_MAX20751 is not set
> # CONFIG_SENSORS_MAX31785 is not set
> # CONFIG_SENSORS_MAX34440 is not set
> # CONFIG_SENSORS_MAX8688 is not set
> CONFIG_SENSORS_PXE1610=y
> # CONFIG_SENSORS_TPS40422 is not set
> # CONFIG_SENSORS_TPS53679 is not set
> # CONFIG_SENSORS_UCD9000 is not set
> CONFIG_SENSORS_UCD9200=y
> CONFIG_SENSORS_XDPE122=y
> # CONFIG_SENSORS_ZL6100 is not set
> # CONFIG_SENSORS_PWM_FAN is not set
> # CONFIG_SENSORS_SHT15 is not set
> # CONFIG_SENSORS_SHT21 is not set
> CONFIG_SENSORS_SHT3x=y
> CONFIG_SENSORS_SHTC1=y
> # CONFIG_SENSORS_SIS5595 is not set
> CONFIG_SENSORS_DME1737=y
> CONFIG_SENSORS_EMC1403=y
> CONFIG_SENSORS_EMC2103=y
> # CONFIG_SENSORS_EMC6W201 is not set
> CONFIG_SENSORS_SMSC47M1=y
> CONFIG_SENSORS_SMSC47M192=y
> CONFIG_SENSORS_SMSC47B397=y
> CONFIG_SENSORS_STTS751=y
> # CONFIG_SENSORS_SMM665 is not set
> CONFIG_SENSORS_ADC128D818=y
> # CONFIG_SENSORS_ADS7828 is not set
> CONFIG_SENSORS_ADS7871=y
> # CONFIG_SENSORS_AMC6821 is not set
> CONFIG_SENSORS_INA209=y
> CONFIG_SENSORS_INA2XX=y
> # CONFIG_SENSORS_INA3221 is not set
> CONFIG_SENSORS_TC74=y
> # CONFIG_SENSORS_THMC50 is not set
> # CONFIG_SENSORS_TMP102 is not set
> CONFIG_SENSORS_TMP103=y
> CONFIG_SENSORS_TMP108=y
> # CONFIG_SENSORS_TMP401 is not set
> CONFIG_SENSORS_TMP421=y
> # CONFIG_SENSORS_TMP513 is not set
> # CONFIG_SENSORS_VIA_CPUTEMP is not set
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_VT1211 is not set
> CONFIG_SENSORS_VT8231=y
> CONFIG_SENSORS_W83773G=y
> CONFIG_SENSORS_W83781D=y
> CONFIG_SENSORS_W83791D=y
> CONFIG_SENSORS_W83792D=y
> # CONFIG_SENSORS_W83793 is not set
> CONFIG_SENSORS_W83795=y
> CONFIG_SENSORS_W83795_FANCTRL=y
> # CONFIG_SENSORS_W83L785TS is not set
> CONFIG_SENSORS_W83L786NG=y
> CONFIG_SENSORS_W83627HF=y
> # CONFIG_SENSORS_W83627EHF is not set
> # CONFIG_SENSORS_WM8350 is not set
> 
> #
> # ACPI drivers
> #
> # CONFIG_SENSORS_ACPI_POWER is not set
> # CONFIG_SENSORS_ATK0110 is not set
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_OF=y
> # CONFIG_THERMAL_WRITABLE_TRIPS is not set
> # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_GOV_STEP_WISE is not set
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> CONFIG_THERMAL_GOV_USER_SPACE=y
> # CONFIG_CPU_THERMAL is not set
> CONFIG_CLOCK_THERMAL=y
> # CONFIG_DEVFREQ_THERMAL is not set
> # CONFIG_THERMAL_EMULATION is not set
> CONFIG_THERMAL_MMIO=y
> CONFIG_DA9062_THERMAL=y
> 
> #
> # Intel thermal drivers
> #
> # CONFIG_INTEL_POWERCLAMP is not set
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # end of ACPI INT340X thermal drivers
> 
> # CONFIG_INTEL_PCH_THERMAL is not set
> # end of Intel thermal drivers
> 
> # CONFIG_TI_SOC_THERMAL is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=y
> CONFIG_SSB_SPROM=y
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> CONFIG_SSB_PCIHOST=y
> CONFIG_SSB_SDIOHOST_POSSIBLE=y
> # CONFIG_SSB_SDIOHOST is not set
> CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> CONFIG_SSB_DRIVER_PCICORE=y
> CONFIG_SSB_DRIVER_GPIO=y
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=y
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> CONFIG_BCMA_HOST_PCI=y
> CONFIG_BCMA_HOST_SOC=y
> CONFIG_BCMA_DRIVER_PCI=y
> CONFIG_BCMA_SFLASH=y
> # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> # CONFIG_BCMA_DRIVER_GPIO is not set
> # CONFIG_BCMA_DEBUG is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> CONFIG_MFD_CS5535=y
> # CONFIG_MFD_ACT8945A is not set
> CONFIG_MFD_AS3711=y
> # CONFIG_MFD_AS3722 is not set
> # CONFIG_PMIC_ADP5520 is not set
> CONFIG_MFD_AAT2870_CORE=y
> CONFIG_MFD_ATMEL_FLEXCOM=y
> CONFIG_MFD_ATMEL_HLCDC=y
> CONFIG_MFD_BCM590XX=y
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> CONFIG_MFD_CROS_EC_DEV=y
> # CONFIG_MFD_MADERA is not set
> # CONFIG_PMIC_DA903X is not set
> CONFIG_PMIC_DA9052=y
> # CONFIG_MFD_DA9052_SPI is not set
> CONFIG_MFD_DA9052_I2C=y
> # CONFIG_MFD_DA9055 is not set
> CONFIG_MFD_DA9062=y
> CONFIG_MFD_DA9063=y
> CONFIG_MFD_DA9150=y
> CONFIG_MFD_DLN2=y
> CONFIG_MFD_GATEWORKS_GSC=y
> CONFIG_MFD_MC13XXX=y
> CONFIG_MFD_MC13XXX_SPI=y
> CONFIG_MFD_MC13XXX_I2C=y
> # CONFIG_MFD_MP2629 is not set
> CONFIG_MFD_HI6421_PMIC=y
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_HTC_I2CPLD is not set
> CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
> CONFIG_LPC_ICH=y
> CONFIG_LPC_SCH=y
> # CONFIG_INTEL_SOC_PMIC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> CONFIG_MFD_INTEL_LPSS=y
> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> CONFIG_MFD_INTEL_LPSS_PCI=y
> # CONFIG_MFD_INTEL_PMC_BXT is not set
> # CONFIG_MFD_IQS62X is not set
> CONFIG_MFD_JANZ_CMODIO=y
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> CONFIG_MFD_88PM805=y
> # CONFIG_MFD_88PM860X is not set
> CONFIG_MFD_MAX14577=y
> # CONFIG_MFD_MAX77620 is not set
> # CONFIG_MFD_MAX77650 is not set
> CONFIG_MFD_MAX77686=y
> CONFIG_MFD_MAX77693=y
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> CONFIG_MFD_MAX8997=y
> # CONFIG_MFD_MAX8998 is not set
> CONFIG_MFD_MT6360=y
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> CONFIG_EZX_PCAP=y
> CONFIG_MFD_CPCAP=y
> CONFIG_MFD_VIPERBOARD=y
> CONFIG_MFD_RETU=y
> CONFIG_MFD_PCF50633=y
> CONFIG_PCF50633_ADC=y
> CONFIG_PCF50633_GPIO=y
> CONFIG_MFD_RDC321X=y
> CONFIG_MFD_RT5033=y
> CONFIG_MFD_RC5T583=y
> # CONFIG_MFD_RK808 is not set
> # CONFIG_MFD_RN5T618 is not set
> CONFIG_MFD_SEC_CORE=y
> # CONFIG_MFD_SI476X_CORE is not set
> # CONFIG_MFD_SM501 is not set
> CONFIG_MFD_SKY81452=y
> CONFIG_MFD_SMSC=y
> CONFIG_ABX500_CORE=y
> # CONFIG_AB3100_CORE is not set
> CONFIG_MFD_STMPE=y
> 
> #
> # STMicroelectronics STMPE Interface Drivers
> #
> CONFIG_STMPE_I2C=y
> # CONFIG_STMPE_SPI is not set
> # end of STMicroelectronics STMPE Interface Drivers
> 
> CONFIG_MFD_SYSCON=y
> CONFIG_MFD_TI_AM335X_TSCADC=y
> CONFIG_MFD_LP3943=y
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> CONFIG_MFD_PALMAS=y
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> CONFIG_TPS6507X=y
> CONFIG_MFD_TPS65086=y
> # CONFIG_MFD_TPS65090 is not set
> CONFIG_MFD_TPS65217=y
> # CONFIG_MFD_TPS68470 is not set
> CONFIG_MFD_TI_LP873X=y
> # CONFIG_MFD_TI_LP87565 is not set
> # CONFIG_MFD_TPS65218 is not set
> CONFIG_MFD_TPS6586X=y
> CONFIG_MFD_TPS65910=y
> CONFIG_MFD_TPS65912=y
> CONFIG_MFD_TPS65912_I2C=y
> # CONFIG_MFD_TPS65912_SPI is not set
> CONFIG_MFD_TPS80031=y
> CONFIG_TWL4030_CORE=y
> CONFIG_MFD_TWL4030_AUDIO=y
> CONFIG_TWL6040_CORE=y
> # CONFIG_MFD_WL1273_CORE is not set
> CONFIG_MFD_LM3533=y
> CONFIG_MFD_TIMBERDALE=y
> # CONFIG_MFD_TC3589X is not set
> CONFIG_MFD_TQMX86=y
> CONFIG_MFD_VX855=y
> # CONFIG_MFD_LOCHNAGAR is not set
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> CONFIG_MFD_WM8350=y
> CONFIG_MFD_WM8350_I2C=y
> CONFIG_MFD_WM8994=y
> # CONFIG_MFD_ROHM_BD718XX is not set
> CONFIG_MFD_ROHM_BD70528=y
> CONFIG_MFD_ROHM_BD71828=y
> CONFIG_MFD_STPMIC1=y
> CONFIG_MFD_STMFX=y
> CONFIG_MFD_WCD934X=y
> # CONFIG_RAVE_SP_CORE is not set
> # end of Multifunction device drivers
> 
> CONFIG_REGULATOR=y
> # CONFIG_REGULATOR_DEBUG is not set
> # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> # CONFIG_REGULATOR_88PG86X is not set
> CONFIG_REGULATOR_ACT8865=y
> CONFIG_REGULATOR_AD5398=y
> # CONFIG_REGULATOR_AAT2870 is not set
> CONFIG_REGULATOR_AS3711=y
> CONFIG_REGULATOR_BCM590XX=y
> CONFIG_REGULATOR_BD70528=y
> # CONFIG_REGULATOR_BD71828 is not set
> # CONFIG_REGULATOR_CPCAP is not set
> CONFIG_REGULATOR_DA9052=y
> CONFIG_REGULATOR_DA9062=y
> CONFIG_REGULATOR_DA9063=y
> CONFIG_REGULATOR_DA9210=y
> CONFIG_REGULATOR_DA9211=y
> CONFIG_REGULATOR_FAN53555=y
> # CONFIG_REGULATOR_GPIO is not set
> CONFIG_REGULATOR_HI6421=y
> CONFIG_REGULATOR_HI6421V530=y
> CONFIG_REGULATOR_ISL9305=y
> CONFIG_REGULATOR_ISL6271A=y
> # CONFIG_REGULATOR_LP3971 is not set
> CONFIG_REGULATOR_LP3972=y
> # CONFIG_REGULATOR_LP872X is not set
> CONFIG_REGULATOR_LP873X=y
> CONFIG_REGULATOR_LP8755=y
> CONFIG_REGULATOR_LTC3589=y
> CONFIG_REGULATOR_LTC3676=y
> # CONFIG_REGULATOR_MAX14577 is not set
> CONFIG_REGULATOR_MAX1586=y
> # CONFIG_REGULATOR_MAX8649 is not set
> # CONFIG_REGULATOR_MAX8660 is not set
> CONFIG_REGULATOR_MAX8952=y
> CONFIG_REGULATOR_MAX8973=y
> CONFIG_REGULATOR_MAX8997=y
> CONFIG_REGULATOR_MAX77686=y
> # CONFIG_REGULATOR_MAX77693 is not set
> CONFIG_REGULATOR_MAX77802=y
> # CONFIG_REGULATOR_MAX77826 is not set
> CONFIG_REGULATOR_MC13XXX_CORE=y
> CONFIG_REGULATOR_MC13783=y
> CONFIG_REGULATOR_MC13892=y
> # CONFIG_REGULATOR_MCP16502 is not set
> CONFIG_REGULATOR_MP5416=y
> CONFIG_REGULATOR_MP8859=y
> CONFIG_REGULATOR_MP886X=y
> CONFIG_REGULATOR_MPQ7920=y
> CONFIG_REGULATOR_MT6311=y
> # CONFIG_REGULATOR_PALMAS is not set
> CONFIG_REGULATOR_PCAP=y
> # CONFIG_REGULATOR_PCF50633 is not set
> # CONFIG_REGULATOR_PFUZE100 is not set
> CONFIG_REGULATOR_PV88060=y
> CONFIG_REGULATOR_PV88080=y
> CONFIG_REGULATOR_PV88090=y
> CONFIG_REGULATOR_PWM=y
> CONFIG_REGULATOR_QCOM_SPMI=y
> CONFIG_REGULATOR_RC5T583=y
> CONFIG_REGULATOR_RT5033=y
> # CONFIG_REGULATOR_S2MPA01 is not set
> # CONFIG_REGULATOR_S2MPS11 is not set
> CONFIG_REGULATOR_S5M8767=y
> CONFIG_REGULATOR_SKY81452=y
> CONFIG_REGULATOR_SLG51000=y
> CONFIG_REGULATOR_STPMIC1=y
> CONFIG_REGULATOR_SY8106A=y
> # CONFIG_REGULATOR_SY8824X is not set
> # CONFIG_REGULATOR_TPS51632 is not set
> # CONFIG_REGULATOR_TPS62360 is not set
> CONFIG_REGULATOR_TPS65023=y
> CONFIG_REGULATOR_TPS6507X=y
> # CONFIG_REGULATOR_TPS65086 is not set
> CONFIG_REGULATOR_TPS65132=y
> # CONFIG_REGULATOR_TPS65217 is not set
> CONFIG_REGULATOR_TPS6524X=y
> CONFIG_REGULATOR_TPS6586X=y
> CONFIG_REGULATOR_TPS65910=y
> CONFIG_REGULATOR_TPS65912=y
> CONFIG_REGULATOR_TPS80031=y
> CONFIG_REGULATOR_TWL4030=y
> CONFIG_REGULATOR_VCTRL=y
> CONFIG_REGULATOR_WM8350=y
> CONFIG_REGULATOR_WM8994=y
> # CONFIG_RC_CORE is not set
> CONFIG_CEC_CORE=y
> CONFIG_CEC_NOTIFIER=y
> CONFIG_CEC_PIN=y
> # CONFIG_CEC_PIN_ERROR_INJ is not set
> CONFIG_MEDIA_CEC_SUPPORT=y
> # CONFIG_CEC_CROS_EC is not set
> CONFIG_CEC_GPIO=y
> CONFIG_USB_PULSE8_CEC=y
> CONFIG_USB_RAINSHADOW_CEC=y
> CONFIG_MEDIA_SUPPORT=y
> CONFIG_MEDIA_SUPPORT_FILTER=y
> # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> 
> #
> # Media device types
> #
> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> CONFIG_MEDIA_RADIO_SUPPORT=y
> # CONFIG_MEDIA_SDR_SUPPORT is not set
> # CONFIG_MEDIA_PLATFORM_SUPPORT is not set
> # CONFIG_MEDIA_TEST_SUPPORT is not set
> # end of Media device types
> 
> CONFIG_VIDEO_DEV=y
> CONFIG_MEDIA_CONTROLLER=y
> CONFIG_DVB_CORE=y
> 
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2=y
> CONFIG_VIDEO_V4L2_I2C=y
> CONFIG_VIDEO_V4L2_SUBDEV_API=y
> CONFIG_VIDEO_ADV_DEBUG=y
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> CONFIG_V4L2_FLASH_LED_CLASS=y
> CONFIG_V4L2_FWNODE=y
> # end of Video4Linux options
> 
> #
> # Media controller options
> #
> # CONFIG_MEDIA_CONTROLLER_DVB is not set
> # end of Media controller options
> 
> #
> # Digital TV options
> #
> CONFIG_DVB_MMAP=y
> CONFIG_DVB_NET=y
> CONFIG_DVB_MAX_ADAPTERS=16
> # CONFIG_DVB_DYNAMIC_MINORS is not set
> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> CONFIG_DVB_ULE_DEBUG=y
> # end of Digital TV options
> 
> #
> # Media drivers
> #
> 
> #
> # Drivers filtered as selected at 'Filter media drivers'
> #
> # CONFIG_MEDIA_USB_SUPPORT is not set
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> # CONFIG_RADIO_ADAPTERS is not set
> CONFIG_VIDEOBUF2_CORE=y
> CONFIG_VIDEOBUF2_V4L2=y
> CONFIG_VIDEOBUF2_MEMOPS=y
> CONFIG_VIDEOBUF2_VMALLOC=y
> CONFIG_VIDEOBUF2_DMA_SG=y
> # end of Media drivers
> 
> #
> # Media ancillary drivers
> #
> CONFIG_MEDIA_ATTACH=y
> 
> #
> # Audio decoders, processors and mixers
> #
> CONFIG_VIDEO_TVAUDIO=y
> CONFIG_VIDEO_TDA7432=y
> CONFIG_VIDEO_TDA9840=y
> CONFIG_VIDEO_TEA6415C=y
> CONFIG_VIDEO_TEA6420=y
> CONFIG_VIDEO_MSP3400=y
> CONFIG_VIDEO_CS3308=y
> CONFIG_VIDEO_CS5345=y
> # CONFIG_VIDEO_CS53L32A is not set
> CONFIG_VIDEO_TLV320AIC23B=y
> CONFIG_VIDEO_UDA1342=y
> CONFIG_VIDEO_WM8775=y
> CONFIG_VIDEO_WM8739=y
> CONFIG_VIDEO_VP27SMPX=y
> CONFIG_VIDEO_SONY_BTF_MPX=y
> # end of Audio decoders, processors and mixers
> 
> #
> # RDS decoders
> #
> CONFIG_VIDEO_SAA6588=y
> # end of RDS decoders
> 
> #
> # Video decoders
> #
> # CONFIG_VIDEO_ADV7180 is not set
> # CONFIG_VIDEO_ADV7183 is not set
> CONFIG_VIDEO_ADV748X=y
> CONFIG_VIDEO_ADV7604=y
> CONFIG_VIDEO_ADV7604_CEC=y
> CONFIG_VIDEO_ADV7842=y
> CONFIG_VIDEO_ADV7842_CEC=y
> # CONFIG_VIDEO_BT819 is not set
> # CONFIG_VIDEO_BT856 is not set
> CONFIG_VIDEO_BT866=y
> CONFIG_VIDEO_KS0127=y
> CONFIG_VIDEO_ML86V7667=y
> # CONFIG_VIDEO_SAA7110 is not set
> CONFIG_VIDEO_SAA711X=y
> # CONFIG_VIDEO_TC358743 is not set
> CONFIG_VIDEO_TVP514X=y
> # CONFIG_VIDEO_TVP5150 is not set
> CONFIG_VIDEO_TVP7002=y
> # CONFIG_VIDEO_TW2804 is not set
> CONFIG_VIDEO_TW9903=y
> CONFIG_VIDEO_TW9906=y
> # CONFIG_VIDEO_TW9910 is not set
> # CONFIG_VIDEO_VPX3220 is not set
> 
> #
> # Video and audio decoders
> #
> CONFIG_VIDEO_SAA717X=y
> CONFIG_VIDEO_CX25840=y
> # end of Video decoders
> 
> #
> # Video encoders
> #
> CONFIG_VIDEO_SAA7127=y
> CONFIG_VIDEO_SAA7185=y
> # CONFIG_VIDEO_ADV7170 is not set
> CONFIG_VIDEO_ADV7175=y
> CONFIG_VIDEO_ADV7343=y
> CONFIG_VIDEO_ADV7393=y
> CONFIG_VIDEO_AD9389B=y
> # CONFIG_VIDEO_AK881X is not set
> # CONFIG_VIDEO_THS8200 is not set
> # end of Video encoders
> 
> #
> # Video improvement chips
> #
> CONFIG_VIDEO_UPD64031A=y
> # CONFIG_VIDEO_UPD64083 is not set
> # end of Video improvement chips
> 
> #
> # Audio/Video compression chips
> #
> CONFIG_VIDEO_SAA6752HS=y
> # end of Audio/Video compression chips
> 
> #
> # SDR tuner chips
> #
> # end of SDR tuner chips
> 
> #
> # Miscellaneous helper chips
> #
> CONFIG_VIDEO_THS7303=y
> CONFIG_VIDEO_M52790=y
> CONFIG_VIDEO_I2C=y
> CONFIG_VIDEO_ST_MIPID02=y
> # end of Miscellaneous helper chips
> 
> #
> # SPI helper chips
> #
> CONFIG_VIDEO_GS1662=y
> # end of SPI helper chips
> 
> #
> # Media SPI Adapters
> #
> CONFIG_CXD2880_SPI_DRV=y
> # end of Media SPI Adapters
> 
> CONFIG_MEDIA_TUNER=y
> 
> #
> # Customize TV tuners
> #
> CONFIG_MEDIA_TUNER_SIMPLE=y
> CONFIG_MEDIA_TUNER_TDA18250=y
> CONFIG_MEDIA_TUNER_TDA8290=y
> CONFIG_MEDIA_TUNER_TDA827X=y
> CONFIG_MEDIA_TUNER_TDA18271=y
> CONFIG_MEDIA_TUNER_TDA9887=y
> CONFIG_MEDIA_TUNER_TEA5761=y
> CONFIG_MEDIA_TUNER_TEA5767=y
> CONFIG_MEDIA_TUNER_MSI001=y
> CONFIG_MEDIA_TUNER_MT20XX=y
> CONFIG_MEDIA_TUNER_MT2060=y
> # CONFIG_MEDIA_TUNER_MT2063 is not set
> # CONFIG_MEDIA_TUNER_MT2266 is not set
> CONFIG_MEDIA_TUNER_MT2131=y
> # CONFIG_MEDIA_TUNER_QT1010 is not set
> CONFIG_MEDIA_TUNER_XC2028=y
> CONFIG_MEDIA_TUNER_XC5000=y
> CONFIG_MEDIA_TUNER_XC4000=y
> # CONFIG_MEDIA_TUNER_MXL5005S is not set
> CONFIG_MEDIA_TUNER_MXL5007T=y
> # CONFIG_MEDIA_TUNER_MC44S803 is not set
> CONFIG_MEDIA_TUNER_MAX2165=y
> CONFIG_MEDIA_TUNER_TDA18218=y
> CONFIG_MEDIA_TUNER_FC0011=y
> CONFIG_MEDIA_TUNER_FC0012=y
> CONFIG_MEDIA_TUNER_FC0013=y
> CONFIG_MEDIA_TUNER_TDA18212=y
> # CONFIG_MEDIA_TUNER_E4000 is not set
> CONFIG_MEDIA_TUNER_FC2580=y
> CONFIG_MEDIA_TUNER_M88RS6000T=y
> CONFIG_MEDIA_TUNER_TUA9001=y
> CONFIG_MEDIA_TUNER_SI2157=y
> # CONFIG_MEDIA_TUNER_IT913X is not set
> # CONFIG_MEDIA_TUNER_R820T is not set
> CONFIG_MEDIA_TUNER_MXL301RF=y
> CONFIG_MEDIA_TUNER_QM1D1C0042=y
> # CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
> # end of Customize TV tuners
> 
> #
> # Customise DVB Frontends
> #
> 
> #
> # Multistandard (satellite) frontends
> #
> # CONFIG_DVB_STB0899 is not set
> CONFIG_DVB_STB6100=y
> CONFIG_DVB_STV090x=y
> # CONFIG_DVB_STV0910 is not set
> # CONFIG_DVB_STV6110x is not set
> # CONFIG_DVB_STV6111 is not set
> # CONFIG_DVB_MXL5XX is not set
> CONFIG_DVB_M88DS3103=y
> 
> #
> # Multistandard (cable + terrestrial) frontends
> #
> CONFIG_DVB_DRXK=y
> CONFIG_DVB_TDA18271C2DD=y
> # CONFIG_DVB_SI2165 is not set
> CONFIG_DVB_MN88472=y
> CONFIG_DVB_MN88473=y
> 
> #
> # DVB-S (satellite) frontends
> #
> # CONFIG_DVB_CX24110 is not set
> CONFIG_DVB_CX24123=y
> CONFIG_DVB_MT312=y
> CONFIG_DVB_ZL10036=y
> # CONFIG_DVB_ZL10039 is not set
> # CONFIG_DVB_S5H1420 is not set
> CONFIG_DVB_STV0288=y
> CONFIG_DVB_STB6000=y
> # CONFIG_DVB_STV0299 is not set
> # CONFIG_DVB_STV6110 is not set
> # CONFIG_DVB_STV0900 is not set
> CONFIG_DVB_TDA8083=y
> # CONFIG_DVB_TDA10086 is not set
> CONFIG_DVB_TDA8261=y
> # CONFIG_DVB_VES1X93 is not set
> CONFIG_DVB_TUNER_ITD1000=y
> CONFIG_DVB_TUNER_CX24113=y
> CONFIG_DVB_TDA826X=y
> CONFIG_DVB_TUA6100=y
> CONFIG_DVB_CX24116=y
> CONFIG_DVB_CX24117=y
> CONFIG_DVB_CX24120=y
> CONFIG_DVB_SI21XX=y
> CONFIG_DVB_TS2020=y
> # CONFIG_DVB_DS3000 is not set
> CONFIG_DVB_MB86A16=y
> CONFIG_DVB_TDA10071=y
> 
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_SP8870=y
> CONFIG_DVB_SP887X=y
> CONFIG_DVB_CX22700=y
> # CONFIG_DVB_CX22702 is not set
> CONFIG_DVB_S5H1432=y
> # CONFIG_DVB_DRXD is not set
> CONFIG_DVB_L64781=y
> CONFIG_DVB_TDA1004X=y
> CONFIG_DVB_NXT6000=y
> CONFIG_DVB_MT352=y
> # CONFIG_DVB_ZL10353 is not set
> # CONFIG_DVB_DIB3000MB is not set
> # CONFIG_DVB_DIB3000MC is not set
> # CONFIG_DVB_DIB7000M is not set
> CONFIG_DVB_DIB7000P=y
> CONFIG_DVB_DIB9000=y
> # CONFIG_DVB_TDA10048 is not set
> # CONFIG_DVB_AF9013 is not set
> CONFIG_DVB_EC100=y
> CONFIG_DVB_STV0367=y
> CONFIG_DVB_CXD2820R=y
> CONFIG_DVB_CXD2841ER=y
> CONFIG_DVB_RTL2830=y
> # CONFIG_DVB_RTL2832 is not set
> CONFIG_DVB_SI2168=y
> CONFIG_DVB_ZD1301_DEMOD=y
> # CONFIG_DVB_CXD2880 is not set
> 
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_VES1820=y
> CONFIG_DVB_TDA10021=y
> CONFIG_DVB_TDA10023=y
> CONFIG_DVB_STV0297=y
> 
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_NXT200X=y
> CONFIG_DVB_OR51211=y
> CONFIG_DVB_OR51132=y
> CONFIG_DVB_BCM3510=y
> CONFIG_DVB_LGDT330X=y
> CONFIG_DVB_LGDT3305=y
> CONFIG_DVB_LGDT3306A=y
> CONFIG_DVB_LG2160=y
> # CONFIG_DVB_S5H1409 is not set
> CONFIG_DVB_AU8522=y
> # CONFIG_DVB_AU8522_DTV is not set
> CONFIG_DVB_AU8522_V4L=y
> CONFIG_DVB_S5H1411=y
> 
> #
> # ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_S921=y
> # CONFIG_DVB_DIB8000 is not set
> CONFIG_DVB_MB86A20S=y
> 
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> # CONFIG_DVB_TC90522 is not set
> # CONFIG_DVB_MN88443X is not set
> 
> #
> # Digital terrestrial only tuners/PLL
> #
> CONFIG_DVB_PLL=y
> # CONFIG_DVB_TUNER_DIB0070 is not set
> # CONFIG_DVB_TUNER_DIB0090 is not set
> 
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_DRX39XYJ=y
> CONFIG_DVB_LNBH25=y
> # CONFIG_DVB_LNBH29 is not set
> CONFIG_DVB_LNBP21=y
> # CONFIG_DVB_LNBP22 is not set
> CONFIG_DVB_ISL6405=y
> CONFIG_DVB_ISL6421=y
> CONFIG_DVB_ISL6423=y
> # CONFIG_DVB_A8293 is not set
> CONFIG_DVB_LGS8GL5=y
> # CONFIG_DVB_LGS8GXX is not set
> CONFIG_DVB_ATBM8830=y
> CONFIG_DVB_TDA665x=y
> # CONFIG_DVB_IX2505V is not set
> CONFIG_DVB_M88RS2000=y
> CONFIG_DVB_AF9033=y
> # CONFIG_DVB_HORUS3A is not set
> # CONFIG_DVB_ASCOT2E is not set
> CONFIG_DVB_HELENE=y
> 
> #
> # Common Interface (EN50221) controller drivers
> #
> # CONFIG_DVB_CXD2099 is not set
> CONFIG_DVB_SP2=y
> # end of Customise DVB Frontends
> # end of Media ancillary drivers
> 
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_INTEL_GTT=y
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_VGA_SWITCHEROO is not set
> CONFIG_DRM=y
> CONFIG_DRM_MIPI_DBI=y
> CONFIG_DRM_MIPI_DSI=y
> CONFIG_DRM_DP_AUX_CHARDEV=y
> CONFIG_DRM_DEBUG_MM=y
> CONFIG_DRM_DEBUG_SELFTEST=y
> CONFIG_DRM_KMS_HELPER=y
> CONFIG_DRM_KMS_FB_HELPER=y
> # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_FBDEV_OVERALLOC=100
> CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> # CONFIG_DRM_DP_CEC is not set
> CONFIG_DRM_TTM=y
> CONFIG_DRM_TTM_DMA_PAGE_POOL=y
> CONFIG_DRM_VRAM_HELPER=y
> CONFIG_DRM_TTM_HELPER=y
> CONFIG_DRM_GEM_CMA_HELPER=y
> CONFIG_DRM_KMS_CMA_HELPER=y
> CONFIG_DRM_GEM_SHMEM_HELPER=y
> CONFIG_DRM_SCHED=y
> 
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=y
> CONFIG_DRM_I2C_SIL164=y
> CONFIG_DRM_I2C_NXP_TDA998X=y
> CONFIG_DRM_I2C_NXP_TDA9950=y
> # end of I2C encoder or helper chips
> 
> #
> # ARM devices
> #
> CONFIG_DRM_KOMEDA=y
> # end of ARM devices
> 
> # CONFIG_DRM_RADEON is not set
> CONFIG_DRM_AMDGPU=y
> CONFIG_DRM_AMDGPU_SI=y
> CONFIG_DRM_AMDGPU_CIK=y
> CONFIG_DRM_AMDGPU_USERPTR=y
> CONFIG_DRM_AMDGPU_GART_DEBUGFS=y
> 
> #
> # ACP (Audio CoProcessor) Configuration
> #
> CONFIG_DRM_AMD_ACP=y
> # end of ACP (Audio CoProcessor) Configuration
> 
> #
> # Display Engine Configuration
> #
> CONFIG_DRM_AMD_DC=y
> CONFIG_DRM_AMD_DC_DCN=y
> # CONFIG_DRM_AMD_DC_HDCP is not set
> CONFIG_DEBUG_KERNEL_DC=y
> # end of Display Engine Configuration
> 
> CONFIG_DRM_NOUVEAU=y
> # CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
> CONFIG_NOUVEAU_DEBUG=5
> CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> # CONFIG_NOUVEAU_DEBUG_MMU is not set
> CONFIG_DRM_NOUVEAU_BACKLIGHT=y
> CONFIG_DRM_I915=y
> CONFIG_DRM_I915_FORCE_PROBE=""
> CONFIG_DRM_I915_CAPTURE_ERROR=y
> CONFIG_DRM_I915_COMPRESS_ERROR=y
> CONFIG_DRM_I915_USERPTR=y
> 
> #
> # drm/i915 Debugging
> #
> # CONFIG_DRM_I915_WERROR is not set
> CONFIG_DRM_I915_DEBUG=y
> CONFIG_DRM_I915_DEBUG_MMIO=y
> CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
> # CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
> # CONFIG_DRM_I915_DEBUG_GUC is not set
> CONFIG_DRM_I915_SELFTEST=y
> CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
> CONFIG_DRM_I915_DEBUG_VBLANK_EVADE=y
> CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
> # end of drm/i915 Debugging
> 
> #
> # drm/i915 Profile Guided Optimisation
> #
> CONFIG_DRM_I915_FENCE_TIMEOUT=10000
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
> CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
> CONFIG_DRM_I915_STOP_TIMEOUT=100
> CONFIG_DRM_I915_TIMESLICE_DURATION=1
> # end of drm/i915 Profile Guided Optimisation
> 
> CONFIG_DRM_VGEM=y
> # CONFIG_DRM_VKMS is not set
> CONFIG_DRM_VMWGFX=y
> CONFIG_DRM_VMWGFX_FBCON=y
> CONFIG_DRM_GMA500=y
> CONFIG_DRM_GMA600=y
> CONFIG_DRM_GMA3600=y
> # CONFIG_DRM_UDL is not set
> # CONFIG_DRM_AST is not set
> # CONFIG_DRM_MGAG200 is not set
> CONFIG_DRM_RCAR_DW_HDMI=y
> CONFIG_DRM_RCAR_LVDS=y
> # CONFIG_DRM_QXL is not set
> CONFIG_DRM_BOCHS=y
> CONFIG_DRM_VIRTIO_GPU=y
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_ARM_VERSATILE is not set
> CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=y
> CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
> # CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
> CONFIG_DRM_PANEL_LVDS=y
> # CONFIG_DRM_PANEL_SIMPLE is not set
> # CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
> CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=y
> CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
> CONFIG_DRM_PANEL_ILITEK_IL9322=y
> CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
> CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
> CONFIG_DRM_PANEL_JDI_LT070ME05000=y
> CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
> CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=y
> CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=y
> # CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
> CONFIG_DRM_PANEL_LG_LB035Q02=y
> # CONFIG_DRM_PANEL_LG_LG4573 is not set
> # CONFIG_DRM_PANEL_NEC_NL8048HL11 is not set
> CONFIG_DRM_PANEL_NOVATEK_NT35510=y
> CONFIG_DRM_PANEL_NOVATEK_NT39016=y
> CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
> CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
> CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
> CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
> CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
> CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
> CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
> # CONFIG_DRM_PANEL_ROCKTECH_JH057N00900 is not set
> CONFIG_DRM_PANEL_RONBO_RB070D30=y
> CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
> CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
> CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
> # CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
> CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
> CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
> # CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
> CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
> # CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
> CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
> CONFIG_DRM_PANEL_SONY_ACX424AKP=y
> CONFIG_DRM_PANEL_SONY_ACX565AKM=y
> CONFIG_DRM_PANEL_TPO_TD028TTEC1=y
> CONFIG_DRM_PANEL_TPO_TD043MTEA1=y
> CONFIG_DRM_PANEL_TPO_TPG110=y
> # CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
> # CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
> CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
> # end of Display Panels
> 
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_CDNS_DSI is not set
> CONFIG_DRM_CHRONTEL_CH7033=y
> CONFIG_DRM_DISPLAY_CONNECTOR=y
> # CONFIG_DRM_LVDS_CODEC is not set
> CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
> CONFIG_DRM_NWL_MIPI_DSI=y
> CONFIG_DRM_NXP_PTN3460=y
> CONFIG_DRM_PARADE_PS8622=y
> CONFIG_DRM_PARADE_PS8640=y
> # CONFIG_DRM_SIL_SII8620 is not set
> CONFIG_DRM_SII902X=y
> CONFIG_DRM_SII9234=y
> CONFIG_DRM_SIMPLE_BRIDGE=y
> CONFIG_DRM_THINE_THC63LVD1024=y
> # CONFIG_DRM_TOSHIBA_TC358764 is not set
> CONFIG_DRM_TOSHIBA_TC358767=y
> CONFIG_DRM_TOSHIBA_TC358768=y
> CONFIG_DRM_TI_TFP410=y
> # CONFIG_DRM_TI_SN65DSI86 is not set
> CONFIG_DRM_TI_TPD12S015=y
> CONFIG_DRM_ANALOGIX_ANX6345=y
> CONFIG_DRM_ANALOGIX_ANX78XX=y
> CONFIG_DRM_ANALOGIX_DP=y
> CONFIG_DRM_I2C_ADV7511=y
> # CONFIG_DRM_I2C_ADV7511_CEC is not set
> CONFIG_DRM_DW_HDMI=y
> CONFIG_DRM_DW_HDMI_CEC=y
> # end of Display Interface Bridges
> 
> # CONFIG_DRM_ETNAVIV is not set
> CONFIG_DRM_ARCPGU=y
> CONFIG_DRM_MXS=y
> CONFIG_DRM_MXSFB=y
> # CONFIG_DRM_CIRRUS_QEMU is not set
> CONFIG_DRM_GM12U320=y
> # CONFIG_TINYDRM_HX8357D is not set
> CONFIG_TINYDRM_ILI9225=y
> CONFIG_TINYDRM_ILI9341=y
> CONFIG_TINYDRM_ILI9486=y
> # CONFIG_TINYDRM_MI0283QT is not set
> CONFIG_TINYDRM_REPAPER=y
> # CONFIG_TINYDRM_ST7586 is not set
> CONFIG_TINYDRM_ST7735R=y
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_EXPORT_FOR_TESTS=y
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> CONFIG_DRM_LIB_RANDOM=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_DDC=y
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> CONFIG_FB_FOREIGN_ENDIAN=y
> # CONFIG_FB_BOTH_ENDIAN is not set
> # CONFIG_FB_BIG_ENDIAN is not set
> CONFIG_FB_LITTLE_ENDIAN=y
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_HECUBA=y
> CONFIG_FB_SVGALIB=y
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> CONFIG_FB_CYBER2000=y
> CONFIG_FB_CYBER2000_DDC=y
> CONFIG_FB_ARC=y
> CONFIG_FB_ASILIANT=y
> CONFIG_FB_IMSTT=y
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_VESA=y
> CONFIG_FB_N411=y
> # CONFIG_FB_HGA is not set
> CONFIG_FB_OPENCORES=y
> CONFIG_FB_S1D13XXX=y
> # CONFIG_FB_NVIDIA is not set
> CONFIG_FB_RIVA=y
> # CONFIG_FB_RIVA_I2C is not set
> # CONFIG_FB_RIVA_DEBUG is not set
> CONFIG_FB_RIVA_BACKLIGHT=y
> CONFIG_FB_I740=y
> CONFIG_FB_LE80578=y
> CONFIG_FB_CARILLO_RANCH=y
> CONFIG_FB_MATROX=y
> CONFIG_FB_MATROX_MILLENIUM=y
> CONFIG_FB_MATROX_MYSTIQUE=y
> # CONFIG_FB_MATROX_G is not set
> # CONFIG_FB_MATROX_I2C is not set
> CONFIG_FB_RADEON=y
> # CONFIG_FB_RADEON_I2C is not set
> # CONFIG_FB_RADEON_BACKLIGHT is not set
> # CONFIG_FB_RADEON_DEBUG is not set
> CONFIG_FB_ATY128=y
> # CONFIG_FB_ATY128_BACKLIGHT is not set
> CONFIG_FB_ATY=y
> # CONFIG_FB_ATY_CT is not set
> CONFIG_FB_ATY_GX=y
> CONFIG_FB_ATY_BACKLIGHT=y
> # CONFIG_FB_S3 is not set
> CONFIG_FB_SAVAGE=y
> # CONFIG_FB_SAVAGE_I2C is not set
> CONFIG_FB_SAVAGE_ACCEL=y
> CONFIG_FB_SIS=y
> CONFIG_FB_SIS_300=y
> CONFIG_FB_SIS_315=y
> # CONFIG_FB_VIA is not set
> CONFIG_FB_NEOMAGIC=y
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> CONFIG_FB_VOODOO1=y
> CONFIG_FB_VT8623=y
> CONFIG_FB_TRIDENT=y
> CONFIG_FB_ARK=y
> CONFIG_FB_PM3=y
> CONFIG_FB_CARMINE=y
> # CONFIG_FB_CARMINE_DRAM_EVAL is not set
> CONFIG_CARMINE_DRAM_CUSTOM=y
> CONFIG_FB_GEODE=y
> # CONFIG_FB_GEODE_LX is not set
> # CONFIG_FB_GEODE_GX is not set
> # CONFIG_FB_GEODE_GX1 is not set
> CONFIG_FB_SMSCUFX=y
> CONFIG_FB_UDL=y
> CONFIG_FB_IBM_GXT4500=y
> CONFIG_FB_VIRTUAL=y
> CONFIG_FB_METRONOME=y
> # CONFIG_FB_MB862XX is not set
> CONFIG_FB_SIMPLE=y
> CONFIG_FB_SSD1307=y
> CONFIG_FB_SM712=y
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=y
> CONFIG_LCD_L4F00242T03=y
> CONFIG_LCD_LMS283GF05=y
> CONFIG_LCD_LTV350QV=y
> # CONFIG_LCD_ILI922X is not set
> CONFIG_LCD_ILI9320=y
> CONFIG_LCD_TDO24M=y
> CONFIG_LCD_VGG2432A4=y
> CONFIG_LCD_PLATFORM=y
> CONFIG_LCD_AMS369FG06=y
> CONFIG_LCD_LMS501KF03=y
> CONFIG_LCD_HX8357=y
> CONFIG_LCD_OTM3225A=y
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_GENERIC=y
> # CONFIG_BACKLIGHT_LM3533 is not set
> CONFIG_BACKLIGHT_CARILLO_RANCH=y
> CONFIG_BACKLIGHT_PWM=y
> # CONFIG_BACKLIGHT_DA9052 is not set
> # CONFIG_BACKLIGHT_APPLE is not set
> CONFIG_BACKLIGHT_QCOM_WLED=y
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> CONFIG_BACKLIGHT_ADP8870=y
> CONFIG_BACKLIGHT_PCF50633=y
> CONFIG_BACKLIGHT_AAT2870=y
> # CONFIG_BACKLIGHT_LM3630A is not set
> CONFIG_BACKLIGHT_LM3639=y
> # CONFIG_BACKLIGHT_LP855X is not set
> CONFIG_BACKLIGHT_OT200=y
> CONFIG_BACKLIGHT_PANDORA=y
> # CONFIG_BACKLIGHT_SKY81452 is not set
> CONFIG_BACKLIGHT_TPS65217=y
> # CONFIG_BACKLIGHT_AS3711 is not set
> CONFIG_BACKLIGHT_GPIO=y
> CONFIG_BACKLIGHT_LV5207LP=y
> CONFIG_BACKLIGHT_BD6107=y
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> CONFIG_BACKLIGHT_LED=y
> # end of Backlight & LCD device support
> 
> CONFIG_VGASTATE=y
> CONFIG_VIDEOMODE_HELPERS=y
> CONFIG_HDMI=y
> # CONFIG_LOGO is not set
> # end of Graphics support
> 
> CONFIG_SOUND=y
> # CONFIG_SND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> # CONFIG_HIDRAW is not set
> CONFIG_UHID=y
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=y
> CONFIG_HID_ACRUX=y
> CONFIG_HID_ACRUX_FF=y
> CONFIG_HID_APPLE=y
> CONFIG_HID_AUREAL=y
> CONFIG_HID_BELKIN=y
> # CONFIG_HID_CHERRY is not set
> CONFIG_HID_CHICONY=y
> CONFIG_HID_CORSAIR=y
> # CONFIG_HID_COUGAR is not set
> # CONFIG_HID_MACALLY is not set
> CONFIG_HID_CMEDIA=y
> CONFIG_HID_CYPRESS=y
> CONFIG_HID_DRAGONRISE=y
> CONFIG_DRAGONRISE_FF=y
> # CONFIG_HID_EMS_FF is not set
> CONFIG_HID_ELECOM=y
> # CONFIG_HID_EZKEY is not set
> CONFIG_HID_GEMBIRD=y
> # CONFIG_HID_GFRM is not set
> CONFIG_HID_GLORIOUS=y
> CONFIG_HID_KEYTOUCH=y
> CONFIG_HID_KYE=y
> # CONFIG_HID_WALTOP is not set
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_GYRATION is not set
> CONFIG_HID_ICADE=y
> CONFIG_HID_ITE=y
> CONFIG_HID_JABRA=y
> CONFIG_HID_TWINHAN=y
> CONFIG_HID_KENSINGTON=y
> CONFIG_HID_LCPOWER=y
> CONFIG_HID_LED=y
> CONFIG_HID_LENOVO=y
> CONFIG_HID_LOGITECH=y
> CONFIG_HID_LOGITECH_HIDPP=y
> CONFIG_LOGITECH_FF=y
> # CONFIG_LOGIRUMBLEPAD2_FF is not set
> CONFIG_LOGIG940_FF=y
> CONFIG_LOGIWHEELS_FF=y
> CONFIG_HID_MAGICMOUSE=y
> # CONFIG_HID_MALTRON is not set
> CONFIG_HID_MAYFLASH=y
> CONFIG_HID_REDRAGON=y
> # CONFIG_HID_MICROSOFT is not set
> CONFIG_HID_MONTEREY=y
> CONFIG_HID_MULTITOUCH=y
> CONFIG_HID_NTI=y
> CONFIG_HID_ORTEK=y
> # CONFIG_HID_PANTHERLORD is not set
> # CONFIG_HID_PETALYNX is not set
> # CONFIG_HID_PICOLCD is not set
> # CONFIG_HID_PLANTRONICS is not set
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_SAITEK is not set
> CONFIG_HID_SAMSUNG=y
> CONFIG_HID_SPEEDLINK=y
> # CONFIG_HID_STEAM is not set
> CONFIG_HID_STEELSERIES=y
> CONFIG_HID_SUNPLUS=y
> CONFIG_HID_RMI=y
> CONFIG_HID_GREENASIA=y
> # CONFIG_GREENASIA_FF is not set
> CONFIG_HID_SMARTJOYPLUS=y
> CONFIG_SMARTJOYPLUS_FF=y
> # CONFIG_HID_TIVO is not set
> CONFIG_HID_TOPSEED=y
> CONFIG_HID_THINGM=y
> CONFIG_HID_THRUSTMASTER=y
> CONFIG_THRUSTMASTER_FF=y
> CONFIG_HID_UDRAW_PS3=y
> # CONFIG_HID_WIIMOTE is not set
> # CONFIG_HID_XINMO is not set
> # CONFIG_HID_ZEROPLUS is not set
> CONFIG_HID_ZYDACRON=y
> # CONFIG_HID_SENSOR_HUB is not set
> # CONFIG_HID_ALPS is not set
> # end of Special HID drivers
> 
> #
> # USB HID support
> #
> # CONFIG_USB_HID is not set
> CONFIG_HID_PID=y
> 
> #
> # USB HID Boot Protocol drivers
> #
> CONFIG_USB_KBD=y
> CONFIG_USB_MOUSE=y
> # end of USB HID Boot Protocol drivers
> # end of USB HID support
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID is not set
> # end of I2C HID support
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_ULPI_BUS=y
> CONFIG_USB_CONN_GPIO=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> # CONFIG_USB_PCI is not set
> # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> CONFIG_USB_DYNAMIC_MINORS=y
> CONFIG_USB_OTG=y
> # CONFIG_USB_OTG_WHITELIST is not set
> # CONFIG_USB_OTG_BLACKLIST_HUB is not set
> CONFIG_USB_OTG_FSM=y
> CONFIG_USB_AUTOSUSPEND_DELAY=2
> # CONFIG_USB_MON is not set
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_C67X00_HCD=y
> CONFIG_USB_XHCI_HCD=y
> # CONFIG_USB_XHCI_DBGCAP is not set
> CONFIG_USB_XHCI_PCI_RENESAS=y
> CONFIG_USB_XHCI_PLATFORM=y
> # CONFIG_USB_EHCI_HCD is not set
> # CONFIG_USB_OXU210HP_HCD is not set
> CONFIG_USB_ISP116X_HCD=y
> CONFIG_USB_FOTG210_HCD=y
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_SSB=y
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> # CONFIG_USB_U132_HCD is not set
> CONFIG_USB_SL811_HCD=y
> # CONFIG_USB_SL811_HCD_ISO is not set
> # CONFIG_USB_R8A66597_HCD is not set
> CONFIG_USB_HCD_BCMA=y
> CONFIG_USB_HCD_SSB=y
> # CONFIG_USB_HCD_TEST_MODE is not set
> 
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=y
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_WDM is not set
> CONFIG_USB_TMC=y
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USBIP_CORE is not set
> # CONFIG_USB_CDNS3 is not set
> CONFIG_USB_MUSB_HDRC=y
> CONFIG_USB_MUSB_HOST=y
> 
> #
> # Platform Glue Layer
> #
> 
> #
> # MUSB DMA mode
> #
> # CONFIG_MUSB_PIO_ONLY is not set
> CONFIG_USB_DWC3=y
> # CONFIG_USB_DWC3_ULPI is not set
> CONFIG_USB_DWC3_HOST=y
> 
> #
> # Platform Glue Driver Support
> #
> CONFIG_USB_DWC3_OF_SIMPLE=y
> CONFIG_USB_DWC2=y
> CONFIG_USB_DWC2_HOST=y
> 
> #
> # Gadget/Dual-role mode requires USB Gadget support to be enabled
> #
> CONFIG_USB_DWC2_DEBUG=y
> # CONFIG_USB_DWC2_VERBOSE is not set
> CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
> CONFIG_USB_DWC2_DEBUG_PERIODIC=y
> CONFIG_USB_ISP1760=y
> CONFIG_USB_ISP1760_HCD=y
> CONFIG_USB_ISP1760_HOST_ROLE=y
> 
> #
> # USB port drivers
> #
> # CONFIG_USB_SERIAL is not set
> 
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_EMI62=y
> CONFIG_USB_EMI26=y
> # CONFIG_USB_ADUTUX is not set
> CONFIG_USB_SEVSEG=y
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> CONFIG_USB_CYPRESS_CY7C63=y
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> CONFIG_USB_FTDI_ELAN=y
> CONFIG_USB_APPLEDISPLAY=y
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> CONFIG_USB_SISUSBVGA=y
> # CONFIG_USB_LD is not set
> CONFIG_USB_TRANCEVIBRATOR=y
> CONFIG_USB_IOWARRIOR=y
> # CONFIG_USB_TEST is not set
> CONFIG_USB_EHSET_TEST_FIXTURE=y
> CONFIG_USB_ISIGHTFW=y
> CONFIG_USB_YUREX=y
> CONFIG_USB_EZUSB_FX2=y
> CONFIG_USB_HUB_USB251XB=y
> CONFIG_USB_HSIC_USB3503=y
> CONFIG_USB_HSIC_USB4604=y
> # CONFIG_USB_LINK_LAYER_TEST is not set
> CONFIG_USB_CHAOSKEY=y
> 
> #
> # USB Physical Layer drivers
> #
> CONFIG_USB_PHY=y
> CONFIG_NOP_USB_XCEIV=y
> CONFIG_USB_GPIO_VBUS=y
> # CONFIG_TAHVO_USB is not set
> CONFIG_USB_ISP1301=y
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> CONFIG_TYPEC=y
> CONFIG_TYPEC_TCPM=y
> # CONFIG_TYPEC_TCPCI is not set
> CONFIG_TYPEC_FUSB302=y
> CONFIG_TYPEC_UCSI=y
> CONFIG_UCSI_CCG=y
> # CONFIG_UCSI_ACPI is not set
> CONFIG_TYPEC_HD3SS3220=y
> CONFIG_TYPEC_TPS6598X=y
> 
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> CONFIG_TYPEC_MUX_PI3USB30532=y
> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
> 
> #
> # USB Type-C Alternate Mode drivers
> #
> # CONFIG_TYPEC_DP_ALTMODE is not set
> # end of USB Type-C Alternate Mode drivers
> 
> CONFIG_USB_ROLE_SWITCH=y
> # CONFIG_USB_ROLES_INTEL_XHCI is not set
> CONFIG_MMC=y
> CONFIG_PWRSEQ_EMMC=y
> CONFIG_PWRSEQ_SIMPLE=y
> CONFIG_SDIO_UART=y
> # CONFIG_MMC_TEST is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=y
> CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> CONFIG_MMC_SDHCI_PCI=y
> # CONFIG_MMC_RICOH_MMC is not set
> # CONFIG_MMC_SDHCI_ACPI is not set
> CONFIG_MMC_SDHCI_PLTFM=y
> CONFIG_MMC_SDHCI_OF_ARASAN=y
> CONFIG_MMC_SDHCI_OF_ASPEED=y
> # CONFIG_MMC_SDHCI_OF_AT91 is not set
> # CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
> CONFIG_MMC_SDHCI_CADENCE=y
> # CONFIG_MMC_SDHCI_F_SDH30 is not set
> CONFIG_MMC_SDHCI_MILBEAUT=y
> # CONFIG_MMC_WBSD is not set
> CONFIG_MMC_TIFM_SD=y
> CONFIG_MMC_SPI=y
> CONFIG_MMC_CB710=y
> CONFIG_MMC_VIA_SDMMC=y
> # CONFIG_MMC_VUB300 is not set
> # CONFIG_MMC_USHC is not set
> CONFIG_MMC_USDHI6ROL0=y
> CONFIG_MMC_REALTEK_PCI=y
> CONFIG_MMC_REALTEK_USB=y
> CONFIG_MMC_CQHCI=y
> # CONFIG_MMC_HSQ is not set
> CONFIG_MMC_TOSHIBA_PCI=y
> # CONFIG_MMC_MTK is not set
> CONFIG_MMC_SDHCI_XENON=y
> CONFIG_MMC_SDHCI_OMAP=y
> CONFIG_MMC_SDHCI_AM654=y
> CONFIG_MEMSTICK=y
> CONFIG_MEMSTICK_DEBUG=y
> 
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> 
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_MEMSTICK_TIFM_MS=y
> CONFIG_MEMSTICK_JMICRON_38X=y
> CONFIG_MEMSTICK_R592=y
> CONFIG_MEMSTICK_REALTEK_PCI=y
> # CONFIG_MEMSTICK_REALTEK_USB is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> CONFIG_LEDS_CLASS_FLASH=y
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_AAT1290 is not set
> CONFIG_LEDS_AN30259A=y
> # CONFIG_LEDS_AS3645A is not set
> # CONFIG_LEDS_AW2013 is not set
> # CONFIG_LEDS_BCM6328 is not set
> # CONFIG_LEDS_BCM6358 is not set
> CONFIG_LEDS_CPCAP=y
> CONFIG_LEDS_CR0014114=y
> # CONFIG_LEDS_EL15203000 is not set
> CONFIG_LEDS_LM3530=y
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3533 is not set
> # CONFIG_LEDS_LM3642 is not set
> CONFIG_LEDS_LM3692X=y
> CONFIG_LEDS_LM3601X=y
> CONFIG_LEDS_NET48XX=y
> CONFIG_LEDS_WRAP=y
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=y
> CONFIG_LEDS_LP3952=y
> CONFIG_LEDS_LP55XX_COMMON=y
> CONFIG_LEDS_LP5521=y
> # CONFIG_LEDS_LP5523 is not set
> # CONFIG_LEDS_LP5562 is not set
> CONFIG_LEDS_LP8501=y
> CONFIG_LEDS_LP8860=y
> CONFIG_LEDS_PCA955X=y
> CONFIG_LEDS_PCA955X_GPIO=y
> CONFIG_LEDS_PCA963X=y
> CONFIG_LEDS_WM8350=y
> CONFIG_LEDS_DA9052=y
> # CONFIG_LEDS_DAC124S085 is not set
> CONFIG_LEDS_PWM=y
> # CONFIG_LEDS_REGULATOR is not set
> # CONFIG_LEDS_BD2802 is not set
> # CONFIG_LEDS_LT3593 is not set
> CONFIG_LEDS_MC13783=y
> CONFIG_LEDS_TCA6507=y
> CONFIG_LEDS_TLC591XX=y
> CONFIG_LEDS_MAX77693=y
> # CONFIG_LEDS_MAX8997 is not set
> # CONFIG_LEDS_LM355x is not set
> # CONFIG_LEDS_OT200 is not set
> # CONFIG_LEDS_KTD2692 is not set
> CONFIG_LEDS_IS31FL319X=y
> CONFIG_LEDS_IS31FL32XX=y
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=y
> CONFIG_LEDS_SYSCON=y
> # CONFIG_LEDS_MLXREG is not set
> CONFIG_LEDS_USER=y
> # CONFIG_LEDS_NIC78BX is not set
> CONFIG_LEDS_SPI_BYTE=y
> # CONFIG_LEDS_TI_LMU_COMMON is not set
> CONFIG_LEDS_SGM3140=y
> 
> #
> # LED Triggers
> #
> # CONFIG_LEDS_TRIGGERS is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> # CONFIG_EDAC is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> # CONFIG_RTC_HCTOSYS is not set
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> CONFIG_RTC_DRV_ABB5ZES3=y
> CONFIG_RTC_DRV_ABEOZ9=y
> CONFIG_RTC_DRV_ABX80X=y
> CONFIG_RTC_DRV_DS1307=y
> CONFIG_RTC_DRV_DS1307_CENTURY=y
> CONFIG_RTC_DRV_DS1374=y
> # CONFIG_RTC_DRV_DS1374_WDT is not set
> CONFIG_RTC_DRV_DS1672=y
> CONFIG_RTC_DRV_HYM8563=y
> CONFIG_RTC_DRV_MAX6900=y
> CONFIG_RTC_DRV_MAX8997=y
> CONFIG_RTC_DRV_MAX77686=y
> CONFIG_RTC_DRV_RS5C372=y
> # CONFIG_RTC_DRV_ISL1208 is not set
> # CONFIG_RTC_DRV_ISL12022 is not set
> CONFIG_RTC_DRV_ISL12026=y
> # CONFIG_RTC_DRV_X1205 is not set
> # CONFIG_RTC_DRV_PCF8523 is not set
> CONFIG_RTC_DRV_PCF85063=y
> # CONFIG_RTC_DRV_PCF85363 is not set
> # CONFIG_RTC_DRV_PCF8563 is not set
> # CONFIG_RTC_DRV_PCF8583 is not set
> CONFIG_RTC_DRV_M41T80=y
> # CONFIG_RTC_DRV_M41T80_WDT is not set
> CONFIG_RTC_DRV_BD70528=y
> # CONFIG_RTC_DRV_BQ32K is not set
> CONFIG_RTC_DRV_TWL4030=y
> CONFIG_RTC_DRV_PALMAS=y
> CONFIG_RTC_DRV_TPS6586X=y
> CONFIG_RTC_DRV_TPS65910=y
> # CONFIG_RTC_DRV_TPS80031 is not set
> CONFIG_RTC_DRV_RC5T583=y
> CONFIG_RTC_DRV_S35390A=y
> CONFIG_RTC_DRV_FM3130=y
> CONFIG_RTC_DRV_RX8010=y
> CONFIG_RTC_DRV_RX8581=y
> CONFIG_RTC_DRV_RX8025=y
> # CONFIG_RTC_DRV_EM3027 is not set
> # CONFIG_RTC_DRV_RV3028 is not set
> CONFIG_RTC_DRV_RV8803=y
> CONFIG_RTC_DRV_S5M=y
> # CONFIG_RTC_DRV_SD3078 is not set
> 
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> CONFIG_RTC_DRV_M41T94=y
> CONFIG_RTC_DRV_DS1302=y
> CONFIG_RTC_DRV_DS1305=y
> # CONFIG_RTC_DRV_DS1343 is not set
> CONFIG_RTC_DRV_DS1347=y
> CONFIG_RTC_DRV_DS1390=y
> CONFIG_RTC_DRV_MAX6916=y
> CONFIG_RTC_DRV_R9701=y
> CONFIG_RTC_DRV_RX4581=y
> CONFIG_RTC_DRV_RX6110=y
> CONFIG_RTC_DRV_RS5C348=y
> CONFIG_RTC_DRV_MAX6902=y
> # CONFIG_RTC_DRV_PCF2123 is not set
> CONFIG_RTC_DRV_MCP795=y
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS3232=y
> # CONFIG_RTC_DRV_DS3232_HWMON is not set
> # CONFIG_RTC_DRV_PCF2127 is not set
> # CONFIG_RTC_DRV_RV3029C2 is not set
> 
> #
> # Platform RTC drivers
> #
> # CONFIG_RTC_DRV_CMOS is not set
> CONFIG_RTC_DRV_DS1286=y
> CONFIG_RTC_DRV_DS1511=y
> # CONFIG_RTC_DRV_DS1553 is not set
> CONFIG_RTC_DRV_DS1685_FAMILY=y
> # CONFIG_RTC_DRV_DS1685 is not set
> # CONFIG_RTC_DRV_DS1689 is not set
> CONFIG_RTC_DRV_DS17285=y
> # CONFIG_RTC_DRV_DS17485 is not set
> # CONFIG_RTC_DRV_DS17885 is not set
> CONFIG_RTC_DRV_DS1742=y
> CONFIG_RTC_DRV_DS2404=y
> CONFIG_RTC_DRV_DA9052=y
> CONFIG_RTC_DRV_DA9063=y
> CONFIG_RTC_DRV_STK17TA8=y
> CONFIG_RTC_DRV_M48T86=y
> CONFIG_RTC_DRV_M48T35=y
> CONFIG_RTC_DRV_M48T59=y
> CONFIG_RTC_DRV_MSM6242=y
> CONFIG_RTC_DRV_BQ4802=y
> CONFIG_RTC_DRV_RP5C01=y
> CONFIG_RTC_DRV_V3020=y
> # CONFIG_RTC_DRV_WM8350 is not set
> # CONFIG_RTC_DRV_PCF50633 is not set
> CONFIG_RTC_DRV_ZYNQMP=y
> CONFIG_RTC_DRV_CROS_EC=y
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_CADENCE is not set
> # CONFIG_RTC_DRV_FTRTC010 is not set
> CONFIG_RTC_DRV_PCAP=y
> CONFIG_RTC_DRV_MC13XXX=y
> CONFIG_RTC_DRV_R7301=y
> # CONFIG_RTC_DRV_CPCAP is not set
> 
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_DMADEVICES is not set
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> CONFIG_SW_SYNC=y
> CONFIG_UDMABUF=y
> CONFIG_DMABUF_MOVE_NOTIFY=y
> CONFIG_DMABUF_SELFTESTS=y
> # CONFIG_DMABUF_HEAPS is not set
> # end of DMABUF options
> 
> CONFIG_AUXDISPLAY=y
> CONFIG_HD44780=y
> # CONFIG_IMG_ASCII_LCD is not set
> CONFIG_HT16K33=y
> CONFIG_PANEL_CHANGE_MESSAGE=y
> CONFIG_PANEL_BOOT_MESSAGE=""
> CONFIG_CHARLCD_BL_OFF=y
> # CONFIG_CHARLCD_BL_ON is not set
> # CONFIG_CHARLCD_BL_FLASH is not set
> CONFIG_CHARLCD=y
> CONFIG_UIO=y
> # CONFIG_UIO_CIF is not set
> CONFIG_UIO_PDRV_GENIRQ=y
> # CONFIG_UIO_DMEM_GENIRQ is not set
> # CONFIG_UIO_AEC is not set
> # CONFIG_UIO_SERCOS3 is not set
> CONFIG_UIO_PCI_GENERIC=y
> CONFIG_UIO_NETX=y
> CONFIG_UIO_PRUSS=y
> # CONFIG_UIO_MF624 is not set
> CONFIG_VFIO_IOMMU_TYPE1=y
> CONFIG_VFIO=y
> # CONFIG_VFIO_NOIOMMU is not set
> # CONFIG_VFIO_PCI is not set
> CONFIG_VFIO_MDEV=y
> # CONFIG_VFIO_MDEV_DEVICE is not set
> CONFIG_VIRT_DRIVERS=y
> CONFIG_VBOXGUEST=y
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_MENU=y
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_PCI_LEGACY=y
> CONFIG_VIRTIO_VDPA=y
> # CONFIG_VIRTIO_BALLOON is not set
> # CONFIG_VIRTIO_INPUT is not set
> CONFIG_VIRTIO_MMIO=y
> # CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
> CONFIG_VDPA=y
> CONFIG_VDPA_SIM=y
> CONFIG_IFCVF=y
> CONFIG_VHOST_IOTLB=y
> CONFIG_VHOST_RING=y
> # CONFIG_VHOST_MENU is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_HYPERV is not set
> # end of Microsoft Hyper-V guest support
> 
> CONFIG_GREYBUS=y
> CONFIG_GREYBUS_ES2=y
> CONFIG_STAGING=y
> CONFIG_COMEDI=y
> CONFIG_COMEDI_DEBUG=y
> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
> CONFIG_COMEDI_MISC_DRIVERS=y
> # CONFIG_COMEDI_BOND is not set
> CONFIG_COMEDI_TEST=y
> CONFIG_COMEDI_PARPORT=y
> CONFIG_COMEDI_SSV_DNP=y
> CONFIG_COMEDI_ISA_DRIVERS=y
> # CONFIG_COMEDI_PCL711 is not set
> CONFIG_COMEDI_PCL724=y
> CONFIG_COMEDI_PCL726=y
> CONFIG_COMEDI_PCL730=y
> CONFIG_COMEDI_PCL812=y
> CONFIG_COMEDI_PCL816=y
> CONFIG_COMEDI_PCL818=y
> # CONFIG_COMEDI_PCM3724 is not set
> # CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
> # CONFIG_COMEDI_AMPLC_PC236_ISA is not set
> CONFIG_COMEDI_AMPLC_PC263_ISA=y
> # CONFIG_COMEDI_RTI800 is not set
> CONFIG_COMEDI_RTI802=y
> # CONFIG_COMEDI_DAC02 is not set
> CONFIG_COMEDI_DAS16M1=y
> # CONFIG_COMEDI_DAS08_ISA is not set
> CONFIG_COMEDI_DAS16=y
> CONFIG_COMEDI_DAS800=y
> # CONFIG_COMEDI_DAS1800 is not set
> CONFIG_COMEDI_DAS6402=y
> CONFIG_COMEDI_DT2801=y
> # CONFIG_COMEDI_DT2811 is not set
> CONFIG_COMEDI_DT2814=y
> CONFIG_COMEDI_DT2815=y
> CONFIG_COMEDI_DT2817=y
> # CONFIG_COMEDI_DT282X is not set
> # CONFIG_COMEDI_DMM32AT is not set
> CONFIG_COMEDI_FL512=y
> # CONFIG_COMEDI_AIO_AIO12_8 is not set
> # CONFIG_COMEDI_AIO_IIRO_16 is not set
> # CONFIG_COMEDI_II_PCI20KC is not set
> # CONFIG_COMEDI_C6XDIGIO is not set
> # CONFIG_COMEDI_MPC624 is not set
> CONFIG_COMEDI_ADQ12B=y
> # CONFIG_COMEDI_NI_AT_A2150 is not set
> CONFIG_COMEDI_NI_AT_AO=y
> CONFIG_COMEDI_NI_ATMIO=y
> CONFIG_COMEDI_NI_ATMIO16D=y
> # CONFIG_COMEDI_NI_LABPC_ISA is not set
> CONFIG_COMEDI_PCMAD=y
> CONFIG_COMEDI_PCMDA12=y
> CONFIG_COMEDI_PCMMIO=y
> CONFIG_COMEDI_PCMUIO=y
> # CONFIG_COMEDI_MULTIQ3 is not set
> CONFIG_COMEDI_S526=y
> # CONFIG_COMEDI_PCI_DRIVERS is not set
> CONFIG_COMEDI_USB_DRIVERS=y
> CONFIG_COMEDI_DT9812=y
> CONFIG_COMEDI_NI_USB6501=y
> CONFIG_COMEDI_USBDUX=y
> CONFIG_COMEDI_USBDUXFAST=y
> CONFIG_COMEDI_USBDUXSIGMA=y
> CONFIG_COMEDI_VMK80XX=y
> CONFIG_COMEDI_8254=y
> CONFIG_COMEDI_8255=y
> CONFIG_COMEDI_8255_SA=y
> CONFIG_COMEDI_KCOMEDILIB=y
> CONFIG_COMEDI_ISADMA=y
> CONFIG_COMEDI_NI_TIO=y
> CONFIG_COMEDI_NI_ROUTING=y
> # CONFIG_RTL8192U is not set
> # CONFIG_RTLLIB is not set
> # CONFIG_R8712U is not set
> # CONFIG_FB_SM750 is not set
> 
> #
> # Speakup console speech
> #
> # end of Speakup console speech
> 
> CONFIG_STAGING_MEDIA=y
> CONFIG_VIDEO_IPU3_IMGU=y
> 
> #
> # soc_camera sensor drivers
> #
> 
> #
> # Android
> #
> # end of Android
> 
> CONFIG_STAGING_BOARD=y
> # CONFIG_LTE_GDM724X is not set
> # CONFIG_GS_FPGABOOT is not set
> CONFIG_UNISYSSPAR=y
> CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
> CONFIG_FB_TFT=y
> CONFIG_FB_TFT_AGM1264K_FL=y
> CONFIG_FB_TFT_BD663474=y
> # CONFIG_FB_TFT_HX8340BN is not set
> # CONFIG_FB_TFT_HX8347D is not set
> CONFIG_FB_TFT_HX8353D=y
> # CONFIG_FB_TFT_HX8357D is not set
> # CONFIG_FB_TFT_ILI9163 is not set
> CONFIG_FB_TFT_ILI9320=y
> CONFIG_FB_TFT_ILI9325=y
> # CONFIG_FB_TFT_ILI9340 is not set
> # CONFIG_FB_TFT_ILI9341 is not set
> CONFIG_FB_TFT_ILI9481=y
> CONFIG_FB_TFT_ILI9486=y
> CONFIG_FB_TFT_PCD8544=y
> # CONFIG_FB_TFT_RA8875 is not set
> # CONFIG_FB_TFT_S6D02A1 is not set
> CONFIG_FB_TFT_S6D1121=y
> CONFIG_FB_TFT_SEPS525=y
> CONFIG_FB_TFT_SH1106=y
> CONFIG_FB_TFT_SSD1289=y
> # CONFIG_FB_TFT_SSD1305 is not set
> # CONFIG_FB_TFT_SSD1306 is not set
> CONFIG_FB_TFT_SSD1331=y
> CONFIG_FB_TFT_SSD1351=y
> CONFIG_FB_TFT_ST7735R=y
> CONFIG_FB_TFT_ST7789V=y
> CONFIG_FB_TFT_TINYLCD=y
> CONFIG_FB_TFT_TLS8204=y
> CONFIG_FB_TFT_UC1611=y
> CONFIG_FB_TFT_UC1701=y
> # CONFIG_FB_TFT_UPD161704 is not set
> CONFIG_FB_TFT_WATTEROTT=y
> # CONFIG_KS7010 is not set
> CONFIG_GREYBUS_AUDIO=y
> # CONFIG_GREYBUS_BOOTROM is not set
> CONFIG_GREYBUS_FIRMWARE=y
> CONFIG_GREYBUS_HID=y
> # CONFIG_GREYBUS_LIGHT is not set
> CONFIG_GREYBUS_LOG=y
> CONFIG_GREYBUS_LOOPBACK=y
> CONFIG_GREYBUS_POWER=y
> CONFIG_GREYBUS_RAW=y
> CONFIG_GREYBUS_VIBRATOR=y
> # CONFIG_GREYBUS_BRIDGED_PHY is not set
> CONFIG_PI433=y
> 
> #
> # Gasket devices
> #
> # end of Gasket devices
> 
> # CONFIG_XIL_AXIS_FIFO is not set
> CONFIG_FIELDBUS_DEV=y
> CONFIG_HMS_ANYBUSS_BUS=y
> CONFIG_ARCX_ANYBUS_CONTROLLER=y
> CONFIG_HMS_PROFINET=y
> # CONFIG_KPC2000 is not set
> # CONFIG_QLGE is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> CONFIG_ACPI_WMI=y
> CONFIG_WMI_BMOF=y
> # CONFIG_ALIENWARE_WMI is not set
> # CONFIG_HUAWEI_WMI is not set
> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
> # CONFIG_INTEL_WMI_THUNDERBOLT is not set
> CONFIG_MXM_WMI=y
> # CONFIG_PEAQ_WMI is not set
> # CONFIG_XIAOMI_WMI is not set
> # CONFIG_ACERHDF is not set
> # CONFIG_ACER_WIRELESS is not set
> # CONFIG_ACER_WMI is not set
> # CONFIG_APPLE_GMUX is not set
> # CONFIG_ASUS_LAPTOP is not set
> # CONFIG_ASUS_WIRELESS is not set
> # CONFIG_ASUS_WMI is not set
> # CONFIG_EEEPC_LAPTOP is not set
> # CONFIG_DCDBAS is not set
> # CONFIG_DELL_SMBIOS is not set
> # CONFIG_DELL_RBU is not set
> # CONFIG_DELL_SMO8800 is not set
> # CONFIG_DELL_WMI_AIO is not set
> # CONFIG_DELL_WMI_LED is not set
> # CONFIG_FUJITSU_LAPTOP is not set
> # CONFIG_FUJITSU_TABLET is not set
> # CONFIG_GPD_POCKET_FAN is not set
> # CONFIG_HP_ACCEL is not set
> # CONFIG_HP_WIRELESS is not set
> # CONFIG_HP_WMI is not set
> # CONFIG_TC1100_WMI is not set
> # CONFIG_IBM_RTL is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_THINKPAD_ACPI is not set
> # CONFIG_INTEL_ATOMISP2_PM is not set
> # CONFIG_INTEL_HID_EVENT is not set
> # CONFIG_INTEL_INT0002_VGPIO is not set
> # CONFIG_INTEL_MENLOW is not set
> # CONFIG_INTEL_VBTN is not set
> # CONFIG_SURFACE_3_BUTTON is not set
> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> # CONFIG_MSI_WMI is not set
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_SAMSUNG_LAPTOP is not set
> # CONFIG_SAMSUNG_Q10 is not set
> # CONFIG_TOSHIBA_BT_RFKILL is not set
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> # CONFIG_ACPI_CMPC is not set
> # CONFIG_LG_LAPTOP is not set
> # CONFIG_PANASONIC_LAPTOP is not set
> # CONFIG_SYSTEM76_ACPI is not set
> # CONFIG_TOPSTAR_LAPTOP is not set
> # CONFIG_I2C_MULTI_INSTANTIATE is not set
> # CONFIG_MLX_PLATFORM is not set
> # CONFIG_INTEL_IPS is not set
> # CONFIG_INTEL_RST is not set
> # CONFIG_INTEL_SMARTCONNECT is not set
> # CONFIG_INTEL_PMC_CORE is not set
> # CONFIG_INTEL_PUNIT_IPC is not set
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> CONFIG_PMC_ATOM=y
> CONFIG_MFD_CROS_EC=y
> CONFIG_CHROME_PLATFORMS=y
> CONFIG_CHROMEOS_PSTORE=y
> # CONFIG_CHROMEOS_TBMC is not set
> CONFIG_CROS_EC=y
> CONFIG_CROS_EC_I2C=y
> # CONFIG_CROS_EC_RPMSG is not set
> CONFIG_CROS_EC_SPI=y
> # CONFIG_CROS_EC_LPC is not set
> CONFIG_CROS_EC_PROTO=y
> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
> CONFIG_CROS_EC_CHARDEV=y
> CONFIG_CROS_EC_LIGHTBAR=y
> CONFIG_CROS_EC_VBC=y
> # CONFIG_CROS_EC_DEBUGFS is not set
> # CONFIG_CROS_EC_SENSORHUB is not set
> CONFIG_CROS_EC_SYSFS=y
> CONFIG_CROS_EC_TYPEC=y
> CONFIG_CROS_USBPD_NOTIFY=y
> CONFIG_MELLANOX_PLATFORM=y
> CONFIG_MLXREG_HOTPLUG=y
> CONFIG_MLXREG_IO=y
> CONFIG_HAVE_CLK=y
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> CONFIG_COMMON_CLK_MAX77686=y
> CONFIG_COMMON_CLK_MAX9485=y
> CONFIG_COMMON_CLK_SI5341=y
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI514 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> CONFIG_COMMON_CLK_SI570=y
> CONFIG_COMMON_CLK_CDCE706=y
> CONFIG_COMMON_CLK_CDCE925=y
> CONFIG_COMMON_CLK_CS2000_CP=y
> CONFIG_COMMON_CLK_S2MPS11=y
> # CONFIG_CLK_TWL6040 is not set
> # CONFIG_COMMON_CLK_PALMAS is not set
> # CONFIG_COMMON_CLK_PWM is not set
> # CONFIG_COMMON_CLK_VC5 is not set
> CONFIG_COMMON_CLK_BD718XX=y
> # CONFIG_COMMON_CLK_FIXED_MMIO is not set
> # CONFIG_CLK_LGM_CGU is not set
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKSRC_I8253=y
> CONFIG_CLKEVT_I8253=y
> CONFIG_CLKBLD_I8253=y
> # CONFIG_MICROCHIP_PIT64B is not set
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> # CONFIG_PLATFORM_MHU is not set
> # CONFIG_PCC is not set
> CONFIG_ALTERA_MBOX=y
> CONFIG_MAILBOX_TEST=y
> CONFIG_IOMMU_IOVA=y
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
> 
> CONFIG_IOMMU_DEBUGFS=y
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_OF_IOMMU=y
> # CONFIG_INTEL_IOMMU is not set
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> # CONFIG_RPMSG_CHAR is not set
> CONFIG_RPMSG_QCOM_GLINK=y
> CONFIG_RPMSG_QCOM_GLINK_RPM=y
> CONFIG_RPMSG_VIRTIO=y
> # end of Rpmsg drivers
> 
> CONFIG_SOUNDWIRE=y
> 
> #
> # SoundWire Devices
> #
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Aspeed SoC drivers
> #
> # end of Aspeed SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> CONFIG_XILINX_VCU=y
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> CONFIG_PM_DEVFREQ=y
> 
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> # CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
> CONFIG_DEVFREQ_GOV_POWERSAVE=y
> CONFIG_DEVFREQ_GOV_USERSPACE=y
> CONFIG_DEVFREQ_GOV_PASSIVE=y
> 
> #
> # DEVFREQ Drivers
> #
> CONFIG_PM_DEVFREQ_EVENT=y
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> # CONFIG_EXTCON_FSA9480 is not set
> CONFIG_EXTCON_GPIO=y
> # CONFIG_EXTCON_INTEL_INT3496 is not set
> # CONFIG_EXTCON_MAX14577 is not set
> CONFIG_EXTCON_MAX3355=y
> CONFIG_EXTCON_MAX77693=y
> # CONFIG_EXTCON_MAX8997 is not set
> CONFIG_EXTCON_PALMAS=y
> CONFIG_EXTCON_PTN5150=y
> CONFIG_EXTCON_RT8973A=y
> CONFIG_EXTCON_SM5502=y
> CONFIG_EXTCON_USB_GPIO=y
> CONFIG_EXTCON_USBC_CROS_EC=y
> CONFIG_MEMORY=y
> # CONFIG_IIO is not set
> CONFIG_NTB=y
> CONFIG_NTB_MSI=y
> # CONFIG_NTB_IDT is not set
> CONFIG_NTB_SWITCHTEC=y
> CONFIG_NTB_PINGPONG=y
> # CONFIG_NTB_TOOL is not set
> # CONFIG_NTB_PERF is not set
> CONFIG_NTB_MSI_TEST=y
> CONFIG_NTB_TRANSPORT=y
> # CONFIG_VME_BUS is not set
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> # CONFIG_PWM_DEBUG is not set
> CONFIG_PWM_ATMEL_HLCDC_PWM=y
> CONFIG_PWM_CROS_EC=y
> CONFIG_PWM_FSL_FTM=y
> CONFIG_PWM_LP3943=y
> CONFIG_PWM_LPSS=y
> CONFIG_PWM_LPSS_PCI=y
> # CONFIG_PWM_LPSS_PLATFORM is not set
> CONFIG_PWM_PCA9685=y
> # CONFIG_PWM_STMPE is not set
> CONFIG_PWM_TWL=y
> CONFIG_PWM_TWL_LED=y
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> CONFIG_AL_FIC=y
> # end of IRQ chip support
> 
> CONFIG_IPACK_BUS=y
> # CONFIG_BOARD_TPCI200 is not set
> CONFIG_SERIAL_IPOCTAL=y
> CONFIG_RESET_CONTROLLER=y
> CONFIG_RESET_BRCMSTB_RESCAL=y
> # CONFIG_RESET_INTEL_GW is not set
> CONFIG_RESET_TI_SYSCON=y
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> CONFIG_GENERIC_PHY_MIPI_DPHY=y
> CONFIG_BCM_KONA_USB2_PHY=y
> # CONFIG_PHY_CADENCE_TORRENT is not set
> CONFIG_PHY_CADENCE_DPHY=y
> CONFIG_PHY_CADENCE_SIERRA=y
> CONFIG_PHY_CADENCE_SALVO=y
> # CONFIG_PHY_FSL_IMX8MQ_USB is not set
> CONFIG_PHY_MIXEL_MIPI_DPHY=y
> CONFIG_PHY_PXA_28NM_HSIC=y
> CONFIG_PHY_PXA_28NM_USB2=y
> CONFIG_PHY_MAPPHONE_MDM6600=y
> CONFIG_PHY_OCELOT_SERDES=y
> # CONFIG_PHY_QCOM_USB_HS is not set
> CONFIG_PHY_QCOM_USB_HSIC=y
> CONFIG_PHY_SAMSUNG_USB2=y
> # CONFIG_PHY_TUSB1210 is not set
> # CONFIG_PHY_INTEL_COMBO is not set
> # CONFIG_PHY_INTEL_EMMC is not set
> # end of PHY Subsystem
> 
> CONFIG_POWERCAP=y
> CONFIG_INTEL_RAPL_CORE=y
> CONFIG_INTEL_RAPL=y
> # CONFIG_IDLE_INJECT is not set
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> CONFIG_RAS=y
> CONFIG_USB4=y
> 
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # end of Android
> 
> CONFIG_DAX=y
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> CONFIG_NVMEM_SPMI_SDAM=y
> 
> #
> # HW tracing support
> #
> CONFIG_STM=y
> CONFIG_STM_PROTO_BASIC=y
> # CONFIG_STM_PROTO_SYS_T is not set
> CONFIG_STM_DUMMY=y
> CONFIG_STM_SOURCE_CONSOLE=y
> CONFIG_STM_SOURCE_HEARTBEAT=y
> CONFIG_INTEL_TH=y
> CONFIG_INTEL_TH_PCI=y
> # CONFIG_INTEL_TH_ACPI is not set
> CONFIG_INTEL_TH_GTH=y
> CONFIG_INTEL_TH_STH=y
> CONFIG_INTEL_TH_MSU=y
> # CONFIG_INTEL_TH_PTI is not set
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
> 
> CONFIG_FPGA=y
> CONFIG_ALTERA_PR_IP_CORE=y
> CONFIG_ALTERA_PR_IP_CORE_PLAT=y
> CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
> # CONFIG_FPGA_MGR_ALTERA_CVP is not set
> CONFIG_FPGA_MGR_XILINX_SPI=y
> CONFIG_FPGA_MGR_ICE40_SPI=y
> CONFIG_FPGA_MGR_MACHXO2_SPI=y
> CONFIG_FPGA_BRIDGE=y
> CONFIG_ALTERA_FREEZE_BRIDGE=y
> CONFIG_XILINX_PR_DECOUPLER=y
> CONFIG_FPGA_REGION=y
> CONFIG_OF_FPGA_REGION=y
> # CONFIG_FPGA_DFL is not set
> CONFIG_FSI=y
> CONFIG_FSI_NEW_DEV_NODE=y
> # CONFIG_FSI_MASTER_GPIO is not set
> # CONFIG_FSI_MASTER_HUB is not set
> CONFIG_FSI_MASTER_ASPEED=y
> # CONFIG_FSI_SCOM is not set
> CONFIG_FSI_SBEFIFO=y
> CONFIG_FSI_OCC=y
> CONFIG_TEE=y
> 
> #
> # TEE drivers
> #
> # end of TEE drivers
> 
> CONFIG_MULTIPLEXER=y
> 
> #
> # Multiplexer drivers
> #
> CONFIG_MUX_ADG792A=y
> CONFIG_MUX_ADGS1408=y
> CONFIG_MUX_GPIO=y
> CONFIG_MUX_MMIO=y
> # end of Multiplexer drivers
> 
> CONFIG_PM_OPP=y
> CONFIG_SIOX=y
> CONFIG_SIOX_BUS_GPIO=y
> CONFIG_SLIMBUS=y
> # CONFIG_SLIM_QCOM_CTRL is not set
> CONFIG_INTERCONNECT=y
> CONFIG_COUNTER=y
> CONFIG_FTM_QUADDEC=y
> # CONFIG_MOST is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> # CONFIG_EXPORTFS_BLOCK_OPS is not set
> CONFIG_FILE_LOCKING=y
> CONFIG_MANDATORY_FILE_LOCKING=y
> # CONFIG_FS_ENCRYPTION is not set
> CONFIG_FS_VERITY=y
> # CONFIG_FS_VERITY_DEBUG is not set
> # CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> # CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS4_FS is not set
> CONFIG_AUTOFS_FS=y
> # CONFIG_FUSE_FS is not set
> CONFIG_OVERLAY_FS=y
> CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> # CONFIG_OVERLAY_FS_INDEX is not set
> # CONFIG_OVERLAY_FS_METACOPY is not set
> 
> #
> # Caches
> #
> CONFIG_FSCACHE=y
> # CONFIG_FSCACHE_STATS is not set
> # CONFIG_FSCACHE_HISTOGRAM is not set
> # CONFIG_FSCACHE_DEBUG is not set
> # CONFIG_FSCACHE_OBJECT_LIST is not set
> # end of Caches
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_KCORE is not set
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> # CONFIG_PROC_CHILDREN is not set
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> # CONFIG_HUGETLBFS is not set
> CONFIG_MEMFD_CREATE=y
> CONFIG_CONFIGFS_FS=y
> # end of Pseudo filesystems
> 
> # CONFIG_MISC_FILESYSTEMS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=m
> # CONFIG_NFS_V4_1 is not set
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFS_FSCACHE is not set
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=m
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=m
> # CONFIG_CIFS_STATS2 is not set
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> # CONFIG_CIFS_WEAK_PW_HASH is not set
> # CONFIG_CIFS_UPCALL is not set
> # CONFIG_CIFS_XATTR is not set
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CIFS_FSCACHE is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_CODEPAGE_737=y
> CONFIG_NLS_CODEPAGE_775=y
> CONFIG_NLS_CODEPAGE_850=y
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> CONFIG_NLS_CODEPAGE_857=y
> CONFIG_NLS_CODEPAGE_860=y
> CONFIG_NLS_CODEPAGE_861=y
> CONFIG_NLS_CODEPAGE_862=y
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> CONFIG_NLS_CODEPAGE_865=y
> CONFIG_NLS_CODEPAGE_866=y
> CONFIG_NLS_CODEPAGE_869=y
> CONFIG_NLS_CODEPAGE_936=y
> CONFIG_NLS_CODEPAGE_950=y
> CONFIG_NLS_CODEPAGE_932=y
> CONFIG_NLS_CODEPAGE_949=y
> CONFIG_NLS_CODEPAGE_874=y
> CONFIG_NLS_ISO8859_8=y
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=y
> CONFIG_NLS_ISO8859_2=y
> # CONFIG_NLS_ISO8859_3 is not set
> CONFIG_NLS_ISO8859_4=y
> # CONFIG_NLS_ISO8859_5 is not set
> CONFIG_NLS_ISO8859_6=y
> CONFIG_NLS_ISO8859_7=y
> CONFIG_NLS_ISO8859_9=y
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=y
> CONFIG_NLS_KOI8_R=y
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_MAC_ROMAN is not set
> # CONFIG_NLS_MAC_CELTIC is not set
> CONFIG_NLS_MAC_CENTEURO=y
> CONFIG_NLS_MAC_CROATIAN=y
> CONFIG_NLS_MAC_CYRILLIC=y
> # CONFIG_NLS_MAC_GAELIC is not set
> # CONFIG_NLS_MAC_GREEK is not set
> CONFIG_NLS_MAC_ICELAND=y
> CONFIG_NLS_MAC_INUIT=y
> # CONFIG_NLS_MAC_ROMANIAN is not set
> CONFIG_NLS_MAC_TURKISH=y
> # CONFIG_NLS_UTF8 is not set
> # CONFIG_DLM is not set
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=y
> CONFIG_BIG_KEYS=y
> CONFIG_TRUSTED_KEYS=y
> CONFIG_ENCRYPTED_KEYS=y
> CONFIG_KEY_DH_OPERATIONS=y
> # CONFIG_KEY_NOTIFICATIONS is not set
> CONFIG_SECURITY_DMESG_RESTRICT=y
> CONFIG_SECURITY=y
> CONFIG_SECURITYFS=y
> # CONFIG_SECURITY_NETWORK is not set
> CONFIG_PAGE_TABLE_ISOLATION=y
> CONFIG_SECURITY_PATH=y
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_HARDENED_USERCOPY_FALLBACK=y
> CONFIG_HARDENED_USERCOPY_PAGESPAN=y
> # CONFIG_FORTIFY_SOURCE is not set
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> # CONFIG_SECURITY_YAMA is not set
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> CONFIG_INTEGRITY=y
> CONFIG_INTEGRITY_SIGNATURE=y
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> CONFIG_IMA=y
> CONFIG_IMA_MEASURE_PCR_IDX=10
> CONFIG_IMA_TEMPLATE=y
> # CONFIG_IMA_NG_TEMPLATE is not set
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE="ima"
> CONFIG_IMA_DEFAULT_HASH_SHA1=y
> CONFIG_IMA_DEFAULT_HASH="sha1"
> # CONFIG_IMA_WRITE_POLICY is not set
> CONFIG_IMA_READ_POLICY=y
> # CONFIG_IMA_APPRAISE is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> CONFIG_EVM=y
> CONFIG_EVM_ATTR_FSUUID=y
> # CONFIG_EVM_ADD_XATTRS is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> CONFIG_INIT_ON_FREE_DEFAULT_ON=y
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
> CONFIG_CRYPTO_SIMD=y
> CONFIG_CRYPTO_ENGINE=y
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_ECC=y
> # CONFIG_CRYPTO_ECDH is not set
> CONFIG_CRYPTO_ECRDSA=y
> # CONFIG_CRYPTO_CURVE25519 is not set
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=m
> CONFIG_CRYPTO_GCM=m
> CONFIG_CRYPTO_CHACHA20POLY1305=y
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_SEQIV is not set
> # CONFIG_CRYPTO_ECHAINIV is not set
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=y
> CONFIG_CRYPTO_OFB=y
> CONFIG_CRYPTO_PCBC=y
> CONFIG_CRYPTO_XTS=y
> # CONFIG_CRYPTO_KEYWRAP is not set
> CONFIG_CRYPTO_NHPOLY1305=y
> CONFIG_CRYPTO_ADIANTUM=y
> # CONFIG_CRYPTO_ESSIV is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_XCBC is not set
> CONFIG_CRYPTO_VMAC=y
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=y
> CONFIG_CRYPTO_CRC32=y
> CONFIG_CRYPTO_CRC32_PCLMUL=y
> # CONFIG_CRYPTO_XXHASH is not set
> CONFIG_CRYPTO_BLAKE2B=y
> CONFIG_CRYPTO_BLAKE2S=y
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_GHASH=m
> CONFIG_CRYPTO_POLY1305=y
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> CONFIG_CRYPTO_RMD128=y
> # CONFIG_CRYPTO_RMD160 is not set
> CONFIG_CRYPTO_RMD256=y
> CONFIG_CRYPTO_RMD320=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=y
> CONFIG_CRYPTO_SM3=y
> CONFIG_CRYPTO_STREEBOG=y
> CONFIG_CRYPTO_TGR192=y
> # CONFIG_CRYPTO_WP512 is not set
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=y
> CONFIG_CRYPTO_AES_NI_INTEL=y
> CONFIG_CRYPTO_ANUBIS=y
> # CONFIG_CRYPTO_ARC4 is not set
> CONFIG_CRYPTO_BLOWFISH=y
> CONFIG_CRYPTO_BLOWFISH_COMMON=y
> CONFIG_CRYPTO_CAMELLIA=y
> CONFIG_CRYPTO_CAST_COMMON=y
> # CONFIG_CRYPTO_CAST5 is not set
> CONFIG_CRYPTO_CAST6=y
> CONFIG_CRYPTO_DES=y
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_KHAZAD is not set
> CONFIG_CRYPTO_SALSA20=y
> CONFIG_CRYPTO_CHACHA20=y
> CONFIG_CRYPTO_SEED=y
> CONFIG_CRYPTO_SERPENT=y
> # CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
> CONFIG_CRYPTO_SM4=y
> CONFIG_CRYPTO_TEA=y
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> CONFIG_CRYPTO_TWOFISH_586=y
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_842=y
> CONFIG_CRYPTO_LZ4=y
> # CONFIG_CRYPTO_LZ4HC is not set
> CONFIG_CRYPTO_ZSTD=y
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=y
> # CONFIG_CRYPTO_DRBG_MENU is not set
> CONFIG_CRYPTO_JITTERENTROPY=y
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> CONFIG_CRYPTO_HASH_INFO=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_ARC4=m
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> CONFIG_CRYPTO_LIB_BLAKE2S=y
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> CONFIG_CRYPTO_LIB_CURVE25519=y
> CONFIG_CRYPTO_LIB_DES=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> CONFIG_CRYPTO_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
> CONFIG_CRYPTO_LIB_SHA256=y
> CONFIG_CRYPTO_HW=y
> CONFIG_CRYPTO_DEV_PADLOCK=y
> CONFIG_CRYPTO_DEV_PADLOCK_AES=y
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
> CONFIG_CRYPTO_DEV_GEODE=y
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> CONFIG_CRYPTO_DEV_CCP=y
> CONFIG_CRYPTO_DEV_CCP_DD=y
> CONFIG_CRYPTO_DEV_QAT=y
> # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> CONFIG_CRYPTO_DEV_QAT_C3XXX=y
> CONFIG_CRYPTO_DEV_QAT_C62X=y
> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
> # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> CONFIG_CRYPTO_DEV_QAT_C62XVF=y
> CONFIG_CRYPTO_DEV_VIRTIO=y
> CONFIG_CRYPTO_DEV_SAFEXCEL=y
> # CONFIG_CRYPTO_DEV_CCREE is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
> CONFIG_TPM_KEY_PARSER=y
> # CONFIG_PKCS7_MESSAGE_PARSER is not set
> 
> #
> # Certificates for signature checking
> #
> # CONFIG_SYSTEM_TRUSTED_KEYRING is not set
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> # end of Certificates for signature checking
> 
> #
> # Library routines
> #
> CONFIG_LINEAR_RANGES=y
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> CONFIG_CORDIC=y
> CONFIG_PRIME_NUMBERS=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> # CONFIG_CRC_CCITT is not set
> CONFIG_CRC16=y
> # CONFIG_CRC_T10DIF is not set
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> # CONFIG_CRC32_SLICEBY8 is not set
> CONFIG_CRC32_SLICEBY4=y
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC64 is not set
> CONFIG_CRC4=y
> CONFIG_CRC7=y
> # CONFIG_LIBCRC32C is not set
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> CONFIG_RANDOM32_SELFTEST=y
> CONFIG_842_COMPRESS=y
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> # CONFIG_XZ_DEC_X86 is not set
> # CONFIG_XZ_DEC_POWERPC is not set
> CONFIG_XZ_DEC_IA64=y
> # CONFIG_XZ_DEC_ARM is not set
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_BCH=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_SWIOTLB=y
> CONFIG_DMA_CMA=y
> 
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_PERCENTAGE=0
> # CONFIG_CMA_SIZE_SEL_MBYTES is not set
> CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=8
> # CONFIG_DMA_API_DEBUG is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_DQL=y
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_SIGNATURE=y
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_32=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_FONT_SUPPORT=y
> CONFIG_FONT_8x16=y
> CONFIG_FONT_AUTOSELECT=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_STRING_SELFTEST=y
> # end of Library routines
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> # CONFIG_PRINTK_CALLER is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> CONFIG_SYMBOLIC_ERRNAME=y
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_ENABLE_MUST_CHECK=y
> CONFIG_FRAME_WARN=8192
> CONFIG_STRIP_ASM_SYMS=y
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_FRAME_POINTER=y
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> # CONFIG_MAGIC_SYSRQ_SERIAL is not set
> CONFIG_DEBUG_FS=y
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> CONFIG_UBSAN_TRAP=y
> # CONFIG_UBSAN_BOUNDS is not set
> # CONFIG_UBSAN_MISC is not set
> # CONFIG_UBSAN_SANITIZE_ALL is not set
> # CONFIG_TEST_UBSAN is not set
> # end of Generic Kernel Debugging Instruments
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> CONFIG_DEBUG_PAGEALLOC=y
> # CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
> CONFIG_PAGE_OWNER=y
> CONFIG_PAGE_POISONING=y
> # CONFIG_PAGE_POISONING_NO_SANITY is not set
> # CONFIG_PAGE_POISONING_ZERO is not set
> CONFIG_DEBUG_RODATA_TEST=y
> CONFIG_ARCH_HAS_DEBUG_WX=y
> CONFIG_DEBUG_WX=y
> CONFIG_GENERIC_PTDUMP=y
> CONFIG_PTDUMP_CORE=y
> CONFIG_PTDUMP_DEBUGFS=y
> CONFIG_DEBUG_OBJECTS=y
> CONFIG_DEBUG_OBJECTS_SELFTEST=y
> CONFIG_DEBUG_OBJECTS_FREE=y
> # CONFIG_DEBUG_OBJECTS_TIMERS is not set
> CONFIG_DEBUG_OBJECTS_WORK=y
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> # CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> CONFIG_SCHED_STACK_END_CHECK=y
> # CONFIG_DEBUG_VM is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_KASAN_STACK=1
> # end of Memory Debugging
> 
> # CONFIG_DEBUG_SHIRQ is not set
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=0
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> # CONFIG_DETECT_HUNG_TASK is not set
> CONFIG_WQ_WATCHDOG=y
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=y
> # CONFIG_SCHEDSTATS is not set
> # end of Scheduler Debugging
> 
> # CONFIG_DEBUG_TIMEKEEPING is not set
> CONFIG_DEBUG_PREEMPT=y
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> # CONFIG_PROVE_LOCKING is not set
> CONFIG_LOCK_STAT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> # CONFIG_DEBUG_RWSEMS is not set
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> CONFIG_LOCK_TORTURE_TEST=y
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_STACKTRACE=y
> CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=y
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> CONFIG_DEBUG_NOTIFIERS=y
> CONFIG_BUG_ON_DATA_CORRUPTION=y
> # end of Debug kernel data structures
> 
> CONFIG_DEBUG_CREDENTIALS=y
> 
> #
> # RCU Debugging
> #
> CONFIG_TORTURE_TEST=y
> CONFIG_RCU_PERF_TEST=y
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> # CONFIG_RCU_TRACE is not set
> CONFIG_RCU_EQS_DEBUG=y
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_SAMPLES is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> # CONFIG_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> # CONFIG_EARLY_PRINTK is not set
> CONFIG_DEBUG_TLBFLUSH=y
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> # CONFIG_X86_DECODER_SELFTEST is not set
> # CONFIG_IO_DELAY_0X80 is not set
> # CONFIG_IO_DELAY_0XED is not set
> CONFIG_IO_DELAY_UDELAY=y
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEBUG_BOOT_PARAMS=y
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> CONFIG_DEBUG_NMI_SELFTEST=y
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> CONFIG_NOTIFIER_ERROR_INJECTION=y
> CONFIG_PM_NOTIFIER_ERROR_INJECT=y
> CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
> # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> CONFIG_FAULT_INJECTION=y
> CONFIG_FAILSLAB=y
> CONFIG_FAIL_PAGE_ALLOC=y
> # CONFIG_FAIL_FUTEX is not set
> CONFIG_FAULT_INJECTION_DEBUG_FS=y
> # CONFIG_FAIL_MMC_REQUEST is not set
> CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> CONFIG_RUNTIME_TESTING_MENU=y
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_LIST_SORT is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_SORT is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> CONFIG_ATOMIC64_SELFTEST=y
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> CONFIG_TEST_STRSCPY=y
> # CONFIG_TEST_KSTRTOX is not set
> CONFIG_TEST_PRINTF=y
> CONFIG_TEST_BITMAP=y
> # CONFIG_TEST_BITFIELD is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_OVERFLOW is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_HASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> CONFIG_TEST_FIRMWARE=y
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_DEBUG_VIRTUAL is not set
> # CONFIG_TEST_MEMCAT_P is not set
> CONFIG_TEST_STACKINIT=y
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_MEMTEST is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='trinity'
> 	export testcase='trinity'
> 	export category='functional'
> 	export need_memory='300MB'
> 	export runtime=300
> 	export job_origin='/lkp-src/allot/rand/vm-snb-i386/trinity.yaml'
> 	export queue_cmdline_keys='branch
> commit
> queue_at_least_once'
> 	export queue='validate'
> 	export testbox='vm-snb-i386-32'
> 	export tbox_group='vm-snb-i386'
> 	export branch='linux-next/master'
> 	export commit='0ea9ee430e74b16c6b17e70757d1c26d8d140e1f'
> 	export kconfig='i386-randconfig-a004-20200809'
> 	export repeat_to=4
> 	export nr_vm=64
> 	export submit_id='5f3045d53d95e21ff86525eb'
> 	export job_file='/lkp/jobs/scheduled/vm-snb-i386-32/trinity-300s-openwrt-i386-generic-20190428.cgz-0ea9ee430e74b16c6b17e70757d1c26d8d140e1f-20200810-8184-eltzvs-2.yaml'
> 	export id='ee6befac576ecac6e4f6c9f4d41d9cb47aeb3dd9'
> 	export queuer_version='/lkp-src'
> 	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
> 	export nr_cpu=2
> 	export memory='16G'
> 	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
> 	export swap_partitions='/dev/vdg'
> 	export need_kconfig='CONFIG_KVM_GUEST=y'
> 	export ssh_base_port=23032
> 	export rootfs='openwrt-i386-generic-20190428.cgz'
> 	export compiler='gcc-9'
> 	export enqueue_time='2020-08-10 02:52:05 +0800'
> 	export _id='5f3045d53d95e21ff86525eb'
> 	export _rt='/result/trinity/300s/vm-snb-i386/openwrt-i386-generic-20190428.cgz/i386-randconfig-a004-20200809/gcc-9/0ea9ee430e74b16c6b17e70757d1c26d8d140e1f'
> 	export user='lkp'
> 	export result_root='/result/trinity/300s/vm-snb-i386/openwrt-i386-generic-20190428.cgz/i386-randconfig-a004-20200809/gcc-9/0ea9ee430e74b16c6b17e70757d1c26d8d140e1f/3'
> 	export scheduler_version='/lkp/lkp/.src-20200805-150518'
> 	export LKP_SERVER='inn'
> 	export arch='i386'
> 	export max_uptime=1500
> 	export initrd='/osimage/openwrt/openwrt-i386-generic-20190428.cgz'
> 	export bootloader_append='root=/dev/ram0
> user=lkp
> job=/lkp/jobs/scheduled/vm-snb-i386-32/trinity-300s-openwrt-i386-generic-20190428.cgz-0ea9ee430e74b16c6b17e70757d1c26d8d140e1f-20200810-8184-eltzvs-2.yaml
> ARCH=i386
> kconfig=i386-randconfig-a004-20200809
> branch=linux-next/master
> commit=0ea9ee430e74b16c6b17e70757d1c26d8d140e1f
> BOOT_IMAGE=/pkg/linux/i386-randconfig-a004-20200809/gcc-9/0ea9ee430e74b16c6b17e70757d1c26d8d140e1f/vmlinuz-5.8.0-00043-g0ea9ee430e74b
> max_uptime=1500
> RESULT_ROOT=/result/trinity/300s/vm-snb-i386/openwrt-i386-generic-20190428.cgz/i386-randconfig-a004-20200809/gcc-9/0ea9ee430e74b16c6b17e70757d1c26d8d140e1f/3
> LKP_SERVER=inn
> selinux=0
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/i386-randconfig-a004-20200809/gcc-9/0ea9ee430e74b16c6b17e70757d1c26d8d140e1f/modules.cgz'
> 	export bm_initrd='/osimage/pkg/openwrt-i386-generic-20190428.cgz/trinity-static-i386-x86_64-f93256fb_2019-08-28.cgz'
> 	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export schedule_notify_address=
> 	export queue_at_least_once=1
> 	export kernel='/pkg/linux/i386-randconfig-a004-20200809/gcc-9/0ea9ee430e74b16c6b17e70757d1c26d8d140e1f/vmlinuz-5.8.0-00043-g0ea9ee430e74b'
> 	export dequeue_time='2020-08-10 02:55:39 +0800'
> 	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-32/trinity-300s-openwrt-i386-generic-20190428.cgz-0ea9ee430e74b16c6b17e70757d1c26d8d140e1f-20200810-8184-eltzvs-2.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test $LKP_SRC/tests/wrapper trinity
> }
> 
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=
> 
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper meminfo
> 
> 	$LKP_SRC/stats/wrapper time trinity.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
> 
> "$@"


> Seeding trinity based on i386-randconfig-a004-20200809
> 2020-08-09 18:56:55 trinity -q -q -l off -s 201168 -x get_robust_list -x remap_file_pages -N 999999999 -X
> Trinity 2019.06  Dave Jones <davej@codemonkey.org.uk>
> shm:0x774d9000-0x83c85e14 (4 pages)
> [main] Marking syscall get_robust_list (312) as to be disabled.
> [main] Marking syscall remap_file_pages (257) as to be disabled.
> Error getting nobody pwent (No such file or directory)

