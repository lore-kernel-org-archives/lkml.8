Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8945CC7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B83020659
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBQD0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:26:36 -0500
Received: from inva021.nxp.com ([92.121.34.21]:48928 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgBQD0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:26:36 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3AE5C201E36;
        Mon, 17 Feb 2020 04:26:34 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 72A7D200EBF;
        Mon, 17 Feb 2020 04:26:24 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AC27F402A7;
        Mon, 17 Feb 2020 11:26:12 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 0/7] Add FlexCAN support on i.MX8QXP
Date:   Mon, 17 Feb 2020 11:19:14 +0800
Message-Id: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FlexCAN support on i.MX8QXP.

Joakim Zhang (7):
  firmware: imx: scu-pd: add power domain for I2C and INTMUX in CM40 SS
  clk: imx8: Add SCU and LPCG clocks for I2C in CM40 SS
  bindings: clock: imx8qxp: add "fsl,imx8qxp-lpcg-cm40" compatible
    string
  clk: imx: imx8qxp: Enable SCU and LPCG clocks for I2C in CM40 SS
  arch: arm64: dts: imx8qxp: add device node for I2C and INTMUX in CM40
    SS
  clk: imx: imx8qxp: add LPCG clock for FlexCAN in ADMA SS
  arch: arm64: dts: imx8qxp: add device node for CAN in ADMA SS

 .../bindings/clock/imx8qxp-lpcg.txt           |   1 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  74 ++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 106 ++++++++++++++++++
 drivers/clk/imx/clk-imx8qxp-lpcg.c            |  15 +++
 drivers/clk/imx/clk-imx8qxp-lpcg.h            |   3 +
 drivers/clk/imx/clk-imx8qxp.c                 |   4 +
 drivers/firmware/imx/scu-pd.c                 |   4 +
 include/dt-bindings/clock/imx8-clock.h        |  13 ++-
 8 files changed, 219 insertions(+), 1 deletion(-)

-- 
2.17.1

