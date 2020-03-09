Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A8AC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E5C24656
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCITn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:43:58 -0400
Received: from v6.sk ([167.172.42.174]:34748 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgCITn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:57 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 835216130D;
        Mon,  9 Mar 2020 19:43:55 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 14/17] clk: mmp2: Add clocks for the thermal sensors
Date:   Mon,  9 Mar 2020 20:42:51 +0100
Message-Id: <20200309194254.29009-15-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register definitions gotten from OLPC Open Firmware.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Added this patch

 drivers/clk/mmp/clk-of-mmp2.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 208c67df482a9..0057a53905d8b 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -54,6 +54,10 @@
 #define APMU_DISP1	0x110
 #define APMU_CCIC0	0x50
 #define APMU_CCIC1	0xf4
+#define APBC_THERMAL0	0x90
+#define APBC_THERMAL1	0x98
+#define APBC_THERMAL2	0x9c
+#define APBC_THERMAL3	0xa0
 #define APMU_USBHSIC0	0xf8
 #define APMU_USBHSIC1	0xfc
 #define APMU_GPU	0xcc
@@ -215,6 +219,13 @@ static struct mmp_param_gate_clk apbc_gate_clks[] = {
 	{MMP2_CLK_SSP2, "ssp2_clk", "ssp2_mux", CLK_SET_RATE_PARENT, APBC_SSP2, 0x7, 0x3, 0x0, 0, &ssp2_lock},
 	{MMP2_CLK_SSP3, "ssp3_clk", "ssp3_mux", CLK_SET_RATE_PARENT, APBC_SSP3, 0x7, 0x3, 0x0, 0, &ssp3_lock},
 	{MMP2_CLK_TIMER, "timer_clk", "timer_mux", CLK_SET_RATE_PARENT, APBC_TIMER, 0x7, 0x3, 0x0, 0, &timer_lock},
+	{MMP2_CLK_THERMAL0, "thermal0_clk", "vctcxo", CLK_SET_RATE_PARENT, APBC_THERMAL0, 0x7, 0x3, 0x0, MMP_CLK_GATE_NEED_DELAY, &reset_lock},
+};
+
+static struct mmp_param_gate_clk mmp3_apbc_gate_clks[] = {
+	{MMP3_CLK_THERMAL1, "thermal1_clk", "vctcxo", CLK_SET_RATE_PARENT, APBC_THERMAL1, 0x7, 0x3, 0x0, MMP_CLK_GATE_NEED_DELAY, &reset_lock},
+	{MMP3_CLK_THERMAL2, "thermal2_clk", "vctcxo", CLK_SET_RATE_PARENT, APBC_THERMAL2, 0x7, 0x3, 0x0, MMP_CLK_GATE_NEED_DELAY, &reset_lock},
+	{MMP3_CLK_THERMAL3, "thermal3_clk", "vctcxo", CLK_SET_RATE_PARENT, APBC_THERMAL3, 0x7, 0x3, 0x0, MMP_CLK_GATE_NEED_DELAY, &reset_lock},
 };
 
 static void mmp2_apb_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
@@ -226,6 +237,11 @@ static void mmp2_apb_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
 
 	mmp_register_gate_clks(unit, apbc_gate_clks, pxa_unit->apbc_base,
 				ARRAY_SIZE(apbc_gate_clks));
+
+	if (pxa_unit->model == CLK_MODEL_MMP3) {
+		mmp_register_gate_clks(unit, mmp3_apbc_gate_clks, pxa_unit->apbc_base,
+					ARRAY_SIZE(mmp3_apbc_gate_clks));
+	}
 }
 
 static DEFINE_SPINLOCK(sdh_lock);
-- 
2.25.1

