Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE99BC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE2B21D81
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="0Vr/iUCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgF2Sja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgF2Sh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:59 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF58C031428
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:21:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so15970195qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acMY/PDEeXIX2iUBf49C2Sg8svQXM/66G883KF7yr14=;
        b=0Vr/iUCTL0YCeERQJU5A4XFXP9WRqstSxzdmUQD6ykn1ca7JzGnnei2ewZDfArLcSu
         CYypdB2pqO57zT6zodFJ+ZD2IJlbzrIK+M+0o5ZTdkG8QVZhgL9zkp0H1qxCaw466lPK
         6Bvj8YaLOMYtN4/izEybXm6/6yU52gkFLcOx+I3rM5FhrNY74YEXLbbNt48iXwhoEPPu
         iXBbUAWO7sDhCLWBK888xnmlUL60CSL1wubqDtYE+gsqRKrAtDHB1OF8tXE7vDS8nrL4
         PTrSsSyc3GZc2W9tFD0ZGVWlquLpWeYBoT0Xyb1zNWMo124SuQuu2KPXpOSkUPdRlH8B
         rUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acMY/PDEeXIX2iUBf49C2Sg8svQXM/66G883KF7yr14=;
        b=qd30uSyngEo6+leg7nSN7/i3hi5FZ8YjUfeM4ozY1yPd7s7UYZu4yH18K8dPa/3AYc
         /1/fUvUjpUphUMRoLQ/MUjSPayOirpbHeTBpfzr5CdLulisIncm8PC0Q0WiOTahMwpWF
         DF4Knt9Nn9h7ArmCA0RPE6HsnzZagSPNyrSppljWOYsvf+0bLIQO1j8fUjUbhhKDvIIK
         gPm5Uzx6fRce8lVXV+2/g2n3Hv39tL2vSq0kAAjVM09i4bolKE+RixpTgptEBfBdPnKy
         YmiKRDyU0YDIQaAH8xLMkj0K+noRwhQOLlFY5i0A+1ryGtr09fUH1bVR607DRzyN42l4
         In3A==
X-Gm-Message-State: AOAM533FPH1kGvaL7zX4XQ5PRCotPUK0DJKw9Wb9pJy73W69uleDgTc2
        KG2iAagnBcONl4xxgzdRTEXRkg==
X-Google-Smtp-Source: ABdhPJyEZvgI7BCAXGHakCfxARGoDPMIkgxM8m5Edq3X5e6ibIASdaGalKlTTXkySTsiXwmys77+LA==
X-Received: by 2002:a05:620a:483:: with SMTP id 3mr15187886qkr.299.1593451266376;
        Mon, 29 Jun 2020 10:21:06 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id q5sm408363qtf.12.2020.06.29.10.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:21:06 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/13] clk: qcom: gcc: remove unnecessary vco_table from SM8150
Date:   Mon, 29 Jun 2020 13:20:35 -0400
Message-Id: <20200629172049.30452-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629172049.30452-1-jonathan@marek.ca>
References: <20200629172049.30452-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixed alpha pll ops only use it for clamping in round_rate, which is
unnecessary. This is consistent with SM8250 GCC not using vco_table.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/clk/qcom/gcc-sm8150.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index d7778def37da..8e9b5b3cceaf 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -34,14 +34,8 @@ enum {
 	P_SLEEP_CLK,
 };
 
-static const struct pll_vco trion_vco[] = {
-	{ 249600000, 2000000000, 0 },
-};
-
 static struct clk_alpha_pll gpll0 = {
 	.offset = 0x0,
-	.vco_table = trion_vco,
-	.num_vco = ARRAY_SIZE(trion_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TRION],
 	.clkr = {
 		.enable_reg = 0x52000,
@@ -85,8 +79,6 @@ static struct clk_alpha_pll_postdiv gpll0_out_even = {
 
 static struct clk_alpha_pll gpll7 = {
 	.offset = 0x1a000,
-	.vco_table = trion_vco,
-	.num_vco = ARRAY_SIZE(trion_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TRION],
 	.clkr = {
 		.enable_reg = 0x52000,
@@ -105,8 +97,6 @@ static struct clk_alpha_pll gpll7 = {
 
 static struct clk_alpha_pll gpll9 = {
 	.offset = 0x1c000,
-	.vco_table = trion_vco,
-	.num_vco = ARRAY_SIZE(trion_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TRION],
 	.clkr = {
 		.enable_reg = 0x52000,
-- 
2.26.1

