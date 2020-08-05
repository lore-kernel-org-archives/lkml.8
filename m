Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E97C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD852075D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHEBRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:17:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:48839 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHEBRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:17:21 -0400
IronPort-SDR: 6xVsOjKd+86DHZSxMgGMWmIpox2jM+V19ZI92VoY/lPFtzfj22/IGkduM3xHffIlGOcGYSElfP
 P6bDL0oJYCfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="149874912"
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="xz'?gz'50?scan'50,208,50";a="149874912"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 17:20:53 -0700
IronPort-SDR: OTR/udezkkWAPqN0p1tGWStbYCZLTfg1mCNuwyo1E/qysDyV9Zv5vA9/eg2tIu01YPc/KtMddp
 LGEpbhEBisWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="xz'?gz'50?scan'50,208,50";a="315549504"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2020 17:20:51 -0700
Date:   Wed, 5 Aug 2020 08:20:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>
Subject: ed66f991bb ("module: Refactor section attr into bin attribute"): [
   70.645135] BUG: KASAN: slab-out-of-bounds in vsnprintf
Message-ID: <20200805002015.GE23458@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jPJw4wSVUvI9Tm/b"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jPJw4wSVUvI9Tm/b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit ed66f991bb19d94cae5d38f77de81f96aac7813f
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Thu Jul 2 13:47:20 2020 -0700
Commit:     Kees Cook <keescook@chromium.org>
CommitDate: Wed Jul 8 16:00:17 2020 -0700

    module: Refactor section attr into bin attribute
    
    In order to gain access to the open file's f_cred for kallsym visibility
    permission checks, refactor the module section attributes to use the
    bin_attribute instead of attribute interface. Additionally removes the
    redundant "name" struct member.
    
    Cc: stable@vger.kernel.org
    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Tested-by: Jessica Yu <jeyu@kernel.org>
    Acked-by: Jessica Yu <jeyu@kernel.org>
    Signed-off-by: Kees Cook <keescook@chromium.org>

160251842c  kallsyms: Refactor kallsyms_show_value() to take cred
ed66f991bb  module: Refactor section attr into bin attribute
c0842fbc1b  random32: move the pseudo-random 32-bit definitions to prandom.h
+-----------------------------------+------------+------------+------------+
|                                   | 160251842c | ed66f991bb | c0842fbc1b |
+-----------------------------------+------------+------------+------------+
| boot_successes                    | 642        | 200        | 30         |
| boot_failures                     | 9          | 20         | 2          |
| BUG:kernel_hang_in_test_stage     | 2          |            |            |
| BUG:kernel_hang_in_boot_stage     | 7          | 1          |            |
| BUG:KASAN:slab-out-of-bounds_in_n | 0          | 5          | 1          |
| BUG:KASAN:slab-out-of-bounds_in_v | 0          | 14         | 1          |
+-----------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[   64.103075] trinity-c0 (1011): attempted to duplicate a private mapping with mremap.  This is not supported.
[   64.300797] Lockdown: trinity-c0: unsafe use of perf is restricted; see man kernel_lockdown.7
[   65.342888] Unable to find swap-space signature
[main] 10730 iterations. [F:7458 S:3194 HI:3556]
[   70.643757] ==================================================================
[   70.645135] BUG: KASAN: slab-out-of-bounds in vsnprintf+0xa75/0x1e70
[   70.646293] Write of size 2 at addr ffff888358c37e80 by task trinity-c2/1318
[   70.647661] 
[   70.647974] CPU: 0 PID: 1318 Comm: trinity-c2 Not tainted 5.8.0-rc2-00002-ged66f991bb19d #1
[   70.649549] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   70.651118] Call Trace:
[   70.651761]  dump_stack+0x35/0x50
[   70.652419]  print_address_description+0x2f/0x360
[   70.653490]  ? stack_trace_save+0x96/0xd0
[   70.654239]  ? stack_trace_snprint+0x120/0x120
[   70.655066]  ? vsnprintf+0xa75/0x1e70
[   70.687351]  kasan_report.cold+0xba/0x17e
[   70.688142]  ? vsnprintf+0xa75/0x1e70
[   70.688855]  check_memory_region+0x2b2/0x300
[   70.689687]  memcpy+0x5c/0xa0
[   70.690287]  vsnprintf+0xa75/0x1e70
[   70.690959]  ? pointer+0x8b0/0x8b0
[   70.691736]  sprintf+0xb6/0xf0
[   70.692329]  ? va_format+0x1b0/0x1b0
[   70.693117]  ? prep_new_page+0xa1/0x450
[   70.693836]  ? __might_sleep+0xab/0x1e0
[   70.694586]  module_sect_read+0x64/0xc0
[   70.695324]  sysfs_kf_bin_read+0x15a/0x310
[   70.696093]  kernfs_file_direct_read+0x213/0x4e0
[   70.696935]  kernfs_fop_read+0xd9/0x180
[   70.697650]  do_loop_readv_writev+0xda/0x320
[   70.698440]  do_iter_read+0x2af/0x3a0
[   70.699147]  vfs_readv+0xe1/0x160
[   70.699848]  ? compat_rw_copy_check_uvector+0x550/0x550
[   70.700810]  ? push_pipe+0x283/0x7a0
[   70.701457]  ? iov_iter_get_pages_alloc+0xc82/0x16a0
[   70.702364]  ? iov_iter_pipe+0x300/0x300
[   70.703092]  ? find_get_entry+0x18c/0x3a0
[   70.703850]  ? __lock_page_or_retry+0x360/0x360
[   70.704686]  default_file_splice_read+0x532/0x9f0
[   70.705653]  ? iter_file_splice_write+0xca0/0xca0
[   70.706514]  ? __kasan_check_read+0x21/0x30
[   70.707304]  ? __module_text_address+0x1b/0x1a0
[   70.708156]  ? __kasan_check_read+0x21/0x30
[   70.708929]  ? __fsnotify_update_child_dentry_flags+0x2e0/0x2e0
[   70.710004]  ? __kasan_check_write+0x24/0x30
[   70.710806]  ? __fsnotify_inode_delete+0x30/0x30
[   70.711682]  ? security_file_permission+0x1fb/0x530
[   70.712586]  ? rw_verify_area+0xc8/0x350
[   70.713316]  do_splice_to+0x126/0x1a0
[   70.714009]  splice_direct_to_actor+0x2d7/0xa00
[   70.714830]  ? __generic_file_write_iter+0x363/0x610
[   70.715771]  ? do_splice_from+0x140/0x140
[   70.716522]  ? do_splice_to+0x1a0/0x1a0
[   70.717242]  ? rw_verify_area+0xc8/0x350
[   70.717952]  do_splice_direct+0x16e/0x2e0
[   70.718708]  ? new_sync_write+0x3a4/0x6f0
[   70.723643]  ? splice_direct_to_actor+0xa00/0xa00
[   70.724557]  ? __might_sleep+0xab/0x1e0
[   70.725304]  ? rw_verify_area+0xc8/0x350
[   70.726071]  do_sendfile+0x478/0xe30
[   70.726771]  ? __x64_sys_copy_file_range+0x560/0x560
[   70.727824]  ? __might_sleep+0xab/0x1e0
[   70.728667]  ? __kasan_check_write+0x24/0x30
[   70.729631]  __x64_sys_sendfile64+0x145/0x250
[   70.730560]  ? __x32_compat_sys_sendfile+0x250/0x250
[   70.731694]  ? __prepare_exit_to_usermode+0xa8/0x2d0
[   70.732919]  do_syscall_64+0x6d/0x290
[   70.733856]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   70.735137] RIP: 0033:0x457729
[   70.735882] Code: Bad RIP value.
[   70.736662] RSP: 002b:00007ffd0e5de6c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
[   70.738494] RAX: ffffffffffffffda RBX: 0000000000000028 RCX: 0000000000457729
[   70.740255] RDX: 0000000000000001 RSI: 000000000000003d RDI: 000000000000011c
[   70.742031] RBP: 00007ffd0e5de770 R08: 00000000000000dd R09: 000000000000ff47
[   70.743729] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000002
[   70.745081] R13: 00007fb7e7ab4058 R14: 0000000001057830 R15: 00007fb7e7ab4000
[   70.746414] 
[   70.746746] Allocated by task 1318:
[   70.747461]  save_stack+0x2b/0x70
[   70.748126]  __kasan_kmalloc+0x111/0x120
[   70.749086]  kasan_kmalloc+0x11/0x20
[   70.749796]  __kmalloc+0x196/0x300
[   70.750470]  kernfs_file_direct_read+0x368/0x4e0
[   70.755459]  kernfs_fop_read+0xd9/0x180
[   70.756218]  do_loop_readv_writev+0xda/0x320
[   70.757045]  do_iter_read+0x2af/0x3a0
[   70.757760]  vfs_readv+0xe1/0x160
[   70.758417]  default_file_splice_read+0x532/0x9f0
[   70.759441]  do_splice_to+0x126/0x1a0
[   70.760165]  splice_direct_to_actor+0x2d7/0xa00
[   70.761060]  do_splice_direct+0x16e/0x2e0
[   70.761812]  do_sendfile+0x478/0xe30
[   70.762511]  __x64_sys_sendfile64+0x145/0x250
[   70.763372]  do_syscall_64+0x6d/0x290
[   70.764092]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   70.765050] 
[   70.765375] Freed by task 0:
[   70.765918] (stack is not available)
[   70.766610] 

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start d9ad7006330c4d6ce3d7369ed85f9404a6629dba v5.7 --
git bisect good 44ebe016df3aad96e3be8f95ec52397728dd7701  # 13:58  G    212     0    1   1  Merge branch 'proc-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
git bisect good 2cfa46dadd203eef88cc70131df7a81ebc34b8ff  # 15:42  G    212     0    1   1  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect  bad cb24c61b53c3f47d4ba596fe37076202f7189676  # 16:02  B      0     1   17   0  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect good 9bc0b029a8889f2c67c988760aba66a8d7b22af5  # 16:32  G    212     0    0   0  Merge tag 'powerpc-5.8-5' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good a6bc851ffe0b246ab4f8aa0d01620fbc08d0441f  # 17:52  G    213     0    1   1  Merge tag 'tpmdd-next-v5.8-rc5' of git://git.infradead.org/users/jjs/linux-tpmdd
git bisect good 0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7  # 18:28  G    216     0    1   1  Documentation: update for gcc 4.9 requirement
git bisect  bad 355a3587d4ca09f2b1014778a7c8908351a91468  # 18:52  B     13     1    1   1  kbuild: Move -Wtype-limits to W=2
git bisect  bad ce69fb3b392fbfd6c255aeb0ee371652478c716f  # 19:23  B     11     2    1   1  Merge tag 'kallsyms_show_value-v5.8-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect  bad b25a7c5af9051850d4f3d93ca500056ab6ec724b  # 19:47  B      3     2    0   0  module: Do not expose section addresses to non-CAP_SYSLOG
git bisect  bad ed66f991bb19d94cae5d38f77de81f96aac7813f  # 20:15  B     15     1    0   0  module: Refactor section attr into bin attribute
git bisect good 160251842cd35a75edfb0a1d76afa3eb674ff40a  # 22:02  G    211     0    2   2  kallsyms: Refactor kallsyms_show_value() to take cred
# first bad commit: [ed66f991bb19d94cae5d38f77de81f96aac7813f] module: Refactor section attr into bin attribute
git bisect good 160251842cd35a75edfb0a1d76afa3eb674ff40a  # 23:22  G    632     0    7   9  kallsyms: Refactor kallsyms_show_value() to take cred
# extra tests with debug options
git bisect  bad ed66f991bb19d94cae5d38f77de81f96aac7813f  # 23:56  B     34     1    0   0  module: Refactor section attr into bin attribute
# extra tests on head commit of linus/master
git bisect  bad c0842fbc1b18c7a044e6ff3e8fa78bfa822c7d1a  # 01:15  B     30     1    1   1  random32: move the pseudo-random 32-bit definitions to prandom.h
# bad: [c0842fbc1b18c7a044e6ff3e8fa78bfa822c7d1a] random32: move the pseudo-random 32-bit definitions to prandom.h
# extra tests on linus/master
# duplicated: [c0842fbc1b18c7a044e6ff3e8fa78bfa822c7d1a] random32: move the pseudo-random 32-bit definitions to prandom.h
# extra tests on linux-next/master
# 119: [1cfc1dba44c2b62b2856bf23624116eea9cd5627] Add linux-next specific files for 20200804

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--jPJw4wSVUvI9Tm/b
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-41:20200804201519:x86_64-randconfig-a004-20200730:5.8.0-rc2-00002-ged66f991bb19d:1.gz"
Content-Transfer-Encoding: base64

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
IuRePkPAfOn2DcDsL49Um1PFLwIA

--jPJw4wSVUvI9Tm/b
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-22:20200804224700:x86_64-randconfig-a004-20200730:5.8.0-rc2-00001-g160251842cd35:1.gz"
Content-Transfer-Encoding: base64

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
T//4/N8fmNb7J0Nbf/Tpr2ge/Q8o7vmmnJEBAA==

--jPJw4wSVUvI9Tm/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vm-yocto-41:20200804201519:x86_64-randconfig-a004-20200730:5.8.0-rc2-00002-ged66f991bb19d:1"

#!/bin/bash

kernel=$1
initrd=yocto-x86_64-trinity.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/$initrd

# make INSTALL_MOD_PATH=<mod-install-dir> modules_install
# cd <mod-install-dir>
# find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
[[ -f modules.cgz ]] || echo "warning: can't find modules.cgz"
cat $initrd modules.cgz > final_initrd.cgz

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd final_initrd.cgz
	-m 16384
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

--jPJw4wSVUvI9Tm/b
Content-Type: application/x-xz
Content-Disposition: attachment; filename="3eeb076bed98a9c2f180dd8c9adc82e2efd41f5a:gcc-9:x86_64-randconfig-a004-20200730:BUG:KASAN:slab-out-of-bounds_in_v.xz"
Content-Transfer-Encoding: base64

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
AARZWg==

--jPJw4wSVUvI9Tm/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.8.0-rc2-00002-ged66f991bb19d"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.8.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-14) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=234000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
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
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
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
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_TIME_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
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
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
CONFIG_XEN_PVH=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_ACRN_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_SIG=y
CONFIG_KEXEC_SIG_FORCE=y
# CONFIG_KEXEC_BZIMAGE_VERIFY_SIG is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
# CONFIG_ACPI_AC is not set
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_TINY_POWER_BUTTON=m
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_TAD=m
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=y
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

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
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=m
CONFIG_GOOGLE_MEMCONSOLE=m
CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=m
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
CONFIG_GOOGLE_VPD=m
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_OPTPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
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
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
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
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
CONFIG_MODULE_SIG_SHA224=y
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha224"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
# CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=m
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_HMM_MIRROR=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
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
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_FAILOVER is not set
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
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=y
CONFIG_XEN_PCIDEV_FRONTEND=y
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
# CONFIG_PCIE_XILINX is not set
CONFIG_VMD=y
# CONFIG_PCI_HYPERV_INTERFACE is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCIE_INTEL_GW=y
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
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
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_PCCARD=y
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_PD6729 is not set
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=m
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=m
# CONFIG_RAPIDIO_CPS_XX is not set
CONFIG_RAPIDIO_TSI568=m
CONFIG_RAPIDIO_CPS_GEN2=m
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

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
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
CONFIG_MHI_BUS=y
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=m
# CONFIG_GNSS_MTK_SERIAL is not set
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=m
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
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
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=m
CONFIG_IBM_ASM=m
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
# CONFIG_VMWARE_BALLOON is not set
# CONFIG_SRAM is not set
CONFIG_PCI_ENDPOINT_TEST=y
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
CONFIG_PVPANIC=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=m
CONFIG_INTEL_MEI_HDCP=m
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#
# CONFIG_INTEL_MIC_BUS is not set
CONFIG_SCIF_BUS=m
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
CONFIG_MISC_ALCOR_PCI=m
CONFIG_MISC_RTSX_PCI=y
CONFIG_HABANA_AI=y
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.rst for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=m
CONFIG_IDE_GD_ATA=y
# CONFIG_IDE_GD_ATAPI is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_DELKIN=y
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=y
CONFIG_BLK_DEV_IDEACPI=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
# CONFIG_BLK_DEV_PLATFORM is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=m
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_PCIBUS_ORDER=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_ATIIXP=m
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=m
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_JMICRON=m
# CONFIG_BLK_DEV_PIIX is not set
CONFIG_BLK_DEV_IT8172=m
CONFIG_BLK_DEV_IT8213=m
CONFIG_BLK_DEV_IT821X=y
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_BLK_DEV_TC86C001=m
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=m
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=y
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
CONFIG_SCSI_3W_SAS=y
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_DPT_I2O=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
# CONFIG_MEGARAID_MAILBOX is not set
CONFIG_MEGARAID_LEGACY=y
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
CONFIG_SCSI_SMARTPQI=m
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
CONFIG_SCSI_UFS_CDNS_PLATFORM=m
# CONFIG_SCSI_UFS_DWC_TC_PLATFORM is not set
CONFIG_SCSI_UFS_BSG=y
CONFIG_SCSI_HPTIOP=m
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_FLASHPOINT is not set
CONFIG_SCSI_MYRB=m
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
CONFIG_XEN_SCSI_FRONTEND=m
CONFIG_HYPERV_STORAGE=m
CONFIG_SCSI_SNIC=m
CONFIG_SCSI_SNIC_DEBUG_FS=y
CONFIG_SCSI_DMX3191D=y
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=y
CONFIG_SCSI_INIA100=y
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
CONFIG_SCSI_IZIP_SLOW_CTR=y
# CONFIG_SCSI_STEX is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_MMIO is not set
CONFIG_SCSI_IPR=y
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
CONFIG_SCSI_QLOGIC_1280=m
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_VIRTIO is not set
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
# CONFIG_PCMCIA_AHA152X is not set
CONFIG_PCMCIA_FDOMAIN=m
# CONFIG_PCMCIA_QLOGIC is not set
CONFIG_PCMCIA_SYM53C500=m
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
CONFIG_AHCI_CEVA=y
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
CONFIG_SATA_QSTOR=y
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
CONFIG_SATA_DWC=m
CONFIG_SATA_DWC_OLD_DMA=y
CONFIG_SATA_DWC_DEBUG=y
CONFIG_SATA_DWC_VDEBUG=y
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
# CONFIG_SATA_PROMISE is not set
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=y
CONFIG_SATA_SVW=y
CONFIG_SATA_ULI=y
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
# CONFIG_PATA_ATIIXP is not set
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=y
CONFIG_PATA_CYPRESS=m
CONFIG_PATA_EFAR=y
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
CONFIG_PATA_JMICRON=y
CONFIG_PATA_MARVELL=y
CONFIG_PATA_NETCELL=y
CONFIG_PATA_NINJA32=m
CONFIG_PATA_NS87415=m
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=y
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=y
CONFIG_PATA_SIS=y
CONFIG_PATA_TOSHIBA=y
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
CONFIG_PATA_WINBOND=y

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
CONFIG_PATA_MPIIX=y
# CONFIG_PATA_NS87410 is not set
CONFIG_PATA_OPTI=y
CONFIG_PATA_PCMCIA=m
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
CONFIG_PATA_LEGACY=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
# CONFIG_DM_CACHE_SMQ is not set
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
# CONFIG_DM_ERA is not set
CONFIG_DM_CLONE=m
CONFIG_DM_MIRROR=m
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_RAID=m
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
# CONFIG_DM_DELAY is not set
# CONFIG_DM_DUST is not set
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
# CONFIG_DM_SWITCH is not set
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_TARGET_CORE=m
# CONFIG_TCM_IBLOCK is not set
# CONFIG_TCM_FILEIO is not set
# CONFIG_TCM_PSCSI is not set
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
CONFIG_SBP_TARGET=m
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=m
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
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
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
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
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
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
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
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
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
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
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
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
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
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
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=m
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_88PM860X=m
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_BU21029=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=m
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
# CONFIG_TOUCHSCREEN_DA9052 is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
# CONFIG_TOUCHSCREEN_ILI210X is not set
CONFIG_TOUCHSCREEN_S6SY761=m
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=y
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_IMX6UL_TSC=m
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_PENMOUNT=y
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2007=m
# CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
CONFIG_TOUCHSCREEN_RM_TS=y
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=y
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_STMPE=m
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
# CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=m
CONFIG_INPUT_88PM80X_ONKEY=m
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_MAX77650_ONKEY=m
CONFIG_INPUT_MAX77693_HAPTIC=m
# CONFIG_INPUT_MAX8925_ONKEY is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_GPIO_VIBRA=m
CONFIG_INPUT_ATLAS_BTNS=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=m
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
CONFIG_INPUT_AXP20X_PEK=m
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PCF50633_PMU=y
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=m
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_RK805_PWRKEY=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA9052_ONKEY=y
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_WM831X_ON=y
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_IQS269A=y
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
# CONFIG_INPUT_XEN_KBDDEV_FRONTEND is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
CONFIG_INPUT_DRV260X_HAPTICS=y
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
# CONFIG_INPUT_STPMIC1_ONKEY is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
# CONFIG_HYPERV_KEYBOARD is not set
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=m
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_16550A_VARIANTS=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_EXAR=m
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=m
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=m
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SIFIVE=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=m
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_GOLDFISH_TTY=m
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_TRACE_ROUTER=m
CONFIG_TRACE_SINK=m
CONFIG_HVC_DRIVER=y
# CONFIG_HVC_XEN is not set
CONFIG_SERIAL_DEV_BUS=m
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
CONFIG_VIRTIO_CONSOLE=m
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_CCTRNG=m
CONFIG_APPLICOM=y

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

CONFIG_MWAVE=m
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set
# CONFIG_NVRAM is not set
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=m
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_XEN=m
CONFIG_TCG_CRB=m
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS=m
# CONFIG_XILLYBUS_PCIE is not set
CONFIG_XILLYBUS_OF=m
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=m
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_DEMUX_PINCTRL is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=m
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_AMD_MP2=m
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=y
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EMEV2=m
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_RK3X=m
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=m
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AXP209=y
CONFIG_PINCTRL_AMD=m
CONFIG_PINCTRL_DA9062=m
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_STMFX is not set
CONFIG_PINCTRL_MAX77620=m
# CONFIG_PINCTRL_RK805 is not set
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=m
CONFIG_PINCTRL_LYNXPOINT=m
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LEWISBURG=y
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L92=y
CONFIG_PINCTRL_EQUILIBRIUM=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_EXAR=m
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=m
CONFIG_GPIO_ICH=m
CONFIG_GPIO_LOGICVC=y
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SYSCON=m
CONFIG_GPIO_VX855=m
CONFIG_GPIO_XILINX=m
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=m
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=m
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=m
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_BD71828 is not set
# CONFIG_GPIO_BD9571MWV is not set
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=m
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_MADERA is not set
# CONFIG_GPIO_MAX77620 is not set
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_STMPE=y
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_ML_IOH=m
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

CONFIG_GPIO_AGGREGATOR=m
# CONFIG_GPIO_MOCKUP is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_MT6323=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=m
CONFIG_SYSCON_REBOOT_MODE=m
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_MAX8925_POWER is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=m
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=m
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_LEGO_EV3=m
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9052=m
CONFIG_BATTERY_DA9150=m
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
CONFIG_AXP288_FUEL_GAUGE=m
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_88PM860X=m
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=m
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_LP8788=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77650=m
CONFIG_CHARGER_MAX8998=y
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65217=m
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_CHARGER_UCS1002=m
CONFIG_CHARGER_BD99954=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=y
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DRIVETEMP=y
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_GSC is not set
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_I5500=m
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX16065=m
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NPCM7XX=m
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_BEL_PFE=m
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR38064=y
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX16601=m
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_TPS40422=y
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE122=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_PWM_FAN=m
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP513=m
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_XGENE=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
# CONFIG_THERMAL_MMIO is not set
CONFIG_MAX77620_THERMAL=m
CONFIG_DA9062_THERMAL=m

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
CONFIG_INT3406_THERMAL=m
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=m
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=m
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC_DEV=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=m
# CONFIG_MFD_CS47L15 is not set
CONFIG_MFD_CS47L35=y
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_GATEWORKS_GSC=y
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_HI6421_PMIC=m
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=m
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6360 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=m
CONFIG_MFD_VX855=m
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=m
# CONFIG_MFD_ROHM_BD70528 is not set
CONFIG_MFD_ROHM_BD71828=y
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=m
# CONFIG_MFD_WCD934X is not set
CONFIG_RAVE_SP_CORE=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=m
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD71828=y
CONFIG_REGULATOR_BD718XX=m
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9063=m
CONFIG_REGULATOR_DA9210=m
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=m
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=m
# CONFIG_REGULATOR_LP8788 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=m
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX77620 is not set
CONFIG_REGULATOR_MAX77650=m
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=m
# CONFIG_REGULATOR_MAX8925 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77686=m
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77802=m
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MCP16502=y
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MP886X=m
CONFIG_REGULATOR_MPQ7920=y
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCF50633=m
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=m
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=m
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_ROHM=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_STPMIC1=m
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_TPS51632=m
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS65217 is not set
CONFIG_REGULATOR_TPS65218=m
CONFIG_REGULATOR_TPS65910=y
# CONFIG_REGULATOR_VCTRL is not set
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8400=m
# CONFIG_REGULATOR_WM8994 is not set
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=m
CONFIG_CEC_NOTIFIER=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=m
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_SIS=m
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_I2C_NXP_TDA9950=m
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
# CONFIG_DRM_AMDGPU_CIK is not set
CONFIG_DRM_AMDGPU_USERPTR=y
CONFIG_DRM_AMDGPU_GART_DEBUGFS=y

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_AMD_ACP is not set
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_DCN=y
CONFIG_DRM_AMD_DC_HDCP=y
# CONFIG_DEBUG_KERNEL_DC is not set
# end of Display Engine Configuration

# CONFIG_HSA_AMD is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
# CONFIG_DRM_I915_COMPRESS_ERROR is not set
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
CONFIG_DRM_VGEM=m
CONFIG_DRM_VKMS=m
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
# CONFIG_DRM_GMA3600 is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_RCAR_DW_HDMI=m
CONFIG_DRM_RCAR_LVDS=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=m
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
CONFIG_DRM_PANEL_BOE_HIMAX8279D=m
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
# CONFIG_DRM_PANEL_LVDS is not set
# CONFIG_DRM_PANEL_SIMPLE is not set
CONFIG_DRM_PANEL_ELIDA_KD35T133=m
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=m
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=m
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=m
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
CONFIG_DRM_PANEL_NOVATEK_NT35510=m
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_ROCKTECH_JH057N00900 is not set
CONFIG_DRM_PANEL_RONBO_RB070D30=m
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=m
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
CONFIG_DRM_PANEL_SONY_ACX424AKP=m
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
CONFIG_DRM_PANEL_VISIONOX_RM69299=m
CONFIG_DRM_PANEL_XINPENG_XPP055C272=m
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
CONFIG_DRM_CHRONTEL_CH7033=m
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
CONFIG_DRM_LVDS_CODEC=m
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
CONFIG_DRM_NWL_MIPI_DSI=m
CONFIG_DRM_NXP_PTN3460=m
CONFIG_DRM_PARADE_PS8622=m
CONFIG_DRM_PARADE_PS8640=m
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
CONFIG_DRM_SII9234=m
# CONFIG_DRM_SIMPLE_BRIDGE is not set
CONFIG_DRM_THINE_THC63LVD1024=m
CONFIG_DRM_TOSHIBA_TC358764=m
CONFIG_DRM_TOSHIBA_TC358767=m
CONFIG_DRM_TOSHIBA_TC358768=m
# CONFIG_DRM_TI_TFP410 is not set
# CONFIG_DRM_TI_SN65DSI86 is not set
CONFIG_DRM_TI_TPD12S015=m
CONFIG_DRM_ANALOGIX_ANX6345=m
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_DP=m
# CONFIG_DRM_I2C_ADV7511 is not set
CONFIG_DRM_DW_HDMI=m
CONFIG_DRM_DW_HDMI_CEC=m
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=m
# CONFIG_DRM_ETNAVIV_THERMAL is not set
# CONFIG_DRM_ARCPGU is not set
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_XEN=y
CONFIG_DRM_XEN_FRONTEND=m
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=m
# CONFIG_DRM_R128 is not set
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set
CONFIG_DRM_VIA=m
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=m
# CONFIG_FB_CYBER2000_DDC is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
CONFIG_FB_N411=m
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=m
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=m
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=m
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
CONFIG_FB_TRIDENT=m
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MAX8925=m
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP5520=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_88PM860X=m
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_LP8788=m
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_TPS65217=m
CONFIG_BACKLIGHT_GPIO=m
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_BACKLIGHT_RAVE_SP=m
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=y
CONFIG_HID_COUGAR=m
CONFIG_HID_MACALLY=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=y
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID=y
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support
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
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
# CONFIG_MSPRO_BLOCK is not set
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
# CONFIG_LEDS_AAT1290 is not set
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_AW2013 is not set
CONFIG_LEDS_BCM6328=m
CONFIG_LEDS_BCM6358=m
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=m
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_WM831X_STATUS is not set
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX77650 is not set
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m
CONFIG_LEDS_SGM3140=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
# CONFIG_LEDS_TRIGGER_AUDIO is not set
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_E752X=y
CONFIG_EDAC_I82975X=y
CONFIG_EDAC_I3000=y
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=m
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
CONFIG_EDAC_I7300=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
# CONFIG_RTC_DRV_88PM80X is not set
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_AS3722=m
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_HYM8563=m
CONFIG_RTC_DRV_LP8788=m
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX8925=m
CONFIG_RTC_DRV_MAX8998=m
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_RK808=m
CONFIG_RTC_DRV_RS5C372=y
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_ISL12026 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TPS65910=y
CONFIG_RTC_DRV_RC5T583=m
# CONFIG_RTC_DRV_RC5T619 is not set
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV3028=m
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_S5M=m
CONFIG_RTC_DRV_SD3078=m

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
CONFIG_RTC_DRV_DS1286=m
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=m
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
# CONFIG_RTC_DRV_M48T59 is not set
CONFIG_RTC_DRV_MSM6242=m
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m
# CONFIG_RTC_DRV_WM831X is not set
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=y
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_CADENCE is not set
CONFIG_RTC_DRV_FTRTC010=m
CONFIG_RTC_DRV_MT6397=m
CONFIG_RTC_DRV_R7301=y

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=m
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_DW_AXI_DMAC=m
# CONFIG_FSL_EDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_DW_EDMA=m
CONFIG_DW_EDMA_PCIE=m
CONFIG_HSU_DMA=m
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
# CONFIG_CFAG12864B is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=m
CONFIG_PARPORT_PANEL=y
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
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_VDPA=m
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=m
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
CONFIG_VDPA=y
# CONFIG_VDPA_SIM is not set
CONFIG_IFCVF=m
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SCRUB_PAGES_DEFAULT is not set
# CONFIG_XEN_DEV_EVTCHN is not set
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=y
CONFIG_XEN_COMPAT_XENFS=y
# CONFIG_XEN_SYS_HYPERVISOR is not set
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=y
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=m
# end of Xen driver support

CONFIG_GREYBUS=m
CONFIG_STAGING=y
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
# CONFIG_COMEDI_ADDI_APCI_1500 is not set
# CONFIG_COMEDI_ADDI_APCI_1516 is not set
# CONFIG_COMEDI_ADDI_APCI_1564 is not set
CONFIG_COMEDI_ADDI_APCI_16XX=m
CONFIG_COMEDI_ADDI_APCI_2032=m
# CONFIG_COMEDI_ADDI_APCI_2200 is not set
# CONFIG_COMEDI_ADDI_APCI_3120 is not set
CONFIG_COMEDI_ADDI_APCI_3501=m
# CONFIG_COMEDI_ADDI_APCI_3XXX is not set
CONFIG_COMEDI_ADL_PCI6208=m
CONFIG_COMEDI_ADL_PCI7X3X=m
CONFIG_COMEDI_ADL_PCI8164=m
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
CONFIG_COMEDI_ADV_PCI1724=m
CONFIG_COMEDI_ADV_PCI1760=m
# CONFIG_COMEDI_ADV_PCI_DIO is not set
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=m
CONFIG_COMEDI_AMPLC_PCI230=m
# CONFIG_COMEDI_CONTEC_PCI_DIO is not set
CONFIG_COMEDI_DAS08_PCI=m
CONFIG_COMEDI_DT3000=m
CONFIG_COMEDI_DYNA_PCI10XX=m
CONFIG_COMEDI_GSC_HPDI=m
# CONFIG_COMEDI_MF6X4 is not set
CONFIG_COMEDI_ICP_MULTI=m
CONFIG_COMEDI_DAQBOARD2000=m
# CONFIG_COMEDI_JR3_PCI is not set
CONFIG_COMEDI_KE_COUNTER=m
CONFIG_COMEDI_CB_PCIDAS64=m
# CONFIG_COMEDI_CB_PCIDAS is not set
# CONFIG_COMEDI_CB_PCIDDA is not set
CONFIG_COMEDI_CB_PCIMDAS=m
# CONFIG_COMEDI_CB_PCIMDDA is not set
CONFIG_COMEDI_ME4000=m
# CONFIG_COMEDI_ME_DAQ is not set
# CONFIG_COMEDI_NI_6527 is not set
CONFIG_COMEDI_NI_65XX=m
# CONFIG_COMEDI_NI_660X is not set
# CONFIG_COMEDI_NI_670X is not set
# CONFIG_COMEDI_NI_LABPC_PCI is not set
CONFIG_COMEDI_NI_PCIDIO=m
# CONFIG_COMEDI_NI_PCIMIO is not set
# CONFIG_COMEDI_RTD520 is not set
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
CONFIG_COMEDI_NI_DAQ_700_CS=m
CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
CONFIG_COMEDI_NI_LABPC_CS=m
# CONFIG_COMEDI_NI_MIO_CS is not set
# CONFIG_COMEDI_QUATECH_DAQP_CS is not set
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_NI_LABPC=m
# CONFIG_RTLLIB is not set
CONFIG_RTS5208=m

#
# IIO staging drivers
#

#
# Accelerometers
#
# end of Accelerometers

#
# Analog to digital converters
#
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_I2C=m
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
CONFIG_AD7746=m
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
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
# CONFIG_ADE7854_I2C is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=m

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
CONFIG_ASHMEM=y
# CONFIG_ION is not set
# end of Android

CONFIG_STAGING_BOARD=y
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_GOLDFISH_AUDIO=m
CONFIG_GS_FPGABOOT=y
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_MOST_COMPONENTS is not set
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=m
# CONFIG_GREYBUS_LOOPBACK is not set
# CONFIG_GREYBUS_POWER is not set
# CONFIG_GREYBUS_RAW is not set
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=m
# CONFIG_GREYBUS_GPIO is not set
CONFIG_GREYBUS_I2C=m
CONFIG_GREYBUS_PWM=m
CONFIG_GREYBUS_UART=m

#
# Gasket devices
#
CONFIG_STAGING_GASKET_FRAMEWORK=m
CONFIG_STAGING_APEX_DRIVER=m
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CHROMEOS_TBMC=y
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LIGHTBAR=y
CONFIG_CROS_EC_VBC=m
# CONFIG_CROS_EC_DEBUGFS is not set
# CONFIG_CROS_EC_SENSORHUB is not set
CONFIG_CROS_EC_SYSFS=y
CONFIG_CROS_USBPD_LOGGER=y
CONFIG_CROS_USBPD_NOTIFY=y
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_RK808=m
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_COMMON_CLK_VC5=y
# CONFIG_COMMON_CLK_BD718XX is not set
CONFIG_COMMON_CLK_FIXED_MMIO=y
CONFIG_CLK_LGM_CGU=y
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=m
CONFIG_MAILBOX_TEST=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

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

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=m
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=m
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=m
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_CROS_EC is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_DMA=m
CONFIG_IIO_BUFFER_DMAENGINE=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
CONFIG_ADXL372=m
CONFIG_ADXL372_I2C=m
# CONFIG_BMA180 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=m
CONFIG_DA311=m
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=m
CONFIG_DMARD10=m
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_KXSD9=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7660=m
CONFIG_MMA8452=m
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=m
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=m
CONFIG_AD7291=m
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD799X=m
CONFIG_ADI_AXI_ADC=m
CONFIG_AXP20X_ADC=m
# CONFIG_AXP288_ADC is not set
CONFIG_CC10001_ADC=m
# CONFIG_DA9150_GPADC is not set
CONFIG_ENVELOPE_DETECTOR=m
CONFIG_HX711=m
CONFIG_LP8788_ADC=m
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP3422=m
CONFIG_MEN_Z188_ADC=m
# CONFIG_NAU7802 is not set
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
CONFIG_QCOM_SPMI_ADC5=m
CONFIG_RN5T618_ADC=m
CONFIG_SD_ADC_MODULATOR=m
CONFIG_STMPE_ADC=m
CONFIG_TI_ADC081C=m
CONFIG_TI_ADS1015=m
# CONFIG_TI_AM335X_ADC is not set
CONFIG_VF610_ADC=m
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_HMC425=m
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
# CONFIG_PMS7003 is not set
CONFIG_SENSIRION_SGP30=m
# CONFIG_SPS30 is not set
CONFIG_VZ89X=m
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=m
CONFIG_AD5446=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5593R=m
# CONFIG_AD5696_I2C is not set
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=m
CONFIG_M62332=m
# CONFIG_MAX517 is not set
CONFIG_MAX5821=m
CONFIG_MCP4725=m
CONFIG_TI_DAC5571=m
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
# CONFIG_DHT11 is not set
CONFIG_HDC100X=m
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
# CONFIG_ADUX1020 is not set
CONFIG_AL3010=m
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=m
CONFIG_BH1750=m
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
CONFIG_CM3232=m
CONFIG_CM3323=m
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
CONFIG_GP2AP002=m
CONFIG_GP2AP020A00F=m
CONFIG_IQS621_ALS=m
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
CONFIG_NOA1305=m
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
CONFIG_SI1133=m
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=m
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
CONFIG_TSL2772=m
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
CONFIG_VCNL4035=m
CONFIG_VEML6030=m
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=m
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
# end of Magnetometer sensors

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_IQS624_POS is not set
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5272=m
# CONFIG_DS1803 is not set
CONFIG_MAX5432=m
# CONFIG_MCP4018 is not set
CONFIG_MCP4531=m
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_DLHL60D=m
CONFIG_DPS310=m
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
CONFIG_ICP10100=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL3115 is not set
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
# CONFIG_T5403 is not set
CONFIG_HP206C=m
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
CONFIG_LIDAR_LITE_V2=m
CONFIG_MB1232=m
CONFIG_PING=m
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
CONFIG_SX9310=m
CONFIG_SX9500=m
CONFIG_SRF08=m
CONFIG_VCNL3020=m
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_IQS620AT_TEMP is not set
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=m
CONFIG_MLX90632=m
CONFIG_TMP006=m
CONFIG_TMP007=m
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=m
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CROS_EC is not set
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_IQS620A is not set
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
CONFIG_PWM_STMPE=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_CADENCE_TORRENT is not set
CONFIG_PHY_CADENCE_DPHY=m
CONFIG_PHY_CADENCE_SALVO=m
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
CONFIG_PHY_MIXEL_MIPI_DPHY=m
CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_INTEL_COMBO is not set
CONFIG_PHY_INTEL_EMMC=m
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
# CONFIG_INTEL_RAPL is not set
CONFIG_IDLE_INJECT=y
CONFIG_MCB=m
CONFIG_MCB_PCI=m
# CONFIG_MCB_LPC is not set

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
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_SPMI_SDAM is not set
CONFIG_RAVE_SP_EEPROM=m

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=m
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=y
CONFIG_OF_FPGA_REGION=y
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
CONFIG_FPGA_DFL_FME_MGR=m
# CONFIG_FPGA_DFL_FME_BRIDGE is not set
# CONFIG_FPGA_DFL_FME_REGION is not set
CONFIG_FPGA_DFL_AFU=m
CONFIG_FPGA_DFL_PCI=m
# CONFIG_FSI is not set
CONFIG_TEE=m

#
# TEE drivers
#
# end of TEE drivers

CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_UNISYS_VISORBUS=m
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=m
CONFIG_FTM_QUADDEC=m
CONFIG_MOST=m
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
CONFIG_FSCACHE_OBJECT_LIST=y
# CONFIG_CACHEFILES is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
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
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=m
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=m
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=m
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_KEY_NOTIFICATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_SAFESETID=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
# CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY=y
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
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
CONFIG_CRYPTO_RNG_DEFAULT=m
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECRDSA=m
# CONFIG_CRYPTO_CURVE25519 is not set
CONFIG_CRYPTO_CURVE25519_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_NHPOLY1305=y
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=m
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA1_SSSE3=m
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_STREEBOG=m
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=m
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=m
CONFIG_CRYPTO_JITTERENTROPY=m
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=m
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
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
# CONFIG_SYMBOLIC_ERRNAME is not set
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
# CONFIG_UBSAN_BOUNDS is not set
CONFIG_UBSAN_MISC=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_TEST_UBSAN=m
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=1
CONFIG_KASAN_VMALLOC=y
CONFIG_TEST_KASAN=m
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=m
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=y
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
CONFIG_TEST_BITOPS=m
# CONFIG_TEST_VMALLOC is not set
CONFIG_TEST_USER_COPY=m
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
# CONFIG_TEST_SYSCTL is not set
CONFIG_SYSCTL_KUNIT_TEST=y
CONFIG_LIST_KUNIT_TEST=y
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_MEMTEST=y
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--jPJw4wSVUvI9Tm/b--
