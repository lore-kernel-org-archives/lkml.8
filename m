Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED54C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8913D207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rzGMCDTZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DIXLXeyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgHSIyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgHSIwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:52:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78770C061343;
        Wed, 19 Aug 2020 01:52:08 -0700 (PDT)
Date:   Wed, 19 Aug 2020 08:52:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597827126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDhTYGjcq4hRoNjkXO7m3LqBsirHwTeENnCZjBg6PJM=;
        b=rzGMCDTZHriZ0ClfBtf5zXZYM2lvj7TORbrBEupYGKTnk7DGF1S7Vy9nilYhPndEBKowSd
        PLsaiLovRJLQPuEPpQCosw2IX3VBAeVibei4q0fdL8XIItpo+6tZT8GOIeXUZdjsnZPa/D
        +BBRmkeiSjJEO6KA5+9l3uMKtsHhh9sskKfzoj3EGOR1i23JeVGen9SAw5urniCgS6fCg2
        Vh2nso/yf4zy5NY23aFlMIDciL/Y1vJBua9xPeXHUW5VnKPcct40GxLRQ6vAy7mLQZl0Vy
        OAgIMtRHpfxrsGeGkdoifIgHxRDJ5D+vYfSR2H4K4DrqJ3LrMVFC0HY3DuX3sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597827126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDhTYGjcq4hRoNjkXO7m3LqBsirHwTeENnCZjBg6PJM=;
        b=DIXLXeyUUUqpXrHZRxoUWeu4777+i3mZ8GMoaZLAWSV7R6rwgzQl/gAPrUYtLt5Wv0jh0d
        PCnysNUNsHLQcQAQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add a macro for RDPMC offset of fixed counters
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171117.9918-10-kan.liang@linux.intel.com>
References: <20200723171117.9918-10-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159782712634.3192.7845292859376351543.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0e2e45e2ded4988f5641115fd996c75dc32e4be3
Gitweb:        https://git.kernel.org/tip/0e2e45e2ded4988f5641115fd996c75dc32e4be3
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 23 Jul 2020 10:11:12 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Aug 2020 16:34:36 +02:00

perf/x86: Add a macro for RDPMC offset of fixed counters

The RDPMC base offset of fixed counters is hard-code. Use a meaningful
name to replace the magic number to improve the readability of the code.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200723171117.9918-10-kan.liang@linux.intel.com
---
 arch/x86/events/core.c            | 3 ++-
 arch/x86/include/asm/perf_event.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 53fcf0a..ebf723f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1151,7 +1151,8 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
 				(idx - INTEL_PMC_IDX_FIXED);
-		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) | 1<<30;
+		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) |
+					INTEL_PMC_FIXED_RDPMC_BASE;
 		break;
 
 	default:
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 000cab7..964ba31 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -196,6 +196,9 @@ struct x86_pmu_capability {
  * Fixed-purpose performance events:
  */
 
+/* RDPMC offset for Fixed PMCs */
+#define INTEL_PMC_FIXED_RDPMC_BASE		(1 << 30)
+
 /*
  * All the fixed-mode PMCs are configured via this single MSR:
  */
