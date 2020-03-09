Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE04C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1584424656
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgCITnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:43:51 -0400
Received: from v6.sk ([167.172.42.174]:34714 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgCITnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:50 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 9C1076130A;
        Mon,  9 Mar 2020 19:43:47 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 12/17] clk: mmp2: add the GPU clocks
Date:   Mon,  9 Mar 2020 20:42:49 +0100
Message-Id: <20200309194254.29009-13-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMP2 has a single GC860 core while MMP3 has a GC2000 and a GC300.
On both platforms there's an AXI bus interface clock that's common for
all GPUs and each GPU core has a separate clock.

Meaning of the relevant APMU_GPU bits were gotten from James Cameron's
message and [1], the OLPC OS kernel source [2] and Marvell's MMP3 tree.

[1] http://lists.laptop.org/pipermail/devel/2019-April/039053.html
[2] http://dev.laptop.org/git/olpc-kernel/commit/arch/arm/mach-mmp/mmp2.c?h=arm-3.0-wip&id=8ce9f6122

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Added this patch

 drivers/clk/mmp/clk-of-mmp2.c | 61 +++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 310d77855f03f..208c67df482a9 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -56,6 +56,7 @@
 #define APMU_CCIC1	0xf4
 #define APMU_USBHSIC0	0xf8
 #define APMU_USBHSIC1	0xfc
+#define APMU_GPU	0xcc
 
 #define MPMU_FCCR		0x8
 #define MPMU_POSR		0x10
@@ -245,6 +246,14 @@ static DEFINE_SPINLOCK(ccic0_lock);
 static DEFINE_SPINLOCK(ccic1_lock);
 static const char * const ccic_parent_names[] = {"pll1_2", "pll1_16", "vctcxo"};
 
+static DEFINE_SPINLOCK(gpu_lock);
+static const char * const mmp2_gpu_gc_parent_names[] =  {"pll1_2", "pll1_3", "pll2_2", "pll2_3", "pll2", "usb_pll"};
+static u32 mmp2_gpu_gc_parent_table[] =          { 0x0000,   0x0040,   0x0080,   0x00c0,   0x1000, 0x1040   };
+static const char * const mmp2_gpu_bus_parent_names[] = {"pll1_4", "pll2",   "pll2_2", "usb_pll"};
+static u32 mmp2_gpu_bus_parent_table[] =         { 0x0000,   0x0020,   0x0030,   0x4020   };
+static const char * const mmp3_gpu_bus_parent_names[] = {"pll1_4", "pll1_6", "pll1_2", "pll2_2"};
+static const char * const mmp3_gpu_gc_parent_names[] =  {"pll1",   "pll2",   "pll1_p", "pll2_p"};
+
 static struct mmp_clk_mix_config ccic0_mix_config = {
 	.reg_info = DEFINE_MIX_REG_INFO(4, 17, 2, 6, 32),
 };
@@ -257,6 +266,15 @@ static struct mmp_param_mux_clk apmu_mux_clks[] = {
 	{MMP2_CLK_DISP1_MUX, "disp1_mux", disp_parent_names, ARRAY_SIZE(disp_parent_names), CLK_SET_RATE_PARENT, APMU_DISP1, 6, 2, 0, &disp1_lock},
 };
 
+static struct mmp_param_mux_clk mmp3_apmu_mux_clks[] = {
+	{0, "gpu_bus_mux", mmp3_gpu_bus_parent_names, ARRAY_SIZE(mmp3_gpu_bus_parent_names),
+									CLK_SET_RATE_PARENT, APMU_GPU, 4, 2, 0, &gpu_lock},
+	{0, "gpu_3d_mux", mmp3_gpu_gc_parent_names, ARRAY_SIZE(mmp3_gpu_gc_parent_names),
+									CLK_SET_RATE_PARENT, APMU_GPU, 6, 2, 0, &gpu_lock},
+	{0, "gpu_2d_mux", mmp3_gpu_gc_parent_names, ARRAY_SIZE(mmp3_gpu_gc_parent_names),
+									CLK_SET_RATE_PARENT, APMU_GPU, 12, 2, 0, &gpu_lock},
+};
+
 static struct mmp_param_div_clk apmu_div_clks[] = {
 	{0, "disp0_div", "disp0_mux", CLK_SET_RATE_PARENT, APMU_DISP0, 8, 4, 0, &disp0_lock},
 	{0, "disp0_sphy_div", "disp0_mux", CLK_SET_RATE_PARENT, APMU_DISP0, 15, 5, 0, &disp0_lock},
@@ -265,6 +283,11 @@ static struct mmp_param_div_clk apmu_div_clks[] = {
 	{0, "ccic1_sphy_div", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC1, 10, 5, 0, &ccic1_lock},
 };
 
+static struct mmp_param_div_clk mmp3_apmu_div_clks[] = {
+	{0, "gpu_3d_div", "gpu_3d_mux", CLK_SET_RATE_PARENT, APMU_GPU, 24, 4, 0, &gpu_lock},
+	{0, "gpu_2d_div", "gpu_2d_mux", CLK_SET_RATE_PARENT, APMU_GPU, 28, 4, 0, &gpu_lock},
+};
+
 static struct mmp_param_gate_clk apmu_gate_clks[] = {
 	{MMP2_CLK_USB, "usb_clk", "usb_pll", 0, APMU_USB, 0x9, 0x9, 0x0, 0, &usb_lock},
 	{MMP2_CLK_USBHSIC0, "usbhsic0_clk", "usb_pll", 0, APMU_USBHSIC0, 0x1b, 0x1b, 0x0, 0, &usbhsic0_lock},
@@ -285,6 +308,16 @@ static struct mmp_param_gate_clk apmu_gate_clks[] = {
 	{MMP2_CLK_CCIC1, "ccic1_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x1b, 0x1b, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_PHY, "ccic1_phy_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x24, 0x24, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_SPHY, "ccic1_sphy_clk", "ccic1_sphy_div", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x300, 0x300, 0x0, 0, &ccic1_lock},
+	{MMP2_CLK_GPU_BUS, "gpu_bus_clk", "gpu_bus_mux", CLK_SET_RATE_PARENT, APMU_GPU, 0xa, 0xa, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock},
+};
+
+static struct mmp_param_gate_clk mmp2_apmu_gate_clks[] = {
+	{MMP2_CLK_GPU_3D, "gpu_3d_clk", "gpu_3d_mux", CLK_SET_RATE_PARENT, APMU_GPU, 0x5, 0x5, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock},
+};
+
+static struct mmp_param_gate_clk mmp3_apmu_gate_clks[] = {
+	{MMP3_CLK_GPU_3D, "gpu_3d_clk", "gpu_3d_div", CLK_SET_RATE_PARENT, APMU_GPU, 0x5, 0x5, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock},
+	{MMP3_CLK_GPU_2D, "gpu_2d_clk", "gpu_2d_div", CLK_SET_RATE_PARENT, APMU_GPU, 0x1c0000, 0x1c0000, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock},
 };
 
 static void mmp2_axi_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
@@ -320,6 +353,34 @@ static void mmp2_axi_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
 
 	mmp_register_gate_clks(unit, apmu_gate_clks, pxa_unit->apmu_base,
 				ARRAY_SIZE(apmu_gate_clks));
+
+	if (pxa_unit->model == CLK_MODEL_MMP3) {
+		mmp_register_mux_clks(unit, mmp3_apmu_mux_clks, pxa_unit->apmu_base,
+					ARRAY_SIZE(mmp3_apmu_mux_clks));
+
+		mmp_register_div_clks(unit, mmp3_apmu_div_clks, pxa_unit->apmu_base,
+					ARRAY_SIZE(mmp3_apmu_div_clks));
+
+		mmp_register_gate_clks(unit, mmp3_apmu_gate_clks, pxa_unit->apmu_base,
+					ARRAY_SIZE(mmp3_apmu_gate_clks));
+	} else {
+		clk_register_mux_table(NULL, "gpu_3d_mux", mmp2_gpu_gc_parent_names,
+					ARRAY_SIZE(mmp2_gpu_gc_parent_names),
+					CLK_SET_RATE_PARENT,
+					pxa_unit->apmu_base + APMU_GPU,
+					0, 0x10c0, 0,
+					mmp2_gpu_gc_parent_table, &gpu_lock);
+
+		clk_register_mux_table(NULL, "gpu_bus_mux", mmp2_gpu_bus_parent_names,
+					ARRAY_SIZE(mmp2_gpu_bus_parent_names),
+					CLK_SET_RATE_PARENT,
+					pxa_unit->apmu_base + APMU_GPU,
+					0, 0x4030, 0,
+					mmp2_gpu_bus_parent_table, &gpu_lock);
+
+		mmp_register_gate_clks(unit, mmp2_apmu_gate_clks, pxa_unit->apmu_base,
+					ARRAY_SIZE(mmp2_apmu_gate_clks));
+	}
 }
 
 static void mmp2_clk_reset_init(struct device_node *np,
-- 
2.25.1

