Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E223C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0132F207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgFRBBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:01:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:45668 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgFRBBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:01:34 -0400
IronPort-SDR: MroawA3PBWmhobr4NXeRwwnfjCyAlmYY/RYvJJEP8G2iol3Lm1EBYkl0Lfs+t/BYYf9m/iyG0S
 JVcuwvEYu8uw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 18:01:12 -0700
IronPort-SDR: XwmR8alBfneBXqvH/+yGURBZvdyxDGR+b4wF3H/ZAzke7MV2Jj8FqthfLRyobjQAnwdWueSrsd
 01TvkKPnDcuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,524,1583222400"; 
   d="xz'?gz'50?scan'50,208,50";a="299489491"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2020 18:01:09 -0700
Date:   Thu, 18 Jun 2020 09:00:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        LKP <lkp@lists.01.org>
Subject: ff5c4f5cad ("rcu/tree: Mark the idle relevant functions noinstr"):
 BUG: kernel reboot-without-warning in test stage
Message-ID: <20200618010050.GC5279@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit ff5c4f5cad33061b07c3fb9187506783c0f3cb66
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri Mar 13 17:32:17 2020 +0100
Commit:     Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue May 19 15:51:20 2020 +0200

    rcu/tree: Mark the idle relevant functions noinstr
    
    These functions are invoked from context tracking and other places in the
    low level entry code. Move them into the .noinstr.text section to exclude
    them from instrumentation.
    
    Mark the places which are safe to invoke traceable functions with
    instrumentation_begin/end() so objtool won't complain.
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
    Acked-by: Peter Zijlstra <peterz@infradead.org>
    Acked-by: Paul E. McKenney <paulmck@kernel.org>
    Link: https://lkml.kernel.org/r/20200505134100.575356107@linutronix.de

0d00449c7a  x86: Replace ist_enter() with nmi_enter()
ff5c4f5cad  rcu/tree: Mark the idle relevant functions noinstr
b3a9e3b962  Linux 5.8-rc1
+----------------------------------------------------------------------------+------------+------------+----------+
|                                                                            | 0d00449c7a | ff5c4f5cad | v5.8-rc1 |
+----------------------------------------------------------------------------+------------+------------+----------+
| boot_successes                                                             | 443        | 137        | 84       |
| boot_failures                                                              | 3          | 30         | 13       |
| INFO:rcu_sched_self-detected_stall_on_CPU                                  | 1          |            |          |
| RIP:write_comp_data                                                        | 1          |            |          |
| RIP:__sanitizer_cov_trace_const_cmp4                                       | 1          |            |          |
| RIP:__sanitizer_cov_trace_pc                                               | 1          |            |          |
| BUG:kernel_hang_in_test_stage                                              | 2          | 1          |          |
| BUG:unable_to_handle_page_fault_for_address                                | 1          | 1          | 1        |
| Oops:#[##]                                                                 | 1          | 1          | 1        |
| RIP:write_port                                                             | 1          |            |          |
| Kernel_panic-not_syncing:Fatal_exception                                   | 1          | 1          | 1        |
| Kernel_panic-not_syncing:VFS:Unable_to_mount_root_fs_on_unknown-block(#,#) | 0          | 4          |          |
| BUG:kernel_reboot-without-warning_in_test_stage                            | 0          | 24         | 12       |
| WARNING:at_mm/usercopy.c:#usercopy_warn                                    | 0          | 1          |          |
| RIP:usercopy_warn                                                          | 0          | 1          |          |
| canonical_address#:#[##]                                                   | 0          | 1          | 1        |
| RIP:follow_page_mask                                                       | 0          | 1          |          |
| BUG:kernel_NULL_pointer_dereference,address                                | 0          | 1          |          |
| RIP:ftrace_ops_trampoline                                                  | 0          | 1          | 1        |
| kernel_BUG_at_mm/slab.c                                                    | 0          | 1          |          |
| invalid_opcode:#[##]                                                       | 0          | 1          |          |
| RIP:__check_heap_object                                                    | 0          | 1          |          |
+----------------------------------------------------------------------------+------------+------------+----------+

commit ff5c4f5cad causes approximately 15% kernel reboot without warning, and
no such issue in parent commit kernel.

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

01 00 00 00 68 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
[child7:891] kcmp (312) returned ENOSYS, marking as inactive.
[   32.345837] warning: process `trinity-c7' used the deprecated sysctl system call with 
[child7:893] sysctl (156) returned ENOSYS, marking as inactive.
[child7:895] mbind (237) returned ENOSYS, marking as inactive.
BUG: kernel reboot-without-warning in test stage


                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start af7b4801030c07637840191c69eb666917e4135d v5.7 --
git bisect  bad f1e455352b6f503532eb3637d0a6d991895e7856  # 22:16  B      0     2   18   0  Merge tag 'kgdb-5.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux
git bisect  bad 4fdea5848b3c7fb13a0bfd7f768dcf15b534dafe  # 22:26  B      0     1   17   0  Merge branch 'uaccess.__put_user' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect  bad 69fc06f70f4569c9969f99fe25bdc9a6bb537b43  # 22:36  B     10     1    0   2  Merge tag 'objtool-core-2020-06-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good afdb0f2ec57d4899eda2c5e09fc3a005f2119690  # 00:05  G    151     0    0   2  Merge tag 'fscrypt-for-linus' of git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt
git bisect good ef34ba6d36af9e6f5918f7f7e287be4b70a358b4  # 00:31  G    148     0    0   2  Merge tag 'x86_microcode_for_5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 0bd957eb11cfeef23fcc240edde6dfe431731e69  # 00:54  G    152     0    1   1  Merge tag 'core-kprobes-2020-06-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 2227e5b21aec6c5f7f6491352f0c19fd02d19418  # 01:04  B      0     3   19   0  Merge tag 'core-rcu-2020-06-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good e5a971d76d701dbff9e5dbaa84dc9e8c3081a867  # 01:26  G    151     0    0   0  ftrace: Use synchronize_rcu_tasks_rude() instead of ftrace_sync()
git bisect good f736e0f1a55a88cb258b73da77463573739e9ac9  # 01:52  G    145     0    1   1  Merge branches 'fixes.2020.04.27a', 'kfree_rcu.2020.04.27a', 'rcu-tasks.2020.04.27a', 'stall.2020.04.27a' and 'torture.2020.05.07a' into HEAD
git bisect good b052df3da821adfd6be26a6eb16624fb50e90e56  # 02:26  G    147     0    0   1  x86/entry: Get rid of ist_begin/end_non_atomic()
git bisect  bad 8ae0ae6737ad449c8ae21e2bb01d9736f360a933  # 02:35  B      4     2    0   0  rcu: Provide rcu_irq_exit_preempt()
git bisect good 0d00449c7a28a1514595630735df383dec606812  # 03:10  G    152     0    0   0  x86: Replace ist_enter() with nmi_enter()
git bisect  bad 9ea366f669ded353ae49754216c042e7d2f72ba6  # 03:21  B      1     2    1   1  rcu: Make RCU IRQ enter/exit functions rely on in_nmi()
git bisect  bad ff5c4f5cad33061b07c3fb9187506783c0f3cb66  # 03:34  B      4     3    0   0  rcu/tree: Mark the idle relevant functions noinstr
# first bad commit: [ff5c4f5cad33061b07c3fb9187506783c0f3cb66] rcu/tree: Mark the idle relevant functions noinstr
git bisect good 0d00449c7a28a1514595630735df383dec606812  # 03:54  G    444     0    2   2  x86: Replace ist_enter() with nmi_enter()
# extra tests with debug options
git bisect  bad ff5c4f5cad33061b07c3fb9187506783c0f3cb66  # 04:07  B      5     3    0   0  rcu/tree: Mark the idle relevant functions noinstr
# extra tests on head commit of linus/master
git bisect  bad b3a9e3b9622ae10064826dccb4f7a52bd88c7407  # 04:43  B     72    11    1   1  Linux 5.8-rc1
# bad: [b3a9e3b9622ae10064826dccb4f7a52bd88c7407] Linux 5.8-rc1
# extra tests on linus/master
# duplicated: [b3a9e3b9622ae10064826dccb4f7a52bd88c7407] Linux 5.8-rc1
# extra tests on linux-next/master
# 119: [842221d073a88c9cd1aa01777c4b69020c28e7a4] Add linux-next specific files for 20200614

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--zx4FCpZtqtKETZ7O
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-53:20200615033441:x86_64-randconfig-s032-20200614:5.7.0-rc5-00101-gff5c4f5cad330:1.gz"
Content-Transfer-Encoding: base64

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
G/8Hkj1RXp0nAQA=

--zx4FCpZtqtKETZ7O
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vm-yocto-37:20200615033618:x86_64-randconfig-s032-20200614:5.7.0-rc5-00100-g0d00449c7a28a:1.gz"
Content-Transfer-Encoding: base64

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
AgA=

--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vm-yocto-53:20200615033441:x86_64-randconfig-s032-20200614:5.7.0-rc5-00101-gff5c4f5cad330:1"

#!/bin/bash

kernel=$1
initrd=yocto-x86_64-trinity.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
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

--zx4FCpZtqtKETZ7O
Content-Type: application/x-xz
Content-Disposition: attachment; filename="1e45a7d385f9b6c9d9e5ca4cc3e8deb91f02c51b:gcc-9:x86_64-randconfig-s032-20200614:BUG:kernel_reboot-without-warning_in_test_stage.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4N35F0NdABecCWaK1+kyVIEaR//eNR5wLEdWAmTc
rbGKD6VfvF2QBKqvo5O6DJAG7ojxVWveGi7poUPtVml7vid3i8j9r4sV7n1SvSt7UzLV2hWv
Qs+rjLK6zL5DFIzF+HnXgSJPOlp6/+DKdvKKpr/GAch8TQMufMUHjMrMsCLVizOPX5DGEjkR
hRZbFKrT5HOLzRCsSQ7X7gqyQ0bROc/a4PIM2PCEC437GjEiYPMgedP/GyIS7aUcqOlM9hfz
ypyJoJNqv67TD3gsizCSJwYltJk7VrO1KA3NCpKGY+A+2hRix5mOGHMxROx19f/LmF3RXKDV
s8is3vzbzsIorh8Ecv42KHYUfEh/35DbKeeb/OFVIjooDjjSikOErByKQw6A4V0LS4vCFSDG
gHokABM/abd6yxJLnM7WW0hCpQopaI5XTmaqm/l2Xm6k11jtSyxA1AMv725zUkYimWzU7HEx
GlZPal0kyYVlzNwmok8Yiz51+AVzuJei1P5LVzxazSL1+YMPhLD/WGYD3eI8HyItWEh4hcKi
jxcKOu8JvqCvXscTn1Chp9YXjUxNZoCLFUigLBCJ1ISImHc12a2LFwVTMOc5FZgb4uGkuTob
z8OZFEd6TGJQtvFDr4pNGPLqoZqcFuGrGD/wv/wxVoVlC8ykHiUzP7Ngj3z3opNCji/hTm1D
84p2EwcNyseg2fx8za/fSHLdwHAl7UWdW89G4dRLkkqAF0e6OY/Sly/zsO0Bo9ybgBt/D9pq
pLOtwj429KBnkP6QAqMg8l0zLKJbl0PXs5non0MP8KTs0HerDDoE4KT61/hitFMwixL9+ocX
3KyqiZaQ6NYVK0ryh6grC3PMqLHxUXm9BZ/FSYLHFXFdyfTEwZXpG3oVATI/PJQYYMVGgZY/
gB1etlr+iXD9JL17gZM+jV6TtCqdpNDhtRm6YvIQomfcp3PLtFMfb8jwAO014pvswDEFg21R
eQDSTTzRCwHGU0WjT3BlqcgItcZu5duDDJXmTiHxjOLUWX4CpB18V2dryhzeuQrcxaqTyiQB
MuYxsXrKtmR5W0XTakODTjKPcEQJ3YKES2HUwFngyNZWtWPPoMWnZRCa0ThmQJavf4gTu/nw
LS9HkvyOYl7OMSUoctZ5kUJ1CfRPiFYjEYvINSUY35/EvSzXHHURz08BW5rnXTOauAtpK4Oj
MdK37c/vDIsAVQ4gA1eATvpunxT7zRz2DKWaEli1G9tLGfEsnBwHlKEhj31GukBuE/ZDgUYR
2gtqectUQ9ap2qIiUODiJEDwHKOKNKYFtwa18OrWC2qvx5CDK/+YT2VWIvDNCHzCsRzTj83W
Uo7GZM1ZnlLN+63rCAbM+Jxv3UWtUY78GerHh9KSSGmO+3iMfvZ3FfIXEeoFnDz8mb+KyMaB
pxCzJ6bCNBsC6CI5s3fxrz7o9sIMdccbfgDoOn9j/UGvRN5QbJ2UN+UDArvg2wiG4wxRNe1b
vjDbMI1FxLLXSHJm/JlmTQ9JwdqpEwGD4+6Z14KP2BPar+9M/DFE16VN/jCspfjGlaiqxjnK
1q1Q3VWYsNEG/8mC9g3x/LXCF914a83Mm3Ucya05Q3JcSO9jdy+fXfUGQUHn9/1P5IgH/wKS
l9x1YALlMRYmnbnqglA7E5gHuDa0P5nGqvkgr21YOQ4nFSOyVCEMsvEPoTj92ApkKmMf5m+D
QAzg3jlKgcF3HoBCZvvhRNn/r2rJdOJcC9Etqu3bpS2exnn+duuH0iT+DNDvcZD46YzYAxjM
84q3hEL6qictCGTio1iVXQ3pKiVUJ7WGrs6VKD0g+FZJHsweProHoRKKmx7yamIfqHHPa2Bg
zK5zuK+Vcc/8GWby9YLY25SFkfLmnhJxL5/hx/SjEwlSO0Fxya/ar039NVQGC17qRN6BeUvY
gRrkcFslzCFuMy4pvmwZCNp9LEc0PHyUSJTVCXJTN6J6bbXtN+Czw+ig/b2cIv+oKr01wzGw
OaTwRaNrP7eLgRmZjiifiKSTyBSdAbavFViwVwhyD98MlP37x/qOijX3aT2R/ucUY4aBeYT0
ZezZqy46oAgBIF5fVwBcdDFeUW4I+NRPWJeotcB5fJdvFpy1YzwPj7VDMn+uZ0GtzwQ2bW/6
UP02udLn8vtuMso4E17sjXCED0gT6xD8SvT8DwkN61Ht2UUiMdpS4IXheuZSzhRi0maLCEUG
NgV6DnezsHtIF6pPBrIAMVjfhrCkhohFArQxMr7JgOKav8OJqI3N/YUaZt9BWNeYEhY6GSY/
Di6IcuEpcG5kAbmTAUUSdEr8Koe9QEkZjajCXg6ONYqYPADDy7nioIAo1qmLy0CpfctfbfYE
saJMThKAi0kQtiqsZThv9x0baUD6wn1WAd5Bjsk/CE/bxZ8+up8pOKwh6uiCYiliQ+5ZoskG
jrmkZljO1vr+2XLI6z9eFzZI3VG/jTF71kyDjtCGZNwdT1F0tvkhVGa4jnZX2oxT/N3Nrqwu
yLSpAYwzu+GkgPw3VGsdY2xnqJqgVR+UT3ZKXWXdfzR3OToNN8742qr+9UxlgWE/7NP9nFPg
apzcaBhkXGmtgzaF62K8hPjq4exnCTA5qiCtGo2YugnSFcD8K4ASt+UUixRUVF6zYjNUFMI5
mIz46cNEBa8Vt5HV4Ky2Hu3/utErBg04sLgwq5eukRpJGGXKTpJrpe5kYew8I6z/dLtgO3pg
/51nOFAYC+WPfJGzQwy0E1F53dLLoUgj540FCLllgvw2vFr09aVEp2G/O5ySztQFK4H9QWM3
9kX6rFHWwKgs1XXZtDSybIKD1q4DZiaVFGBm5XojCNru1oOxUJjwooh++wb1E3KC+XMn3SrI
t2TVB3xqBd/oZYBdavy1t+dH+gGlpy9e96e2QQnB/sXtlYqvVwmBgjoAnel6eC6ralSpbBRN
K+JNNElopVqo1cAXUW2iqs3KHDFoOxwW7BSy/BYqIFf4KhADZfLqdeuNEBFWSYV2ruT9xXQE
9a/eZ4E6U57YuzDg/2oaR71kzbXW/HQw5LI7hAaiUMNCV6WvNr0p6TYCSG7+HZkyVXyeW5eV
s/oKtCsQrL4BFiNxbyG9ZMSNWp3MWw37PYYpehRGzB0f4wl2r0v5QWEThq3I7EBbhHe4x6zq
qAwsu8IhJGNEF+mjHJ7nlzdyOD/7b/BKp9DbbqkA2qmGr8Yl+ObH8xgYeLFZ/d060pM3a73F
1qlUHExGe+YdH42FZqtP3qhEYimlXGsmlGOmC+zVFEvGvkhMSaII7OgnSB7NKA4EuQ5usiJZ
CtWVGxaQAfGUcWngZB99btR2vCcTzBkiUXmBdYXITs7edsKeYHX0xw+plgjEvJyT+4lBBb5j
T/YHQXwFZq/chmxgXwx6fYBDuVxppIPPi17whsx3ygyiWUmxgWyd8cHZY1nz6294LS03TE6w
TQqZ5mrYpejrPYNaFG+lZqthjLbOxwDah6aAlyybS3c63CtT+B0B7jOWTpW2qfPOrzGtp5f1
vllUCm1HJMMl+tQffHH75t0EmiptKF5xdpX4J8JOPImJCYDGn9XPMhIMGq2sZJFXWHQtovkQ
IfEcrE+cIn55XK0PjCd9j3vGz6Tw4yK9/qyfyOBXlKtsV4GGIBjuSp0+kZ2p9KC3w1xwC28I
EUwvZRtefsPHo2ZWj1xbuD3qJ2AB6wNceIHnOVxjX5G5nsHb/K7wJBRMHIl9DpRD0uQrqKIl
4J0WFAfXzMQUal/6ZGQOg6OMKXsKQaPURYbY25g4I4OW4VvIHHic9UgnT6t0Tmb22DVKjSuI
SPT2uIdf5o5ItGKtqOtQ4mltNmeEYFEmnpgtV03bmGnX2+ChwBz/Fn9mlWO3G9nPsGSb8wAA
S2/YL/Su2FwMqlYeLD3L+YeZj6nlKwftjmueoo0+j3rpD/WVOtgZAY1yAYjGJE+c05RX07E1
Hf56/6p6vVFyoKtdgAByK83DQSLBO/F0CD03FwDccmrMP1fkYuyYfJi0i/4a3Wg9O8FUBx+3
rLr+jwp2fE2u7/gwtx8P+bhLTfCbh5zCm0yndXs9vml5redGeQ/dRBY54Qyp6S+wGG5V+pLG
6xW3fK495RnJOrmvk3bSiBgIzctu25AOPOUnXFWpjvGYDpCXjCSArmfHpeMqUtZkI07nfvXu
a4+rjRSnhlYNophtVzOoNwddm2HG5oT6Fs9MFqr0q2a2tWWFjyhilut3C2yr3U3TOs/V9Yxw
cqY5qja5s9f3Mlw++WrBw8iCrdaon0HgCGUxADpogQIwxIECtciIICMsQBeFrjxnhJ0CMAAV
pyOZ7EcgMAwayl7vqlrWwEnXIo4KeCKzx0vGaYahiS6f49JJGK3cEdfTO7SnwtfwdjsRVhZm
Vuy6H1FMJVESWNZ+3CBDDfPVjC5DctA2UB3xGML0/THd6mgrvuWazSZ3cLqC4KCPbC43osuO
iop73m5VSxoEOAogJbMy2p+RjLlAgB86yhpgqq2p066Wpi+XeizCub9d9OuQIxrwXyZq9TMB
YSOP/RtF9x/iN5+Z8GTjKV1NHDBmWKkn5F/MooT1lkTetqm5oDj1P9vC6wTA5yuQjymXrloW
hp48DqCGejXQqiSoN/ql/gmqEXtPYAoh0Ho90O6oNOj5ibzkZkcEyyzuqihVOR9MOuVbvQrt
gbxEVjZvB58kKkXKqZ8EdPTeACQ038okh3wtIKoW1O3KYvniize7D/Xes1EU3cihwfcFfMC/
G8nu40L0e6ZAVHvqSDH6wf7wgkbAuSTxkYvLgYpNeuqkQ+KWBb25EJNjpt9ebMn65CztaQmR
p5sYYJcDgM5IlbxWGFvqQYSb5vbpdqTYnn9m+jwnT+nTH6HvAKeO9TVcyvw1ncn9/HuHaqgb
MwPHnBYcx9bQamAM+v9PJ7i39dCcJn7SuWSCVUcE1Z+KeFDgU+Fmn/UgOTqvANMnGt+S8cs/
4h3Nb637O62vHOhSUZUIQQ+VOqLgph9OQvnzUuTPDtIlufB0Ycf9DwTTtAnkjPt52kmk0z38
tsZTd72Z0Wr3yTiqbf2FIvafzD3AZRbVlY2AnCmIACKZT6L6zCpdk02OISj24IKObDgwO7R5
3sDpNSfgDEqbQE9Y7w4hDJbiDpKIGGKPebWs4GmFfPu2f3l3FLHiTthP4/9RqbYAnpzmzmfe
RlS3yWYGGzV0iPgs3EFi81adOK8LSfqNu3IstvzGgX51mCt3BeO8TgEsIBn12EfCSb2YSGr0
ILWjMKiq8TZ+Vf6ugUPtC/qUkDg/gx9i2lovmA1m62TfjSS3qCVwTRuD8yBNpnmn1wFxVBeu
ugGN0LrcUIpjTGiG73M/KH1apzaYl46axji8YVT9n5CqCpnP6nyg0DMYKR+QhBb7rjQj9CtX
IqA7I3XU0R4FDos43LgP/7vRj/uEh/B+t//vXlb8rFKd/Q+XHbCPmOkzi2HBleCrmjPEnebO
eAPcgMO+5kD+yk1F9OYYUBgMGAjlqg3zsXhkOjhOYBBkHHDJG+hVH4we297AhCZXz6a8825v
bQgE+sEXpf4lduB7o6J+kJ8xRULtBX4GYnzZnXj/raApPbVtUBrpZB3fHhEMNOwEhTY8qBr2
K6L73fv/NLAepQggZPXpkKkNCDbNJfxLSnHDa9JoZqncNiar1LpsXuYw5FKLFYaj2RiSUlOU
gjCJe3QVLifKD1eygAFm69Tg7YmLjBRpsYmOrydD663g9azn2SQRnbikHQP2c09/7RrRvgx8
Dn19q8/BC6S58h1uo1qvOoPiKcZ0f7RidH3wZ5Pnis342a+zUv/XEYj5xNzbPJ2+jg9NSuiu
YYfSPdwhV6Sp9QAqHqunRqPtolSsENeU5nZ2EG6jj7rkofXdBIBvXcBbaJn4qjjtCltz1+rY
kFIEaZLMCq6G/oDUK3dXkowW1MnzQ18w7MaW6zicgdd01IEDZXWWnkJMiJwml4aM4PD2ngZl
VNTgptDm8ivMFHnRBSDCjRJd0ZXVGyRiOv/ING3EpbZa/K6gjv9oXbO3M4LlgLJ0KQ1mToSq
r0WPtxmoNE5nZyrytaIcW71uDfObIIN1Y3pBtuAcgYtmk73ZCaNohZsgBv37pWLHdvOaS5tR
FU07ykE0v8ZLM8fJvP/yPSR2SbmoCbeHy5tuQx6YxvBW/VpjXRwjh6saNuM5UrFYYfas6mOu
UxXv8qAGxOx9c/6Csoaxxut+Uu7dA41OizJNgGMTSQYM60GmHAhwF1lDiPBMNBE5jc9Lne+3
3uh1jJoBrXjh87hfoS1b7T2S41ukuNG9dvTIXTJz7p9OcKtPcKbWJubIGFDJzLmJadnjghdu
vSSRy5+uuPsG8Cd5vePbzt7zNe8WLATGsWW80GOf7iAkKrAcf8TVruFfJyspn+wityCn3Xjc
msOrbJxpn/iVF8t04n3uPhzLanu89wZq1uuXsY7x9tw7KkMydlDWslVGOEvDZ/7VSOvsX2EG
icCHXluA1ZdMr5svPvmJwu3VioNxbt4gLtpd2pk0eHMh5rNS/tdqY4i+kd+h1RDIDh2jQVsT
SWBP6HvYAl3jeqKyDcvbymyuyYvOAr0zL/tuor53vh1sESO+c/IxhakcKRd+J16LC/32lUxU
aKybAinGLjRgAG6wePmIULHPCEXOLYbHvY4UlSMe/N4OpVLY9r53+YrsjQBsZs0BaY6CSDqF
usY609DF0vfGOXxi4/Hs9zhNhch3vp0QLG1gwt177tU0c3QkZ2Pe7aS9qj77eZqOhqDqQt31
ak/kNpwCljyWdf30OIypx9rrg2tDXKBeTPauxxQadjcqHDiaWZcfkwwd3Xz9XaIAEuiduZdC
QRj5NkCqJg6zS13g7ZXp+cRkfjLUQqM+P2q03OwTw/yotDO7qFbPNjpvC59rJluh9ce3elZd
WATrv026jNZRa9WoQmo1fZC/CzWjESCx0Z6iAAeNc2E6NOvj/JWeiybyuu8N3SriS1qoCM6+
LehA0uXHaur3NUWC1MxzvWuojlYhfmGyhb96Dod2alMCPk1Bpv31jwQ2+R3KVpva52JEbR7L
3AKltKAf88W4KZHLQcPHzyDMCOXSbE9d4AIZY/GaILxOiuzEtY41QVAG64kfoW2EiAL0Rr/h
9tglKkzDbmxVIZHh4l4etgrz3pFRn9lO4IY1bdQK3Vx6MXRulu2JYy6pWGvARtbNEfm2jUPz
HSQFO6ylN/3OCqtASbvqAQ/zD9mA9leNsy+3Wu/QC79KVXF94pfx7WHa631RSfPB5R+gt33V
JWs3ftMQx/r201RVsyXRKAPe/9tYEiDDLetjkTpqA7pX/BILDKnIuV77f5nK3MeXhJIvd+7e
dZbuVF40xXR6+jjw76ixrAG2KFje//8eNloldSYNJG4rcY/rOCCAragquOs3JB8ooqcSOkF5
Ky2SsCqyRDxMaA2SNqtFuJnQwtxBtPGC1thflqrDIBk0nsId+vVox67ugZYkheoYaALNcXiO
maMEnkPY5AsHvptTT7IXk2ve5ZjXDYOornuL6lJHR/uOE0toZVemvz1NwoBOtbiYME38Tmqq
kBL/OtumvinMbqeyaCv2aVAvvLkAM1f2WRhghpBP3HBH4gH/bOa+6t7bkcT9KO10YoPnigtf
oyZTHNETErTz8i6DA161/MHzksHH8EAYky75f7wHMm2RCXtyze/E4rZ2bOotgtQ986Y/pAPk
hHVZExaNtDoBB6haP450e0HBi2Wo4m/hTVP5IZjCO+14A3JSlpP3oY9E8SLCz6gFO4XTlriC
WY2zWsgQc8/dzuWtyM587agiYUMr1/b9SwiIDdviobFOrRV3EABuq/Y75x4QLFILnxzKSUHo
A9BbVbgjeArqZ40msdftbJT2YBP8tuVHNjWybt5KCIDRdn0K0p1hfodkYWVAfSt/0fyEOd2G
KYCpMt0JyHFOcq+S0USuGPPU1eWl4BRmVxlqqZl7ifTsk0SB68F+4pFZ/ErbmAAAG7vclHTn
ChoAAd8u+rsDALNfMVWxxGf7AgAAAAAEWVo=

--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.7.0-rc5-00101-gff5c4f5cad330"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.7.0-rc5 Kernel Configuration
#

#
# Compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=234000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_UAPI_HEADER_TEST is not set
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
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_FORCE=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_SCHED_THERMAL_PRESSURE=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
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
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
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
CONFIG_EXPERT=y
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
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
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
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
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
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
# CONFIG_MICROCODE_OLD_INTERFACE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=m
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
# CONFIG_AMD_MEM_ENCRYPT is not set
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_UMIP is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
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
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_TINY_POWER_BUTTON is not set
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
# CONFIG_ACPI_THERMAL is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_PMIC_OPREGION=y
# CONFIG_CHT_WC_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=m
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

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
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
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
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
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

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
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
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
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
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
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

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
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
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
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
CONFIG_MQ_IOSCHED_DEADLINE=m
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=m
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
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
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
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=m
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_READ_ONLY_THP_FOR_FS=y
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
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_NET_FLOW_LIMIT=y

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
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
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
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
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
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=m
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
# CONFIG_FW_CACHE is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# CONFIG_KUNIT_DRIVER_PE_TEST is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=m
CONFIG_MHI_BUS=m
# end of Bus devices

# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
CONFIG_MTD=y
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
CONFIG_INFTL=m
CONFIG_RFD_FTL=y
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=y
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_OTP=y
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=m
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=m
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_PHYSMAP_VERSATILE is not set
# CONFIG_MTD_PHYSMAP_GEMINI is not set
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=m
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_RAW_NAND=y
CONFIG_MTD_NAND_ECC_SW_BCH=y

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=y
# CONFIG_MTD_NAND_DENALI_PCI is not set
CONFIG_MTD_NAND_DENALI_DT=y
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_MXIC=m
CONFIG_MTD_NAND_GPIO=m
# CONFIG_MTD_NAND_PLATFORM is not set
CONFIG_MTD_NAND_CADENCE=m

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=m
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_MTD_HYPERBUS=m
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
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_FD=y
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_INTEL_MIC_BUS is not set
# CONFIG_SCIF_BUS is not set
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=m

#
# Please see Documentation/ide/ide.rst for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_BLK_DEV_IDE_SATA=y
# CONFIG_IDE_GD is not set
# CONFIG_BLK_DEV_DELKIN is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_CMD640=m
CONFIG_BLK_DEV_CMD640_ENHANCED=y
# CONFIG_BLK_DEV_IDEPNP is not set

#
# PCI IDE chipsets support
#
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=m
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
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
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
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
CONFIG_NET_VENDOR_GOOGLE=y
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
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
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
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
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

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
CONFIG_NVM_PBLK=m
# CONFIG_NVM_PBLK_DEBUG is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=m
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=m
# CONFIG_KEYBOARD_QT2160 is not set
CONFIG_KEYBOARD_DLINK_DIR685=y
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=m
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=m
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_IQS62X=m
CONFIG_KEYBOARD_OMAP4=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_TWL4030=m
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CROS_EC=m
CONFIG_KEYBOARD_CAP11XX=y
# CONFIG_KEYBOARD_BCM is not set
CONFIG_KEYBOARD_MTK_PMIC=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=y
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_JOYSTICK_FSIA6B=y
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=m
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM860X_ONKEY is not set
# CONFIG_INPUT_88PM80X_ONKEY is not set
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=m
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MAX8925_ONKEY is not set
# CONFIG_INPUT_MAX8997_HAPTIC is not set
CONFIG_INPUT_MMA8450=y
# CONFIG_INPUT_APANEL is not set
CONFIG_INPUT_GP2A=y
CONFIG_INPUT_GPIO_BEEPER=y
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
# CONFIG_INPUT_RETU_PWRBUTTON is not set
CONFIG_INPUT_AXP20X_PEK=m
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_VIBRA=m
CONFIG_INPUT_UINPUT=m
CONFIG_INPUT_PCF50633_PMU=y
CONFIG_INPUT_PCF8574=m
CONFIG_INPUT_PWM_BEEPER=y
CONFIG_INPUT_PWM_VIBRA=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA9052_ONKEY=y
CONFIG_INPUT_DA9055_ONKEY=y
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_WM831X_ON=m
CONFIG_INPUT_ADXL34X=y
# CONFIG_INPUT_ADXL34X_I2C is not set
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_SOC_BUTTON_ARRAY=m
CONFIG_INPUT_DRV260X_HAPTICS=m
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
CONFIG_INPUT_STPMIC1_ONKEY=y
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F55=y

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
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
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
CONFIG_LDISC_AUTOLOAD=y

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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
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
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
# CONFIG_IPMB_DEVICE_INTERFACE is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=m
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=m
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=m
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_DEMUX_PINCTRL=m
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
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
# CONFIG_I2C_CHT_WC is not set
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
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_RK3X=y
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
# CONFIG_DW_I3C_MASTER is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

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
CONFIG_PINCTRL_AXP209=m
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_DA9062 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_MAX77620=y
CONFIG_PINCTRL_OCELOT=y
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_LYNXPOINT=m
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_TIGERLAKE=y
CONFIG_PINCTRL_LOCHNAGAR=y
CONFIG_PINCTRL_EQUILIBRIUM=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LOGICVC=y
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_SAMA5D2_PIOBU=y
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_WCD934X=m
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=m
# CONFIG_GPIO_GPIO_MM is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD70528=y
CONFIG_GPIO_BD71828=m
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_LP87565=m
CONFIG_GPIO_MAX77620=m
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_TWL4030=m
# CONFIG_GPIO_WM831X is not set
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

CONFIG_GPIO_MOCKUP=m
CONFIG_W1=m

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=m
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS250X=m
# CONFIG_W1_SLAVE_DS2780 is not set
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=m
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_LEGO_EV3=y
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9030=y
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=m
# CONFIG_BATTERY_TWL4030_MADC is not set
CONFIG_CHARGER_PCF50633=m
CONFIG_BATTERY_RX51=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_TWL4030=m
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_LP8788 is not set
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_MAX8998=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_CROS_USBPD=m
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD70528=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=m
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=m
CONFIG_SENSORS_ADM9240=y
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AS370=m
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_DA9055=m
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LOCHNAGAR=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=y
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=m
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_BEL_PFE=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR38064=m
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LTC2978 is not set
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_PXE1610 is not set
CONFIG_SENSORS_TPS40422=m
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_XDPE122=y
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_PWM_FAN=m
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_WM831X=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_CLOCK_THERMAL=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=y
CONFIG_MAX77620_THERMAL=m
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_PKG_TEMP_THERMAL=y
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
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_BD70528_WATCHDOG is not set
CONFIG_DA9052_WATCHDOG=y
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=y
CONFIG_GPIO_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_RAVE_SP_WATCHDOG=m
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=m
CONFIG_RN5T618_WATCHDOG=m
# CONFIG_TWL4030_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_MAX77620_WATCHDOG=y
CONFIG_RETU_WATCHDOG=y
CONFIG_STPMIC1_WATCHDOG=y
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=m
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=m
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
CONFIG_TQMX86_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_NI903X_WDT=m
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=m
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC_DEV=m
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=m
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
CONFIG_INTEL_SOC_PMIC_CHTWC=y
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=m
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=m
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=m
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=m
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=m
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=m
CONFIG_MFD_ROHM_BD718XX=m
CONFIG_MFD_ROHM_BD70528=y
CONFIG_MFD_ROHM_BD71828=m
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=m
CONFIG_RAVE_SP_CORE=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AB3100=m
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BD70528=m
# CONFIG_REGULATOR_BD71828 is not set
CONFIG_REGULATOR_BD718XX=m
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9055=m
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LOCHNAGAR=m
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=m
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX14577=m
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77620=m
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX8998=m
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=y
# CONFIG_REGULATOR_MP886X is not set
CONFIG_REGULATOR_MPQ7920=y
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6397=m
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_ROHM=m
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_S2MPA01=m
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_STPMIC1=m
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS6586X=m
# CONFIG_REGULATOR_TPS80031 is not set
CONFIG_REGULATOR_TWL4030=m
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=y
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_CEC_CORE=m
CONFIG_CEC_NOTIFIER=y
# CONFIG_RC_CORE is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_I2C_NXP_TDA9950=m
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=m
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
CONFIG_DRM_VKMS=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=m
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=m
CONFIG_DRM_PANEL_BOE_HIMAX8279D=m
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
CONFIG_DRM_PANEL_LVDS=m
# CONFIG_DRM_PANEL_SIMPLE is not set
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=m
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
CONFIG_DRM_PANEL_NOVATEK_NT35510=m
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_ROCKTECH_JH057N00900 is not set
CONFIG_DRM_PANEL_RONBO_RB070D30=m
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=m
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
CONFIG_DRM_PANEL_SONY_ACX424AKP=m
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=m
CONFIG_DRM_DISPLAY_CONNECTOR=m
CONFIG_DRM_LVDS_CODEC=m
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
CONFIG_DRM_NXP_PTN3460=m
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_PARADE_PS8640=m
# CONFIG_DRM_SIL_SII8620 is not set
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
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_I2C_ADV7511=m
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_DW_HDMI=m
CONFIG_DRM_DW_HDMI_CEC=m
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=m
# CONFIG_DRM_ETNAVIV_THERMAL is not set
# CONFIG_DRM_ARCPGU is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_N411 is not set
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
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_GOLDFISH is not set
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
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA903X is not set
# CONFIG_BACKLIGHT_DA9052 is not set
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_88PM860X is not set
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_LM3630A=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_LP8788=y
CONFIG_BACKLIGHT_PANDORA=m
CONFIG_BACKLIGHT_SKY81452=m
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_BACKLIGHT_RAVE_SP=m
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=m
CONFIG_HID_COUGAR=m
CONFIG_HID_MACALLY=m
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=m
CONFIG_HID_GYRATION=m
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MALTRON=m
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=m
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=m
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=m
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID=m
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
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=m
# CONFIG_PWRSEQ_SIMPLE is not set
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
CONFIG_MMC_SDHCI_OF_ARASAN=m
CONFIG_MMC_SDHCI_OF_ASPEED=m
# CONFIG_MMC_SDHCI_OF_AT91 is not set
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
CONFIG_MMC_SDHCI_CADENCE=m
CONFIG_MMC_SDHCI_F_SDH30=m
CONFIG_MMC_SDHCI_MILBEAUT=m
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_GOLDFISH=m
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_CQHCI=m
CONFIG_MMC_HSQ=y
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MMC_SDHCI_OMAP is not set
CONFIG_MMC_SDHCI_AM654=m
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=y
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_CLEVO_MAIL=m
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_PWM=m
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
# CONFIG_RTC_DRV_88PM80X is not set
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_AS3722 is not set
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_MAX8998=m
CONFIG_RTC_DRV_MAX8997=m
CONFIG_RTC_DRV_MAX77686=m
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BD70528=y
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_TWL4030 is not set
CONFIG_RTC_DRV_TPS6586X=m
# CONFIG_RTC_DRV_TPS80031 is not set
CONFIG_RTC_DRV_RC5T583=y
CONFIG_RTC_DRV_RC5T619=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_S5M is not set
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_DS1286=m
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
CONFIG_RTC_DRV_DS17285=y
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9052=m
CONFIG_RTC_DRV_DA9055=y
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=m
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_PCF50633=y
# CONFIG_RTC_DRV_AB3100 is not set
# CONFIG_RTC_DRV_ZYNQMP is not set
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=m
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_MT6397=m
CONFIG_RTC_DRV_R7301=m

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=y
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_VDPA=m
# CONFIG_VIRTIO_PMEM is not set
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VDPA=m
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_DPN=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_SCSI=m
CONFIG_VHOST_VDPA=m
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_STAGING=y
CONFIG_COMEDI=m
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
CONFIG_COMEDI_TEST=m
CONFIG_COMEDI_PARPORT=m
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set

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
CONFIG_ADT7316=y
CONFIG_ADT7316_I2C=y
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# end of Android

# CONFIG_STAGING_BOARD is not set
CONFIG_GOLDFISH_AUDIO=y
CONFIG_GS_FPGABOOT=y
# CONFIG_UNISYSSPAR is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=m
# CONFIG_KS7010 is not set
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=y
CONFIG_GREYBUS_LOOPBACK=y
CONFIG_GREYBUS_POWER=m
CONFIG_GREYBUS_RAW=m
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
CONFIG_GREYBUS_PWM=m
CONFIG_GREYBUS_SDIO=m
# CONFIG_GREYBUS_UART is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=m
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_MFD_CROS_EC=m
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=m
CONFIG_CHROMEOS_TBMC=m
CONFIG_CROS_EC=m
CONFIG_CROS_EC_I2C=m
CONFIG_CROS_EC_RPMSG=m
CONFIG_CROS_EC_LPC=m
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=m
CONFIG_CROS_EC_CHARDEV=m
# CONFIG_CROS_EC_LIGHTBAR is not set
# CONFIG_CROS_EC_VBC is not set
CONFIG_CROS_EC_DEBUGFS=m
CONFIG_CROS_EC_SENSORHUB=m
# CONFIG_CROS_EC_SYSFS is not set
CONFIG_CROS_USBPD_LOGGER=m
CONFIG_CROS_USBPD_NOTIFY=m
# CONFIG_WILCO_EC is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=m
CONFIG_CLK_HSDK=y
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_COMMON_CLK_LOCHNAGAR=y
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_BD718XX=y
CONFIG_COMMON_CLK_FIXED_MMIO=y
# end of Common Clock Framework

CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_AMD_IOMMU is not set

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
CONFIG_XILINX_VCU=m
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_INTEL_INT3496=y
# CONFIG_EXTCON_INTEL_CHT_WC is not set
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PTN5150=m
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
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
CONFIG_BMA180=y
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=m
CONFIG_DA311=m
# CONFIG_DMARD06 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
CONFIG_KXSD9=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=m
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=m
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=y
CONFIG_AD7291=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD799X=m
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
CONFIG_CC10001_ADC=y
# CONFIG_DA9150_GPADC is not set
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_HX711 is not set
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
CONFIG_LTC2485=m
CONFIG_LTC2497=y
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=m
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_RN5T618_ADC=y
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_STX104=y
CONFIG_TI_ADC081C=y
CONFIG_TI_ADS1015=y
CONFIG_TWL4030_MADC=y
# CONFIG_TWL6030_GPADC is not set
CONFIG_VF610_ADC=y
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=m
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_BME680=m
CONFIG_BME680_I2C=m
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
CONFIG_PMS7003=m
CONFIG_SENSIRION_SGP30=m
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m
# CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
# CONFIG_AD5380 is not set
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
CONFIG_CIO_DAC=m
CONFIG_DPOT_DAC=m
CONFIG_DS4424=m
# CONFIG_M62332 is not set
CONFIG_MAX517=m
CONFIG_MAX5821=m
CONFIG_MCP4725=m
CONFIG_TI_DAC5571=m
CONFIG_VF610_DAC=m
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
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
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_HID_SENSOR_GYRO_3D=m
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
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
CONFIG_KMX61=m
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=m
CONFIG_BH1750=y
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM3605=y
CONFIG_CM36651=m
# CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=m
# CONFIG_IQS621_ALS is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=m
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
CONFIG_LTR501=m
CONFIG_LV0104CS=m
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=m
CONFIG_NOA1305=y
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=y
CONFIG_SI1133=m
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=m
CONFIG_US5182D=y
CONFIG_VCNL4000=m
CONFIG_VCNL4035=m
CONFIG_VEML6030=y
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=m
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
# CONFIG_SENSORS_RM3100_I2C is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=m
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
CONFIG_MAX5432=m
CONFIG_MCP4018=y
CONFIG_MCP4531=y
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
CONFIG_IIO_CROS_EC_BARO=m
CONFIG_DLHL60D=y
CONFIG_DPS310=m
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=y
CONFIG_ICP10100=y
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=y
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
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
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=m
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
CONFIG_SX9500=m
CONFIG_SRF08=m
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_IQS620AT_TEMP is not set
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=m
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=m
# CONFIG_TSYS02D is not set
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CROS_EC is not set
CONFIG_PWM_FSL_FTM=m
# CONFIG_PWM_LP3943 is not set
CONFIG_PWM_LPSS=m
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=m

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_BRCMSTB_RESCAL=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_CADENCE_TORRENT=m
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_MIXEL_MIPI_DPHY=m
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=m
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=y
# CONFIG_BTT is not set
CONFIG_OF_PMEM=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=y
# CONFIG_DEV_DAX_KMEM is not set
# CONFIG_NVMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=y
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
# CONFIG_FPGA_DFL_FME_MGR is not set
CONFIG_FPGA_DFL_FME_BRIDGE=m
CONFIG_FPGA_DFL_FME_REGION=m
# CONFIG_FPGA_DFL_AFU is not set
# CONFIG_FPGA_DFL_PCI is not set
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
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_UNISYS_VISORBUS=m
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
# CONFIG_104_QUAD_8 is not set
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=m
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
CONFIG_JFFS2_SUMMARY=y
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_LZO=y
# CONFIG_JFFS2_RTIME is not set
CONFIG_JFFS2_RUBIN=y
CONFIG_JFFS2_CMODE_NONE=y
# CONFIG_JFFS2_CMODE_PRIORITY is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
CONFIG_UBIFS_FS=y
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
CONFIG_UBIFS_ATIME_SUPPORT=y
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
CONFIG_UBIFS_FS_AUTHENTICATION=y
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
# CONFIG_SQUASHFS is not set
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=m
CONFIG_OMFS_FS=m
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=m
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
# CONFIG_ROMFS_BACKED_BY_MTD is not set
CONFIG_ROMFS_BACKED_BY_BOTH=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_842_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="842"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
# CONFIG_PSTORE_RAM is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
# CONFIG_EROFS_FS_POSIX_ACL is not set
# CONFIG_EROFS_FS_SECURITY is not set
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
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
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=m
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
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
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
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
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_CURVE25519 is not set
CONFIG_CRYPTO_CURVE25519_X86=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_NHPOLY1305=m
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_AVX2=m
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_BLAKE2S_X86=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
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
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=m
CONFIG_CRYPTO_LIB_BLAKE2S=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
CONFIG_CRYPTO_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
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
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
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
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
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
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
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
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y
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
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_STACK_VALIDATION is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_TEST=m
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
# CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

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

CONFIG_DEBUG_TIMEKEEPING=y

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
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
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
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_STACK_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_KPROBE_EVENTS is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
CONFIG_TRACEPOINT_BENCHMARK=y
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=m
# CONFIG_KUNIT_EXAMPLE_TEST is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_KCOV_INSTRUMENT_ALL=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--zx4FCpZtqtKETZ7O--
