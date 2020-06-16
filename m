Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF3FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F01720739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pjFgRUJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgFPI0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:26:10 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:19830 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFPI0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592295970; x=1623831970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pdUPZ7+Pu/NEXeETQG7AdYlCrLApBPSZGixeZ66Fvys=;
  b=pjFgRUJHRMps3/KCxEleLCP7LIBdRfg6TSKaaJ9Ys63JsstM5ElLpyD9
   SWh0NpcMn/+fQYvwvyYCvPoBXsbzw4flm3lnRfnYj3FOOdfZZ/ZuO3Nml
   sQ1dxeqfFir87YLgAdrVj4N7Hps3nfPk8EWoxT5P3F51SqMBJNTaMwD1i
   427rXGcm2VR/GYMF1dF4UR9KcJinLCsiHwCnO1HiseQTTV//NF0kSJ/wV
   PUkHx784A+t4ADBoFF7tQGYZCegcOIhHlIhtO9DrufSgUHWJ+kU+RVvzJ
   bTceWy/SRP02P2sQ9ti8Pl+BppAE4t7JjH0DwWIHZWQEaiIlzt6DnQSiP
   Q==;
IronPort-SDR: YcQAzRbALpE91uj+fDjLyhJYX/RMVfaIOHGR+8/8dHiOmYVMzdWjHPlVSty/KZqDBmkZ/vqR30
 EGwopgrpB+EGNuOiIuYFzQJaIj8JdyJWadsaX8ryy4qwmBU44ZIF1MRI5BrXjIQpW++MJJ50Bv
 J71rXEzXdlQkeunDpG5RyoyfNrr+qgRMy2xH2xYLlK06UiTZxVby7C7XtQKz3jqZt98F46dFjk
 juc62I6iEsoC4yw8e3VTkxraBX9KKeJZo8GUrL2Przc2jZ/Gu+rkXaMZqEt1hHX62FMiXR0MzN
 W/g=
X-IronPort-AV: E=Sophos;i="5.73,518,1583218800"; 
   d="scan'208";a="79621886"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2020 01:26:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 01:26:09 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 16 Jun 2020 01:26:06 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 0/3] hwmon: Adding support for Microchip Sparx5 SoC
Date:   Tue, 16 Jun 2020 10:25:53 +0200
Message-ID: <20200616082556.27877-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an add-on series to the main SoC Sparx5 series
(Message-ID: <20200615133242.24911-1-lars.povlsen@microchip.com>

Changes in v3:
- Enabled driver for COMPILE_TEST
- Use "bitfield.h"
- Trimmed #includes even more
- Removed unnecessary devm_add_action()
- Maintain sort order in Makefile
- Minor cosmetics

Changes in v2:
- Removed unnecessary #includes
- Statement reordering in s5_read()
- Replaced EINVAL with EIO
- Add 'break' in default: case statement.
- Removed extra ()
- Removed superfluous initialization

Lars Povlsen (3):
  dt-bindings: hwmon: Add Sparx5 temperature sensor
  arm64: dts: sparx5: Add hwmon temperature sensor
  hwmon: sparx5: Add Sparx5 SoC temperature driver

 .../bindings/hwmon/microchip,sparx5-temp.yaml |  39 +++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |   6 +
 drivers/hwmon/Kconfig                         |  10 ++
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sparx5-temp.c                   | 136 ++++++++++++++++++
 5 files changed, 192 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
 create mode 100644 drivers/hwmon/sparx5-temp.c

-- 
2.27.0

