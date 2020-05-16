Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF650C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CE220671
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCJnrewn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgEPMuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726206AbgEPMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:50:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF7DC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:50:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so2237892pjw.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/VElStb6fjAYbZ4B7vgbZVnEhth0ws2lGWe8fvBxrg=;
        b=SCJnrewntUekgCrLrPYKTjDyWUiaT6tukJ7ghZCp/+OlBZYuLFZdo2vx6iAo08VGqN
         HA9FU+E4IuYzi3E4RLgOGtcsrMKaIVhKfJk8juuPDehu3XUNZEfCnrFKPBAZKCX4xGqb
         hs1nFDZ67Bdf0zkzStFPU4wszli+z8hWwt3+8E2+bCSZh+E2Bm66Im4l8o0Ips+Flf/n
         FFQ1sO1tqv4qIv2PgbVNPXtzzz4QFerAN3CxpgNEm3uUPTzlh/z8jL8/4qLXPiJzRbeb
         PGGA/oywLbZkAycUIqB9G9+4YBpewcErpSWjLaYM/h/L6u16827k/r8aJfYhCa2S8oPu
         y4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/VElStb6fjAYbZ4B7vgbZVnEhth0ws2lGWe8fvBxrg=;
        b=nnaC2pCaMbUK7DMCjoiU2wUQ33OgwxDpnDKBauAPv7lXj6mskxdvTOY7rChOz06tPI
         UXFE7UVw8QbsxHdlJMRd5LCR7GnDAa7mE9aanKjEgitTeHJ5aa8WNmDKAWoBb9erALxh
         QY7Z4fAxNXAptZTD705x6nDYe28Wr9rAlcp30FpNiYWI/R/XwBYDwYHeS3WueRL4kz0P
         jBC1ETTfSTDxXfrwiC+QHCAZ/kWX7JtlLqVCzezmDdw0BRRTxqIRYRsKwNr+y0YQmL3D
         yxLPcXX1pmsL/tMuMual7Xx2LMCIqd49DX3QpbfxPR/Z//fsrNr7wRpIn98I2aaY+r00
         ETyQ==
X-Gm-Message-State: AOAM5327CrZCpdjmlsB2SotwyxZ8XZEuK+FoZfXuI2XSPID1a1TSrVUJ
        /+o/mfYuiiWp1OVfRtbyRSxSXcWZ
X-Google-Smtp-Source: ABdhPJzcs64HJTWzTse+oOBspVOEV5XzRGG9wrG7svjtS4HdTsyk3E3hIOd9b+hUCGQIn9WnzsqeTQ==
X-Received: by 2002:a17:90a:7349:: with SMTP id j9mr9123258pjs.196.1589633405850;
        Sat, 16 May 2020 05:50:05 -0700 (PDT)
Received: from localhost.localdomain (61-228-240-171.dynamic-ip.hinet.net. [61.228.240.171])
        by smtp.gmail.com with ESMTPSA id k27sm3768323pgb.30.2020.05.16.05.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 05:50:05 -0700 (PDT)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lecopzer.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        matthias.bgg@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, acme@kernel.org,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-mediatek@lists.infradead.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        yj.chiang@mediatek.com, Lecopzer Chen <lecopzer@gmail.com>
Subject: [PATCH 1/3] arm_pmu: Add support for perf NMI interrupts registration
Date:   Sat, 16 May 2020 20:48:55 +0800
Message-Id: <20200516124857.75004-2-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200516124857.75004-1-lecopzer@gmail.com>
References: <20200516124857.75004-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register perf interrupts by request_nmi()/percpu_nmi() when both
ARM64_PSEUDO_NMI and ARM64_PSEUDO_NMI_PERF are enabled and nmi
cpufreature is active.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 drivers/perf/arm_pmu.c       | 51 +++++++++++++++++++++++++++++++-----
 include/linux/perf/arm_pmu.h |  6 +++++
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index df352b334ea7..fa37b72d19e2 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -559,6 +559,48 @@ void armpmu_free_irq(int irq, int cpu)
 	per_cpu(cpu_irq, cpu) = 0;
 }
 
+static void armpmu_prepare_percpu_nmi_other(void *info)
+{
+	/*
+	 * We don't need to disable preemption since smp_call_function()
+	 * did this for us.
+	 */
+	prepare_percpu_nmi((uintptr_t) info);
+}
+
+static int _armpmu_request_irq(unsigned int irq, irq_handler_t handler,
+			       unsigned long flags, int cpu)
+{
+	if (armpmu_support_nmi())
+		return request_nmi(irq, handler, flags, "arm-pmu",
+				   per_cpu_ptr(&cpu_armpmu, cpu));
+	return request_irq(irq, handler, flags, "arm-pmu",
+			   per_cpu_ptr(&cpu_armpmu, cpu));
+}
+
+static int _armpmu_request_percpu_irq(unsigned int irq, irq_handler_t handler)
+{
+	if (armpmu_support_nmi()) {
+		int err;
+
+		err = request_percpu_nmi(irq, handler, "arm-pmu",
+					 &cpu_armpmu);
+		if (err)
+			return err;
+
+		preempt_disable();
+		err = prepare_percpu_nmi(irq);
+		if (err) {
+			return err;
+			preempt_enable();
+		}
+		smp_call_function(armpmu_prepare_percpu_nmi_other,
+				  (void *)(uintptr_t) irq, true);
+		preempt_enable();
+	}
+	return request_percpu_irq(irq, handler, "arm-pmu",
+				  &cpu_armpmu);
+}
+
 int armpmu_request_irq(int irq, int cpu)
 {
 	int err = 0;
@@ -582,12 +624,9 @@ int armpmu_request_irq(int irq, int cpu)
 			    IRQF_NO_THREAD;
 
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
-		err = request_irq(irq, handler, irq_flags, "arm-pmu",
-				  per_cpu_ptr(&cpu_armpmu, cpu));
-	} else if (armpmu_count_irq_users(irq) == 0) {
-		err = request_percpu_irq(irq, handler, "arm-pmu",
-					 &cpu_armpmu);
-	}
+		err = _armpmu_request_irq(irq, handler, irq_flags, cpu);
+	} else if (armpmu_count_irq_users(irq) == 0)
+		err = _armpmu_request_percpu_irq(irq, handler);
 
 	if (err)
 		goto err_out;
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 5b616dde9a4c..5b878b5a22aa 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -160,6 +160,12 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
 static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
 #endif
 
+static inline bool armpmu_support_nmi(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI_PERF) &&
+	       system_uses_irq_prio_masking();
+}
+
 /* Internal functions only for core arm_pmu code */
 struct arm_pmu *armpmu_alloc(void);
 struct arm_pmu *armpmu_alloc_atomic(void);
-- 
2.25.1

