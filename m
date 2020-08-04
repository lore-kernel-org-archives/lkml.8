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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F21EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B1522CB2
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De/jNu96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgHDQdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbgHDQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:33:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE291C06179E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:33:18 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o5so4554520pgb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Joo9G8dpZiV+ukJjlPwDuzRh/fKHk3sZ/ezTEfq1J4w=;
        b=De/jNu96mJukp4chWsMDcgMGSnYzj6VY5TgCOJPgy4y9devJV5pT2uNd/EZzLIt5sC
         G12avvOo9F5n52s/ixkhoTjP2KwAL3BoyNvr9LV6Z7tMRPWUaf/KuCOPLnVEmR2ffARU
         Z35mjxsMvqCz85c4AX10QCWcLiCpWnyDCRnqI1wCOUiPHAq1BcKE5aNnhCyJZMY3bnby
         +t1zT74gtTBbN8OzRlFvY4q+pZrXjzHv3B32pgKEtIEvohCHj0A/5IjTudhY/OgcUhoP
         GT7B4Elovv1R3qotYSkyfQUfHaAVxTRusfIDBXEzhXkoJuoqYr5qGgy9vrQuwAEqzLgd
         UjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Joo9G8dpZiV+ukJjlPwDuzRh/fKHk3sZ/ezTEfq1J4w=;
        b=XTmfyStUUMpQXdN1gdc/7Yqcqj5qJIZ4rjTbkAhXNxOf/DN4kc31rAueHmKQSEor6t
         /CuJWbrXtp9CLq97REv7WM7g543v8tXU4X3R6CilIMYiyGXflIGYntyJyKYg6XnfE+VB
         7F+SClT7w45bJ6/t/cmgwW5tY1p8FLhvI+xfVCCQzRSfy3WmKd5xz4X/lt0zmXAOKUwH
         r+ZuNtJdGH66tun5YeDg6jGq8XV36iuL7JP4aHYV269gwjvDq9GwQRuHo2EL4OLm0RZ8
         oY6NduOgJ30BpQh8BIQfsn9gEDFY7n3WChk1x9DE4hzpY8KjqUruJm/zR2sX/IaVDzVX
         dFSg==
X-Gm-Message-State: AOAM530q63m7xbkyAdkTHGlcCDxFJV0CEwcYiAGxcWF+GP6LVJrrz7zc
        PaHzDoCSZ5xk68eDIJ9DZmE=
X-Google-Smtp-Source: ABdhPJwo6/ubLU4AReb0s2APcKHXVKyaB9BWQyUa/5liofmuzVDETXysgLOxjz7oJeySotbfjMz8Yw==
X-Received: by 2002:a62:758f:: with SMTP id q137mr20675494pfc.170.1596558798302;
        Tue, 04 Aug 2020 09:33:18 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id m16sm657253pjz.47.2020.08.04.09.33.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:33:17 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com, rafael@kernel.org
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH 3/9] mfd: mt6360: Indicate sub-dev compatible name by using "-"
Date:   Wed,  5 Aug 2020 00:32:55 +0800
Message-Id: <1596558782-3415-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
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

