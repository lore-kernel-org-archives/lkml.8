Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87F7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEFC20702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGGFNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:13:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53162 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbgGGFNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:13:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D6D47200848;
        Tue,  7 Jul 2020 07:13:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 677CC200842;
        Tue,  7 Jul 2020 07:12:52 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A3133402A8;
        Tue,  7 Jul 2020 13:12:40 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, abel.vesa@nxp.com, peng.fan@nxp.com,
        sfr@canb.auug.org.au, j.remmet@phytec.de,
        georg.waibel@wiedemann-group.de, Georg.Waibel@wiedemann-group.com,
        laurent.pinchart@ideasonboard.com, chen.fang@nxp.com,
        fugang.duan@nxp.com, daniel.baluta@nxp.com, yuehaibing@huawei.com,
        andrew.smirnov@gmail.com, horia.geanta@nxp.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V6 0/6] Support building i.MX ARMv8 platforms clock driver as module
Date:   Tue,  7 Jul 2020 13:09:33 +0800
Message-Id: <1594098579-25050-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nowdays, there are more and more requirements of building SoC specific drivers
as modules, such as Android GKI (generic kernel image), this patch set supports
building i.MX ARMv8 SoCs clock drivers as modules,

The CLK_IMXxxx is introduced for i.MX ARMv7 platforms in order to make the build
options aligned, the reason why i.MX ARMv7 platforms clock driver do NOT support
module build and COMPILE_TEST is because, some drivers like i.MX GPT timer driver
depends on clock driver to be ready before it, GPT driver uses TIMER_OF_DECLARE(),
while i.MX6/7 clock drivers use CLK_OF_DECLARE(), and GPT driver is critical for
i.MX6/7 platforms kernel boot up, so GPT driver needs to be changed to support
loadable clock driver first, then the i.MX6/7 clock drivers can support loadable
module, this will be done later.

Changes since V5:
	- make i.MX ARMv7 platforms clock driver to bool and NOT support COMPILT_TEST,
	  since they depends on ARCH_MXC or SOC config, which makes the COMPILT_TEST
	  NOT make enough sense, so just skip the COMPILT_TEST support for i.MX ARMv7
	  platform clock drivers, leave them same as original implementation.
	- add a patch to fix build warning reported by kernel robot test on i.MX6SL
	  clock driver.

Anson Huang (6):
  clk: composite: Export clk_hw_register_composite()
  clk: imx: Support building i.MX common clock driver as module
  clk: imx: Add clock configuration for ARMv7 platforms
  clk: imx8m: Support module build
  clk: imx8qxp: Support building i.MX8QXP clock driver as module
  clk: imx6sl: Fix build warning reported by kernel test robot

 drivers/clk/clk-composite.c        |  1 +
 drivers/clk/imx/Kconfig            | 94 ++++++++++++++++++++++++++++++++------
 drivers/clk/imx/Makefile           | 79 ++++++++++++++++----------------
 drivers/clk/imx/clk-composite-8m.c |  2 +
 drivers/clk/imx/clk-cpu.c          |  2 +
 drivers/clk/imx/clk-frac-pll.c     |  2 +
 drivers/clk/imx/clk-gate2.c        |  2 +
 drivers/clk/imx/clk-imx6sl.c       | 15 +++---
 drivers/clk/imx/clk-imx8mm.c       |  4 ++
 drivers/clk/imx/clk-imx8mn.c       |  4 ++
 drivers/clk/imx/clk-imx8mp.c       |  4 ++
 drivers/clk/imx/clk-imx8mq.c       |  4 ++
 drivers/clk/imx/clk-imx8qxp-lpcg.c |  4 ++
 drivers/clk/imx/clk-imx8qxp.c      |  4 ++
 drivers/clk/imx/clk-pll14xx.c      |  5 ++
 drivers/clk/imx/clk-sscg-pll.c     |  2 +
 drivers/clk/imx/clk.c              | 17 +++++--
 drivers/clk/imx/clk.h              |  6 +++
 18 files changed, 186 insertions(+), 65 deletions(-)

-- 
2.7.4

