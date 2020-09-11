Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC50C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994E022204
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGOWZRFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgIKQWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgIKP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:28:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77ADC061796
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z19so7338029pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Borfb2c/AuKaxrPEvHGpc2ZkIkK0QqkS7G7OkbQVw6o=;
        b=jGOWZRFHUPusoZoYx87HUc0UdvWsBxz/6APZqblOC9XbCFv0ytJIfpKbUiqGR+qoBp
         OecjXlHzj+qtca8/4IwvdC6BImis+apETeuCYAtSsst/IzfSeJ9zBlJJOWLAZ8Q3b6pm
         yKHIP/rm3cGeLhNBMovZS3Ac8tjlfx5ca9yGhAwO+l3zo/53AazZkVt70xeUCA9FCju/
         EGMp/NOXqs0btZS4XhRbtqqwXskqCdE6JBpojPgaA7D1Dyl9f8kzzekwPx3+YC8LIm61
         J7tsBhGdMbL0TwkfjHVGE+2z6hAPvDArpTr24zfjOcqFOHryVEhD9n16KKxaEvvfXSfS
         0BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Borfb2c/AuKaxrPEvHGpc2ZkIkK0QqkS7G7OkbQVw6o=;
        b=LBrFSCR6wE9+srAWXp5+kL4vITu/ADiJfg8KEq6mIi9LC3KF4Ufmdj75WnVbw0JKeC
         HO8dl3b49SsFYTSLa6pjZDJ84qmYoI4Uir5DA6tJnlC+YKWBq654lg7CkZJ6311Dmska
         xPz1bo8jbypSuClZEUS2L20jVXYxlhzbYQ5/gS9H9xBAmB97WTUZqKJXgbHFGjpYsjTU
         bpDCcRxIXbjXR8uwDfL/SR4/4/bZUWPr9vwYrnldRTPGAM5b/u9ynJhelXFujJ9pgQF1
         rDcL5J0CkRY+OTMQao4t2BWFCu85DaOqaNT+WHFCeBK24qGebP9GYDF8O2GJUZyNaKkp
         DVlQ==
X-Gm-Message-State: AOAM533VHPtqS7TS87KKxM0euIlQ+NcfY4Q9HflsAbXz2TieHK3yu9af
        VNtfXeAa7sz0nvbQD6oSWgk0oQ==
X-Google-Smtp-Source: ABdhPJxr9ACTHLE1mqe3DgZIxSLIMmNQF1fyLmvRkWYTYL0CQRvGUt3F8c0z0XSGcO/b1SJoc8A1AA==
X-Received: by 2002:a62:5244:: with SMTP id g65mr2133117pfb.132.1599830968549;
        Fri, 11 Sep 2020 06:29:28 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.48])
        by smtp.gmail.com with ESMTPSA id e10sm557988pgb.45.2020.09.11.06.29.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:29:27 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 3/5] arm64: smp: Allocate and setup IPI as NMI
Date:   Fri, 11 Sep 2020 18:58:42 +0530
Message-Id: <1599830924-13990-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
References: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate an unused IPI that can be turned as NMI using ipi_nmi framework.
Also, invoke corresponding NMI setup/teardown APIs.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b6bde26..3f3b1ff 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -43,6 +43,7 @@
 #include <asm/daifflags.h>
 #include <asm/kvm_mmu.h>
 #include <asm/mmu_context.h>
+#include <asm/nmi.h>
 #include <asm/numa.h>
 #include <asm/processor.h>
 #include <asm/smp_plat.h>
@@ -962,6 +963,8 @@ static void ipi_setup(int cpu)
 
 	for (i = 0; i < nr_ipi; i++)
 		enable_percpu_irq(ipi_irq_base + i, 0);
+
+	ipi_nmi_setup(cpu);
 }
 
 static void ipi_teardown(int cpu)
@@ -973,6 +976,8 @@ static void ipi_teardown(int cpu)
 
 	for (i = 0; i < nr_ipi; i++)
 		disable_percpu_irq(ipi_irq_base + i);
+
+	ipi_nmi_teardown(cpu);
 }
 
 void __init set_smp_ipi_range(int ipi_base, int n)
@@ -993,6 +998,9 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
 	}
 
+	if (n > nr_ipi)
+		set_smp_ipi_nmi(ipi_base + nr_ipi);
+
 	ipi_irq_base = ipi_base;
 
 	/* Setup the boot CPU immediately */
-- 
2.7.4

