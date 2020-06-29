Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5769C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40C920656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="IXmyZM/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404007AbgF2Vnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgF2Shs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:48 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE00C031420
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:21:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id r22so15927063qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fem3XNP+K3JU9MCaDCRGbzpn3Qjj+S6fTPpAXuau47M=;
        b=IXmyZM/yRnHMX0W2VsnzlDaWZI/gIrdOGnVPWgA+2Kxtlsm4yBGwSUeP2xGUDv1KYx
         ysOEPUN0Yf1dqDn3fjal1FFDnykYcc3fT8m1LMbYmnJ8CNQrn90e8PjsxNEWrn0fVA0h
         lJk/GqLz6CmqU1mS/49tGnXa7GVxX3PRcW+YfeBzAPwpO86IUfVtSRYapv8eyk+gissX
         in9N5q8c6+M6KL58t09k47Q5dcwMInAFOEFjr37pQ6Njfopi7K6y5rCTvKyjmaWA3Jmo
         HPr2+RQ2/30V9ckiCKd+BkFCselNoTY+vcSiaP2qs3iVoEn5dEkE0ilLhDgW3Sw5wXoD
         79AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fem3XNP+K3JU9MCaDCRGbzpn3Qjj+S6fTPpAXuau47M=;
        b=nsEscSg4QvlnuyZjHrdMXbO7NzJ6Y5LJtvVcL2ttmuNKspRys7gHs9pnBzrlSXfINe
         s7YSe011xb3Yfs0SDdFE9rUImxTpgQOcIPLANzGukEXERqw0mAC0JHnX0e237KTrl3jT
         8KzuxLmMJ/6t8L9np0cHy+VclEnflYuCFogHLGhxruEjoEvCuHU7sTaUftvpKQoJtBwL
         0k533EheuEWtWWhSLoAt9khjLpycpmq9fzI03Im8nGD85pa43pziD58hKPy+FoHqZtDB
         l6QPkbsWVz7gB8lNEsdfyFKMjmHR+F8AyMPmVWfmLJQC+itwC34CQG25tNG9XqkWpZTp
         wQUw==
X-Gm-Message-State: AOAM533P3oID+Vki4GxkaNwuRlQqaz6TQKIMnAvr+VxH3wtiYJpcXhhG
        iNaoZK5dNUoUNXEikF/Hus9Zwg==
X-Google-Smtp-Source: ABdhPJxy3AW0ebQa1q0sqz4u/+GdjEeyX7bZO37gJSu74AUtCI+D1DWF+pQRCB+c38adJFkCFtGJJg==
X-Received: by 2002:a37:e4e:: with SMTP id 75mr16083443qko.81.1593451262110;
        Mon, 29 Jun 2020 10:21:02 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id q5sm408363qtf.12.2020.06.29.10.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:21:01 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Deepak Katragadda <dkatraga@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/13] clk: qcom: clk-alpha-pll: remove unused/incorrect PLL_CAL_VAL
Date:   Mon, 29 Jun 2020 13:20:32 -0400
Message-Id: <20200629172049.30452-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629172049.30452-1-jonathan@marek.ca>
References: <20200629172049.30452-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0x44 isn't a register offset, it is the value that goes into CAL_L_VAL.

Fixes: 548a909597d5 ("clk: qcom: clk-alpha-pll: Add support for Trion PLLs")

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

