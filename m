Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6385CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4333521501
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgE1DXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 23:23:11 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55656 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgE1DXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:23:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 15CC51A0B98;
        Thu, 28 May 2020 05:23:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D609B1A0A5E;
        Thu, 28 May 2020 05:23:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id ADB9440280;
        Thu, 28 May 2020 11:22:50 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, daniel.baluta@nxp.com,
        leonard.crestez@nxp.com, peng.fan@nxp.com, aford173@gmail.com,
        jun.li@nxp.com, shengjiu.wang@nxp.com, horia.geanta@nxp.com,
        aisheng.dong@nxp.com, fugang.duan@nxp.com, agx@sigxcpu.org,
        l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 0/4] Change i.MX/MXS SoCs ocotp/iim node name to efuse
Date:   Thu, 28 May 2020 11:12:46 +0800
Message-Id: <1590635570-8541-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the nvmem yaml schema, it requires the nodename to be one of
"eeprom|efuse|nvram", so need to change all i.MX/MXS SoCs ocotp/iim node
name to efuse:

MXS platforms: i.MX23/28;
i.MX platforms with IIM: i.MX25/27/31/35/51/53.
i.MX ARMv7 platforms with OCOTP: i.MX6QDL/6SL/6SX/6SLL/6UL/7S/7ULP.
i.MX ARMv8 platforms with OCOTP: i.MX8MQ/8MM/8MN/8MP.

Anson Huang (4):
  ARM: dts: imx: change ocotp node name on i.MX6/7 SoCs
  arm64: dts: imx8m: change ocotp node name on i.MX8M SoCs
  ARM: dts: imx: change ocotp node name on MXS SoCs
  ARM: dts: imx: change iim node name on i.MX SoCs

 arch/arm/boot/dts/imx23.dtsi              | 2 +-
 arch/arm/boot/dts/imx25.dtsi              | 2 +-
 arch/arm/boot/dts/imx27.dtsi              | 2 +-
 arch/arm/boot/dts/imx28.dtsi              | 2 +-
 arch/arm/boot/dts/imx31.dtsi              | 2 +-
 arch/arm/boot/dts/imx35.dtsi              | 2 +-
 arch/arm/boot/dts/imx51.dtsi              | 2 +-
 arch/arm/boot/dts/imx53.dtsi              | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi            | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi             | 2 +-
 arch/arm/boot/dts/imx6sll.dtsi            | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi             | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi             | 2 +-
 arch/arm/boot/dts/imx7s.dtsi              | 2 +-
 arch/arm/boot/dts/imx7ulp.dtsi            | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.7.4

