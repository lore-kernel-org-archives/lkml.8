Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D45C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B58206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgEUX6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:58:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:19369 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgEUX6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:58:37 -0400
IronPort-SDR: moKI3ziEMYW3pyMMXiXZYHh4B9MH9Lq9QzRa1pxDOQJN43t3S3dG8FSyCRoTXRl9jOFiJgzHkp
 QGPeLJlJo4PA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 16:57:26 -0700
IronPort-SDR: dY65Wx9tu20xAFqcB2Uo5rbnsf4YeSLpV6vPtdVxjUcX7iI7PmW5coh/QJC1IqsqHyno1ew/0j
 PoaO1yr6NU6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="xz'?gz'50?scan'50,208,50";a="412583559"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 May 2020 16:57:21 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jbv3x-0007OG-9A; Fri, 22 May 2020 07:57:21 +0800
Date:   Fri, 22 May 2020 07:56:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     LKP <lkp@lists.01.org>, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Wolfram Sang <wsa-dev@sang-engineering.com>,
        philip.li@intel.com
Subject: 6fe12cdbcf ("i2c: core: support bus regulator controlling in
 .."):  BUG: sleeping function called from invalid context at
 kernel/locking/mutex.c:935
Message-ID: <5ec71528.qSD3ljogzEHcLRXO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5ec71528.0QLGqQ/3LEsf5mMcGcUd845ptqqZ30AbAEbHAutQsyKP7C/w"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5ec71528.0QLGqQ/3LEsf5mMcGcUd845ptqqZ30AbAEbHAutQsyKP7C/w
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

commit 6fe12cdbcfe35ad4726a619a9546822d34fc934c
Author:     Bibby Hsieh <bibby.hsieh@mediatek.com>
AuthorDate: Tue May 19 15:27:29 2020 +0800
Commit:     Wolfram Sang <wsa@kernel.org>
CommitDate: Wed May 20 15:25:55 2020 +0200

    i2c: core: support bus regulator controlling in adapter
    
    Although in the most platforms, the bus power of i2c
    are alway on, some platforms disable the i2c bus power
    in order to meet low power request.
    
    We get and enable bulk regulator in i2c adapter device.
    
    Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
    Reviewed-by: Tomasz Figa <tfiga@chromium.org>
    Signed-off-by: Wolfram Sang <wsa@kernel.org>

6aab46bc52  dt-binding: i2c: add bus-supply property
6fe12cdbcf  i2c: core: support bus regulator controlling in adapter
+-----------------------------------------------------------------------------+------------+------------+
|                                                                             | 6aab46bc52 | 6fe12cdbcf |
+-----------------------------------------------------------------------------+------------+------------+
| boot_successes                                                              | 33         | 0          |
| boot_failures                                                               | 2          | 16         |
| WARNING:at_lib/kobject_uevent.c:#add_uevent_var                             | 1          |            |
| EIP:add_uevent_var                                                          | 1          |            |
| BUG:kernel_hang_in_boot_stage                                               | 1          |            |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c | 0          | 16         |
+-----------------------------------------------------------------------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[  105.730065] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13/status
[  105.730071] ### dt-test ### EXPECT \ : i2c i2c-1: Added multiplexed i2c bus 3
[  105.747587] i2c i2c-3: supply bus not found, using dummy regulator
[  105.754529] i2c i2c-1: Added multiplexed i2c bus 3
[  105.756092] ### dt-test ### EXPECT / : i2c i2c-1: Added multiplexed i2c bus 3
[  105.773831] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
[  105.777468] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 189, name: kworker/0:2
[  105.778995] 2 locks held by kworker/0:2/189:
[  105.779775]  #0: f48249a4 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x3ac/0x1050
[  105.781743]  #1: f4145f34 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: process_one_work+0x3ac/0x1050
[  105.783485] Preemption disabled at:
[  105.783509] [<cdbb653d>] srcu_invoke_callbacks+0x14d/0x280
[  105.785397] CPU: 0 PID: 189 Comm: kworker/0:2 Not tainted 5.7.0-rc1-00058-g6fe12cdbcfe35 #1
[  105.786961] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  105.788608] Workqueue: rcu_gp srcu_invoke_callbacks
[  105.789777] Call Trace:
[  105.790308]  dump_stack+0x32/0x4a
[  105.790914]  ___might_sleep+0x3dc/0x4b0
[  105.791659]  ? srcu_invoke_callbacks+0x14d/0x280
[  105.792574]  ? srcu_invoke_callbacks+0x14d/0x280
[  105.793677]  ? srcu_invoke_callbacks+0x14d/0x280
[  105.794480]  __might_sleep+0x10e/0x210
[  105.795186]  __mutex_lock+0x34/0x12f0
[  105.795838]  ? mark_held_locks+0xb3/0x100
[  105.796561]  ? _raw_spin_unlock_irqrestore+0x13b/0x190
[  105.797694]  ? _raw_spin_unlock_irqrestore+0x13b/0x190
[  105.798653]  ? lockdep_hardirqs_on+0x1bb/0x420
[  105.799462]  mutex_lock_nested+0x41/0x60
[  105.800155]  ? regulator_put+0x25/0x70
[  105.800839]  regulator_put+0x25/0x70
[  105.801641]  devm_regulator_release+0x1d/0x30
[  105.802415]  release_nodes+0x326/0x500
[  105.803126]  devres_release_all+0xb9/0x130
[  105.803873]  device_release+0x25/0x1b0
[  105.804548]  ? srcu_invoke_callbacks+0xfa/0x280
[  105.805591]  kobject_put+0x33e/0x800
[  105.806244]  ? refcount_dec_not_one+0x107/0x2f0
[  105.807050]  ? srcu_invoke_callbacks+0x14d/0x280
[  105.807918]  __device_link_free_srcu+0x79/0xe0
[  105.808685]  srcu_invoke_callbacks+0x160/0x280
[  105.809729]  process_one_work+0x594/0x1050
[  105.810535]  ? process_one_work+0x3ac/0x1050
[  105.811314]  ? _raw_spin_lock_irq+0x56/0xe0
[  105.812113]  worker_thread+0x4a3/0xc00
[  105.812823]  kthread+0x31f/0x3b0
[  105.813537]  ? rescuer_thread+0x720/0x720
[  105.814227]  ? kthread_bind+0x30/0x30
[  105.814920]  ret_from_fork+0x19/0x24
[  105.866663] ### dt-test ### EXPECT \ : GPIO line <<int>> (line-B-input) hogged as input
[  105.868134] ### dt-test ### EXPECT \ : GPIO line <<int>> (line-A-input) hogged as input
[  105.870372] GPIO line 509 (line-B-input) hogged as input
[  105.872524] GPIO line 503 (line-A-input) hogged as input
[  105.874446] ### dt-test ### EXPECT / : GPIO line <<int>> (line-A-input) hogged as input

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start d0edf98c01ebe0790295cf888a2976d2d04377b1 b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce --
git bisect  bad 4fde3f7c56e653e1d62102a4a77534f4bfec9689  # 07:04  B      0    17   33   0  Merge 'linux-review/Anson-Huang/ARM-dts-imx-Make-tempmon-node-as-child-of-anatop-node/20200520-230948' into devel-hourly-2020052107
git bisect  bad e8344c6f4e6b7a7318fa46dd6fd5418f3e36d010  # 07:04  B      0    17   33   0  Merge 'linux-review/Gabriel-Krisman-Bertazi/iscsi-Fix-deadlock-on-recovery-path-during-GFP_IO-reclaim/20200520-220836' into devel-hourly-2020052107
git bisect good 6332b5a106b02909b3ac673832d1e36a901d81fa  # 07:04  G     11     0    0   0  Merge 'stericsson/ux500-dts' into devel-hourly-2020052107
git bisect  bad 05c599fa08c02ea883075d05cc544f5e133dad15  # 07:04  B      0    11   27   0  Merge 'ras/edac-misc' into devel-hourly-2020052107
git bisect good 25ef63dabd6b9567bd3d7870c5e8595b6b87c678  # 07:05  G     11     0    0   0  Merge 'linux-review/Maulik-Shah/arm64-dts-qcom-sc7180-Correct-the-pdc-interrupt-ranges/20200518-202257' into devel-hourly-2020052107
git bisect good 0db2ae8dfea89b3541eb5ffb6e0aed13d921b277  # 07:05  G     11     0    0   0  Merge 'linux-review/Geert-Uytterhoeven/ARM-dts-r9a06g032-Correct-GIC-compatible-value-order/20200519-204708' into devel-hourly-2020052107
git bisect good aeee233deb1c06fcf7630402c1f15208aa3d723a  # 07:05  G     11     0    0   0  Merge 'linux-review/Lubomir-Rintel/media-marvell-ccic-Add-support-for-runtime-PM/20200521-053250' into devel-hourly-2020052107
git bisect  bad 6872daa8abed0e8bd8447d56cfca80c4d29d6243  # 07:05  B      0    10   27   1  Merge 'linux-review/Dinghao-Liu/i2c-imx-lpi2c-fix-runtime-pm-imbalance-on-error/20200521-033738' into devel-hourly-2020052107
git bisect good f23da43a58d09dc6ea58837a45374e15de36537e  # 07:05  G     10     0    0   1  Merge branch 'i2c/for-current' into i2c/for-next
git bisect good fadb47fca1f132c123395bca26c69007e816988f  # 07:05  G     11     0    0   0  Merge branch 'i2c/for-5.8' into i2c/for-next
git bisect  bad 4f118a7e4686062bd4df4a37e24c22cd71495b5f  # 07:05  B      0    11   27   0  Merge tag 'for-5.8-i2c' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into i2c/for-5.8
git bisect good c73178b93754edd8449dccd3faf05baafd4d3f0e  # 07:05  G     11     0    0   0  i2c: tegra: Add support for the VI I2C on Tegra210
git bisect good 6aab46bc52a8f579879d491c9d8062e03caa5c61  # 07:05  G     30     0    0   3  dt-binding: i2c: add bus-supply property
git bisect  bad f89c326dcaa0cb8c3af7764e75eeed4e3f3c879a  # 07:05  B      0    15   31   0  Merge branch 'i2c/for-current-fixed' into i2c/for-5.8
git bisect  bad 6fe12cdbcfe35ad4726a619a9546822d34fc934c  # 07:05  B      0    15   45   0  i2c: core: support bus regulator controlling in adapter
# first bad commit: [6fe12cdbcfe35ad4726a619a9546822d34fc934c] i2c: core: support bus regulator controlling in adapter
git bisect good 6aab46bc52a8f579879d491c9d8062e03caa5c61  # 07:06  G     30     0    0   3  dt-binding: i2c: add bus-supply property
# extra tests with debug options
git bisect  bad 6fe12cdbcfe35ad4726a619a9546822d34fc934c  # 07:06  B      0    14   30   0  i2c: core: support bus regulator controlling in adapter
# extra tests on revert first bad commit
git bisect good 3788bb973ab542fcf623106a1cef5d8b1e237f7c  # 07:56  G     10     0    0   0  Revert "i2c: core: support bus regulator controlling in adapter"
# good: [3788bb973ab542fcf623106a1cef5d8b1e237f7c] Revert "i2c: core: support bus regulator controlling in adapter"

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--=_5ec71528.0QLGqQ/3LEsf5mMcGcUd845ptqqZ30AbAEbHAutQsyKP7C/w
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-openwrt-vm-openwrt-30:20200522001242:i386-randconfig-a013-20200520:5.7.0-rc1-00058-g6fe12cdbcfe35:1.gz"

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
u/c/yu0/+HEjAQAK

--=_5ec71528.0QLGqQ/3LEsf5mMcGcUd845ptqqZ30AbAEbHAutQsyKP7C/w
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-openwrt-vm-openwrt-33:20200522002459:i386-randconfig-a013-20200520:5.7.0-rc1-00057-g6aab46bc52a8f:1.gz"

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
p5LSeuJ1Y3r2YPrd1tuk/nll/kN65os7Y1ln6dkvVLo5yd69X3r1e2Npw9v4snx1d3078f7T
zKxuaUtL6wfyz2+J1dTM2/2NK72yeno2v7Q9fz2Vq2eTM+fvtzNnGz/swlRh9lC++Tapvjvf
tRKF9zN8fm1h5dVlNb08lxxPvCmwz2Ry/ZXmXlyu2EfFQj4hTX/g13PLbw42Uqe7999St9f7
3ye046tzdTE3MbUtJ+9Wb6jzy52dXvj0Z8pvVIzSzfbyycxRY+vT3X3+dyld/nOTd35U/hwW
Juec6v6O+6o8n1jLHP2c/OiNz9VKc/bpz4vcncR/fagXfi/t/WTfJk9uj3fvJrX7twnv5Gpx
L+duHjdy49/kXzPW97nNX+WF3SXl8Gj25uwmt5K6uywvL3reu+3bhdMjufIrZWUvyBbdP/6T
yq3t7c4Z784OJxdu9vls4vLtd/fjyc/pk5w2/UNVlj45N/V7urPNC++cPx+vnStrQ8kuzZe8
vduvl8nxxUKltdgZxc1gMV9zOlf8qkhT0ToWjhpAlMv7pwH+aYB/GuB/SQM0l7uhaOILd5fl
nrMKImWByMOHTsJ9za+B01AoiCew8LP/Vv6/lf9v5f/3V3603FVqUHy9lIr9OycO7KmuMBnl
Rfx5sw2jDLNvWa5rBhsD89aCpW83sKyoyPEB2gHUQzF8Px42MjAfbDOn9MruEeYi2d1chd2Z
rujEqpNC3s5cl+1v+MUmwJx2sqpGO7p6Q78z1cvAT5u28Esy5rbeKruNAr7uz5cwSVK+lI1B
aEj2g45XysVi26Z5G7/ZwW4YX3P3TwtIJlgLPRffcDasqiucIUwikiV7a1tHmFW15GJO0t0V
kshzTnOn5A1QsHk6CztZQ03OkuXNnQPC0kyC3hihPENZRgI+t9ArEn7gW9vczQ7EDkXHN+Qr
ZReI4BaeitRlPNhl68RmxFOIa2D8LDxk8NCJPaTE0fAMicSJxYnnEVknrk48XZyPNYjktrA5
tAs2h7dhm6f+Ip6xCFu09w/kKDC/DnEk7ARPJseCeiNCWsPSVRzW2tIpzKH4JylkbRl+85mn
W/A7WVtp/g1/W4391kJjiA9Oaweb4R81H9CsbsYbLu8KpJrvwvjXDpq/SU4TjURFbdfVA2yn
2QAV3uQOAkxkXdzIMjkQNypgyn1cCp5S/OaitpAxUaNhZZ9miQ6yJpqt7EsAqruSGNrKvpwl
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

--=_5ec71528.0QLGqQ/3LEsf5mMcGcUd845ptqqZ30AbAEbHAutQsyKP7C/w
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-openwrt-vm-openwrt-30:20200522001242:i386-randconfig-a013-20200520:5.7.0-rc1-00058-g6fe12cdbcfe35:1"

#!/bin/bash

kernel=$1
initrd=openwrt-i386-trinity.cgz

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

--=_5ec71528.0QLGqQ/3LEsf5mMcGcUd845ptqqZ30AbAEbHAutQsyKP7C/w
Content-Type: application/x-xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="d0edf98c01ebe0790295cf888a2976d2d04377b1:gcc-5:i386-randconfig-a013-20200520:BUG:sleeping_function_called_from_invalid_context_at_kernel_locking_mutex.c.xz"

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
AARZWg==

--=_5ec71528.0QLGqQ/3LEsf5mMcGcUd845ptqqZ30AbAEbHAutQsyKP7C/w
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.7.0-rc1-00058-g6fe12cdbcfe35"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.7.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=50500
CONFIG_LD_VERSION=234000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
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
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
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
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
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
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
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
# CONFIG_BOOT_CONFIG is not set
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
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
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
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_PROFILING=y
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
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
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
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
CONFIG_MEFFICEON=y
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
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_ANCIENT_MCE=y

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=y
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_16BIT is not set
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
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
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
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
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
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

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
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
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
CONFIG_PCI_GODIRECT=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_GEOS=y
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
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

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
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM_WERROR is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_4_7=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
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
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
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
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_IPVTI=y
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
CONFIG_IPV6_VTI=y
CONFIG_IPV6_SIT=m
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
# CONFIG_MPTCP_HMAC_TEST is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
# CONFIG_BRIDGE_NETFILTER is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NETFILTER_NETLINK_OSF is not set
CONFIG_NF_CONNTRACK=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
# CONFIG_NF_CONNTRACK_AMANDA is not set
# CONFIG_NF_CONNTRACK_FTP is not set
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_SNMP is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
# CONFIG_NF_CONNTRACK_SIP is not set
# CONFIG_NF_CONNTRACK_TFTP is not set
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_NAT=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_NUMGEN is not set
# CONFIG_NFT_CT is not set
CONFIG_NFT_FLOW_OFFLOAD=m
# CONFIG_NFT_COUNTER is not set
# CONFIG_NFT_CONNLIMIT is not set
# CONFIG_NFT_LOG is not set
# CONFIG_NFT_LIMIT is not set
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
# CONFIG_NFT_COMPAT is not set
# CONFIG_NFT_HASH is not set
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_DUP_NETDEV is not set
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=m

#
# Xtables combined modules
#
# CONFIG_NETFILTER_XT_MARK is not set
# CONFIG_NETFILTER_XT_CONNMARK is not set

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
# CONFIG_NETFILTER_XT_TARGET_LED is not set
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
# CONFIG_NETFILTER_XT_TARGET_MARK is not set
CONFIG_NETFILTER_XT_NAT=m
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
# CONFIG_NETFILTER_XT_TARGET_MASQUERADE is not set
# CONFIG_NETFILTER_XT_TARGET_TEE is not set
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_BPF is not set
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ECN is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
# CONFIG_NETFILTER_XT_MATCH_HL is not set
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_MAC is not set
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
# CONFIG_NETFILTER_XT_MATCH_STATE is not set
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TPROXY_IPV4 is not set
CONFIG_NF_TABLES_IPV4=y
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_FLOW_TABLE_IPV4=m
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_AH is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_FILTER is not set
# CONFIG_IP_NF_TARGET_SYNPROXY is not set
CONFIG_IP_NF_NAT=m
# CONFIG_IP_NF_TARGET_MASQUERADE is not set
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_SECURITY is not set
# CONFIG_IP_NF_ARPTABLES is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TPROXY_IPV6 is not set
CONFIG_NF_TABLES_IPV6=y
# CONFIG_NFT_DUP_IPV6 is not set
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_FLOW_TABLE_IPV6=m
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
CONFIG_IP6_NF_IPTABLES=m
# CONFIG_IP6_NF_MATCH_AH is not set
# CONFIG_IP6_NF_MATCH_EUI64 is not set
# CONFIG_IP6_NF_MATCH_FRAG is not set
# CONFIG_IP6_NF_MATCH_OPTS is not set
# CONFIG_IP6_NF_MATCH_HL is not set
# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
# CONFIG_IP6_NF_MATCH_MH is not set
# CONFIG_IP6_NF_MATCH_RT is not set
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_FILTER is not set
# CONFIG_IP6_NF_TARGET_SYNPROXY is not set
# CONFIG_IP6_NF_MANGLE is not set
# CONFIG_IP6_NF_RAW is not set
# CONFIG_IP6_NF_SECURITY is not set
CONFIG_IP6_NF_NAT=m
# CONFIG_IP6_NF_TARGET_MASQUERADE is not set
# CONFIG_IP6_NF_TARGET_NPT is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m

#
# DECnet: Netfilter Configuration
#
# CONFIG_DECNET_NF_GRABULATOR is not set
# end of DECnet: Netfilter Configuration

# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_LTPC=y
# CONFIG_COPS is not set
CONFIG_IPDDP=y
# CONFIG_IPDDP_ENCAP is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_ATM=y
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=y
CONFIG_NET_SCH_RED=y
# CONFIG_NET_SCH_SFB is not set
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_NETEM=y
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=y
# CONFIG_NET_SCH_CHOKE is not set
CONFIG_NET_SCH_QFQ=y
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=y
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
CONFIG_DEFAULT_CODEL=y
# CONFIG_DEFAULT_FQ_CODEL is not set
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=y
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=y
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_MCAST=y
CONFIG_BATMAN_ADV_DEBUGFS=y
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_BATMAN_ADV_SYSFS is not set
# CONFIG_BATMAN_ADV_TRACING is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=y
CONFIG_VSOCKETS_LOOPBACK=y
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
CONFIG_HSR=y
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
# CONFIG_CAN_SLCAN is not set
# CONFIG_CAN_DEV is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=y
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=y
# CONFIG_BT_RFCOMM_TTY is not set
# CONFIG_BT_BNEP is not set
# CONFIG_BT_HIDP is not set
# CONFIG_BT_HS is not set
# CONFIG_BT_LE is not set
# CONFIG_BT_LEDS is not set
CONFIG_BT_SELFTEST=y
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_HCIBTUSB=y
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
# CONFIG_BT_HCIBTUSB_BCM is not set
# CONFIG_BT_HCIBTUSB_MTK is not set
# CONFIG_BT_HCIBTUSB_RTL is not set
CONFIG_BT_HCIBTSDIO=y
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIDTL1=y
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
# CONFIG_BT_MRVL_SDIO is not set
CONFIG_BT_ATH3K=y
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
# CONFIG_NFC_NCI is not set
CONFIG_NFC_HCI=y
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_MEI_PHY=y
CONFIG_NFC_SIM=y
CONFIG_NFC_PORT100=y
CONFIG_NFC_PN544=y
CONFIG_NFC_PN544_MEI=y
CONFIG_NFC_PN533=y
# CONFIG_NFC_PN533_USB is not set
CONFIG_NFC_PN533_I2C=y
# CONFIG_NFC_MICROREAD_MEI is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
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
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
# CONFIG_PCIEAER is not set
# CONFIG_PCIEASPM is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
CONFIG_PCIE_XILINX=y

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
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
CONFIG_PCI_EPF_TEST=y
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
# CONFIG_YENTA_O2 is not set
# CONFIG_YENTA_RICOH is not set
# CONFIG_YENTA_TI is not set
CONFIG_YENTA_TOSHIBA=y
# CONFIG_PD6729 is not set
CONFIG_I82092=y
# CONFIG_I82365 is not set
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_TSI568=y
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
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
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
# CONFIG_ZRAM_WRITEBACK is not set
CONFIG_ZRAM_MEMORY_TRACKING=y
CONFIG_BLK_DEV_UMEM=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_SX8=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=y

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_CS5535_MFGPT=y
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
# CONFIG_CS5535_CLOCK_EVENT_SRC is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.rst for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_IDE_LEGACY=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
# CONFIG_IDE_GD_ATAPI is not set
CONFIG_BLK_DEV_IDECS=y
CONFIG_BLK_DEV_DELKIN=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS is not set
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
CONFIG_BLK_DEV_PLATFORM=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
CONFIG_BLK_DEV_CS5520=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_CS5535=y
# CONFIG_BLK_DEV_CS5536 is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_JMICRON=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IT8172=y
CONFIG_BLK_DEV_IT8213=y
CONFIG_BLK_DEV_IT821X=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_BLK_DEV_TC86C001 is not set

#
# Other IDE chipsets support
#

#
# Note: most of these also require special kernel boot parameters
#
CONFIG_BLK_DEV_4DRIVES=y
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
CONFIG_BLK_DEV_HT6560B=y
CONFIG_BLK_DEV_QD65XX=y
CONFIG_BLK_DEV_UMC8672=y
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
# CONFIG_SCSI_DH_HP_SW is not set
# CONFIG_SCSI_DH_EMC is not set
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=y
CONFIG_TCM_USER2=y
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
CONFIG_SBP_TARGET=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
# CONFIG_CAIF_DRIVERS is not set

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
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
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
# CONFIG_USB_HSO is not set
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
CONFIG_NETDEVSIM=m
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
CONFIG_NVM_PBLK=y
CONFIG_NVM_PBLK_DEBUG=y

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
CONFIG_KEYBOARD_ADP5588=y
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
CONFIG_KEYBOARD_QT1070=y
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
# CONFIG_KEYBOARD_MCS is not set
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
# CONFIG_KEYBOARD_OPENCORES is not set
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
CONFIG_KEYBOARD_OMAP4=y
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_TWL4030=y
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
CONFIG_MOUSE_PS2_BYD=y
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
# CONFIG_MOUSE_PS2_CYPRESS is not set
# CONFIG_MOUSE_PS2_LIFEBOOK is not set
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_SERIAL=y
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=y
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
CONFIG_MOUSE_SYNAPTICS_USB=y
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
CONFIG_INPUT_ATMEL_CAPTOUCH=y
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GP2A=y
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_WISTRON_BTNS=y
# CONFIG_INPUT_ATLAS_BTNS is not set
CONFIG_INPUT_ATI_REMOTE2=y
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_TPS65218_PWRBUTTON=y
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_VIBRA=y
CONFIG_INPUT_TWL6040_VIBRA=y
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_PWM_BEEPER=y
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_RK805_PWRKEY is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA9052_ONKEY is not set
# CONFIG_INPUT_DA9063_ONKEY is not set
# CONFIG_INPUT_WM831X_ON is not set
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
# CONFIG_INPUT_IMS_PCU is not set
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=y
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
# CONFIG_RMI4_F30 is not set
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
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
# CONFIG_SERIAL_8250_CS is not set
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
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
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
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_GEODE=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_DTLK=y
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=y

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=y
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
# CONFIG_RAW_DRIVER is not set
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
# end of Character devices

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
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EG20T=y
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
CONFIG_I2C_RK3X=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=y
# CONFIG_I2C_PCA_ISA is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_SCx200_ACB=y
CONFIG_I2C_FSI=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

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
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_DA9062 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_STMFX is not set
# CONFIG_PINCTRL_MAX77620 is not set
# CONFIG_PINCTRL_PALMAS is not set
CONFIG_PINCTRL_RK805=y
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
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L90=y
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_CS5535=y
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DLN2 is not set
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_LP87565=y
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77620=y
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_STMPE=y
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM831X=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9052 is not set
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_88PM860X=y
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=y
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=y
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CPU_THERMAL is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_MAX77620_THERMAL is not set
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_DA9062_THERMAL is not set

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

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=y
CONFIG_GPIO_WATCHDOG_ARCH_INITCALL=y
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
# CONFIG_TWL4030_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
CONFIG_SP5100_TCO=y
CONFIG_GEODE_WDT=y
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=y
# CONFIG_ITCO_VENDOR_SUPPORT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_KEMPLD_WDT is not set
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
# CONFIG_SBC7240_WDT is not set
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
CONFIG_MIXCOMWD=y
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC_DEV=y
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
# CONFIG_MFD_CS47L15 is not set
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SMSC=y
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_LOCHNAGAR is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=y
# CONFIG_MFD_ROHM_BD70528 is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
# CONFIG_MFD_WCD934X is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ARIZONA_LDO1 is not set
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_ROHM=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TWL4030 is not set
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=y
CONFIG_CEC_CORE=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=m
# CONFIG_IR_RC6_DECODER is not set
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
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
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_PCI_SKELETON=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_VMALLOC=y
CONFIG_DVB_CORE=y
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=y
# CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV is not set
CONFIG_USB_GSPCA=y
CONFIG_USB_M5602=y
# CONFIG_USB_STV06XX is not set
# CONFIG_USB_GL860 is not set
# CONFIG_USB_GSPCA_BENQ is not set
CONFIG_USB_GSPCA_CONEX=y
CONFIG_USB_GSPCA_CPIA1=y
CONFIG_USB_GSPCA_DTCS033=y
# CONFIG_USB_GSPCA_ETOMS is not set
CONFIG_USB_GSPCA_FINEPIX=y
CONFIG_USB_GSPCA_JEILINJ=y
CONFIG_USB_GSPCA_JL2005BCD=y
# CONFIG_USB_GSPCA_KINECT is not set
# CONFIG_USB_GSPCA_KONICA is not set
CONFIG_USB_GSPCA_MARS=y
CONFIG_USB_GSPCA_MR97310A=y
# CONFIG_USB_GSPCA_NW80X is not set
# CONFIG_USB_GSPCA_OV519 is not set
# CONFIG_USB_GSPCA_OV534 is not set
# CONFIG_USB_GSPCA_OV534_9 is not set
# CONFIG_USB_GSPCA_PAC207 is not set
CONFIG_USB_GSPCA_PAC7302=y
CONFIG_USB_GSPCA_PAC7311=y
# CONFIG_USB_GSPCA_SE401 is not set
# CONFIG_USB_GSPCA_SN9C2028 is not set
CONFIG_USB_GSPCA_SN9C20X=y
CONFIG_USB_GSPCA_SONIXB=y
# CONFIG_USB_GSPCA_SONIXJ is not set
CONFIG_USB_GSPCA_SPCA500=y
CONFIG_USB_GSPCA_SPCA501=y
CONFIG_USB_GSPCA_SPCA505=y
# CONFIG_USB_GSPCA_SPCA506 is not set
# CONFIG_USB_GSPCA_SPCA508 is not set
CONFIG_USB_GSPCA_SPCA561=y
CONFIG_USB_GSPCA_SPCA1528=y
CONFIG_USB_GSPCA_SQ905=y
CONFIG_USB_GSPCA_SQ905C=y
CONFIG_USB_GSPCA_SQ930X=y
CONFIG_USB_GSPCA_STK014=y
# CONFIG_USB_GSPCA_STK1135 is not set
# CONFIG_USB_GSPCA_STV0680 is not set
# CONFIG_USB_GSPCA_SUNPLUS is not set
CONFIG_USB_GSPCA_T613=y
CONFIG_USB_GSPCA_TOPRO=y
CONFIG_USB_GSPCA_TOUPTEK=y
# CONFIG_USB_GSPCA_TV8532 is not set
CONFIG_USB_GSPCA_VC032X=y
CONFIG_USB_GSPCA_VICAM=y
CONFIG_USB_GSPCA_XIRLINK_CIT=y
# CONFIG_USB_GSPCA_ZC3XX is not set
CONFIG_USB_PWC=y
# CONFIG_USB_PWC_DEBUG is not set
# CONFIG_USB_PWC_INPUT_EVDEV is not set
CONFIG_VIDEO_CPIA2=y
CONFIG_USB_ZR364XX=y
CONFIG_USB_STKWEBCAM=y
CONFIG_USB_S2255=y
CONFIG_VIDEO_USBTV=y

#
# Analog/digital TV USB devices
#
# CONFIG_VIDEO_AU0828 is not set
CONFIG_VIDEO_CX231XX=y
# CONFIG_VIDEO_CX231XX_ALSA is not set
CONFIG_VIDEO_CX231XX_DVB=y
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
# CONFIG_DVB_USB_DIB0700 is not set
# CONFIG_DVB_USB_UMT_010 is not set
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
# CONFIG_DVB_USB_DIGITV is not set
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
# CONFIG_DVB_USB_TTUSB2 is not set
# CONFIG_DVB_USB_DTT200U is not set
CONFIG_DVB_USB_OPERA1=m
# CONFIG_DVB_USB_AF9005 is not set
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
# CONFIG_DVB_USB_CINERGY_T2 is not set
CONFIG_DVB_USB_DTV5100=m
# CONFIG_DVB_USB_AZ6027 is not set
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
# CONFIG_DVB_USB_AZ6007 is not set
# CONFIG_DVB_USB_CE6230 is not set
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
# CONFIG_DVB_USB_RTL28XXU is not set
CONFIG_DVB_USB_DVBSKY=m
CONFIG_DVB_USB_ZD1301=m
# CONFIG_DVB_TTUSB_BUDGET is not set
CONFIG_DVB_TTUSB_DEC=y
CONFIG_SMS_USB_DRV=m
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
CONFIG_DVB_AS102=y

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=y
CONFIG_VIDEO_EM28XX_DVB=y

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set

#
# USB HDMI CEC adapters
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_VIDEO_CAFE_CCIC is not set
# CONFIG_VIDEO_CADENCE is not set
# CONFIG_VIDEO_ASPEED is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set
CONFIG_VIDEO_SH_VEU=y
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
# CONFIG_CEC_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_RADIO_ADAPTERS is not set

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_VS6624 is not set
CONFIG_VIDEO_MT9M111=y
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_RJ54N1 is not set

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
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
# CONFIG_MEDIA_TUNER_MT2063 is not set
# CONFIG_MEDIA_TUNER_MT2266 is not set
# CONFIG_MEDIA_TUNER_MT2131 is not set
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
# CONFIG_MEDIA_TUNER_FC0012 is not set
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC2580=y
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=y
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
# CONFIG_DVB_STV0910 is not set
CONFIG_DVB_STV6110x=y
# CONFIG_DVB_STV6111 is not set
# CONFIG_DVB_MXL5XX is not set
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_SI2165=y
# CONFIG_DVB_MN88472 is not set
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
# CONFIG_DVB_CX24123 is not set
CONFIG_DVB_MT312=y
# CONFIG_DVB_ZL10036 is not set
CONFIG_DVB_ZL10039=y
# CONFIG_DVB_S5H1420 is not set
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_STV0900=y
# CONFIG_DVB_TDA8083 is not set
CONFIG_DVB_TDA10086=y
# CONFIG_DVB_TDA8261 is not set
# CONFIG_DVB_VES1X93 is not set
# CONFIG_DVB_TUNER_ITD1000 is not set
# CONFIG_DVB_TUNER_CX24113 is not set
CONFIG_DVB_TDA826X=y
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_DS3000=y
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=y
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=y
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_TDA1004X=y
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_MT352=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=y
# CONFIG_DVB_DIB9000 is not set
# CONFIG_DVB_TDA10048 is not set
CONFIG_DVB_AF9013=y
CONFIG_DVB_EC100=y
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_CXD2820R=y
# CONFIG_DVB_CXD2841ER is not set
# CONFIG_DVB_RTL2830 is not set
# CONFIG_DVB_RTL2832 is not set
# CONFIG_DVB_RTL2832_SDR is not set
CONFIG_DVB_SI2168=y
CONFIG_DVB_AS102_FE=y
CONFIG_DVB_ZD1301_DEMOD=y
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_VES1820 is not set
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
# CONFIG_DVB_STV0297 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
# CONFIG_DVB_OR51211 is not set
# CONFIG_DVB_OR51132 is not set
# CONFIG_DVB_BCM3510 is not set
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LG2160=y
CONFIG_DVB_S5H1409=y
# CONFIG_DVB_AU8522_DTV is not set
# CONFIG_DVB_AU8522_V4L is not set
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
# CONFIG_DVB_DIB8000 is not set
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
# CONFIG_DVB_LNBH25 is not set
# CONFIG_DVB_LNBH29 is not set
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=y
# CONFIG_DVB_ISL6405 is not set
# CONFIG_DVB_ISL6421 is not set
CONFIG_DVB_ISL6423=y
CONFIG_DVB_A8293=y
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=y
CONFIG_DVB_ATBM8830=y
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_IX2505V=y
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_AF9033=y
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
# CONFIG_DVB_CXD2099 is not set
CONFIG_DVB_SP2=y

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Customise DVB Frontends

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set

#
# drm/i915 Debugging
#
CONFIG_DRM_I915_WERROR=y
CONFIG_DRM_I915_DEBUG=y
CONFIG_DRM_I915_DEBUG_MMIO=y
# CONFIG_DRM_I915_DEBUG_GEM is not set
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
CONFIG_DRM_I915_DEBUG_GUC=y
CONFIG_DRM_I915_SELFTEST=y
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=y
# CONFIG_DRM_GMA600 is not set
# CONFIG_DRM_GMA3600 is not set
CONFIG_DRM_UDL=y
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_CIRRUS_QEMU=y
# CONFIG_DRM_RCAR_DW_HDMI is not set
CONFIG_DRM_RCAR_LVDS=y
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_SIMPLE=y
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_ROCKTECH_JH057N00900 is not set
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
# CONFIG_DRM_PANEL_SONY_ACX424AKP is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_LVDS_CODEC is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
# CONFIG_DRM_PARADE_PS8640 is not set
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=y
# CONFIG_DRM_SII9234 is not set
# CONFIG_DRM_SIMPLE_BRIDGE is not set
CONFIG_DRM_THINE_THC63LVD1024=y
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=y
# CONFIG_DRM_TOSHIBA_TC358768 is not set
CONFIG_DRM_TI_TFP410=y
# CONFIG_DRM_TI_SN65DSI86 is not set
# CONFIG_DRM_TI_TPD12S015 is not set
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
# CONFIG_DRM_I2C_ADV7511 is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
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
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=y
CONFIG_FB_LE80578=y
# CONFIG_FB_CARILLO_RANCH is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
# CONFIG_FB_ATY_GX is not set
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=y
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=y
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_LP8788 is not set
CONFIG_BACKLIGHT_OT200=y
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_PROC_FS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_VIRMIDI=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_VX_LIB=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_VIRMIDI=y
# CONFIG_SND_MTPAV is not set
CONFIG_SND_MTS64=y
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y
CONFIG_SND_PORTMAN2X4=y
# CONFIG_SND_AC97_POWER_SAVE is not set
# CONFIG_SND_ISA is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=0
# CONFIG_SND_USB is not set
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=y
# CONFIG_SND_PDAUDIOCF is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_AMD_ACP=y
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=y
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=y
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_ATMEL_SOC=y
# CONFIG_SND_SOC_MIKROE_PROTO is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
CONFIG_SND_SOC_IMX_AUDMUX=y
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=y
CONFIG_SND_SOC_IMG_I2S_OUT=y
CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
# CONFIG_SND_SOC_IMG_SPDIF_IN is not set
CONFIG_SND_SOC_IMG_SPDIF_OUT=y
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_ZX_TDM=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU7002=y
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4118 is not set
CONFIG_SND_SOC_AK4458=y
CONFIG_SND_SOC_AK4554=y
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK5386=y
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
CONFIG_SND_SOC_CS35L32=y
# CONFIG_SND_SOC_CS35L33 is not set
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=y
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
# CONFIG_SND_SOC_CS42L52 is not set
CONFIG_SND_SOC_CS42L56=y
CONFIG_SND_SOC_CS42L73=y
CONFIG_SND_SOC_CS4265=y
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
CONFIG_SND_SOC_CS53L30=y
# CONFIG_SND_SOC_CX2072X is not set
# CONFIG_SND_SOC_DA7213 is not set
CONFIG_SND_SOC_DA7219=y
# CONFIG_SND_SOC_DMIC is not set
CONFIG_SND_SOC_HDMI_CODEC=y
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_GTM601=y
CONFIG_SND_SOC_INNO_RK3036=y
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98357A=y
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RT5616=y
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5645=y
# CONFIG_SND_SOC_SGTL5000 is not set
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
CONFIG_SND_SOC_SSM4567=y
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
CONFIG_SND_SOC_STI_SAS=y
CONFIG_SND_SOC_TAS2552=y
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
CONFIG_SND_SOC_TAS571X=y
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
# CONFIG_SND_SOC_TS3A227E is not set
CONFIG_SND_SOC_TSCS42XX=y
CONFIG_SND_SOC_TSCS454=y
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WCD9335 is not set
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8524=y
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
CONFIG_SND_SOC_WM8737=y
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8903=y
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
CONFIG_SND_SOC_WM8962=y
# CONFIG_SND_SOC_WM8974 is not set
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8985=y
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MT6351=y
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=y
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
CONFIG_HID_COUGAR=y
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CP2112=y
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELAN=y
CONFIG_HID_ELECOM=y
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=y
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_GOOGLE_HAMMER=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y
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
CONFIG_USB_ULPI_BUS=y
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
# CONFIG_USB_SL811_CS is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
CONFIG_USB_STORAGE_DATAFAB=y
# CONFIG_USB_STORAGE_FREECOM is not set
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=y

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
CONFIG_USB_MUSB_GADGET=y
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_ULPI is not set
CONFIG_USB_DWC3_HOST=y
# CONFIG_USB_DWC3_GADGET is not set
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
CONFIG_USB_DWC3_OF_SIMPLE=y
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
# CONFIG_USB_DWC2_DUAL_ROLE is not set
CONFIG_USB_DWC2_PCI=y
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=y
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=y
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FUSB300 is not set
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y

#
# Platform Support
#
CONFIG_USB_BDC_PCI=y
CONFIG_USB_AMD5536UDC=y
CONFIG_USB_NET2272=y
CONFIG_USB_NET2272_DMA=y
CONFIG_USB_NET2280=y
# CONFIG_USB_GOKU is not set
CONFIG_USB_EG20T=y
CONFIG_USB_GADGET_XILINX=y
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_U_AUDIO=y
CONFIG_USB_F_NCM=y
CONFIG_USB_F_ECM=y
CONFIG_USB_F_EEM=y
CONFIG_USB_F_RNDIS=y
CONFIG_USB_F_UAC1=y
CONFIG_USB_F_UVC=y
CONFIG_USB_F_TCM=y
CONFIG_USB_CONFIGFS=y
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
CONFIG_USB_CONFIGFS_NCM=y
CONFIG_USB_CONFIGFS_ECM=y
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
CONFIG_USB_CONFIGFS_RNDIS=y
CONFIG_USB_CONFIGFS_EEM=y
# CONFIG_USB_CONFIGFS_PHONET is not set
# CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
# CONFIG_USB_CONFIGFS_F_FS is not set
CONFIG_USB_CONFIGFS_F_UAC1=y
# CONFIG_USB_CONFIGFS_F_UAC1_LEGACY is not set
# CONFIG_USB_CONFIGFS_F_UAC2 is not set
# CONFIG_USB_CONFIGFS_F_MIDI is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
CONFIG_USB_CONFIGFS_F_UVC=y
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
CONFIG_USB_CONFIGFS_F_TCM=y

#
# USB Gadget precomposed configurations
#
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_MASS_STORAGE is not set
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_NOKIA is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
# CONFIG_UCSI_ACPI is not set
# CONFIG_TYPEC_HD3SS3220 is not set
CONFIG_TYPEC_TPS6598X=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=y
# CONFIG_TYPEC_NVIDIA_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_GOLDFISH is not set
# CONFIG_MMC_SDRICOH_CS is not set
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
# CONFIG_LEDS_AAT1290 is not set
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=y
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=y
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_ACCESSIBILITY is not set
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
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_HYM8563 is not set
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8998=y
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_RK808=y
CONFIG_RTC_DRV_RS5C372=y
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TWL4030=y
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS6586X=y
# CONFIG_RTC_DRV_TPS65910 is not set
CONFIG_RTC_DRV_RC5T583=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_ZYNQMP=y
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_CADENCE is not set
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_MC13XXX=y
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_SELFTESTS=y
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
CONFIG_UIO_MF624=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_VDPA is not set
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
# CONFIG_VDPA_MENU is not set
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST=y
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_SCSI=y
CONFIG_VHOST_VSOCK=y
# CONFIG_VHOST_VDPA is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set
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
# CONFIG_ADT7316 is not set
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
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# end of Android

# CONFIG_STAGING_BOARD is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GOLDFISH_AUDIO is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_KS7010 is not set

#
# Gasket devices
#
# end of Gasket devices

# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=y
# CONFIG_CROS_EC_RPMSG is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LIGHTBAR=y
CONFIG_CROS_EC_VBC=y
CONFIG_CROS_EC_DEBUGFS=y
CONFIG_CROS_EC_SENSORHUB=y
CONFIG_CROS_EC_SYSFS=y
CONFIG_CROS_EC_TYPEC=y
CONFIG_CROS_USBPD_LOGGER=y
CONFIG_CROS_USBPD_NOTIFY=y
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
CONFIG_CLK_HSDK=y
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_PALMAS is not set
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_VC5=y
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
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
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=y
# CONFIG_EXTCON_PALMAS is not set
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=y
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
# CONFIG_DMARD10 is not set
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
CONFIG_AD7291=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD799X=y
CONFIG_CC10001_ADC=y
CONFIG_DA9150_GPADC=y
CONFIG_DLN2_ADC=y
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HX711=y
CONFIG_LP8788_ADC=y
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
CONFIG_LTC2497=y
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=y
# CONFIG_PALMAS_GPADC is not set
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STMPE_ADC is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADS1015=y
CONFIG_TI_AM335X_ADC=y
# CONFIG_TWL4030_MADC is not set
CONFIG_TWL6030_GPADC=y
# CONFIG_VF610_ADC is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
CONFIG_VZ89X=y
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=y
# CONFIG_IIO_CROS_EC_SENSORS is not set
# CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
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
CONFIG_AD5380=y
# CONFIG_AD5446 is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5696_I2C is not set
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_M62332=y
CONFIG_MAX517=y
CONFIG_MAX5821=y
CONFIG_MCP4725=y
# CONFIG_TI_DAC5571 is not set
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=y
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
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
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
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
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_BH1750=y
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
CONFIG_CM3232=y
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
# CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
# CONFIG_HID_SENSOR_ALS is not set
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_MAG3110 is not set
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
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
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
CONFIG_HID_SENSOR_DEVICE_ROTATION=y
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
CONFIG_DS1803=y
# CONFIG_MAX5432 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=y
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
# CONFIG_IIO_CROS_EC_BARO is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=y
CONFIG_HP03=y
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=y
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_T5403=y
# CONFIG_HP206C is not set
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX9500=y
CONFIG_SRF08=y
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=y
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=y
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
CONFIG_PWM_STMPE=y
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_CPCAP_USB=y
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_SAMSUNG_USB2 is not set
# CONFIG_PHY_TUSB1210 is not set
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=y
# CONFIG_FSI_MASTER_ASPEED is not set
CONFIG_FSI_SCOM=y
# CONFIG_FSI_SBEFIFO is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=y
# CONFIG_OCFS2_FS_O2CB is not set
CONFIG_OCFS2_FS_STATS=y
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_ZONEFS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_HISTOGRAM=y
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
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
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_BLOCKDEV is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_842_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="842"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
CONFIG_UFS_DEBUG=y
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
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
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
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
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
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
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
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
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_CURVE25519 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
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
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

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
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_CRYPTO_DEV_GEODE=y
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_VIRTIO=y
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_CCREE=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
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
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
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
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
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
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
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
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
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
CONFIG_DYNAMIC_DEBUG=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
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
# CONFIG_UBSAN_TRAP is not set
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_MISC=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
CONFIG_UBSAN_NO_ALIGNMENT=y
# CONFIG_TEST_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_DEBUG_SLAB=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
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
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
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
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
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
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
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
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_MMIOTRACE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_MMIOTRACE_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_INTEL_MEI is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
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
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--=_5ec71528.0QLGqQ/3LEsf5mMcGcUd845ptqqZ30AbAEbHAutQsyKP7C/w
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.7.0-rc1-00058-g6fe12cdbcfe35"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.7.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=50500
CONFIG_LD_VERSION=234000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
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
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
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
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
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
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
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
# CONFIG_BOOT_CONFIG is not set
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
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
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
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_PROFILING=y
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
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
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
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
CONFIG_MEFFICEON=y
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
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_ANCIENT_MCE=y

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=y
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_16BIT is not set
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
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
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
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
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
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

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
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
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
CONFIG_PCI_GODIRECT=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_GEOS=y
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
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

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
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM_WERROR is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_4_7=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
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
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
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
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_IPVTI=y
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
CONFIG_IPV6_VTI=y
CONFIG_IPV6_SIT=m
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
# CONFIG_MPTCP_HMAC_TEST is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
# CONFIG_BRIDGE_NETFILTER is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NETFILTER_NETLINK_OSF is not set
CONFIG_NF_CONNTRACK=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
# CONFIG_NF_CONNTRACK_AMANDA is not set
# CONFIG_NF_CONNTRACK_FTP is not set
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_SNMP is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
# CONFIG_NF_CONNTRACK_SIP is not set
# CONFIG_NF_CONNTRACK_TFTP is not set
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_NAT=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_NUMGEN is not set
# CONFIG_NFT_CT is not set
CONFIG_NFT_FLOW_OFFLOAD=m
# CONFIG_NFT_COUNTER is not set
# CONFIG_NFT_CONNLIMIT is not set
# CONFIG_NFT_LOG is not set
# CONFIG_NFT_LIMIT is not set
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
# CONFIG_NFT_COMPAT is not set
# CONFIG_NFT_HASH is not set
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_DUP_NETDEV is not set
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=m

#
# Xtables combined modules
#
# CONFIG_NETFILTER_XT_MARK is not set
# CONFIG_NETFILTER_XT_CONNMARK is not set

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
# CONFIG_NETFILTER_XT_TARGET_LED is not set
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
# CONFIG_NETFILTER_XT_TARGET_MARK is not set
CONFIG_NETFILTER_XT_NAT=m
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
# CONFIG_NETFILTER_XT_TARGET_MASQUERADE is not set
# CONFIG_NETFILTER_XT_TARGET_TEE is not set
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_BPF is not set
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ECN is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
# CONFIG_NETFILTER_XT_MATCH_HL is not set
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_MAC is not set
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
# CONFIG_NETFILTER_XT_MATCH_STATE is not set
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TPROXY_IPV4 is not set
CONFIG_NF_TABLES_IPV4=y
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_FLOW_TABLE_IPV4=m
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_AH is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_FILTER is not set
# CONFIG_IP_NF_TARGET_SYNPROXY is not set
CONFIG_IP_NF_NAT=m
# CONFIG_IP_NF_TARGET_MASQUERADE is not set
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_SECURITY is not set
# CONFIG_IP_NF_ARPTABLES is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TPROXY_IPV6 is not set
CONFIG_NF_TABLES_IPV6=y
# CONFIG_NFT_DUP_IPV6 is not set
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_FLOW_TABLE_IPV6=m
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
CONFIG_IP6_NF_IPTABLES=m
# CONFIG_IP6_NF_MATCH_AH is not set
# CONFIG_IP6_NF_MATCH_EUI64 is not set
# CONFIG_IP6_NF_MATCH_FRAG is not set
# CONFIG_IP6_NF_MATCH_OPTS is not set
# CONFIG_IP6_NF_MATCH_HL is not set
# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
# CONFIG_IP6_NF_MATCH_MH is not set
# CONFIG_IP6_NF_MATCH_RT is not set
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_FILTER is not set
# CONFIG_IP6_NF_TARGET_SYNPROXY is not set
# CONFIG_IP6_NF_MANGLE is not set
# CONFIG_IP6_NF_RAW is not set
# CONFIG_IP6_NF_SECURITY is not set
CONFIG_IP6_NF_NAT=m
# CONFIG_IP6_NF_TARGET_MASQUERADE is not set
# CONFIG_IP6_NF_TARGET_NPT is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m

#
# DECnet: Netfilter Configuration
#
# CONFIG_DECNET_NF_GRABULATOR is not set
# end of DECnet: Netfilter Configuration

# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_LTPC=y
# CONFIG_COPS is not set
CONFIG_IPDDP=y
# CONFIG_IPDDP_ENCAP is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_ATM=y
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=y
CONFIG_NET_SCH_RED=y
# CONFIG_NET_SCH_SFB is not set
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_NETEM=y
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=y
# CONFIG_NET_SCH_CHOKE is not set
CONFIG_NET_SCH_QFQ=y
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=y
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
CONFIG_DEFAULT_CODEL=y
# CONFIG_DEFAULT_FQ_CODEL is not set
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=y
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=y
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_MCAST=y
CONFIG_BATMAN_ADV_DEBUGFS=y
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_BATMAN_ADV_SYSFS is not set
# CONFIG_BATMAN_ADV_TRACING is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=y
CONFIG_VSOCKETS_LOOPBACK=y
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
CONFIG_HSR=y
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
# CONFIG_CAN_SLCAN is not set
# CONFIG_CAN_DEV is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=y
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=y
# CONFIG_BT_RFCOMM_TTY is not set
# CONFIG_BT_BNEP is not set
# CONFIG_BT_HIDP is not set
# CONFIG_BT_HS is not set
# CONFIG_BT_LE is not set
# CONFIG_BT_LEDS is not set
CONFIG_BT_SELFTEST=y
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_HCIBTUSB=y
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
# CONFIG_BT_HCIBTUSB_BCM is not set
# CONFIG_BT_HCIBTUSB_MTK is not set
# CONFIG_BT_HCIBTUSB_RTL is not set
CONFIG_BT_HCIBTSDIO=y
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIDTL1=y
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
# CONFIG_BT_MRVL_SDIO is not set
CONFIG_BT_ATH3K=y
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
# CONFIG_NFC_NCI is not set
CONFIG_NFC_HCI=y
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_MEI_PHY=y
CONFIG_NFC_SIM=y
CONFIG_NFC_PORT100=y
CONFIG_NFC_PN544=y
CONFIG_NFC_PN544_MEI=y
CONFIG_NFC_PN533=y
# CONFIG_NFC_PN533_USB is not set
CONFIG_NFC_PN533_I2C=y
# CONFIG_NFC_MICROREAD_MEI is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
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
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
# CONFIG_PCIEAER is not set
# CONFIG_PCIEASPM is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
CONFIG_PCIE_XILINX=y

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
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
CONFIG_PCI_EPF_TEST=y
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
# CONFIG_YENTA_O2 is not set
# CONFIG_YENTA_RICOH is not set
# CONFIG_YENTA_TI is not set
CONFIG_YENTA_TOSHIBA=y
# CONFIG_PD6729 is not set
CONFIG_I82092=y
# CONFIG_I82365 is not set
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_TSI568=y
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
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
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
# CONFIG_ZRAM_WRITEBACK is not set
CONFIG_ZRAM_MEMORY_TRACKING=y
CONFIG_BLK_DEV_UMEM=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_SX8=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=y

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_CS5535_MFGPT=y
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
# CONFIG_CS5535_CLOCK_EVENT_SRC is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.rst for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_IDE_LEGACY=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
# CONFIG_IDE_GD_ATAPI is not set
CONFIG_BLK_DEV_IDECS=y
CONFIG_BLK_DEV_DELKIN=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS is not set
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
CONFIG_BLK_DEV_PLATFORM=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
CONFIG_BLK_DEV_CS5520=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_CS5535=y
# CONFIG_BLK_DEV_CS5536 is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_JMICRON=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IT8172=y
CONFIG_BLK_DEV_IT8213=y
CONFIG_BLK_DEV_IT821X=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_BLK_DEV_TC86C001 is not set

#
# Other IDE chipsets support
#

#
# Note: most of these also require special kernel boot parameters
#
CONFIG_BLK_DEV_4DRIVES=y
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
CONFIG_BLK_DEV_HT6560B=y
CONFIG_BLK_DEV_QD65XX=y
CONFIG_BLK_DEV_UMC8672=y
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
# CONFIG_SCSI_DH_HP_SW is not set
# CONFIG_SCSI_DH_EMC is not set
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=y
CONFIG_TCM_USER2=y
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
CONFIG_SBP_TARGET=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
# CONFIG_CAIF_DRIVERS is not set

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
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
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
# CONFIG_USB_HSO is not set
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
CONFIG_NETDEVSIM=m
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
CONFIG_NVM_PBLK=y
CONFIG_NVM_PBLK_DEBUG=y

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
CONFIG_KEYBOARD_ADP5588=y
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
CONFIG_KEYBOARD_QT1070=y
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
# CONFIG_KEYBOARD_MCS is not set
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
# CONFIG_KEYBOARD_OPENCORES is not set
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
CONFIG_KEYBOARD_OMAP4=y
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_TWL4030=y
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
CONFIG_MOUSE_PS2_BYD=y
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
# CONFIG_MOUSE_PS2_CYPRESS is not set
# CONFIG_MOUSE_PS2_LIFEBOOK is not set
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_SERIAL=y
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=y
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
CONFIG_MOUSE_SYNAPTICS_USB=y
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
CONFIG_INPUT_ATMEL_CAPTOUCH=y
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GP2A=y
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_WISTRON_BTNS=y
# CONFIG_INPUT_ATLAS_BTNS is not set
CONFIG_INPUT_ATI_REMOTE2=y
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_TPS65218_PWRBUTTON=y
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_VIBRA=y
CONFIG_INPUT_TWL6040_VIBRA=y
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_PWM_BEEPER=y
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_RK805_PWRKEY is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA9052_ONKEY is not set
# CONFIG_INPUT_DA9063_ONKEY is not set
# CONFIG_INPUT_WM831X_ON is not set
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
# CONFIG_INPUT_IMS_PCU is not set
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=y
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
# CONFIG_RMI4_F30 is not set
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
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
# CONFIG_SERIAL_8250_CS is not set
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
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
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
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_GEODE=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_DTLK=y
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=y

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=y
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
# CONFIG_RAW_DRIVER is not set
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
# end of Character devices

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
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EG20T=y
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
CONFIG_I2C_RK3X=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=y
# CONFIG_I2C_PCA_ISA is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_SCx200_ACB=y
CONFIG_I2C_FSI=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

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
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_DA9062 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_STMFX is not set
# CONFIG_PINCTRL_MAX77620 is not set
# CONFIG_PINCTRL_PALMAS is not set
CONFIG_PINCTRL_RK805=y
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
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L90=y
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_CS5535=y
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DLN2 is not set
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_LP87565=y
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77620=y
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_STMPE=y
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM831X=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9052 is not set
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_88PM860X=y
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=y
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=y
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CPU_THERMAL is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_MAX77620_THERMAL is not set
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_DA9062_THERMAL is not set

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

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=y
CONFIG_GPIO_WATCHDOG_ARCH_INITCALL=y
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
# CONFIG_TWL4030_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
CONFIG_SP5100_TCO=y
CONFIG_GEODE_WDT=y
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=y
# CONFIG_ITCO_VENDOR_SUPPORT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_KEMPLD_WDT is not set
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
# CONFIG_SBC7240_WDT is not set
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
CONFIG_MIXCOMWD=y
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC_DEV=y
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
# CONFIG_MFD_CS47L15 is not set
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SMSC=y
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_LOCHNAGAR is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=y
# CONFIG_MFD_ROHM_BD70528 is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
# CONFIG_MFD_WCD934X is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ARIZONA_LDO1 is not set
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_ROHM=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TWL4030 is not set
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=y
CONFIG_CEC_CORE=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=m
# CONFIG_IR_RC6_DECODER is not set
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
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
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_PCI_SKELETON=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_VMALLOC=y
CONFIG_DVB_CORE=y
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=y
# CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV is not set
CONFIG_USB_GSPCA=y
CONFIG_USB_M5602=y
# CONFIG_USB_STV06XX is not set
# CONFIG_USB_GL860 is not set
# CONFIG_USB_GSPCA_BENQ is not set
CONFIG_USB_GSPCA_CONEX=y
CONFIG_USB_GSPCA_CPIA1=y
CONFIG_USB_GSPCA_DTCS033=y
# CONFIG_USB_GSPCA_ETOMS is not set
CONFIG_USB_GSPCA_FINEPIX=y
CONFIG_USB_GSPCA_JEILINJ=y
CONFIG_USB_GSPCA_JL2005BCD=y
# CONFIG_USB_GSPCA_KINECT is not set
# CONFIG_USB_GSPCA_KONICA is not set
CONFIG_USB_GSPCA_MARS=y
CONFIG_USB_GSPCA_MR97310A=y
# CONFIG_USB_GSPCA_NW80X is not set
# CONFIG_USB_GSPCA_OV519 is not set
# CONFIG_USB_GSPCA_OV534 is not set
# CONFIG_USB_GSPCA_OV534_9 is not set
# CONFIG_USB_GSPCA_PAC207 is not set
CONFIG_USB_GSPCA_PAC7302=y
CONFIG_USB_GSPCA_PAC7311=y
# CONFIG_USB_GSPCA_SE401 is not set
# CONFIG_USB_GSPCA_SN9C2028 is not set
CONFIG_USB_GSPCA_SN9C20X=y
CONFIG_USB_GSPCA_SONIXB=y
# CONFIG_USB_GSPCA_SONIXJ is not set
CONFIG_USB_GSPCA_SPCA500=y
CONFIG_USB_GSPCA_SPCA501=y
CONFIG_USB_GSPCA_SPCA505=y
# CONFIG_USB_GSPCA_SPCA506 is not set
# CONFIG_USB_GSPCA_SPCA508 is not set
CONFIG_USB_GSPCA_SPCA561=y
CONFIG_USB_GSPCA_SPCA1528=y
CONFIG_USB_GSPCA_SQ905=y
CONFIG_USB_GSPCA_SQ905C=y
CONFIG_USB_GSPCA_SQ930X=y
CONFIG_USB_GSPCA_STK014=y
# CONFIG_USB_GSPCA_STK1135 is not set
# CONFIG_USB_GSPCA_STV0680 is not set
# CONFIG_USB_GSPCA_SUNPLUS is not set
CONFIG_USB_GSPCA_T613=y
CONFIG_USB_GSPCA_TOPRO=y
CONFIG_USB_GSPCA_TOUPTEK=y
# CONFIG_USB_GSPCA_TV8532 is not set
CONFIG_USB_GSPCA_VC032X=y
CONFIG_USB_GSPCA_VICAM=y
CONFIG_USB_GSPCA_XIRLINK_CIT=y
# CONFIG_USB_GSPCA_ZC3XX is not set
CONFIG_USB_PWC=y
# CONFIG_USB_PWC_DEBUG is not set
# CONFIG_USB_PWC_INPUT_EVDEV is not set
CONFIG_VIDEO_CPIA2=y
CONFIG_USB_ZR364XX=y
CONFIG_USB_STKWEBCAM=y
CONFIG_USB_S2255=y
CONFIG_VIDEO_USBTV=y

#
# Analog/digital TV USB devices
#
# CONFIG_VIDEO_AU0828 is not set
CONFIG_VIDEO_CX231XX=y
# CONFIG_VIDEO_CX231XX_ALSA is not set
CONFIG_VIDEO_CX231XX_DVB=y
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
# CONFIG_DVB_USB_DIB0700 is not set
# CONFIG_DVB_USB_UMT_010 is not set
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
# CONFIG_DVB_USB_DIGITV is not set
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
# CONFIG_DVB_USB_TTUSB2 is not set
# CONFIG_DVB_USB_DTT200U is not set
CONFIG_DVB_USB_OPERA1=m
# CONFIG_DVB_USB_AF9005 is not set
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
# CONFIG_DVB_USB_CINERGY_T2 is not set
CONFIG_DVB_USB_DTV5100=m
# CONFIG_DVB_USB_AZ6027 is not set
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
# CONFIG_DVB_USB_AZ6007 is not set
# CONFIG_DVB_USB_CE6230 is not set
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
# CONFIG_DVB_USB_RTL28XXU is not set
CONFIG_DVB_USB_DVBSKY=m
CONFIG_DVB_USB_ZD1301=m
# CONFIG_DVB_TTUSB_BUDGET is not set
CONFIG_DVB_TTUSB_DEC=y
CONFIG_SMS_USB_DRV=m
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
CONFIG_DVB_AS102=y

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=y
CONFIG_VIDEO_EM28XX_DVB=y

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set

#
# USB HDMI CEC adapters
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_VIDEO_CAFE_CCIC is not set
# CONFIG_VIDEO_CADENCE is not set
# CONFIG_VIDEO_ASPEED is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set
CONFIG_VIDEO_SH_VEU=y
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
# CONFIG_CEC_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_RADIO_ADAPTERS is not set

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_VS6624 is not set
CONFIG_VIDEO_MT9M111=y
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_RJ54N1 is not set

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
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
# CONFIG_MEDIA_TUNER_MT2063 is not set
# CONFIG_MEDIA_TUNER_MT2266 is not set
# CONFIG_MEDIA_TUNER_MT2131 is not set
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
# CONFIG_MEDIA_TUNER_FC0012 is not set
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC2580=y
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=y
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
# CONFIG_DVB_STV0910 is not set
CONFIG_DVB_STV6110x=y
# CONFIG_DVB_STV6111 is not set
# CONFIG_DVB_MXL5XX is not set
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_SI2165=y
# CONFIG_DVB_MN88472 is not set
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
# CONFIG_DVB_CX24123 is not set
CONFIG_DVB_MT312=y
# CONFIG_DVB_ZL10036 is not set
CONFIG_DVB_ZL10039=y
# CONFIG_DVB_S5H1420 is not set
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_STV0900=y
# CONFIG_DVB_TDA8083 is not set
CONFIG_DVB_TDA10086=y
# CONFIG_DVB_TDA8261 is not set
# CONFIG_DVB_VES1X93 is not set
# CONFIG_DVB_TUNER_ITD1000 is not set
# CONFIG_DVB_TUNER_CX24113 is not set
CONFIG_DVB_TDA826X=y
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_DS3000=y
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=y
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=y
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_TDA1004X=y
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_MT352=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=y
# CONFIG_DVB_DIB9000 is not set
# CONFIG_DVB_TDA10048 is not set
CONFIG_DVB_AF9013=y
CONFIG_DVB_EC100=y
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_CXD2820R=y
# CONFIG_DVB_CXD2841ER is not set
# CONFIG_DVB_RTL2830 is not set
# CONFIG_DVB_RTL2832 is not set
# CONFIG_DVB_RTL2832_SDR is not set
CONFIG_DVB_SI2168=y
CONFIG_DVB_AS102_FE=y
CONFIG_DVB_ZD1301_DEMOD=y
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_VES1820 is not set
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
# CONFIG_DVB_STV0297 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
# CONFIG_DVB_OR51211 is not set
# CONFIG_DVB_OR51132 is not set
# CONFIG_DVB_BCM3510 is not set
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LG2160=y
CONFIG_DVB_S5H1409=y
# CONFIG_DVB_AU8522_DTV is not set
# CONFIG_DVB_AU8522_V4L is not set
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
# CONFIG_DVB_DIB8000 is not set
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
# CONFIG_DVB_LNBH25 is not set
# CONFIG_DVB_LNBH29 is not set
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=y
# CONFIG_DVB_ISL6405 is not set
# CONFIG_DVB_ISL6421 is not set
CONFIG_DVB_ISL6423=y
CONFIG_DVB_A8293=y
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=y
CONFIG_DVB_ATBM8830=y
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_IX2505V=y
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_AF9033=y
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
# CONFIG_DVB_CXD2099 is not set
CONFIG_DVB_SP2=y

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Customise DVB Frontends

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set

#
# drm/i915 Debugging
#
CONFIG_DRM_I915_WERROR=y
CONFIG_DRM_I915_DEBUG=y
CONFIG_DRM_I915_DEBUG_MMIO=y
# CONFIG_DRM_I915_DEBUG_GEM is not set
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
CONFIG_DRM_I915_DEBUG_GUC=y
CONFIG_DRM_I915_SELFTEST=y
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=y
# CONFIG_DRM_GMA600 is not set
# CONFIG_DRM_GMA3600 is not set
CONFIG_DRM_UDL=y
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_CIRRUS_QEMU=y
# CONFIG_DRM_RCAR_DW_HDMI is not set
CONFIG_DRM_RCAR_LVDS=y
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_SIMPLE=y
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_ROCKTECH_JH057N00900 is not set
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
# CONFIG_DRM_PANEL_SONY_ACX424AKP is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_LVDS_CODEC is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
# CONFIG_DRM_PARADE_PS8640 is not set
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=y
# CONFIG_DRM_SII9234 is not set
# CONFIG_DRM_SIMPLE_BRIDGE is not set
CONFIG_DRM_THINE_THC63LVD1024=y
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=y
# CONFIG_DRM_TOSHIBA_TC358768 is not set
CONFIG_DRM_TI_TFP410=y
# CONFIG_DRM_TI_SN65DSI86 is not set
# CONFIG_DRM_TI_TPD12S015 is not set
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
# CONFIG_DRM_I2C_ADV7511 is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
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
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=y
CONFIG_FB_LE80578=y
# CONFIG_FB_CARILLO_RANCH is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
# CONFIG_FB_ATY_GX is not set
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=y
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=y
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_LP8788 is not set
CONFIG_BACKLIGHT_OT200=y
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_PROC_FS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_VIRMIDI=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_VX_LIB=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_VIRMIDI=y
# CONFIG_SND_MTPAV is not set
CONFIG_SND_MTS64=y
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y
CONFIG_SND_PORTMAN2X4=y
# CONFIG_SND_AC97_POWER_SAVE is not set
# CONFIG_SND_ISA is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=0
# CONFIG_SND_USB is not set
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=y
# CONFIG_SND_PDAUDIOCF is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_AMD_ACP=y
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=y
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=y
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_ATMEL_SOC=y
# CONFIG_SND_SOC_MIKROE_PROTO is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
CONFIG_SND_SOC_IMX_AUDMUX=y
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=y
CONFIG_SND_SOC_IMG_I2S_OUT=y
CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
# CONFIG_SND_SOC_IMG_SPDIF_IN is not set
CONFIG_SND_SOC_IMG_SPDIF_OUT=y
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_ZX_TDM=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU7002=y
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4118 is not set
CONFIG_SND_SOC_AK4458=y
CONFIG_SND_SOC_AK4554=y
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK5386=y
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
CONFIG_SND_SOC_CS35L32=y
# CONFIG_SND_SOC_CS35L33 is not set
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=y
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
# CONFIG_SND_SOC_CS42L52 is not set
CONFIG_SND_SOC_CS42L56=y
CONFIG_SND_SOC_CS42L73=y
CONFIG_SND_SOC_CS4265=y
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
CONFIG_SND_SOC_CS53L30=y
# CONFIG_SND_SOC_CX2072X is not set
# CONFIG_SND_SOC_DA7213 is not set
CONFIG_SND_SOC_DA7219=y
# CONFIG_SND_SOC_DMIC is not set
CONFIG_SND_SOC_HDMI_CODEC=y
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_GTM601=y
CONFIG_SND_SOC_INNO_RK3036=y
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98357A=y
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RT5616=y
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5645=y
# CONFIG_SND_SOC_SGTL5000 is not set
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
CONFIG_SND_SOC_SSM4567=y
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
CONFIG_SND_SOC_STI_SAS=y
CONFIG_SND_SOC_TAS2552=y
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
CONFIG_SND_SOC_TAS571X=y
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
# CONFIG_SND_SOC_TS3A227E is not set
CONFIG_SND_SOC_TSCS42XX=y
CONFIG_SND_SOC_TSCS454=y
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WCD9335 is not set
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8524=y
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
CONFIG_SND_SOC_WM8737=y
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8903=y
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
CONFIG_SND_SOC_WM8962=y
# CONFIG_SND_SOC_WM8974 is not set
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8985=y
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MT6351=y
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=y
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
CONFIG_HID_COUGAR=y
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CP2112=y
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELAN=y
CONFIG_HID_ELECOM=y
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=y
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_GOOGLE_HAMMER=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y
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
CONFIG_USB_ULPI_BUS=y
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
# CONFIG_USB_SL811_CS is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
CONFIG_USB_STORAGE_DATAFAB=y
# CONFIG_USB_STORAGE_FREECOM is not set
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=y

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
CONFIG_USB_MUSB_GADGET=y
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_ULPI is not set
CONFIG_USB_DWC3_HOST=y
# CONFIG_USB_DWC3_GADGET is not set
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
CONFIG_USB_DWC3_OF_SIMPLE=y
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
# CONFIG_USB_DWC2_DUAL_ROLE is not set
CONFIG_USB_DWC2_PCI=y
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=y
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=y
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FUSB300 is not set
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y

#
# Platform Support
#
CONFIG_USB_BDC_PCI=y
CONFIG_USB_AMD5536UDC=y
CONFIG_USB_NET2272=y
CONFIG_USB_NET2272_DMA=y
CONFIG_USB_NET2280=y
# CONFIG_USB_GOKU is not set
CONFIG_USB_EG20T=y
CONFIG_USB_GADGET_XILINX=y
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_U_AUDIO=y
CONFIG_USB_F_NCM=y
CONFIG_USB_F_ECM=y
CONFIG_USB_F_EEM=y
CONFIG_USB_F_RNDIS=y
CONFIG_USB_F_UAC1=y
CONFIG_USB_F_UVC=y
CONFIG_USB_F_TCM=y
CONFIG_USB_CONFIGFS=y
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
CONFIG_USB_CONFIGFS_NCM=y
CONFIG_USB_CONFIGFS_ECM=y
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
CONFIG_USB_CONFIGFS_RNDIS=y
CONFIG_USB_CONFIGFS_EEM=y
# CONFIG_USB_CONFIGFS_PHONET is not set
# CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
# CONFIG_USB_CONFIGFS_F_FS is not set
CONFIG_USB_CONFIGFS_F_UAC1=y
# CONFIG_USB_CONFIGFS_F_UAC1_LEGACY is not set
# CONFIG_USB_CONFIGFS_F_UAC2 is not set
# CONFIG_USB_CONFIGFS_F_MIDI is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
CONFIG_USB_CONFIGFS_F_UVC=y
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
CONFIG_USB_CONFIGFS_F_TCM=y

#
# USB Gadget precomposed configurations
#
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_MASS_STORAGE is not set
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_NOKIA is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
# CONFIG_UCSI_ACPI is not set
# CONFIG_TYPEC_HD3SS3220 is not set
CONFIG_TYPEC_TPS6598X=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=y
# CONFIG_TYPEC_NVIDIA_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_GOLDFISH is not set
# CONFIG_MMC_SDRICOH_CS is not set
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
# CONFIG_LEDS_AAT1290 is not set
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=y
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=y
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_ACCESSIBILITY is not set
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
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_HYM8563 is not set
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8998=y
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_RK808=y
CONFIG_RTC_DRV_RS5C372=y
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TWL4030=y
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS6586X=y
# CONFIG_RTC_DRV_TPS65910 is not set
CONFIG_RTC_DRV_RC5T583=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_ZYNQMP=y
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_CADENCE is not set
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_MC13XXX=y
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_SELFTESTS=y
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
CONFIG_UIO_MF624=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_VDPA is not set
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
# CONFIG_VDPA_MENU is not set
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST=y
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_SCSI=y
CONFIG_VHOST_VSOCK=y
# CONFIG_VHOST_VDPA is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set
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
# CONFIG_ADT7316 is not set
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
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# end of Android

# CONFIG_STAGING_BOARD is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GOLDFISH_AUDIO is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_KS7010 is not set

#
# Gasket devices
#
# end of Gasket devices

# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=y
# CONFIG_CROS_EC_RPMSG is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LIGHTBAR=y
CONFIG_CROS_EC_VBC=y
CONFIG_CROS_EC_DEBUGFS=y
CONFIG_CROS_EC_SENSORHUB=y
CONFIG_CROS_EC_SYSFS=y
CONFIG_CROS_EC_TYPEC=y
CONFIG_CROS_USBPD_LOGGER=y
CONFIG_CROS_USBPD_NOTIFY=y
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
CONFIG_CLK_HSDK=y
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_PALMAS is not set
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_VC5=y
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
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
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=y
# CONFIG_EXTCON_PALMAS is not set
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=y
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
# CONFIG_DMARD10 is not set
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
CONFIG_AD7291=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD799X=y
CONFIG_CC10001_ADC=y
CONFIG_DA9150_GPADC=y
CONFIG_DLN2_ADC=y
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HX711=y
CONFIG_LP8788_ADC=y
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
CONFIG_LTC2497=y
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=y
# CONFIG_PALMAS_GPADC is not set
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STMPE_ADC is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADS1015=y
CONFIG_TI_AM335X_ADC=y
# CONFIG_TWL4030_MADC is not set
CONFIG_TWL6030_GPADC=y
# CONFIG_VF610_ADC is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
CONFIG_VZ89X=y
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=y
# CONFIG_IIO_CROS_EC_SENSORS is not set
# CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
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
CONFIG_AD5380=y
# CONFIG_AD5446 is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5696_I2C is not set
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_M62332=y
CONFIG_MAX517=y
CONFIG_MAX5821=y
CONFIG_MCP4725=y
# CONFIG_TI_DAC5571 is not set
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=y
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
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
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
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
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_BH1750=y
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
CONFIG_CM3232=y
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
# CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
# CONFIG_HID_SENSOR_ALS is not set
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_MAG3110 is not set
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
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
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
CONFIG_HID_SENSOR_DEVICE_ROTATION=y
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
CONFIG_DS1803=y
# CONFIG_MAX5432 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=y
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
# CONFIG_IIO_CROS_EC_BARO is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=y
CONFIG_HP03=y
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=y
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_T5403=y
# CONFIG_HP206C is not set
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX9500=y
CONFIG_SRF08=y
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=y
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=y
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
CONFIG_PWM_STMPE=y
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_CPCAP_USB=y
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_SAMSUNG_USB2 is not set
# CONFIG_PHY_TUSB1210 is not set
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=y
# CONFIG_FSI_MASTER_ASPEED is not set
CONFIG_FSI_SCOM=y
# CONFIG_FSI_SBEFIFO is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=y
# CONFIG_OCFS2_FS_O2CB is not set
CONFIG_OCFS2_FS_STATS=y
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_ZONEFS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_HISTOGRAM=y
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
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
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_BLOCKDEV is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_842_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="842"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
CONFIG_UFS_DEBUG=y
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
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
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
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
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
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
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
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
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_CURVE25519 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
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
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

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
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_CRYPTO_DEV_GEODE=y
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_VIRTIO=y
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_CCREE=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
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
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
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
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
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
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
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
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
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
CONFIG_DYNAMIC_DEBUG=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
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
# CONFIG_UBSAN_TRAP is not set
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_MISC=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
CONFIG_UBSAN_NO_ALIGNMENT=y
# CONFIG_TEST_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_DEBUG_SLAB=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
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
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
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
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
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
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
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
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_MMIOTRACE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_MMIOTRACE_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_INTEL_MEI is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
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
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--=_5ec71528.0QLGqQ/3LEsf5mMcGcUd845ptqqZ30AbAEbHAutQsyKP7C/w--
