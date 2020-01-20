Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02B8C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8061D2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZJCzDnVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgATIun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:50:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FHQHy9MJDq8pTNILUwL7Udrti/XuWgeB7brLm2Zqto8=; b=ZJCzDnVOx8H2QIEA18weBsJYC
        bMBOjOCNrI+vUOu42EbxW0fNdEqeto3PJ7fMEtoDJgaNEir9A7U+QFxh4tY5aUnLBVimuVXxgdnbO
        4NnRj10z4RvNBxthlAzd5yYe2wQ+UVudOcON2ggL3P5SawflTAXVlJzxLPxfEKE63Ku52bZVsTwG0
        pFsYBtr6Q3wjd7ctJSbJM5AeXXbPeNhXCobcZKNXlFrCMNdoph5YQnJTeRAAuu4QGwSW9wZftuMK9
        jOGFmeOtL/ON0U5fzfoufh09N7VzKuy3KBzRk+FcQ94Fb0n2sYsdeM+ps0lv9TFGxcloKpvtsw6u9
        XYS1bG4wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itSlO-0002QF-4l; Mon, 20 Jan 2020 08:50:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 643FA3008A9;
        Mon, 20 Jan 2020 09:48:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB3282B2811DA; Mon, 20 Jan 2020 09:50:22 +0100 (CET)
Date:   Mon, 20 Jan 2020 09:50:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Andi Kleen <andi@firstfloor.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] perf/core: Install cgroup event via IPI
Message-ID: <20200120085022.GJ14879@hirez.programming.kicks-ass.net>
References: <20200116172555.3674873-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116172555.3674873-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 09:25:55AM -0800, Song Liu wrote:
> cgroup events in OFF state cannot be installed without IPI, otherwise, it
> may trigger the following calltrace with CONFIG_DEBUG_LIST:
> 
> [   31.776974] ------------[ cut here ]------------
> [   31.777570] list_add double add: new=ffff888ff7cf0db0, prev=ffff888ff7ce82f0, next=ffff888ff7cf0db0.
> [   31.778737] WARNING: CPU: 3 PID: 1186 at lib/list_debug.c:31 __list_add_valid+0x67/0x70
> [   31.779745] Modules linked in:
> [   31.780138] CPU: 3 PID: 1186 Comm: perf Tainted: G        W         5.5.0-rc6+ #3962
> [   31.781125] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> [   31.782199] RIP: 0010:__list_add_valid+0x67/0x70

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a1f8bde19b56..36e8fe27e2a1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2682,14 +2682,18 @@ perf_install_in_context(struct perf_event_context *ctx,
>  	smp_store_release(&event->ctx, ctx);
>  
>  	/*
> -	 * perf_event_attr::disabled events will not run and can be initialized
> -	 * without IPI. Except when this is the first event for the context, in
> -	 * that case we need the magic of the IPI to set ctx->is_active.
> +	 * perf_event_attr::disabled events will not run and can be
> +	 * initialized without IPI. Except:
> +	 *   1. when this is the first event for the context, in that case
> +	 *      we need the magic of the IPI to set ctx->is_active;
> +	 *   2. cgroup event in OFF state, because it is installed in the
> +	 *      cpuctx.
>  	 *
>  	 * The IOC_ENABLE that is sure to follow the creation of a disabled
>  	 * event will issue the IPI and reprogram the hardware.
>  	 */
> -	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF && ctx->nr_events) {
> +	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF &&
> +	    !is_cgroup_event(event) && ctx->nr_events) {
>  		raw_spin_lock_irq(&ctx->lock);
>  		if (ctx->task == TASK_TOMBSTONE) {
>  			raw_spin_unlock_irq(&ctx->lock);

I don't think this is right. Because cgroup events are always per-cpu
events, ctx == &cpuctx->ctx, so the locking should work out just fine.

What does appear to be the problem is that:

  add_event_to_ctx()
    list_update_cgroup_event()
      cpuctx = __get_cpu_context(ctx)

uses this_cpu_ptr() and we're now calling it from the 'wrong' CPU.

But I'm thinking the below should also work just fine, hmm?

---

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2173c23c25b4..2c6134604811 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -951,9 +951,9 @@ list_update_cgroup_event(struct perf_event *event,
 
 	/*
 	 * Because cgroup events are always per-cpu events,
-	 * this will always be called from the right CPU.
+	 * @ctx == &cpuctx->cpu.
 	 */
-	cpuctx = __get_cpu_context(ctx);
+	cpuctx = container_of(ctx, struct perf_cpu_context, ctx);
 
 	/*
 	 * Since setting cpuctx->cgrp is conditional on the current @cgrp
