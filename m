Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19D9C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC25A20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQ94vAR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgICPMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgICM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:26:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306EFC061249
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 05:06:04 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e33so1982471pgm.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 05:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l42Sw4hGC87WjooQg2VTZSFCehZO9m9AdkULNCdGfhY=;
        b=QQ94vAR9C6a51GpTGkrB1+xPpXfRafgvPa3tu6a+3G75SJXaTYLuJc+aYbErLcWfPr
         CucHQhF5l4BWTgM4UZBaXdBwO+8s55QNcM+2DJ92B86SADz7QZakpwkUXnwFHnL04xJR
         smJhScLAnqI38oNpr05jXEP03UuXB94dw1B1goqFZLPlwmWeZNgTVbv0kittkb9EuS61
         9Vu4GMgFj1p3zoMvDwBo1EDUY8JFsb2AScBfwOSCR32qSiq76EQjJYR4WmTCu5a6kdrG
         qcqRr57lm9R51EqFelU2ta3IbNgwRf2dWKoJDqzGSpKc0QH4zoncfhXeUayjhlOKr2CQ
         2Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l42Sw4hGC87WjooQg2VTZSFCehZO9m9AdkULNCdGfhY=;
        b=ay2rxkgJkdQY7KSreXmID1OX1xbCz+MTG9W+evPlM9bQKlLdmtpLVpWrcYl5sgXSLZ
         7Z6mKrHPX0x3fwu8PQo6Uz0mOVB1+prxfqvkZJCg++sGF3eu8917ZqesOlT/ZwKfimjh
         nOdGS1heOky+gQIR8PIX8jsHpUqlr+QSm6lBmsKH/yMPUgqTm3qSR0QncY5Mu4gvzrzP
         SiNfxr5SJ1LIC5VQl8LEmxYZ+UO14JFcjlWdBBlD+zrVXdu/1f0N3fydKDl6KDYyuH2p
         cpgyAK5N//M68bVCnpepTUWgo3tO+evIVN2MpjNK75Mw9iet26DKyCsTgIZYbuNutSQL
         /LMA==
X-Gm-Message-State: AOAM531Zt2eS3Svxki6TLDE273OOv7TRCaaYTJnQoSTx3D5TVSP+HSt0
        W/Y8d1vKl+AwDJJa+Xit27Lhxg==
X-Google-Smtp-Source: ABdhPJwA8w/V9i9vrKKv3vQBxhzDj1BOn4fq9KGcKRyand8nMjBomLB0bAwwW8ejG7VaZ6lBdtyH9Q==
X-Received: by 2002:a63:ce56:: with SMTP id r22mr2749565pgi.141.1599134763468;
        Thu, 03 Sep 2020 05:06:03 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.248])
        by smtp.gmail.com with ESMTPSA id s1sm2922022pgh.47.2020.09.03.05.05.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 05:06:02 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 3/4] arm64: smp: Setup IPI_CALL_NMI_FUNC as a pseudo NMI
Date:   Thu,  3 Sep 2020 17:35:11 +0530
Message-Id: <1599134712-30923-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
References: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup IPI_CALL_NMI_FUNC as a pseudo NMI using generic interrupt framework
APIs. In case a plarform doesn't provide support for pseudo NMIs, switch
back to IPI_CALL_NMI_FUNC being a normal interrupt.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/kernel/smp.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1b4c07c..572f8f5 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -81,6 +81,7 @@ enum ipi_msg_type {
 static int ipi_irq_base __read_mostly;
 static int nr_ipi __read_mostly = NR_IPI;
 static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
+static int ipi_nmi = -1;
 
 static void ipi_setup(int cpu);
 static void ipi_teardown(int cpu);
@@ -971,8 +972,14 @@ static void ipi_setup(int cpu)
 	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
-	for (i = 0; i < nr_ipi; i++)
-		enable_percpu_irq(ipi_irq_base + i, 0);
+	for (i = 0; i < nr_ipi; i++) {
+		if (ipi_nmi == ipi_irq_base + i) {
+			if (!prepare_percpu_nmi(ipi_nmi))
+				enable_percpu_nmi(ipi_nmi, 0);
+		} else {
+			enable_percpu_irq(ipi_irq_base + i, 0);
+		}
+	}
 }
 
 static void ipi_teardown(int cpu)
@@ -982,23 +989,34 @@ static void ipi_teardown(int cpu)
 	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
-	for (i = 0; i < nr_ipi; i++)
-		disable_percpu_irq(ipi_irq_base + i);
+	for (i = 0; i < nr_ipi; i++) {
+		if (ipi_nmi == ipi_irq_base + i) {
+			disable_percpu_nmi(ipi_nmi);
+			teardown_percpu_nmi(ipi_nmi);
+		} else {
+			disable_percpu_irq(ipi_irq_base + i);
+		}
+	}
 }
 
 void __init set_smp_ipi_range(int ipi_base, int n)
 {
-	int i;
+	int i, err;
 
 	WARN_ON(n < NR_IPI);
 	nr_ipi = min(n, NR_IPI);
 
-	for (i = 0; i < nr_ipi; i++) {
-		int err;
+	err = request_percpu_nmi(ipi_base + IPI_CALL_NMI_FUNC,
+				 ipi_handler, "IPI", &cpu_number);
+	if (!err)
+		ipi_nmi = ipi_base + IPI_CALL_NMI_FUNC;
 
-		err = request_percpu_irq(ipi_base + i, ipi_handler,
-					 "IPI", &cpu_number);
-		WARN_ON(err);
+	for (i = 0; i < nr_ipi; i++) {
+		if (ipi_base + i != ipi_nmi) {
+			err = request_percpu_irq(ipi_base + i, ipi_handler,
+						 "IPI", &cpu_number);
+			WARN_ON(err);
+		}
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
-- 
2.7.4

