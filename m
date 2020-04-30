Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573E5C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BB520838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFlPir4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgD3Jnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726453AbgD3Jnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:43:50 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C370DC035494;
        Thu, 30 Apr 2020 02:43:50 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w3so2054643plz.5;
        Thu, 30 Apr 2020 02:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PMlWSW6ttnanNb8wF0bobaava2tVkjYUTBjAcm/ZuJs=;
        b=MFlPir4vo3tEZYxlusrpRQF5dV+NyqZ+15+TQFJLozgqv+/HoDTTsM9j5hQMDFgyI5
         /QPcVzxBAlfOI5DCpUcUmQPdN3BpfO5ImVwMShy5sFSa6XAqvb/69oqZIgApPKizVlib
         p2Z0OeoLvAPyMWpI5Ah+svBEvUfQfakzUXEWT/g36h6Imiwt2O/UwWeaWFpu/U2RrjI8
         3wJaz9cELshAdY2rUcOq4Q8NiaBW2R2EJQf6dkyPNvxcT1dhz+tVp3WI+UXFDtZDEpRH
         Wr4vCgcociS8CmaTZYdyDFNKYLMNQFgpCQEMJo3OzPjoQ7AR/utuwMPMTdoKeZSmF0M1
         NbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PMlWSW6ttnanNb8wF0bobaava2tVkjYUTBjAcm/ZuJs=;
        b=cEabMlpi6Ey56XxYO/nz+TD+kUHsHWPQad00Ud+zb2U2f5PFcoOopB6C5Of6GQGdfH
         3jnra+EgJ7HqJh2IcHD+E/hcf7zUlin5Ls7FYOL972+Hj4XBUA8WfnJwnfIOMpxlIHDp
         stXe1fcfQxlwuJyDeCH2E6iOoHmGlXVo13EdcRvANH9jSe2U1afM1e8LaxbmYBR8g06d
         KAj4mj3f1+NnpmVzhtMHYpaf237EELyhHftNWv0DlYR0GNp6uauRJH/Npvh2MO1S4Es0
         LLcXFRyzNdnhcVbkr4S9cadJaAPBFaCIyJ/Zh4zSaRfui79pHTHCwiG/zoZsiCT4Sma9
         Nn7A==
X-Gm-Message-State: AGi0PuZvXOMqBf0LKISzSmNnGkjFuyh6gb91yErMwA/WceMIjykfZ90N
        9mwnNBNS5An4TftxCJbWT7I=
X-Google-Smtp-Source: APiQypLKUFlZg0CytxNp74nTXeWU2B/WRcjEZ8j8XaaORn8LkrMUWInRi+XbgmfA/ZJJ++4rjGTf1Q==
X-Received: by 2002:a17:902:a586:: with SMTP id az6mr2779889plb.201.1588239829729;
        Thu, 30 Apr 2020 02:43:49 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.101.138])
        by smtp.gmail.com with ESMTPSA id 5sm1307138pjf.19.2020.04.30.02.43.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 02:43:49 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     alexandre.torgue@st.com
Cc:     sboyd@kernel.org, mcoquelin.stm32@gmail.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon.minfei@gmail.com
Subject: [PATCH 2/4] fix hang in ltdc driver loading bug, add CLK_IGNORE_UNUSED for ltdc
Date:   Thu, 30 Apr 2020 17:43:44 +0800
Message-Id: <1588239824-11491-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

1) in clk-stm32f4.c set clk_hw to the wrong offset PLL_VCO_SAI, PLL_VCO_I2S
   of clks array, should change to PLL_SAI, PLL_I2S, otherwise get null from
   to_clk_gate

2) add CLK_IGNORE_UNUSED for ltdc, otherwise system will close ltdc clk
   before filesystem mount

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

