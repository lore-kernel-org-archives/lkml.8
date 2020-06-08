Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDC9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244B12072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgFHNXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:23:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47988 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgFHNXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:23:13 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9647B20008C;
        Mon,  8 Jun 2020 15:23:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A939B200DF5;
        Mon,  8 Jun 2020 15:23:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 52FE740297;
        Mon,  8 Jun 2020 21:22:49 +0800 (SGT)
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
Subject: [PATCH 0/9] Support building i.MX8 SoCs clock driver as module
Date:   Mon,  8 Jun 2020 21:12:07 +0800
Message-Id: <1591621936-11886-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nowdays, there are more and more requirements of building SoC specific
drivers as modules, such as Android GKI (generic kernel image), this patch
set support building i.MX8 SoCs clock drivers as modules, including
i.MX8MQ/MM/MN/MP/QXP, the common clock modules are: mxc-clk.ko for
i.MX8MQ/MM/MN/MP, mxc-clk-scu.ko for i.MX8QXP and later SoCs with SCU inside,
normally, each platform can ONLY insmod 1 common i.MX clock driver and
its own SoC clock driver.

Since i.MX common clk driver will support module build and no longer selected
by default, so for i.MX ARMv7 platforms, need to manually select it to
make build pass.

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
 drivers/clk/imx/Kconfig            | 20 ++++++++++++--------
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
 19 files changed, 64 insertions(+), 37 deletions(-)

-- 
2.7.4

