Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B366C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024522076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OfrB63I3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgCRKbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:31:39 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7066 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgCRKbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:31:38 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e71f87c0000>; Wed, 18 Mar 2020 03:31:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 18 Mar 2020 03:31:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 18 Mar 2020 03:31:37 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Mar
 2020 10:31:37 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Mar 2020 10:31:37 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e71f8850000>; Wed, 18 Mar 2020 03:31:36 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <kishon@ti.com>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jckuo@nvidia.com>, Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V1 0/8] Tegra XUSB charger detect support
Date:   Wed, 18 Mar 2020 16:00:59 +0530
Message-ID: <1584527467-8058-1-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584527484; bh=MQxDA3+0DCyRa8tzAovhw+nWxnnrADn8jKFJkcOd/Nc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=OfrB63I3DB8gc1cJQle4aBbmCv/JsdiY4nzFpqwUpeMyLCXUukDh/G2Tl6f/Nk93I
         Z/+9kRPBPKVHrkbe7vLpzBZSUfojgiUeieK3XKxyk3w4gz67wh8QS41Evu9AWBrWG4
         PHUhhvE3e8JPFTD/yHaAXVJBnf9gAp7Wlhg7bk7/NrEi5+QOnbsslgvd2hxhkF4RYh
         +YtVDEvRRZEg5Rn2SCSjUuYGOtrsy/0JBmy2MArCEfdSPTPjYGLJKruMD6BTHYzmFn
         WZw78HXZNUs0hIqCsqpdT1Fwdnn+BR5aeBJlqP5AjQSeogErmWM/HBvgfpq2BcxoK7
         X1S+gH2S/JSPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds charger detect support on XUSB hardware used in
Tegra210 and Tegra186 SoCs.

This patchset is composed with :
 - dt bindings of XUSB Pad Controller
 - Tegra XUSB device mode driver to add vbus_draw support 
 - Tegra PHY driver for charger detect support

Tests done:
 - Connect USB cable from ubuntu host to micro-B port of DUT to detect
   SDP_TYPE charger
 - Connect USB cable from external powered USB hub(which inturn connects
   to ubuntu host) to micro-B port of DUT to detect CDP_TYPE charger.
 - Connect USB cable from USB charger to micro-B port of DUT to detect
   DCP_TYPE charger.
DUT: Jetson-tx1, Jetson tx2.

Nagarjuna Kristam (8):
  dt-bindings: phy: tegra-xusb: Add charger-detect property
  usb: gadget: tegra-xudc: Add vbus_draw support
  phy: tegra: xusb: Add support for UTMI pad power control
  phy: tegra: xusb: Add USB2 pad power control support for Tegra210
  phy: tegra: xusb: Add soc ops API to enable UTMI PAD protection
  phy: tegra: xusb: Add support for charger detect
  phy: tegra: xusb: Enable charger detect for Tegra186
  phy: tegra: xusb: Enable charger detect for Tegra210

 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |   4 +
 drivers/phy/tegra/Makefile                         |   2 +-
 drivers/phy/tegra/xusb-tegra-cd.c                  | 300 +++++++++++++++++++++
 drivers/phy/tegra/xusb-tegra186.c                  |  92 +++++--
 drivers/phy/tegra/xusb-tegra210.c                  | 222 +++++++++++----
 drivers/phy/tegra/xusb.c                           |  80 ++++++
 drivers/phy/tegra/xusb.h                           |  22 ++
 drivers/usb/gadget/udc/tegra-xudc.c                |  16 ++
 8 files changed, 653 insertions(+), 85 deletions(-)
 create mode 100644 drivers/phy/tegra/xusb-tegra-cd.c

-- 
2.7.4

