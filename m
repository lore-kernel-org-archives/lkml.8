Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B81FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731622075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgFEKmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:42:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:3700 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgFEKmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:42:37 -0400
IronPort-SDR: e+Vlmxv0XW2Oa1NxrQTAAd8zO9ShXIDAbf2yTs4X+LSfrIEydNIylIvOZwFb6IzIyXJ+ZGvxWB
 tgzc5tjA8mcw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 03:40:46 -0700
IronPort-SDR: iLAjJ+EkP4ZuPn6boZoHANTUoEC48XI1sCa8u4mBM6c6KxvElOepDNDdw+dE+0OrEABdSC0zNW
 KtR2Iy+us0FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="xz'?gz'50?scan'50,208,50";a="471874665"
Received: from lkp-server02.sh.intel.com (HELO 85fa322b0eb2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2020 03:40:42 -0700
Received: from kbuild by 85fa322b0eb2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jh9mD-0000Ch-Ca; Fri, 05 Jun 2020 10:40:41 +0000
Date:   Fri, 05 Jun 2020 18:40:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gene, Chen," <gene.chen.richtek@gmail.com>
Cc:     LKP <lkp@lists.01.org>, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gene Chen <gene_chen@richtek.com>,
        "Lee, Jones," <lee.jones@linaro.org>, philip.li@intel.com
Subject: 7edd363421 ("mfd: Add support for PMIC MT6360"):  BUG: kernel
 NULL pointer dereference, address: 00000000
Message-ID: <5eda2124.3xzBeaq3PNfXClV8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5eda2124.AZGb1fsN7ZFKHaZB+nA/MJZYYg+lOOljWryhX08UQ8d78B9u"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5eda2124.AZGb1fsN7ZFKHaZB+nA/MJZYYg+lOOljWryhX08UQ8d78B9u
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 7edd363421dab1d4806802ac65613d1c0ec85824
Author:     Gene Chen <gene.chen.richtek@gmail.com>
AuthorDate: Thu Apr 23 19:24:52 2020 +0800
Commit:     Lee Jones <lee.jones@linaro.org>
CommitDate: Wed May 27 07:46:18 2020 +0100

    mfd: Add support for PMIC MT6360
    
    Add MFD driver for mt6360 pmic chip include Battery Charger/
    USB_PD/Flash, LED/RGB and LED/LDO/Buck
    
    Signed-off-by: Gene Chen <gene_chen@richtek.com>
    Signed-off-by: Lee Jones <lee.jones@linaro.org>

12e5bf757a  mfd: max77620: Use single-byte writes on MAX77620
7edd363421  mfd: Add support for PMIC MT6360
435faf5c21  Merge tag 'riscv-for-linus-5.8-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
+---------------------------------------------+------------+------------+------------+
|                                             | 12e5bf757a | 7edd363421 | 435faf5c21 |
+---------------------------------------------+------------+------------+------------+
| boot_successes                              | 29         | 0          | 0          |
| boot_failures                               | 1          | 15         | 10         |
| BUG:kernel_hang_in_boot_stage               | 1          |            |            |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 15         | 10         |
| Oops:#[##]                                  | 0          | 15         | 10         |
| EIP:strcmp                                  | 0          | 15         | 10         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 15         | 10         |
+---------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[  121.091622] Phantom Linux Driver, version n0.9.8, init OK
[  121.113939] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
[  121.146046] Guest personality initialized and is inactive
[  121.169091] VMCI host device registered (name=vmci, major=10, minor=60)
[  121.188032] Initialized host personality
[  121.241021] BUG: kernel NULL pointer dereference, address: 00000000
[  121.243012] #PF: supervisor read access in kernel mode
[  121.243012] #PF: error_code(0x0000) - not-present page
[  121.243012] *pdpt = 0000000000000000 *pde = f000ff53f000ff53 
[  121.243012] Oops: 0000 [#1] DEBUG_PAGEALLOC
[  121.243012] CPU: 0 PID: 1 Comm: swapper Not tainted 5.7.0-rc1-00052-g7edd363421dab #1
[  121.243012] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  121.243012] EIP: strcmp+0x11/0x30
[  121.243012] Code: fa 8b 75 f8 89 c8 8b 7d fc 89 ec 5d c3 8d b4 26 00 00 00 00 8d 74 26 00 90 55 89 e5 83 ec 08 89 75 f8 89 c6 89 7d fc 89 d7 ac <ae> 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 8b 75 f8 8b 7d fc 89
[  121.243012] EAX: c2a8bc64 EBX: 00000000 ECX: 00000000 EDX: 00000000
[  121.243012] ESI: c2a8bc79 EDI: 00000000 EBP: e54bdea8 ESP: e54bdea0
[  121.243012] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
[  121.243012] CR0: 80050033 CR2: 00000000 CR3: 02ec3000 CR4: 000006b0
[  121.243012] Call Trace:
[  121.243012]  kset_find_obj+0x3d/0xc0
[  121.243012]  driver_find+0x16/0x40
[  121.243012]  driver_register+0x49/0x100
[  121.243012]  ? i2c_for_each_dev+0x39/0x50
[  121.243012]  ? __process_new_adapter+0x20/0x20
[  121.243012]  ? cht_wc_driver_init+0x11/0x11
[  121.243012]  i2c_register_driver+0x30/0x80
[  121.243012]  ? intel_lpss_pci_driver_init+0x16/0x16
[  121.243012]  mt6360_pmu_driver_init+0xf/0x11
[  121.243012]  do_one_initcall+0x33/0x1a0
[  121.243012]  ? parse_args+0x1eb/0x3d0
[  121.243012]  ? __might_sleep+0x31/0x90
[  121.243012]  ? kernel_init_freeable+0x10a/0x17f
[  121.243012]  kernel_init_freeable+0x12c/0x17f
[  121.243012]  ? rest_init+0x110/0x110
[  121.243012]  kernel_init+0xb/0x100
[  121.243012]  ? schedule_tail_wrapper+0x9/0xc
[  121.243012]  ret_from_fork+0x19/0x24
[  121.243012] Modules linked in:
[  121.243012] CR2: 0000000000000000
[  121.243012] random: get_random_bytes called from init_oops_id+0x3a/0x40 with crng_init=0
[  121.243012] ---[ end trace 38a803400f1a2bee ]---
[  121.243012] EIP: strcmp+0x11/0x30

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start e7b08814b16b80a0bf76eeca16317f8c2ed23b8c v5.6 --
git bisect good 0e698dfa282211e414076f9dc7e83c1c288314fd  # 10:46  G     10     0    0   0  Linux 5.7-rc4
git bisect good e6dffbf84da606cdb0a9bbaf5578cd2f7f792e05  # 11:36  G     10     0    0   0  Merge remote-tracking branch 'omap/for-next'
git bisect good 2a74742ab11f42d8f855b00f88b3ed269c68040b  # 12:11  G     10     0    0   0  Merge remote-tracking branch 'sound-asoc/for-next'
git bisect  bad 259921c0dc98a30df65d25d91f2f5c95567d12c9  # 12:37  B      0     1   17   0  Merge remote-tracking branch 'driver-core/driver-core-next'
git bisect  bad d9baaa8ac86327a7a913f79db4b7342d0fa09c91  # 12:56  B      0     1   17   0  Merge remote-tracking branch 'iommu/next'
git bisect  bad aacbf7c5e5f087e216d3c8772ef36ef46d873876  # 13:14  B      0     1   17   0  Merge remote-tracking branch 'regulator/for-next'
git bisect good f7793e0aaba983940644b9610e8a04d2c417b797  # 13:49  G     10     0    0   0  Merge remote-tracking branch 'pcmcia/pcmcia-next'
git bisect  bad 5ba24b008cb7900cfe07e3bf27ff854e4cf520cc  # 14:51  B      0     4   22   0  Merge remote-tracking branch 'mfd/for-mfd-next'
git bisect good ae683dc18d5e3febf0a0346f56a641351a95dc48  # 15:29  G     10     0    1   1  Merge remote-tracking branch 'mmc/next'
git bisect good 2f72d35ea75ee8bf8c9e63fb43d43d5bfb4ac8fd  # 15:49  G     10     0    0   0  MAINTAINERS: Update entry for Intel Broxton PMC driver
git bisect good ff8bd0b59cfdabb9bc4c0941724fafaf9a508c07  # 16:08  G     10     0    0   0  mfd: tqmx86: Fix a typo in MODULE_DESCRIPTION
git bisect good f4a1954036c1a256e89fb087eb39cb719336e7c4  # 16:23  G     10     0    0   0  mfd: wm8994: Fix unbalanced calls to regulator_bulk_disable()
git bisect good 97eda5dcc2cde5dcc778bef7a9344db3b6bf8ef5  # 17:25  G     10     0    1   1  mfd: stmfx: Disable IRQ in suspend to avoid spurious interrupt
git bisect good 12e5bf757a1fd03c5d736942428732be641daa1c  # 17:41  G     10     0    0   0  mfd: max77620: Use single-byte writes on MAX77620
git bisect  bad 7edd363421dab1d4806802ac65613d1c0ec85824  # 18:00  B      0     3   19   0  mfd: Add support for PMIC MT6360
# first bad commit: [7edd363421dab1d4806802ac65613d1c0ec85824] mfd: Add support for PMIC MT6360
git bisect good 12e5bf757a1fd03c5d736942428732be641daa1c  # 18:10  G     30     0    3   4  mfd: max77620: Use single-byte writes on MAX77620
# extra tests with debug options
git bisect  bad 7edd363421dab1d4806802ac65613d1c0ec85824  # 18:21  B      0     3   19   0  mfd: Add support for PMIC MT6360
# extra tests on head commit of linus/master
git bisect  bad 435faf5c218a47fd6258187f62d9bb1009717896  # 18:39  B      0    10   26   0  Merge tag 'riscv-for-linus-5.8-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
# bad: [435faf5c218a47fd6258187f62d9bb1009717896] Merge tag 'riscv-for-linus-5.8-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
# extra tests on linus/master
# duplicated: [435faf5c218a47fd6258187f62d9bb1009717896] Merge tag 'riscv-for-linus-5.8-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
# extra tests on linux-next/master
# 119: [af30725c132e2e5c5369b60369ff0771fde7d4ff] Add linux-next specific files for 20200605

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--=_5eda2124.AZGb1fsN7ZFKHaZB+nA/MJZYYg+lOOljWryhX08UQ8d78B9u
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-vm-quantal-15:20200605180348:i386-randconfig-r001-20200604:5.7.0-rc1-00052-g7edd363421dab:1.gz"

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
rQAA

--=_5eda2124.AZGb1fsN7ZFKHaZB+nA/MJZYYg+lOOljWryhX08UQ8d78B9u
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-vm-quantal-11:20200605180957:i386-randconfig-r001-20200604:5.7.0-rc1-00051-g12e5bf757a1fd:1.gz"

H4sICPYg2l4AA2RtZXNnLXF1YW50YWwtdm0tcXVhbnRhbC0xMToyMDIwMDYwNTE4MDk1Nzpp
Mzg2LXJhbmRjb25maWctcjAwMS0yMDIwMDYwNDo1LjcuMC1yYzEtMDAwNTEtZzEyZTViZjc1
N2ExZmQ6MQC0W2lz27iW/Z5fgar+4kxbEgFugKr0amzZjjWOYrXldDKvy6WiSFDms0SquXhJ
5cfPvSApUpspe9JMJZII3IOD5W4AIp14/kLcKEyiuSRBSBKZZkt44ckPcrNMPqex46aTBxmH
cv4hCJdZOvGc1OkS7Vlj3DA0WxSv5zJUb6nmT7lpfoiyFF4Xr9RTvKpqSpe6lH/I0SdplDrz
SRL8kDm6MC0UCqX0pLf9/sOZdKPFMpZJEoQz8jkIs+d2u01GTqxenH++wJ9eFMr2h9MoSvFl
ei9J3lz7w18EHq2dc7vLAcijBOkoJGbbbmut2KUtKDRpa0aZNKe+bdoO9T1y9DDNgrn33xaz
HM9nrhBc/0iOZq67QjDaoq2To6/TLEyz/FeL6pn6yT4ek09fvpI5IOHnKbSdBvOE+FFMcomP
hLV14yP5jZKLOCD/kwEnQu0u413DJP3xLWEa0zY78cytjr/MuvDFJhejr+QpmM9Jlkhy8X18
8uf5Zv3TwfW4tYyjxwDGmCzvX5LAdebk5mRIFs6yu7O65Ezrkr8WcoHTsfG01l4Jf+r7d9C+
M53LN4EJ390G8xEMJlzGj9J7E5y/zc1/Pxzd7Cr00svh3tpVkJTbYO/m5ksfB64Oh6/eDZej
rcG9nx0tMSo4Q1/B7R65ZRyE6UOXeHKazbokmIVRjIo8j2Zz+SjnaL5Qs7fUuRScguaXFu0v
ZeCANZTLEJvbIv/lOzk6f5ZulkpyFihKHwErSqWbglZ3CZjD4HGL5niIvQaV5QQtkgzTLUJn
w0GX/HE+/ErGqRN6TuyRUZ8cBWBDL76T38loMPh+TKgQFhgHhUbblIERokQzOhrtMI0am6CX
L0uYgyABs+FJ5Ci9Lrn6c7hZ7+Fx0XLnkQsD8lVZx0USJ8SYmpbhaZQAn/LHuklha6LuMiPa
McoSJj0dZvQYx3nhxC+qTFV7RT5TTSfuPdiayPdh6uCDUGqazDK4sIj74s5lUkMwNf0uh02i
LHbBA9TgFk7ygC7B33ig4HmSQ2ExdT2DSQMUdHqsigJvLichlHFOTaGZghpcJ2GtXSqYdUfS
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
Ho7v0s3DlWnFTzxcBN/Pww0+PObhKYkDD9dW1Hg4zq1tHu6MsGQVo5OHR8fdHSjLnMbDlWvA
70k83GmAT8bDndHsMO8bD5/Lwx3dSu3xv97Dwx3ZjW65SJCxdr9uHs5MrVb3MnAn7zTJb5oN
EH93NoH1zvXS104e7mwwtBUrycMXHkRwXBz5DKbwcMXI8iQerrh6ajw8/qGzRXBJLHr8hjR4
OAYMBr40Hu6oe9R5ePBNHu4bPNw0ebgc4uGqDA+Pg0cuPyhaiX8RPNy5wOqfSTzcecE2tAd5
uKPTpnASD8eogVbwfTzceanIZH0fD8fnjo6Genk4BghSzODhDreOdAo+xMMxDAt+hni485qd
vszi4RjJ2aIWFbAWXOJf5Xg47i9scl6/NA933qWbX4vzcHJoWIyHOw8iuwEoxsMxm5on+CV5
uPMBbCke7kB4XcqiAnnDTZxraR6O47vOdgkW5uEOcOteiofjqkjI1FWW5+GYfs0ERzEe7sCC
zq+xLA935Nkk3+AvwsMdeCdzHkV4uIPAlyRK8nAXhMzijTI8nC6dQSmLCo7ONovycBfwjbO9
gwI83AXye1yUh+N6PBS1qODo/nhqhyI8PDiTKWkRHh68tsnBQBEeHkBlllyEhwf82hJxL8HD
vQC+RVqOh+MmA1y2/l8AVnspcE9QElZ7KZ0tDKtxs2WVKwmrBcNqHEnbtghw9ndq1MUADcKZ
VIsGqdbHpJq3xkek2h2RaqWgzxQB78d7QTV5iVHDpgiOCztoicB0FezsT9s31zc7SedN2PiP
Hx63Tzern0kTfk43Ip8fbjG7X//2d3/8zz9+t3q3fnh7fft6tX5Mh1cvqwT097HP3L/df4iE
c/Uz7IenJfK4f6Lmvb+7ud5+WP0M11OT04lVB0J46sujZifq1acbbS28G1MltLxJeBWSNwkn
aQcxta3JX48eNTvRLO0csxOxZDk3J2nCG60e1+dsQ9v47rOscjjneq1y8BlTf/VIJWC0wLT2
6HMOMunTPSqv1kKc9umCBO3G+x9NoX1jjfDqqP8ZGOt/WplUwWKyyRPcWrJz+9He4PtttGh3
1BtahW3XroP+2h3uDaSlGP1Y/Mk2WmLJcm6eLY+PtqXrG0uUEscKJz/a+VTInml4TTdV34Qr
Db6a9q93693vr2+/X73d/7jfnl+/W7/er+5udufr++vz3f72muROm/+5+MXz7Vusm9tfrqIZ
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
/Fv815/+Hv989v/lv1vO6dcCAA==

--=_5eda2124.AZGb1fsN7ZFKHaZB+nA/MJZYYg+lOOljWryhX08UQ8d78B9u
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-quantal-vm-quantal-15:20200605180348:i386-randconfig-r001-20200604:5.7.0-rc1-00052-g7edd363421dab:1"

#!/bin/bash

kernel=$1
initrd=quantal-i386-trinity.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
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

--=_5eda2124.AZGb1fsN7ZFKHaZB+nA/MJZYYg+lOOljWryhX08UQ8d78B9u
Content-Type: application/x-xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="e59fd1222b1fb0d5395b4d1b259c0f80a82ace5f:gcc-4.9:i386-randconfig-r001-20200604:EIP:strcmp.xz"

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

--=_5eda2124.AZGb1fsN7ZFKHaZB+nA/MJZYYg+lOOljWryhX08UQ8d78B9u
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.7.0-rc1-00052-g7edd363421dab"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.7.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-4.9 (Ubuntu 4.9.3-13ubuntu2) 4.9.3
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=40903
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
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
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
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
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
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_TIME_NS=y
# CONFIG_IPC_NS is not set
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
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
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
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
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
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
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
# end of General setup

CONFIG_X86_32=y
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
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
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
CONFIG_MPENTIUMII=y
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
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
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
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
# CONFIG_X86_IOPL_IOPERM is not set
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
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
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_TINY_POWER_BUTTON=y
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
# CONFIG_ACPI_DOCK is not set
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_TPS68470_PMIC_OPREGION is not set
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
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
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
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
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
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
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
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_4_7=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
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
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
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
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_GUP_GET_PTE_LOW_HIGH=y
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
# CONFIG_XDP_SOCKETS is not set
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
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set

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
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
# CONFIG_PCIEAER is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_PTM=y
CONFIG_PCIE_BW=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
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
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=y
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
# CONFIG_RAPIDIO_CPS_XX is not set
CONFIG_RAPIDIO_TSI568=y
CONFIG_RAPIDIO_CPS_GEN2=y
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
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
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
# CONFIG_GNSS_SIRF_SERIAL is not set
# CONFIG_GNSS_UBX_SERIAL is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y
CONFIG_FTL=y
CONFIG_NFTL=y
CONFIG_NFTL_RW=y
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
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
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
CONFIG_MTD_ESB2ROM=y
CONFIG_MTD_CK804XROM=y
CONFIG_MTD_SCB2_FLASH=y
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
CONFIG_MTD_PCI=y
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
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
# CONFIG_MTD_ONENAND_GENERIC is not set
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_RAW_NAND=y
CONFIG_MTD_NAND_ECC_SW_BCH=y

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=y
CONFIG_MTD_NAND_DENALI_PCI=y
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_CS553X is not set
CONFIG_MTD_NAND_MXIC=y
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y

#
# Misc
#
CONFIG_MTD_SM_COMMON=y
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_RICOH=y
CONFIG_MTD_NAND_DISKONCHIP=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
CONFIG_MTD_UBI_BLOCK=y
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
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
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_CS5535_MFGPT is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_VMWARE_BALLOON=y
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
CONFIG_PVPANIC=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
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
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

CONFIG_ECHO=y
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=y
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.rst for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_BLK_DEV_IDE_SATA=y
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
CONFIG_IDE_GD_ATAPI=y
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_ATIIXP=y
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
CONFIG_BLK_DEV_CS5520=y
CONFIG_BLK_DEV_CS5530=y
# CONFIG_BLK_DEV_CS5535 is not set
CONFIG_BLK_DEV_CS5536=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_JMICRON=y
CONFIG_BLK_DEV_SC1200=y
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
CONFIG_BLK_DEV_IT821X=y
CONFIG_BLK_DEV_NS87415=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_TC86C001=y
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
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_SATA_INIC162X=y
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
CONFIG_SATA_QSTOR=y
CONFIG_SATA_SX4=y
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
CONFIG_PATA_MPIIX=y
CONFIG_PATA_NS87410=y
CONFIG_PATA_OPTI=y
CONFIG_PATA_RZ1000=y

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=y
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_SBP2 is not set
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
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
# CONFIG_NTB_NETDEV is not set
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
# CONFIG_EL3 is not set
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
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
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
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_POLLDEV is not set
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

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
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
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
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
# CONFIG_TOUCHSCREEN_BU21029 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=y
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
# CONFIG_INPUT_88PM80X_ONKEY is not set
# CONFIG_INPUT_AD714X is not set
CONFIG_INPUT_ARIZONA_HAPTICS=y
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_MC13783_PWRBUTTON=y
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_WISTRON_BTNS=y
CONFIG_INPUT_ATLAS_BTNS=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
# CONFIG_INPUT_RETU_PWRBUTTON is not set
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_VIBRA=y
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_WM831X_ON=y
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_INPUT_RAVE_SP_PWRBUTTON=y
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_HYPERV_KEYBOARD=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
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
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_LPSS is not set
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_FSL_LINFLEXUART=y
CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE=y
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_SPRD=y
CONFIG_SERIAL_SPRD_CONSOLE=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=y
CONFIG_NULL_TTY=y
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
# CONFIG_HW_RANDOM_GEODE is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_APPLICOM=y
CONFIG_SONYPI=y
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_DEVPORT is not set
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
# CONFIG_XILLYBUS is not set
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
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
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
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_AMD_MP2=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_CHT_WC=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

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
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
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
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
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
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=y
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_EXAR=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_VX855=y
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_CRYSTAL_COVE=y
# CONFIG_GPIO_CS5535 is not set
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_MSIC is not set
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TPS68470 is not set
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL4030=y
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=y
# CONFIG_GPIO_WM8994 is not set
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
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
# CONFIG_W1_SLAVE_DS2780 is not set
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_AVS=y
CONFIG_QCOM_CPR=y
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_MT6323 is not set
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_88PM860X=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_TWL4030=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX8998=y
CONFIG_CHARGER_MP2629=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_WILCO=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_K8TEMP=y
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_CLOCK_THERMAL=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_PCI is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
# CONFIG_MFD_AS3711 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC_DEV is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_CHTWC=y
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_INTEL_SOC_PMIC_MRFLD=y
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_INTEL_MSIC=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS68470=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_WCD934X=y
CONFIG_RAVE_SP_CORE=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ARIZONA_LDO1=y
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8998=y
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RC5T583=y
# CONFIG_REGULATOR_SKY81452 is not set
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS80031=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_DVB_CORE=y
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
CONFIG_V4L_TEST_DRIVERS=y
# CONFIG_VIDEO_VIMC is not set
CONFIG_VIDEO_VIVID=y
# CONFIG_VIDEO_VIVID_CEC is not set
CONFIG_VIDEO_VIVID_MAX_DEVS=64
CONFIG_VIDEO_VIM2M=y
CONFIG_VIDEO_VICODEC=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_CEC_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
# CONFIG_RADIO_ADAPTERS is not set

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEO_V4L2_TPG=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y
CONFIG_MEDIA_ATTACH=y

#
# I2C drivers hidden by 'Autoselect ancillary drivers'
#

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Lens drivers
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# SPI drivers hidden by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER=y

#
# Tuner drivers hidden by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# DVB Frontend drivers hidden by 'Autoselect ancillary drivers'
#

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Common Interface (EN50221) controller drivers
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_ALI=y
CONFIG_AGP_ATI=y
CONFIG_AGP_AMD=y
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_SWORKS=y
CONFIG_AGP_VIA=y
CONFIG_AGP_EFFICEON=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=y
# CONFIG_DRM_VMWGFX_FBCON is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
# CONFIG_DRM_ETNAVIV_THERMAL is not set
CONFIG_DRM_VBOXVIDEO=y
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

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
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
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
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=y
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=y
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=y
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=y
CONFIG_FB_GEODE_GX=y
# CONFIG_FB_GEODE_GX1 is not set
CONFIG_FB_SM501=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_HYPERV=y
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_CARILLO_RANCH=y
CONFIG_BACKLIGHT_APPLE=y
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_BACKLIGHT_RAVE_SP=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# CONFIG_FRAMEBUFFER_CONSOLE is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_SB_COMMON=y
CONFIG_SND_SB16_DSP=y
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=y
# CONFIG_SND_ALS300 is not set
CONFIG_SND_ALS4000=y
CONFIG_SND_ALI5451=y
# CONFIG_SND_ASIHPI is not set
CONFIG_SND_ATIIXP=y
CONFIG_SND_ATIIXP_MODEM=y
CONFIG_SND_AU8810=y
# CONFIG_SND_AU8820 is not set
CONFIG_SND_AU8830=y
CONFIG_SND_AW2=y
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
CONFIG_SND_CMIPCI=y
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=y
# CONFIG_SND_CS46XX_NEW_DSP is not set
CONFIG_SND_CS5530=y
CONFIG_SND_CS5535AUDIO=y
CONFIG_SND_CTXFI=y
# CONFIG_SND_DARLA20 is not set
CONFIG_SND_GINA20=y
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
CONFIG_SND_GINA24=y
# CONFIG_SND_LAYLA24 is not set
CONFIG_SND_MONA=y
CONFIG_SND_MIA=y
CONFIG_SND_ECHO3G=y
CONFIG_SND_INDIGO=y
CONFIG_SND_INDIGOIO=y
CONFIG_SND_INDIGODJ=y
CONFIG_SND_INDIGOIOX=y
# CONFIG_SND_INDIGODJX is not set
CONFIG_SND_EMU10K1=y
CONFIG_SND_EMU10K1X=y
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=y
CONFIG_SND_ES1938=y
CONFIG_SND_ES1968=y
CONFIG_SND_ES1968_INPUT=y
# CONFIG_SND_ES1968_RADIO is not set
CONFIG_SND_FM801=y
# CONFIG_SND_FM801_TEA575X_BOOL is not set
CONFIG_SND_HDSP=y

#
# Don't forget to add built-in firmwares for HDSP driver
#
# CONFIG_SND_HDSPM is not set
CONFIG_SND_ICE1712=y
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
CONFIG_SND_MIXART=y
CONFIG_SND_NM256=y
CONFIG_SND_PCXHR=y
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=y
# CONFIG_SND_RME96 is not set
CONFIG_SND_RME9652=y
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=y
CONFIG_SND_VIA82XX_MODEM=y
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
CONFIG_SND_YMFPCI=y

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_INTEL=y
# CONFIG_SND_HDA_HWDEP is not set
CONFIG_SND_HDA_RECONFIG=y
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
CONFIG_SND_HDA_CODEC_CA0110=y
# CONFIG_SND_HDA_CODEC_CA0132 is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_AMD_ACP=y
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=y
# CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_BCM63XX_I2S_WHISTLER=y
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_MQS=y
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
CONFIG_SND_SOC_FSL_ESAI=y
CONFIG_SND_SOC_FSL_MICFIL=y
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
CONFIG_SND_SOC_IMG=y
# CONFIG_SND_SOC_IMG_I2S_IN is not set
CONFIG_SND_SOC_IMG_I2S_OUT=y
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
CONFIG_SND_SOC_IMG_SPDIF_IN=y
CONFIG_SND_SOC_IMG_SPDIF_OUT=y
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=y
CONFIG_SND_SST_IPC_ACPI=y
CONFIG_SND_SOC_INTEL_SST=y
# CONFIG_SND_SOC_INTEL_HASWELL is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=y
CONFIG_SND_SOC_INTEL_SKYLAKE=y
CONFIG_SND_SOC_INTEL_SKL=y
CONFIG_SND_SOC_INTEL_APL=y
CONFIG_SND_SOC_INTEL_KBL=y
CONFIG_SND_SOC_INTEL_GLK=y
CONFIG_SND_SOC_INTEL_CNL=y
CONFIG_SND_SOC_INTEL_CFL=y
# CONFIG_SND_SOC_INTEL_CML_H is not set
CONFIG_SND_SOC_INTEL_CML_LP=y
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=y
CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=y
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
# CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH is not set
# CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH is not set
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=y
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=y
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=y
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=y
CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=y
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=y
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=y
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=y
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=y
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=y
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=y
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=y
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=y
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=y
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=y
# CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH is not set
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=y
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=y
CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=y
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=y
CONFIG_SND_SOC_MTK_BTCVSD=y
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=y
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
CONFIG_SND_SOC_XILINX_SPDIF=y
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_ZX_TDM=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU_UTILS=y
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
CONFIG_SND_SOC_ADAU7118_I2C=y
# CONFIG_SND_SOC_AK4118 is not set
CONFIG_SND_SOC_AK4458=y
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4642=y
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AK5558=y
CONFIG_SND_SOC_ALC5623=y
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
CONFIG_SND_SOC_CROS_EC_CODEC=y
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=y
CONFIG_SND_SOC_CS35L36=y
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
CONFIG_SND_SOC_CS42L56=y
# CONFIG_SND_SOC_CS42L73 is not set
CONFIG_SND_SOC_CS4265=y
# CONFIG_SND_SOC_CS4270 is not set
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
# CONFIG_SND_SOC_CS43130 is not set
CONFIG_SND_SOC_CS4341=y
CONFIG_SND_SOC_CS4349=y
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_CX2072X=y
CONFIG_SND_SOC_DA7213=y
CONFIG_SND_SOC_DA7219=y
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_HDMI_CODEC=y
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_GTM601=y
CONFIG_SND_SOC_HDAC_HDMI=y
CONFIG_SND_SOC_HDAC_HDA=y
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_MAX98088=y
CONFIG_SND_SOC_MAX98090=y
CONFIG_SND_SOC_MAX98357A=y
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98373=y
# CONFIG_SND_SOC_MAX9860 is not set
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RL6347A=y
CONFIG_SND_SOC_RT286=y
CONFIG_SND_SOC_RT298=y
CONFIG_SND_SOC_RT5616=y
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5645=y
CONFIG_SND_SOC_RT5660=y
CONFIG_SND_SOC_RT5670=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
CONFIG_SND_SOC_SSM4567=y
# CONFIG_SND_SOC_STA32X is not set
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STI_SAS=y
CONFIG_SND_SOC_TAS2552=y
# CONFIG_SND_SOC_TAS2562 is not set
CONFIG_SND_SOC_TAS2770=y
# CONFIG_SND_SOC_TAS5086 is not set
CONFIG_SND_SOC_TAS571X=y
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS6424=y
# CONFIG_SND_SOC_TDA7419 is not set
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320ADCX140=y
CONFIG_SND_SOC_TS3A227E=y
CONFIG_SND_SOC_TSCS42XX=y
CONFIG_SND_SOC_TSCS454=y
# CONFIG_SND_SOC_UDA1334 is not set
CONFIG_SND_SOC_WCD9335=y
CONFIG_SND_SOC_WCD934X=y
CONFIG_SND_SOC_WM8510=y
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=y
# CONFIG_SND_SOC_WM8580 is not set
CONFIG_SND_SOC_WM8711=y
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=y
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8960=y
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8974=y
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8985=y
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
CONFIG_SND_SOC_MT6660=y
CONFIG_SND_SOC_NAU8540=y
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_NAU8825=y
CONFIG_SND_SOC_TPA6130A2=y
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SND_X86=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_HIDPP is not set
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_HYPERV_MOUSE is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
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
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_NET48XX=y
# CONFIG_LEDS_WRAP is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_ADP5520=y
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y
CONFIG_LEDS_TPS6105X=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
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
CONFIG_ALTERA_MSGDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
CONFIG_PLX_DMA=y
CONFIG_TIMB_DMA=y
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=y

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
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
CONFIG_UIO_HV_GENERIC=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO=y
CONFIG_VFIO_NOIOMMU=y
# CONFIG_VFIO_PCI is not set
# CONFIG_VFIO_MDEV is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
# CONFIG_VIRTIO_VDPA is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VDPA_MENU is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
CONFIG_ALIENWARE_WMI=y
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_MXM_WMI=y
# CONFIG_PEAQ_WMI is not set
CONFIG_XIAOMI_WMI=y
CONFIG_ACERHDF=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACER_WMI is not set
CONFIG_APPLE_GMUX=y
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_DCDBAS is not set
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_WMI is not set
# CONFIG_DELL_LAPTOP is not set
CONFIG_DELL_RBU=y
CONFIG_DELL_SMO8800=y
CONFIG_DELL_WMI=y
CONFIG_DELL_WMI_DESCRIPTOR=y
CONFIG_DELL_WMI_AIO=y
# CONFIG_DELL_WMI_LED is not set
CONFIG_FUJITSU_LAPTOP=y
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=y
# CONFIG_TC1100_WMI is not set
CONFIG_IBM_RTL=y
CONFIG_SENSORS_HDAPS=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=y
CONFIG_INTEL_INT0002_VGPIO=y
CONFIG_INTEL_VBTN=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_MSI_WMI=y
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_SAMSUNG_Q10=y
CONFIG_ACPI_TOSHIBA=y
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=y
CONFIG_LG_LAPTOP=y
CONFIG_PANASONIC_LAPTOP=y
CONFIG_SYSTEM76_ACPI=y
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_I2C_MULTI_INSTANTIATE=y
# CONFIG_MLX_PLATFORM is not set
CONFIG_TOUCHSCREEN_DMI=y
CONFIG_INTEL_IPS=y
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=y
CONFIG_INTEL_MFLD_THERMAL=y
# CONFIG_INTEL_MID_POWER_BUTTON is not set
CONFIG_INTEL_MRFLD_PWRBTN=y
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_MFD_CROS_EC is not set
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CHROMEOS_TBMC=y
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_WILCO_EC=y
CONFIG_WILCO_EC_DEBUGFS=y
CONFIG_WILCO_EC_EVENTS=y
# CONFIG_WILCO_EC_TELEMETRY is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
# CONFIG_MLXREG_IO is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# end of Common Clock Framework

CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
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

CONFIG_SOC_TI=y

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
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_ARIZONA=y
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_INTEL_CHT_WC=y
CONFIG_EXTCON_INTEL_MRFLD=y
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
# CONFIG_ADXL345_I2C is not set
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
# CONFIG_BMA180 is not set
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
# CONFIG_MXC6255 is not set
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=y
CONFIG_AD7291=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD799X=y
CONFIG_CC10001_ADC=y
# CONFIG_DA9150_GPADC is not set
# CONFIG_HX711 is not set
CONFIG_INA2XX_ADC=y
CONFIG_INTEL_MRFLD_ADC=y
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
CONFIG_LTC2497=y
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=y
# CONFIG_MCP3422 is not set
# CONFIG_MEN_Z188_ADC is not set
CONFIG_MP2629_ADC=y
# CONFIG_NAU7802 is not set
CONFIG_QCOM_SPMI_IADC=y
# CONFIG_QCOM_SPMI_VADC is not set
# CONFIG_QCOM_SPMI_ADC5 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_AM335X_ADC=y
# CONFIG_TWL4030_MADC is not set
CONFIG_TWL6030_GPADC=y
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog Front Ends
#
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
CONFIG_BME680=y
CONFIG_BME680_I2C=y
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
CONFIG_PMS7003=y
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
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5380=y
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
CONFIG_DS4424=y
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MCP4725 is not set
CONFIG_TI_DAC5571=y
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
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
# CONFIG_FXAS21002C is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
CONFIG_ACPI_ALS=y
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
CONFIG_AL3010=y
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM36651=y
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
CONFIG_IQS621_ALS=y
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
CONFIG_NOA1305=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6030=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
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
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
# CONFIG_MCP4018 is not set
CONFIG_MCP4531=y
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
# CONFIG_BMP280 is not set
CONFIG_DLHL60D=y
# CONFIG_DPS310 is not set
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=y
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
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
CONFIG_SX9500=y
CONFIG_SRF08=y
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
CONFIG_MLX90614=y
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# end of Temperature sensors

CONFIG_NTB=y
# CONFIG_NTB_IDT is not set
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_BRCMSTB_RESCAL=y
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_INTEL_EMMC=y
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
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=y
# CONFIG_RAVE_SP_EEPROM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_ACPI=y
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
CONFIG_MOST=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
CONFIG_F2FS_FS_LZ4=y
# CONFIG_F2FS_FS_ZSTD is not set
CONFIG_ZONEFS_FS=y
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=y
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_UBIFS_FS=y
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
# CONFIG_UBIFS_FS_SECURITY is not set
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_CRAMFS_MTD=y
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
# CONFIG_QNX6FS_FS is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
# CONFIG_VBOXSF_FS is not set
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
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set
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
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
CONFIG_SECURITY_LOADPIN_ENFORCE=y
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
# CONFIG_INTEGRITY_ASYMMETRIC_KEYS is not set
# CONFIG_IMA is not set
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
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_CURVE25519 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

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
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
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
# CONFIG_CRYPTO_DRBG_HASH is not set
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
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_TPM_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
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
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
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
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
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
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
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
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
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
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
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
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
CONFIG_UBSAN_BOUNDS=y
# CONFIG_UBSAN_MISC is not set
# CONFIG_UBSAN_SANITIZE_ALL is not set
CONFIG_UBSAN_NO_ALIGNMENT=y
# CONFIG_TEST_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_DEBUG_ON=y
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
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
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

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

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
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
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
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
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
CONFIG_HYPERV_TESTING=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--=_5eda2124.AZGb1fsN7ZFKHaZB+nA/MJZYYg+lOOljWryhX08UQ8d78B9u
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.7.0-rc1-00052-g7edd363421dab"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.7.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-4.9 (Ubuntu 4.9.3-13ubuntu2) 4.9.3
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=40903
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
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
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
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
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
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_TIME_NS=y
# CONFIG_IPC_NS is not set
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
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
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
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
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
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
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
# end of General setup

CONFIG_X86_32=y
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
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
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
CONFIG_MPENTIUMII=y
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
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
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
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
# CONFIG_X86_IOPL_IOPERM is not set
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
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
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_TINY_POWER_BUTTON=y
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
# CONFIG_ACPI_DOCK is not set
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_TPS68470_PMIC_OPREGION is not set
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
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
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
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
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
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
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
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_4_7=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
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
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
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
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_GUP_GET_PTE_LOW_HIGH=y
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
# CONFIG_XDP_SOCKETS is not set
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
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set

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
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
# CONFIG_PCIEAER is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_PTM=y
CONFIG_PCIE_BW=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
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
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=y
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
# CONFIG_RAPIDIO_CPS_XX is not set
CONFIG_RAPIDIO_TSI568=y
CONFIG_RAPIDIO_CPS_GEN2=y
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
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
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
# CONFIG_GNSS_SIRF_SERIAL is not set
# CONFIG_GNSS_UBX_SERIAL is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y
CONFIG_FTL=y
CONFIG_NFTL=y
CONFIG_NFTL_RW=y
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
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
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
CONFIG_MTD_ESB2ROM=y
CONFIG_MTD_CK804XROM=y
CONFIG_MTD_SCB2_FLASH=y
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
CONFIG_MTD_PCI=y
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
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
# CONFIG_MTD_ONENAND_GENERIC is not set
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_RAW_NAND=y
CONFIG_MTD_NAND_ECC_SW_BCH=y

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=y
CONFIG_MTD_NAND_DENALI_PCI=y
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_CS553X is not set
CONFIG_MTD_NAND_MXIC=y
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y

#
# Misc
#
CONFIG_MTD_SM_COMMON=y
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_RICOH=y
CONFIG_MTD_NAND_DISKONCHIP=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
CONFIG_MTD_UBI_BLOCK=y
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
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
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_CS5535_MFGPT is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_VMWARE_BALLOON=y
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
CONFIG_PVPANIC=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
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
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

CONFIG_ECHO=y
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=y
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.rst for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_BLK_DEV_IDE_SATA=y
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
CONFIG_IDE_GD_ATAPI=y
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_ATIIXP=y
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
CONFIG_BLK_DEV_CS5520=y
CONFIG_BLK_DEV_CS5530=y
# CONFIG_BLK_DEV_CS5535 is not set
CONFIG_BLK_DEV_CS5536=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_JMICRON=y
CONFIG_BLK_DEV_SC1200=y
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
CONFIG_BLK_DEV_IT821X=y
CONFIG_BLK_DEV_NS87415=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_TC86C001=y
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
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_SATA_INIC162X=y
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
CONFIG_SATA_QSTOR=y
CONFIG_SATA_SX4=y
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
CONFIG_PATA_MPIIX=y
CONFIG_PATA_NS87410=y
CONFIG_PATA_OPTI=y
CONFIG_PATA_RZ1000=y

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=y
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_SBP2 is not set
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
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
# CONFIG_NTB_NETDEV is not set
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
# CONFIG_EL3 is not set
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
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
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
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_POLLDEV is not set
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

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
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
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
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
# CONFIG_TOUCHSCREEN_BU21029 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=y
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
# CONFIG_INPUT_88PM80X_ONKEY is not set
# CONFIG_INPUT_AD714X is not set
CONFIG_INPUT_ARIZONA_HAPTICS=y
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_MC13783_PWRBUTTON=y
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_WISTRON_BTNS=y
CONFIG_INPUT_ATLAS_BTNS=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
# CONFIG_INPUT_RETU_PWRBUTTON is not set
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_VIBRA=y
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_WM831X_ON=y
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_INPUT_RAVE_SP_PWRBUTTON=y
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_HYPERV_KEYBOARD=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
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
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_LPSS is not set
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_FSL_LINFLEXUART=y
CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE=y
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_SPRD=y
CONFIG_SERIAL_SPRD_CONSOLE=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=y
CONFIG_NULL_TTY=y
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
# CONFIG_HW_RANDOM_GEODE is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_APPLICOM=y
CONFIG_SONYPI=y
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_DEVPORT is not set
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
# CONFIG_XILLYBUS is not set
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
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
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
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_AMD_MP2=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_CHT_WC=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

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
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
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
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
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
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=y
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_EXAR=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_VX855=y
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_CRYSTAL_COVE=y
# CONFIG_GPIO_CS5535 is not set
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_MSIC is not set
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TPS68470 is not set
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL4030=y
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=y
# CONFIG_GPIO_WM8994 is not set
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
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
# CONFIG_W1_SLAVE_DS2780 is not set
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_AVS=y
CONFIG_QCOM_CPR=y
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_MT6323 is not set
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_88PM860X=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_TWL4030=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX8998=y
CONFIG_CHARGER_MP2629=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_WILCO=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_K8TEMP=y
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_CLOCK_THERMAL=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_PCI is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
# CONFIG_MFD_AS3711 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC_DEV is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_CHTWC=y
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_INTEL_SOC_PMIC_MRFLD=y
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_INTEL_MSIC=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS68470=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_WCD934X=y
CONFIG_RAVE_SP_CORE=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ARIZONA_LDO1=y
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8998=y
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RC5T583=y
# CONFIG_REGULATOR_SKY81452 is not set
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS80031=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_DVB_CORE=y
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
CONFIG_V4L_TEST_DRIVERS=y
# CONFIG_VIDEO_VIMC is not set
CONFIG_VIDEO_VIVID=y
# CONFIG_VIDEO_VIVID_CEC is not set
CONFIG_VIDEO_VIVID_MAX_DEVS=64
CONFIG_VIDEO_VIM2M=y
CONFIG_VIDEO_VICODEC=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_CEC_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
# CONFIG_RADIO_ADAPTERS is not set

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEO_V4L2_TPG=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y
CONFIG_MEDIA_ATTACH=y

#
# I2C drivers hidden by 'Autoselect ancillary drivers'
#

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Lens drivers
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# SPI drivers hidden by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER=y

#
# Tuner drivers hidden by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# DVB Frontend drivers hidden by 'Autoselect ancillary drivers'
#

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Common Interface (EN50221) controller drivers
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_ALI=y
CONFIG_AGP_ATI=y
CONFIG_AGP_AMD=y
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_SWORKS=y
CONFIG_AGP_VIA=y
CONFIG_AGP_EFFICEON=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=y
# CONFIG_DRM_VMWGFX_FBCON is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
# CONFIG_DRM_ETNAVIV_THERMAL is not set
CONFIG_DRM_VBOXVIDEO=y
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

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
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
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
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=y
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=y
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=y
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=y
CONFIG_FB_GEODE_GX=y
# CONFIG_FB_GEODE_GX1 is not set
CONFIG_FB_SM501=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_HYPERV=y
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_CARILLO_RANCH=y
CONFIG_BACKLIGHT_APPLE=y
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_BACKLIGHT_RAVE_SP=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# CONFIG_FRAMEBUFFER_CONSOLE is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_SB_COMMON=y
CONFIG_SND_SB16_DSP=y
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=y
# CONFIG_SND_ALS300 is not set
CONFIG_SND_ALS4000=y
CONFIG_SND_ALI5451=y
# CONFIG_SND_ASIHPI is not set
CONFIG_SND_ATIIXP=y
CONFIG_SND_ATIIXP_MODEM=y
CONFIG_SND_AU8810=y
# CONFIG_SND_AU8820 is not set
CONFIG_SND_AU8830=y
CONFIG_SND_AW2=y
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
CONFIG_SND_CMIPCI=y
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=y
# CONFIG_SND_CS46XX_NEW_DSP is not set
CONFIG_SND_CS5530=y
CONFIG_SND_CS5535AUDIO=y
CONFIG_SND_CTXFI=y
# CONFIG_SND_DARLA20 is not set
CONFIG_SND_GINA20=y
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
CONFIG_SND_GINA24=y
# CONFIG_SND_LAYLA24 is not set
CONFIG_SND_MONA=y
CONFIG_SND_MIA=y
CONFIG_SND_ECHO3G=y
CONFIG_SND_INDIGO=y
CONFIG_SND_INDIGOIO=y
CONFIG_SND_INDIGODJ=y
CONFIG_SND_INDIGOIOX=y
# CONFIG_SND_INDIGODJX is not set
CONFIG_SND_EMU10K1=y
CONFIG_SND_EMU10K1X=y
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=y
CONFIG_SND_ES1938=y
CONFIG_SND_ES1968=y
CONFIG_SND_ES1968_INPUT=y
# CONFIG_SND_ES1968_RADIO is not set
CONFIG_SND_FM801=y
# CONFIG_SND_FM801_TEA575X_BOOL is not set
CONFIG_SND_HDSP=y

#
# Don't forget to add built-in firmwares for HDSP driver
#
# CONFIG_SND_HDSPM is not set
CONFIG_SND_ICE1712=y
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
CONFIG_SND_MIXART=y
CONFIG_SND_NM256=y
CONFIG_SND_PCXHR=y
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=y
# CONFIG_SND_RME96 is not set
CONFIG_SND_RME9652=y
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=y
CONFIG_SND_VIA82XX_MODEM=y
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
CONFIG_SND_YMFPCI=y

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_INTEL=y
# CONFIG_SND_HDA_HWDEP is not set
CONFIG_SND_HDA_RECONFIG=y
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
CONFIG_SND_HDA_CODEC_CA0110=y
# CONFIG_SND_HDA_CODEC_CA0132 is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_AMD_ACP=y
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=y
# CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_BCM63XX_I2S_WHISTLER=y
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_MQS=y
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
CONFIG_SND_SOC_FSL_ESAI=y
CONFIG_SND_SOC_FSL_MICFIL=y
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
CONFIG_SND_SOC_IMG=y
# CONFIG_SND_SOC_IMG_I2S_IN is not set
CONFIG_SND_SOC_IMG_I2S_OUT=y
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
CONFIG_SND_SOC_IMG_SPDIF_IN=y
CONFIG_SND_SOC_IMG_SPDIF_OUT=y
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=y
CONFIG_SND_SST_IPC_ACPI=y
CONFIG_SND_SOC_INTEL_SST=y
# CONFIG_SND_SOC_INTEL_HASWELL is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=y
CONFIG_SND_SOC_INTEL_SKYLAKE=y
CONFIG_SND_SOC_INTEL_SKL=y
CONFIG_SND_SOC_INTEL_APL=y
CONFIG_SND_SOC_INTEL_KBL=y
CONFIG_SND_SOC_INTEL_GLK=y
CONFIG_SND_SOC_INTEL_CNL=y
CONFIG_SND_SOC_INTEL_CFL=y
# CONFIG_SND_SOC_INTEL_CML_H is not set
CONFIG_SND_SOC_INTEL_CML_LP=y
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=y
CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=y
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
# CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH is not set
# CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH is not set
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=y
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=y
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=y
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=y
CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=y
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=y
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=y
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=y
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=y
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=y
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=y
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=y
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=y
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=y
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=y
# CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH is not set
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=y
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=y
CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=y
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=y
CONFIG_SND_SOC_MTK_BTCVSD=y
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=y
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
CONFIG_SND_SOC_XILINX_SPDIF=y
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_ZX_TDM=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU_UTILS=y
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
CONFIG_SND_SOC_ADAU7118_I2C=y
# CONFIG_SND_SOC_AK4118 is not set
CONFIG_SND_SOC_AK4458=y
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4642=y
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AK5558=y
CONFIG_SND_SOC_ALC5623=y
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
CONFIG_SND_SOC_CROS_EC_CODEC=y
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=y
CONFIG_SND_SOC_CS35L36=y
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
CONFIG_SND_SOC_CS42L56=y
# CONFIG_SND_SOC_CS42L73 is not set
CONFIG_SND_SOC_CS4265=y
# CONFIG_SND_SOC_CS4270 is not set
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
# CONFIG_SND_SOC_CS43130 is not set
CONFIG_SND_SOC_CS4341=y
CONFIG_SND_SOC_CS4349=y
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_CX2072X=y
CONFIG_SND_SOC_DA7213=y
CONFIG_SND_SOC_DA7219=y
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_HDMI_CODEC=y
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_GTM601=y
CONFIG_SND_SOC_HDAC_HDMI=y
CONFIG_SND_SOC_HDAC_HDA=y
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_MAX98088=y
CONFIG_SND_SOC_MAX98090=y
CONFIG_SND_SOC_MAX98357A=y
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98373=y
# CONFIG_SND_SOC_MAX9860 is not set
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RL6347A=y
CONFIG_SND_SOC_RT286=y
CONFIG_SND_SOC_RT298=y
CONFIG_SND_SOC_RT5616=y
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5645=y
CONFIG_SND_SOC_RT5660=y
CONFIG_SND_SOC_RT5670=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
CONFIG_SND_SOC_SSM4567=y
# CONFIG_SND_SOC_STA32X is not set
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STI_SAS=y
CONFIG_SND_SOC_TAS2552=y
# CONFIG_SND_SOC_TAS2562 is not set
CONFIG_SND_SOC_TAS2770=y
# CONFIG_SND_SOC_TAS5086 is not set
CONFIG_SND_SOC_TAS571X=y
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS6424=y
# CONFIG_SND_SOC_TDA7419 is not set
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320ADCX140=y
CONFIG_SND_SOC_TS3A227E=y
CONFIG_SND_SOC_TSCS42XX=y
CONFIG_SND_SOC_TSCS454=y
# CONFIG_SND_SOC_UDA1334 is not set
CONFIG_SND_SOC_WCD9335=y
CONFIG_SND_SOC_WCD934X=y
CONFIG_SND_SOC_WM8510=y
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=y
# CONFIG_SND_SOC_WM8580 is not set
CONFIG_SND_SOC_WM8711=y
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=y
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8960=y
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8974=y
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8985=y
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
CONFIG_SND_SOC_MT6660=y
CONFIG_SND_SOC_NAU8540=y
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_NAU8825=y
CONFIG_SND_SOC_TPA6130A2=y
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SND_X86=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_HIDPP is not set
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_HYPERV_MOUSE is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
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
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_NET48XX=y
# CONFIG_LEDS_WRAP is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_ADP5520=y
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y
CONFIG_LEDS_TPS6105X=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
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
CONFIG_ALTERA_MSGDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
CONFIG_PLX_DMA=y
CONFIG_TIMB_DMA=y
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=y

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
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
CONFIG_UIO_HV_GENERIC=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO=y
CONFIG_VFIO_NOIOMMU=y
# CONFIG_VFIO_PCI is not set
# CONFIG_VFIO_MDEV is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
# CONFIG_VIRTIO_VDPA is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VDPA_MENU is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
CONFIG_ALIENWARE_WMI=y
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_MXM_WMI=y
# CONFIG_PEAQ_WMI is not set
CONFIG_XIAOMI_WMI=y
CONFIG_ACERHDF=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACER_WMI is not set
CONFIG_APPLE_GMUX=y
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_DCDBAS is not set
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_WMI is not set
# CONFIG_DELL_LAPTOP is not set
CONFIG_DELL_RBU=y
CONFIG_DELL_SMO8800=y
CONFIG_DELL_WMI=y
CONFIG_DELL_WMI_DESCRIPTOR=y
CONFIG_DELL_WMI_AIO=y
# CONFIG_DELL_WMI_LED is not set
CONFIG_FUJITSU_LAPTOP=y
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=y
# CONFIG_TC1100_WMI is not set
CONFIG_IBM_RTL=y
CONFIG_SENSORS_HDAPS=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=y
CONFIG_INTEL_INT0002_VGPIO=y
CONFIG_INTEL_VBTN=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_MSI_WMI=y
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_SAMSUNG_Q10=y
CONFIG_ACPI_TOSHIBA=y
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=y
CONFIG_LG_LAPTOP=y
CONFIG_PANASONIC_LAPTOP=y
CONFIG_SYSTEM76_ACPI=y
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_I2C_MULTI_INSTANTIATE=y
# CONFIG_MLX_PLATFORM is not set
CONFIG_TOUCHSCREEN_DMI=y
CONFIG_INTEL_IPS=y
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=y
CONFIG_INTEL_MFLD_THERMAL=y
# CONFIG_INTEL_MID_POWER_BUTTON is not set
CONFIG_INTEL_MRFLD_PWRBTN=y
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_MFD_CROS_EC is not set
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CHROMEOS_TBMC=y
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_WILCO_EC=y
CONFIG_WILCO_EC_DEBUGFS=y
CONFIG_WILCO_EC_EVENTS=y
# CONFIG_WILCO_EC_TELEMETRY is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
# CONFIG_MLXREG_IO is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# end of Common Clock Framework

CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
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

CONFIG_SOC_TI=y

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
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_ARIZONA=y
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_INTEL_CHT_WC=y
CONFIG_EXTCON_INTEL_MRFLD=y
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
# CONFIG_ADXL345_I2C is not set
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
# CONFIG_BMA180 is not set
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
# CONFIG_MXC6255 is not set
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=y
CONFIG_AD7291=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD799X=y
CONFIG_CC10001_ADC=y
# CONFIG_DA9150_GPADC is not set
# CONFIG_HX711 is not set
CONFIG_INA2XX_ADC=y
CONFIG_INTEL_MRFLD_ADC=y
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
CONFIG_LTC2497=y
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=y
# CONFIG_MCP3422 is not set
# CONFIG_MEN_Z188_ADC is not set
CONFIG_MP2629_ADC=y
# CONFIG_NAU7802 is not set
CONFIG_QCOM_SPMI_IADC=y
# CONFIG_QCOM_SPMI_VADC is not set
# CONFIG_QCOM_SPMI_ADC5 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_AM335X_ADC=y
# CONFIG_TWL4030_MADC is not set
CONFIG_TWL6030_GPADC=y
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog Front Ends
#
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
CONFIG_BME680=y
CONFIG_BME680_I2C=y
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
CONFIG_PMS7003=y
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
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5380=y
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
CONFIG_DS4424=y
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MCP4725 is not set
CONFIG_TI_DAC5571=y
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
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
# CONFIG_FXAS21002C is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
CONFIG_ACPI_ALS=y
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
CONFIG_AL3010=y
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM36651=y
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
CONFIG_IQS621_ALS=y
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
CONFIG_NOA1305=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6030=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
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
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
# CONFIG_MCP4018 is not set
CONFIG_MCP4531=y
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
# CONFIG_BMP280 is not set
CONFIG_DLHL60D=y
# CONFIG_DPS310 is not set
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=y
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
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
CONFIG_SX9500=y
CONFIG_SRF08=y
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
CONFIG_MLX90614=y
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# end of Temperature sensors

CONFIG_NTB=y
# CONFIG_NTB_IDT is not set
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_BRCMSTB_RESCAL=y
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_INTEL_EMMC=y
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
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=y
# CONFIG_RAVE_SP_EEPROM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_ACPI=y
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
CONFIG_MOST=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
CONFIG_F2FS_FS_LZ4=y
# CONFIG_F2FS_FS_ZSTD is not set
CONFIG_ZONEFS_FS=y
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=y
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_UBIFS_FS=y
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
# CONFIG_UBIFS_FS_SECURITY is not set
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_CRAMFS_MTD=y
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
# CONFIG_QNX6FS_FS is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
# CONFIG_VBOXSF_FS is not set
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
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set
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
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
CONFIG_SECURITY_LOADPIN_ENFORCE=y
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
# CONFIG_INTEGRITY_ASYMMETRIC_KEYS is not set
# CONFIG_IMA is not set
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
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_CURVE25519 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

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
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
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
# CONFIG_CRYPTO_DRBG_HASH is not set
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
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_TPM_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
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
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
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
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
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
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
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
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
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
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
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
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
CONFIG_UBSAN_BOUNDS=y
# CONFIG_UBSAN_MISC is not set
# CONFIG_UBSAN_SANITIZE_ALL is not set
CONFIG_UBSAN_NO_ALIGNMENT=y
# CONFIG_TEST_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_DEBUG_ON=y
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
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
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

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

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
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
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
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
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
CONFIG_HYPERV_TESTING=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--=_5eda2124.AZGb1fsN7ZFKHaZB+nA/MJZYYg+lOOljWryhX08UQ8d78B9u--
