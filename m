Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D439C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01C32064A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgCDA0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:26:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:41065 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbgCDA0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:26:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 16:25:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="xz'?scan'208";a="287166022"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2020 16:25:52 -0800
Date:   Wed, 4 Mar 2020 08:25:42 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: [mm/debug] 216e0b7a58: BUG:non-zero_pgtables_bytes_on_freeing_mm
Message-ID: <20200304002542.GY6548@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qwWC3uIwaXcGNtT+"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qwWC3uIwaXcGNtT+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: 216e0b7a586b92c286da611aad11ec36e8985755 ("mm/debug: add tests validating architecture page table helpers")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: trinity
with following parameters:

	runtime: 300s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+-------------------------------------------------------------------------------+------------+------------+
|                                                                               | ddad3873db | 216e0b7a58 |
+-------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                | 7          | 0          |
| boot_failures                                                                 | 5          | 12         |
| WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_oom_notify                     | 5          |            |
| EIP:rcutorture_oom_notify                                                     | 5          |            |
| WARNING:at_kernel/locking/lockdep.c:#mark_lock                                | 1          |            |
| EIP:mark_lock                                                                 | 1          |            |
| BUG:kernel_hang_in_test_stage                                                 | 2          |            |
| page_allocation_failure:order:#,mode:#(GFP_NOWAIT|__GFP_COMP),nodemask=(null) | 2          |            |
| Mem-Info                                                                      | 2          |            |
| INFO:trying_to_register_non-static_key                                        | 3          | 1          |
| BUG:unable_to_handle_page_fault_for_address                                   | 1          |            |
| Oops:#[##]                                                                    | 1          |            |
| EIP:rcu_torture_fwd_prog_cbfree                                               | 1          |            |
| Kernel_panic-not_syncing:Fatal_exception                                      | 1          |            |
| BUG:non-zero_pgtables_bytes_on_freeing_mm                                     | 0          | 12         |
| BUG:Bad_page_state_in_process                                                 | 0          | 12         |
+-------------------------------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


[   15.579147] BUG: non-zero pgtables_bytes on freeing mm: -4096
[   15.579586] debug: unmapping init [mem 0xc885e000-0xc8a2cfff]
[   15.580585] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   15.581619] cfg80211: failed to load regulatory.db
[   15.600801] random: fast init done
[   15.611059] Write protecting kernel text and read-only data: 13616k
[   15.611834] NX-protecting the kernel data: 8620k
[   15.625996] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   15.626813] rodata_test: all tests were successful
[   15.627380] Run /init as init process
[   15.627809]   with arguments:
[   15.628165]     /init
[   15.628442]   with environment:
[   15.628817]     HOME=/
[   15.629103]     TERM=linux
[   15.629431]     user=lkp
[   15.629736]     job=/lkp/jobs/scheduled/vm-snb-i386-14/trinity-300s-yocto-i386-minimal-20190520.cgz-216e0b7a586b92c286da611aad11ec36e8985755-20200304-4330-u6qq9b-10.yaml
[   15.631436]     ARCH=i386
[   15.631718]     kconfig=i386-randconfig-e002-20200228
[   15.632234]     branch=linux-review/Qiujun-Huang/kcsan-Fix-a-typo-in-a-comment/20200228-201130
[   15.633132]     commit=216e0b7a586b92c286da611aad11ec36e8985755
[   15.633780]     BOOT_IMAGE=/pkg/linux/i386-randconfig-e002-20200228/gcc-7/216e0b7a586b92c286da611aad11ec36e8985755/vmlinuz-5.6.0-rc3-00029-g216e0b7a586b9
[   15.635178]     max_uptime=1500
[   15.635566]     RESULT_ROOT=/result/trinity/300s/vm-snb-i386/yocto-i386-minimal-20190520.cgz/i386-randconfig-e002-20200228/gcc-7/216e0b7a586b92c286da611aad11ec36e8985755/8
[   15.637029]     LKP_SERVER=inn
[   15.637260]     selinux=0
[   15.637458]     nmi_watchdog=panic
[   15.637711]     prompt_ramdisk=0
[   15.637952]     earlyprintk=ttyS0,115200
[   15.638243]     vga=normal
[   15.638616] BUG: Bad page state in process swapper/0  pfn:1dc26
[   15.639103] page:ef9af558 refcount:-1 mapcount:0 mapping:00000000 index:0x0
[   15.639610] flags: 0x0()
[   15.639805] raw: 00000000 00000100 00000122 00000000 00000000 c01153c0 ffffffff ffffffff
[   15.640392] raw: 00000000
[   15.640591] page dumped because: nonzero _refcount
[   15.640942] Modules linked in:
[   15.641174] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc3-00029-g216e0b7a586b9 #1
[   15.641751] Call Trace:
[   15.642003]  dump_stack+0x9a/0xd4
[   15.642302]  bad_page+0xc6/0x130
[   15.642549]  check_new_page_bad+0x51/0x70
[   15.642848]  get_page_from_freelist+0x1063/0x1660
[   15.643237]  ? sched_clock_cpu+0x19/0x140
[   15.643641]  __alloc_pages_nodemask+0xee/0xdc0
[   15.644205]  ? __lock_acquire+0x1a7e/0x1f10
[   15.644597]  ? cache_grow_begin+0x565/0xaa0
[   15.644994]  ? lockdep_hardirqs_on+0x124/0x1b0
[   15.645321]  ? cache_grow_begin+0x565/0xaa0
[   15.645709]  ? kmem_cache_alloc+0x310/0x700
[   15.646035]  ? trace_hardirqs_on+0x35/0xf0
[   15.646341]  cache_grow_begin+0x58c/0xaa0
[   15.646717]  ? kmem_cache_alloc+0x93/0x700
[   15.647030]  kmem_cache_alloc+0x310/0x700
[   15.647369]  vm_area_alloc+0x16/0x40
[   15.647645]  __do_execve_file+0x2d5/0x920
[   15.647953]  do_execve+0x1f/0x30
[   15.648215]  run_init_process+0x58/0xa0
[   15.648508]  ? rest_init+0x220/0x220
[   15.648806]  kernel_init+0x50/0xf0
[   15.649070]  ret_from_fork+0x33/0x40
[   15.649344] Disabling lock debugging due to kernel taint
[   15.655890] mount (200) used greatest stack depth: 4 bytes left
Starting udev
[   15.696213] udevd[226]: starting version 3.2.7
[   15.697231] random: udevd: uninitialized urandom read (16 bytes read)
[   15.703596] random: udevd: uninitialized urandom read (16 bytes read)
[   15.704416] random: udevd: uninitialized urandom read (16 bytes read)
[   15.706631] udevd[226]: specified group 'kvm' unknown
[   15.709584] udevd[227]: starting eudev-3.2.7
[   15.740547] udevd[227]: specified group 'kvm' unknown
[   15.756776] Linux agpgart interface v0.103
[   15.783499] rtc_cmos 00:00: RTC can wake from S4
[   15.784329] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
[   15.788266] piix4_smbus 0000:00:01.3: SMBus region 0x700 already in use!
[   15.788768] piix4_smbus: probe of 0000:00:01.3 failed with error -16
[   15.803389] rtc_cmos 00:00: registered as rtc0
[   15.804107] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
[   15.805588] rtc_cmos 00:00: RTC can wake from S4
[   15.820863] rtc_cmos 00:00: registered as rtc1
[   15.821565] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
LKP: HOSTNAME vm-snb-i386-14, MAC 6a:43:f3:2d:8e:16, kernel 5.6.0-rc3-00029-g216e0b7a586b9 1, serial console /dev/ttyS0
Poky (Yocto Project Reference Distro) 2.7+snapshot vm-snb-i386-14 /dev/ttyS0
[   28.765565] can: request_module (can-proto-1) failed.
[   28.766367] can: request_module (can-proto-2) failed.
[   28.785933] VFS: Warning: trinity-c2 using old stat() call. Recompile your binary.
[   28.822322] warning: process `trinity-c4' used the deprecated sysctl system call with 
[   28.831669] VFS: Warning: trinity-c1 using old stat() call. Recompile your binary.
[   28.833558] VFS: Warning: trinity-c3 using old stat() call. Recompile your binary.
[   28.835219] vm86_32: Denied a call to vm86(old) from trinity-c3[764] (uid: 65534).  Set the vm.mmap_min_addr sysctl to 0 and/or adjust LSM mmap_min_addr policy to enable vm86 if you are using a vm86-based DOS emulator.
[   28.840307] audit: type=1326 audit(1583252334.460:2): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=764 comm="trinity-c3" exe="/bin/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0xb7f2eb39 code=0x0
[   28.842728] VFS: Warning: trinity-c5 using old stat() call. Recompile your binary.
[   28.845737] VFS: Warning: trinity-c5 using old stat() call. Recompile your binary.
[   28.864103] audit: type=1326 audit(1583252334.490:3): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=761 comm="trinity-c0" exe="/bin/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0xb7f2eb39 code=0x0
[   29.881821] raw_sendmsg: trinity-c7 forgot to set AF_INET. Fix it!
[   31.140533] random: crng init done
[   31.149362] random: 5 urandom warning(s) missed due to ratelimiting
[   31.152945] audit: type=1326 audit(1583252336.780:4): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=779 comm="trinity-c3" exe="/bin/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0xb7f2eb39 code=0x0
[   31.264643] audit: type=1326 audit(1583252336.890:5): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=767 comm="trinity-c6" exe="/bin/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0xb7f2eb39 code=0x0
[   31.290796] audit: type=1326 audit(1583252336.920:6): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=806 comm="trinity-c6" exe="/bin/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0xb7f2eb39 code=0x0
[   31.425043] audit: type=1326 audit(1583252337.050:7): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=808 comm="trinity-c6" exe="/bin/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0xb7f2eb39 code=0x0
[   31.878089] audit: type=1326 audit(1583252337.500:8): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=762 comm="trinity-c1" exe="/bin/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0xb7f2eb39 code=0x0
[   32.165271] futex_wake_op: trinity-c2 tries to shift op by -16; fix this program
[   32.444872] audit: type=1326 audit(1583252338.070:9): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=810 comm="trinity-c6" exe="/bin/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0xb7f2eb39 code=0x0
[   32.577475] audit: type=1326 audit(1583252338.200:10): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=780 comm="trinity-c0" exe="/bin/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0xb7f2eb39 code=0x0
[   39.265054] kauditd_printk_skb: 2 callbacks suppressed
[   39.265057] audit: type=1326 audit(1583252344.890:13): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=799 comm="trinity-c3" exe="/bin/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0xb7f2eb39 code=0x0
[   42.573997] audit: type=1326 audit(1583252348.200:14): auid=4294967295 uid=65534 gid=65534 ses=4294967295 pid=833 comm="trinity-c0" exe="/bin/trinity" sig=9 arch=40000003 syscall=19 compat=0 ip=0xb7f2eb39 code=0x0

Elapsed time: 60

qemu-img create -f qcow2 disk-vm-snb-i386-14-0 256G
qemu-img create -f qcow2 disk-vm-snb-i386-14-1 256G
qemu-img create -f qcow2 disk-vm-snb-i386-14-2 256G
qemu-img create -f qcow2 disk-vm-snb-i386-14-3 256G
qemu-img create -f qcow2 disk-vm-snb-i386-14-4 256G
qemu-img create -f qcow2 disk-vm-snb-i386-14-5 256G
qemu-img create -f qcow2 disk-vm-snb-i386-14-6 256G

kvm=(
	qemu-system-i386
	-enable-kvm
	-cpu SandyBridge
	-kernel $kernel
	-initrd initrd-vm-snb-i386-14.cgz
	-m 8192
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
	-boot order=nc
	-no-reboot


To reproduce:

        # build kernel
	cd linux
	cp config-5.6.0-rc3-00029-g216e0b7a586b9 .config
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=i386 olddefconfig prepare modules_prepare bzImage

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



Thanks,
Rong Chen


--qwWC3uIwaXcGNtT+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.6.0-rc3-00029-g216e0b7a586b9"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.6.0-rc3 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
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
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
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
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
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
CONFIG_MEMCG=y
# CONFIG_MEMCG_SWAP is not set
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
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
CONFIG_AIO=y
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
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
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
CONFIG_X86_BIGSMP=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
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
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
CONFIG_CPU_SUP_CYRIX_32=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
CONFIG_CPU_SUP_UMC_32=y
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_ANCIENT_MCE=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_X86_16BIT is not set
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_X86_PAE=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# end of Processor type and features

CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set
CONFIG_X86_APM_BOOT=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_ALLOW_INTS=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
CONFIG_PCI_GODIRECT=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_XEN=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
# CONFIG_X86_SYSFB is not set
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
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH=y
# CONFIG_EFI_TEST is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_UPROBES=y
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
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
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
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
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

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_GUP_GET_PTE_LOW_HIGH=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_TUNNEL=y
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
# CONFIG_MPTCP_HMAC_TEST is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
# CONFIG_BRIDGE_NETFILTER is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NETFILTER_NETLINK_OSF is not set
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NF_LOG_NETDEV is not set
# CONFIG_NF_TABLES is not set
# CONFIG_NETFILTER_XTABLES is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TPROXY_IPV4 is not set
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TPROXY_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
# CONFIG_IP6_NF_IPTABLES is not set
# end of IPv6: Netfilter Configuration

# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=m
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
CONFIG_BATMAN_ADV=m
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUGFS is not set
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_BATMAN_ADV_SYSFS is not set
CONFIG_BATMAN_ADV_TRACING=y
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
# CONFIG_MPLS is not set
CONFIG_NET_NSH=y
CONFIG_HSR=m
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
CONFIG_CAN_J1939=y

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
CONFIG_CAN_VXCAN=m
# CONFIG_CAN_SLCAN is not set
# CONFIG_CAN_DEV is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=y
CONFIG_BT_BREDR=y
# CONFIG_BT_RFCOMM is not set
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
# CONFIG_BT_HIDP is not set
# CONFIG_BT_HS is not set
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
CONFIG_BT_SELFTEST=y
CONFIG_BT_SELFTEST_ECDH=y
# CONFIG_BT_SELFTEST_SMP is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTSDIO is not set
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIVHCI=y
# CONFIG_BT_MRVL is not set
CONFIG_BT_MTKSDIO=m
CONFIG_BT_MTKUART=m
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=y
# CONFIG_NL80211_TESTMODE is not set
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
CONFIG_CFG80211_CERTIFICATION_ONUS=y
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_EXTRA_REGDB_KEYDIR=""
CONFIG_CFG80211_REG_CELLULAR_HINTS=y
CONFIG_CFG80211_REG_RELAX_NO_IR=y
CONFIG_CFG80211_DEFAULT_PS=y
CONFIG_CFG80211_DEBUGFS=y
# CONFIG_CFG80211_CRDA_SUPPORT is not set
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=y
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
# CONFIG_MAC80211_LEDS is not set
CONFIG_MAC80211_DEBUGFS=y
CONFIG_MAC80211_MESSAGE_TRACING=y
CONFIG_MAC80211_DEBUG_MENU=y
# CONFIG_MAC80211_NOINLINE is not set
# CONFIG_MAC80211_VERBOSE_DEBUG is not set
CONFIG_MAC80211_MLME_DEBUG=y
CONFIG_MAC80211_STA_DEBUG=y
CONFIG_MAC80211_HT_DEBUG=y
CONFIG_MAC80211_OCB_DEBUG=y
CONFIG_MAC80211_IBSS_DEBUG=y
CONFIG_MAC80211_PS_DEBUG=y
# CONFIG_MAC80211_MPL_DEBUG is not set
# CONFIG_MAC80211_MPATH_DEBUG is not set
# CONFIG_MAC80211_MHWMP_DEBUG is not set
CONFIG_MAC80211_MESH_SYNC_DEBUG=y
CONFIG_MAC80211_MESH_CSA_DEBUG=y
CONFIG_MAC80211_MESH_PS_DEBUG=y
CONFIG_MAC80211_TDLS_DEBUG=y
# CONFIG_MAC80211_DEBUG_COUNTERS is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y
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
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
CONFIG_PCIEASPM_PERFORMANCE=y
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=m
CONFIG_PCI_PF_STUB=y
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCI_MESON=y
# end of DesignWare PCI Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
CONFIG_YENTA=m
# CONFIG_YENTA_O2 is not set
# CONFIG_YENTA_RICOH is not set
CONFIG_YENTA_TI=y
# CONFIG_YENTA_TOSHIBA is not set
# CONFIG_PD6729 is not set
CONFIG_I82092=m
CONFIG_I82365=m
CONFIG_TCIC=m
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
# CONFIG_RAPIDIO_CHMAN is not set
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=m
# CONFIG_RAPIDIO_CPS_XX is not set
CONFIG_RAPIDIO_TSI568=y
CONFIG_RAPIDIO_CPS_GEN2=m
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

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
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=m
CONFIG_REGMAP_I3C=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
# CONFIG_MTD_SBC_GXX is not set
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
CONFIG_MTD_ESB2ROM=y
CONFIG_MTD_CK804XROM=m
CONFIG_MTD_SCB2_FLASH=y
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
CONFIG_MTD_PCI=y
# CONFIG_MTD_PCMCIA is not set
CONFIG_MTD_INTEL_VR_NOR=m
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
CONFIG_MTD_DATAFLASH_OTP=y
CONFIG_MTD_MCHP23K256=y
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
CONFIG_MTD_SPI_NAND=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_SPI_MTK_QUADSPI is not set
CONFIG_SPI_INTEL_SPI=m
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=m
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=y
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
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_CS5535_MFGPT is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_VMWARE_BALLOON=m
# CONFIG_PCH_PHUB is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_XILINX_SDFEC=y
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=m
CONFIG_VMWARE_VMCI=m

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
CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
CONFIG_EQUALIZER=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=y
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_RIONET=m
CONFIG_RIONET_TX_SIZE=128
CONFIG_RIONET_RX_SIZE=128
CONFIG_TUN=m
CONFIG_TUN_VNET_CROSS_LE=y
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
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
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_NI65 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=m
CONFIG_MDIO_BUS=m
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
CONFIG_MDIO_GPIO=m
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
# CONFIG_PPP_DEFLATE is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=y
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPPOE=y
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=y

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

CONFIG_WAN=y
# CONFIG_HOSTESS_SV11 is not set
CONFIG_COSA=m
CONFIG_LANMEDIA=m
# CONFIG_SEALEVEL_4021 is not set
CONFIG_HDLC=m
# CONFIG_HDLC_RAW is not set
CONFIG_HDLC_RAW_ETH=m
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
# CONFIG_HDLC_PPP is not set

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
CONFIG_WANXL=m
# CONFIG_WANXL_BUILD_FIRMWARE is not set
CONFIG_PC300TOO=m
CONFIG_N2=m
CONFIG_C101=m
CONFIG_FARSYNC=m
# CONFIG_DLCI is not set
CONFIG_SBNI=m
# CONFIG_SBNI_MULTILINE is not set
# CONFIG_IEEE802154_DRIVERS is not set
CONFIG_XEN_NETDEV_FRONTEND=m
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
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
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
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
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
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
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
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
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
# CONFIG_GOLDFISH_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_TTY_PRINTK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_GEODE is not set
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_NVRAM is not set
CONFIG_DTLK=m
CONFIG_APPLICOM=m
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=y
CONFIG_TCG_TIS_SPI_CR50=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=m
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_INFINEON=m
CONFIG_TCG_XEN=y
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TCG_TIS_ST33ZP24_SPI=y
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_PCIE=m
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EG20T=m
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_PCA_ISA=y
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_SCx200_ACB=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
# CONFIG_CDNS_I3C_MASTER is not set
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=y
CONFIG_SPI_TOPCLIFF_PCH=y
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=m
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PTP_1588_CLOCK_IDTCM=m
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_SIOX=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
CONFIG_GPIO_104_IDIO_16=m
CONFIG_GPIO_104_IDI_48=m
CONFIG_GPIO_F7188X=m
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_CS5535 is not set
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_UCB1400=m
# CONFIG_GPIO_WM8350 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=m
# end of SPI GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=m
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

CONFIG_POWER_AVS=y
CONFIG_QCOM_CPR=y
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_WM8350_POWER=m
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9052=y
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_88PM860X=m
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=m
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_BQ2415X=m
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=m
# CONFIG_CHARGER_CROS_USBPD is not set
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_DA9052_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_MENZ069_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
CONFIG_WM8350_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_RAVE_SP_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_RETU_WATCHDOG=m
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=y
# CONFIG_F71808E_WDT is not set
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=m
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=m
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_SC1200_WDT is not set
CONFIG_SCx200_WDT=m
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
CONFIG_60XX_WDT=y
# CONFIG_SBC8360_WDT is not set
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=m
CONFIG_TQMX86_WDT=m
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
# CONFIG_XEN_WDT is not set

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=m
CONFIG_MFD_AS3711=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=m
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC_DEV is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=m
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_EZX_PCAP=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=m
# CONFIG_PCF50633_GPIO is not set
CONFIG_UCB1400_CORE=m
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=m
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_TQMX86=m
CONFIG_MFD_VX855=m
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_WCD934X=y
CONFIG_RAVE_SP_CORE=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3711=m
CONFIG_REGULATOR_BCM590XX=y
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MP8859=m
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_PCAP is not set
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=y
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65090 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS6524X=m
CONFIG_REGULATOR_WM8350=m
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
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_MEM2MEM_DEV=m
CONFIG_V4L2_FWNODE=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_SOLO6X10=m
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
CONFIG_VIDEO_TW686X=m

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_IVTV is not set
CONFIG_VIDEO_HEXIUM_GEMINI=m
# CONFIG_VIDEO_HEXIUM_ORION is not set
CONFIG_VIDEO_MXB=m
CONFIG_VIDEO_DT3155=m

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX25821=m
CONFIG_VIDEO_CX25821_ALSA=m
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_SAA7134 is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_VIDEO_CAFE_CCIC=m
# CONFIG_VIDEO_VIA_CAMERA is not set
CONFIG_VIDEO_CADENCE=y
CONFIG_VIDEO_ASPEED=m
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
CONFIG_V4L_TEST_DRIVERS=y
# CONFIG_VIDEO_VIVID is not set
CONFIG_VIDEO_VIM2M=m
# CONFIG_VIDEO_VICODEC is not set
# CONFIG_CEC_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_UDA1342=m
# CONFIG_VIDEO_WM8775 is not set
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_SONY_BTF_MPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
# CONFIG_VIDEO_BT866 is not set
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TVP514X=m
CONFIG_VIDEO_TVP5150=m
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_TW9910=m
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_AK881X=m
CONFIG_VIDEO_THS8200=m

#
# Camera sensor devices
#
CONFIG_VIDEO_OV2640=m
CONFIG_VIDEO_OV2659=m
# CONFIG_VIDEO_OV6650 is not set
CONFIG_VIDEO_OV5695=m
CONFIG_VIDEO_OV772X=m
CONFIG_VIDEO_OV7640=m
CONFIG_VIDEO_OV7670=m
CONFIG_VIDEO_OV7740=m
CONFIG_VIDEO_OV9640=m
CONFIG_VIDEO_VS6624=m
CONFIG_VIDEO_MT9M111=m
CONFIG_VIDEO_MT9T112=m
CONFIG_VIDEO_MT9V011=m
# CONFIG_VIDEO_MT9V111 is not set
CONFIG_VIDEO_SR030PC30=m
CONFIG_VIDEO_RJ54N1=m

#
# Lens drivers
#

#
# Flash devices
#

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=m

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=m
CONFIG_VIDEO_I2C=m
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

#
# Media SPI Adapters
#
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
# CONFIG_MEDIA_TUNER_MT2063 is not set
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
# CONFIG_MEDIA_TUNER_XC2028 is not set
# CONFIG_MEDIA_TUNER_XC5000 is not set
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MAX2165=m
# CONFIG_MEDIA_TUNER_TDA18218 is not set
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_TDA18212=m
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_SI2157=m
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Tools to develop new frontends
#
# end of Customise DVB Frontends

#
# Graphics support
#
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
CONFIG_AGP_INTEL=m
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=m
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
# CONFIG_AGP_EFFICEON is not set
CONFIG_INTEL_GTT=m
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ARM devices
#
# end of ARM devices

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_XEN is not set

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
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
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=m
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=m
CONFIG_FB_I810=m
# CONFIG_FB_I810_GTF is not set
CONFIG_FB_LE80578=m
# CONFIG_FB_CARILLO_RANCH is not set
# CONFIG_FB_INTEL is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_RADEON=m
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
CONFIG_FB_3DFX_I2C=y
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=m
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
# CONFIG_FB_GEODE is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_XEN_FBDEV_FRONTEND=m
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_SM712=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=m
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=m
# CONFIG_LCD_VGG2432A4 is not set
# CONFIG_LCD_PLATFORM is not set
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_CARILLO_RANCH=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_DA9052=m
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP5520=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_AAT2870=m
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_AS3711=m
CONFIG_BACKLIGHT_GPIO=m
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_RAVE_SP=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
CONFIG_SND_CTL_VALIDATION=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL4_LIB=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_WSS_LIB=m
CONFIG_SND_SB_COMMON=m
CONFIG_SND_SB8_DSP=m
CONFIG_SND_SB16_DSP=m
CONFIG_SND_ISA=y
CONFIG_SND_ADLIB=m
CONFIG_SND_AD1816A=m
CONFIG_SND_AD1848=m
CONFIG_SND_ALS100=m
CONFIG_SND_AZT1605=m
CONFIG_SND_AZT2316=m
CONFIG_SND_AZT2320=m
CONFIG_SND_CMI8328=m
# CONFIG_SND_CMI8330 is not set
CONFIG_SND_CS4231=m
CONFIG_SND_CS4236=m
CONFIG_SND_ES1688=m
CONFIG_SND_ES18XX=m
CONFIG_SND_SC6000=m
CONFIG_SND_GUSCLASSIC=m
CONFIG_SND_GUSEXTREME=m
# CONFIG_SND_GUSMAX is not set
CONFIG_SND_INTERWAVE=m
CONFIG_SND_INTERWAVE_STB=m
CONFIG_SND_JAZZ16=m
CONFIG_SND_OPL3SA2=m
CONFIG_SND_OPTI92X_AD1848=m
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
CONFIG_SND_MIRO=m
# CONFIG_SND_SB8 is not set
CONFIG_SND_SB16=m
CONFIG_SND_SBAWE=m
# CONFIG_SND_SB16_CSP is not set
CONFIG_SND_SSCAPE=m
CONFIG_SND_WAVEFRONT=m
CONFIG_SND_MSND_PINNACLE=m
CONFIG_SND_MSND_CLASSIC=m
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
CONFIG_SND_ALS4000=m
# CONFIG_SND_ASIHPI is not set
CONFIG_SND_ATIIXP=m
# CONFIG_SND_ATIIXP_MODEM is not set
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
CONFIG_SND_AW2=m
CONFIG_SND_BT87X=m
CONFIG_SND_BT87X_OVERCLOCK=y
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
CONFIG_SND_CS4281=m
# CONFIG_SND_CS46XX is not set
CONFIG_SND_CS5530=m
CONFIG_SND_CS5535AUDIO=m
# CONFIG_SND_CTXFI is not set
CONFIG_SND_DARLA20=m
# CONFIG_SND_GINA20 is not set
CONFIG_SND_LAYLA20=m
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
CONFIG_SND_MONA=m
# CONFIG_SND_MIA is not set
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
# CONFIG_SND_INDIGODJX is not set
CONFIG_SND_ENS1370=m
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
# CONFIG_SND_KORG1212 is not set
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_VIA82XX is not set
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
CONFIG_SND_YMFPCI=m

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_SPI=y
# CONFIG_SND_PCMCIA is not set
# CONFIG_SND_SOC is not set
# CONFIG_SND_X86 is not set
CONFIG_SND_XEN_FRONTEND=m
CONFIG_AC97_BUS=m

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
# CONFIG_HID_PRODIKEYS is not set
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
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_WBSD=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_GOLDFISH=m
CONFIG_MMC_SPI=m
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_CQHCI=m
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_NET48XX=m
CONFIG_LEDS_WRAP=m
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_WM8350 is not set
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_ADP5520=m
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXREG=m
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_MTD=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
# CONFIG_RTC_INTF_PROC is not set
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
# CONFIG_RTC_DRV_88PM80X is not set
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=m
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
# CONFIG_RTC_DRV_M41T80 is not set
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV3028=y
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
CONFIG_RTC_DRV_DS1302=m
CONFIG_RTC_DRV_DS1305=y
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
CONFIG_RTC_DRV_MAX6916=m
CONFIG_RTC_DRV_R9701=m
# CONFIG_RTC_DRV_RX4581 is not set
CONFIG_RTC_DRV_RX6110=y
# CONFIG_RTC_DRV_RS5C348 is not set
CONFIG_RTC_DRV_MAX6902=y
CONFIG_RTC_DRV_PCF2123=m
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=m
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=m
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=y
# CONFIG_RTC_DRV_DA9055 is not set
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM8350=y
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_CROS_EC=y

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_PCAP is not set
CONFIG_RTC_DRV_MC13XXX=m

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=y
# CONFIG_INTEL_IDMA64 is not set
CONFIG_PCH_DMA=y
CONFIG_PLX_DMA=m
CONFIG_TIMB_DMA=m
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=m
CONFIG_DW_EDMA=y
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=m

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=m
CONFIG_IMG_ASCII_LCD=y
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_CHARLCD=m
CONFIG_UIO=y
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=y
# CONFIG_UIO_PRUSS is not set
CONFIG_UIO_MF624=m
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
# CONFIG_XENFS is not set
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=y
# CONFIG_XEN_GNTDEV_DMABUF is not set
CONFIG_XEN_GRANT_DEV_ALLOC=y
CONFIG_XEN_GRANT_DMA_ALLOC=y
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=m
# end of Xen driver support

CONFIG_GREYBUS=y
CONFIG_STAGING=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
# CONFIG_COMEDI_TEST is not set
# CONFIG_COMEDI_PARPORT is not set
# CONFIG_COMEDI_SSV_DNP is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=m
CONFIG_COMEDI_PCL724=m
# CONFIG_COMEDI_PCL726 is not set
# CONFIG_COMEDI_PCL730 is not set
CONFIG_COMEDI_PCL812=m
CONFIG_COMEDI_PCL816=y
CONFIG_COMEDI_PCL818=m
CONFIG_COMEDI_PCM3724=m
# CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
CONFIG_COMEDI_AMPLC_PC263_ISA=m
CONFIG_COMEDI_RTI800=y
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
# CONFIG_COMEDI_DAS16 is not set
CONFIG_COMEDI_DAS800=m
CONFIG_COMEDI_DAS1800=y
# CONFIG_COMEDI_DAS6402 is not set
# CONFIG_COMEDI_DT2801 is not set
CONFIG_COMEDI_DT2811=m
CONFIG_COMEDI_DT2814=m
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=m
# CONFIG_COMEDI_DT282X is not set
# CONFIG_COMEDI_DMM32AT is not set
# CONFIG_COMEDI_FL512 is not set
CONFIG_COMEDI_AIO_AIO12_8=y
# CONFIG_COMEDI_AIO_IIRO_16 is not set
CONFIG_COMEDI_II_PCI20KC=y
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=m
CONFIG_COMEDI_NI_AT_A2150=m
CONFIG_COMEDI_NI_AT_AO=m
CONFIG_COMEDI_NI_ATMIO=m
# CONFIG_COMEDI_NI_ATMIO16D is not set
CONFIG_COMEDI_NI_LABPC_ISA=m
# CONFIG_COMEDI_PCMAD is not set
# CONFIG_COMEDI_PCMDA12 is not set
CONFIG_COMEDI_PCMMIO=y
# CONFIG_COMEDI_PCMUIO is not set
# CONFIG_COMEDI_MULTIQ3 is not set
CONFIG_COMEDI_S526=m
CONFIG_COMEDI_PCI_DRIVERS=y
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=y
CONFIG_COMEDI_ADDI_APCI_1032=y
# CONFIG_COMEDI_ADDI_APCI_1500 is not set
CONFIG_COMEDI_ADDI_APCI_1516=m
# CONFIG_COMEDI_ADDI_APCI_1564 is not set
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
# CONFIG_COMEDI_ADDI_APCI_2032 is not set
CONFIG_COMEDI_ADDI_APCI_2200=y
CONFIG_COMEDI_ADDI_APCI_3120=y
# CONFIG_COMEDI_ADDI_APCI_3501 is not set
CONFIG_COMEDI_ADDI_APCI_3XXX=m
CONFIG_COMEDI_ADL_PCI6208=y
CONFIG_COMEDI_ADL_PCI7X3X=y
CONFIG_COMEDI_ADL_PCI8164=y
CONFIG_COMEDI_ADL_PCI9111=y
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
# CONFIG_COMEDI_ADV_PCI1720 is not set
CONFIG_COMEDI_ADV_PCI1723=y
CONFIG_COMEDI_ADV_PCI1724=m
# CONFIG_COMEDI_ADV_PCI1760 is not set
CONFIG_COMEDI_ADV_PCI_DIO=m
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
# CONFIG_COMEDI_AMPLC_PC236_PCI is not set
CONFIG_COMEDI_AMPLC_PC263_PCI=y
# CONFIG_COMEDI_AMPLC_PCI224 is not set
# CONFIG_COMEDI_AMPLC_PCI230 is not set
# CONFIG_COMEDI_CONTEC_PCI_DIO is not set
# CONFIG_COMEDI_DAS08_PCI is not set
CONFIG_COMEDI_DT3000=y
CONFIG_COMEDI_DYNA_PCI10XX=y
CONFIG_COMEDI_GSC_HPDI=m
# CONFIG_COMEDI_MF6X4 is not set
# CONFIG_COMEDI_ICP_MULTI is not set
# CONFIG_COMEDI_DAQBOARD2000 is not set
CONFIG_COMEDI_JR3_PCI=y
CONFIG_COMEDI_KE_COUNTER=y
CONFIG_COMEDI_CB_PCIDAS64=y
CONFIG_COMEDI_CB_PCIDAS=m
# CONFIG_COMEDI_CB_PCIDDA is not set
# CONFIG_COMEDI_CB_PCIMDAS is not set
# CONFIG_COMEDI_CB_PCIMDDA is not set
# CONFIG_COMEDI_ME4000 is not set
# CONFIG_COMEDI_ME_DAQ is not set
# CONFIG_COMEDI_NI_6527 is not set
CONFIG_COMEDI_NI_65XX=y
# CONFIG_COMEDI_NI_660X is not set
CONFIG_COMEDI_NI_670X=y
CONFIG_COMEDI_NI_LABPC_PCI=y
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=y
# CONFIG_COMEDI_RTD520 is not set
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
CONFIG_COMEDI_NI_DAQ_700_CS=m
# CONFIG_COMEDI_NI_DAQ_DIO24_CS is not set
CONFIG_COMEDI_NI_LABPC_CS=m
CONFIG_COMEDI_NI_MIO_CS=m
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_VT6655 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
CONFIG_ADIS16240=y
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
CONFIG_AD7280=y
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
# CONFIG_ADT7316_SPI is not set
CONFIG_ADT7316_I2C=m
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
CONFIG_AD7746=m
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=y
CONFIG_AD9834=y
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=m
CONFIG_ADE7854_I2C=m
CONFIG_ADE7854_SPI=m
# end of Active energy metering IC

#
# Resolver to digital converters
#
CONFIG_AD2S1210=m
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=m

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

CONFIG_GOLDFISH_AUDIO=m
CONFIG_GS_FPGABOOT=m
CONFIG_UNISYSSPAR=y
CONFIG_FB_TFT=m
CONFIG_FB_TFT_AGM1264K_FL=m
# CONFIG_FB_TFT_BD663474 is not set
# CONFIG_FB_TFT_HX8340BN is not set
# CONFIG_FB_TFT_HX8347D is not set
CONFIG_FB_TFT_HX8353D=m
CONFIG_FB_TFT_HX8357D=m
CONFIG_FB_TFT_ILI9163=m
CONFIG_FB_TFT_ILI9320=m
CONFIG_FB_TFT_ILI9325=m
# CONFIG_FB_TFT_ILI9340 is not set
CONFIG_FB_TFT_ILI9341=m
CONFIG_FB_TFT_ILI9481=m
CONFIG_FB_TFT_ILI9486=m
CONFIG_FB_TFT_PCD8544=m
# CONFIG_FB_TFT_RA8875 is not set
CONFIG_FB_TFT_S6D02A1=m
CONFIG_FB_TFT_S6D1121=m
# CONFIG_FB_TFT_SEPS525 is not set
# CONFIG_FB_TFT_SH1106 is not set
CONFIG_FB_TFT_SSD1289=m
CONFIG_FB_TFT_SSD1305=m
CONFIG_FB_TFT_SSD1306=m
CONFIG_FB_TFT_SSD1331=m
CONFIG_FB_TFT_SSD1351=m
CONFIG_FB_TFT_ST7735R=m
# CONFIG_FB_TFT_ST7789V is not set
# CONFIG_FB_TFT_TINYLCD is not set
CONFIG_FB_TFT_TLS8204=m
# CONFIG_FB_TFT_UC1611 is not set
CONFIG_FB_TFT_UC1701=m
CONFIG_FB_TFT_UPD161704=m
CONFIG_FB_TFT_WATTEROTT=m
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_MOST=m
CONFIG_MOST_CDEV=m
# CONFIG_MOST_NET is not set
CONFIG_MOST_SOUND=m
CONFIG_MOST_VIDEO=m
CONFIG_MOST_I2C=m
CONFIG_KS7010=m
CONFIG_GREYBUS_AUDIO=m
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_FIRMWARE=y
# CONFIG_GREYBUS_HID is not set
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=y
# CONFIG_GREYBUS_LOOPBACK is not set
CONFIG_GREYBUS_POWER=y
CONFIG_GREYBUS_RAW=m
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=y
# CONFIG_GREYBUS_PWM is not set
# CONFIG_GREYBUS_SDIO is not set
# CONFIG_GREYBUS_SPI is not set
# CONFIG_GREYBUS_UART is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# end of Gasket devices

CONFIG_FIELDBUS_DEV=y
CONFIG_KPC2000=y
# CONFIG_KPC2000_CORE is not set
CONFIG_KPC2000_SPI=y
CONFIG_KPC2000_I2C=y
CONFIG_KPC2000_DMA=m
# CONFIG_UWB is not set
# CONFIG_STAGING_EXFAT_FS is not set
# CONFIG_QLGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_WFX=m
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DCDBAS is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_DELL_RBU is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_PMC_CORE=y
CONFIG_IBM_RTL=y
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_MLX_PLATFORM=y
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_INTEL_ATOMISP2_PM=y
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=m
CONFIG_CROS_EC_SPI=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CS2000_CP=m
CONFIG_COMMON_CLK_PWM=m
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
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_INTEL_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_QCOM_GLINK_NATIVE=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

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

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=m

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX77843=m
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=m
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_ADIS16201=m
# CONFIG_ADIS16209 is not set
CONFIG_ADXL345=m
# CONFIG_ADXL345_I2C is not set
CONFIG_ADXL345_SPI=m
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=m
CONFIG_ADXL372_I2C=y
# CONFIG_BMA180 is not set
CONFIG_BMA220=y
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
CONFIG_DA311=m
CONFIG_DMARD09=y
CONFIG_DMARD10=y
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=m
CONFIG_MMA7455_SPI=y
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
CONFIG_SCA3000=m
CONFIG_STK8312=m
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
CONFIG_AD7124=m
CONFIG_AD7266=y
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
CONFIG_AD7298=m
CONFIG_AD7476=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD7606_IFACE_SPI=y
CONFIG_AD7766=m
CONFIG_AD7768_1=m
CONFIG_AD7780=m
CONFIG_AD7791=y
CONFIG_AD7793=y
CONFIG_AD7887=y
CONFIG_AD7923=y
CONFIG_AD7949=y
CONFIG_AD799X=m
CONFIG_CC10001_ADC=y
# CONFIG_HI8435 is not set
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=y
CONFIG_LTC2496=m
CONFIG_LTC2497=m
CONFIG_MAX1027=y
CONFIG_MAX11100=m
CONFIG_MAX1118=m
CONFIG_MAX1363=y
CONFIG_MAX9611=y
# CONFIG_MCP320X is not set
CONFIG_MCP3422=m
CONFIG_MCP3911=y
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=y
CONFIG_QCOM_VADC_COMMON=m
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=m
# CONFIG_QCOM_SPMI_ADC5 is not set
CONFIG_STX104=m
CONFIG_TI_ADC081C=y
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=m
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_BME680_SPI=m
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
CONFIG_PMS7003=m
# CONFIG_SENSIRION_SGP30 is not set
CONFIG_SPS30=y
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5421=y
CONFIG_AD5446=m
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
# CONFIG_AD5592R is not set
CONFIG_AD5593R=m
CONFIG_AD5504=m
# CONFIG_AD5624R_SPI is not set
CONFIG_LTC1660=y
CONFIG_LTC2632=m
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
CONFIG_AD5755=y
CONFIG_AD5758=y
CONFIG_AD5761=m
# CONFIG_AD5764 is not set
CONFIG_AD5791=m
CONFIG_AD7303=m
# CONFIG_CIO_DAC is not set
# CONFIG_AD8801 is not set
CONFIG_DS4424=y
CONFIG_M62332=y
CONFIG_MAX517=y
CONFIG_MCP4725=m
# CONFIG_MCP4922 is not set
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=m
CONFIG_TI_DAC7311=m
CONFIG_TI_DAC7612=m
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m
CONFIG_ADF4371=y
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
CONFIG_ADIS16130=m
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
CONFIG_ADXRS450=m
# CONFIG_BMG160 is not set
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_FXAS21002C_SPI=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
CONFIG_AFE4404=m
CONFIG_MAX30100=m
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
CONFIG_HDC100X=y
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16460=m
CONFIG_ADIS16480=y
CONFIG_BMI160=y
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=y
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
# CONFIG_FXOS8700_SPI is not set
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_ADUX1020=y
CONFIG_AL3320A=y
CONFIG_APDS9300=m
CONFIG_APDS9960=y
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
CONFIG_CM3232=m
CONFIG_CM3323=m
CONFIG_CM36651=y
CONFIG_GP2AP020A00F=y
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=m
CONFIG_LTR501=m
CONFIG_LV0104CS=y
CONFIG_MAX44000=m
CONFIG_MAX44009=y
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
CONFIG_US5182D=m
CONFIG_VCNL4000=y
CONFIG_VCNL4035=m
CONFIG_VEML6030=m
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=m
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Digital potentiometers
#
CONFIG_AD5272=m
CONFIG_DS1803=m
# CONFIG_MAX5432 is not set
CONFIG_MAX5481=y
CONFIG_MAX5487=m
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=y
CONFIG_MCP4531=y
CONFIG_MCP41010=y
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
# CONFIG_BMP280 is not set
CONFIG_DLHL60D=m
# CONFIG_DPS310 is not set
CONFIG_HP03=m
CONFIG_MPL115=m
# CONFIG_MPL115_I2C is not set
CONFIG_MPL115_SPI=m
CONFIG_MPL3115=m
CONFIG_MS5611=m
# CONFIG_MS5611_I2C is not set
# CONFIG_MS5611_SPI is not set
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
CONFIG_T5403=m
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=y
CONFIG_PING=y
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
# CONFIG_SX9500 is not set
CONFIG_SRF08=y
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=m
CONFIG_AD2S1200=m
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_LTC2983=y
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_MLX90614=y
CONFIG_MLX90632=m
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=m
CONFIG_MAX31856=m
# end of Temperature sensors

CONFIG_NTB=y
CONFIG_NTB_MSI=y
# CONFIG_NTB_IDT is not set
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=y
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_MSI_TEST is not set
CONFIG_NTB_TRANSPORT=y
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=m
CONFIG_VME_TSI148=y
CONFIG_VME_FAKE=m

#
# VME Board Drivers
#
# CONFIG_VMIVME_7805 is not set

#
# VME Device Drivers
#
CONFIG_VME_USER=y
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y

#
# IRQ chip support
#
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_INTEL_EMMC=m
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=m
CONFIG_MCB_PCI=m
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=y
CONFIG_RAVE_SP_EEPROM=m

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_MACHXO2_SPI=m
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_FPGA_DFL is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=m
CONFIG_COUNTER=y
# CONFIG_104_QUAD_8 is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
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
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set
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
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
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
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=m
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=m
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
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
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
CONFIG_STACKLEAK_METRICS=y
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
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
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_CURVE25519=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

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
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=m
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=m
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=m
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_586=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
CONFIG_CRYPTO_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
# CONFIG_CRYPTO_DEV_PADLOCK_SHA is not set
CONFIG_CRYPTO_DEV_GEODE=m
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_CRYPTO_DEV_SAFEXCEL=m
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=m
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
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
CONFIG_DEBUG_BUGVERBOSE=y
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
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
CONFIG_UBSAN_NO_ALIGNMENT=y
CONFIG_TEST_UBSAN=m
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
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
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=m
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_TEST is not set
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_MMC_REQUEST=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
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
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--qwWC3uIwaXcGNtT+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='/lkp-src/allot/rand/vm-snb-i386/trinity.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-i386-14'
	export tbox_group='vm-snb-i386'
	export branch='linux-review/Qiujun-Huang/kcsan-Fix-a-typo-in-a-comment/20200228-201130'
	export commit='216e0b7a586b92c286da611aad11ec36e8985755'
	export kconfig='i386-randconfig-e002-20200228'
	export repeat_to=12
	export nr_vm=64
	export submit_id='5e5e830da02e3b10ea49199f'
	export job_file='/lkp/jobs/scheduled/vm-snb-i386-14/trinity-300s-yocto-i386-minimal-20190520.cgz-216e0b7a586b92c286da611aad11ec36e8985755-20200304-4330-u6qq9b-10.yaml'
	export id='986562f22bbad45e86cc2fc7ad17d7dc0d9e6e1d'
	export queuer_version='/lkp-src'
	export arch='i386'
	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='8G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export ssh_base_port=23032
	export rootfs='yocto-i386-minimal-20190520.cgz'
	export compiler='gcc-7'
	export enqueue_time='2020-03-04 00:17:21 +0800'
	export _id='5e5e8314a02e3b10ea4919a3'
	export _rt='/result/trinity/300s/vm-snb-i386/yocto-i386-minimal-20190520.cgz/i386-randconfig-e002-20200228/gcc-7/216e0b7a586b92c286da611aad11ec36e8985755'
	export user='lkp'
	export result_root='/result/trinity/300s/vm-snb-i386/yocto-i386-minimal-20190520.cgz/i386-randconfig-e002-20200228/gcc-7/216e0b7a586b92c286da611aad11ec36e8985755/8'
	export scheduler_version='/lkp/lkp/.src-20200302-232359'
	export LKP_SERVER='inn'
	export max_uptime=1500
	export initrd='/osimage/yocto/yocto-i386-minimal-20190520.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-i386-14/trinity-300s-yocto-i386-minimal-20190520.cgz-216e0b7a586b92c286da611aad11ec36e8985755-20200304-4330-u6qq9b-10.yaml
ARCH=i386
kconfig=i386-randconfig-e002-20200228
branch=linux-review/Qiujun-Huang/kcsan-Fix-a-typo-in-a-comment/20200228-201130
commit=216e0b7a586b92c286da611aad11ec36e8985755
BOOT_IMAGE=/pkg/linux/i386-randconfig-e002-20200228/gcc-7/216e0b7a586b92c286da611aad11ec36e8985755/vmlinuz-5.6.0-rc3-00029-g216e0b7a586b9
max_uptime=1500
RESULT_ROOT=/result/trinity/300s/vm-snb-i386/yocto-i386-minimal-20190520.cgz/i386-randconfig-e002-20200228/gcc-7/216e0b7a586b92c286da611aad11ec36e8985755/8
LKP_SERVER=inn
selinux=0
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
rw'
	export modules_initrd='/pkg/linux/i386-randconfig-e002-20200228/gcc-7/216e0b7a586b92c286da611aad11ec36e8985755/modules.cgz'
	export bm_initrd='/osimage/pkg/yocto-i386-minimal-20190520.cgz/trinity-i386.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/i386-randconfig-e002-20200228/gcc-7/216e0b7a586b92c286da611aad11ec36e8985755/vmlinuz-5.6.0-rc3-00029-g216e0b7a586b9'
	export dequeue_time='2020-03-04 00:18:07 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-14/trinity-300s-yocto-i386-minimal-20190520.cgz-216e0b7a586b92c286da611aad11ec36e8985755-20200304-4330-u6qq9b-10.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--qwWC3uIwaXcGNtT+
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4TY4NZFdADKYSqt8kKSEWvAZo7Ydv/tz/AJuxJZ5
vBF30b/4YMqRSKgGmYMJdYhPOw5CuX6Pjwn/OgyS/cn59qfTHJ5T15zGlBtnLsne3nvGjViM
SU4X2El2bTyp0s8EvabgwuO6C06Djmps4mW+YX4uaKMUeyLTNZjhMhoY4LQM2UEtAX4RtNqo
9rbsfThnMlbNTlyfkODrIGbrcZT/0GjNbea74UwPlKNhxxScYubqw8HPVk5OLJxKTYtmJaPq
yIb2YfRXlRGDPSl5fFkE6yoVZXJTj6iwZeycPgRGBJZi7yl6RhR0tsvUwKJ/9ekA+4mthhdx
Tf8FSMOJcGsHWF5ic5jpf0gb/46SEs09dhKzqOrp2ARJecI+0fiUdXxnaDJjVz6QhOPtH3KK
ERomFdq759shUfwlFchuHciA2jXYKZwbkNK14J/n+TWzxrkzC2jEgJfw8geSUjFTt0BZazVW
7ZC3f2MzXZQ3xv0oIC976cssyOXVzTBEhKq4djFrf/hqUAK4Xh46GfkA5WMUldtEdOytX/uF
k8emkl8HajMuSFVyDadg7PMwnByxekTW9RAoeAUyzLHd3IrDTJvfJYa1RMd9fgTwLaQ/GBrz
ifPZGBX6VDQVaweRSh9u9tjivh4KVz+1WN3h3JZJU2m1eZjlRkblVA8cemZw4/1WlZZ9sYDR
ISlD06ElrpCKswrLUIuisTA1XKXyE1+PDmcoYkeN5vG10fWEblv3tlwhZoyemikz2ks/1OxR
cBKlaeEE+AEWzcJMdfjOjrEbaUpgK4q8iOxUCZcliVTOAS7XsusUthpn3ZZZo9zi5tfUeQn7
SSHi5XlqYUGFVHwy5byGCXwFQqeQBYlpdGTKTCgURgl7FUfIoXvtoeeNh0S+rM9dhCkzywn2
7eDL0MZyxxDjgZ160aLY4XvyodbyZIPVDPseeW1zPyAuZPQd3ua+v1flYn28aOtmPNLDprS1
Y23ui2kvzBZ0OzP5QPf8Vf+CxiichvTJvXLn/HFnjwBm5Ozn5/QmtmtQpO4Mhmi9wWl4V5qP
/kc5Of9U4lpWSZet9j1kOcxmztUAiFcL94aoFBEz5ZawTaOc8RxlGxNIeWmHCZgIK2yaMtrN
Lk23RNLSgiECpVI8b5NTljCZ1ob1jYaJ6mSzWblFpNxWtwswWlo8+WSyi/hvh+EIroQ/gLlR
iPAVheEhupox7SLOdSFhznJOnrQtguD6anRSrxc/gCp9+WlXZLOo8Umh6RT7Df5bqGBFRyrI
CRGzXPbS+FRmM6r6AdXEZQoVC1Z6foKaFVIreuxdwO9o2oP9U+GsLGCcfKsxRM83NoqIakPY
Ejk4of0fDykhTXLAIEZuTfxz7GSitbmWylO4SQPYDSK4hK44Qr493l0ekPSOHuDL8tQU6KJ4
SCA94vi+0LV7+sckQKKFLhin4blDqVTw+J/rUzSDH8NhZ2mLxbh/D4mUPKs4f2oMjKrF8sDZ
TLvVZSvHbkIFc1T/+gSglWbciKXH7E9RzK5bfq/qn7C8GH9Rbd4P/jIo8vyYllgtc+ZX46on
RXN/kmnKiSd1y+IW2UL2zFt0JqPWyvg2Q9AqRc8yhqt3JT9Yb+N3fiQdH/L0g0C72VFKX1mT
e4Y5c6tPwWRhREOjbzIchI6XABKu/i5om5tv3gStp16mMB7alF02whGOwpqAMVMnNaa+cU6c
gEE2Yxlb0eykeTDQ443XUHOXP30nbRFv2db3SHU7lDLztZe6Vyib4eU0lJ6L3GXKa1gzod5T
RobldtKRsxeDp/Z+qTYccMlSm6XZzT+bZQe4C1BjL88v7VG4Agzkc7OGEuUgZV22uQk4i8SI
ItFRQA5rnE200k/jahy0D6b//uPIqrOcmzkZJduEeQH53kHqZimYvcA5QSKhYOerZ5gchmaA
aKVBGaFCNgyKUuTYbboSGdKTTDlrdD1IR+PGlUGWTAkSoCodfcYJ9UwoWhm7B0QZUTDVaX+z
8ZmzCzPiFabqwNk1yFp4A3ikciF4xp0Zaw9YzXvi5aqFwV24bJXQoKIFZANYPVfb17Wn+xRy
wFiH7RPFPcmQ1JV+sYGhKYR+iQi5BR2oLOgNwsluBslOe2UKLEqywKsgp+XPDpgy/eXmkPoK
uU4tgW57bY/FSiq51G09RE3aQZvPDAe844FIfXV+I2/r84QWhpwtowW5TN0ulDJzlWmX1WJ6
AeyA3maa30ENrd0gbdZnCOPNOhlp0ga5rZ5vygJRzFxdqPU0OasqjFQSILAxvJgP9PZcggtT
ThDWdStWdBUzKLP2VhJ1X8fKqhhcwwbamgpPoS/+W+6+YYPxQZ9Ah0PhupsFQ1NqUOtPzGM7
V0zL+Ngtu4A9f4QfsBDSCaL8cLysRE+9BaW06evRwaPZGSU7KhkcTDCAZA9vGZHyOxDC0NnY
dugdbqO4JAyFh6vhUFRdzl5zKpd5rKVmPJ+rSej+lowY+iT/6GUULA3WfjVUk4ClOE1ZkNpb
kFVUQUBkc5jzF77YZtNbC6M14h7AtbI9QP4Kb+3ERekz5RQVWMEEP3R+CUJIsN0DGWIcG6As
sdGw8F9uW60Ez4/GlWoIxg1pd1AwikvpBdWYCpi2He/a3xHGoU6ty3wr0JqonlddXoy1oLB8
UlCTh7kiylEtq4H0LEO991zjeRvS5EkPrRNOsAf8iQKEZ4ArPMvJk19tub/Y25mSYxELMLu9
0wDilBLbU05662NG1dgJWVcgbM9YWz1F0Lzl1a82rI5fDpanvQhkhTH4oNHUyH+ZI25vvTX3
7zzQuBbEhb/lreajgpWJ5qq/Vz2qaJ9stgBrdZIw5vfco1Bb2FlwlGC1x0Gv5gOPx0Z8PL7g
mRsDZT0W95GZ3CyIGO3DLVo1hNPZxlDNNBp68y0W/gNM36QXm49KSCfHPAVprYnA/YYEMBSl
bY5BakUx4wE07AtB9yzUyrd7seEx8V7K7U/Qo3NSRyGIlJiEjAN148O9ef44iMtTerNgDlNA
s34OSc7IstF+EYdS9dpsZ7ywQDbNLjBiEKPRjB+1ur2QVxlQE898S/muzgEhcYTvIFGQkvnV
FJsAPQkTNIK6OtyImwYE6pgZEY2XWSC8akPrCP/EMGWSHU7QkuOk9dbXttByAeeo/XNA922/
t8+Bv1ZgeC1bmR3EEfTBFkfF0gl/7BOG8or9lHLbqr6kY4HHhgJEcwZ80sRcGmTMVa+/IU8g
1SFHe7slXO0Dqovu/U42WNGEHW3V3jrHxxP0m01yom+cmuMpwAyFuhgMD5RsX7xDnqKROJJy
njlBLaJhiJNgF3O0suqn2HpNCCG6r3xuLaaesWnNjCTTChiIGfrVBYH3HdSKixu5ymDIP2AB
AD+7JIwY+zELWMFHjxjSzLbqdzV4bz5QNC5gmEahvMAToasJeO0FeqbeZOs4hyWfTM6Bxwo8
ydMgfKbLzROQeZdC1l8OvYTrfedIE3gRZ3Txz6gv17KhIBeMtxdg7aTuRKEGjDZIJYQHUISC
S6L03a9sZMoyKV3PvT4RSTiRZ+2g4NuiNnnat+HyJT4e4Rk0+eF8Vvv4KWeii3Elv4qWhkY6
/pgdlIUsZDVWUA+byHmuJgg+pjHPyoX2Sm655cnkz0BepCKzU2jrqAratrus4V2OHo9DFH1K
Wfp1zZb0pMUn+f6niwd15zxGnIt05Eiah9VvQq+ABqBsackVg3Lzkx0n8B3byi07GCY2F5kW
3fSUewxqV0cR0dyo5GbYAWMgMdpJpAg0zFVQiC6Mvwiqv42UkYNAOAckLoxdJVUGxOIbJTm7
bu/A5vqU7uPUjuXoJt1gMom4+r1StxLC3uLr/X8yjr6Fa47JJ2iCOLcoElRY57luFA0bbQjO
g+6ApC7tBaYRej1gPXq2YZlY+jfsAVMRmcf4RE3Qp7R4wVb52dp8L2VbJC5UmWZuQuz+N0d9
kLXGfIpPndOB8miPwpOAakjpN6DhyNrsIiAfye8gEHUScywQ+O/2d+c61lf8iF7Q/fD3c8PG
q5t4MZyLsA0ReyjPdxUQFrelFDT4R9kQNaTtl0AmPK+uTXd9utV6DfkKF1f4Tq6sZ5Givd5Z
f6Tikc/qU0DfTRJoWvDfS6/HG+uY/TBzyAqKtL41c/3D+uKJbOdMgjIfH+4ASOdieNe+gOWE
3yb0hgtIqiXINvAYCHaFMiSQc102atOfiShhg0BQ+eD24yVelY5G4VlSmw6TFg/uEdbD8ER8
INlaCZNcSVIQjPaSItZiN9r7YKWau8b/bm/2wuPSyhRI/Xw/2rOewLOw+7W4Wr8a3yZZQwzo
cMluWGFeQ108HcFp7NJNQvqNKGTCcKkil/srIfm74H8G4OO7AasB8LX9pYXKidhoNECJ0FSt
LzlEe0Uupapa5Mr/5Ow79flN4aoKOLLijRBZO7165Pf6w5L5akmGDZb1xzueoBR2Q6BvISk4
ws3875Yyd/WJmyoR5PW1AfV2JtEwBTzcDRjDzTF+J5anvwe0G8+OxM3+ImX52dIPPJXgpzsI
VqCLj2jpRgXdTFURoQaaPdcptzboPoK6TKQgVmuQbwyyTgRMzsxLqqw4r0f75mGxkEPjSsuG
5HgmZTIn2WWsDFAnRo1Pq7lqBoD8ZU5e1g9vTfv63KD4+tbAN0//WWitZTEVGEE6XdaAchxy
Z49+oJez8h0ioY6Cx9GKkZRDj7Nl7mciOIwZm8HwfeshlfWLd9NXH5Nb4lD/ZI0qP4pjsYJH
NOGbCF2unx9VA640ou6fCeRk6c+Ssos1fDyh5QqnPTjddn6/t7Il5P32QLxvYtVOPYhYUSjx
mymYNeYKUbqZhCSDsoRAp2AAZTE6e8T+iRWpISoaoqYpEG14MQylHleGqCYha6rozXEpSKys
cle+OPRsSiXU1XNdgNl5RyKkZG01LksoxJwpQVaelq3zdjhmSl9MlOhYAGW3bSfSq3zuUsgE
oGny8HqcyaLcZlYkgxS9nf+QC2r6G2hRZHpfQsOGDsTpHSuPJFAJ7nXNKLoki485xbma3iKY
P7xKrCGlKxLw4OPc22m6N1bliUF/e6jauEnl3xMRdANdt1npCx5DKZy1ufzq8YzwXP1MDb0N
5O/OWBv8yIVf2mmXZI+QU/zZmkMq4yL3K7qZ2GIv5Tz/8hqYpJT/11VCBGj5mOjzd2WksXNT
15BypL/dZFXXipz7Gj9GApqoRYKwW2upKlkj+qheqQfJ/LMZV0oz09m8f4/yE1bEivM8+b9J
rUXnw/KZQJl+vUwiml6opDNUARemu2bmcST+Y/XYB8Nuh4rJGKmrR4nyJY9FFADmwpoVa7Et
E0mlRXXFpMKMz0/TQUX9H9CgYsZkYr9IxPBKqur2Ey73BVTpSFDSIuRKofjGKN9KtOqIhSHM
aoV4nniHRcn8KHluoJior98uay3a3XbS4S2ce1+HEJfZKTqGV0qd5oun16qmmN+hm4qe6BJZ
qofAT99fnLZUIPHDbnXg/q89iwh6kir56aH1AuA2F80b5aqt/46GCMxV8jPgZiNXBViYKQH1
xX2rkNKjckhXkfJ+t3Q9AaUzelH03QzPLBWWj5bRei7lw2j1IWfJPE623Xf+ugH+DL9fxJpU
NwXRB7f6po28uajbpCy7SJwhQOaeKG2v2j7jWmzMKL2yHcX++UMdo6YMr0AdZTlIvJPnTuUA
0ms+z6pbMBzOwQZP9OGiDb/LKd4W/eniqEiPM8m2gq/ytQi9OcRqou3ewnziicV7EjrSN/9u
ICs/GV8kZoJr2byHXMQlSVZ9bilKGHR/WF599W5BkBQJZe9+lmjfytrzPFpx+p6zg++HhLvp
niOVhEvAhuoU5Ccmj2ctmzeUGY0YeggvEEkvKG9zdiL0Z8w1tOsjGHvia6dUWdRglkPraYwK
0fTWG34+GJ7C6og6D7Ph+E3Pa2BRGuGecvArbWzwDwQe0e0FamhgfiS25Zy0e26ql/LAEZ95
T9ZrD54B4G0Lk9Cc1Atosq3d4l/SGXAp9k4RDtlicc7fIQC8/7jmvak0mO4oT73TFW+/5Q+Y
IEOOwafEnKL4aQ5K9NS+6qnY4AuhBZafkdgzS64gB8Ni8S2aOt0ZuGSNdsGDzJkHHAnfrtGD
BrCgq503E0mtKCmknIO1AkC875TAiSh4PRes4T4OyQklTF3/U+u+00WUy1ETsH+VmQuERUxP
kgycVU+C2tVefwpgdw6gNUJl/ZpBdgtR8afaT7NiO69hBfWpqeK+jp3NoDWuraNILYDrSiz5
F/xdd1dm5jAr9X7uE3jbYWXmZjL5TpuzYtfItDyXprqW29WoT3vr+EWsRAhzMWoVqEWBCbvo
zeV3NBih+5sdEz+7mMXEpk1EglHKrrbt62gFKTRclcFr3/kjydPPa1ktytZdNisALUbbfjEq
7QYVMvJnCG83NQgFcWkTNCwhxJgIHPmAs392Cd3uNxVubierILy1ezYscMsEsS72NP4bEWFZ
kztMRMq74B6uNeeb7wOVqQk+zCYnCWiqW3ewUAtU74hBWxeZOEXren5bTppou1NIYb2TuEWK
4iHYvGZONWcjbx2WzZzsP2gpysJza/yyiFxrtu0VizwE/GwmW6S6t8XzzAg+K/nKuzv47OPH
uvIHKVPtb60vmyiVwuF9tIo5LWmWazS1oX0Y9Aj551grA77zPKg+OaOyP4Kn9sjjkKXQhuT2
IC+tswnaAP1yEkLeeElSaxEXWszACe48vWcL0awg/I77QDQ7uxIJ/Y9L7pvCY234Hxa8zdRA
LXgVGS4Y80CmaAzF7y5x0yTbzLmaRE+8zYUkI93fbJMK1SuNaeGCSRN55KCpsV3DW9jbv2KS
TSisiSUQ0lP7b2NSzvXzwOFVxz3wIqeyb79dvZKkOdiFicn7JuVy03hHvD2rZOTH07Cz6G/U
TiMNoy+HfqIGC0lQps9z5KX4XSC7mf317CBcE+vZSLHmCOqfThF9rEszx0rafhrKoTasSahM
Xx9JgEnPz0CmqKqI2bvBvVNnSUr/XOIM2UIH8TfbJ3touQNRzshlQVibh4ErCyj2ZM0vW5Yr
zR5iD0zab1lO/xabFYqmbDwZmVPFyclWeSwJYU0J9qnmdxtR+ycoYnJucvJbmVHWEY8fSuhs
KU29EyKJJm7BhNqPNHFqlIsRGeCQoqOPyWa51yA/JZj/ESPpc1GrmzuEd6uxrx4+S8grs+Ct
dcDBdvid1rbOGxWjDNL7oxqNKdkfIUJea5xXVTQhsQtM6EoYMnetbv0Kgf7vrcfq8X0Vx1NX
K6OLOEUeTBSknnH1Idqpx79DPvGvTnh9Yd333hDN2qkGLhbq4IHWNM3GZjtrt+2as13tH/Cf
Jh3uQHsYczDDUetIdJqMM+HrOpEm9XIJ67LXXgXp8vCtTe+XnQXwHcThAq3Alj1YZ2kULelQ
SLlZDPP/7uwo2WFMq9zMJjpP5hleGzxdeGuD+jNdRmjBW2F8aaAwL2nBNtyi2Wx2r5SDTMY+
ZsgMa58Yeh++J4yaqDKhM1+ay5lpwLciRz1gOgyLSdpXCzdgXMideZDRl7qz6w0ORBjeMP1K
LXg6i2K14bTYx6eJelXTpK3ybh0y+ZSdK7/USCIWbwbWn6/qbAbTCA6JBXxYD9hFO7Bw+F1l
TeJ8fz2qT+y4XyiKnTXrOLFjH3PwO2j7XBkzrLq7izLDTRoI177YV+MDP2mvAuPj6aVobPA7
wj9IWg9BmoRkoPa7tdixgqoGIGra6zsK9JLTjPAvpQlD/p0NaO5IcAhZItzW1RzrgbFaBbNE
K+07QkIHrlmCM73q7tCbAxESi2wOpJYN/iEMMRzBokZtiwjcG7ct6bACQMHFBTCJbf70a0Qn
JSVf3LuVXGVnTkSgMpwRFP6/1IGk2zmJpREZFw/hYkv5u4NkZ7/XviANzcMsuYmBnyCEFGqj
FcaE83gMVD9k/awe6ane3rMONi+bHuKySsxamCezEhlI4TA9eem2jM5OQUyJmb3/7UdrF9xv
QeOKcTyLSSgVsrk7G3kKDbQd/RU1ui/lmXc0Ti88EgxJjPTcg8w5vn5K1flwsWKSg0vn94cs
uZH10NauoID4pJ7veA5cXOmcZpoBR8jUovVABglqrxBLK47bZ0YRjyuGhVfGTkHqdpSp39gw
EwTDCriHejy2p0RiHwVZKQSQ2CuAqLNWFCaCJX8MJ4xm3gQ8YhsgUuAZbhOhy4rFHq26LqS3
dMvs2Mk8wsS/w6jEfnERYOrBBFtwghOFMoj2in/LiRXxur0Pp1i3nUnSzve0x55GKYAj0DQc
0Y8lx+joweNUahPRS0o5+awnOhduU0r6tyj4IbVwMqnb6g3ZjDDYOaJgxA/+7abvMzB6nUoF
zGfAiioJIFflTLxVQ6CEkd39ZAEhMbZGiA36b3IpjaZm1EsrIyaJbGzJf4ZzQ6v22RBWs/zV
J1/kXlnz0ZqjlWObDeXW23sXVJBQngF5OY5y5Y+k2x7wgD8UctQWqZaYCNAWXLbqdqVnAgHJ
+txurYa1ynS9koAInnOkMiN4IewE67fm5+d/oVVFPhk5dEbuAe8PGvr2ir3sS5m6vCgk+xQu
pB+JUgs+fuFc/3nWTh8zjPkD2dTruf8GhEzyeSlLtwlYq0vNVTP74halLXPfi1Aa8ig9n3kY
swNpC1BEG0845ZK3WFid8tvVrPuW/hbdIoFYrnLXw7mXPk3PI/rXxXxXdoKp6vuuW/Kpnubs
j4YThvHMvoNg1Vm337z/KD8P+fVbRAn9Od2PpI8WZF1I1Ih9/Nj35ugxNCO0n5/2HSg6kxmm
89GwrMkyq40l9rGSEAjeWpISHCKgqBWqjJSJYvKFT7dFgUA66osnOGHXp3s01xvtUdbWum1N
pR6bk6lFuq40P05X3yMxjSd1JYXdSSnXVbsEz5bKaLUjBeZWgAIAtYSU25GGjMll6ldHL22J
u4fdFifKMOGw/fea+b9EFCSHpOnrpS1oRN8BQg7XnDZ1C1TNNAC4OPKoRsF+nOE/i8rH+ywx
9OdoRf+WtBbEXxf1voC4F/7oFyeSSl4Q0C7aYCcGOocsNzAWt+NAjPLRJv0Bxn+da+0hCWq7
y+Ra5Z2oZ4zuJHEIJF53qAKJBhc2NxCCkoPiY8QguEi/eckemikybuTghiil+YyanrVIaVGD
7VDq7YLMsH7z2nqU7b/CI3biqJ2Ewxd/k4ZE5f6Xncre3YFnIrbRcdqBAj1uFndjHjISBRGm
zeatWC6J3JAX9yyX+k1nlPSGTcAAIY/MzuyvaFYkpFNjX8vGdJfDHzVn7am3QabEACEK4mHO
PxIIEHdLLvzX4RE9jqLhfnCaB53xf3Ch2qEeqcwaIaGuYjyFz26sxpDyB0ThdyYwGWIHQnZa
JtwFMOQ2Rf+R1VqOYF6c6mraRjTs6Ako7lZvyCYaq96YTgGIZLwmdDPamhCzJCViVJyfdX6C
XsL2FrQlWsAVWXbqiGmzPZYNNlKL7SMvfqxI3F0b588eRNd1WezKC/h8BbUPMLuiOIs6IXJj
DsL1WB3VEHTGVbAIKXqpQly4n8xDnFfnn4442spXe2ibrHy94UjqnSGnJAG4rlv/x4oYqybc
o8Lp4intGgTQ6YMFQ3u+xHGnbjCGkEQPUt/6m4Aj+4A3b7rh37SSyRug11jiBfBo/AXt9LnC
IX8veSKL0X+cbIAwJoUUoa3pGpU3iVEzOQB7gFgTEz7ZfDEgVxZ2TAL96JebNiHbScgLaZqO
m974uv7Wc893dSIuSCMaHSYC/a/hFDLn7rop2Pgp0uQbLQs2Dt76eT6l/OPaXkLDwtg9kxoB
vpJpIPR9g0E/5pYTuQeud2jSthp8woK9SMiDJOjIMhjJCSJjZGlWnKaOjLsikOgsBfpjMLar
Mrr9TrourMSYekJL8NIK5gXvui5z6mdnSyzuxi64NDrJwT3BAcg69Ti3uOJw5KD0Ay1SKtcY
s692/LF0hIapLGgbfX0RyZKLikxjLT187g3qen4TsJuyaTxvk4O1yitjfTJUZoPoS+TNHtgX
P4pLvD5xNL//rL/UzBI/21CK8BUZNTTzC7amNH94ULOnZxtmim7Du527F4QHxH9pOuQrdQsO
bxBQzc1T7o0rvw0w3rnZojcHOTdmHNSeFHxnBxom7+VmVooLSqRZ5ggzSj/fl6K6NFzsveow
GtMVPv1EIe+taU93euNagAYe31Gh4hGVe9jw8T5kAleREBR1Gh2aChubBodsZeZCIuFCQvi0
Ir1Z6Gu2Ud6n7V8661VuSG52Pmnjl24F4+MsHKPUHmMdtdfINTvhRyhJb56Z3QXybCbmJujw
umJGXffDxDHU0W4UhkDLAePMJnPXJ6d3AZ63u5zWfnEDvGX0cGZ4dXIwXuxCSanVaGhlnpf0
LSMP+lOXdfPW2BC+ACFOodUfV8dea7A+EqXqlMeOqD7qIIugZJNq8/Fys6cxAmI83CeC7wef
ONqfSmqrMFk8hOtiOm/tYwpdruHoS8B1KCbuOxOg3tD3u0rQYFxdkicEXQgrfxFrpjaEOBZB
WHuhtfiNPT8nOVfJKQPNV6nQMboz485+QXKPMQnVabULizRQdD4wVR9G5a9apzSJ9P+7OgC2
qSYxq3MQ/fOsO8qGf6nk0cqB90Pt6bmqaRmFQp+7pf4RRlGWvNNo41fMEhcmJJu7MOR2yNVY
fZ0aQp0ZagA5y6zT5PaPc2SwkkLRouhkQ4HcNIBUgJ5oD8GHFTjdcnn03xx+WxSKAQjq4YMJ
N5olViAYDT2kPi6a1auMniekzruT3Momq3tD91n3lmyJzw2iprJHukLpZkhpaxMq5OGMubRY
JJp69O5ArvftqvXhVthB7OVsM+cUtzbUxCmRfMKbq/bWffvTt0ODiZ44M1M3emzFa51yR+lG
mQXMDxfGYL8uf8kQUg8p82ALjTYWk2gLfFAuMXm94fZSigfP9rtiOWPtHb5+AgmJC59BagJ9
yCYDA5mesYsbdAaAYbppdkv63WTXviFcj+5GgXUNeIjA1CZEqVRaFuJkYm2S/OzBxVqrjBkh
9pztBPbnXtFgj5PPYceCxSzOlLPpJK/DiPxt4uF35+tO9IK3RgvXhSqHfkT4hs9cynkBqAbR
hWnZ9/JzqHQw7JWpPIf6eQIO8rYUdd8E7e0cPnXcvrMQmvKJvSMnS2YxBpdof+05CT13C9cE
ThIU3VAIljuU9fScGMLpnFq+C89S1dwGCC4nDDjIUMJiel0AfGsuly4XiCoGw/q7seaoUbuw
f+DA+3P9RTDlSdOGvtVGREgb9AG7B+0IL4vceUVk5hFD6Eb7RiXvyWohfspJmJLhEFjuYva9
/1o9IhZUQ80ff9xGbk10v+r6UcUGBR1gYlJuHyeubBYY4i7Qb58LFqh7LFL5pGMYADDS084H
xHoD39ZimMj7L0SyEGb6ffzDZvqdUuaaVReI2zOtpYQB8hoaKLXt74QVp8kvrC6XfR7/Ugnc
NB6THrnXopDhBDJEvz7OnjB+/xeaYX96aTe7JRnXiEv3g9FNFtFBfgeerWaYcTfPs4RB5tvb
uoh3kF6sU1Gv3eSK22HeMGUBzPHvkXrI/FPklPymobUNcIpqmj6x3noFKvn0fraoC0qXVKb3
3rLBHmQmLyjSYMujbBLCCI/hDTe/D4kW/a8QviskM4ObCFDov9R17B4lhc8Iv3WTObarIG71
ao9ks2h5fyLY+ZDRNzaFL9MqM1LcYWSZZ3PJuLO9o8JDdCP7RZAx/6nvzaCSNxBrV740DPdQ
Oj/5uVrdSSgygQgB8EnqRG0aExJ19Kps3L3KDwRq7mkkrNrUoKDcWjgi1CNC/d/CXjyoR6zR
NXQkhoyYGS8wefNtqGNCg0eO9YGPEl44uDBOczjv+n3/apqK4wleQoXjih8vSAQIdv0YWEsG
/UnsFy9hNLwKnyU1WFAUmZsJi80w/fEJFAv6NZYPK/SX1R3DfFo5YEtoSndLhwZY9hz0e8zN
fGUOe2Ww2byv1B1X/XD80OvsSb0uehEIRhjQ7wLJyl8eSXXhlQoOU4t0edkQXxuhXtaZVOih
yZhZ9m0KSFESeELoBZCH7VA5MKZdUY+v/NXuAwx6jHTgjD9l7flHwuZgWGQhp9m1b9QrM7Nc
Jx6T5+F+hSqq0/hsM80h6Tnblbv7QwcerlZhrCr2ahHvxms99WEtpgCtjKHgceuOB+zGRK1n
95nkJMIYdyuGGGJ1IayVoz2zdyIoUBv24KXha+U3tP9tbNbzCjmtoHMFH1esOfa7oxbVijfr
S7mE24YyXtse1WHIhaNSRtrs1ONdePOlIz4mcCQO4LMao4Hdo1Rd8W0WNsJz/KrSARUX/iSo
NjNJZCxv71ofOjQxU2CLF7zlAMoBiaxpZmwft+wXyzZflk3raMzlTWXnOI/ZeC9dgNweMHNW
wT3ULRAZ78P1dLSH6UtQDD3dDin1iJLPIlqmYALodtsRKadNvNCvdNkut3nn1SYGdO5+qk8Q
5EEUfRy35wkW4yIik/ym4oJveOOqPhJBVpe+n6aDqYd1b3/KOxymb5BnLVjSdPB1ete2V9pl
EzJOc8HU0g9/2BOJIDzzWNsKQ3ePFbTmTdDE6N1sdDzI01RILtdHjw3otTAlhhoHPo5hjiiW
7Klyq4PBw6z0Uq1FifCew8JsIuRuwStSIbGMF8t5OJH8zkZr50hvb0Wtw7fFjTXECbBpqX0k
3m9ULeF3QuyWQJs5JZM4ezYs2+46RTcyiDjJop/gb8/719G01ORH1VAb5UotwkRJmvyBGx65
kleFTnWcdU9vWnyn04eD+HTcfUQQaJrvcrXCsQ2SgqwycsCsj+Otnu9tPG6L164niu7xDOt+
5mH/wELhJObaH6P+GsgpQm1gQxBVB2mfBUydOb94719rc7x00PW8vRUSERMxOVUcAuTlqxyH
OYhObMGc+hkIaadaAdNzRn6ZEdUY3f6JCBwM8D44QevWrKvHqYyiwntRWHRT4+XTplpiAs+Z
+ClJTlC00iIf6LOZ11m++s5BfWMI020uM6fE/OWAczII4Mab8560GfAgol9sjXgF+MMdZBSq
hjLSVF89GUYf5jyO42PwfVYvRsJB1FYgt+E3umBNlUG5Pj13pVZai7yTM1bYSBYv7KkXGd3g
yEiOe4ydSUd9bplDs/3sGQ8a/OduCPcrZH0YX4zEjcrw8jl9SEYXzqOty6sfX/4Q+7VK5y5n
cwzr9xoqj8b4rnoy7IJI58o388oNOwPQK+YU6Z/4derNpJ9RrSKdJ2lAGpzNUdOc81YWCHZ/
I5CimnbYScq7YVGPeVNAVqLOJUzzYWTFLb9widfkcKeCpZ1cWllGiTcyAUVXG0xZVO3fRLNB
Y+kQcmvO0zDnuFkN2fdmrmodtOBDqVNUAPpkoZJAOjDCU1qYphUGQi/ZxrEBtAUVGu67Uv8I
OtjYoYXYxfHu/a5ZkEetTZaIbNKqm3ivs4T8WrZhypLxsqNpGi/A/Vor9pgLBYF+HfddxKZT
D7EU2hhY/Uub4TphbdIvRFEFRCxQ4VpZIeJrVn8+02+7J0w76ExfvDseiB8W0r5VmGu6hNa7
Z/CuX3v9emn/bgOn1v4U5qwIqetobOA79X08q2ehpnx6KN0KppDqF1U2j/fsH2AgPX4UNHsS
qLny9Zwl0S8OkOVU097mzaiQvZUUVRrfRwMZ+Ye9oIXra6J0+Q7fDxAl4tzyyInq6cjEBFTC
Y/+NmTIQfiNf8NjiHBzrzBohzYCyaq5uPQI44NGzK2ZOqXodZ8ZuDsqhDbtk9i8/OgGNi5Zq
LbK+AO9EXlsup8YimOPVKI1SsdC3wF7HjNz8iLLBEpMN2Y+PGhf1KDQSCRJEgMI5oxwDQvqX
ev9PReAPD02EvWJlEgI1zWRJs/CAUXczz7pHIN1GXuuLh3fBpgj9VpFQ/47dV+PBrYiX23qb
mOimQNL/RmCEHnftoEi/aPAPTtXvVblcj2FY/g9R75i5t5y7pPExM+BsTR6xe0Klp1O9I5QO
PyesE4SxaY1sjKzrzIibnyP4caymtReT8st1Rj9jvy6DjtULJnPUB1VCaB5S2LLb+VyCWvB/
KleSvaRHkIp6K5r5DxeqwOKVa0kfqxIUNBB2O30/AyS9CNHvUuopuDKrG3/b+K4St1I90gLl
9qR6aVOaXcMN0GPK8x4241UeQlVaHLYe2solMmFC4mgERVEoU26+jnAbwYWR0AI6RXDuJKpf
EJu5HetkB738O+oifBkZv/qRoTYVHYirbxKo9Mztm6yLTBOKd5ToEXXBTL8oGKPE4n07mPDM
E8wtKJgoCHCZQUFRvtz7qFZXGLbt7OgRmY9iXAisqtSeoqjGz9PXMYlYGMLe68a8Y/TA6N+R
+R3lgGtO3N1LkfyzJOkuoDHZWN5LdtQUmbxIG33Dwt6q7prpR4RTnyphS5OI3ul1kJorxQCN
QhupyRPjbe6bW+y2N/NPlFW5c9Idu7nZ2fy4NEFa+THT1HDuQ8uXQ7bPE8lVQKQsvx4ei20f
30rLuLiUnrUXSoYARf5nkafut1+NHQR18RVIvuP1bqNOV0R1WEmbdOoaUhOoecWEznrdxlLf
P8iXryQ6mMiLz+KbwrSbOJKWHzuguAbCWLE02WLvWoHpadx8DON3X8Ynwn12wa9PuR+z5Wq2
BOnuVqOmWmWlP3fqBMXQgVJD9CbGP8GEtK5ET9UvEcw37WKXSBK1R2gaP8/PwrQIHlycNxPT
askKhJkjMXi82r3QYVpWAXRX1idynl1ZzM7z5vl4So/1z2KaBU4F0lpI0KFr39YCmiDdYuiY
nEW+EgWnOJOGqU2RdhpCsfPdKUqlY4mVCT0Mg8fWWvE7U9A8eP/TlaWd9J4OhpREgzZLa3Ug
eT6yhHJ7H++jDeP/Q45KdNc4oXSYfH3WulS2iJo+DO8xU8iz9i+z58apOoTisPuahw85jdDO
p9kdOFUEl4Shf2KVneifc8ONeKYUqKkrAanStbm2KbXpYi8SzOLPYinNMQfriRior8IFzpZX
OygcmYx7qa76kvVM3oNjQGCjLUZHedMihEw9R6pcRSZkg+3+I3LXp19KIWo5IYYo5OWHbaFt
4bOcd5EVQDA65xqvoQzgrnYBLiV8RIFwEK8XxdhYYqIzCm3wpZJiM6PsTZfNVVwH7R5HQvXy
OXYM/ivcyO6p327ukXsxpFo6ZFaM8oCaZl46au/RgyrbRkkIXVIpRHO1kUJgikfx7lB9gHrW
SBwFlOzCELqHIytz0U2KKyicNkoLBcCwZLerOi1s9vGvbGsL14QEtQXT3x/3WbimI94Z+ntI
UhX4DAiBlUx0iPyuS3vSPwgeEOm+5+awfXneCVsNlAN5ESaksLKdpOsWzf4pa2fA+UDVi18R
YbArphFsy5d9TwgUXdpQaRdbrGusPBtIUKSbGsNKFaBKtWt4q9bLR91/wT1Bl9GCsp96TjcL
QUuy5IdLAEcmxRlukXoMPvOydIRjyV2JCkoLmAM5Nkvy+SVoZodCdO0/ZTiFGOSjHuljRbXi
84mWrbh1uk/52eMDDvgvPVOfNL2wThKnwKHT8otiNQI1K5odZSJP2gMj6Q75bm4zybfoYISm
0H07h7e1/pLGRDRIHm1+awtayIbX9UK1Sdr5G9cuxiqOSU1D+vhiB+t2hcsZYFVoqjHLut07
g8Z+DaRF5lnEp2iPiyjhZLloMgAt6iFgETMDsibaVL2Yhpd27UiThe90cUMPXenUw2+I6TQ+
dKWCczbvJXlMJGdxL+LvZlY6wtyutt9q6KwvNJWzspWQZ78VlWsqf8GmCq1cnJ0lsdrIZyZ7
n2mL63co03ZcheKBtexBIYJ6CODb0WDL1ea57fVyNMfaMrvRz6pqE6bjPt9Tb8tAYHy5DTnx
w/Ocz1HBxRkmkXdmy/rASZDzUUJejztBsDfAUXi1ESSNyH3bdePJt0kPWnHSF5JBYwI5Vn2I
Rx1EnJsLtzpUir/TH7jkQ/C4JcZSjDP4ZxRu417Kyyq9Gyf2WumGZBuTB+XUYq0UrI4fplVy
k4jioBAibu4QU4Rne9gFV4rH+Li/g/rejZKCs0EepqsqAV2tbqcHeXTK62yU8/Eztz+zY+j1
YDePptGYFSOArrM3n9BNg8iWQANUjLLdewhkJ+ZdE+ztcLyw91B5lwPlc7n+UF/jt5ML8dMe
f3S//q9X0pPWzk5ImvuPxxYOThy95f8fxYvcyeBlLWtoFeGaUOGRlAkPGCi/RBEwu1AV2GF7
7RUrjU24ZOelfqVD/oJhdkpkCFBo3SZlrvBEhZ7uiLgWrGK3eZRpWzxE9DPFolVg2gZlvLCj
NJ12cP1fRMZFEG8me9rFW4mXEgag7IGpeScumFrE04lWlHoiUkqbyehOQEENWW6h5T1nIzAJ
v83TNBvTvH2ZCaG/7RnuHd22NwsvNZj9du9bLE64eWguyKjQ/2tOAbewXVXnCZ0FSwa/LEy2
jzW7USi/uIKBLecS8m7sEYNz2pa2ecHeY2KoCqT0CFwtm1GN8udTYiwPY/JX85YTXJQf+Hc/
TOkqfysZxEIHeLN8KfSjN2PhzokbirjF8p6yUhq4BzFVH/Qy4K+KAfHYsWlYIXnmNC+KzVuE
kojvSCc+YzFtLr1MdINuVq/035CokDZ7RRNndujSutyviZe3CUbKcCggtjbamJI4LZqk7tmB
GoE8jIbs5Ut+HrzmMsWC4mkdEgJ83heaWHdVOa6Gxbv6G5sGNJEeO5nqCwaOz/FSAODm6L3O
IyPHQucmBLO+ailUQKHoN31dgL63bBIGBWg8v/L9dC/u/j3tuhVLgadbRQ6/rMDZvF0UsmDD
835RQFD3N+81zaaOEn+ZuXTuMdAaKhZ7YmYzb+zv2x423mqORlnN7rsvEzsGOJshLDPTqRaJ
TOC3/tezkIFhCUBF3lKxvKhoyblekjVPAT57cQZCTJd6xN4S3O987xzO5qgNMv1PEVMHUrY0
3efczzid86q6dTZ34s+Rxa+lhseGL4kL177PzFDIc1rP7TcQRNC2JQwjQKnr7i9El0jrd/3n
fzmLx93poQqUQi4+Ng1/tFvIyLLW9kh5e7hg8j6We67Av0gT6wMHwJVfIVmU5hVAMtCmFtfL
ilnVqn76duEA5MC8X0zdbwiYkSoNvlwwc+VehTf4IFMGa+uVaMbxo8UJA4tSoopmouYdjMWC
En3NGqRcd/H+v/cD+vPFqSrevaZ5K+EnEx3bIDyn5WkmIKJgUhoxCJsl7hgfx8beSi9c0JyD
noAEeHlt/5mOBfvleZvnQEV3mNJ2Fpg0Helx9HFH8eeoJHYLCZkpBd9SOPjvCvtWPEegoeNz
zYGsOIlTWl0+X9aQzf5vYSEXLa+uP3A1HuCH0kVOTMZrzgktJ5Pgqn5eqr+hOI9hDH+544Vc
e6jeQ4LDvodz0SG91yv8F/obaB3ARB7CByveG/GbVlVAv5i2BAKVftqO21pZ0KvqgzErJK3T
t/QZV+dUsci47weit8YN3LhEX3Dighn8q18MusNU5kfdZf967XP43/7eTYBynd+aG3YVllnZ
EKviF8gySzatrjOcL55yUFpspdozAeYvI/n3ROEh+MeVVhKwZnfGTzRexNUO8YHNu2Jndy1W
PsZRIT0jVHzHTvhPovazRGCEBRs9U6DiTHxJpwcdq46+WNx1oR2SNjl/mml0vpxsROx3Yzkw
q3l9Es9Gz7kwswgz8b52XdtKhIPl4Nf2P+flIH5WFeho6QrLAKTJZTnv9Obd/D/Px/56yBeE
CTbiCtki4EPsBkX2urPYdc2IJJ07QcWXm/XWbf7H/g/DC+NCfYFEfS8hH6hnXWVtqn8t+tzU
75/jIyyL1RIoV6o3hlgvDQGEaj27QYF35Z2NxMg624poQ0CinSIh7I5NaTn8xythNXBEQ8EC
uqu79kIY7xPK0KkIlxMOgzicSvbXkAwMdnR8lO414U69t0MLRoQ9s/uSdBVPyxyZk2kRNkjJ
WObcAG4iOM+qexCXBTUU4quyDOXfUiktT4Y2LC5VrjOd7TXqsHsmqZOGms/AaRV+CANQ4LBD
ZxrfgF4TOUI7oJy5B01G/EiQQcEKeKMftPqyJ4kyQAidakH+3bw1/0P9jy7UVS1zwh5cN3EH
1pT9v8WOJ0oUxo/Ejw4I1UUSxqz6+L2yMKNmQs1+1kWqjgO7636YQNuRoMXbFDmhWYCtC7Zd
l/KUZ8w3wG/9z4mcxiciE17MjYk/c3ZfGb4uePb46ZNGkV4xVwnDkKKpqq/TEAtqiYt63xb4
mxkLESp3SZqK2I6+xHX1hAV+elfjYaiP28dY4sFYqGUuhiyyHIbhLrE1k3jhtfkDFSnXEOL3
d12X9rnZAWsey7bhRIKyLel4MBgHb0MXy8CH3QAAAAAtAMRJvpORygABrWu57AQAYX3bLLHE
Z/sCAAAAAARZWg==

--qwWC3uIwaXcGNtT+--
