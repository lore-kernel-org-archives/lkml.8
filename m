Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF3EC47258
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826D7206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/A7OFjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgEFGmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727778AbgEFGmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:42:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C8C061A0F;
        Tue,  5 May 2020 23:42:49 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q124so343844pgq.13;
        Tue, 05 May 2020 23:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OYAtQovas94oeU9iNU8MsCCycx+f76DGkCEYi2Qp+I=;
        b=l/A7OFjUswLmXEWx30U77o4/Wz7vsqghg9D/5bpCSueH68jULm3lmf58hL8+qMqpAJ
         i1747OQhv44vyaZ58GQ0UTYJmOp9034n+D9ebtjM6DSA82ofsmBaIhAWJIPk1YOzNvZj
         YewtH6m3zMLHZujXRq3dLBkfEXJAc/Xbe00F/UDNj/KbK0tPLv3jQq8IVf9E72uaZQ0M
         dboPrjM4njMwLoj/Wq+/bNOKAYaCvaC5uwF1GuX1EAA9Bl7OMz23N1S5/+cxbQVMrqS6
         jMPE6+Q3/ZdlMYlnh2fT25NXVSzpa+jRXnGqlPIL+UU5p4wYGne40lOXu5YdT7tNjxKw
         GxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6OYAtQovas94oeU9iNU8MsCCycx+f76DGkCEYi2Qp+I=;
        b=ahOGoW7vMhwIxMDCQsx9z2Ui8oywRDipDx6+pvBR+DBBnIhdqPuLH0wJNCB7naBKOi
         74DbEpxFLqUzqT+ZdpujWmsdIFReJk3GdEQohjCBEZ5KQe9Z3Nl1HqfmPLO9lom/yjpA
         nk0y1CalRdOcY5o/r+mHqMB3FGGdce71oNAHcKVmUVzUxowe+skbShvXL2V3a0rDsgfv
         1P3FxLXXzyIhNahYHon0o/cYZbAn/3iB6VeqJhbzWv5Z5sHUanqkmshfgTP4PX2mAF4f
         6iClqG1GpKUh8kalBb7Er6ztZ7WYd5iFHjigwUczVT50eufn2IAdgt1mt9h1BLNAsJpd
         g1Mw==
X-Gm-Message-State: AGi0PuZ8eryAQKeImMHiaBocVqIpiBBeDCK7eqZ7V2jRBjidIJ4TG5Sd
        OcP39w2ueWY16lsxh4UPtpU=
X-Google-Smtp-Source: APiQypLjH1m7IH+Es3ImYbRw2ZMow3U5CDc3acH8t4Lng+3TAVYPSQ/UIQdCmjvWz6d0JGPABQhw/Q==
X-Received: by 2002:a65:6795:: with SMTP id e21mr928114pgr.171.1588747369351;
        Tue, 05 May 2020 23:42:49 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id b75sm3793254pjc.23.2020.05.05.23.42.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 23:42:49 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mturquette@baylibre.com, sboyd@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        sam@ravnborg.org
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 4/4] clk: stm32f4: fix ltdc driver hang as clk set rate failed
Date:   Wed,  6 May 2020 14:42:38 +0800
Message-Id: <1588747358-31306-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588747358-31306-1-git-send-email-dillon.minfei@gmail.com>
References: <1588747358-31306-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

should use PLL_SAI offset of clks , not PLL_VCO_SAI
else can not get clk gate.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 drivers/clk/clk-stm32f4.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 18117ce..bdebe05 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -129,7 +129,8 @@ static const struct stm32f4_gate_data stm32f429_gates[] __initconst = {
 	{ STM32F4_RCC_APB2ENR, 20,	"spi5",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR, 21,	"spi6",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR, 22,	"sai1",		"apb2_div" },
-	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div",
+		CLK_IGNORE_UNUSED },
 };
 
 static const struct stm32f4_gate_data stm32f469_gates[] __initconst = {
@@ -1754,10 +1755,10 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	stm32f4_rcc_register_pll("vco_in", &data->pll_data[0],
 			&stm32f4_clk_lock);
 
-	clks[PLL_VCO_I2S] = stm32f4_rcc_register_pll("vco_in",
+	clks[PLL_I2S] = stm32f4_rcc_register_pll("vco_in",
 			&data->pll_data[1], &stm32f4_clk_lock);
 
-	clks[PLL_VCO_SAI] = stm32f4_rcc_register_pll("vco_in",
+	clks[PLL_SAI] = stm32f4_rcc_register_pll("vco_in",
 			&data->pll_data[2], &stm32f4_clk_lock);
 
 	for (n = 0; n < MAX_POST_DIV; n++) {
-- 
2.7.4

