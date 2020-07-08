Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2994DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F0C20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1BlMkUF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3Vs5Re0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgGHJvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGHJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F168EC08C5DC;
        Wed,  8 Jul 2020 02:51:47 -0700 (PDT)
Date:   Wed, 08 Jul 2020 09:51:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JJjUfmuHysNBryM7uHgIfTniU1JPg1OQP686fOVpusw=;
        b=a1BlMkUFxIqaRuWurkVMGP9lgfy+gqsXBWO+wZ3T0auz/gTw9WzCoyhcBH8EUAbRUM+WUc
        +sU+jjoxKeTqZHWqlHoIUVWbJp0Qp3tXxo1QrDFCqfyHe47ZxTPdpKjDd7QChfEsUcou3A
        bnD18faubYBrxqYWJl9a5woTE6wmavAyePNSBU0PKIHBlCC9tsG7ESu55twWjLx5P0NE3z
        J6AmU+P3BilcMQ6ndkyiZwCuU9shHKipz9x/87KXnS3nTxFgNsMB6hRFejdsUz26wmjKqb
        Tu7oSG+8oUYFWq7KZvTXAq8GqiMF3E+w1Mm3+5IcCc8kjM4WjVCbE7jTgMKJNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JJjUfmuHysNBryM7uHgIfTniU1JPg1OQP686fOVpusw=;
        b=a3Vs5Re05NullXkvauUaddziinmY19WwXlOC9pqC52RjI4gV73xpet1aif8KGKJZpwfOs4
        nb/Uz8r0mM6bkgDw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Remove task_ctx_size
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-19-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-19-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420190589.4006.9804478417037329640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5a09928d339f3cf0973991ddc3a2798825c84c99
Gitweb:        https://git.kernel.org/tip/5a09928d339f3cf0973991ddc3a2798825c84c99
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:24 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:55 +02:00

perf/x86: Remove task_ctx_size

A new kmem_cache method has replaced the kzalloc() to allocate the PMU
specific data. The task_ctx_size is not required anymore.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-19-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c      | 1 -
 arch/x86/events/intel/lbr.c | 1 -
 include/linux/perf_event.h  | 4 ----
 kernel/events/core.c        | 4 +---
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d740c86..6b1228a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2371,7 +2371,6 @@ static struct pmu pmu = {
 
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
-	.task_ctx_size          = sizeof(struct x86_perf_task_context),
 	.swap_task_ctx		= x86_pmu_swap_task_ctx,
 	.check_period		= x86_pmu_check_period,
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index e784c1d..3ad5289 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1672,7 +1672,6 @@ void __init intel_pmu_arch_lbr_init(void)
 
 	size = sizeof(struct x86_perf_task_context_arch_lbr) +
 	       lbr_nr * sizeof(struct lbr_entry);
-	x86_get_pmu()->task_ctx_size = size;
 	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
 
 	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 09915ae..3b22db0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -419,10 +419,6 @@ struct pmu {
 	 */
 	void (*sched_task)		(struct perf_event_context *ctx,
 					bool sched_in);
-	/*
-	 * PMU specific data size
-	 */
-	size_t				task_ctx_size;
 
 	/*
 	 * Kmem cache of PMU specific data
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 30d9b31..7c436d7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1243,15 +1243,13 @@ static void *alloc_task_ctx_data(struct pmu *pmu)
 	if (pmu->task_ctx_cache)
 		return kmem_cache_zalloc(pmu->task_ctx_cache, GFP_KERNEL);
 
-	return kzalloc(pmu->task_ctx_size, GFP_KERNEL);
+	return NULL;
 }
 
 static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
 {
 	if (pmu->task_ctx_cache && task_ctx_data)
 		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
-	else
-		kfree(task_ctx_data);
 }
 
 static void free_ctx(struct rcu_head *head)
