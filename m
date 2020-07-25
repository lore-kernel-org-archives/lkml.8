Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B23C433EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1342074F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgGYFMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:12:21 -0400
Received: from out28-100.mail.aliyun.com ([115.124.28.100]:39737 "EHLO
        out28-100.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGYFMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:12:16 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2196652|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.184409-0.000282952-0.815308;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07447;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I7G.t3W_1595653922;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I7G.t3W_1595653922)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sat, 25 Jul 2020 13:12:11 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH 3/3] clk: Ingenic: Add RTC related clocks for Ingenic SoCs.
Date:   Sat, 25 Jul 2020 13:11:36 +0800
Message-Id: <20200725051136.58220-4-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200725051136.58220-1-zhouyanjie@wanyeetech.com>
References: <20200725051136.58220-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC unit in the Ingenic SoCs has two clock sources, one
is from an external 32.768kHz clock, and the other is from an
external 24MHz/48MHz main clock that is divided by 512. The
choice of these two clocks is controlled by the ERCS bit in
the OPCR register. The RNG unit will also use this clock.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/clk/ingenic/jz4780-cgu.c | 12 ++++++++++++
 drivers/clk/ingenic/x1000-cgu.c  | 13 +++++++++++++
 drivers/clk/ingenic/x1830-cgu.c  | 13 +++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 6c5b8029cc8a..288e9694285b 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -516,6 +516,18 @@ static const struct ingenic_cgu_clk_info jz4780_cgu_clocks[] = {
 		.gate = { CGU_REG_CLKGR0, 1 },
 	},
 
+	[JZ4780_CLK_EXCLK_DIV512] = {
+		"exclk_div512", CGU_CLK_FIXDIV,
+		.parents = { JZ4780_CLK_EXCLK },
+		.fixdiv = { 512 },
+	},
+
+	[JZ4780_CLK_RTC] = {
+		"rtc_ercs", CGU_CLK_MUX | CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK_DIV512, JZ4780_CLK_RTCLK },
+		.mux = { CGU_REG_OPCR, 2, 1},
+	},
+
 	/* Gate-only clocks */
 
 	[JZ4780_CLK_NEMC] = {
diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index 453f3323cb99..3cc37466ce6b 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -278,6 +278,19 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.mux = { CGU_REG_SSICDR, 30, 1 },
 	},
 
+	[X1000_CLK_EXCLK_DIV512] = {
+		"exclk_div512", CGU_CLK_FIXDIV,
+		.parents = { X1000_CLK_EXCLK },
+		.fixdiv = { 512 },
+	},
+
+	[X1000_CLK_RTC] = {
+		"rtc_ercs", CGU_CLK_MUX | CGU_CLK_GATE,
+		.parents = { X1000_CLK_EXCLK_DIV512, X1000_CLK_RTCLK },
+		.mux = { CGU_REG_OPCR, 2, 1},
+		.gate = { CGU_REG_CLKGR, 27 },
+	},
+
 	/* Gate-only clocks */
 
 	[X1000_CLK_EMC] = {
diff --git a/drivers/clk/ingenic/x1830-cgu.c b/drivers/clk/ingenic/x1830-cgu.c
index a1b2ff0ee487..950aee243364 100644
--- a/drivers/clk/ingenic/x1830-cgu.c
+++ b/drivers/clk/ingenic/x1830-cgu.c
@@ -329,6 +329,19 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 		.mux = { CGU_REG_SSICDR, 29, 1 },
 	},
 
+	[X1830_CLK_EXCLK_DIV512] = {
+		"exclk_div512", CGU_CLK_FIXDIV,
+		.parents = { X1830_CLK_EXCLK },
+		.fixdiv = { 512 },
+	},
+
+	[X1830_CLK_RTC] = {
+		"rtc_ercs", CGU_CLK_MUX | CGU_CLK_GATE,
+		.parents = { X1830_CLK_EXCLK_DIV512, X1830_CLK_RTCLK },
+		.mux = { CGU_REG_OPCR, 2, 1},
+		.gate = { CGU_REG_CLKGR0, 29 },
+	},
+
 	/* Gate-only clocks */
 
 	[X1830_CLK_EMC] = {
-- 
2.11.0

