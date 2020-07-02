Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81C8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA5A2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgGBCRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:17:51 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45898 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgGBCRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:17:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1615C1A0928;
        Thu,  2 Jul 2020 04:17:49 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E62EF1A0914;
        Thu,  2 Jul 2020 04:17:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 07EB4402DD;
        Thu,  2 Jul 2020 10:17:32 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        peng.fan@nxp.com, arnd@arndb.de, abel.vesa@nxp.com,
        aisheng.dong@nxp.com, fugang.duan@nxp.com, daniel.baluta@nxp.com,
        yuehaibing@huawei.com, sfr@canb.auug.org.au,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4 0/5] Support building i.MX8 SoCs clock driver as module
Date:   Thu,  2 Jul 2020 10:14:29 +0800
Message-Id: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nowdays, there are more and more requirements of building SoC specific
drivers as modules, such as Android GKI (generic kernel image), this patch
set supports building i.MX8 SoCs clock drivers as modules, including
i.MX8MQ/MM/MN/MP/QXP, the common clock modules are: mxc-clk.ko for
i.MX8MQ/MM/MN/MP, i.MX8QXP has linked the common scu/lpcg clock driver into
its clock drivers.

Since i.MX common clk driver will support module build and no longer selected
by default, so for i.MX ARMv7 platforms, add clock configuration for each SoC
and they are selected by default if the corresponding SoC config is selected.

Changes since V3:
	- merge all i.MX8M SoCs patches together;
	- add module author/description;
	- drop __setup_param() change, it is ONLY needed for built-in version,
	  so just add #if check for module build;
	- link common scu and lpcg clock into i.MX8QXP clock driver, then export
	  is no needed for common scu/lpcg clock driver.

Anson Huang (5):
  clk: composite: Export clk_hw_register_composite()
  clk: imx: Add clock configuration for ARMv7 platforms
  clk: imx: Support building i.MX common clock driver as module
  clk: imx8m: Support module build
  clk: imx8qxp: Support building i.MX8QXP clock driver as module

 drivers/clk/clk-composite.c        |   1 +
 drivers/clk/imx/Kconfig            | 112 ++++++++++++++++++++++++++++++++++---
 drivers/clk/imx/Makefile           |  79 +++++++++++++-------------
 drivers/clk/imx/clk-composite-8m.c |   2 +
 drivers/clk/imx/clk-cpu.c          |   2 +
 drivers/clk/imx/clk-frac-pll.c     |   2 +
 drivers/clk/imx/clk-gate2.c        |   2 +
 drivers/clk/imx/clk-imx8mm.c       |   4 ++
 drivers/clk/imx/clk-imx8mn.c       |   4 ++
 drivers/clk/imx/clk-imx8mp.c       |   4 ++
 drivers/clk/imx/clk-imx8mq.c       |   4 ++
 drivers/clk/imx/clk-imx8qxp-lpcg.c |  10 +++-
 drivers/clk/imx/clk-imx8qxp.c      |  11 +++-
 drivers/clk/imx/clk-pll14xx.c      |   5 ++
 drivers/clk/imx/clk-sscg-pll.c     |   2 +
 drivers/clk/imx/clk.c              |  22 ++++++--
 16 files changed, 209 insertions(+), 57 deletions(-)

-- 
2.7.4

