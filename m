Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEBBC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CBC20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgBLJIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:08:45 -0500
Received: from inva020.nxp.com ([92.121.34.13]:51734 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgBLJIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:08:44 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 690011A3CE4;
        Wed, 12 Feb 2020 10:08:40 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 696F91A09E5;
        Wed, 12 Feb 2020 10:08:31 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AC410402A9;
        Wed, 12 Feb 2020 17:08:20 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, peng.fan@nxp.com, broonie@kernel.org,
        tglx@linutronix.de, allison@lohutok.net,
        gregkh@linuxfoundation.org, rfontana@redhat.com, info@metux.net,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] clk: imx: drop redundant initialization
Date:   Wed, 12 Feb 2020 17:03:00 +0800
Message-Id: <1581498180-2652-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to initialize flags as 0, remove the initialization.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 2 +-
 drivers/clk/imx/clk-fixup-div.c    | 2 +-
 drivers/clk/imx/clk-fixup-mux.c    | 2 +-
 drivers/clk/imx/clk-gate2.c        | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 20f7c91..a35407b 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -91,7 +91,7 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 					unsigned long parent_rate)
 {
 	struct clk_divider *divider = to_clk_divider(hw);
-	unsigned long flags = 0;
+	unsigned long flags;
 	int prediv_value;
 	int div_value;
 	int ret;
diff --git a/drivers/clk/imx/clk-fixup-div.c b/drivers/clk/imx/clk-fixup-div.c
index 4b17b91..100ca82 100644
--- a/drivers/clk/imx/clk-fixup-div.c
+++ b/drivers/clk/imx/clk-fixup-div.c
@@ -55,7 +55,7 @@ static int clk_fixup_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_fixup_div *fixup_div = to_clk_fixup_div(hw);
 	struct clk_divider *div = to_clk_divider(hw);
 	unsigned int divider, value;
-	unsigned long flags = 0;
+	unsigned long flags;
 	u32 val;
 
 	divider = parent_rate / rate;
diff --git a/drivers/clk/imx/clk-fixup-mux.c b/drivers/clk/imx/clk-fixup-mux.c
index b569d91..58a6763 100644
--- a/drivers/clk/imx/clk-fixup-mux.c
+++ b/drivers/clk/imx/clk-fixup-mux.c
@@ -42,7 +42,7 @@ static int clk_fixup_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_fixup_mux *fixup_mux = to_clk_fixup_mux(hw);
 	struct clk_mux *mux = to_clk_mux(hw);
-	unsigned long flags = 0;
+	unsigned long flags;
 	u32 val;
 
 	spin_lock_irqsave(mux->lock, flags);
diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index 7d44ce8..72a7698 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -40,7 +40,7 @@ static int clk_gate2_enable(struct clk_hw *hw)
 {
 	struct clk_gate2 *gate = to_clk_gate2(hw);
 	u32 reg;
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	spin_lock_irqsave(gate->lock, flags);
 
@@ -62,7 +62,7 @@ static void clk_gate2_disable(struct clk_hw *hw)
 {
 	struct clk_gate2 *gate = to_clk_gate2(hw);
 	u32 reg;
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	spin_lock_irqsave(gate->lock, flags);
 
@@ -101,7 +101,7 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
 static void clk_gate2_disable_unused(struct clk_hw *hw)
 {
 	struct clk_gate2 *gate = to_clk_gate2(hw);
-	unsigned long flags = 0;
+	unsigned long flags;
 	u32 reg;
 
 	spin_lock_irqsave(gate->lock, flags);
-- 
2.7.4

