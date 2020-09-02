Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DE2C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0391C207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599061140;
	bh=T6Yn3tddYjoK53UIen+h42dRX/nUCLrBYpMRIo/p/jg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hkKlOMxZA4ssmLFUF36/W4WbqnBvqzyMxgIYtZXm9vDRr7qgCSg5PrCRcegnu3ycK
	 hnbDRpPV5OsrKbXyeHaGrNELYZHFUqBEtBGvf+7+s6FpCxn38uNM5qmCKS5/Qqzwgi
	 T5zAbwY26XplKbzTgMUSDk0Nm8DRf5yfASKljR70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgIBPi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgIBPC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:02:57 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BCC620773;
        Wed,  2 Sep 2020 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599058974;
        bh=T6Yn3tddYjoK53UIen+h42dRX/nUCLrBYpMRIo/p/jg=;
        h=From:To:Cc:Subject:Date:From;
        b=mQl7IDeluJ5si0Krf40peleU/p5DkqAdXabeJfq4UXZPZwSy48Z41gWvswjYvSbx5
         aCnXwidGvUsRyRp1ZAYL9ne3hMwdL855PygrXIQImnJbPLmSvEDr5qoT6m0s53XQR9
         keKYV1/Tm/01ybiTAwuDEnp7WfqNPlBD9B1dVyhU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] clk: imx: Declare clock init functions in header acessible from mach
Date:   Wed,  2 Sep 2020 17:02:42 +0200
Message-Id: <20200902150244.14347-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple files from arch/arm/mach-imx/ use clock init functions which
are defined in the IMX clock drivers.  Declare them in globally
accessible header to fix GCC warnings:

  drivers/clk/imx/clk-imx21.c:122:74: warning: no previous prototype for 'mx21_clocks_init' [-Wmissing-prototypes]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/imx/clk-imx21.c |  1 +
 drivers/clk/imx/clk-imx27.c |  1 +
 drivers/clk/imx/clk-imx31.c |  1 +
 drivers/clk/imx/clk-imx35.c |  1 +
 include/linux/clk/imx.h     | 11 +++++++++++
 5 files changed, 15 insertions(+)
 create mode 100644 include/linux/clk/imx.h

diff --git a/drivers/clk/imx/clk-imx21.c b/drivers/clk/imx/clk-imx21.c
index 077b4a7123ce..2105ef57b6bc 100644
--- a/drivers/clk/imx/clk-imx21.c
+++ b/drivers/clk/imx/clk-imx21.c
@@ -7,6 +7,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/clk/imx.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index a3753067fc12..c0d8bcdf0719 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -2,6 +2,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/clk/imx.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index 4bb05e440cdd..25be4c292e44 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/clk/imx.h>
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/of.h>
diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index e595f559907f..baf8d236d6ef 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -5,6 +5,7 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/clk/imx.h>
 #include <linux/io.h>
 #include <linux/clkdev.h>
 #include <linux/of.h>
diff --git a/include/linux/clk/imx.h b/include/linux/clk/imx.h
new file mode 100644
index 000000000000..f6394d1b0a94
--- /dev/null
+++ b/include/linux/clk/imx.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_CLK_IMX_H
+#define __LINUX_CLK_IMX_H
+
+int mx21_clocks_init(unsigned long lref, unsigned long href);
+int mx27_clocks_init(unsigned long fref);
+int mx31_clocks_init(unsigned long fref);
+int mx35_clocks_init(void);
+
+#endif /* __LINUX_CLK_IMX_H */
-- 
2.17.1

