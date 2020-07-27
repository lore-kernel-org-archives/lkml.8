Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6341C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2975206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YZlE7wpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgG0FN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:13:57 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:50178 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgG0FN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:13:57 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2436EC0641;
        Mon, 27 Jul 2020 05:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1595826836; bh=eul44+C62DTDvDmmS3zMwGRsSJ3B5+hYF5hZSdNPdx8=;
        h=From:To:Cc:Subject:Date:From;
        b=YZlE7wpKcVSwyi8bkmwbLc0lqtJM8vmgs1XgeUj4/2EWDSbzoW7OtlFn3Rdf+mZBk
         jPWD0WUkCtO9D1ms27FWkl8AJGUlqpw+glKlj5JIZjMAzWEZQTkgiiobusbsmJtKAz
         GEuUwBKhRhQzc5upBNHt4gDTTKUfnFHAv8YWFBVTbvzhkaKguWefuxD57/uDKkSU7w
         ifJmPOb9iz7tBou+1ivkMHfnDKr3WgMqu588ajxCoHEIVDPiDSL74GmVrh35Ia8fUt
         j3V6WmOneMbSRy4z7PyxT0nfZ3+GUsmynK/ml3f1k+kJYC8X86r9FlMu30EyOktwkF
         KOYY3e+mmwTMw==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id 40187A0096;
        Mon, 27 Jul 2020 05:13:52 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] ARC: perf: don't bail setup if pct irq missing in device-tree
Date:   Sun, 26 Jul 2020 22:13:45 -0700
Message-Id: <20200727051345.13382-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code inadventely bails if hardware supports sampling/overflow
interrupts, but the irq is missing from device tree. This need not be as
we can still do simple counting based perf stat.

This unborks perf on HSDK-4xD

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/perf_event.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 661fd842ea97..79849f37e782 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -562,7 +562,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 {
 	struct arc_reg_pct_build pct_bcr;
 	struct arc_reg_cc_build cc_bcr;
-	int i, has_interrupts;
+	int i, has_interrupts, irq;
 	int counter_size;	/* in bits */
 
 	union cc_name {
@@ -637,13 +637,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 		.attr_groups	= arc_pmu->attr_groups,
 	};
 
-	if (has_interrupts) {
-		int irq = platform_get_irq(pdev, 0);
-
-		if (irq < 0) {
-			pr_err("Cannot get IRQ number for the platform\n");
-			return -ENODEV;
-		}
+	if (has_interrupts && (irq = platform_get_irq(pdev, 0) >= 0)) {
 
 		arc_pmu->irq = irq;
 
@@ -652,9 +646,9 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 				   this_cpu_ptr(&arc_pmu_cpu));
 
 		on_each_cpu(arc_cpu_pmu_irq_init, &irq, 1);
-
-	} else
+	} else {
 		arc_pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	}
 
 	/*
 	 * perf parser doesn't really like '-' symbol in events name, so let's
-- 
2.20.1

