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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C203C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8052078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO7InCj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgHQKtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgHQKsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:48:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76686C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:48:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d19so7921172pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5bxP7SBsyG/FaxnJHfQjTjpWsNLjhkZMYmiwNpRv5E=;
        b=HO7InCj5DyHxtQgmb+1KB7+pIlkzUgKfEmsbL0H0SYyo5af3rPrGCpvNyoqeBQ5r8I
         HybpsHuOOJjfzI2HxXoypVGpBcIeuO7SsnhNX1mLlDhCHIlCPMca2sBS7kfJ1+5lkWTL
         GZ5klR6KBdfbj+LkssigwXNmTTUo8ny+UTvblxIeKQwwBn9pmoJc8IBmb8VPROIuJHw+
         KR4ssvdt15UtIuQsP+CU6LWmYAVtLD19UU/ZUrtMXoE0yrDX/Vy4lfSGSRrVKKddt90N
         YlHRv//ef4GBmYcqVAwhetNxRuOly5BWordloaAq2FLxTfrdQZH4viOp/FRzJM6Jr38T
         ntsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5bxP7SBsyG/FaxnJHfQjTjpWsNLjhkZMYmiwNpRv5E=;
        b=oVv0oNr7ysHomEZKQ+N6XAY7eDoCGEmcPXaYoo9ed5p1pw7VMJZbclF51ojCbv60tI
         PR3+KWaHRzMVyX7VfvJ+R1x36RNsNbscoFGELoGT5vnGSh4Q1q0ZrTDD8T9ZPxJsXOpA
         NEfj+PB5piwgz0Vo107SJmOSPSJ809qwTnFqegwcwik0hyUrOc/ly3NDhhxeDSqUAIoz
         8CqTx+IJRUe7wPw9qhre3PlUYwPr+/yTKcfcAvV1n1AXojBca9hwRhEtE9NeyfNE5LC2
         ApNl56D//2+EzUyKF1KDRO9sbfukRJq0kEMBWQiR3O496RIa42OXNBsM0nLz8j3XGdB1
         EW1Q==
X-Gm-Message-State: AOAM532WgxFrlfv6tIC3HsQbSCOoMw1pxMKQZ0M3YIYDQWzu02myqZeG
        9Bq3rb+pBpZXSD4mscps0XU=
X-Google-Smtp-Source: ABdhPJxvjPog/zcs2IZsuzELFP8q8eDDcmQE5AoBcs21M2OG72EoIcTBtviVCIpusOnygDIeHNgGFw==
X-Received: by 2002:a63:4450:: with SMTP id t16mr9468564pgk.3.1597661332106;
        Mon, 17 Aug 2020 03:48:52 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:c217:67e6:a40c:a3bf:1945])
        by smtp.gmail.com with ESMTPSA id k12sm16976528pjp.38.2020.08.17.03.48.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 03:48:51 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v4 4/9] mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360 regulator resources
Date:   Mon, 17 Aug 2020 18:47:52 +0800
Message-Id: <1597661277-27862-5-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Combine mt6360 pmic/ldo resources into mt6360 regulator resources
to simplify the similar resources object.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 692e47b..5119e51 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
 };
 
-static const struct resource mt6360_pmic_resources[] = {
+static const struct resource mt6360_regulator_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
@@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
-};
-
-static const struct resource mt6360_ldo_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
@@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-chg"),
 	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
 		    NULL, 0, 0, "mediatek,mt6360-led"),
-	OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
-		    NULL, 0, 0, "mediatek,mt6360-pmic"),
-	OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
-		    NULL, 0, 0, "mediatek,mt6360-ldo"),
+	OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
+		    NULL, 0, 0, "mediatek,mt6360-regulator"),
 	OF_MFD_CELL("mt6360-tcpc", NULL,
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
-- 
2.7.4

