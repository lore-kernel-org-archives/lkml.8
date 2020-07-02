Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AD6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CD4208B6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgGBP1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:27:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55200 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgGBP1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:27:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A90D61A0C17;
        Thu,  2 Jul 2020 17:27:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 20A8B1A0AE6;
        Thu,  2 Jul 2020 17:27:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3563F402B1;
        Thu,  2 Jul 2020 23:27:00 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, arnd@arndb.de, peng.fan@nxp.com,
        abel.vesa@nxp.com, j.remmet@phytec.de, sfr@canb.auug.org.au,
        georg.waibel@wiedemann-group.de, Georg.Waibel@wiedemann-group.com,
        laurent.pinchart@ideasonboard.com, chen.fang@nxp.com,
        fugang.duan@nxp.com, daniel.baluta@nxp.com, yuehaibing@huawei.com,
        horia.geanta@nxp.com, andrew.smirnov@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V5 0/6] Support building i.MX ARMv7/ARMv8 platforms clock driver as module
Date:   Thu,  2 Jul 2020 23:23:55 +0800
Message-Id: <1593703441-16944-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nowdays, there are more and more requirements of building SoC specific
drivers as modules, such as Android GKI (generic kernel image), this
patch set supports building i.MX ARMv6/ARMv7 SoCs clock drivers as modules,

The CLK_IMXxxx is introduced for i.MX ARMv7 platforms in order to support
various build options, and i.MX1/2/3 platforms now still ONLY support built-in
as they are rarely used now.

Changes since V4:
	- add empty function of imx_register_uart_clocks() for MODULE build, then
	  all earlycon related clock handler can be built-out for MODULE;
	- add module build support for ARMv7 platforms, also add COMPILE_TEST for them;
	- add COMPILE_TEST for ARMv8 platforms;
	- keep using builtin_platform_driver() for i.MX8QXP clock driver.

Anson Huang (6):
  clk: composite: Export clk_hw_register_composite()
  clk: imx: Support module build for i.MX5/6/7 and vf610
  clk: imx: Support building i.MX common clock driver as module
  clk: imx: Add clock configuration for ARMv7 platforms
  clk: imx8m: Support module build
  clk: imx8qxp: Support building i.MX8QXP clock driver as module

 drivers/clk/clk-composite.c        |   1 +
 drivers/clk/imx/Kconfig            | 101 ++++++++++++++++++++++++++++++++-----
 drivers/clk/imx/Makefile           |  79 ++++++++++++++---------------
 drivers/clk/imx/clk-composite-8m.c |   2 +
 drivers/clk/imx/clk-cpu.c          |   2 +
 drivers/clk/imx/clk-frac-pll.c     |   2 +
 drivers/clk/imx/clk-gate2.c        |   2 +
 drivers/clk/imx/clk-imx5.c         |   5 ++
 drivers/clk/imx/clk-imx6q.c        |   5 ++
 drivers/clk/imx/clk-imx6sl.c       |   5 ++
 drivers/clk/imx/clk-imx6sll.c      |   5 ++
 drivers/clk/imx/clk-imx6sx.c       |   5 ++
 drivers/clk/imx/clk-imx6ul.c       |   5 ++
 drivers/clk/imx/clk-imx7d.c        |   5 ++
 drivers/clk/imx/clk-imx7ulp.c      |   5 ++
 drivers/clk/imx/clk-imx8mm.c       |   4 ++
 drivers/clk/imx/clk-imx8mn.c       |   4 ++
 drivers/clk/imx/clk-imx8mp.c       |   4 ++
 drivers/clk/imx/clk-imx8mq.c       |   4 ++
 drivers/clk/imx/clk-imx8qxp-lpcg.c |   4 ++
 drivers/clk/imx/clk-imx8qxp.c      |   4 ++
 drivers/clk/imx/clk-pll14xx.c      |   5 ++
 drivers/clk/imx/clk-sscg-pll.c     |   2 +
 drivers/clk/imx/clk-vf610.c        |   5 ++
 drivers/clk/imx/clk.c              |  17 +++++--
 drivers/clk/imx/clk.h              |   6 +++
 26 files changed, 231 insertions(+), 57 deletions(-)

-- 
2.7.4

