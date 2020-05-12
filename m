Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D6BC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54179207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJSL2ofe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgELHEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgELHEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:04:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC0CC061A0C;
        Tue, 12 May 2020 00:04:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a7so8960906pju.2;
        Tue, 12 May 2020 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cPYlxJhfKmWtbP4a2dRiIg5n9Tzb/bTlK0+j+KORUjo=;
        b=fJSL2ofei13tcbkZZb/Pr2NnHzs1Y2rSHpEwbHjNlqAa7o8IvZixYeWVN0GwMPsg3e
         NxAQzgeAo4o4vpJAckHUOcH80IP1TYeqpPIGlXUVpc42ex8nU7V6rEYV9TBblsrf8BEC
         HUIAaYhUqYBYn9phOtOrgDq3qusl55w6vxMQXl5OXAtVE1omAufTXfeTU4xVweno/ouS
         68tFoeeXP1DdaqcSkvQo++6sfqHAGqbOkBYkn+s2pyoxmE1/GUPGaOX333CbZjrumHIZ
         +/nrG+kam+ITLvosujZ2z0x8Ewa1/gON6f49XZfUVM0/KPLnCoXNaubyBmYyyCX5Zkp0
         /6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cPYlxJhfKmWtbP4a2dRiIg5n9Tzb/bTlK0+j+KORUjo=;
        b=cHkMnR11P86s9KNONDxf+7G4QSDyel8+3OTPhVklaFAk/Z0o7Hxz6sPIg0Bic1CoCx
         g1wIHryTjEl5NygS2BKKzccOhy7iOxRYDToWvf+GHmHH2xO3SQLi5v4lmQf2GGaGkGKP
         2SqKkD9IuPzQ144E9OqbJM8ly4Wj0sI2/GCAy3PEnxS5YfYEb+EuolzsXBGbqMEhONZJ
         nvs+Ead7RXW4fxU1Rqw9G4KXht3e18yDZrzkhSXy5lBzNKCysHg0QXXZTC2P1xR76WbB
         f+1sKqT8fSOsivCZKs91aRms6NFPtxlxauJOqHpuuWjvwMLMgICEjOx55fywAoqtYYI4
         C7lw==
X-Gm-Message-State: AGi0PuYvQv82eHQ4MFZImFiTI+O5VZcCSLCklT5g6SSLDvRNTUj0NXaX
        s/tk5i9dfIDnPV53MeJmyZs=
X-Google-Smtp-Source: APiQypKswW2iqMgYeLIiYULPyqI7RQPh0iMAPiCh2qROGM6rAR0Y5+8mNaNz5BngqvD9sBNfVV306w==
X-Received: by 2002:a17:902:8bc5:: with SMTP id r5mr18978437plo.218.1589267046097;
        Tue, 12 May 2020 00:04:06 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id 62sm11016369pfu.181.2020.05.12.00.04.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 00:04:05 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon.minfei@gmail.com
Subject: [PATCH v3 4/5] clk: stm32: Fix stm32f429 ltdc driver loading hang in clk set rate. keep ltdc clk running after kernel startup
Date:   Tue, 12 May 2020 15:03:36 +0800
Message-Id: <1589267017-17294-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

as store stm32f4_rcc_register_pll return to the wrong offset of clks,
so ltdc gate clk is null. need change clks[PLL_VCO_SAI] to clks[PLL_SAI]

add CLK_IGNORE_UNUSED for ltdc to make sure clk not be freed by
clk_disable_unused

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 drivers/clk/clk-stm32f4.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 18117ce..0ba73de 100644
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
@@ -1757,7 +1758,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	clks[PLL_VCO_I2S] = stm32f4_rcc_register_pll("vco_in",
 			&data->pll_data[1], &stm32f4_clk_lock);
 
-	clks[PLL_VCO_SAI] = stm32f4_rcc_register_pll("vco_in",
+	clks[PLL_SAI] = stm32f4_rcc_register_pll("vco_in",
 			&data->pll_data[2], &stm32f4_clk_lock);
 
 	for (n = 0; n < MAX_POST_DIV; n++) {
-- 
2.7.4

