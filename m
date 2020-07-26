Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D1AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D1120658
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgGZHyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:54:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:48741 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGZHyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:54:06 -0400
IronPort-SDR: S5J7H3VHo3IREnyIrVCWNFcKJNwtI+fRh+sKHmTJDeNQI1YAYQvGs84T/pFit6h9WjJQjJB6q2
 M7lmkfxWK1hQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9693"; a="150865486"
X-IronPort-AV: E=Sophos;i="5.75,397,1589266800"; 
   d="xz'?gz'50?scan'50,208,50";a="150865486"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 00:51:17 -0700
IronPort-SDR: 2fAxhEiZMm7zZP1HJTxpidR3K3CV9u3qAvD+2Jw08KAPDFnKN3x28yUI82U0qUvcOkukxOqbM6
 6ZvWXc6DeNvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,397,1589266800"; 
   d="xz'?gz'50?scan'50,208,50";a="489176739"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jul 2020 00:51:14 -0700
Date:   Sun, 26 Jul 2020 15:50:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>
Subject: ed66f991bb ("module: Refactor section attr into bin attribute"): [
   37.829284] kernel BUG at mm/usercopy.c:99!
Message-ID: <20200726075042.GH1850@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X+8siUETKMkW99st"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X+8siUETKMkW99st
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
f37e99aca0  Merge tag 's390-5.8-6' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux into master
+----------------------------------------------------------------+------------+------------+------------+
|                                                                | 160251842c | ed66f991bb | f37e99aca0 |
+----------------------------------------------------------------+------------+------------+------------+
| boot_successes                                                 | 895        | 299        | 66         |
| boot_failures                                                  | 25         | 17         | 2          |
| WARNING:at_kernel/tracepoint.c:#tracepoint_probe_register_prio | 18         | 7          |            |
| EIP:tracepoint_probe_register_prio                             | 18         | 7          |            |
| Mem-Info                                                       | 3          | 0          | 1          |
| BUG:kernel_hang_in_boot_stage                                  | 3          |            |            |
| BUG:kernel_hang_in_test_stage                                  | 1          |            |            |
| invoked_oom-killer:gfp_mask=0x                                 | 1          | 0          | 1          |
| kernel_BUG_at_mm/usercopy.c                                    | 0          | 10         | 1          |
| invalid_opcode:#[##]                                           | 0          | 10         | 1          |
| EIP:usercopy_abort                                             | 0          | 10         | 1          |
| Kernel_panic-not_syncing:Fatal_exception                       | 0          | 10         | 1          |
+----------------------------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[child1:1413] connect (362) returned ENOSYS, marking as inactive.
[child1:1413] newfstat (108) returned ENOSYS, marking as inactive.
[child3:1415] fcntl (55) returned ENOSYS, marking as inactive.
[   37.827565] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-8' (offset 0, size 11)!
[   37.829283] ------------[ cut here ]------------
[   37.829284] kernel BUG at mm/usercopy.c:99!
[   37.830689] invalid opcode: 0000 [#1]
[   37.831348] CPU: 0 PID: 1413 Comm: trinity-c1 Not tainted 5.8.0-rc2-00002-ged66f991bb19d #1
[   37.832774] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   37.834105] EIP: usercopy_abort+0x5d/0x5f
[   37.834890] Code: ab ce c1 b9 3d 09 ce c1 eb 0a bf 5c 2d d0 c1 b9 9e 51 cd c1 ff 75 0c ff 75 08 56 52 53 50 57 51 68 be 09 ce c1 e8 50 6a f2 ff <0f> 0b 3e 8d 74 26 00 55 89 e5 8b 00 2b 02 5d c3 3e 8d 74 26 00 55
[   37.838004] EAX: 00000063 EBX: c1ce0930 ECX: 00000001 EDX: ffffffff
[   37.839098] ESI: c1ce0931 EDI: c1ceab30 EBP: f6b4dc74 ESP: f6b4dc44
[   37.840164] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010246
[   37.841354] CR0: 80050033 CR2: 00000001 CR3: 36823000 CR4: 00000690
[   37.842402] Call Trace:
[   37.845304]  __check_heap_object+0xbd/0xc5
[   37.845982]  __check_object_size+0xcc/0x271
[   37.846656]  kernfs_fop_read+0xfe/0x143
[   37.847362]  ? kernfs_create_link+0x77/0x77
[   37.848116]  do_loop_readv_writev+0x53/0x91
[   37.848878]  do_iter_read+0x6c/0x8e
[   37.849504]  vfs_readv+0x3f/0x54
[   37.850044]  ? iov_iter_get_pages_alloc+0xd1/0x2ea
[   37.850967]  ? sched_clock_cpu+0x17/0x100
[   37.851672]  default_file_splice_read+0x192/0x20f
[   37.852604]  ? lockdep_init_map_waits+0xb3/0x19d
[   37.853356]  ? debug_mutex_init+0x2a/0x37
[   37.854019]  do_splice_to+0x64/0x74
[   37.854639]  splice_direct_to_actor+0xde/0x1aa
[   37.855489]  ? do_splice_from+0x4f/0x4f
[   37.856174]  do_splice_direct+0x7f/0x9d
[   37.856866]  do_sendfile+0x183/0x216
[   37.857495]  __ia32_sys_sendfile+0x5f/0xa3
[   37.858216]  do_syscall_32_irqs_on+0xf7/0x106
[   37.859048]  do_int80_syscall_32+0x20/0x48
[   37.859766]  entry_INT80_32+0x109/0x109
[   37.860447] EIP: 0x809b132
[   37.860942] Code: Bad RIP value.
[   37.861510] EAX: ffffffda EBX: 00000131 ECX: 000000d0 EDX: b6d01000
[   37.862592] ESI: 00000004 EDI: 00007c6e EBP: 00000200 ESP: bfdee7b8
[   37.863742] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   37.864910] Modules linked in: bochs_drm drm_vram_helper drm_ttm_helper ttm drm_kms_helper drm rtc_cmos drm_panel_orientation_quirks intel_agp intel_gtt agpgart evdev
[   37.867558] ---[ end trace 17d071bed5108050 ]---
[   37.868377] EIP: usercopy_abort+0x5d/0x5f

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 7a4462a96777b64b22412f782de226c90290bf75 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68 --
git bisect good a761b8b00c6cde8f20cdcafdfba685118f2832e3  # 13:33  G    303     0    7   7  misc: mic: cosm: cosm_debugfs: Demote function headers from kerneldoc
git bisect good a9f91cebbeb8ea1355e852cce6d40efbcddbfe2b  # 14:28  G    307     0    8   8  misc: vmw_vmci_defs: Mark 'struct vmci_handle VMCI_ANON_SRC_HANDLE' as __maybe_unused
git bisect  bad 8f3ce74c20f21e09644d2a584238f1453a00eb8d  # 14:47  B     60     1    1   1  coresight: replicator: Reset replicator if context is lost
git bisect good f31a03b123b1f849bc0f60493edb95342f2c8e9a  # 15:43  G    300     0   10  10  Documentation/driver-api: xillybus: drop doubled word
git bisect  bad c4d41d00552754cc8cdd66a52da9b7c203884d49  # 16:01  B      6     1    1   1  Merge v5.8-rc6 into char-misc-next
git bisect good 3a12c2b5f38227a7104ce9f2be682059c7c93100  # 17:53  G    300     0    6   6  cxl: Change PCIBIOS_SUCCESSFUL to 0
git bisect good fadbfc38dde26d31e901c3c85cf01332cb6a2224  # 18:37  G    302     0    7   8  hpilo: Replace one-element array with flexible-array member
git bisect  bad 9321f1aaf63e74ec3884347490e4ebb039f01b6e  # 19:14  B    141     1    3   3  mips: Remove compiler check in unroll macro
git bisect good f23dbe18930ba992f5c8c7b31e80f40dd6716081  # 20:03  G    308     0    8   8  Merge tag 'irq-urgent-2020-07-05' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 2a89b99f580371b86ae9bafd6cbeccd3bfab524a  # 20:12  B      4     1    0   0  Merge tag 'for-5.8/dm-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
git bisect good aa27b32b76d0b1b242d43977da0e5358da1c825f  # 21:56  G    301     0   10  10  Merge tag 'for-5.8-rc4-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect good 6ec4476ac82512f09c94aff5972654b70f3772b2  # 23:40  G    303     0   10  10  Raise gcc version requirement to 4.9
git bisect good b6a1e78b96a5d7f312f08b3a470eb911ab5feec0  # 01:22  G    300     0  300 306  ALSA: usb-audio: Add implicit feedback quirk for RTX6001
git bisect  bad ce69fb3b392fbfd6c255aeb0ee371652478c716f  # 02:08  B     56     1    2   2  Merge tag 'kallsyms_show_value-v5.8-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect  bad 63960260457a02af2a6cb35d75e6bdb17299c882  # 02:28  B     10     1    1   1  bpf: Check correct cred for CAP_SYSLOG in bpf_dump_raw_ok()
git bisect  bad ed66f991bb19d94cae5d38f77de81f96aac7813f  # 02:43  B      2     1    0   0  module: Refactor section attr into bin attribute
git bisect good 160251842cd35a75edfb0a1d76afa3eb674ff40a  # 03:54  G    300     0    8   8  kallsyms: Refactor kallsyms_show_value() to take cred
# first bad commit: [ed66f991bb19d94cae5d38f77de81f96aac7813f] module: Refactor section attr into bin attribute
git bisect good 160251842cd35a75edfb0a1d76afa3eb674ff40a  # 05:04  G    901     0   23  31  kallsyms: Refactor kallsyms_show_value() to take cred
# extra tests with debug options
git bisect  bad ed66f991bb19d94cae5d38f77de81f96aac7813f  # 05:25  B     33     1    1   2  module: Refactor section attr into bin attribute
# extra tests on head commit of linus/master
git bisect  bad f37e99aca03f63aa3f2bd13ceaf769455d12c4b0  # 06:06  B     55     1    0   2  Merge tag 's390-5.8-6' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux into master
# bad: [f37e99aca03f63aa3f2bd13ceaf769455d12c4b0] Merge tag 's390-5.8-6' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux into master
# extra tests on linus/master
# duplicated: [f37e99aca03f63aa3f2bd13ceaf769455d12c4b0] Merge tag 's390-5.8-6' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux into master
# extra tests on linux-next/master
# 119: [26027945c94a1dfe67ea39f676f5a31276951159] Add linux-next specific files for 20200724

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--X+8siUETKMkW99st
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vm-quantal-31:20200725024247:i386-randconfig-a004-20200724:5.8.0-rc2-00002-ged66f991bb19d:1.gz"
Content-Transfer-Encoding: base64

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
fCEMt3fv38sFmYS2ADZZ20vA7g/gMLAPcOMBAA==

--X+8siUETKMkW99st
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vm-quantal-13:20200725050017:i386-randconfig-a004-20200724:5.8.0-rc2-00001-g160251842cd35:1.gz"
Content-Transfer-Encoding: base64

H4sICHVbG18AA2RtZXNnLXF1YW50YWwtdm0tcXVhbnRhbC0xMzoyMDIwMDcyNTA1MDAxNzpp
Mzg2LXJhbmRjb25maWctYTAwNC0yMDIwMDcyNDo1LjguMC1yYzItMDAwMDEtZzE2MDI1MTg0
MmNkMzU6MQC0W2tT4ziz/j6/Qqf2C3OWBEuWL0pV3joQYMlhAlkCu3PeKSrl2HLil8TO+sLA
1P740y3bsXPDYWbWU0t86X7UaqlvklY68fyVuFGYRHNJgpAkMs2W8MKTH4ZxNAnCKbk4PydH
0vO6ke+TNCJekDiTufzYbrdJ9PRBbkLIlzR23HT8JONQzj8E4TJLx56TOh2ivWjMslzNEsXr
uQzVW01ojmWLD1GWwmv1imrqKl6tKKnm0YnBP+To4zRKnfk4Cb7JHF0TEplCKT3pbb//cC7d
aLGMZZJg1z4FYfaC/Rg6sXpx8ekSH70olO0PZ1GU4st0JkneXPvDFwKX1s5le8wByLME7igk
Rttua63YZS38SltTamrMoDZnrqcb5OhpkgVz73+Ebbq67fg216yP5Gjqui1Bjs7lJHBCIto6
YFD+Mb87Jr/dPJC5R47w9wyaS4N5QvwoJg+TLEyzj4S1daD+hZKRk5L/zeaEGURjHW50uEZ6
o3vCoPubgl9f3N1cfCJJtlxGcSo94i6zpLNJRUg/TOWc/CbDLAiletimOR2ck9MMtBSmgQsP
2xRXr1NQj/pbQG3T9IDdyeLy98rJ5sk21X3shMlCpk4p0/3gxTbfolvd9YYP23QPg179v22C
bzMneoFZTcho5oTTmRMQskkFEpz4y6wDNxa5HD6Qr8F8TrJEksvPo9M/Ljbpz/q3o9Yyjp4D
mKRkOXtNAteZk7vTAVk4y61RUOTSZlqHfFnIhbKX9au19kr4E99/hPbRTN8FJnx3G8xHMLAY
GT9L711w/rZs/vfD0c2uQi896X9PV5HT3wL7btl8kMJdh8NX3w2Xo63Bfb90tMSo4Li+gtut
uWUchOlTh3hykk07JJiGUYyecB5N5/IZHAKECXSNW/6wZJyA6yxDwhcVIUBq+C5DbG5L+Btw
tC546pvP5OjiRbpZKsl5EWYAM0qlm6KDdZ0wjFIykSVQh4RR2BqeXhQO+r82kUcDVAz4SJug
1wffsiXz+aDfIb9fDB7IKHVCz4k9MuyRo4Bz7fIz+ZUM+/3Px4QKYX48VmomtE0ZOmmi8RON
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

--X+8siUETKMkW99st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-vm-quantal-31:20200725024247:i386-randconfig-a004-20200724:5.8.0-rc2-00002-ged66f991bb19d:1"

#!/bin/bash

kernel=$1
initrd=initrd-quantal-vm-quantal-31.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/initrd/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 16384
	-smp 8
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

--X+8siUETKMkW99st
Content-Type: application/x-xz
Content-Disposition: attachment; filename="7a4462a96777b64b22412f782de226c90290bf75:gcc-9:i386-randconfig-a004-20200724:EIP:usercopy_abort.xz"
Content-Transfer-Encoding: base64

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

--X+8siUETKMkW99st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.8.0-rc2-00002-ged66f991bb19d"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.8.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-14) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=234000000
CONFIG_CLANG_VERSION=0
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
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
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
# end of RCU Subsystem

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

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_BOOT_CONFIG=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
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
# CONFIG_BPF_SYSCALL is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
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
# CONFIG_SLUB_DEBUG is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
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
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
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
CONFIG_MELAN=y
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=4
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
# CONFIG_X86_IOPL_IOPERM is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_OLD_INTERFACE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_HIGHPTE=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
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
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_ALLOW_INTS is not set

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
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_GEOS=y
# CONFIG_TS5500 is not set
CONFIG_AMD_NB=y
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
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_DMIID is not set
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set
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
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
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
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
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
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
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
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=m
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_HMM_MIRROR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
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
# CONFIG_NET_DROP_MONITOR is not set
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
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=y
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCIE_BW=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
CONFIG_PCI_FTPCI100=y
# CONFIG_PCI_HOST_GENERIC is not set
CONFIG_PCIE_XILINX=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCIE_INTEL_GW is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
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

CONFIG_PCCARD=y
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
# CONFIG_YENTA_O2 is not set
CONFIG_YENTA_RICOH=y
# CONFIG_YENTA_TI is not set
# CONFIG_YENTA_TOSHIBA is not set
CONFIG_PD6729=m
# CONFIG_I82092 is not set
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=m
CONFIG_RAPIDIO_TSI721=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
# CONFIG_RAPIDIO_ENUM_BASIC is not set
CONFIG_RAPIDIO_CHMAN=m
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
# CONFIG_RAPIDIO_CPS_XX is not set
# CONFIG_RAPIDIO_TSI568 is not set
# CONFIG_RAPIDIO_CPS_GEN2 is not set
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=y
CONFIG_SIMPLE_PM_BUS=m
CONFIG_MHI_BUS=y
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_MTD=y
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
# CONFIG_MTD_SC520CDP is not set
# CONFIG_MTD_NETSC520 is not set
CONFIG_MTD_SCx200_DOCFLASH=m
# CONFIG_MTD_AMD76XROM is not set
# CONFIG_MTD_ICHXROM is not set
CONFIG_MTD_ESB2ROM=m
CONFIG_MTD_CK804XROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
# CONFIG_MTD_L440GX is not set
CONFIG_MTD_PCI=y
# CONFIG_MTD_PCMCIA is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
CONFIG_MTD_PMC551_DEBUG=y
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
# CONFIG_MTD_DATAFLASH_OTP is not set
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_SST25L=y
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=m
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=m
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=m
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_RAW_NAND=m
# CONFIG_MTD_NAND_ECC_SW_BCH is not set

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=m
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_NAND_CADENCE=m
CONFIG_MTD_NAND_ARASAN=m

#
# Misc
#
# CONFIG_MTD_NAND_NANDSIM is not set
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
CONFIG_MTD_SPI_NAND=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=m
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_HYPERBUS is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_CS5535_MFGPT=m
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
CONFIG_CS5535_CLOCK_EVENT_SRC=m
CONFIG_HP_ILO=m
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
# CONFIG_VMWARE_BALLOON is not set
CONFIG_PCH_PHUB=m
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=m
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=m
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=m
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=y
CONFIG_INTEL_MEI_HDCP=m
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

CONFIG_ECHO=m
CONFIG_MISC_ALCOR_PCI=m
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
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
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
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
# CONFIG_QCA7000_SPI is not set
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
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
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
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
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
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=m
# CONFIG_JOYSTICK_COBRA is not set
CONFIG_JOYSTICK_GF2K=m
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_USB is not set
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_DB9=y
CONFIG_JOYSTICK_GAMECON=y
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_PSXPAD_SPI=y
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
CONFIG_JOYSTICK_PXRC=m
CONFIG_JOYSTICK_FSIA6B=y
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=m
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=m
# CONFIG_INPUT_AD714X_SPI is not set
CONFIG_INPUT_ARIZONA_HAPTICS=m
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=m
# CONFIG_INPUT_MAX77650_ONKEY is not set
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MAX8997_HAPTIC is not set
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GPIO_BEEPER=m
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_CPCAP_PWRBUTTON=m
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=m
# CONFIG_INPUT_RETU_PWRBUTTON is not set
CONFIG_INPUT_TPS65218_PWRBUTTON=y
CONFIG_INPUT_AXP20X_PEK=y
CONFIG_INPUT_TWL4030_PWRBUTTON=m
CONFIG_INPUT_TWL4030_VIBRA=m
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PCF50633_PMU=m
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_PWM_BEEPER=m
CONFIG_INPUT_PWM_VIBRA=y
CONFIG_INPUT_RK805_PWRKEY=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA9052_ONKEY=m
CONFIG_INPUT_DA9055_ONKEY=m
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_WM831X_ON=y
# CONFIG_INPUT_PCAP is not set
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_ADXL34X_SPI=m
# CONFIG_INPUT_IMS_PCU is not set
CONFIG_INPUT_IQS269A=m
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV260X_HAPTICS=m
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
# CONFIG_RMI4_F12 is not set
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
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
# CONFIG_SERIAL_8250_PCI is not set
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_ASPEED_VUART=y
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_OF_PLATFORM=m

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
CONFIG_SERIAL_MAX310X=y
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_LANTIQ=m
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_IFX6X60=y
CONFIG_SERIAL_PCH_UART=y
# CONFIG_SERIAL_PCH_UART_CONSOLE is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_SPRD=y
# CONFIG_SERIAL_SPRD_CONSOLE is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_GOLDFISH_TTY=m
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=m
CONFIG_NULL_TTY=m
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_GEODE is not set
CONFIG_HW_RANDOM_VIA=m
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_CCTRNG=y
CONFIG_APPLICOM=y
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=m
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=m
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=m
CONFIG_HW_RANDOM_TPM=y
# CONFIG_TCG_TIS is not set
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=m
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
CONFIG_TELCLOCK=y
# CONFIG_XILLYBUS is not set
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
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_DEMUX_PINCTRL=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=m
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_NVIDIA_GPU=m
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
CONFIG_I2C_RK3X=m
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=m
CONFIG_SCx200_ACB=m
# CONFIG_I2C_FSI is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=m
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
CONFIG_SPI_CADENCE=m
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_DMA is not set
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_FSI=m
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_LM70_LLP=y
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_SC18IS602 is not set
CONFIG_SPI_SIFIVE=m
CONFIG_SPI_MXIC=m
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=y
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=m
CONFIG_SPI_AMD=m

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_LOOPBACK_TEST=m
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPMI=m
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
# CONFIG_PPS is not set

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AS3722=m
CONFIG_PINCTRL_AXP209=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_DA9062=y
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_MAX77620 is not set
CONFIG_PINCTRL_RK805=m
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
CONFIG_PINCTRL_LOCHNAGAR=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_PINCTRL_CS47L92=y
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_SAMA5D2_PIOBU=m
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_VX855=y
# CONFIG_GPIO_WCD934X is not set
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=m
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_GPIO_MM=m
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=m
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD70528=y
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_CS5535=m
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_LP87565 is not set
CONFIG_GPIO_MADERA=y
# CONFIG_GPIO_MAX77620 is not set
CONFIG_GPIO_MAX77650=m
# CONFIG_GPIO_MSIC is not set
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TIMBERDALE=y
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_UCB1400=m
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8350=m
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCH=m
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=m
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=m
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=m
# CONFIG_GPIO_XRA1403 is not set
CONFIG_GPIO_MOXTET=m
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# end of USB GPIO expanders

CONFIG_GPIO_AGGREGATOR=m
CONFIG_GPIO_MOCKUP=m
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

CONFIG_POWER_AVS=y
CONFIG_QCOM_CPR=m
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
CONFIG_POWER_RESET_GPIO=y
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_MT6323=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=m
CONFIG_SYSCON_REBOOT_MODE=m
CONFIG_NVMEM_REBOOT_MODE=m
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=m
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_OLPC=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=m
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77650=m
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX8997 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65090=m
CONFIG_CHARGER_TPS65217=m
CONFIG_BATTERY_GAUGE_LTC2941=m
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_UCS1002=m
# CONFIG_CHARGER_BD70528 is not set
CONFIG_CHARGER_BD99954=m
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AS370=m
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_AMD_ENERGY=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_DA9055=m
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LOCHNAGAR=m
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_ADCXX=m
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=m
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=m
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=m
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=m
CONFIG_MAX77620_THERMAL=m
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

CONFIG_INTEL_PCH_THERMAL=y
# end of Intel thermal drivers

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
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_BD70528_WATCHDOG=y
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9055_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENZ069_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=m
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=m
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
# CONFIG_DW_WATCHDOG is not set
# CONFIG_RN5T618_WATCHDOG is not set
CONFIG_TWL4030_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=m
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=m
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=m
CONFIG_GEODE_WDT=m
# CONFIG_SC520_WDT is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=m
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=m
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_KEMPLD_WDT is not set
CONFIG_SC1200_WDT=m
CONFIG_SCx200_WDT=m
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=y
CONFIG_60XX_WDT=y
# CONFIG_SBC8360_WDT is not set
CONFIG_SBC7240_WDT=m
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=m
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=m
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=m
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=m
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC_DEV=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_MADERA_SPI=m
# CONFIG_MFD_CS47L15 is not set
CONFIG_MFD_CS47L35=y
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
CONFIG_MFD_CS47L92=y
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=m
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_INTEL_SOC_PMIC_MRFLD is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_INTEL_MSIC=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=m
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=m
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
CONFIG_UCB1400_CORE=m
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=m
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# CONFIG_STMPE_SPI is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=m
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
CONFIG_MFD_TIMBERDALE=m
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=m
CONFIG_MFD_VX855=y
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=m
CONFIG_MFD_ROHM_BD70528=y
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=m
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_AAT2870 is not set
CONFIG_REGULATOR_ARIZONA_LDO1=m
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
CONFIG_REGULATOR_AS3722=m
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=m
# CONFIG_REGULATOR_BD70528 is not set
# CONFIG_REGULATOR_BD718XX is not set
CONFIG_REGULATOR_BD9571MWV=m
# CONFIG_REGULATOR_CPCAP is not set
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9055=m
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LOCHNAGAR=m
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP87565=m
CONFIG_REGULATOR_LTC3589=m
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=m
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MCP16502=m
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=y
# CONFIG_REGULATOR_MP886X is not set
CONFIG_REGULATOR_MPQ7920=m
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6323=y
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCAP=y
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_SPMI=m
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_RN5T618=m
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=m
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=m
CONFIG_REGULATOR_TPS65132=m
# CONFIG_REGULATOR_TPS65217 is not set
# CONFIG_REGULATOR_TPS65218 is not set
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS80031=m
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=m
CONFIG_REGULATOR_WM8350=m
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_RC_CORE=y
# CONFIG_RC_MAP is not set
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_JVC_DECODER is not set
CONFIG_IR_SONY_DECODER=y
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=y
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=y
# CONFIG_IR_ENE is not set
CONFIG_IR_HIX5HD2=m
CONFIG_IR_IMON=y
CONFIG_IR_IMON_RAW=y
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
CONFIG_IR_REDRAT3=y
CONFIG_IR_SPI=m
CONFIG_IR_STREAMZAP=m
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=y
CONFIG_IR_TTUSBIR=y
CONFIG_RC_LOOPBACK=y
CONFIG_IR_GPIO_CIR=m
CONFIG_IR_GPIO_TX=y
CONFIG_IR_PWM_TX=y
CONFIG_IR_SERIAL=m
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_IR_SIR=y
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=m
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
# CONFIG_AGP_AMD is not set
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
CONFIG_AGP_EFFICEON=m
CONFIG_INTEL_GTT=m
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DBI=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=m
# end of ARM devices

CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=m
# CONFIG_DRM_AMDGPU_SI is not set
CONFIG_DRM_AMDGPU_CIK=y
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
# CONFIG_DRM_AMD_DC_HDCP is not set
# CONFIG_DEBUG_KERNEL_DC is not set
# end of Display Engine Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
# CONFIG_DRM_I915_USERPTR is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
CONFIG_DRM_I915_DEBUG_MMIO=y
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
CONFIG_DRM_I915_DEBUG_GUC=y
CONFIG_DRM_I915_SELFTEST=y
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
CONFIG_DRM_I915_DEBUG_VBLANK_EVADE=y
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
CONFIG_DRM_VKMS=m
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_GMA600 is not set
# CONFIG_DRM_GMA3600 is not set
CONFIG_DRM_UDL=m
# CONFIG_DRM_AST is not set
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_RCAR_DW_HDMI is not set
CONFIG_DRM_RCAR_LVDS=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=m
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=m
CONFIG_DRM_PANEL_BOE_HIMAX8279D=m
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=m
CONFIG_DRM_PANEL_ELIDA_KD35T133=m
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=m
CONFIG_DRM_PANEL_ILITEK_IL9322=m
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=m
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
CONFIG_DRM_PANEL_LG_LG4573=m
CONFIG_DRM_PANEL_NEC_NL8048HL11=m
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
CONFIG_DRM_PANEL_ROCKTECH_JH057N00900=m
CONFIG_DRM_PANEL_RONBO_RB070D30=m
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
CONFIG_DRM_PANEL_SITRONIX_ST7789V=m
# CONFIG_DRM_PANEL_SONY_ACX424AKP is not set
CONFIG_DRM_PANEL_SONY_ACX565AKM=m
CONFIG_DRM_PANEL_TPO_TD028TTEC1=m
CONFIG_DRM_PANEL_TPO_TD043MTEA1=m
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_CHRONTEL_CH7033 is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_LVDS_CODEC is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
# CONFIG_DRM_NWL_MIPI_DSI is not set
CONFIG_DRM_NXP_PTN3460=m
CONFIG_DRM_PARADE_PS8622=m
# CONFIG_DRM_PARADE_PS8640 is not set
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
CONFIG_DRM_SII9234=m
CONFIG_DRM_SIMPLE_BRIDGE=m
CONFIG_DRM_THINE_THC63LVD1024=m
CONFIG_DRM_TOSHIBA_TC358764=m
# CONFIG_DRM_TOSHIBA_TC358767 is not set
CONFIG_DRM_TOSHIBA_TC358768=m
CONFIG_DRM_TI_TFP410=m
# CONFIG_DRM_TI_SN65DSI86 is not set
CONFIG_DRM_TI_TPD12S015=m
CONFIG_DRM_ANALOGIX_ANX6345=m
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_DP=m
# CONFIG_DRM_I2C_ADV7511 is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_ARCPGU=m
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=m
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_GM12U320=m
CONFIG_TINYDRM_HX8357D=m
CONFIG_TINYDRM_ILI9225=m
# CONFIG_TINYDRM_ILI9341 is not set
CONFIG_TINYDRM_ILI9486=m
CONFIG_TINYDRM_MI0283QT=m
# CONFIG_TINYDRM_REPAPER is not set
CONFIG_TINYDRM_ST7586=m
CONFIG_TINYDRM_ST7735R=m
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_I810=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m
CONFIG_DRM_VIA=m
CONFIG_DRM_SAVAGE=m
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=m
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RIVA_DEBUG=y
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=m
CONFIG_FB_I810=m
# CONFIG_FB_I810_GTF is not set
CONFIG_FB_LE80578=m
CONFIG_FB_CARILLO_RANCH=m
CONFIG_FB_INTEL=m
CONFIG_FB_INTEL_DEBUG=y
CONFIG_FB_INTEL_I2C=y
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_RADEON=m
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
# CONFIG_FB_ATY_GX is not set
CONFIG_FB_ATY_BACKLIGHT=y
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=m
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=m
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=m
CONFIG_FB_SM712=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_AMS369FG06=y
# CONFIG_LCD_LMS501KF03 is not set
CONFIG_LCD_HX8357=m
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_CARILLO_RANCH is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_AAT2870=m
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_OT200 is not set
CONFIG_BACKLIGHT_PANDORA=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_PROC_FS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_CTL_VALIDATION=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_SB_COMMON=m
CONFIG_SND_SB16_DSP=m
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ASIHPI is not set
CONFIG_SND_ATIIXP=y
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=y
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=y
CONFIG_SND_AW2=m
# CONFIG_SND_BT87X is not set
CONFIG_SND_CA0106=y
# CONFIG_SND_CMIPCI is not set
CONFIG_SND_OXYGEN_LIB=y
CONFIG_SND_OXYGEN=y
CONFIG_SND_CS4281=y
# CONFIG_SND_CS46XX is not set
CONFIG_SND_CS5530=m
CONFIG_SND_CS5535AUDIO=y
# CONFIG_SND_CTXFI is not set
CONFIG_SND_DARLA20=y
# CONFIG_SND_GINA20 is not set
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=y
# CONFIG_SND_GINA24 is not set
CONFIG_SND_LAYLA24=m
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=y
# CONFIG_SND_INDIGOIO is not set
CONFIG_SND_INDIGODJ=y
CONFIG_SND_INDIGOIOX=y
CONFIG_SND_INDIGODJX=m
CONFIG_SND_ENS1370=y
# CONFIG_SND_ENS1371 is not set
CONFIG_SND_FM801=m
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=y
CONFIG_SND_LX6464ES=m
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=y
# CONFIG_SND_PCXHR is not set
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=y
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VIA82XX_MODEM is not set
CONFIG_SND_VIRTUOSO=y
# CONFIG_SND_VX222 is not set
CONFIG_SND_YMFPCI=y

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
# CONFIG_SND_HDA_CODEC_CA0132 is not set
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=2048
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
# CONFIG_SND_SPI is not set
# CONFIG_SND_USB is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=y
CONFIG_SND_DICE=y
CONFIG_SND_OXFW=y
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
CONFIG_SND_BEBOB=m
CONFIG_SND_FIREWIRE_DIGI00X=m
CONFIG_SND_FIREWIRE_TASCAM=m
# CONFIG_SND_FIREWIRE_MOTU is not set
CONFIG_SND_FIREFACE=y
# CONFIG_SND_PCMCIA is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=m
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_SOC_AMD_RENOIR=m
# CONFIG_SND_SOC_AMD_RENOIR_MACH is not set
CONFIG_SND_ATMEL_SOC=m
CONFIG_SND_SOC_MIKROE_PROTO=m
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_MQS=m
# CONFIG_SND_SOC_FSL_AUDMIX is not set
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_EASRC is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
CONFIG_SND_SOC_IMG_I2S_OUT=m
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
CONFIG_SND_SOC_MTK_BTCVSD=m
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=m
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
# CONFIG_SND_SOC_XILINX_SPDIF is not set
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_ZX_TDM=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
# CONFIG_SND_SOC_ADAU1761_SPI is not set
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_ADAU7118=m
CONFIG_SND_SOC_ADAU7118_HW=m
CONFIG_SND_SOC_ADAU7118_I2C=m
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK5386=m
# CONFIG_SND_SOC_AK5558 is not set
CONFIG_SND_SOC_ALC5623=m
CONFIG_SND_SOC_BD28623=m
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CPCAP is not set
CONFIG_SND_SOC_CROS_EC_CODEC=m
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
CONFIG_SND_SOC_CS42L42=m
# CONFIG_SND_SOC_CS42L51_I2C is not set
CONFIG_SND_SOC_CS42L52=m
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
CONFIG_SND_SOC_CS4271_SPI=m
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4341=m
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_CX2072X=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES7241=m
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_LOCHNAGAR_SC=m
CONFIG_SND_SOC_MAX98088=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98390=m
CONFIG_SND_SOC_MAX9860=m
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=m
# CONFIG_SND_SOC_PCM179X_I2C is not set
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
CONFIG_SND_SOC_PCM186X_SPI=m
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM3168A_SPI=m
CONFIG_SND_SOC_PCM512x=m
# CONFIG_SND_SOC_PCM512x_I2C is not set
CONFIG_SND_SOC_PCM512x_SPI=m
CONFIG_SND_SOC_RK3328=m
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
# CONFIG_SND_SOC_SPDIF is not set
CONFIG_SND_SOC_SSM2305=m
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=m
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS6424=m
CONFIG_SND_SOC_TDA7419=m
# CONFIG_SND_SOC_TFA9879 is not set
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
# CONFIG_SND_SOC_TS3A227E is not set
CONFIG_SND_SOC_TSCS42XX=m
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
CONFIG_SND_SOC_WCD9335=m
CONFIG_SND_SOC_WCD934X=m
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
CONFIG_SND_SOC_WM8711=m
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=m
# CONFIG_SND_SOC_WM8737 is not set
CONFIG_SND_SOC_WM8741=m
# CONFIG_SND_SOC_WM8750 is not set
CONFIG_SND_SOC_WM8753=m
CONFIG_SND_SOC_WM8770=m
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=m
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8804_SPI=m
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
CONFIG_SND_SOC_ZL38060=m
CONFIG_SND_SOC_ZX_AUD96P22=m
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MT6351=m
CONFIG_SND_SOC_MT6358=m
CONFIG_SND_SOC_MT6660=m
# CONFIG_SND_SOC_NAU8540 is not set
CONFIG_SND_SOC_NAU8810=m
# CONFIG_SND_SOC_NAU8822 is not set
# CONFIG_SND_SOC_NAU8824 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
CONFIG_SND_AUDIO_GRAPH_CARD=m
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_BIGBEN_FF=y
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
CONFIG_HID_COUGAR=m
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CREATIVE_SB0540=y
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELAN=y
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
# CONFIG_HID_GFRM is not set
CONFIG_HID_GLORIOUS=y
# CONFIG_HID_HOLTEK is not set
CONFIG_HID_GOOGLE_HAMMER=m
CONFIG_HID_GT683R=y
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=m
# CONFIG_HID_LOGITECH_DJ is not set
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PENMOUNT=m
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LCD=y
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
CONFIG_SONY_FF=y
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_U2FZERO=y
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=m
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=m
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI_RENESAS=m
CONFIG_USB_XHCI_PLATFORM=m
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_FOTG210_HCD=y
# CONFIG_USB_MAX3421_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_SL811_CS=m
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_HCD_BCMA=m
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS3=m
# CONFIG_USB_CDNS3_GADGET is not set
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
# CONFIG_USB_DWC3_OF_SIMPLE is not set
CONFIG_USB_DWC2=m
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=y
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
CONFIG_USB_SERIAL_CH341=m
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
CONFIG_USB_SERIAL_EMPEG=y
CONFIG_USB_SERIAL_FTDI_SIO=y
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
CONFIG_USB_SERIAL_IR=y
# CONFIG_USB_SERIAL_EDGEPORT is not set
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_IUU=y
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
# CONFIG_USB_SERIAL_MOS7840 is not set
CONFIG_USB_SERIAL_MXUPORT=y
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
CONFIG_USB_SERIAL_SPCP8X5=y
CONFIG_USB_SERIAL_SAFE=m
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
CONFIG_USB_SERIAL_XIRCOM=y
CONFIG_USB_SERIAL_WWAN=y
CONFIG_USB_SERIAL_OPTION=y
CONFIG_USB_SERIAL_OMNINET=m
# CONFIG_USB_SERIAL_OPTICON is not set
CONFIG_USB_SERIAL_XSENS_MT=m
CONFIG_USB_SERIAL_WISHBONE=m
CONFIG_USB_SERIAL_SSU100=y
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_DEBUG=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=m
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=y
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=m
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
CONFIG_USB_GADGET_DEBUG_FILES=y
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=m
CONFIG_USB_FOTG210_UDC=m
CONFIG_USB_GR_UDC=m
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
CONFIG_USB_MV_U3D=m
# CONFIG_USB_SNP_UDC_PLAT is not set
CONFIG_USB_M66592=m
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_NET2272 is not set
CONFIG_USB_GADGET_XILINX=m
CONFIG_USB_MAX3420_UDC=m
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_MIDI=m
CONFIG_USB_F_HID=m
# CONFIG_USB_CONFIGFS is not set

#
# USB Gadget precomposed configurations
#
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_G_SERIAL is not set
CONFIG_USB_MIDI_GADGET=m
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
CONFIG_USB_G_HID=m
# CONFIG_USB_G_DBGP is not set
CONFIG_USB_RAW_GADGET=m
# end of USB Gadget precomposed configurations

# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_SDIO_UART=m
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=m
CONFIG_MMC_ALCOR=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_GOLDFISH=m
CONFIG_MMC_SPI=m
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_CQHCI is not set
CONFIG_MMC_HSQ=m
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_MTK=m
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
CONFIG_MEMSTICK_JMICRON_38X=y
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AN30259A=y
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_AW2013 is not set
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=m
CONFIG_LEDS_CPCAP=m
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_EL15203000=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_NET48XX is not set
# CONFIG_LEDS_WRAP is not set
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_WM8350=m
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=m
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_MC13783=m
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX77650=m
CONFIG_LEDS_MAX77693=m
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=y
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_SPI_BYTE=y
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m
CONFIG_LEDS_SGM3140=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_MTD=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_AMD76X=m
CONFIG_EDAC_E7XXX=m
# CONFIG_EDAC_E752X is not set
CONFIG_EDAC_I82875P=m
CONFIG_EDAC_I82975X=y
CONFIG_EDAC_I3000=y
# CONFIG_EDAC_I3200 is not set
CONFIG_EDAC_IE31200=y
CONFIG_EDAC_X38=y
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I82860=m
CONFIG_EDAC_R82600=m
CONFIG_EDAC_I5000=y
# CONFIG_EDAC_I5100 is not set
CONFIG_EDAC_I7300=m
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
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABEOZ9=y
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_AS3722=m
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
# CONFIG_RTC_DRV_MAX8997 is not set
CONFIG_RTC_DRV_MAX77686=m
CONFIG_RTC_DRV_RK808=m
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=m
CONFIG_RTC_DRV_X1205=m
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=y
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BD70528=m
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TWL4030=m
CONFIG_RTC_DRV_TPS6586X=m
CONFIG_RTC_DRV_TPS80031=y
CONFIG_RTC_DRV_RC5T619=y
CONFIG_RTC_DRV_S35390A=m
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8010=y
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=m
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=m
CONFIG_RTC_DRV_DS1302=y
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=y
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=y
CONFIG_RTC_DRV_R9701=m
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_PCF2123=m
CONFIG_RTC_DRV_MCP795=y
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
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
CONFIG_RTC_DRV_DS1689=y
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=m
CONFIG_RTC_DRV_DA9055=m
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=m
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_PCF50633=m
# CONFIG_RTC_DRV_ZYNQMP is not set
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=y
CONFIG_RTC_DRV_FTRTC010=m
# CONFIG_RTC_DRV_PCAP is not set
CONFIG_RTC_DRV_MC13XXX=y
CONFIG_RTC_DRV_MT6397=y
CONFIG_RTC_DRV_R7301=y
CONFIG_RTC_DRV_CPCAP=m

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=y
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_IMG_ASCII_LCD=m
CONFIG_HT16K33=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
CONFIG_CHARLCD=y
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_VDPA is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VDPA=y
CONFIG_VDPA_SIM=y
CONFIG_IFCVF=m
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST_RING=y
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_DCDBAS=y
CONFIG_DELL_SMBIOS=m
# CONFIG_DELL_SMBIOS_SMM is not set
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
CONFIG_IBM_RTL=m
CONFIG_SENSORS_HDAPS=y
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_XO15_EBOOK is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_MFLD_THERMAL is not set
# CONFIG_INTEL_MID_POWER_BUTTON is not set
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_RPMSG is not set
# CONFIG_CROS_EC_SPI is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_CROS_EC_CHARDEV is not set
CONFIG_CROS_EC_LIGHTBAR=y
# CONFIG_CROS_EC_VBC is not set
CONFIG_CROS_EC_DEBUGFS=y
CONFIG_CROS_EC_SENSORHUB=y
CONFIG_CROS_EC_SYSFS=m
# CONFIG_CROS_USBPD_NOTIFY is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_RK808=m
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=m
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=m
CONFIG_COMMON_CLK_LOCHNAGAR=y
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=m
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_INTEL_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
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

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ARIZONA is not set
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=m
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=m
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
# CONFIG_VME_CA91CX42 is not set
CONFIG_VME_TSI148=m
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
# CONFIG_VMIVME_7805 is not set

#
# VME Device Drivers
#
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_ATMEL_HLCDC_PWM=m
# CONFIG_PWM_CROS_EC is not set
CONFIG_PWM_FSL_FTM=m
# CONFIG_PWM_IQS620A is not set
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_STMPE is not set
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_TI_SYSCON=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_CADENCE_TORRENT is not set
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_MIXEL_MIPI_DPHY=m
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=m
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=y
CONFIG_PHY_SAMSUNG_USB2=m
# CONFIG_PHY_INTEL_COMBO is not set
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
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=m

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
# CONFIG_STM_SOURCE_HEARTBEAT is not set
# CONFIG_STM_SOURCE_FTRACE is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_MGR_XILINX_SPI=m
# CONFIG_FPGA_MGR_ICE40_SPI is not set
CONFIG_FPGA_MGR_MACHXO2_SPI=m
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_OF_FPGA_REGION is not set
# CONFIG_FPGA_DFL is not set
CONFIG_FSI=m
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=m
CONFIG_FSI_MASTER_HUB=m
# CONFIG_FSI_MASTER_ASPEED is not set
CONFIG_FSI_SCOM=m
CONFIG_FSI_SBEFIFO=m
CONFIG_FSI_OCC=m
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=m
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=m
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_HISTOGRAM=y
CONFIG_FSCACHE_DEBUG=y
CONFIG_FSCACHE_OBJECT_LIST=y
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_JFFS2_FS is not set
CONFIG_UBIFS_FS=m
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
# CONFIG_UBIFS_FS_ZLIB is not set
# CONFIG_UBIFS_FS_ZSTD is not set
CONFIG_UBIFS_ATIME_SUPPORT=y
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_MTD=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=m
CONFIG_PSTORE_DEFLATE_COMPRESS=m
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=m
CONFIG_PSTORE_LZ4HC_COMPRESS=m
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_FTRACE=y
CONFIG_PSTORE_RAM=m
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
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
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
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
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=m
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_KEY_NOTIFICATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
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
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=m
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_ECRDSA=m
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_SEQIV is not set
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=m
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# CONFIG_CRYPTO_XXHASH is not set
# CONFIG_CRYPTO_BLAKE2B is not set
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=m
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m

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
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
CONFIG_CRC4=m
CONFIG_CRC7=y
# CONFIG_LIBCRC32C is not set
CONFIG_CRC8=y
CONFIG_XXHASH=m
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=m
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
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
# CONFIG_DYNAMIC_DEBUG_CORE is not set
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
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
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
CONFIG_UBSAN_TRAP=y
CONFIG_UBSAN_BOUNDS=y
# CONFIG_UBSAN_MISC is not set
# CONFIG_UBSAN_SANITIZE_ALL is not set
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
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
# CONFIG_PAGE_POISONING_ZERO is not set
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_TEST=m
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
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
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
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
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_STACK_TRACER is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_MMIOTRACE=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACE_EVENT_INJECT=y
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=m
CONFIG_TRACE_EVAL_MAP_FILE=y
CONFIG_GCOV_PROFILE_FTRACE=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
CONFIG_SYNTH_EVENT_GEN_TEST=y
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=m
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=m
CONFIG_KUNIT_DEBUGFS=y
# CONFIG_KUNIT_TEST is not set
CONFIG_KUNIT_EXAMPLE_TEST=m
CONFIG_KUNIT_ALL_TESTS=m
CONFIG_NOTIFIER_ERROR_INJECTION=m
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_SYSCTL is not set
# CONFIG_SYSCTL_KUNIT_TEST is not set
# CONFIG_LIST_KUNIT_TEST is not set
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_STACKINIT=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--X+8siUETKMkW99st--
