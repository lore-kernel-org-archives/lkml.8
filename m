Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C928DC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF8B20791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599215108;
	bh=zsXGoYIKZ7McsBLN5A59BuKXBaK5/H+qvIXPUfHggZk=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=Un99JIvO6SiHIykXEmL5ACzB5ukYplZoTbxlMTJqvFLQam0UlPvyQPqNKPB0NUy4B
	 9L15xp6QyOW0buSPQ0v44drf5ZWx6b4i5Gqi4xPgBb1cQqPaYRjHL7+OFjSW5cgrvN
	 6B/EyO6m63ZrZ+hA9QEsZ9tQh0pWNpuedi+Q4HGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgIDKYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730022AbgIDKXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:23:39 -0400
Received: from mail.kernel.org (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3438C20FC3;
        Fri,  4 Sep 2020 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215016;
        bh=zsXGoYIKZ7McsBLN5A59BuKXBaK5/H+qvIXPUfHggZk=;
        h=From:To:Cc:Subject:Date:From;
        b=Cbkt/JmvOBpVNWgZ0zOZFL0J36X3IT6gYV+XJWL5QkvKoyClM91Wq2RknRwtuxt4c
         xMZJcgoBdws0eGlOb27/95HI2Y1NC4Ky360LxF/Ozaw9u24WaXgVi9zxenAxPuVgWK
         ienslIifT51EcY4ZDRqD/yoVY3cybEMHNLfVFqek=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kE8sX-005Sv4-JC; Fri, 04 Sep 2020 12:23:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: [RFC 00/10] Add USB support for Hikey 970
Date:   Fri,  4 Sep 2020 12:23:22 +0200
Message-Id: <cover.1599214329.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC adds what seems to be needed for USB to work with Hikey 970.
While this driver works fine on Kernel 4.9 and 4.19, there's a hack there,
in the form of some special binding logic under dwg3 driver,  that seems to
 be just adding some delay,  and doing some different initializations at
PM (basically, disabling autosuspend).

With upstream Kernel, however, I'm getting a hard to track
Kernel panic:

[    1.837458] SError Interrupt on CPU0, code 0xbf000002 -- SError
[    1.837462] CPU: 0 PID: 74 Comm: kworker/0:1 Not tainted 5.8.0+ #205
[    1.837463] Hardware name: HiKey970 (DT)
[    1.837465] Workqueue: events deferred_probe_work_func
[    1.837467] pstate: 20000005 (nzCv daif -PAN -UAO BTYPE=--)
[    1.837468] pc : _raw_spin_unlock_irqrestore+0x18/0x50
[    1.837469] lr : regmap_unlock_spinlock+0x14/0x20
[    1.837470] sp : ffff8000124dba60
[    1.837471] x29: ffff8000124dba60 x28: 0000000000000000 
[    1.837474] x27: ffff0001b7e854c8 x26: ffff80001204ea18 
[    1.837476] x25: 0000000000000005 x24: ffff800011f918f8 
[    1.837479] x23: ffff800011fbb588 x22: ffff0001b7e40e00 
[    1.837481] x21: 0000000000000100 x20: 0000000000000000 
[    1.837483] x19: ffff0001b767ec00 x18: 00000000ff10c000 
[    1.837485] x17: 0000000000000002 x16: 0000b0740fdb9950 
[    1.837488] x15: ffff8000116c1198 x14: ffffffffffffffff 
[    1.837490] x13: 0000000000000030 x12: 0101010101010101 
[    1.837493] x11: 0000000000000020 x10: ffff0001bf17d130 
[    1.837495] x9 : 0000000000000000 x8 : ffff0001b6938080 
[    1.837497] x7 : 0000000000000000 x6 : 000000000000003f 
[    1.837500] x5 : 0000000000000000 x4 : 0000000000000000 
[    1.837502] x3 : ffff80001096a880 x2 : 0000000000000000 
[    1.837505] x1 : ffff0001b7e40e00 x0 : 0000000100000001 
[    1.837507] Kernel panic - not syncing: Asynchronous SError Interrupt
[    1.837509] CPU: 0 PID: 74 Comm: kworker/0:1 Not tainted 5.8.0+ #205
[    1.837510] Hardware name: HiKey970 (DT)
[    1.837511] Workqueue: events deferred_probe_work_func
[    1.837513] Call trace:
[    1.837514]  dump_backtrace+0x0/0x1e0
[    1.837515]  show_stack+0x18/0x24
[    1.837516]  dump_stack+0xc0/0x11c
[    1.837517]  panic+0x15c/0x324
[    1.837518]  nmi_panic+0x8c/0x90
[    1.837519]  arm64_serror_panic+0x78/0x84
[    1.837520]  do_serror+0x158/0x15c
[    1.837521]  el1_error+0x84/0x100
[    1.837522]  _raw_spin_unlock_irqrestore+0x18/0x50
[    1.837523]  regmap_write+0x58/0x80
[    1.837524]  hi3660_reset_deassert+0x28/0x34
[    1.837526]  reset_control_deassert+0x50/0x260
[    1.837527]  reset_control_deassert+0xf4/0x260
[    1.837528]  dwc3_probe+0x5dc/0xe6c
[    1.837529]  platform_drv_probe+0x54/0xb0
[    1.837530]  really_probe+0xe0/0x490
[    1.837531]  driver_probe_device+0xf4/0x160
[    1.837532]  __device_attach_driver+0x8c/0x114
[    1.837533]  bus_for_each_drv+0x78/0xcc
[    1.837534]  __device_attach+0x108/0x1a0
[    1.837535]  device_initial_probe+0x14/0x20
[    1.837537]  bus_probe_device+0x98/0xa0
[    1.837538]  deferred_probe_work_func+0x88/0xe0
[    1.837539]  process_one_work+0x1cc/0x350
[    1.837540]  worker_thread+0x2c0/0x470
[    1.837541]  kthread+0x154/0x160
[    1.837542]  ret_from_fork+0x10/0x30
[    1.837569] SMP: stopping secondary CPUs
[    1.837570] Kernel Offset: 0x1d0000 from 0xffff800010000000
[    1.837571] PHYS_OFFSET: 0x0
[    1.837572] CPU features: 0x240002,20882004
[    1.837573] Memory Limit: none

I suspect that the driver works downstream because of the extra
delay of probing an additional driver, as porting such driver
to upstream sometimes makes this driver to work. So, it could 
be due to some race condition.

The problem could also be due to something wrong at DT,
as, with the additional driver, the DT bindings are different.

As I'm not familiar about the Serror error mechanism on ARM, 
I'm wondering if someone could give me some hint about how
can I identify what's happening here.  Due to the panic(), I
can't check what wrong happened there. Not sure if it would
be safe to just hack the error handling part of Serror, in order
to let the boot to finish.

PS.: the driver/misc hisi_hikey_usb driver on this series came 
from the John Stultz Hikey 960 tree.

Thanks!
Mauro

Mauro Carvalho Chehab (7):
  phy: hisilicon: phy-hi3670-usb3: use a consistent namespace
  phy: hisilicon: phy-hi3670-usb3: fix coding style
  phy: hisilicon: phy-hi3670-usb3: change some DT properties
  dt-bindings: phy: convert phy-kirin970-usb3.txt to yaml
  MAINTAINERS: add myself as maintainer for Kirin 970 USB PHY
  misc: hisi_hikey_usb: add support for Hikey 970
  dts: hisilicon: add support for USB3 on Hikey 970

Yu Chen (3):
  phy: hisilicon: add USB physical layer for Kirin 3670
  phy: hisilicon: phy-hi3670-usb3: fix some issues at the init code
  misc: hisi_hikey_usb: Driver to support onboard USB gpio hub on
    Hikey960

 .../bindings/phy/hisilicon,hi3670-usb3.yaml   |  72 ++
 MAINTAINERS                                   |  16 +-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 103 +++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  49 ++
 drivers/misc/Kconfig                          |   9 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/hisi_hikey_usb.c                 | 272 +++++++
 drivers/phy/hisilicon/Kconfig                 |  10 +
 drivers/phy/hisilicon/Makefile                |   1 +
 drivers/phy/hisilicon/phy-hi3670-usb3.c       | 671 ++++++++++++++++++
 10 files changed, 1203 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
 create mode 100644 drivers/misc/hisi_hikey_usb.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c

-- 
2.26.2


