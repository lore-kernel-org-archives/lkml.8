Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC36C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6577320717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVPJeRsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGQLEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgGQLEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:04:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D090C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a24so5228515pfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5PfOLny4pEJWy4MQsn/yhZkSIXGOVwix+YbwTulqRH4=;
        b=EVPJeRsac75H1MWZGT2eAc7gmbFMNKYmzd2Nc92E+e+bEpn+FWo46iRxErKK3IzEt9
         2mrqzMrvvugMdvTr1gaEfsNkgCM54pdOBZFk5Zki19l+kkc5OnapIjbVhZF8skJtV6Bv
         hZXDHwPvw22AkDXX1vxoK99BFcTSL8uifm7clJ5gKIxZCejgi0lnoZ3UgYiBeagfASd6
         /LH+M8tuBhlarDIljW7f683YsS/SrmgzYY1tmK9o9ZRiLxBSBW5T9e6s4sWHBZHc5XyY
         OA9dSmyVukfmhLCO4TwVP4+gaRxnYVhE77YpYqmgakZZhoQAaMOB5FbF3xnpVTtICqL7
         qPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5PfOLny4pEJWy4MQsn/yhZkSIXGOVwix+YbwTulqRH4=;
        b=SqgVWrAcgaxhE0WQJ09XDpyWXCgM0BQ4/YJ2Vlxqp+NR7N+XpNFWndu/JDUsk2KWHF
         kub74ouvWnHZjdkVp1hd5nvXA2cVAXzBmg8eYBuAjYDkob7kuQB9TYCEbqq0qTb9qML+
         XxEG9Y5VzhgBQQUE75jlWPRVft8QYu1z35PoE0kz1pWflsrYtdO6m6iPKZlEzrCTMXMC
         RaW+E2Ja5q2JVi9FlJ3o8l5S+gognZY604uxKL8eFcbR29gHJ4JWcD11eDwGL5q2fKya
         7I5wdmoLHiWxNCGtw6ocLBIsMwd5v3mUpy5aa6C7bK0TSSQttAAdFsdEjAGi+6zKtS0X
         AKlA==
X-Gm-Message-State: AOAM533Rb//XIlegNEJqBFzFEfnpwW6CPBhpOlzTA2hdgvdRyi5sh1Ib
        e4UM/YE1r8YEjOK+89tCtYA=
X-Google-Smtp-Source: ABdhPJzv2tdiLD9maWynthhXaPy0N5lIriyKmvl7WzGLmVNw5qPWKRQAUxePsMuiL3ItOfq/mNbyaw==
X-Received: by 2002:a62:17d8:: with SMTP id 207mr7112910pfx.44.1594983844789;
        Fri, 17 Jul 2020 04:04:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ae36:984e:c073:9d0b:7c09])
        by smtp.gmail.com with ESMTPSA id o26sm7619183pfp.219.2020.07.17.04.04.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 04:04:04 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v2 3/9] mfd: mt6360: Indicate sub-dev compatible name by using "-"
Date:   Fri, 17 Jul 2020 19:03:25 +0800
Message-Id: <1594983811-25908-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Indicate sub-dev compatible name by using "-".

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index e850675..7cc1b59 100644
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

