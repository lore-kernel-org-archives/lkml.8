Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B025C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE79520758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTd3pBEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgHQKtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgHQKst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:48:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE89C061343
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:48:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so7929586pgh.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Joo9G8dpZiV+ukJjlPwDuzRh/fKHk3sZ/ezTEfq1J4w=;
        b=cTd3pBEfcGOI0GUl+jGoJ9C1jxMlmWh9GPGRNVa87Suq21Jw1Uxy5NhHGeORvoyBdP
         coa4aiLyM8ttF+0vS8u/nG0tFlo4IhI2APHwnMmhf1NKoXQ6JURg5aupiOxSICS8Z+kM
         cGCi+wI8pQiigNOA7cU4sjYrvs6N3t/Zas9HmbPFD4AwAWU8jinfD3U/vC8NjF0qYhc7
         omz0UQ/RZlNoZqGKBreomIsg7fLrHm+c93tqoVYEMtKRHGj8E3Ltbwsml+todPzuspbT
         m1ySsGyOe+FkxH8Imm2LQQh+8fB5ihV6B6xc4g/ixK5/fY1lU9S6/F3nrC09OpkF51Fc
         slgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Joo9G8dpZiV+ukJjlPwDuzRh/fKHk3sZ/ezTEfq1J4w=;
        b=Mki0l7wtQKniRtDJhVQHk4SVbK4Iw+ntglCtsundJi0d8IUp7vn+qkWivHUcEKJbMX
         YrqqskEm+B/8fpRAVxD5emL7dMkJG3uGAjWUIwZj4430YJXS4I0eeC0Pc+eazgGwFoek
         jgZfMflWrNpkZrmg7YMLQREMx2xPCA5IQtJqqaqh+mB/7MxQ0ossmQE3pxmf3JjmBEYh
         lrGs6ek62SepzuhEN3C+2uK+DJ5EiX4QvEcQx3AP9Rq7oF1m4DpEuhHjyrilelpH3Iiw
         p4Qh2S9PzmTbNV6XXFvLk4gwAJ7QH6aI0vC0yWvLHn1ZZNS16GsO8HHW8hU0zNNvLmun
         LAwA==
X-Gm-Message-State: AOAM533k62Q2xyUhVCznH+DcC04MJvM/+rJzOhlsbLLCisy07lP/DW5Y
        x8f/B5dr85HzTF+1CkxSKiQ=
X-Google-Smtp-Source: ABdhPJy2wGTTsSBWFh2L/UODY4F+cIhdd/jqxANXR9mTMHpI8OyDraUX2udy2lqxjSCPNYWA92Y4rA==
X-Received: by 2002:aa7:8b18:: with SMTP id f24mr10782555pfd.301.1597661329381;
        Mon, 17 Aug 2020 03:48:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:c217:67e6:a40c:a3bf:1945])
        by smtp.gmail.com with ESMTPSA id k12sm16976528pjp.38.2020.08.17.03.48.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 03:48:48 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v4 3/9] mfd: mt6360: Indicate sub-dev compatible name by using "-"
Date:   Mon, 17 Aug 2020 18:47:51 +0800
Message-Id: <1597661277-27862-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Indicate sub-dev compatible name by using "-".

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index befee70..692e47b 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -292,18 +292,18 @@ static const struct resource mt6360_ldo_resources[] = {
 };
 
 static const struct mfd_cell mt6360_devs[] = {
-	OF_MFD_CELL("mt6360_adc", mt6360_adc_resources,
-		    NULL, 0, 0, "mediatek,mt6360_adc"),
-	OF_MFD_CELL("mt6360_chg", mt6360_chg_resources,
-		    NULL, 0, 0, "mediatek,mt6360_chg"),
-	OF_MFD_CELL("mt6360_led", mt6360_led_resources,
-		    NULL, 0, 0, "mediatek,mt6360_led"),
-	OF_MFD_CELL("mt6360_pmic", mt6360_pmic_resources,
-		    NULL, 0, 0, "mediatek,mt6360_pmic"),
-	OF_MFD_CELL("mt6360_ldo", mt6360_ldo_resources,
-		    NULL, 0, 0, "mediatek,mt6360_ldo"),
-	OF_MFD_CELL("mt6360_tcpc", NULL,
-		    NULL, 0, 0, "mediatek,mt6360_tcpc"),
+	OF_MFD_CELL("mt6360-adc", mt6360_adc_resources,
+		    NULL, 0, 0, "mediatek,mt6360-adc"),
+	OF_MFD_CELL("mt6360-chg", mt6360_chg_resources,
+		    NULL, 0, 0, "mediatek,mt6360-chg"),
+	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
+		    NULL, 0, 0, "mediatek,mt6360-led"),
+	OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
+		    NULL, 0, 0, "mediatek,mt6360-pmic"),
+	OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
+		    NULL, 0, 0, "mediatek,mt6360-ldo"),
+	OF_MFD_CELL("mt6360-tcpc", NULL,
+		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
-- 
2.7.4

