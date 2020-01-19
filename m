Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BA6C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 08:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C272072B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 08:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgASIZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 03:25:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:15975 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgASIZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 03:25:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 00:25:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,337,1574150400"; 
   d="xz'?gz'50?scan'50,208,50";a="219355585"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2020 00:25:30 -0800
Date:   Sun, 19 Jan 2020 16:25:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>
Subject: c032ace71c ("software node: add basic tests for property .."): [
    2.882143] BUG: unable to handle page fault for address: 455f5349
Message-ID: <20200119082516.GA12867@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

commit c032ace71c29d513bf9df64ace1885fe5ff24981
Author:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
AuthorDate: Wed Dec 4 10:53:15 2019 -0800
Commit:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitDate: Thu Dec 19 18:14:34 2019 +0100

    software node: add basic tests for property entries
    
    This adds tests for creating software nodes with properties supplied by
    PROPERTY_ENTRY_XXX() macros and fetching and validating data from said
    nodes/properties.
    
    We are using KUnit framework for the tests.
    
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

e933bedd45  software node: remove separate handling of references
c032ace71c  software node: add basic tests for property entries
+-------------------------------------------------------------------------+------------+------------+
|                                                                         | e933bedd45 | c032ace71c |
+-------------------------------------------------------------------------+------------+------------+
| boot_successes                                                          | 0          | 0          |
| boot_failures                                                           | 88         | 11         |
| WARNING:at_drivers/base/core.c:#device_links_supplier_sync_state_resume | 88         |            |
| EIP:device_links_supplier_sync_state_resume                             | 88         |            |
| Mem-Info                                                                | 7          |            |
| Initiating_system_reboot                                                | 2          |            |
| BUG:unable_to_handle_page_fault_for_address                             | 0          | 11         |
| Oops:#[##]                                                              | 0          | 11         |
| EIP:strlen                                                              | 0          | 11         |
| Kernel_panic-not_syncing:Fatal_exception                                | 0          | 11         |
+-------------------------------------------------------------------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[    2.879736] 	ok 2 - pe_test_uint_arrays
[    2.880219] 	ok 3 - pe_test_strings
[    2.880711] 	ok 4 - pe_test_bool
[    2.881113] 	ok 5 - pe_test_move_inline_u8
[    2.881636] 	ok 6 - pe_test_move_inline_str
[    2.882143] BUG: unable to handle page fault for address: 455f5349
[    2.882775] #PF: supervisor read access in kernel mode
[    2.883288] #PF: error_code(0x0000) - not-present page
[    2.883773] *pdpt = 0000000000000000 *pde = f000ff53f000ff53 
[    2.884325] Oops: 0000 [#1] PTI
[    2.884630] CPU: 0 PID: 232 Comm: kunit_try_catch Tainted: G                T 5.4.0-09884-gc032ace71c29d #1
[    2.885558] EIP: strlen+0x10/0x1c
[    2.885879] Code: 89 c6 89 d0 88 c4 ac 38 e0 74 09 84 c0 75 f7 be 01 00 00 00 89 f0 48 5e 5d c3 3e 8d 74 26 00 55 83 c9 ff 89 e5 57 89 c7 31 c0 <f2> ae 5f b8 fe ff ff ff 29 c8 5d c3 3e 8d 74 26 00 85 c9 74 17 55
[    2.887641] EAX: 00000000 EBX: ef472584 ECX: ffffffff EDX: 00000cc0
[    2.888232] ESI: 455f5349 EDI: 455f5349 EBP: ef4b9808 ESP: ef4b9804
[    2.888821] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
[    2.889460] CR0: 80050033 CR2: 455f5349 CR3: 01c9e000 CR4: 000406b0
[    2.890050] Call Trace:
[    2.890300]  ? kstrdup+0x1a/0x3f
[    2.890623]  ? kobject_set_name_vargs+0x1d/0x76
[    2.891071]  ? kobject_init_and_add+0x1f/0x4a
[    2.891497]  ? swnode_register+0x113/0x18b
[    2.891889]  ? software_node_register+0x2f/0x49
[    2.892316]  ? software_node_register_nodes+0x1e/0x36
[    2.892798]  ? pe_test_reference+0x24f/0x1318
[    2.893233]  ? kunit_try_run_case+0x43/0x62
[    2.893632]  ? kunit_generic_run_threadfn_adapter+0x11/0x1b
[    2.894159]  ? kthread+0x117/0x11c
[    2.894484]  ? kunit_binary_str_assert_format+0x59/0x59
[    2.895016]  ? kthread_create_worker_on_cpu+0x1c/0x1c
[    2.895494]  ? ret_from_fork+0x2e/0x38
[    2.895851] Modules linked in:
[    2.896145] CR2: 00000000455f5349
[    2.896467] ---[ end trace 7b3188158c60a342 ]---
[    2.896903] EIP: strlen+0x10/0x1c

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 97bdd671728d7d32be52801a177ebeebd6e823e5 fd6988496e79a6a4bdb514a4655d2920209eb85d --
git bisect good 24c550621493a5db81ab6e9139abdb9000ddb054  # 17:57  G     12     0    0   1  Merge 'jpirko-mlxsw/net_queue' into devel-hourly-2020010304
git bisect good a47dd546748ea05638235aafdfb75cb3bfc3b4f5  # 18:38  G     10     0    0   1  Merge 'omap-audio/peter/udma/series_v8-5.5-rc3' into devel-hourly-2020010304
git bisect good 39f4ec57cabc9cd692df18fed4cf48347d89c254  # 19:09  G     10     0    0   1  Merge 'peterz-queue/locking/core' into devel-hourly-2020010304
git bisect good b3b3bac033b35efa0380b53246b44d4cf99fab68  # 19:38  G     10     0    0   2  Merge 'tip/perf/urgent' into devel-hourly-2020010304
git bisect good 1a4491decdcfebafa1c200dad00ec5209d267b2b  # 22:39  G     10     0    0   2  Merge 'dennis-misc/async-discard' into devel-hourly-2020010304
git bisect good 0762d4924bbabe7810aca2931c9e86d8cb3bd860  # 05:50  G     10     0    0   2  Merge 'kees/for-linus/seccomp' into devel-hourly-2020010304
git bisect  bad 3ff9d88a2912dce867610118fd8af40c11d81f9e  # 06:22  B      0    11   27   0  Merge 'pm/testing' into devel-hourly-2020010304
git bisect  bad 7e81b2fe2f4fc3d86d36d20888755f7c453f728b  # 13:53  B      0    11   27   0  Merge branch 'devprop' into linux-next
git bisect good 38233a2de382318f5d506da1812efd258f583bd4  # 15:42  G     31     0    0  13  Merge branches 'acpi-battery', 'acpi-video', 'acpi-fan' and 'acpi-drivers' into linux-next
git bisect good 51cf929321ed4184a819b9246253602dbfed5dcf  # 17:04  G     11     0    0   2  Merge branch 'acpica' into linux-next
git bisect good e933bedd45099dce1165104138bb703a6e31df82  # 14:44  G     11     0   11  56  software node: remove separate handling of references
git bisect good 2d3e79725873c20f6b27e6aecd13e1a4fa5c93a3  # 15:44  G     11     0    0   0  Merge branches 'acpi-doc' and 'acpi-tools' into linux-next
git bisect  bad c032ace71c29d513bf9df64ace1885fe5ff24981  # 16:05  B      0    11   41   0  software node: add basic tests for property entries
# first bad commit: [c032ace71c29d513bf9df64ace1885fe5ff24981] software node: add basic tests for property entries
git bisect good e933bedd45099dce1165104138bb703a6e31df82  # 18:04  G     33     0   33  89  software node: remove separate handling of references
# extra tests with debug options
git bisect good c032ace71c29d513bf9df64ace1885fe5ff24981  # 18:42  G     10     0    4  12  software node: add basic tests for property entries

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-vm-openwrt-07e11ce33e99:20200109003400:i386-randconfig-e002-20200102:5.4.0-09884-gc032ace71c29d:1.gz"
Content-Transfer-Encoding: base64

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
0psCUAzCitYCCnMBABtT74dodwAACg==

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-vm-openwrt-007ddb81116a:20200118174517:i386-randconfig-e002-20200102:5.4.0-09883-ge933bedd45099:1.gz"
Content-Transfer-Encoding: base64

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

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-openwrt-vm-openwrt-07e11ce33e99:20200109003400:i386-randconfig-e002-20200102:5.4.0-09884-gc032ace71c29d:1"

#!/bin/bash

kernel=$1
initrd=openwrt-trinity-i386.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/openwrt/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 8192
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	rcuperf.shutdown=0
	watchdog_thresh=60
)

"${kvm[@]}" -append "${append[*]}"

--FCuugMFkClbJLl1L
Content-Type: application/x-xz
Content-Disposition: attachment; filename="97bdd671728d7d32be52801a177ebeebd6e823e5:gcc-7:i386-randconfig-e002-20200102:EIP:strlen.xz"
Content-Transfer-Encoding: base64

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

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.4.0-09884-gc032ace71c29d"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.4.0 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
# CONFIG_TASK_IO_ACCOUNTING is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_SLUB_DEBUG is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_RDC321X is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_TOSHIBA=y
CONFIG_I8K=m
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=m
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_X86_PAE=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=m
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_TAD=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
# CONFIG_ACPI_THERMAL is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=m
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=m
CONFIG_ACPI_WATCHDOG=y
CONFIG_PMIC_OPREGION=y
CONFIG_ACPI_CONFIGFS=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH=y
# CONFIG_EFI_TEST is not set
# CONFIG_EFI_RCI2_TABLE is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_4_7=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
CONFIG_ZPOOL=m
CONFIG_ZBUD=m
# CONFIG_Z3FOLD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_GUP_GET_PTE_LOW_HIGH=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=y
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_INTERFACE=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
CONFIG_XFRM_STATISTICS=y
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=m
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
# CONFIG_INET6_AH is not set
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_INGRESS is not set
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NETFILTER_NETLINK_OSF=y
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=y
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
# CONFIG_NF_CONNTRACK_MARK is not set
CONFIG_NF_CONNTRACK_SECMARK=y
# CONFIG_NF_CONNTRACK_ZONES is not set
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
# CONFIG_NF_CT_PROTO_SCTP is not set
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
# CONFIG_NF_CONNTRACK_FTP is not set
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
# CONFIG_NF_CONNTRACK_SNMP is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
# CONFIG_NF_CT_NETLINK is not set
# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
# CONFIG_NETFILTER_XT_CONNMARK is not set

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
# CONFIG_NETFILTER_XT_TARGET_CONNSECMARK is not set
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=y
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
CONFIG_NETFILTER_XT_TARGET_RATEEST=y
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
# CONFIG_NETFILTER_XT_TARGET_MASQUERADE is not set
CONFIG_NETFILTER_XT_TARGET_TEE=m
# CONFIG_NETFILTER_XT_TARGET_TPROXY is not set
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=y
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
CONFIG_NETFILTER_XT_MATCH_COMMENT=y
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
CONFIG_NETFILTER_XT_MATCH_DCCP=y
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=y
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=y
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPCOMP=y
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
CONFIG_NETFILTER_XT_MATCH_MAC=y
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
CONFIG_NETFILTER_XT_MATCH_NFACCT=y
CONFIG_NETFILTER_XT_MATCH_OSF=y
CONFIG_NETFILTER_XT_MATCH_OWNER=m
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
CONFIG_NETFILTER_XT_MATCH_QUOTA=y
CONFIG_NETFILTER_XT_MATCH_RATEEST=y
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=y
CONFIG_NETFILTER_XT_MATCH_SCTP=y
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
CONFIG_NETFILTER_XT_MATCH_STRING=y
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
CONFIG_NETFILTER_XT_MATCH_TIME=y
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=y
CONFIG_NF_LOG_IPV4=y
CONFIG_NF_REJECT_IPV4=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_AH=y
# CONFIG_IP_NF_MATCH_ECN is not set
CONFIG_IP_NF_MATCH_RPFILTER=y
CONFIG_IP_NF_MATCH_TTL=m
# CONFIG_IP_NF_FILTER is not set
# CONFIG_IP_NF_TARGET_SYNPROXY is not set
CONFIG_IP_NF_NAT=m
# CONFIG_IP_NF_TARGET_MASQUERADE is not set
CONFIG_IP_NF_TARGET_NETMAP=m
# CONFIG_IP_NF_TARGET_REDIRECT is not set
CONFIG_IP_NF_MANGLE=y
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=y
# CONFIG_IP_NF_TARGET_TTL is not set
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=m
# CONFIG_IP_NF_ARPFILTER is not set
# CONFIG_IP_NF_ARP_MANGLE is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
# CONFIG_NF_TPROXY_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
# CONFIG_IP6_NF_IPTABLES is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_CONNTRACK_BRIDGE=m
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=m
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
CONFIG_SCTP_DBG_OBJCNT=y
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
CONFIG_L2TP=m
# CONFIG_L2TP_DEBUGFS is not set
# CONFIG_L2TP_V3 is not set
CONFIG_MRP=m
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
CONFIG_X25=y
CONFIG_LAPB=m
CONFIG_PHONET=m
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
# CONFIG_MAC802154 is not set
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUGFS is not set
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_BATMAN_ADV_SYSFS is not set
CONFIG_BATMAN_ADV_TRACING=y
CONFIG_OPENVSWITCH=m
CONFIG_VSOCKETS=m
# CONFIG_VSOCKETS_DIAG is not set
# CONFIG_VIRTIO_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
# CONFIG_NETROM is not set
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
# CONFIG_6PACK is not set
CONFIG_BPQETHER=y
CONFIG_DMASCC=m
# CONFIG_SCC is not set
# CONFIG_BAYCOM_SER_FDX is not set
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_BAYCOM_EPP=m
# CONFIG_YAM is not set
# end of AX.25 network device drivers

# CONFIG_CAN is not set
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_ATH3K is not set
CONFIG_BT_HCIUART_INTEL=y
CONFIG_BT_HCIUART_AG6XX=y
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
# CONFIG_BT_HCIBLUECARD is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_MTKSDIO=m
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
CONFIG_CEPH_LIB_PRETTYDEBUG=y
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# end of Cadence PCIe controllers support

# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
CONFIG_I82365=m
CONFIG_TCIC=m
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=y
# CONFIG_SIMPLE_PM_BUS is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=m
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
# CONFIG_AD525X_DPOT_SPI is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
CONFIG_LATTICE_ECP3_CONFIG=y
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module (requires I2C)
#
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
CONFIG_ARCNET=y
# CONFIG_ARCNET_1201 is not set
CONFIG_ARCNET_1051=y
CONFIG_ARCNET_RAW=y
# CONFIG_ARCNET_CAP is not set
CONFIG_ARCNET_COM90xx=y
CONFIG_ARCNET_COM90xxIO=y
CONFIG_ARCNET_RIM_I=m
# CONFIG_ARCNET_COM20020 is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
CONFIG_3C515=y
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_3C589=m
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMAZON is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
CONFIG_LANCE=y
# CONFIG_PCNET32 is not set
CONFIG_PCMCIA_NMCLAN=m
CONFIG_NI65=m
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
CONFIG_AURORA_NB8800=m
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
CONFIG_SYSTEMPORT=m
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
# CONFIG_NET_VENDOR_CIRRUS is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_CX_ECAT is not set
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_FUJITSU is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=y
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_MSCC_OCELOT_SWITCH=m
CONFIG_MSCC_OCELOT_SWITCH_OCELOT=m
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NET_VENDOR_NI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
# CONFIG_NET_VENDOR_REALTEK is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_NET_VENDOR_SAMSUNG is not set
CONFIG_NET_VENDOR_SEEQ=y
# CONFIG_NET_VENDOR_SOLARFLARE is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_SMC9194=m
CONFIG_PCMCIA_SMC91C92=m
# CONFIG_EPIC100 is not set
CONFIG_SMSC911X=m
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
CONFIG_VIA_VELOCITY=m
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
CONFIG_XILINX_AXI_EMAC=m
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
CONFIG_PCMCIA_XIRC2PS=m
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=m
# CONFIG_MDIO_BUS_MUX_GPIO is not set
CONFIG_MDIO_BUS_MUX_MMIOREG=m
# CONFIG_MDIO_BUS_MUX_MULTIPLEXER is not set
# CONFIG_MDIO_GPIO is not set
CONFIG_MDIO_HISI_FEMAC=y
# CONFIG_MDIO_MSCC_MIIM is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_SFP is not set
CONFIG_ADIN_PHY=m
CONFIG_AMD_PHY=m
CONFIG_AQUANTIA_PHY=m
# CONFIG_AX88796B_PHY is not set
CONFIG_BCM7XXX_PHY=m
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_DP83822_PHY=y
CONFIG_DP83TC811_PHY=y
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=y
CONFIG_DP83869_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
# CONFIG_LXT_PHY is not set
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=y
CONFIG_MICROCHIP_PHY=y
# CONFIG_MICROCHIP_T1_PHY is not set
CONFIG_MICROSEMI_PHY=y
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_AT803X_PHY=y
CONFIG_QSEMI_PHY=y
# CONFIG_REALTEK_PHY is not set
CONFIG_RENESAS_PHY=m
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
CONFIG_TERANETICS_PHY=y
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=y
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
CONFIG_SLIP=m
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
CONFIG_SLIP_MODE_SLIP6=y

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
# end of WiMAX Wireless Broadband devices

# CONFIG_WAN is not set
# CONFIG_IEEE802154_DRIVERS is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=y
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_APBPS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=m
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_NULL_TTY=y
# CONFIG_GOLDFISH_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_SCCNXP=m
CONFIG_SERIAL_SC16IS7XX=m
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
CONFIG_SERIAL_TIMBERDALE=m
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_FSL_LINFLEXUART=y
CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
# CONFIG_PRINTER is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=m
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=m
# CONFIG_DTLK is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
# CONFIG_CARDMAN_4000 is not set
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=m
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_SPI_CR50=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_OF=m
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=m
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA is not set
CONFIG_I2C_RK3X=m
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_PCA_ISA=m
CONFIG_I2C_CROS_EC_TUNNEL=m
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_FSI=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=m
CONFIG_SPI_BUTTERFLY=m
CONFIG_SPI_CADENCE=y
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_NXP_FLEXSPI=m
CONFIG_SPI_GPIO=m
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_OC_TINY=m
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=m
CONFIG_SPI_SIFIVE=y
CONFIG_SPI_MXIC=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=m
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=m
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=m
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AXP209=m
CONFIG_PINCTRL_AMD=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STMFX=m
# CONFIG_PINCTRL_RK805 is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=m
# CONFIG_PINCTRL_LEWISBURG is not set
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_PINCTRL_TIGERLAKE=m
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_EQUILIBRIUM=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=m
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_SAMA5D2_PIOBU=m
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=m
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_MADERA=y
# CONFIG_GPIO_MAX77650 is not set
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TPS65218=m
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=m
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=m
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=m
# CONFIG_GPIO_XRA1403 is not set
CONFIG_GPIO_MOXTET=y
# end of SPI GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=m
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_MT6323=y
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
# CONFIG_SYSCON_REBOOT_MODE is not set
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=m
CONFIG_BATTERY_ACT8945A=m
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77650=m
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65217=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_CROS_USBPD=y
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_WILCO is not set
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2947_SPI=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_INSPUR_IPSPS=m
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_IR38064=m
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=m
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_PWM_FAN is not set
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=m
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
CONFIG_DA9062_THERMAL=m

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
# CONFIG_DA9063_WATCHDOG is not set
CONFIG_DA9062_WATCHDOG=m
CONFIG_GPIO_WATCHDOG=m
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_WDAT_WDT=y
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=m
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=m
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
# CONFIG_SMSC37B787_WDT is not set
CONFIG_TQMX86_WDT=y
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_NI903X_WDT=m
CONFIG_NIC7018_WDT=y
# CONFIG_MEN_A21_WDT is not set

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
CONFIG_MIXCOMWD=y
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=m
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
# CONFIG_MFD_CROS_EC_DEV is not set
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_MADERA_SPI=y
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=m
CONFIG_MFD_MC13XXX=m
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77650=m
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=m
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=m
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
CONFIG_ABX500_CORE=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_SPI is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
CONFIG_MFD_TI_LMU=m
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=m
CONFIG_MFD_TPS65912=m
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=m
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8994=m
CONFIG_MFD_STMFX=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9063=m
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=m
CONFIG_REGULATOR_LP8755=m
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX77650=m
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MCP16502=m
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6323=m
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_SY8106A=m
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS65218=m
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_VCTRL=m
CONFIG_REGULATOR_WM8994=m
CONFIG_CEC_CORE=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
# CONFIG_IR_RC5_DECODER is not set
# CONFIG_IR_RC6_DECODER is not set
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=m
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
# CONFIG_IR_HIX5HD2 is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_SPI is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
# CONFIG_IR_PWM_TX is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
CONFIG_DRM_DP_CEC=y

#
# ARM devices
#
# end of ARM devices

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=m
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=y
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=m
CONFIG_LCD_OTM3225A=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_APPLE=m
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_SAHARA=m
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_TPS65217=m
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
# end of Backlight & LCD device support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SD8787=m
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=m
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_GOLDFISH is not set
CONFIG_MMC_SPI=y
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_AN30259A=m
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_CR0014114=m
CONFIG_LEDS_EL15203000=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
CONFIG_LEDS_LM3533=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_MT6323=m
# CONFIG_LEDS_NET48XX is not set
CONFIG_LEDS_WRAP=m
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX77650=m
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_KTD2692=m
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=m
# CONFIG_LEDS_SPI_BYTE is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_DW_AXI_DMAC=m
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_PCH_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_SELFTESTS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
# CONFIG_KS0108 is not set
CONFIG_IMG_ASCII_LCD=m
# CONFIG_HT16K33 is not set
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=m
CONFIG_CHARLCD=y
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=m
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# end of Android

# CONFIG_STAGING_BOARD is not set
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_GOLDFISH_AUDIO=y
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
# CONFIG_FB_TFT is not set
# CONFIG_MOST is not set
CONFIG_KS7010=y
CONFIG_PI433=m

#
# Gasket devices
#
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
CONFIG_FIELDBUS_DEV=m
CONFIG_HMS_ANYBUSS_BUS=m
CONFIG_ARCX_ANYBUS_CONTROLLER=m
CONFIG_HMS_PROFINET=m
CONFIG_UWB=m
# CONFIG_UWB_WHCI is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_QLGE is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WMI is not set
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
CONFIG_ALIENWARE_WMI=m
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DCDBAS is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBU is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
CONFIG_GPD_POCKET_FAN=y
CONFIG_TC1100_WMI=y
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_HP_WMI is not set
# CONFIG_LG_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=y
# CONFIG_WMI_BMOF is not set
CONFIG_INTEL_WMI_THUNDERBOLT=y
# CONFIG_XIAOMI_WMI is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
CONFIG_MXM_WMI=y
CONFIG_SAMSUNG_Q10=y
# CONFIG_APPLE_GMUX is not set
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=m
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_MLX_PLATFORM=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=m
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
CONFIG_CROS_EC_RPMSG=y
CONFIG_CROS_EC_SPI=m
CONFIG_CROS_EC_LPC=m
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
# CONFIG_CROS_USBPD_LOGGER is not set
CONFIG_WILCO_EC=m
# CONFIG_WILCO_EC_DEBUGFS is not set
CONFIG_WILCO_EC_EVENTS=m
# CONFIG_WILCO_EC_TELEMETRY is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_CLK_HSDK=y
CONFIG_COMMON_CLK_MAX9485=m
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_SI514=m
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=m
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=m
CONFIG_COMMON_CLK_PWM=m
CONFIG_COMMON_CLK_VC5=m
CONFIG_COMMON_CLK_FIXED_MMIO=y
# end of Common Clock Framework

CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_MAILBOX_TEST=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=m
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_INTEL_INT3496=m
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_CROS_EC is not set
CONFIG_PWM_FSL_FTM=m
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=m
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=m
CONFIG_PWM_PCA9685=m
# CONFIG_PWM_STMPE is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_CADENCE_DP is not set
CONFIG_PHY_CADENCE_DPHY=m
CONFIG_PHY_CADENCE_SIERRA=m
CONFIG_PHY_FSL_IMX8MQ_USB=m
CONFIG_PHY_MIXEL_MIPI_DPHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=m
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
# CONFIG_STM_PROTO_SYS_T is not set
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=y
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_STH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=m
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=m
CONFIG_FSI_MASTER_HUB=m
CONFIG_FSI_MASTER_ASPEED=m
CONFIG_FSI_SCOM=m
CONFIG_FSI_SBEFIFO=m
# CONFIG_FSI_OCC is not set
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=m
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
# CONFIG_EXT4_KUNIT_TESTS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
CONFIG_VIRTIO_FS=m
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_FSCACHE_OBJECT_LIST=y
# CONFIG_CACHEFILES is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_DEBUG is not set
CONFIG_CEPH_FS=m
CONFIG_CEPH_FSCACHE=y
# CONFIG_CEPH_FS_POSIX_ACL is not set
CONFIG_CIFS=y
CONFIG_CIFS_STATS2=y
# CONFIG_CIFS_ALLOW_INSECURE_LEGACY is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_DEBUG is not set
# CONFIG_CIFS_DFS_UPCALL is not set
CONFIG_CIFS_FSCACHE=y
# CONFIG_CIFS_ROOT is not set
CONFIG_CODA_FS=m
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=m
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=m
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=m
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=m
# CONFIG_NLS_UTF8 is not set
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"

#
# Kernel hardening options
#
CONFIG_GCC_PLUGIN_STRUCTLEAK=y

#
# Memory initialization
#
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_CURVE25519=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=m
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=y
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
CONFIG_CRYPTO_LIB_POLY1305=m
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_GEODE is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_CRYPTO_DEV_SAFEXCEL=m
CONFIG_CRYPTO_DEV_CCREE=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=y
CONFIG_TEXTSEARCH_BM=y
CONFIG_TEXTSEARCH_FSM=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_SYMBOLIC_ERRNAME is not set
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_BRANCH_TRACER is not set
CONFIG_STACK_TRACER=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_GCOV_PROFILE_FTRACE=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_KUNIT=y
CONFIG_KUNIT_TEST=y
# CONFIG_KUNIT_EXAMPLE_TEST is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_SYSCTL_KUNIT_TEST is not set
# CONFIG_LIST_KUNIT_TEST is not set
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_MEMTEST=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y
# end of Kernel hacking

--FCuugMFkClbJLl1L--
