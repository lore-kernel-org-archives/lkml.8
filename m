Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B24C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6437822BED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE8MaqVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgHDQde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbgHDQdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:33:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80190C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:33:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g33so5129839pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5bxP7SBsyG/FaxnJHfQjTjpWsNLjhkZMYmiwNpRv5E=;
        b=HE8MaqVHt2WlTRoli0MbJ8ttSjwj6044ipm+DEd7YcNYTWOpsah5zMJfZQCPlQn3wq
         XxhahHcyq3p5FLARelylRaYJXxBCWlciVrqzyW0U56jhBb39035x84hglhGZbTN+Yrly
         7/zSio7SCngnV0d+TW7+pFQO7YMKPGlxS6v97LRnBuOZcybPsiDDyiF0cHDhWtQlhWSf
         FC3KP4zqbH0HtBynUlhYlC5FzXpxA98yZF350KPtcqu7T3mJFAmd7tSGA+GpffSlbJo/
         xUVkKriYlFWMIFqqjTiFw8rSZ8a9o5mHX+7ABKoN0jL01ETGWOZfwxsi+D0g60CjkoWT
         dsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5bxP7SBsyG/FaxnJHfQjTjpWsNLjhkZMYmiwNpRv5E=;
        b=OfsyWPc8EsQFqETOkjS7GgX/PnFn2NYYjShz3PmkLEHrd3JucbZE9Qcvezvk0D/eZ8
         cAS25lAtMzqh8ghnyc9648ip+Z95LxoB691vLNMGBgMy1S9ODFyzjM/PDGqk7zhSI/BP
         unfw13Uy44c1dh9IAt6VKvGq7DUnMEk/Dp3xxLo9In9IDSTq7/yh/XT7c5rpYWHqpLuA
         sRJfyD3tO3HwpjJH0uYmI+2Srm6nntXt/VH+rThU6khPLjTCCAMZvyqCDZi4Ky0i5ofJ
         s0q7dA01huKp+O5PVZ1LF2pIDvvzULpt6GRTwGlbO6EsKgj8ZxfxuyT/5ZLNY9blOwEj
         rFaA==
X-Gm-Message-State: AOAM530PfRJeWFGrPO2tJBLl1zy3SxMTGu4xw9vU4TxAd49XBXZRI9oT
        wtZuqvOLKi92sdvQSF6eS4g=
X-Google-Smtp-Source: ABdhPJx7CIFp8JKIMAjtmU/77M+OIIHdfSIG/OH/cemvUAaQELVQzbig6KKsiD6NYzB8PGWrhFK46g==
X-Received: by 2002:a62:1ad0:: with SMTP id a199mr16504535pfa.56.1596558801103;
        Tue, 04 Aug 2020 09:33:21 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id m16sm657253pjz.47.2020.08.04.09.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:33:20 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com, rafael@kernel.org
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH 4/9] mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360 regulator resources
Date:   Wed,  5 Aug 2020 00:32:56 +0800
Message-Id: <1596558782-3415-5-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
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

