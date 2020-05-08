Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22245C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F091E20663
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrRdrzH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEHENl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 00:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgEHENj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 00:13:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C5CC05BD43;
        Thu,  7 May 2020 21:13:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id a4so285952pgc.0;
        Thu, 07 May 2020 21:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sGTXTVIeWZfMKGu2Tui/sSS6UaYWbPyLZVydf0J+7iw=;
        b=VrRdrzH7uKw/48TsVJC0k5uaudQ/8i4despiyT+mgT4Oe7Uw8VOpOj9Xe9kAwWSOrh
         FtHdoUcfmFSrMJMUPMSkVlbzZlsazu7YQ21sZyaU2m3P0V48G4dqdsiUOh2Q/rwbZXNy
         oqV1wlxFAiU8EQHraM/wta9w16G93woaX01sKbrtyrtgLftdjx/Zro/oT0KmPuTWsbfE
         LsmgyY+DZ9ULBA4C908KplqHUhCNMgRhNIYnh9D/GFBwWyo0nRqKQGw95vF8LczzNpsy
         OZII5c3ewtpx/1zWKnAbch5U03VOwcZd1k25XnYHOt1PqjJEBxdZ9kaLS8jj7SBzh/8m
         KTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sGTXTVIeWZfMKGu2Tui/sSS6UaYWbPyLZVydf0J+7iw=;
        b=NZQ4D/6UaoW15k+is3B2SQH8/eZB1JqKKT51V18tabirB6fCEkuI0noLRjlBbWGRNi
         t9EgRxzcyzOvxFLH/0rEwJJVLWv1ZyPUiUtX2UPfdVcOQD81YwUtVicH/3h65ecbN3F0
         iMpTn4eI9a+a5Eop5YI5P8wUXWCqBcQPUtWo58HNwRCwtcHXavNElke5GY5bN4qYre8T
         6nzOlvzB0j3AqP2Qpld1rpCnIMvVtvWzGUX2LxxqV9GQpnCIt+dwtqeOj8rtj2ZCx085
         SOBPVQk0aIjlVWMG2z3ggAmtj+PwE2yup7+q3MB456Et3U429xwAZROBOAavhRJv8mh1
         Zhrw==
X-Gm-Message-State: AGi0PubYwaRK869FCYFxpll5ItJWcvxI2WHZaQM3vSRJlxMDRYEWqKTz
        g8yk6g5BoMo71wmELasboTt4ahkDajg=
X-Google-Smtp-Source: APiQypKtSx7FFpg/lKRdr/OnMpMvj7PJ21YY/dFtMba1MMBSiMMuH8F3u50v0gIMSY0JufkuJgzOYQ==
X-Received: by 2002:a62:1994:: with SMTP id 142mr720891pfz.259.1588911218632;
        Thu, 07 May 2020 21:13:38 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id h12sm314868pfq.176.2020.05.07.21.13.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 21:13:38 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 4/5] clk: stm32: Fix stm32f429 ltdc driver loading hang in clk set rate. keep ltdc clk running after kernel startup
Date:   Fri,  8 May 2020 12:13:13 +0800
Message-Id: <1588911194-12433-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588911194-12433-1-git-send-email-dillon.minfei@gmail.com>
References: <1588911194-12433-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

as store stm32f4_rcc_register_pll return to the wrong offset of clks,
so ltdc gate clk is null.
need change clks[PLL_VCO_SAI] to clks[PLL_SAI]

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

