Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7804CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523A9204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgHUPA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:00:27 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:41389 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:00:24 -0400
Received: from lhopital-XPS-13-9360.home (lfbn-tou-1-1372-bdcst.w90-89.abo.wanadoo.fr [90.89.180.255])
        (Authenticated sender: kevin.lhopital@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPA id DDDD5100006;
        Fri, 21 Aug 2020 15:00:17 +0000 (UTC)
From:   =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= 
        <kevin.lhopital@bootlin.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, wens@csie.org, yong.deng@magewell.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        paul.kocialkowski@bootlin.com, thomas.petazzoni@bootlin.com,
        =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= 
        <kevin.lhopital@bootlin.com>
Subject: [PATCH 0/7] Support of MIPI CSI-2 for A83T and OV8865 camera
Date:   Fri, 21 Aug 2020 16:59:28 +0200
Message-Id: <20200821145935.20346-1-kevin.lhopital@bootlin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kévin L'hôpital (7):
  media: sun6i-csi: Fix the bpp for 10-bit bayer formats
  dt-bindings: media: i2c: Add documentation for ov8865
  media: i2c: Add support for the OV8865 image sensor
  media: sunxi: sun6i-csi: Move the sun6i_csi_dev structure to the
    common header
  media: sunxi: sun6i-csi: Add support of MIPI CSI-2 for A83T
  ARM: dts: sun8i: a83t: Add support for the MIPI CSI-2 in CSI node
  [NOT FOR MERGE] ARM: dts: sun8i: a83t: bananapi-m3: Enable OV8865
    camera

 .../devicetree/bindings/media/i2c/ov8865.txt  |   51 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  |   99 +
 arch/arm/boot/dts/sun8i-a83t.dtsi             |   11 +-
 drivers/media/i2c/Kconfig                     |   12 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/ov8865.c                    | 2540 +++++++++++++++++
 .../media/platform/sunxi/sun6i-csi/Makefile   |    2 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |   94 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |   14 +-
 .../sunxi/sun6i-csi/sun8i_a83t_dphy.c         |   20 +
 .../sunxi/sun6i-csi/sun8i_a83t_dphy.h         |   16 +
 .../sunxi/sun6i-csi/sun8i_a83t_dphy_reg.h     |   15 +
 .../sunxi/sun6i-csi/sun8i_a83t_mipi_csi2.c    |  249 ++
 .../sunxi/sun6i-csi/sun8i_a83t_mipi_csi2.h    |   16 +
 .../sun6i-csi/sun8i_a83t_mipi_csi2_reg.h      |   42 +
 15 files changed, 3148 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov8865.txt
 create mode 100644 drivers/media/i2c/ov8865.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun8i_a83t_dphy.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun8i_a83t_dphy.h
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun8i_a83t_dphy_reg.h
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun8i_a83t_mipi_csi2.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun8i_a83t_mipi_csi2.h
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun8i_a83t_mipi_csi2_reg.h

-- 
2.17.1

