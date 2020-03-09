Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBC0C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2448D24656
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCITnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:43:11 -0400
Received: from v6.sk ([167.172.42.174]:34560 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgCITnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:10 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 889F660FF9;
        Mon,  9 Mar 2020 19:43:08 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 02/17] clk: mmp2: Constify some strings
Date:   Mon,  9 Mar 2020 20:42:39 +0100
Message-Id: <20200309194254.29009-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the parent clock names for the muxes are constant. Add const.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-mix.c     |  2 +-
 drivers/clk/mmp/clk-of-mmp2.c | 13 +++++++------
 drivers/clk/mmp/clk.h         |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
index d2cd36c54474f..7a351ec65564e 100644
--- a/drivers/clk/mmp/clk-mix.c
+++ b/drivers/clk/mmp/clk-mix.c
@@ -441,7 +441,7 @@ const struct clk_ops mmp_clk_mix_ops = {
 
 struct clk *mmp_clk_register_mix(struct device *dev,
 					const char *name,
-					const char **parent_names,
+					const char * const *parent_names,
 					u8 num_parents,
 					unsigned long flags,
 					struct mmp_clk_mix_config *config,
diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 6e71591e63a00..ee086d9714160 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -127,16 +127,16 @@ static void mmp2_pll_init(struct mmp2_clk_unit *pxa_unit)
 static DEFINE_SPINLOCK(uart0_lock);
 static DEFINE_SPINLOCK(uart1_lock);
 static DEFINE_SPINLOCK(uart2_lock);
-static const char *uart_parent_names[] = {"uart_pll", "vctcxo"};
+static const char * const uart_parent_names[] = {"uart_pll", "vctcxo"};
 
 static DEFINE_SPINLOCK(ssp0_lock);
 static DEFINE_SPINLOCK(ssp1_lock);
 static DEFINE_SPINLOCK(ssp2_lock);
 static DEFINE_SPINLOCK(ssp3_lock);
-static const char *ssp_parent_names[] = {"vctcxo_4", "vctcxo_2", "vctcxo", "pll1_16"};
+static const char * const ssp_parent_names[] = {"vctcxo_4", "vctcxo_2", "vctcxo", "pll1_16"};
 
 static DEFINE_SPINLOCK(timer_lock);
-static const char *timer_parent_names[] = {"clk32", "vctcxo_4", "vctcxo_2", "vctcxo"};
+static const char * const timer_parent_names[] = {"clk32", "vctcxo_4", "vctcxo_2", "vctcxo"};
 
 static DEFINE_SPINLOCK(reset_lock);
 
@@ -190,7 +190,7 @@ static void mmp2_apb_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
 }
 
 static DEFINE_SPINLOCK(sdh_lock);
-static const char *sdh_parent_names[] = {"pll1_4", "pll2", "usb_pll", "pll1"};
+static const char * const sdh_parent_names[] = {"pll1_4", "pll2", "usb_pll", "pll1"};
 static struct mmp_clk_mix_config sdh_mix_config = {
 	.reg_info = DEFINE_MIX_REG_INFO(4, 10, 2, 8, 32),
 };
@@ -201,11 +201,12 @@ static DEFINE_SPINLOCK(usbhsic1_lock);
 
 static DEFINE_SPINLOCK(disp0_lock);
 static DEFINE_SPINLOCK(disp1_lock);
-static const char *disp_parent_names[] = {"pll1", "pll1_16", "pll2", "vctcxo"};
+static const char * const disp_parent_names[] = {"pll1", "pll1_16", "pll2", "vctcxo"};
 
 static DEFINE_SPINLOCK(ccic0_lock);
 static DEFINE_SPINLOCK(ccic1_lock);
-static const char *ccic_parent_names[] = {"pll1_2", "pll1_16", "vctcxo"};
+static const char * const ccic_parent_names[] = {"pll1_2", "pll1_16", "vctcxo"};
+
 static struct mmp_clk_mix_config ccic0_mix_config = {
 	.reg_info = DEFINE_MIX_REG_INFO(4, 17, 2, 6, 32),
 };
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index 5bcbced3f458e..37d1e1d7b664c 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -97,7 +97,7 @@ struct mmp_clk_mix {
 extern const struct clk_ops mmp_clk_mix_ops;
 extern struct clk *mmp_clk_register_mix(struct device *dev,
 					const char *name,
-					const char **parent_names,
+					const char * const *parent_names,
 					u8 num_parents,
 					unsigned long flags,
 					struct mmp_clk_mix_config *config,
@@ -193,7 +193,7 @@ void mmp_register_gate_clks(struct mmp_clk_unit *unit,
 struct mmp_param_mux_clk {
 	unsigned int id;
 	char *name;
-	const char **parent_name;
+	const char * const *parent_name;
 	u8 num_parents;
 	unsigned long flags;
 	unsigned long offset;
-- 
2.25.1

