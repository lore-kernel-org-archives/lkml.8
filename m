Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64712C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BDF2073E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHDXWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:22:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49392 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgHDXWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:22:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AF00200326;
        Wed,  5 Aug 2020 01:22:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C711201346;
        Wed,  5 Aug 2020 01:22:07 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8CCA4402CF;
        Wed,  5 Aug 2020 01:21:58 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        peng.fan@nxp.com, abel.vesa@nxp.com, j.remmet@phytec.de,
        laurent.pinchart@ideasonboard.com, yuehaibing@huawei.com,
        andrew.smirnov@gmail.com, horia.geanta@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] clk: imx: Explicitly include bits.h
Date:   Wed,  5 Aug 2020 07:17:29 +0800
Message-Id: <1596583049-7305-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to explicitly include the required header file rather
then get it through some recursive include.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-busy.c           | 1 +
 drivers/clk/imx/clk-composite-7ulp.c | 1 +
 drivers/clk/imx/clk-fixup-mux.c      | 1 +
 drivers/clk/imx/clk-imx6q.c          | 1 +
 drivers/clk/imx/clk-imx6sx.c         | 1 +
 drivers/clk/imx/clk-imx7d.c          | 1 +
 drivers/clk/imx/clk-lpcg-scu.c       | 1 +
 drivers/clk/imx/clk-pll14xx.c        | 2 +-
 drivers/clk/imx/clk-pllv1.c          | 1 +
 drivers/clk/imx/clk-pllv4.c          | 1 +
 drivers/clk/imx/clk-vf610.c          | 1 +
 drivers/clk/imx/clk.c                | 1 +
 drivers/clk/imx/clk.h                | 1 +
 13 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
index 25c863d..6f17311 100644
--- a/drivers/clk/imx/clk-busy.c
+++ b/drivers/clk/imx/clk-busy.c
@@ -4,6 +4,7 @@
  * Copyright 2012 Linaro Ltd.
  */
 
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
index b9efcc8..7c4f31b 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -5,6 +5,7 @@
  *
  */
 
+#include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/imx/clk-fixup-mux.c b/drivers/clk/imx/clk-fixup-mux.c
index 58a6763..c824015 100644
--- a/drivers/clk/imx/clk-fixup-mux.c
+++ b/drivers/clk/imx/clk-fixup-mux.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2013 Freescale Semiconductor, Inc.
  */
 
+#include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index ba33c79..b2ff187 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -6,6 +6,7 @@
 
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 89ba712..20dcce5 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx6sx-clock.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index b2057bd..6197710 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx7d-clock.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index a73a799..1f0e44f 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -4,6 +4,7 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
+#include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index f5c3e7e..aba36e4 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -3,7 +3,7 @@
  * Copyright 2017-2018 NXP.
  */
 
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/export.h>
diff --git a/drivers/clk/imx/clk-pllv1.c b/drivers/clk/imx/clk-pllv1.c
index de4f8a4..36ffb05 100644
--- a/drivers/clk/imx/clk-pllv1.c
+++ b/drivers/clk/imx/clk-pllv1.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
index a494504..8ec703f2 100644
--- a/drivers/clk/imx/clk-pllv4.c
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 5129ef8..8773f4c 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/of_address.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/syscore_ops.h>
 #include <dt-bindings/clock/vf610-clock.h>
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 547cade..47882c5 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index dd47c19..3b796b3 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -2,6 +2,7 @@
 #ifndef __MACH_IMX_CLK_H
 #define __MACH_IMX_CLK_H
 
+#include <linux/bits.h>
 #include <linux/spinlock.h>
 #include <linux/clk-provider.h>
 
-- 
2.7.4

