Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527ACC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E8320848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J5v1QjMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCEMjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:39:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49106 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgCEMjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X2O5NKFp9n04Owtfbt5vDxVlsXil0fvVO5mXmQHlxr0=; b=J5v1QjMQjtFTYNn5cTlTGQfYVL
        gVUD9USIHOX5qrHGFBT/NqmMLsbNAzjJZ4f/kXBRWWXsGjOMcI63+SvP6LdKPaJD/PGpwReVHyU82
        aGB1KqlMvZdTO4E4vAH3yl+b6dq6xiiwK/fR+NDE+XzgSKcgJ9piNgYaiZOJBBVoKraB7bycAEM1R
        4NpUV8+X/1EzcyME2aqit2EEcHB5YTMhZc/ewBkrJHqFIqYwcTXIGXF9YuIHLkYfEiUj1jTsQ70LJ
        6mHBa7ARS9j8fPSdyClRHi09nYc35asRZvm2tNKOrP5MeWw5HLkA+UHubrK7aeotsKV1jElDg+3LW
        22/cEkVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9pmA-0004Is-2q; Thu, 05 Mar 2020 12:38:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1811E30066E;
        Thu,  5 Mar 2020 13:38:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F337F20139C6B; Thu,  5 Mar 2020 13:38:51 +0100 (CET)
Date:   Thu, 5 Mar 2020 13:38:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH] perf/core: Fix endless multiplex timer
Message-ID: <20200305123851.GX2596@hirez.programming.kicks-ass.net>
References: <20200303202819.3942-1-kan.liang@linux.intel.com>
 <20200303210812.GA4745@worktop.programming.kicks-ass.net>
 <b71515e4-484e-d80a-37db-2e51abe69928@linux.intel.com>
 <20200304093344.GJ2596@hirez.programming.kicks-ass.net>
 <6a271c19-9575-24ca-8ebc-9ff5a65bbe3d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a271c19-9575-24ca-8ebc-9ff5a65bbe3d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:20:42AM -0500, Liang, Kan wrote:
> 
> NMI watchdog is pinned event.
> ctx_event_to_rotate() will only pick an event from the flexible_groups.
> So the cpu_ctx_sched_out() in perf_rotate_context() will never be called.

Surely that's fixable; same principle.

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3f1f77de7247..595fb3decd43 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2182,6 +2182,7 @@ __perf_remove_from_context(struct perf_event *event,
 
 	if (!ctx->nr_events && ctx->is_active) {
 		ctx->is_active = 0;
+		ctx->rotate_necessary = 0;
 		if (ctx->task) {
 			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
 			cpuctx->task_ctx = NULL;
@@ -3077,12 +3078,6 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 	if (!ctx->nr_active || !(is_active & EVENT_ALL))
 		return;
 
-	/*
-	 * If we had been multiplexing, no rotations are necessary, now no events
-	 * are active.
-	 */
-	ctx->rotate_necessary = 0;
-
 	perf_pmu_disable(ctx->pmu);
 	if (is_active & EVENT_PINNED) {
 		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
@@ -3092,6 +3087,13 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 	if (is_active & EVENT_FLEXIBLE) {
 		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list)
 			group_sched_out(event, cpuctx, ctx);
+
+		/*
+		 * Since we cleared EVENT_FLEXIBLE, also clear
+		 * rotate_necessary, is will be reset by
+		 * ctx_flexible_sched_in() when needed.
+		 */
+		ctx->rotate_necessary = 0;
 	}
 	perf_pmu_enable(ctx->pmu);
 }
@@ -3841,6 +3843,12 @@ ctx_event_to_rotate(struct perf_event_context *ctx)
 				      typeof(*event), group_node);
 	}
 
+	/*
+	 * Unconditionally clear rotate_necessary; if ctx_flexible_sched_in()
+	 * finds there are unschedulable events, it will set it again.
+	 */
+	ctx->rotate_necessary = 0;
+
 	return event;
 }
 
