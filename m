Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616C0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32342207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNl6HzvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgETLNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETLNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:13:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4410AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:13:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f4so1267014pgi.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L4VlC3w2vGN2vXDu2vdOxtfNJ1ZDmhnMu1C9iDb4k5Q=;
        b=qNl6HzvIrP8iK8PRiHj/zvYTJ4DNHplta8G2LBd6c7zrLo9i6ACDRVaLkd6wXoXCJB
         +Fuka+XhWtRFpeAoF054KBR5WugZjBOv8jYQKfvLaSICPXf9AP3Zltm4vXBY+oWnEfez
         J1s6wj0eGeX1s/UrjZsBUIjUJKuYkd4aznXtek3r9WIw3NWoXXiMxBgc5QUGuJIdRYTu
         +yD1LPTQQ6D1fOc6EZ1NjUvpkAa3wEo8qscsWG+J7LF8y7qEUCk6GeYvOEmLUuJ03SAi
         Bin0nIdV7vyudrOoQomqHhjsrl55+SCMPftq7nhExZAGFrnf1zxw64T90Necr5seGfNb
         D3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L4VlC3w2vGN2vXDu2vdOxtfNJ1ZDmhnMu1C9iDb4k5Q=;
        b=PixRmTIq0ZIyg7H6KbIzs+NfvfjWoJf9G3GgLoxSAwLTtB83UVhwtufBEpCprFXpVT
         crMIYEPYU8Paibra0geEvIieDAFrC7UpPJcG/PwN96zIriblgzKz0jMrJkfdKjJk+aH6
         Ji3vk4WAGWvSz6WjiTqc5p5Iq9vdTAksQ9OxE4XrckIBQYDAR3Vgn3Q515JtBJEK3o5F
         CI6BJoiCzXJzo1QK9tSJJCpGq/8ijshYjpZha9Y+Z5B1zMmN34kqQivtUzTA0EdSKq0U
         97gJ2iePOFRGEL93dMQyaSWp4mGn0h3kW29nYatf5wGm6yixGERcuVqq1vWteYTgdAEc
         YcmA==
X-Gm-Message-State: AOAM531t1j22DFTTHomvuB4bLZPVm7lvIdT1hWtTnmmzWkb3lAaqy5bj
        GgDOK/BOAYmGaXYOtaL+u+kEqw==
X-Google-Smtp-Source: ABdhPJzFrj1psMvJysAYcuO/Cf5POOGdTZuwteJpZy4CrbC1e194avqYMKbaNslTxsDvhte0gChECQ==
X-Received: by 2002:a63:e60b:: with SMTP id g11mr3836980pgh.120.1589973194777;
        Wed, 20 May 2020 04:13:14 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id q134sm2044974pfc.143.2020.05.20.04.13.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 04:13:13 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 3/4] arm64: smp: Setup IPI_CALL_NMI_FUNC as a pseudo NMI
Date:   Wed, 20 May 2020 16:41:54 +0530
Message-Id: <1589973115-14757-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589973115-14757-1-git-send-email-sumit.garg@linaro.org>
References: <1589973115-14757-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup IPI_CALL_NMI_FUNC as a pseudo NMI using generic interrupt framework
APIs. In case a plarform doesn't provide support for pseudo NMIs, switch
back to IPI_CALL_NMI_FUNC being a normal interrupt.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/kernel/smp.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 236784e..c5e42a1 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -68,6 +68,7 @@ struct secondary_data secondary_data;
 int cpus_stuck_in_kernel;
 
 static int ipi_irq_base;
+static int ipi_nmi = -1;
 static int nr_ipi = NR_IPI;
 static struct irq_desc *ipi_desc[NR_IPI];
 
@@ -986,8 +987,14 @@ static void ipi_setup(int cpu)
 	if (ipi_irq_base) {
 		int i;
 
-		for (i = 0; i < nr_ipi; i++)
-			enable_percpu_irq(ipi_irq_base + i, 0);
+		for (i = 0; i < nr_ipi; i++) {
+			if (ipi_nmi == ipi_irq_base + i) {
+				if (!prepare_percpu_nmi(ipi_nmi))
+					enable_percpu_nmi(ipi_nmi, 0);
+			} else {
+				enable_percpu_irq(ipi_irq_base + i, 0);
+			}
+		}
 	}
 }
 
@@ -997,23 +1004,33 @@ static void ipi_teardown(int cpu)
 		int i;
 
 		for (i = 0; i < nr_ipi; i++)
-			disable_percpu_irq(ipi_irq_base + i);
+			if (ipi_nmi == ipi_irq_base + i) {
+				disable_percpu_nmi(ipi_nmi);
+				teardown_percpu_nmi(ipi_nmi);
+			} else {
+				disable_percpu_irq(ipi_irq_base + i);
+			}
 	}
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
+				 ipi_handler, "IPI", &irq_stat);
+	if (!err)
+		ipi_nmi = ipi_base + IPI_CALL_NMI_FUNC;
 
-		err = request_percpu_irq(ipi_base + i, ipi_handler,
-					 "IPI", &irq_stat);
-		WARN_ON(err);
+	for (i = 0; i < nr_ipi; i++) {
+		if (ipi_base + i != ipi_nmi) {
+			err = request_percpu_irq(ipi_base + i, ipi_handler,
+						 "IPI", &irq_stat);
+			WARN_ON(err);
+		}
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
 		irq_set_status_flags(ipi_base + i, IRQ_NO_ACCOUNTING);
-- 
2.7.4

