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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3063C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F68820717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHi5f7k1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgGQLEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGQLEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:04:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014CC061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a23so3629133pfk.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ESlaLWruuMCRnjRqy6Z1yiMvTGKsQq4BBCkehiLzOpM=;
        b=CHi5f7k15qzUSk1+HeUcCRqBuek/IRZcqwhE5ljFzQXUWz45WPSQBr5UA95Bs1G9vO
         F/I7DbNABElTS+HekuqWB7CQUqG1JDXPcBrY2zz5YY/JkgmK3cQJdr0eB/GzFBkvD5cm
         bICHSLgg29qv0Ek5CDQHqf9gXb47DZITHjAjImjTZBgkbLKFyrIEsHn9RrSZo1Y6zEop
         dwSPAzMbgu32k7vRUxQovmLeud7UmPnWPq2z7FtuAdXqwM1+THiw6ip5+WRm2MyDVHhu
         xnzAXM+c5GTu1glP5Be0BiI/oax1rBgMeTiwfq1duy2kzVaqT3JKNUobNI4S1dRyBdr8
         wcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ESlaLWruuMCRnjRqy6Z1yiMvTGKsQq4BBCkehiLzOpM=;
        b=dncsGJngxmGULJj39vllwjCISZ94YnglzkSZ4mBaDiqSUaSht0ArRM3JMBg2LKg2lw
         R+DuaXH64NbM7H23a4Mz5eiXjNIDwBuqMNikgERrySRgLxKMwWC43QYM/ICy1ZDzvCa+
         i6VGyTi9qJlSp/Wx2WCWA1HG5rvgY2nYzBTMuF/eOcRwVBX8W/nRGXwpw+MNAAJ8uuin
         52GM07QYIec4yo/hcI65l/gj3WEVmF+E92abmyLzML7yOIMfBUt8ajgUVUZc7mbtIQdZ
         vb3Tnec9pIO35DANKT2i9oSp86gbnLVmEVCJHhYT8CtGyqUwZzKvd3hG/v+E6Niyfngq
         eGpw==
X-Gm-Message-State: AOAM533emp6GBVNfX8jisz9hjwFM9yc9WMWAWsjNcoBzae73aH8+UGHQ
        p0brPJQwYzJvLIaHXG1q1RM=
X-Google-Smtp-Source: ABdhPJxTrfHAwYAFyXBWhVGeXCB7UYp6gONrLWt3az7DBZoTpXgA5ZJiF+/xj6kSkft5vvUbdpgilQ==
X-Received: by 2002:a62:8c83:: with SMTP id m125mr7749098pfd.14.1594983847241;
        Fri, 17 Jul 2020 04:04:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ae36:984e:c073:9d0b:7c09])
        by smtp.gmail.com with ESMTPSA id o26sm7619183pfp.219.2020.07.17.04.04.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 04:04:06 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v2 4/9] mfd: mt6360: Combine mt6360 pmic/ldo resouces into mt6360 regulator resources
Date:   Fri, 17 Jul 2020 19:03:26 +0800
Message-Id: <1594983811-25908-5-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Combine mt6360 pmic/ldo resouces into mt6360 regulator resources
to simplify the similar resources object.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 7cc1b59..665e26f 100644
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

