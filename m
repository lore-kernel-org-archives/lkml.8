Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C61C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 10:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BC620727
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 10:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PK7nMudt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgEQKEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 06:04:38 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:11547 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgEQKEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 06:04:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589709876; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=9/JNa8z964ok++lan9V15rFE/ELKLV0FIgQLeNardGw=; b=PK7nMudtLBNGcXhxNpV0ZNwjiH9FJ9Oc0ol2Crhr/IkcbSiwf8VGa30clLzYzFITSVUm/2U3
 Cpbx7SBrBA9gBkDH5uC0+6XI0ZBasvMtCAYKmkovAWSg8YTKobIGVT6V/amdVcFpPDmS5b1m
 PD+3IC+8spwRxZJgkIQchigSsRo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec10c34.7efd179ee3b0-smtp-out-n02;
 Sun, 17 May 2020 10:04:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7227CC433F2; Sun, 17 May 2020 10:04:36 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B270EC432C2;
        Sun, 17 May 2020 10:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B270EC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 1/3] clk: qcom: gcc: Add support for a new frequency for SC7180
Date:   Sun, 17 May 2020 15:34:19 +0530
Message-Id: <1589709861-27580-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589709861-27580-1-git-send-email-tdas@codeaurora.org>
References: <1589709861-27580-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a requirement to support 51.2MHz from GPLL6 for qup clocks,
thus update the frequency table and parent data/map to use the GPLL6
source PLL.

Fixes: 17269568f7267 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/gcc-sc7180.c | 73 ++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index 6a51b5b..7338052 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -390,6 +390,7 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	F(29491200, P_GPLL0_OUT_EVEN, 1, 1536, 15625),
 	F(32000000, P_GPLL0_OUT_EVEN, 1, 8, 75),
 	F(48000000, P_GPLL0_OUT_EVEN, 1, 4, 25),
+	F(51200000, P_GPLL6_OUT_MAIN, 7.5, 0, 0),
 	F(64000000, P_GPLL0_OUT_EVEN, 1, 16, 75),
 	F(75000000, P_GPLL0_OUT_EVEN, 4, 0, 0),
 	F(80000000, P_GPLL0_OUT_EVEN, 1, 4, 15),
@@ -405,8 +406,8 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {

 static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s0_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -414,15 +415,15 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
 	.cmd_rcgr = 0x17034,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap0_s0_clk_src_init,
 };

 static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s1_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -430,15 +431,15 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
 	.cmd_rcgr = 0x17164,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap0_s1_clk_src_init,
 };

 static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s2_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -446,15 +447,15 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
 	.cmd_rcgr = 0x17294,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap0_s2_clk_src_init,
 };

 static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s3_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -462,15 +463,15 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
 	.cmd_rcgr = 0x173c4,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap0_s3_clk_src_init,
 };

 static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s4_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -478,15 +479,15 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
 	.cmd_rcgr = 0x174f4,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap0_s4_clk_src_init,
 };

 static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s5_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -494,15 +495,15 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
 	.cmd_rcgr = 0x17624,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap0_s5_clk_src_init,
 };

 static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s0_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -510,15 +511,15 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
 	.cmd_rcgr = 0x18018,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap1_s0_clk_src_init,
 };

 static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s1_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -526,15 +527,15 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
 	.cmd_rcgr = 0x18148,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap1_s1_clk_src_init,
 };

 static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s2_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -542,15 +543,15 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
 	.cmd_rcgr = 0x18278,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap1_s2_clk_src_init,
 };

 static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s3_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -558,15 +559,15 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
 	.cmd_rcgr = 0x183a8,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap1_s3_clk_src_init,
 };

 static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s4_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -574,15 +575,15 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
 	.cmd_rcgr = 0x184d8,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap1_s4_clk_src_init,
 };

 static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s5_clk_src",
-	.parent_data = gcc_parent_data_0,
-	.num_parents = 4,
+	.parent_data = gcc_parent_data_1,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 	.ops = &clk_rcg2_ops,
 };

@@ -590,7 +591,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
 	.cmd_rcgr = 0x18608,
 	.mnd_width = 16,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
+	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
 	.clkr.hw.init = &gcc_qupv3_wrap1_s5_clk_src_init,
 };
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
