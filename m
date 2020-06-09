Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E028EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 07:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65C220823
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 07:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgFIHnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 03:43:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48366 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgFIHnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:43:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C2D97200189;
        Tue,  9 Jun 2020 09:43:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B65A1201036;
        Tue,  9 Jun 2020 09:43:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 660AF402F3;
        Tue,  9 Jun 2020 15:42:49 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, oleksandr.suvorov@toradex.com,
        stefan.agner@toradex.com, arnd@arndb.de, abel.vesa@nxp.com,
        peng.fan@nxp.com, aisheng.dong@nxp.com, tglx@linutronix.de,
        allison@lohutok.net, gregkh@linuxfoundation.org, info@metux.net,
        leonard.crestez@nxp.com, fugang.duan@nxp.com,
        daniel.baluta@nxp.com, yuehaibing@huawei.com, sfr@canb.auug.org.au,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 0/9] Support building i.MX8 SoCs clock driver as module
Date:   Tue,  9 Jun 2020 15:32:04 +0800
Message-Id: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nowdays, there are more and more requirements of building SoC specific drivers
as modules, such as Android GKI (generic kernel image), this patch set supports
building i.MX8 SoCs clock drivers as modules, including i.MX8MQ/MM/MN/MP/QXP,
the common clock modules are: mxc-clk.ko for i.MX8MQ/MM/MN/MP, mxc-clk-scu.ko
for i.MX8QXP and later SoCs with SCU inside, normally, each platform can ONLY
insmod 1 common i.MX clock driver and its own SoC clock driver.

Since i.MX common clk driver will support module build and no longer selected
by default, so for i.MX ARMv7 platforms, need to manually select it to make build pass.

Changes since V1:
	- Fix build error for x86_64-allyesconfig by adding dependency for MXC_CLK_SCU;
	- Move lpcg clock driver change to SCU patch, this is incorrect in V1.

Anson Huang (9):
  clk: composite: Export clk_hw_register_composite()
  ARM: imx: Select MXC_CLK for ARCH_MXC
  clk: imx: Support building SCU clock driver as module
  clk: imx: Support building i.MX common clock driver as module
  clk: imx8mm: Support module build
  clk: imx8mn: Support module build
  clk: imx8mp: Support module build
  clk: imx8mq: Support module build
  clk: imx8qxp: Support module build

 arch/arm/mach-imx/Kconfig          |  1 +
 drivers/clk/clk-composite.c        |  1 +
 drivers/clk/imx/Kconfig            | 22 +++++++++++++---------
 drivers/clk/imx/Makefile           | 30 +++++++-----------------------
 drivers/clk/imx/clk-composite-8m.c |  1 +
 drivers/clk/imx/clk-cpu.c          |  1 +
 drivers/clk/imx/clk-frac-pll.c     |  1 +
 drivers/clk/imx/clk-gate2.c        |  1 +
 drivers/clk/imx/clk-imx8mm.c       |  1 +
 drivers/clk/imx/clk-imx8mn.c       |  1 +
 drivers/clk/imx/clk-imx8mp.c       |  1 +
 drivers/clk/imx/clk-imx8mq.c       |  1 +
 drivers/clk/imx/clk-imx8qxp-lpcg.c |  1 +
 drivers/clk/imx/clk-imx8qxp.c      |  1 +
 drivers/clk/imx/clk-lpcg-scu.c     |  1 +
 drivers/clk/imx/clk-pll14xx.c      |  4 ++++
 drivers/clk/imx/clk-scu.c          |  5 +++++
 drivers/clk/imx/clk-sscg-pll.c     |  1 +
 drivers/clk/imx/clk.c              | 28 ++++++++++++++++++++++------
 19 files changed, 65 insertions(+), 38 deletions(-)

-- 
2.7.4

