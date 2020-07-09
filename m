Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203FAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA5620708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZdVm7z5v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cF/PiVsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGIIqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:46:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:45:59 -0400
Date:   Thu, 09 Jul 2020 08:45:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594284356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PK1rRw0l5dc8LUsW5rkPMfi11Ef3wKnUH8e57/yWWOE=;
        b=ZdVm7z5vyhwkG30P6Jn34zN2OBQgca1gZF/vMUMwo8gh7J04d0O/p8SrG5ZZYZ/MXZFT+u
        W00WAvbUuL7yqAo3WBl6T8H0PDaOlN7cAC2znx1tEpB/AhuJovgsGQeUsp7wlUD5RZQKxt
        tElJxptSQP6b+80vwsJYB0wUzYoD8GH+H6phliBG8dMtNYI8IqVlRLb9uVvUsSGuo+UWwb
        L5Z0jDukB0iMZFaUhA/n/Linb3ZWRRvCkNdNvj0xN9kPBY3SuDyP2YDExRQSKKxsTHVrui
        AjQqsZ00XKO1KmLB7SmTtKYizcZz3HHZ3m5ewGhO6ZprGaD0u8jmzTSrkAv/Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594284356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PK1rRw0l5dc8LUsW5rkPMfi11Ef3wKnUH8e57/yWWOE=;
        b=cF/PiVskK/mbQCQ5stSTIsErm5LKAaWnWOEDzc+WP8Sq2yWpjjLs6qfZmo02uFeHT3nNVA
        GCf8dutNOQsRsaDQ==
From:   "tip-bot2 for Alex Belits" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] lib: Restrict cpumask_local_spread to houskeeping CPUs
Cc:     Alex Belits <abelits@marvell.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200625223443.2684-2-nitesh@redhat.com>
References: <20200625223443.2684-2-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <159428435597.4006.397915663801764561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1abdfe706a579a702799fce465bceb9fb01d407c
Gitweb:        https://git.kernel.org/tip/1abdfe706a579a702799fce465bceb9fb01d407c
Author:        Alex Belits <abelits@marvell.com>
AuthorDate:    Thu, 25 Jun 2020 18:34:41 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:39:01 +02:00

lib: Restrict cpumask_local_spread to houskeeping CPUs

The current implementation of cpumask_local_spread() does not respect the
isolated CPUs, i.e., even if a CPU has been isolated for Real-Time task,
it will return it to the caller for pinning of its IRQ threads. Having
these unwanted IRQ threads on an isolated CPU adds up to a latency
overhead.

Restrict the CPUs that are returned for spreading IRQs only to the
available housekeeping CPUs.

Signed-off-by: Alex Belits <abelits@marvell.com>
Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200625223443.2684-2-nitesh@redhat.com
---
 lib/cpumask.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index fb22fb2..85da6ab 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/memblock.h>
 #include <linux/numa.h>
+#include <linux/sched/isolation.h>
 
 /**
  * cpumask_next - get the next cpu in a cpumask
@@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
  */
 unsigned int cpumask_local_spread(unsigned int i, int node)
 {
-	int cpu;
+	int cpu, hk_flags;
+	const struct cpumask *mask;
 
+	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
+	mask = housekeeping_cpumask(hk_flags);
 	/* Wrap: we always want a cpu. */
-	i %= num_online_cpus();
+	i %= cpumask_weight(mask);
 
 	if (node == NUMA_NO_NODE) {
-		for_each_cpu(cpu, cpu_online_mask)
+		for_each_cpu(cpu, mask) {
 			if (i-- == 0)
 				return cpu;
+		}
 	} else {
 		/* NUMA first. */
-		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
+		for_each_cpu_and(cpu, cpumask_of_node(node), mask) {
 			if (i-- == 0)
 				return cpu;
+		}
 
-		for_each_cpu(cpu, cpu_online_mask) {
+		for_each_cpu(cpu, mask) {
 			/* Skip NUMA nodes, done above. */
 			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
 				continue;
