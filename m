Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC4FC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE58A2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbgEKTZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:25:44 -0400
Received: from v6.sk ([167.172.42.174]:52348 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731572AbgEKTZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:25:41 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 2D5AF610CF;
        Mon, 11 May 2020 19:25:40 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 08/10] clk: mmp2: Add the audio clock
Date:   Mon, 11 May 2020 21:25:15 +0200
Message-Id: <20200511192517.1206442-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511192517.1206442-1-lkundrak@v3.sk>
References: <20200511192517.1206442-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clocks the Audio block.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index dcdff06a698a..c686c16fca82 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -62,6 +62,7 @@
 #define APMU_USBHSIC0	0xf8
 #define APMU_USBHSIC1	0xfc
 #define APMU_GPU	0xcc
+#define APMU_AUDIO	0x10c
 
 #define MPMU_FCCR		0x8
 #define MPMU_POSR		0x10
@@ -317,6 +318,8 @@ static u32 mmp2_gpu_bus_parent_table[] =         { 0x0000,   0x0020,   0x0030,
 static const char * const mmp3_gpu_bus_parent_names[] = {"pll1_4", "pll1_6", "pll1_2", "pll2_2"};
 static const char * const mmp3_gpu_gc_parent_names[] =  {"pll1",   "pll2",   "pll1_p", "pll2_p"};
 
+static DEFINE_SPINLOCK(audio_lock);
+
 static struct mmp_clk_mix_config ccic0_mix_config = {
 	.reg_info = DEFINE_MIX_REG_INFO(4, 17, 2, 6, 32),
 };
@@ -372,6 +375,7 @@ static struct mmp_param_gate_clk apmu_gate_clks[] = {
 	{MMP2_CLK_CCIC1_PHY, "ccic1_phy_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x24, 0x24, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_SPHY, "ccic1_sphy_clk", "ccic1_sphy_div", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x300, 0x300, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_GPU_BUS, "gpu_bus_clk", "gpu_bus_mux", CLK_SET_RATE_PARENT, APMU_GPU, 0xa, 0xa, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock},
+	{MMP2_CLK_AUDIO, "audio_clk", "audio_mix_clk", CLK_SET_RATE_PARENT, APMU_AUDIO, 0x12, 0x12, 0x0, 0, &audio_lock},
 };
 
 static struct mmp_param_gate_clk mmp2_apmu_gate_clks[] = {
-- 
2.26.2

