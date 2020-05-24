Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79D6C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974D6207D8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="1JKePdYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbgEXVGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387850AbgEXVGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 17:06:22 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0116C08C5C2
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 14:06:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i5so15919034qkl.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SMexMeVTm63rHWx/JVuuK6vnjusS2CuBaYCJ1ubsUHs=;
        b=1JKePdYirIa/xYzsH6LsSwNwjA8gJbjzNc7twg6f8DPN18cwtCA0vArVBxSyKrzwOC
         XthO7qIO9vA3RRN3+tojwHCBG3t4z91tLS3NrsK5lpW8vBxOxJzGilyhdUhBY0t71RJU
         3pexLHsPLP4NpTXHLh/ubZgFq9a2lOEsA/TWToMLuIz4OJvJ7PWqmkmMaAY5IcOUnhRE
         0RqhdMSxjwtOhO3MvBo+sWzrl+zpdaU2cwGm3NYWWifV37GcJmcwWSREd0fK73/9hd++
         AshtWVMEBdZ/VNo2ubWltFpFL7Tc0M0ARizZIR/YVghoNsF8IRHTZmsl4oBQk2piKgSW
         ohbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMexMeVTm63rHWx/JVuuK6vnjusS2CuBaYCJ1ubsUHs=;
        b=kvzn0YalZPLzd0jHwvk2tOdceDKnEFEQxrrK+T58CokyyAE6DLskCP+3lkRS2lc3M4
         KlWG/ntJkISrLpSQrEBnBYk/H/MknSOlg4ktP+9Qh8mYUUbKGpW/xCDtmVQicF6EKZ+s
         SqyQM5+OHLxs10ccFymKNEPYlYyij4l7TPHJ5jymGeFdLv+ZSFNRTbGD4YN3unvR4u9V
         2hny520cJOuPsPF9iSCgeCjhN25ygkO1ZrIsd737Z1kPRFy16WOGuUVC6ktsW4ixsPNx
         xVCtilVf+MTCL+BRnbB7Ht02oGQJmL0ced5H3SW3cg6jEavGQqndrps7n35l6WRJ6uVM
         LigA==
X-Gm-Message-State: AOAM5334tP4bmKzjz6ta5zhizXyelUkvcod4F6kMOXrVuyRVtP4s2vkJ
        DsId7APKhWxB2Y4VafBpMHKpTQ==
X-Google-Smtp-Source: ABdhPJwi1NS9dgh+AnJIWhS0n3NdreA/ALo8O17bbkZnccp0vKqKC9yFbnoRSvMemCoMX3c5YyruMA==
X-Received: by 2002:a05:620a:a53:: with SMTP id j19mr24845844qka.183.1590354380991;
        Sun, 24 May 2020 14:06:20 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g51sm4401769qtb.69.2020.05.24.14.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 14:06:20 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/10] clk: qcom: clk-alpha-pll: remove unused/incorrect PLL_CAL_VAL
Date:   Sun, 24 May 2020 17:06:02 -0400
Message-Id: <20200524210615.17035-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200524210615.17035-1-jonathan@marek.ca>
References: <20200524210615.17035-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0x44 isn't a register offset, it is the value that goes into CAL_L_VAL.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 9b2dfa08acb2..1325139173c9 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -56,7 +56,6 @@
 #define PLL_STATUS(p)		((p)->offset + (p)->regs[PLL_OFF_STATUS])
 #define PLL_OPMODE(p)		((p)->offset + (p)->regs[PLL_OFF_OPMODE])
 #define PLL_FRAC(p)		((p)->offset + (p)->regs[PLL_OFF_FRAC])
-#define PLL_CAL_VAL(p)		((p)->offset + (p)->regs[PLL_OFF_CAL_VAL])
 
 const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 	[CLK_ALPHA_PLL_TYPE_DEFAULT] =  {
@@ -115,7 +114,6 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_STATUS] = 0x30,
 		[PLL_OFF_OPMODE] = 0x38,
 		[PLL_OFF_ALPHA_VAL] = 0x40,
-		[PLL_OFF_CAL_VAL] = 0x44,
 	},
 	[CLK_ALPHA_PLL_TYPE_LUCID] =  {
 		[PLL_OFF_L_VAL] = 0x04,
-- 
2.26.1

