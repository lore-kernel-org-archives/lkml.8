Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6240EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CC5208C7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599561186;
	bh=IAB2OfIUn/8K8Wy7aR20s3fCv1Xzvg8uXkO3xarIgmc=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=WXX++DyvXiYI0C/FhAlXNXkuCCDi8HLUzyzSWoJZ5BIWk7XYP5IU0Tdk2GLLAuhan
	 051ndokijbVc0nzcD6TMJEjCikB9F3KRbhvL04DkC+ayKUzw+OvHpmHvqiq0OCD/E9
	 avM1GPelidTuCUBNb4DldHMa/l/eHLn6NxGHMlDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgIHKdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbgIHK3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:29:01 -0400
Received: from mail.kernel.org (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A51421556;
        Tue,  8 Sep 2020 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599560940;
        bh=IAB2OfIUn/8K8Wy7aR20s3fCv1Xzvg8uXkO3xarIgmc=;
        h=From:To:Cc:Subject:Date:From;
        b=X0ZlHXUKM6AI/YSj2aXD1caXyfv3PBwkDkxvZVx9TyCFX+I8K5itKKDtYScVEGpoI
         OYa5jLnt+73Ie2CgOh1OemrRozBTP8TkSripMGOm7Zn7YscOeeRuw2FW/BHOG84mYH
         8kNInTsZUyarKkItX6o1GU5hry6cKHVUKpjWht5A=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFarx-00B3yB-WB; Tue, 08 Sep 2020 12:28:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH 00/10] Add USB support for Hikey 970
Date:   Tue,  8 Sep 2020 12:28:34 +0200
Message-Id: <cover.1599559318.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the phy layer needed by Kirin 970 SoC.

It also adds a GPIO USB3 HUB driver, that is meant to support
the HUB which comes inside with HiKey 960 and 970 designs.

The hub used on Hikey 970 is this one:
	Bus 002 Device 002: ID 0451:8140 Texas Instruments, Inc. TUSB8041 4-Port Hub

While it supports I2C, the driver for it just enables it, depending
on the OTG mode.

v3:
- fixes a problem on the past series, where some changes went
  to the wrong patch;
- adds DTS and dt-bindinds required for Hikey 970 USB to work.

For the dt-bindings to work properly, two patches already sent
are required:
   - a patch adding Hikey 970 to dwg3-of-simple driver;
   - a quirks patch for dwc3, which is required for usbhid to work.
    funny enough, such patch is not required by USB sticks.
    I suspect that it affects only INT URB packets, but didn't
    made any tests.

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
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 102 +++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  58 ++
 drivers/misc/Kconfig                          |   9 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/hisi_hikey_usb.c                 | 274 +++++++
 drivers/phy/hisilicon/Kconfig                 |  10 +
 drivers/phy/hisilicon/Makefile                |   1 +
 drivers/phy/hisilicon/phy-hi3670-usb3.c       | 671 ++++++++++++++++++
 10 files changed, 1213 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
 create mode 100644 drivers/misc/hisi_hikey_usb.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c

-- 
2.26.2


