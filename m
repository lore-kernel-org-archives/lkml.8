Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD74C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2705B20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMlw0eEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGXKzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXKzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:55:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D5C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dTI0RvYmB+fP73ftp8+VFu/GFD8sMlcrk0x3WCQYmQI=; b=rMlw0eEkaKNDAz+lfekbBI0Z3+
        usBKIbI7FDAJDFs0Sg/cDph9xhnpgYIKSLNVoMHX5M3EhGjTgJdQN4hSdu4Drx0upPjEenM9DEHO4
        /uGLK/DgyWQzb/QOxpFxP6brhyiweIm/W6OfxPDQyh3+v2QJLoVKuAdAb1sNqaXJ/qX7Kkor0yMZn
        e+RjsYYIg1hn/YvnsnTNEX7RYsZIlTGBdLaoEA3txs0ADJ8veT7UA98FLjUPxZaakZvS1odKFp7//
        OU50s3WOieZW8B/s808/qjccOGEuNWfYxWFPjxggdM3Gwn1qPbjR6lxpR9IYqLdGHsfg+9tumstRa
        BHI7PBTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyvMe-0005Ll-VL; Fri, 24 Jul 2020 10:55:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CF5C300446;
        Fri, 24 Jul 2020 12:55:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E66F2847BADA; Fri, 24 Jul 2020 12:55:43 +0200 (CEST)
Date:   Fri, 24 Jul 2020 12:55:43 +0200
From:   peterz@infradead.org
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
Message-ID: <20200724105543.GV119549@hirez.programming.kicks-ass.net>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723171117.9918-8-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:11:10AM -0700, kan.liang@linux.intel.com wrote:

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 3b22db08b6fb..93631e5389bf 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -576,9 +576,14 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
>   * PERF_EV_CAP_SOFTWARE: Is a software event.
>   * PERF_EV_CAP_READ_ACTIVE_PKG: A CPU event (or cgroup event) that can be read
>   * from any CPU in the package where it is active.
> + * PERF_EV_CAP_COEXIST: An event with this flag must coexist with other sibling
> + * events, which have the same flag. If any event with the flag is detached
> + * from the group, split the group into singleton events, and move the events
> + * with the flag to the unrecoverable ERROR state.
>   */
>  #define PERF_EV_CAP_SOFTWARE		BIT(0)
>  #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
> +#define PERF_EV_CAP_COEXIST		BIT(2)
>  
>  #define SWEVENT_HLIST_BITS		8
>  #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7c436d705fbd..e35d549a356d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2133,10 +2133,28 @@ static inline struct list_head *get_event_list(struct perf_event *event)
>  	return event->attr.pinned ? &ctx->pinned_active : &ctx->flexible_active;
>  }
>  
> +/*
> + * If the event has PERF_EV_CAP_COEXIST capability,
> + * schedule it out and move it into the ERROR state.
> + */
> +static inline void perf_remove_coexist_events(struct perf_event *event)
> +{
> +	struct perf_event_context *ctx = event->ctx;
> +	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
> +
> +	if (!(event->event_caps & PERF_EV_CAP_COEXIST))
> +		return;
> +
> +	event_sched_out(event, cpuctx, ctx);
> +	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> +}

Ah, so the problem here is that ERROR is actually recoverable using
IOC_ENABLE. We don't want that either. Let me try and figure out of EXIT
would work.
