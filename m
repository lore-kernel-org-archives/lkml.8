Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C7CC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394C320728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3duxFG2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgAQJNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:13:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47368 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgAQJNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=04DhqFKBcPWMrjsGDMVscjHECILU0b/xk1pMLiwRSqQ=; b=3duxFG2MBnvrY7lYp0yOqTlER
        AHTjr7dEWwXAYhjrZQPx5vXU6y8ioLUM3qzTPORZTiIc9Wy8i1SdJERpEaKhRfwervP5bk6y1DzNW
        w7Xux07QOwMuiPtbfho8jfkXH4dmK3vJo5p4D+WPagYHscnQ4oyPpIK3V7vihXeEraVKbO+4r+fax
        qkxm8wxx134ky53hZIyu6oDGLo7vykXr93sz1N1c9q9/lG8m4Lks+nR849MvVzB3RXj6B21y1kYbI
        yScQYr1xgWperFt+q34agHdlYfRB5SiVnqDIZ06zwiXAsCYsUyBmQntipUwnxAP+FA5T5VMxszBFj
        hBCrv+CMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isNhH-0004ZH-Gh; Fri, 17 Jan 2020 09:13:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9321B304A59;
        Fri, 17 Jan 2020 10:12:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B43F020AFB27D; Fri, 17 Jan 2020 10:13:41 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:13:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3] perf/x86: Consider pinned events for group
 validation
Message-ID: <20200117091341.GX2827@hirez.programming.kicks-ass.net>
References: <1579201225-178031-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579201225-178031-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:00:25AM -0800, kan.liang@linux.intel.com wrote:
> @@ -2054,9 +2057,38 @@ static int validate_group(struct perf_event *event)
>  	if (n < 0)
>  		goto out;
>  
> +	/*
> +	 * Disable interrupts and preemption to prevent the events in this
> +	 * CPU's cpuc going away and getting freed.
> +	 */
> +	local_irq_save(flags);
> +
> +	/*
> +	 * The new group must can be scheduled together with current pinned
> +	 * events. Otherwise, it will never get a chance to be scheduled later.
> +	 *
> +	 * It won't catch all possible cases that cannot schedule, such as
> +	 * events pinned on CPU1, but the validation for a new CPU1 event
> +	 * running on other CPU. However, it's good enough to handle common
> +	 * cases like the global NMI watchdog.
> +	 */
> +	for (i = 0; i < cpuc->n_events; i++) {
> +		pinned_event = cpuc->event_list[i];
> +		if (WARN_ON_ONCE(!pinned_event))
> +			continue;
> +		if (!pinned_event->attr.pinned)
> +			continue;
> +		fake_cpuc->n_events = n;
> +		n = collect_events(fake_cpuc, pinned_event, false);
> +		if (n < 0)
> +			goto irq;
> +	}
> +

So I still completely hate this, because it makes the counter scheduling
more eratic.

It changes a situation where we only have false-positives (we allow
scheduling a group that might not ever get to run) into a situation
where we can have both false-positives and false-negatives.

Imagine the pinned event is for a currently running task; and that task
only runs sporadically. Then you can sometimes not create the group, but
mostly it'll work.

Yes, this is all very annoying, but I really don't see how this makes
anything any better.
