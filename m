Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C375C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBFBE22206
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICb2A4Q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIKQZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgIKP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:28:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9268AC061795
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 7so6644374pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kqVh90gZA+Jv+sQxaZ1mzbNqmtA+iD77lIe6xdCdvDA=;
        b=ICb2A4Q92/WBWM7cefZ5ElnS+BfqFA5z0dbBB4/9D+x61pUUrWW1TIJyG5l2OJJ2J5
         /b+lGtutItcjO/D7XmeVO8ZnVREF7WXLuAt2jwJvuvVcSsqEGPxbZ5u5LOpc00sQAHWj
         gfOC3DyGCrPI5E0Cm6J32sd1Nu8oGV5TOkQacP/WGNAa764VytHt7lu0brBvUxrFOvSa
         Pw5Mcyi2x9MbzUTws4bDmbU3LsDZxbaiPV+biUykE5780veIyiTyoc63274v3ZgtVsDG
         TyHyLH9q/0ALmh03yg/t0t0x4rf1uBE9MoH47bCmbU+IFZ52Te0Vqol1v32V9eODx1yV
         Smkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kqVh90gZA+Jv+sQxaZ1mzbNqmtA+iD77lIe6xdCdvDA=;
        b=HczHI8bmRuorwIiqpe2G2BJYuAr3KPWqyc51h2h3w/rgitovJJ93v9dAAwn4bouc70
         bE9Hd6gmR2uwPHrcl3QFG9+dhbgWFVpWMft+sX9QX5X6i3aD96tzbhipk59mulPpv0g8
         T5YZiDtJxntDyMRJINSwS0VfkLjefC2hplGWU/F15UOqahRXcQkBPZGUeGxWmTBMqo48
         ZzEqj6NK0eJSI5gk6V0RWBT1rAZiBENtNT+sdjbnsYmhBRVmQw/JcRKl3r2215dwuWdX
         J4pG+AkEJ7mJHC3RwqDV15uoe77g4HGLq2wJL//o5Rj12vpHYVQpO2gfo+j7m4GJqiif
         gT6w==
X-Gm-Message-State: AOAM530DlND8t5EymfCIcju25g2/VY+EznXc5GmY/jWFO8iY4xxpG2/z
        KT+uD/ZfqupE0YEnK7z0SkXKLg==
X-Google-Smtp-Source: ABdhPJydCZ/jXrds01g38SygDtPX4ovyhhGVLoresFGxG+Fvj8jeLjcgon9C79eWnN9h7K1cLegzTg==
X-Received: by 2002:a17:902:760b:b029:d1:9be4:856b with SMTP id k11-20020a170902760bb02900d19be4856bmr2313328pll.1.1599830962073;
        Fri, 11 Sep 2020 06:29:22 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.48])
        by smtp.gmail.com with ESMTPSA id e10sm557988pgb.45.2020.09.11.06.29.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:29:21 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 2/5] irqchip/gic-v3: Enable support for SGIs to act as NMIs
Date:   Fri, 11 Sep 2020 18:58:41 +0530
Message-Id: <1599830924-13990-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
References: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to handle SGIs as regular NMIs. As SGIs or IPIs defaults to a
special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
handler update in case of SGIs.

Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
as IRQs/NMIs happen as part of this routine.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 7170645..dfd8e03 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -476,6 +476,11 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 	if (WARN_ON(gic_irq(d) >= 8192))
 		return -EINVAL;
 
+	if (get_intid_range(d) == SGI_RANGE) {
+		gic_irq_set_prio(d, GICD_INT_NMI_PRI);
+		return 0;
+	}
+
 	/* desc lock should already be held */
 	if (gic_irq_in_rdist(d)) {
 		u32 idx = gic_get_ppi_index(d);
@@ -513,6 +518,11 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 	if (WARN_ON(gic_irq(d) >= 8192))
 		return;
 
+	if (get_intid_range(d) == SGI_RANGE) {
+		gic_irq_set_prio(d, GICD_INT_DEF_PRI);
+		return;
+	}
+
 	/* desc lock should already be held */
 	if (gic_irq_in_rdist(d)) {
 		u32 idx = gic_get_ppi_index(d);
@@ -1666,6 +1676,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_dist_init();
 	gic_cpu_init();
+	gic_enable_nmi_support();
 	gic_smp_init();
 	gic_cpu_pm_init();
 
@@ -1677,8 +1688,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	gic_enable_nmi_support();
-
 	return 0;
 
 out_free:
-- 
2.7.4

