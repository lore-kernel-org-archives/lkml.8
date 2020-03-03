Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6CEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E16A24684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCCCLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:11:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:2191 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgCCCLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:11:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 18:11:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; 
   d="xz'?gz'50?scan'50,208,50";a="263037915"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2020 18:11:26 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j8x1q-0006ya-BH; Tue, 03 Mar 2020 10:11:26 +0800
Date:   Tue, 03 Mar 2020 10:10:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Rowand <frank.rowand@sony.com>
Cc:     LKP <lkp@lists.01.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>, philip.li@intel.com
Subject: f4056e705b ("of: unittest: add overlay gpio test to catch gpio
 .."):  WARNING: held lock freed!
Message-ID: <5e5dbc98.oBO6UKMRbgQnGwIO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5e5dbc98.3YZqMTP9XCyxGg3+TneaGg7mgLlGOJEy2LQ56W63KxRCveRS"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5e5dbc98.3YZqMTP9XCyxGg3+TneaGg7mgLlGOJEy2LQ56W63KxRCveRS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next

commit f4056e705b2ef7f123a188f6aee23ade70e7d793
Author:     Frank Rowand <frank.rowand@sony.com>
AuthorDate: Thu Feb 20 12:40:20 2020 -0600
Commit:     Rob Herring <robh@kernel.org>
CommitDate: Wed Feb 26 10:42:04 2020 -0600

    of: unittest: add overlay gpio test to catch gpio hog problem
    
    Geert reports that gpio hog nodes are not properly processed when
    the gpio hog node is added via an overlay reply and provides an
    RFC patch to fix the problem [1].
    
    Add a unittest that shows the problem.  Unittest will report "1 failed"
    test before applying Geert's RFC patch and "0 failed" after applying
    Geert's RFC patch.
    
    [1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/
    
    Signed-off-by: Frank Rowand <frank.rowand@sony.com>
    Signed-off-by: Rob Herring <robh@kernel.org>

2f7afc343d  of: property: Add device link support for power-domains and hwlocks
f4056e705b  of: unittest: add overlay gpio test to catch gpio hog problem
76897807dc  dt-bindings: clock: Convert UniPhier clock to json-schema
+---------------------------------------------------+------------+------------+------------+
|                                                   | 2f7afc343d | f4056e705b | 76897807dc |
+---------------------------------------------------+------------+------------+------------+
| boot_successes                                    | 32         | 0          | 0          |
| boot_failures                                     | 8          | 13         | 2          |
| BUG:kernel_timeout_in_torture_test_stage          | 3          |            |            |
| WARNING:at_kernel/workqueue.c:#wq_worker_sleeping | 4          |            |            |
| EIP:wq_worker_sleeping                            | 4          |            |            |
| BUG:kernel_hang_in_boot_stage                     | 1          |            |            |
| WARNING:held_lock_freed                           | 0          | 13         | 2          |
| is_freeing_memory#-#,with_a_lock_still_held_there | 0          | 13         | 2          |
| BUG:kernel_NULL_pointer_dereference,address       | 0          | 13         | 2          |
| Oops:#[##]                                        | 0          | 13         | 2          |
| EIP:device_links_driver_cleanup                   | 0          | 13         | 2          |
| Kernel_panic-not_syncing:Fatal_exception          | 0          | 13         | 2          |
+---------------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[  380.048469] ### dt-test ### EXPECT / : GPIO line <<int>> (line-D-input) hogged as input
[  380.081817] ### dt-test ### EXPECT \ : GPIO line <<int>> (line-C-input) hogged as input
[  380.095866] ### dt-test ### EXPECT / : GPIO line <<int>> (line-C-input) hogged as input
[  380.096714] ### dt-test ### FAIL of_unittest_overlay_gpio():2422 unittest_gpio_chip_request() called 0 times (expected 1 time)
[  380.106856] 
[  380.107033] =========================
[  380.107392] WARNING: held lock freed!
[  380.107759] 5.6.0-rc1-00020-gf4056e705b2ef #1 Not tainted
[  380.108273] -------------------------
[  380.108632] swapper/0/1 is freeing memory f3dc8200-f3dc83ff, with a lock still held there!
[  380.109410] f3dc82c8 (&dev->mutex){....}, at: device_release_driver_internal+0x12/0x116
[  380.110174] 2 locks held by swapper/0/1:
[  380.110548]  #0: 41be5d38 ((of_reconfig_chain).rwsem){++++}, at: __blocking_notifier_call_chain+0x17/0x40
[  380.111472]  #1: f3dc82c8 (&dev->mutex){....}, at: device_release_driver_internal+0x12/0x116
[  380.112296] 
[  380.112296] stack backtrace:
[  380.112773] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc1-00020-gf4056e705b2ef #1
[  380.113569] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  380.114411] Call Trace:
[  380.114694]  ? dump_stack+0x69/0x90
[  380.115034]  ? debug_check_no_locks_freed+0xcf/0xe8
[  380.115516]  ? slab_free_freelist_hook+0x7f/0xec
[  380.115966]  ? kfree+0x22a/0x348
[  380.116283]  ? unittest_gpio_remove+0x23/0x2e
[  380.116711]  ? unittest_gpio_remove+0x23/0x2e
[  380.117129]  ? device_release_driver_internal+0x9d/0x116
[  380.117642]  ? bus_remove_device+0xa1/0xb0
[  380.118039]  ? device_del+0x167/0x2fa
[  380.118394]  ? class_dir_child_ns_type+0xb/0xb
[  380.118832]  ? klist_iter_exit+0x11/0x1a
[  380.119219]  ? platform_device_del+0x17/0x57
[  380.119638]  ? platform_device_unregister+0xa/0x12
[  380.120109]  ? of_platform_device_destroy+0x51/0x55
[  380.120586]  ? of_platform_notify+0xa7/0xcc
[  380.120992]  ? notifier_call_chain+0x2b/0x45
[  380.121455]  ? __blocking_notifier_call_chain+0x2b/0x40
[  380.121982]  ? blocking_notifier_call_chain+0x23/0x27
[  380.122466]  ? of_reconfig_notify+0x14/0x2c
[  380.122877]  ? __of_changeset_entry_notify+0x8d/0xd3
[  380.123360]  ? __of_changeset_revert_notify+0x24/0x41
[  380.123871]  ? of_overlay_remove+0x1a1/0x218
[  380.124323]  ? of_unittest+0x1bf8/0x1fe7
[  380.124755]  ? of_unittest_printf_one+0x11e/0x11e
[  380.125231]  ? do_one_initcall+0x118/0x2cf
[  380.125647]  ? kernel_init_freeable+0x139/0x188
[  380.126084]  ? rest_init+0x11d/0x11d
[  380.126439]  ? kernel_init+0x5/0xcc
[  380.126813]  ? ret_from_fork+0x1e/0x30
[  380.127392] BUG: kernel NULL pointer dereference, address: 00000000
[  380.128064] #PF: supervisor read access in kernel mode
[  380.128562] #PF: error_code(0x0000) - not-present page
[  380.129075] *pde = 00000000 
[  380.129356] Oops: 0000 [#1] PREEMPT SMP
[  380.129728] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc1-00020-gf4056e705b2ef #1
[  380.130480] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  380.143418] EIP: device_links_driver_cleanup+0xcb/0xff
[  380.143947] Code: 54 24 04 31 c9 b8 c8 01 c7 41 e8 19 aa cf ff 83 7b 18 04 5a 75 0d f6 43 1c 10 74 07 89 d8 e8 ae f5 ff ff c7 43 18 00 00 00 00 <8b> 47 04 89 fb e9 42 ff ff ff 8d 9e e4 00 00 00 89 d8 e8 31 f0 ff
[  380.145732] EAX: f3dc82e0 EBX: 6b6b6b67 ECX: 00000000 EDX: 6b6b6b6b
[  380.146331] ESI: f3dc820c EDI: fffffffc EBP: 00000000 ESP: f5155d20
[  380.146981] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[  380.147633] CR0: 80050033 CR2: 00000000 CR3: 01d8e000 CR4: 001406d0
[  380.148232] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  380.148832] DR6: fffe0ff0 DR7: 00000400
[  380.149203] Call Trace:
[  380.149458]  ? device_release_driver_internal+0xa4/0x116
[  380.150005]  ? bus_remove_device+0xa1/0xb0
[  380.150419]  ? device_del+0x167/0x2fa
[  380.150815]  ? class_dir_child_ns_type+0xb/0xb
[  380.151306]  ? klist_iter_exit+0x11/0x1a
[  380.151736]  ? platform_device_del+0x17/0x57
[  380.152149]  ? platform_device_unregister+0xa/0x12
[  380.152616]  ? of_platform_device_destroy+0x51/0x55
[  380.153089]  ? of_platform_notify+0xa7/0xcc
[  380.153501]  ? notifier_call_chain+0x2b/0x45
[  380.153939]  ? __blocking_notifier_call_chain+0x2b/0x40
[  380.154470]  ? blocking_notifier_call_chain+0x23/0x27
[  380.154998]  ? of_reconfig_notify+0x14/0x2c
[  380.155437]  ? __of_changeset_entry_notify+0x8d/0xd3
[  380.155951]  ? __of_changeset_revert_notify+0x24/0x41
[  380.156439]  ? of_overlay_remove+0x1a1/0x218
[  380.156863]  ? of_unittest+0x1bf8/0x1fe7
[  380.157269]  ? of_unittest_printf_one+0x11e/0x11e
[  380.157730]  ? do_one_initcall+0x118/0x2cf
[  380.158153]  ? kernel_init_freeable+0x139/0x188
[  380.158609]  ? rest_init+0x11d/0x11d
[  380.158980]  ? kernel_init+0x5/0xcc
[  380.159331]  ? ret_from_fork+0x1e/0x30
[  380.159723] Modules linked in:
[  380.160025] CR2: 0000000000000000
[  380.160354] ---[ end trace fa157650c0d14f0b ]---
[  380.160804] EIP: device_links_driver_cleanup+0xcb/0xff

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 65e5f40b639d0788611a2e18ae27cadbce7eef70 f8788d86ab28f61f7b46eb6be375f8a726783636 --
git bisect  bad 4e979fd94657ebcb12ceaeb74021db2ae0c44e99  # 17:02  B      0     8   27   3  Merge 'stblinux/defconfig/fixes' into devel-hourly-2020030110
git bisect  bad 5c333c40ae2ad15257877a5b4c85f2001888d8bd  # 17:02  B      0     9   27   2  Merge 'georgi.djakov/icc-next' into devel-hourly-2020030110
git bisect good a5e9a9f2b30c6b17d0e4c5368e21354f1c25baea  # 17:37  G     11     0    1   7  Merge 'linux-review/Gustavo-A-R-Silva/net-marvell-Replace-zero-length-array-with-flexible-array-member/20200225-081226' into devel-hourly-2020030110
git bisect good 3761a240da8cfc7a2515c537e7078756a5d490aa  # 18:14  G     11     0    1   2  Merge 'linux-review/Athira-Rajeev/powerpc-perf-Use-SIER_USER_MASK-while-updating-SPRN_SIER-for-EBB-events/20200229-053024' into devel-hourly-2020030110
git bisect  bad 46761b71e3f0897a438a914779c022bedf38aacd  # 18:14  B      1     7    0   3  Merge 'linux-review/Sergiu-Cuciurean/net-wireless-marvell-libertas-Use-new-structure-for-SPI-transfer-delays/20200228-162311' into devel-hourly-2020030110
git bisect good a6b0da9ee130ff186536d2852ee17a001476e8c8  # 18:20  G     12     0    1   2  Merge 'linux-review/Gustavo-A-R-Silva/ipv6-Replace-zero-length-array-with-flexible-array-member/20200229-073152' into devel-hourly-2020030110
git bisect good fef5536de043ba7b4798f37bf03d93ac3fb3b849  # 18:38  G     12     0    0   1  Merge 'linux-review/Balbir-Singh/Add-support-for-block-disk-resize-notification/20200226-050213' into devel-hourly-2020030110
git bisect good 1fa9848c93094a60d230f9fcc37f5e8b7c903457  # 19:11  G     12     0    1   8  Merge 'linux-review/Jiri-Pirko/mlxsw-pci-Wait-longer-before-accessing-the-device-after-reset/20200229-023848' into devel-hourly-2020030110
git bisect  bad 7291198059b3c748b855973e643cca9844895e00  # 19:11  B      1     9    0   2  Merge 'linux-review/George-Hilliard/Support-the-Allwinner-F1C100s-USB-stack/20200229-003545' into devel-hourly-2020030110
git bisect  bad 4abfe6f04d93e4aac202007486266bd1a904cc43  # 19:11  B      1    10    0   0  dt-bindings: i2c: Convert UniPhier FI2C controller to json-schema
git bisect good faf8e30acb219849725aa75302d36e0ffdb6a258  # 19:29  G     12     0    0   1  dt-bindings: arm: Add kryo260 compatible
git bisect good 8acbbddcf9913149ef47b20f487289da02c4a291  # 20:02  G     12     0    2   5  dt-bindings: ata: rcar-sata: Convert to json-schema
git bisect  bad 0ac1743979408a4999f32b777ce71f40fac040fa  # 21:42  B      0     3   21   0  of: unittest: annotate warnings triggered by unittest
git bisect  bad f4056e705b2ef7f123a188f6aee23ade70e7d793  # 22:48  B      0     1   17   0  of: unittest: add overlay gpio test to catch gpio hog problem
git bisect good 2f7afc343d49eea0bf88ea5fc8cb3afc392356c3  # 02:09  G     12     0    1   1  of: property: Add device link support for power-domains and hwlocks
# first bad commit: [f4056e705b2ef7f123a188f6aee23ade70e7d793] of: unittest: add overlay gpio test to catch gpio hog problem
git bisect good 2f7afc343d49eea0bf88ea5fc8cb3afc392356c3  # 02:56  G     36     0    5   7  of: property: Add device link support for power-domains and hwlocks
# extra tests with debug options
# extra tests on head commit of robh/for-next
git bisect  bad 76897807dc79747161429c984528cf8c6670b328  # 10:08  B      0     2   18   0  dt-bindings: clock: Convert UniPhier clock to json-schema
# bad: [76897807dc79747161429c984528cf8c6670b328] dt-bindings: clock: Convert UniPhier clock to json-schema

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--=_5e5dbc98.3YZqMTP9XCyxGg3+TneaGg7mgLlGOJEy2LQ56W63KxRCveRS
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-vm-yocto-3:20200302224936:i386-randconfig-f003-20200301:5.6.0-rc1-00020-gf4056e705b2ef:1.gz"

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

--=_5e5dbc98.3YZqMTP9XCyxGg3+TneaGg7mgLlGOJEy2LQ56W63KxRCveRS
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-vm-yocto-31:20200303030207:i386-randconfig-f003-20200301:5.6.0-rc1-00019-g2f7afc343d49e:1.gz"

H4sICEq8XV4AA2RtZXNnLXlvY3RvLXZtLXlvY3RvLTMxOjIwMjAwMzAzMDMwMjA3OmkzODYt
cmFuZGNvbmZpZy1mMDAzLTIwMjAwMzAxOjUuNi4wLXJjMS0wMDAxOS1nMmY3YWZjMzQzZDQ5
ZToxALRba3PjNq/+/J5fwTP9kpzGDilREukZv3OcyzaerDdunG33vJ2MR9bFUSNLriRnk05/
/AGoi+lblGy3zqwvEvEABAEQALWBm8UvxEuTPI0DEiUkD4rVEi74wX/9RuBFu1S97snHKFk9
k6cgy6M0IVbX7tJO5rEO3GSyMzdCxw09k5s+lwE5epytotj/X8e0fGmGbuAEzjE5mnteg+B0
rS4lRxfBLHKrXx3r+Jj8wMhkNCbj28vL0fiO3K0CMnIzYhLKeszsmSY5n9wRgxp0W8JnYZ+G
y1UPvjjkw/gz+RrFMVnlAfnwZTL45XJ7/NnwZtJZZulT5Ac+WT685JHnxuR2MCILd9nbOzwQ
Bu2R3xbBgtBnuvXqbFyS4SwM74G/O4t3tPkqmAy9XbAQwbIgD7KnwH8XXLgrW/jtcGx7qjBL
v4R771SBMtgF+2bZwiBExelweOmb4Uq0Dbhvl47VGGs4w2zg9mtumUVJ8dgjfjBbzXskmicp
XJmTOJ3HwVMQo7cWcKG7TfgpLSIv6JFPX8jR5XPgrYqAXESKxzGgpkXgFeiDnpskaUFmAQkS
vOn3SJImnfHgkjwGWRLE/72NPBnhDInRFYADOkiKHeYXo2GP/Hw5+kwmhZv4buaT8Tk5ijin
H76QH8l4OPxyQpiU9vGJ0hdhXWaA9zNC+SllpwZlfBv06mUJ+o7yNANtoPgo6/Uvo+1xj0+L
jhenHmjtc466WuRZTvjMsrlPGQF56h8b4cMwN0i95YrQE6QlzJcwlp3gYizc7EXdU8M26PkG
/Uqxzr0HiCtpGMIywQcxuDCkYzLDIN6LFwe5jmCD8Io6T1cZrp0Gt3BzeKfP4dYLbjxPSyi8
zTyfGwEHZ5ydqFuRHwfTBO4JwSxJLcm4MEmi8xVU3pMi93rkolIrMQybdqUUZHT1JxqLF+Sg
9obGMAV37klp46ul74JtbXlObeKaaZN+/9+7TmOYkhk1VhYs0icdy11j7XcTg1MKio/dvJgu
w4T0gU7FFDV7N/Memsul++mUtl3uGOPBXY+cp0kYzVeZq9ziN9px7nvk1zNCfr0j5PN5B/6R
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
FjYcBKf3mxf8vgAx+Jf+Wn1/3jyd3nyW2tNvD88vkKSLl+vH83PvjHdnEAZc/Onh4WX18ISP
eXF/zcYPZ08bVuLvX/l1Pz8AnCRvzOb501bd2ZXao8+bT9+/oh7CgqH4vLnAZ7y6Jff4sJun
m6tbsPbzzQOf+eYZGOe31f3DPf9794AXhHW7/357e/KHk5OrR+oXcvoJ97/4iJf4CLHGK337
fv/18uXq+efLx6v7m+sLe/Khu+/VI352f+PTPP3P5dXtr1e/PV/qd/mMvq6/P36+etmsqVTw
gS7xoW9vL7thQCE6+QAWrW++3F/dbZ4v8PMRrH/5eY37/3z3/PXi4R5Vct8z3Pj54csLh+r3
x7eHub+7uewZcyG1Jx8eHh6f+79vH654bPkdGPDzheMNHu4eX15rcMvPT58+r+9u7h+eLq8f
vt+/XBR5Hwy1z+tbqOXbzS+b2wuggZMPN19x1eYStVJ58uH64f754XZz8fLyG3raXD3d/qZv
wJr/MKeWM61mcN1W7S9fry7Q4d0Venr69eTDp6er++tvF7c399//ylG2uf0o5dm3h+/o+cwZ
npAMZwlt//jnP//n5b/9+z/+6V8uPj7+/PWjNPoow5fHrOOGX26+nn3B9a/NPn69vj7LH92X
fPXl2gf/OdTN5sp8+lLK5ip+uS7Xnzz/U6korv3HX+7Y6d/O4hqo8ezp2p5hwNt69nXQg35m
4Ob187fvL58ffr0nU/tPcvny7Wnz/O0iGQ6z3/3+fyGtf/mH//6/363OdMytUKd//eXvUH3y
/xzc6EyLDAEA

--=_5e5dbc98.3YZqMTP9XCyxGg3+TneaGg7mgLlGOJEy2LQ56W63KxRCveRS
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-yocto-vm-yocto-3:20200302224936:i386-randconfig-f003-20200301:5.6.0-rc1-00020-gf4056e705b2ef:1"

#!/bin/bash

kernel=$1
initrd=yocto-i386-trinity.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/$initrd

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

--=_5e5dbc98.3YZqMTP9XCyxGg3+TneaGg7mgLlGOJEy2LQ56W63KxRCveRS
Content-Type: application/x-xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="65e5f40b639d0788611a2e18ae27cadbce7eef70:gcc-7:i386-randconfig-f003-20200301:EIP:device_links_driver_cleanup.xz"

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
MDXHjAAB70usqAUA8krFprHEZ/sCAAAAAARZWg==

--=_5e5dbc98.3YZqMTP9XCyxGg3+TneaGg7mgLlGOJEy2LQ56W63KxRCveRS
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.6.0-rc1-00020-gf4056e705b2ef"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.6.0-rc1 Kernel Configuration
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
CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED=y
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
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
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
CONFIG_UCLAMP_TASK=y
CONFIG_UCLAMP_BUCKETS_COUNT=5
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
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
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
# CONFIG_BOOT_CONFIG is not set
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
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
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
# CONFIG_EVENTFD is not set
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
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_SLUB_CPU_PARTIAL is not set
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
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
# CONFIG_X86_32_NON_STANDARD is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
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
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
CONFIG_MGEODEGX1=y
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
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
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
# CONFIG_X86_MCE_AMD is not set
# CONFIG_X86_ANCIENT_MCE is not set
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=m
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
CONFIG_ENERGY_MODEL=y
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
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
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
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=y
# CONFIG_X86_P4_CLOCKMOD is not set
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
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
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
# CONFIG_OLPC is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
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
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
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
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
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
# CONFIG_COMPAT_32BIT_TIME is not set
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
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_CYC_COMPLEXITY=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
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
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y

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
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=m
CONFIG_ZBUD=y
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
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
# CONFIG_NETLABEL is not set
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
# CONFIG_MPTCP_HMAC_TEST is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
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
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_DECNET=m
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=m
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
CONFIG_PHONET=m
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=y
CONFIG_MAC802154=y
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
# CONFIG_NET_SCH_HTB is not set
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=y
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_SKBPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=y
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
# CONFIG_DEFAULT_FQ_CODEL is not set
CONFIG_DEFAULT_SFQ=y
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="sfq"

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
CONFIG_NET_CLS_TCINDEX=y
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=m
# CONFIG_NET_CLS_U32 is not set
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
# CONFIG_NET_EMATCH_NBYTE is not set
CONFIG_NET_EMATCH_U32=y
CONFIG_NET_EMATCH_META=y
# CONFIG_NET_EMATCH_TEXT is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
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
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
# CONFIG_NET_MPLS_GSO is not set
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
# CONFIG_NET_NSH is not set
CONFIG_HSR=m
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
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

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
# CONFIG_BPQETHER is not set
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_YAM=m
# end of AX.25 network device drivers

# CONFIG_CAN is not set
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
CONFIG_BT_LEDS=y
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIBTSDIO=m
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
CONFIG_BT_MTKSDIO=m
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
CONFIG_CFG80211_CERTIFICATION_ONUS=y
# CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is not set
CONFIG_CFG80211_REG_CELLULAR_HINTS=y
# CONFIG_CFG80211_REG_RELAX_NO_IR is not set
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_CRDA_SUPPORT is not set
CONFIG_CFG80211_WEXT=y
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=m
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
# CONFIG_NFC_NCI is not set
CONFIG_NFC_HCI=m
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_MEI_PHY=m
# CONFIG_NFC_PN544_MEI is not set
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_I2C=m
# CONFIG_NFC_MICROREAD_MEI is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_FAILOVER=m
# CONFIG_ETHTOOL_NETLINK is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
# CONFIG_EISA_PCI_EISA is not set
CONFIG_EISA_VIRTUAL_ROOT=y
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
CONFIG_HOTPLUG_PCI_IBM=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_PCI_FTPCI100=y
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCIE_INTEL_GW=y
CONFIG_PCI_MESON=y
# end of DesignWare PCI Core Support

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

# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DMA_ENGINE=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=m
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=m
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_TSI568=m
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=m
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
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
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=m
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
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

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
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_CS5535_MFGPT=m
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
CONFIG_CS5535_CLOCK_EVENT_SRC=m
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m

#
# Altera FPGA firmware download module (requires I2C)
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=m
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
CONFIG_HABANA_AI=m
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
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
CONFIG_EQUALIZER=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
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
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=y
# CONFIG_ARCNET_1051 is not set
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
# CONFIG_ARCNET_COM90xx is not set
CONFIG_ARCNET_COM90xxIO=m
# CONFIG_ARCNET_RIM_I is not set
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
CONFIG_ATM_ENI_TUNE_BURST=y
CONFIG_ATM_ENI_BURST_TX_16W=y
CONFIG_ATM_ENI_BURST_TX_8W=y
# CONFIG_ATM_ENI_BURST_TX_4W is not set
CONFIG_ATM_ENI_BURST_TX_2W=y
CONFIG_ATM_ENI_BURST_RX_16W=y
CONFIG_ATM_ENI_BURST_RX_8W=y
# CONFIG_ATM_ENI_BURST_RX_4W is not set
# CONFIG_ATM_ENI_BURST_RX_2W is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
# CONFIG_ATM_NICSTAR is not set
CONFIG_ATM_IDT77252=y
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=y
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=y
# CONFIG_ATM_IA_DEBUG is not set
# CONFIG_ATM_FORE200E is not set
CONFIG_ATM_HE=y
# CONFIG_ATM_HE_USE_SUNI is not set
# CONFIG_ATM_SOLOS is not set
# CONFIG_CAIF_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=m
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=y
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_ALTERA_TSE=m
# CONFIG_NET_VENDOR_AMAZON is not set
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=y
CONFIG_PCNET32=y
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=y
CONFIG_MACB_USE_HWSTAMP=y
CONFIG_MACB_PCI=y
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=m
CONFIG_CHELSIO_T1_1G=y
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
CONFIG_CHELSIO_T4VF=y
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_CS89x0=y
CONFIG_CS89x0_PLATFORM=y
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
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
CONFIG_JME=y
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8842=m
CONFIG_KS8851_MLL=y
CONFIG_KSZ884X_PCI=y
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
CONFIG_FEALNX=y
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=y
CONFIG_VXGE=m
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=m
# CONFIG_NET_VENDOR_8390 is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
CONFIG_HAMACHI=m
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_NET_VENDOR_QLOGIC is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCOM_EMAC=m
CONFIG_RMNET=m
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_8139CP=y
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=m
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MCDI_MON=y
# CONFIG_SFC_SRIOV is not set
# CONFIG_SFC_MCDI_LOGGING is not set
CONFIG_SFC_FALCON=m
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NIU=y
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=y
CONFIG_DWC_XLGMAC_PCI=y
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
CONFIG_TI_CPSW_PHY_SEL=y
CONFIG_TLAN=y
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=y
CONFIG_MDIO_BUS_MUX_GPIO=y
CONFIG_MDIO_BUS_MUX_MMIOREG=y
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
CONFIG_MDIO_GPIO=y
CONFIG_MDIO_HISI_FEMAC=y
CONFIG_MDIO_I2C=m
CONFIG_MDIO_MSCC_MIIM=y
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_SFP=m
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
CONFIG_BCM7XXX_PHY=y
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM84881_PHY is not set
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=m
CONFIG_DP83822_PHY=m
CONFIG_DP83TC811_PHY=m
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_DP83869_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=m
CONFIG_MARVELL_10G_PHY=m
# CONFIG_MICREL_PHY is not set
CONFIG_MICROCHIP_PHY=m
CONFIG_MICROCHIP_T1_PHY=m
CONFIG_MICROSEMI_PHY=y
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_AT803X_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
# CONFIG_VITESSE_PHY is not set
CONFIG_XILINX_GMII2RGMII=m
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=y
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

# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=y
CONFIG_IEEE802154_FAKELB=y
CONFIG_IEEE802154_HWSIM=m
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_MISDN=y
CONFIG_MISDN_DSP=y
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
# CONFIG_MISDN_HFCPCI is not set
CONFIG_MISDN_HFCMULTI=y
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
# CONFIG_MISDN_INFINEON is not set
# CONFIG_MISDN_W6692 is not set
# CONFIG_MISDN_NETJET is not set
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=m
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=m
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=m
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=m
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_OMAP4=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CROS_EC=m
CONFIG_KEYBOARD_CAP11XX=m
# CONFIG_KEYBOARD_BCM is not set
CONFIG_KEYBOARD_MTK_PMIC=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
CONFIG_MOUSE_PS2_SYNAPTICS=y
# CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
CONFIG_MOUSE_PS2_CYPRESS=y
# CONFIG_MOUSE_PS2_LIFEBOOK is not set
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
# CONFIG_JOYSTICK_ADI is not set
CONFIG_JOYSTICK_COBRA=m
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=m
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_JOYSTICK_FSIA6B=m
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_AD7879=m
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
CONFIG_TOUCHSCREEN_ADC=m
CONFIG_TOUCHSCREEN_AR1021_I2C=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_BU21029=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_ILI210X=m
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=m
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=m
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=m
# CONFIG_INPUT_MSM_VIBRATOR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=m
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_GPIO_VIBRA=m
CONFIG_INPUT_WISTRON_BTNS=m
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_RETU_PWRBUTTON=m
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PCF50633_PMU=m
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=m
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_RK805_PWRKEY=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=m
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
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
# CONFIG_DEVKMEM is not set

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
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
# CONFIG_IPMI_WATCHDOG is not set
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_GEODE is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=m
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=m
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_NVIDIA_GPU=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=m
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PXA=m
CONFIG_I2C_PXA_PCI=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_FSI=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
# CONFIG_CDNS_I3C_MASTER is not set
CONFIG_DW_I3C_MASTER=m
# CONFIG_SPI is not set
CONFIG_SPMI=m
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

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
CONFIG_PTP_1588_CLOCK_PCH=y
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=m
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_SAMA5D2_PIOBU=m
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=m
# CONFIG_GPIO_104_IDI_48 is not set
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_GPIO_MM is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
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
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_CS5535=m
CONFIG_GPIO_JANZ_TTL=m
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=m
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCH=m
CONFIG_GPIO_PCI_IDIO_16=m
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=m
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=m
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS250X=m
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
# CONFIG_POWER_RESET_MT6323 is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=m
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_LEGO_EV3=m
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9150=m
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=m
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65217=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=m
CONFIG_CHARGER_UCS1002=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AS370=y
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31730=m
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_BEL_PFE=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR38064=m
CONFIG_SENSORS_IRPS5401=m
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_PWM_FAN=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set

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
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CPU_THERMAL is not set
# CONFIG_CLOCK_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
# CONFIG_QORIQ_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
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
CONFIG_SOFT_WATCHDOG=m
CONFIG_GPIO_WATCHDOG=m
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
CONFIG_XILINX_WATCHDOG=m
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_MLX_WDT=m
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=y
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
CONFIG_GEODE_WDT=m
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=m
# CONFIG_ITCO_VENDOR_SUPPORT is not set
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=m
# CONFIG_HPWDT_NMI_DECODING is not set
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=y
CONFIG_SCx200_WDT=m
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=y
CONFIG_RDC321X_WDT=y
# CONFIG_60XX_WDT is not set
CONFIG_SBC8360_WDT=y
# CONFIG_SBC7240_WDT is not set
CONFIG_CPU5_WDT=m
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=m
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=m
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC_DEV=m
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=m
CONFIG_HTC_PASIC3=m
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=m
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RK808=m
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
CONFIG_ABX500_CORE=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_TI_LMU=m
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=m
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8994=m
CONFIG_MFD_STMFX=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_ACT8945A is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP873X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MCP16502=m
CONFIG_REGULATOR_MP8859=m
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PFUZE100=m
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM8994=m
CONFIG_CEC_CORE=m
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=m
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_RCMM_DECODER=m
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
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
# CONFIG_AGP_SIS is not set
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
CONFIG_AGP_EFFICEON=m
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
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
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=m
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
# CONFIG_DRM_PANEL_LVDS is not set
# CONFIG_DRM_PANEL_SIMPLE is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
CONFIG_DRM_PANEL_ROCKTECH_JH057N00900=m
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
CONFIG_DRM_PANEL_SONY_ACX424AKP=m
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
CONFIG_DRM_PANEL_XINPENG_XPP055C272=m
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_DUMB_VGA_DAC is not set
CONFIG_DRM_LVDS_CODEC=m
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
# CONFIG_DRM_SII9234 is not set
CONFIG_DRM_THINE_THC63LVD1024=m
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=m
# CONFIG_DRM_TI_TFP410 is not set
CONFIG_DRM_TI_SN65DSI86=m
CONFIG_DRM_ANALOGIX_ANX6345=m
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
CONFIG_DRM_I2C_ADV7511=m
# CONFIG_DRM_I2C_ADV7533 is not set
CONFIG_DRM_I2C_ADV7511_CEC=y
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=m
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_ARCPGU=m
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=m
CONFIG_DRM_VBOXVIDEO=m
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_LIB_RANDOM=y

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
# CONFIG_FB_FOREIGN_ENDIAN is not set
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
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y
CONFIG_FB_I810_I2C=y
CONFIG_FB_LE80578=m
# CONFIG_FB_CARILLO_RANCH is not set
CONFIG_FB_INTEL=m
# CONFIG_FB_INTEL_DEBUG is not set
# CONFIG_FB_INTEL_I2C is not set
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=m
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
CONFIG_FB_VIA_X_COMPATIBILITY=y
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=m
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=m
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
CONFIG_FB_CARMINE=m
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_GEODE=y
# CONFIG_FB_GEODE_LX is not set
CONFIG_FB_GEODE_GX=m
# CONFIG_FB_GEODE_GX1 is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_SSD1307=m
CONFIG_FB_SM712=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_CARILLO_RANCH is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP8860=m
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_OT200=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_TPS65217=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=m
# CONFIG_HID_GFRM is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
CONFIG_HID_ORTEK=m
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=m
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=m
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID=m
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
CONFIG_PWRSEQ_SIMPLE=y
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
CONFIG_MMC_SDHCI_PCI=m
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_ASPEED=m
# CONFIG_MMC_SDHCI_OF_AT91 is not set
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
# CONFIG_MMC_SDHCI_CADENCE is not set
CONFIG_MMC_SDHCI_F_SDH30=m
CONFIG_MMC_SDHCI_MILBEAUT=m
CONFIG_MMC_WBSD=y
CONFIG_MMC_TIFM_SD=y
# CONFIG_MMC_GOLDFISH is not set
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_CQHCI=y
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MMC_SDHCI_OMAP=m
# CONFIG_MMC_SDHCI_AM654 is not set
CONFIG_MMC_SDHCI_EXTERNAL_DMA=y
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_NET48XX=m
CONFIG_LEDS_WRAP=m
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_CLEVO_MAIL=m
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_PWM=m
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m
CONFIG_LEDS_MENF21BMC=m
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=m
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=m
CONFIG_LEDS_LM36274=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=m
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=m
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_AMD76X=m
CONFIG_EDAC_E7XXX=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82875P=y
CONFIG_EDAC_I82975X=y
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=y
CONFIG_EDAC_IE31200=y
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I82860=y
# CONFIG_EDAC_R82600 is not set
CONFIG_EDAC_I5000=y
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=y
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=y
CONFIG_PCH_DMA=m
CONFIG_PLX_DMA=m
CONFIG_TIMB_DMA=y
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_DW_EDMA=y
CONFIG_DW_EDMA_PCIE=y
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=m

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
CONFIG_DMABUF_SELFTESTS=y
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=m
# CONFIG_HT16K33 is not set
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_CHARLCD=y
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=m
# CONFIG_UIO_PRUSS is not set
CONFIG_UIO_MF624=m
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=m
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_STAGING=y
# CONFIG_COMEDI is not set

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
CONFIG_AD7150=m
# CONFIG_AD7746 is not set
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
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_STAGING_BOARD is not set
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_GOLDFISH_AUDIO=y
CONFIG_GS_FPGABOOT=y
CONFIG_UNISYSSPAR=y
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_WILC1000_SDIO is not set
CONFIG_MOST=m
CONFIG_MOST_CDEV=m
CONFIG_MOST_NET=m
CONFIG_MOST_DIM2=m
CONFIG_MOST_I2C=m
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS_AUDIO is not set
# CONFIG_GREYBUS_BOOTROM is not set
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=y
# CONFIG_GREYBUS_LOOPBACK is not set
CONFIG_GREYBUS_POWER=y
# CONFIG_GREYBUS_RAW is not set
CONFIG_GREYBUS_VIBRATOR=m
# CONFIG_GREYBUS_BRIDGED_PHY is not set

#
# Gasket devices
#
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
# CONFIG_FIELDBUS_DEV is not set
CONFIG_KPC2000=y
CONFIG_KPC2000_CORE=m
CONFIG_KPC2000_I2C=m
# CONFIG_KPC2000_DMA is not set
CONFIG_UWB=y
CONFIG_UWB_WHCI=m
# CONFIG_STAGING_EXFAT_FS is not set
CONFIG_QLGE=y
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_MFD_CROS_EC=m
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=m
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_RPMSG is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_CROS_EC_CHARDEV is not set
# CONFIG_CROS_EC_LIGHTBAR is not set
CONFIG_CROS_EC_VBC=m
CONFIG_CROS_EC_DEBUGFS=m
CONFIG_CROS_EC_SENSORHUB=m
CONFIG_CROS_EC_SYSFS=m
CONFIG_CROS_USBPD_LOGGER=m
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=m
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_CLK_HSDK=y
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_RK808=m
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_SI514=m
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_SI570=m
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=m
CONFIG_COMMON_CLK_CS2000_CP=m
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_COMMON_CLK_VC5=m
CONFIG_COMMON_CLK_FIXED_MMIO=y
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_MAILBOX_TEST=y
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
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
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

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
CONFIG_ADXL372=m
CONFIG_ADXL372_I2C=m
# CONFIG_BMA180 is not set
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_DA280=m
CONFIG_DA311=m
CONFIG_DMARD06=m
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
# CONFIG_HID_SENSOR_ACCEL_3D is not set
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=m
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
CONFIG_AD7291=m
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD799X=m
CONFIG_CC10001_ADC=m
# CONFIG_DA9150_GPADC is not set
CONFIG_ENVELOPE_DETECTOR=m
CONFIG_HX711=m
# CONFIG_INA2XX_ADC is not set
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2497=m
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP3422=m
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_QCOM_VADC_COMMON=m
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=m
CONFIG_QCOM_SPMI_ADC5=m
CONFIG_SD_ADC_MODULATOR=m
CONFIG_STX104=m
CONFIG_TI_ADC081C=m
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_AM335X_ADC is not set
# CONFIG_VF610_ADC is not set
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
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_BME680=m
CONFIG_BME680_I2C=m
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
CONFIG_SENSIRION_SGP30=m
# CONFIG_SPS30 is not set
CONFIG_VZ89X=m
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

CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=m
CONFIG_AD5446=m
# CONFIG_AD5593R is not set
# CONFIG_AD5696_I2C is not set
CONFIG_CIO_DAC=m
CONFIG_DPOT_DAC=m
CONFIG_DS4424=m
CONFIG_M62332=m
# CONFIG_MAX517 is not set
CONFIG_MAX5821=m
CONFIG_MCP4725=m
CONFIG_TI_DAC5571=m
CONFIG_VF610_DAC=m
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
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
CONFIG_HTU21=m
# CONFIG_SI7005 is not set
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
# CONFIG_FXOS8700_I2C is not set
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_ADUX1020=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
# CONFIG_APDS9960 is not set
CONFIG_BH1750=m
CONFIG_BH1780=m
CONFIG_CM32181=m
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM3605=m
CONFIG_CM36651=m
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
CONFIG_GP2AP020A00F=m
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=m
CONFIG_RPR0521=m
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=m
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
# CONFIG_MAX44009 is not set
CONFIG_NOA1305=m
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
CONFIG_SI1133=m
CONFIG_SI1145=m
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
CONFIG_US5182D=m
# CONFIG_VCNL4000 is not set
CONFIG_VCNL4035=m
CONFIG_VEML6030=m
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=m
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
CONFIG_IIO_HRTIMER_TRIGGER=m
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Digital potentiometers
#
CONFIG_AD5272=m
CONFIG_DS1803=m
# CONFIG_MAX5432 is not set
# CONFIG_MCP4018 is not set
CONFIG_MCP4531=m
CONFIG_TPL0102=m
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
CONFIG_DLHL60D=m
CONFIG_DPS310=m
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL3115=m
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
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
# CONFIG_MB1232 is not set
CONFIG_PING=m
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
CONFIG_SX9500=m
CONFIG_SRF08=m
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=m
CONFIG_MLX90632=m
CONFIG_TMP006=m
CONFIG_TMP007=m
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# end of Temperature sensors

CONFIG_NTB=m
CONFIG_NTB_MSI=y
CONFIG_NTB_IDT=m
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
# CONFIG_NTB_PERF is not set
CONFIG_NTB_MSI_TEST=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=m
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_LP3943 is not set
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=m

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=m
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_CADENCE_DP=y
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
CONFIG_PHY_MIXEL_MIPI_DPHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=m

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
# CONFIG_FPGA_BRIDGE is not set
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
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_GPIO is not set
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=m
CONFIG_FTM_QUADDEC=y
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
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_XINO_AUTO=y
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
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
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
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
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
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
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=m
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=m
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=m
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_DEBUG=y
# CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS is not set
# CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
# CONFIG_INTEGRITY_ASYMMETRIC_KEYS is not set
# CONFIG_INTEGRITY_AUDIT is not set
# CONFIG_IMA is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,tomoyo"

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
# CONFIG_STACKLEAK_METRICS is not set
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
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
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=m
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
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_ADIANTUM is not set
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
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
# CONFIG_CRYPTO_MD5 is not set
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=y

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
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
# CONFIG_TPM_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
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
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=m
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
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
CONFIG_ARCH_STACKWALK=y
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
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set
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
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
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
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_DEBUG_ON=y
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

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
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
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
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
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
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
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
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_UPROBE_EVENTS is not set
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
CONFIG_KPROBE_EVENT_GEN_TEST=m
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
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=m
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_TEST is not set
# CONFIG_KUNIT_EXAMPLE_TEST is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
CONFIG_REED_SOLOMON_TEST=y
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
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
CONFIG_SYSCTL_KUNIT_TEST=y
# CONFIG_LIST_KUNIT_TEST is not set
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--=_5e5dbc98.3YZqMTP9XCyxGg3+TneaGg7mgLlGOJEy2LQ56W63KxRCveRS
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.6.0-rc1-00020-gf4056e705b2ef"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.6.0-rc1 Kernel Configuration
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
CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED=y
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
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
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
CONFIG_UCLAMP_TASK=y
CONFIG_UCLAMP_BUCKETS_COUNT=5
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
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
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
# CONFIG_BOOT_CONFIG is not set
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
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
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
# CONFIG_EVENTFD is not set
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
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_SLUB_CPU_PARTIAL is not set
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
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
# CONFIG_X86_32_NON_STANDARD is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
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
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
CONFIG_MGEODEGX1=y
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
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
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
# CONFIG_X86_MCE_AMD is not set
# CONFIG_X86_ANCIENT_MCE is not set
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=m
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
CONFIG_ENERGY_MODEL=y
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
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
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
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=y
# CONFIG_X86_P4_CLOCKMOD is not set
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
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
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
# CONFIG_OLPC is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
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
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
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
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
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
# CONFIG_COMPAT_32BIT_TIME is not set
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
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_CYC_COMPLEXITY=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
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
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y

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
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=m
CONFIG_ZBUD=y
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
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
# CONFIG_NETLABEL is not set
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
# CONFIG_MPTCP_HMAC_TEST is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
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
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_DECNET=m
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=m
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
CONFIG_PHONET=m
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=y
CONFIG_MAC802154=y
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
# CONFIG_NET_SCH_HTB is not set
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=y
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_SKBPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=y
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
# CONFIG_DEFAULT_FQ_CODEL is not set
CONFIG_DEFAULT_SFQ=y
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="sfq"

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
CONFIG_NET_CLS_TCINDEX=y
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=m
# CONFIG_NET_CLS_U32 is not set
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
# CONFIG_NET_EMATCH_NBYTE is not set
CONFIG_NET_EMATCH_U32=y
CONFIG_NET_EMATCH_META=y
# CONFIG_NET_EMATCH_TEXT is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
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
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
# CONFIG_NET_MPLS_GSO is not set
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
# CONFIG_NET_NSH is not set
CONFIG_HSR=m
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
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

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
# CONFIG_BPQETHER is not set
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_YAM=m
# end of AX.25 network device drivers

# CONFIG_CAN is not set
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
CONFIG_BT_LEDS=y
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIBTSDIO=m
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
CONFIG_BT_MTKSDIO=m
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
CONFIG_CFG80211_CERTIFICATION_ONUS=y
# CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is not set
CONFIG_CFG80211_REG_CELLULAR_HINTS=y
# CONFIG_CFG80211_REG_RELAX_NO_IR is not set
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_CRDA_SUPPORT is not set
CONFIG_CFG80211_WEXT=y
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=m
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
# CONFIG_NFC_NCI is not set
CONFIG_NFC_HCI=m
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_MEI_PHY=m
# CONFIG_NFC_PN544_MEI is not set
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_I2C=m
# CONFIG_NFC_MICROREAD_MEI is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_FAILOVER=m
# CONFIG_ETHTOOL_NETLINK is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
# CONFIG_EISA_PCI_EISA is not set
CONFIG_EISA_VIRTUAL_ROOT=y
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
CONFIG_HOTPLUG_PCI_IBM=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_PCI_FTPCI100=y
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCIE_INTEL_GW=y
CONFIG_PCI_MESON=y
# end of DesignWare PCI Core Support

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

# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DMA_ENGINE=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=m
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=m
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_TSI568=m
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=m
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
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
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=m
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
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

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
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_CS5535_MFGPT=m
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
CONFIG_CS5535_CLOCK_EVENT_SRC=m
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m

#
# Altera FPGA firmware download module (requires I2C)
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=m
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
CONFIG_HABANA_AI=m
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
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
CONFIG_EQUALIZER=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
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
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=y
# CONFIG_ARCNET_1051 is not set
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
# CONFIG_ARCNET_COM90xx is not set
CONFIG_ARCNET_COM90xxIO=m
# CONFIG_ARCNET_RIM_I is not set
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
CONFIG_ATM_ENI_TUNE_BURST=y
CONFIG_ATM_ENI_BURST_TX_16W=y
CONFIG_ATM_ENI_BURST_TX_8W=y
# CONFIG_ATM_ENI_BURST_TX_4W is not set
CONFIG_ATM_ENI_BURST_TX_2W=y
CONFIG_ATM_ENI_BURST_RX_16W=y
CONFIG_ATM_ENI_BURST_RX_8W=y
# CONFIG_ATM_ENI_BURST_RX_4W is not set
# CONFIG_ATM_ENI_BURST_RX_2W is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
# CONFIG_ATM_NICSTAR is not set
CONFIG_ATM_IDT77252=y
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=y
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=y
# CONFIG_ATM_IA_DEBUG is not set
# CONFIG_ATM_FORE200E is not set
CONFIG_ATM_HE=y
# CONFIG_ATM_HE_USE_SUNI is not set
# CONFIG_ATM_SOLOS is not set
# CONFIG_CAIF_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=m
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=y
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_ALTERA_TSE=m
# CONFIG_NET_VENDOR_AMAZON is not set
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=y
CONFIG_PCNET32=y
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=y
CONFIG_MACB_USE_HWSTAMP=y
CONFIG_MACB_PCI=y
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=m
CONFIG_CHELSIO_T1_1G=y
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
CONFIG_CHELSIO_T4VF=y
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_CS89x0=y
CONFIG_CS89x0_PLATFORM=y
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
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
CONFIG_JME=y
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8842=m
CONFIG_KS8851_MLL=y
CONFIG_KSZ884X_PCI=y
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
CONFIG_FEALNX=y
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=y
CONFIG_VXGE=m
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=m
# CONFIG_NET_VENDOR_8390 is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
CONFIG_HAMACHI=m
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_NET_VENDOR_QLOGIC is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCOM_EMAC=m
CONFIG_RMNET=m
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_8139CP=y
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=m
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MCDI_MON=y
# CONFIG_SFC_SRIOV is not set
# CONFIG_SFC_MCDI_LOGGING is not set
CONFIG_SFC_FALCON=m
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NIU=y
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=y
CONFIG_DWC_XLGMAC_PCI=y
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
CONFIG_TI_CPSW_PHY_SEL=y
CONFIG_TLAN=y
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=y
CONFIG_MDIO_BUS_MUX_GPIO=y
CONFIG_MDIO_BUS_MUX_MMIOREG=y
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
CONFIG_MDIO_GPIO=y
CONFIG_MDIO_HISI_FEMAC=y
CONFIG_MDIO_I2C=m
CONFIG_MDIO_MSCC_MIIM=y
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_SFP=m
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
CONFIG_BCM7XXX_PHY=y
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM84881_PHY is not set
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=m
CONFIG_DP83822_PHY=m
CONFIG_DP83TC811_PHY=m
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_DP83869_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=m
CONFIG_MARVELL_10G_PHY=m
# CONFIG_MICREL_PHY is not set
CONFIG_MICROCHIP_PHY=m
CONFIG_MICROCHIP_T1_PHY=m
CONFIG_MICROSEMI_PHY=y
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_AT803X_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
# CONFIG_VITESSE_PHY is not set
CONFIG_XILINX_GMII2RGMII=m
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=y
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

# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=y
CONFIG_IEEE802154_FAKELB=y
CONFIG_IEEE802154_HWSIM=m
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_MISDN=y
CONFIG_MISDN_DSP=y
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
# CONFIG_MISDN_HFCPCI is not set
CONFIG_MISDN_HFCMULTI=y
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
# CONFIG_MISDN_INFINEON is not set
# CONFIG_MISDN_W6692 is not set
# CONFIG_MISDN_NETJET is not set
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=m
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=m
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=m
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=m
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_OMAP4=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CROS_EC=m
CONFIG_KEYBOARD_CAP11XX=m
# CONFIG_KEYBOARD_BCM is not set
CONFIG_KEYBOARD_MTK_PMIC=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
CONFIG_MOUSE_PS2_SYNAPTICS=y
# CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
CONFIG_MOUSE_PS2_CYPRESS=y
# CONFIG_MOUSE_PS2_LIFEBOOK is not set
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
# CONFIG_JOYSTICK_ADI is not set
CONFIG_JOYSTICK_COBRA=m
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=m
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_JOYSTICK_FSIA6B=m
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_AD7879=m
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
CONFIG_TOUCHSCREEN_ADC=m
CONFIG_TOUCHSCREEN_AR1021_I2C=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_BU21029=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_ILI210X=m
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=m
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=m
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=m
# CONFIG_INPUT_MSM_VIBRATOR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=m
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_GPIO_VIBRA=m
CONFIG_INPUT_WISTRON_BTNS=m
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_RETU_PWRBUTTON=m
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PCF50633_PMU=m
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=m
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_RK805_PWRKEY=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=m
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
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
# CONFIG_DEVKMEM is not set

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
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
# CONFIG_IPMI_WATCHDOG is not set
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_GEODE is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=m
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=m
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_NVIDIA_GPU=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=m
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PXA=m
CONFIG_I2C_PXA_PCI=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_FSI=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
# CONFIG_CDNS_I3C_MASTER is not set
CONFIG_DW_I3C_MASTER=m
# CONFIG_SPI is not set
CONFIG_SPMI=m
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

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
CONFIG_PTP_1588_CLOCK_PCH=y
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=m
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_SAMA5D2_PIOBU=m
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=m
# CONFIG_GPIO_104_IDI_48 is not set
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_GPIO_MM is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
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
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_CS5535=m
CONFIG_GPIO_JANZ_TTL=m
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=m
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCH=m
CONFIG_GPIO_PCI_IDIO_16=m
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=m
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=m
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS250X=m
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
# CONFIG_POWER_RESET_MT6323 is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=m
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_LEGO_EV3=m
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9150=m
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=m
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65217=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=m
CONFIG_CHARGER_UCS1002=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AS370=y
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31730=m
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_BEL_PFE=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR38064=m
CONFIG_SENSORS_IRPS5401=m
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_PWM_FAN=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set

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
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CPU_THERMAL is not set
# CONFIG_CLOCK_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
# CONFIG_QORIQ_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
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
CONFIG_SOFT_WATCHDOG=m
CONFIG_GPIO_WATCHDOG=m
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
CONFIG_XILINX_WATCHDOG=m
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_MLX_WDT=m
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=y
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
CONFIG_GEODE_WDT=m
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=m
# CONFIG_ITCO_VENDOR_SUPPORT is not set
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=m
# CONFIG_HPWDT_NMI_DECODING is not set
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=y
CONFIG_SCx200_WDT=m
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=y
CONFIG_RDC321X_WDT=y
# CONFIG_60XX_WDT is not set
CONFIG_SBC8360_WDT=y
# CONFIG_SBC7240_WDT is not set
CONFIG_CPU5_WDT=m
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=m
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=m
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC_DEV=m
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=m
CONFIG_HTC_PASIC3=m
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=m
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RK808=m
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
CONFIG_ABX500_CORE=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_TI_LMU=m
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=m
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8994=m
CONFIG_MFD_STMFX=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_ACT8945A is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP873X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MCP16502=m
CONFIG_REGULATOR_MP8859=m
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PFUZE100=m
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM8994=m
CONFIG_CEC_CORE=m
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=m
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_RCMM_DECODER=m
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
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
# CONFIG_AGP_SIS is not set
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
CONFIG_AGP_EFFICEON=m
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
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
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=m
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
# CONFIG_DRM_PANEL_LVDS is not set
# CONFIG_DRM_PANEL_SIMPLE is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
CONFIG_DRM_PANEL_ROCKTECH_JH057N00900=m
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
CONFIG_DRM_PANEL_SONY_ACX424AKP=m
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
CONFIG_DRM_PANEL_XINPENG_XPP055C272=m
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_DUMB_VGA_DAC is not set
CONFIG_DRM_LVDS_CODEC=m
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
# CONFIG_DRM_SII9234 is not set
CONFIG_DRM_THINE_THC63LVD1024=m
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=m
# CONFIG_DRM_TI_TFP410 is not set
CONFIG_DRM_TI_SN65DSI86=m
CONFIG_DRM_ANALOGIX_ANX6345=m
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
CONFIG_DRM_I2C_ADV7511=m
# CONFIG_DRM_I2C_ADV7533 is not set
CONFIG_DRM_I2C_ADV7511_CEC=y
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=m
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_ARCPGU=m
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=m
CONFIG_DRM_VBOXVIDEO=m
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_LIB_RANDOM=y

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
# CONFIG_FB_FOREIGN_ENDIAN is not set
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
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y
CONFIG_FB_I810_I2C=y
CONFIG_FB_LE80578=m
# CONFIG_FB_CARILLO_RANCH is not set
CONFIG_FB_INTEL=m
# CONFIG_FB_INTEL_DEBUG is not set
# CONFIG_FB_INTEL_I2C is not set
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=m
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
CONFIG_FB_VIA_X_COMPATIBILITY=y
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=m
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=m
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
CONFIG_FB_CARMINE=m
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_GEODE=y
# CONFIG_FB_GEODE_LX is not set
CONFIG_FB_GEODE_GX=m
# CONFIG_FB_GEODE_GX1 is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_SSD1307=m
CONFIG_FB_SM712=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_CARILLO_RANCH is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP8860=m
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_OT200=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_TPS65217=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=m
# CONFIG_HID_GFRM is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
CONFIG_HID_ORTEK=m
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=m
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=m
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID=m
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
CONFIG_PWRSEQ_SIMPLE=y
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
CONFIG_MMC_SDHCI_PCI=m
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_ASPEED=m
# CONFIG_MMC_SDHCI_OF_AT91 is not set
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
# CONFIG_MMC_SDHCI_CADENCE is not set
CONFIG_MMC_SDHCI_F_SDH30=m
CONFIG_MMC_SDHCI_MILBEAUT=m
CONFIG_MMC_WBSD=y
CONFIG_MMC_TIFM_SD=y
# CONFIG_MMC_GOLDFISH is not set
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_CQHCI=y
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MMC_SDHCI_OMAP=m
# CONFIG_MMC_SDHCI_AM654 is not set
CONFIG_MMC_SDHCI_EXTERNAL_DMA=y
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_NET48XX=m
CONFIG_LEDS_WRAP=m
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_CLEVO_MAIL=m
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_PWM=m
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m
CONFIG_LEDS_MENF21BMC=m
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=m
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=m
CONFIG_LEDS_LM36274=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=m
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=m
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_AMD76X=m
CONFIG_EDAC_E7XXX=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82875P=y
CONFIG_EDAC_I82975X=y
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=y
CONFIG_EDAC_IE31200=y
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I82860=y
# CONFIG_EDAC_R82600 is not set
CONFIG_EDAC_I5000=y
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=y
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=y
CONFIG_PCH_DMA=m
CONFIG_PLX_DMA=m
CONFIG_TIMB_DMA=y
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_DW_EDMA=y
CONFIG_DW_EDMA_PCIE=y
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=m

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
CONFIG_DMABUF_SELFTESTS=y
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=m
# CONFIG_HT16K33 is not set
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_CHARLCD=y
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=m
# CONFIG_UIO_PRUSS is not set
CONFIG_UIO_MF624=m
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=m
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_STAGING=y
# CONFIG_COMEDI is not set

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
CONFIG_AD7150=m
# CONFIG_AD7746 is not set
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
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_STAGING_BOARD is not set
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_GOLDFISH_AUDIO=y
CONFIG_GS_FPGABOOT=y
CONFIG_UNISYSSPAR=y
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_WILC1000_SDIO is not set
CONFIG_MOST=m
CONFIG_MOST_CDEV=m
CONFIG_MOST_NET=m
CONFIG_MOST_DIM2=m
CONFIG_MOST_I2C=m
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS_AUDIO is not set
# CONFIG_GREYBUS_BOOTROM is not set
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=y
# CONFIG_GREYBUS_LOOPBACK is not set
CONFIG_GREYBUS_POWER=y
# CONFIG_GREYBUS_RAW is not set
CONFIG_GREYBUS_VIBRATOR=m
# CONFIG_GREYBUS_BRIDGED_PHY is not set

#
# Gasket devices
#
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
# CONFIG_FIELDBUS_DEV is not set
CONFIG_KPC2000=y
CONFIG_KPC2000_CORE=m
CONFIG_KPC2000_I2C=m
# CONFIG_KPC2000_DMA is not set
CONFIG_UWB=y
CONFIG_UWB_WHCI=m
# CONFIG_STAGING_EXFAT_FS is not set
CONFIG_QLGE=y
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_MFD_CROS_EC=m
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=m
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_RPMSG is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_CROS_EC_CHARDEV is not set
# CONFIG_CROS_EC_LIGHTBAR is not set
CONFIG_CROS_EC_VBC=m
CONFIG_CROS_EC_DEBUGFS=m
CONFIG_CROS_EC_SENSORHUB=m
CONFIG_CROS_EC_SYSFS=m
CONFIG_CROS_USBPD_LOGGER=m
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=m
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_CLK_HSDK=y
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_RK808=m
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_SI514=m
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_SI570=m
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=m
CONFIG_COMMON_CLK_CS2000_CP=m
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_COMMON_CLK_VC5=m
CONFIG_COMMON_CLK_FIXED_MMIO=y
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_MAILBOX_TEST=y
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
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
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

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
CONFIG_ADXL372=m
CONFIG_ADXL372_I2C=m
# CONFIG_BMA180 is not set
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_DA280=m
CONFIG_DA311=m
CONFIG_DMARD06=m
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
# CONFIG_HID_SENSOR_ACCEL_3D is not set
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=m
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
CONFIG_AD7291=m
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD799X=m
CONFIG_CC10001_ADC=m
# CONFIG_DA9150_GPADC is not set
CONFIG_ENVELOPE_DETECTOR=m
CONFIG_HX711=m
# CONFIG_INA2XX_ADC is not set
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2497=m
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP3422=m
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_QCOM_VADC_COMMON=m
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=m
CONFIG_QCOM_SPMI_ADC5=m
CONFIG_SD_ADC_MODULATOR=m
CONFIG_STX104=m
CONFIG_TI_ADC081C=m
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_AM335X_ADC is not set
# CONFIG_VF610_ADC is not set
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
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_BME680=m
CONFIG_BME680_I2C=m
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
CONFIG_SENSIRION_SGP30=m
# CONFIG_SPS30 is not set
CONFIG_VZ89X=m
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

CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=m
CONFIG_AD5446=m
# CONFIG_AD5593R is not set
# CONFIG_AD5696_I2C is not set
CONFIG_CIO_DAC=m
CONFIG_DPOT_DAC=m
CONFIG_DS4424=m
CONFIG_M62332=m
# CONFIG_MAX517 is not set
CONFIG_MAX5821=m
CONFIG_MCP4725=m
CONFIG_TI_DAC5571=m
CONFIG_VF610_DAC=m
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
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
CONFIG_HTU21=m
# CONFIG_SI7005 is not set
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
# CONFIG_FXOS8700_I2C is not set
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_ADUX1020=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
# CONFIG_APDS9960 is not set
CONFIG_BH1750=m
CONFIG_BH1780=m
CONFIG_CM32181=m
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM3605=m
CONFIG_CM36651=m
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
CONFIG_GP2AP020A00F=m
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=m
CONFIG_RPR0521=m
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=m
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
# CONFIG_MAX44009 is not set
CONFIG_NOA1305=m
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
CONFIG_SI1133=m
CONFIG_SI1145=m
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
CONFIG_US5182D=m
# CONFIG_VCNL4000 is not set
CONFIG_VCNL4035=m
CONFIG_VEML6030=m
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=m
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
CONFIG_IIO_HRTIMER_TRIGGER=m
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Digital potentiometers
#
CONFIG_AD5272=m
CONFIG_DS1803=m
# CONFIG_MAX5432 is not set
# CONFIG_MCP4018 is not set
CONFIG_MCP4531=m
CONFIG_TPL0102=m
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
CONFIG_DLHL60D=m
CONFIG_DPS310=m
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL3115=m
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
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
# CONFIG_MB1232 is not set
CONFIG_PING=m
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
CONFIG_SX9500=m
CONFIG_SRF08=m
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=m
CONFIG_MLX90632=m
CONFIG_TMP006=m
CONFIG_TMP007=m
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# end of Temperature sensors

CONFIG_NTB=m
CONFIG_NTB_MSI=y
CONFIG_NTB_IDT=m
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
# CONFIG_NTB_PERF is not set
CONFIG_NTB_MSI_TEST=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=m
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_LP3943 is not set
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=m

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=m
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_CADENCE_DP=y
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
CONFIG_PHY_MIXEL_MIPI_DPHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=m

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
# CONFIG_FPGA_BRIDGE is not set
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
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_GPIO is not set
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=m
CONFIG_FTM_QUADDEC=y
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
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_XINO_AUTO=y
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
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
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
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
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
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
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=m
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=m
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=m
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_DEBUG=y
# CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS is not set
# CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
# CONFIG_INTEGRITY_ASYMMETRIC_KEYS is not set
# CONFIG_INTEGRITY_AUDIT is not set
# CONFIG_IMA is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,tomoyo"

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
# CONFIG_STACKLEAK_METRICS is not set
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
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
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=m
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
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_ADIANTUM is not set
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
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
# CONFIG_CRYPTO_MD5 is not set
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=y

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
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
# CONFIG_TPM_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
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
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=m
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
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
CONFIG_ARCH_STACKWALK=y
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
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set
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
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
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
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_DEBUG_ON=y
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

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
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
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
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
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
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
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
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_UPROBE_EVENTS is not set
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
CONFIG_KPROBE_EVENT_GEN_TEST=m
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
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=m
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_TEST is not set
# CONFIG_KUNIT_EXAMPLE_TEST is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
CONFIG_REED_SOLOMON_TEST=y
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
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
CONFIG_SYSCTL_KUNIT_TEST=y
# CONFIG_LIST_KUNIT_TEST is not set
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--=_5e5dbc98.3YZqMTP9XCyxGg3+TneaGg7mgLlGOJEy2LQ56W63KxRCveRS--
