Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893C0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B0822B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h1y6cW+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgG3EBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 00:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgG3EBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 00:01:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B3CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:01:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so5256041plk.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xsPP2haPHn6gP2Ahy+74zO8OhQ1ajIMIhlDBCTv89iU=;
        b=h1y6cW+6Z9M3i8Gmgo+exdkCKFBjsJco4+EmU8SXWJjn4RYqJkUIfmBZkebgkvyLjC
         90xEmIQysAERID7Tr5dKM9CYAfnfTHChrpKQMsBES1fhl08rGMG3kVGuoHp/uvHIG6l3
         bMhhMk7DDLNn8o8VWm5+YoMHFVNIio0Q70Lf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xsPP2haPHn6gP2Ahy+74zO8OhQ1ajIMIhlDBCTv89iU=;
        b=UQ6AlnH61vwBK3PvgPvgGFprcCqDCaa9kM6L+DKcrH8cHp2GNDtyZ3si0kAtTJFFNl
         p7+n4wiuFT4LM1P4kcomDA/o+umBRSH9jyP4pdwDAHC1e/lAr+cB06xAv4mhm37HzONA
         ASaKDvyLdzCrfaEQRcUwz9g62WYq5q5sIGob/MSsyEVvQWI/8M3PTrz5TDNy2ZXYTcXk
         ti9Xc6DbuwsUEw18kHyfVXCP65C9S77j9OgKP/5aAyZLHK7/seRnFGHu0NuWfLnxlCoF
         QzhWO3cyWmZkopIQli/OjSJKMl7budkNX9jdOF3oBEXfiADbrYaJIxEEZAimeNEzYw8F
         pbDQ==
X-Gm-Message-State: AOAM533gcLvWGQGDdefVO5z7znvu7rFi+Kox7zTtZY1XI6bptRjZ5zRf
        M5Mj0CEEMH4kuncYSSPL1gVwmRv5pi/Pww==
X-Google-Smtp-Source: ABdhPJxkoLXNECTfu4ISeOa4wxsYJN4hZQrVF0BybO4ggF5F738z+52YcT2dpRPFmHvt6Q2fHI6H5Q==
X-Received: by 2002:a17:90a:5d87:: with SMTP id t7mr1095548pji.213.1596081673509;
        Wed, 29 Jul 2020 21:01:13 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id c9sm3635209pjr.35.2020.07.29.21.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 21:01:12 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mediatek: Check if power domains can be powered on at boot time
Date:   Thu, 30 Jul 2020 12:01:08 +0800
Message-Id: <20200730120054.1.I5e6f8c262031d0451fe7241b744f4f3111c1ce71@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error case, where a power domain cannot be powered on
successfully at boot time (in mtk_register_power_domains),
pm_genpd_init would still be called with is_off=false, and the
system would later try to disable the power domain again, triggering
warnings as disabled clocks are disabled again (and other potential
issues).

Fixes: c84e358718a66f7 ("soc: Mediatek: Add SCPSYS power domain driver")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

---

 drivers/soc/mediatek/mtk-scpsys.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index f669d3754627dad..0055a52a49733d5 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -524,6 +524,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 	for (i = 0; i < num; i++) {
 		struct scp_domain *scpd = &scp->domains[i];
 		struct generic_pm_domain *genpd = &scpd->genpd;
+		bool on;
 
 		/*
 		 * Initially turn on all domains to make the domains usable
@@ -531,9 +532,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 		 * software.  The unused domains will be switched off during
 		 * late_init time.
 		 */
-		genpd->power_on(genpd);
+		on = genpd->power_on(genpd) >= 0;
 
-		pm_genpd_init(genpd, NULL, false);
+		pm_genpd_init(genpd, NULL, !on);
 	}
 
 	/*
-- 
2.28.0.rc0.142.g3c755180ce-goog

