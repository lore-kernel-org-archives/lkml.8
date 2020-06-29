Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F917C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4509A206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="abiB2Zdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390884AbgF2VTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390817AbgF2VSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:18:41 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1336AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:18:41 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t11so6298965qvk.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ufJ+qo3NfI0pabE9TlU5wbhOS8NacG5qNuj9VUJYPk=;
        b=abiB2ZdublwAgbqainIsZDDL7hwexcq5V4Qu5eO1In0zlU8HL5Uk0paPZoDEIT+F2r
         3Dx4Bb5nrFv0BMlsf/NpPY21zbxt6CgwyaZ8x9aQCAxI0FMpoLGxsh7cBR51vnzJm126
         tySR9SLOoRg4u//1W9L/xL8P6OrqLBVM30FrjYFFchQFHfJyWNbJMtrIbjVxBEno7Frl
         84egqjdSAP5Bx8W8QwQtnFW68/BNpvVaLfYwEod2MsfuE1B9aGHnjMAeSOhKZR8Jr/r4
         l4FZ4EfK9uIQCQRU5SMtyY0YSOxJXsvvKh8xQJ0tJ3hpFaj+j3ls4M2BtFeUXWXYoRCU
         ZeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ufJ+qo3NfI0pabE9TlU5wbhOS8NacG5qNuj9VUJYPk=;
        b=DwAA6mPR4F5gPRvVlfsH4hZRRvCU/DfRA1If7edqLv8iUigT6UIzk22JwQdQM0QA56
         BZwEJryDi8fTfiaCTUBXDvDfMVRSJ3qx3TY9rXxBtTpUkDAfOfAIEyyR2zdHykow0g0T
         iKXYQtLRXAwgS+y4bYTbJsDoQipbKaq707zO1lofA/wZ2GUniJaooiPI6FvpMw/IrjcO
         p+/Tv7mutEHGkPF8z4LRk3OJ07VueGLa94Gq7zuuNMK4gc1LlHGXnaEtbkdBSMR3EjCd
         iSSFNBQqE9wEDpfp2q8+hfO1JbzwfVMVztTaZg7N3f37BuzDjpFD8+5iaYB5nkVM74Cu
         65aw==
X-Gm-Message-State: AOAM530/Xm8Z1csDO5KkWxyXzm0hzHS6tzoCXwfGvCbpl39RRNK1K4HK
        LAoq0LxTGU34xO3qH51AoI1dvA==
X-Google-Smtp-Source: ABdhPJyW3vONYWwagwcT/E5LbMxblcPJQ9SYEqEOFy7qnO74HXRsjhr9PEVm71TVCuGtYhX486ER6Q==
X-Received: by 2002:a05:6214:942:: with SMTP id dn2mr17312051qvb.161.1593465520291;
        Mon, 29 Jun 2020 14:18:40 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id b196sm1169078qkg.11.2020.06.29.14.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:18:39 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v2 04/13] clk: qcom: clk-alpha-pll: use the right PCAL_DONE value for lucid pll
Date:   Mon, 29 Jun 2020 17:17:10 -0400
Message-Id: <20200629211725.2592-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629211725.2592-1-jonathan@marek.ca>
References: <20200629211725.2592-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lucid PCAL_DONE is different from trion.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/clk/qcom/clk-alpha-pll.c | 28 ++++++++++++++++++++++++++--
 drivers/clk/qcom/clk-alpha-pll.h |  2 +-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index be7ffeae21b1..26139ef005e4 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -143,6 +143,9 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 #define TRION_PLL_CAL_VAL	0x44
 #define TRION_PCAL_DONE		BIT(26)
 
+/* LUCID PLL specific settings and offsets */
+#define LUCID_PCAL_DONE		BIT(27)
+
 #define pll_alpha_width(p)					\
 		((PLL_ALPHA_VAL_U(p) - PLL_ALPHA_VAL(p) == 4) ?	\
 				 ALPHA_REG_BITWIDTH : ALPHA_REG_16BIT_WIDTH)
@@ -1447,7 +1450,7 @@ EXPORT_SYMBOL_GPL(clk_trion_pll_configure);
  * The TRION PLL requires a power-on self-calibration which happens when the
  * PLL comes out of reset. Calibrate in case it is not completed.
  */
-static int alpha_pll_trion_prepare(struct clk_hw *hw)
+static int __alpha_pll_trion_prepare(struct clk_hw *hw, u32 pcal_done)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 regval;
@@ -1455,7 +1458,7 @@ static int alpha_pll_trion_prepare(struct clk_hw *hw)
 
 	/* Return early if calibration is not needed. */
 	regmap_read(pll->clkr.regmap, PLL_STATUS(pll), &regval);
-	if (regval & TRION_PCAL_DONE)
+	if (regval & pcal_done)
 		return 0;
 
 	/* On/off to calibrate */
@@ -1466,6 +1469,16 @@ static int alpha_pll_trion_prepare(struct clk_hw *hw)
 	return ret;
 }
 
+static int alpha_pll_trion_prepare(struct clk_hw *hw)
+{
+	return __alpha_pll_trion_prepare(hw, TRION_PCAL_DONE);
+}
+
+static int alpha_pll_lucid_prepare(struct clk_hw *hw)
+{
+	return __alpha_pll_trion_prepare(hw, LUCID_PCAL_DONE);
+}
+
 static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
 				    unsigned long prate)
 {
@@ -1529,6 +1542,17 @@ const struct clk_ops clk_alpha_pll_trion_ops = {
 	.round_rate = clk_alpha_pll_round_rate,
 	.set_rate = alpha_pll_trion_set_rate,
 };
+EXPORT_SYMBOL_GPL(clk_alpha_pll_trion_ops);
+
+const struct clk_ops clk_alpha_pll_lucid_ops = {
+	.prepare = alpha_pll_lucid_prepare,
+	.enable = clk_trion_pll_enable,
+	.disable = clk_trion_pll_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = clk_trion_pll_recalc_rate,
+	.round_rate = clk_alpha_pll_round_rate,
+	.set_rate = alpha_pll_trion_set_rate,
+};
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_ops = {
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 67f1fd271931..69337c1b5850 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -132,7 +132,7 @@ extern const struct clk_ops clk_alpha_pll_trion_ops;
 extern const struct clk_ops clk_alpha_pll_fixed_trion_ops;
 extern const struct clk_ops clk_alpha_pll_postdiv_trion_ops;
 
-#define clk_alpha_pll_lucid_ops clk_alpha_pll_trion_ops
+extern const struct clk_ops clk_alpha_pll_lucid_ops;
 #define clk_alpha_pll_fixed_lucid_ops clk_alpha_pll_fixed_trion_ops
 extern const struct clk_ops clk_alpha_pll_postdiv_lucid_ops;
 
-- 
2.26.1

