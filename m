Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9238C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D7520853
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dTsFKm8t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="chifnWvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgGHJvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:51:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47986 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgGHJvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:50 -0400
Date:   Wed, 08 Jul 2020 09:51:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+or6mC2pwfStuq70xpfVb7RWLi7kzoRl+X97wO05nqY=;
        b=dTsFKm8tTLwj75JsRgb8kX5PRjujtY03u4+uABxzKZsHcUE6+Y5obBglByzDjLoBid+7z9
        ci2rbDByv1y4gJJnmZGPrN2HWZLmMTWbUA3I3P3oWcYUkf3aFzMFfFnMcc4L1vhfEcs8Tf
        w/N51m2CobPUf5FzbdnxsZ4M70EtX+JMB47Vlx6O04v34SHjdenii07Z6XY31zpxzrwKOh
        xDw9WVQpz0ECD/9hBd6J/I81xnMvgDBmI/v2sWS5EmifriuIqrcwScAJQgnsPXhnxpX1ma
        YzNcOz4oCC3KEFBzhgIYkaSCH7nt/gEWcofWlhGn8Hiry05uRZHPlAqgAfifeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+or6mC2pwfStuq70xpfVb7RWLi7kzoRl+X97wO05nqY=;
        b=chifnWvHS5HPYa/96ACyVjjzl9ZuiaaX7NKoLz8CDaQyBByz5hcr6uqSck0VOl7FgHps5R
        lh0zjilC2iszfqDQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Factor out functions to allocate/free the
 task_ctx_data
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-16-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-16-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420190762.4006.15116080033507278243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ff9ff926889dd8026b4ba55266a010c27f68604f
Gitweb:        https://git.kernel.org/tip/ff9ff926889dd8026b4ba55266a010c27f68604f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:21 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:54 +02:00

perf/core: Factor out functions to allocate/free the task_ctx_data

The method to allocate/free the task_ctx_data is going to be changed in
the following patch. Currently, the task_ctx_data is allocated/freed in
several different places. To avoid repeatedly modifying the same codes
in several different places, alloc_task_ctx_data() and
free_task_ctx_data() are factored out to allocate/free the
task_ctx_data. The modification only needs to be applied once.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-16-git-send-email-kan.liang@linux.intel.com
---
 kernel/events/core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9b8f925..7509040 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1238,12 +1238,22 @@ static void get_ctx(struct perf_event_context *ctx)
 	refcount_inc(&ctx->refcount);
 }
 
+static void *alloc_task_ctx_data(struct pmu *pmu)
+{
+	return kzalloc(pmu->task_ctx_size, GFP_KERNEL);
+}
+
+static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
+{
+	kfree(task_ctx_data);
+}
+
 static void free_ctx(struct rcu_head *head)
 {
 	struct perf_event_context *ctx;
 
 	ctx = container_of(head, struct perf_event_context, rcu_head);
-	kfree(ctx->task_ctx_data);
+	free_task_ctx_data(ctx->pmu, ctx->task_ctx_data);
 	kfree(ctx);
 }
 
@@ -4471,7 +4481,7 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		goto errout;
 
 	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
-		task_ctx_data = kzalloc(pmu->task_ctx_size, GFP_KERNEL);
+		task_ctx_data = alloc_task_ctx_data(pmu);
 		if (!task_ctx_data) {
 			err = -ENOMEM;
 			goto errout;
@@ -4529,11 +4539,11 @@ retry:
 		}
 	}
 
-	kfree(task_ctx_data);
+	free_task_ctx_data(pmu, task_ctx_data);
 	return ctx;
 
 errout:
-	kfree(task_ctx_data);
+	free_task_ctx_data(pmu, task_ctx_data);
 	return ERR_PTR(err);
 }
 
@@ -12497,8 +12507,7 @@ inherit_event(struct perf_event *parent_event,
 	    !child_ctx->task_ctx_data) {
 		struct pmu *pmu = child_event->pmu;
 
-		child_ctx->task_ctx_data = kzalloc(pmu->task_ctx_size,
-						   GFP_KERNEL);
+		child_ctx->task_ctx_data = alloc_task_ctx_data(pmu);
 		if (!child_ctx->task_ctx_data) {
 			free_event(child_event);
 			return ERR_PTR(-ENOMEM);
