Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E1AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE572071A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dBUhoDsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgE2Vha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:37:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgE2VhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OvDinGx9xN3fLgAycdPBiwTRn9dQTI7aXBBvjsisKp4=; b=dBUhoDsxi+W4sURek7NpACxd8t
        J8hsioSpypVZsltyDtIARtivBeyoNfSx+SzCz7BKd3YfsbvJGtIyLx5E168BerPPmwfsV+M6nFTTq
        lbCBF1qqlS1t9/ypnPVXrxk/yIWm7989WIrnIM3ZZKxrsp7BtFslGrov0HO4vjuIIMrVHJ5jiGeH6
        VC6WkDaoP0vqJjt3Q1dTIiIpPINQOiW3e1HCOvVVZ5+QqCeI3dvV1S5RmUtjf+vRyjhjKuwXsCnWi
        ymjutDWf/4Eo8HnbNas9K3vWZKxCgmYmoOY3hgvHJCRheTAkoRGcQdbOM2/LXMoHRUIWfe2bkGTrb
        e5+u+Uag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeP-0007Iw-UA; Fri, 29 May 2020 21:34:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31366301205;
        Fri, 29 May 2020 23:34:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1C5D020FF0A05; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529213320.840953950@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: [PATCH 02/14] x86/hw_breakpoint: Prevent data breakpoints on direct GDT
References: <20200529212728.795169701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

A data breakpoint on the GDT is terrifying and should be avoided.
The GDT on CPU entry area is already protected. The direct GDT
should be also protected, although it is seldom used and only
used for short time.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200526014221.2119-3-laijs@linux.alibaba.com
---
 arch/x86/kernel/hw_breakpoint.c |   30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -32,6 +32,7 @@
 #include <asm/processor.h>
 #include <asm/debugreg.h>
 #include <asm/user.h>
+#include <asm/desc.h>
 
 /* Per cpu debug control register value */
 DEFINE_PER_CPU(unsigned long, cpu_dr7);
@@ -237,13 +238,26 @@ static inline bool within_area(unsigned
 }
 
 /*
- * Checks whether the range from addr to end, inclusive, overlaps the CPU
- * entry area range.
+ * Checks whether the range from addr to end, inclusive, overlaps the fixed
+ * mapped CPU entry area range or other ranges used for CPU entry.
  */
-static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
+static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 {
-	return within_area(addr, end, CPU_ENTRY_AREA_BASE,
-			   CPU_ENTRY_AREA_TOTAL_SIZE);
+	int cpu;
+
+	/* CPU entry erea is always used for CPU entry */
+	if (within_area(addr, end, CPU_ENTRY_AREA_BASE,
+			CPU_ENTRY_AREA_TOTAL_SIZE))
+		return true;
+
+	for_each_possible_cpu(cpu) {
+		/* The original rw GDT is being used after load_direct_gdt() */
+		if (within_area(addr, end, (unsigned long)get_cpu_gdt_rw(cpu),
+				GDT_SIZE))
+			return true;
+	}
+
+	return false;
 }
 
 static int arch_build_bp_info(struct perf_event *bp,
@@ -257,12 +271,12 @@ static int arch_build_bp_info(struct per
 		return -EINVAL;
 
 	/*
-	 * Prevent any breakpoint of any type that overlaps the
-	 * cpu_entry_area.  This protects the IST stacks and also
+	 * Prevent any breakpoint of any type that overlaps the CPU
+	 * entry area and data.  This protects the IST stacks and also
 	 * reduces the chance that we ever find out what happens if
 	 * there's a data breakpoint on the GDT, IDT, or TSS.
 	 */
-	if (within_cpu_entry_area(attr->bp_addr, bp_end))
+	if (within_cpu_entry(attr->bp_addr, bp_end))
 		return -EINVAL;
 
 	hw->address = attr->bp_addr;


