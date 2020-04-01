Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3372C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A1C2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sq4xOi38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgDAKKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:10:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40828 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgDAKKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jriNWIfbT8+OQsM8ZDGM3sxAakgzl94o2gE7qP6sMJs=; b=sq4xOi38Z5EIfIDUDge1egWmKq
        TMYCq5u798c+Km34f8Us0Y1FyfMNDTathK5iXRaYGTSAZsvWDo2Ca5UAl2301kIGSugN4Eck736sT
        UAy22YubeANaELzSW9gjaEqmVCcBQg0T5+Zh5gFik5BjuLlJEi+GTwOG/70yr/EbHhbnLfSjJCHkE
        DaEctZxpc2TI9CQZQNYfjwZ8nuxBLndWSe7yne7ZcBAUagHpZESezS6Fy7oXwoWhkwtOepfXfoXcr
        iLFar9I7CYO2rw9qDhIWQJvrPXAXNo/V9C9HepT3OPMLmZrAewCS6sf/gyp+OWWBy+SF+BgR3qVre
        57BtLc3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJaJp-0000r9-Lj; Wed, 01 Apr 2020 10:09:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C8CD3060FD;
        Wed,  1 Apr 2020 12:09:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85D8729D6F68E; Wed,  1 Apr 2020 12:09:55 +0200 (CEST)
Date:   Wed, 1 Apr 2020 12:09:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 08/13] ftrace: Add perf text poke events for ftrace
 trampolines
Message-ID: <20200401100955.GY20713@hirez.programming.kicks-ass.net>
References: <20200304090633.420-1-adrian.hunter@intel.com>
 <20200304090633.420-9-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304090633.420-9-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:06:28AM +0200, Adrian Hunter wrote:
> Add perf text poke events for ftrace trampolines when created and when
> freed.

If I'm not mistaken that ends up like so:

static void ftrace_update_trampoline(struct ftrace_ops *ops)
{
+       unsigned long trampoline = ops->trampoline;
+
	arch_ftrace_update_trampoline(ops);
+       if (ops->trampoline && ops->trampoline != trampoline &&
> +	    (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP)) {
> +		/* Add to kallsyms before the perf events */
+               ftrace_add_trampoline_to_kallsyms(ops);
> +		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
> +				   ops->trampoline, ops->trampoline_size, false,
> +				   FTRACE_TRAMPOLINE_SYM);
> +		/*
> +		 * Record the perf text poke event after the ksymbol register
> +		 * event.
> +		 */
> +		perf_event_text_poke((void *)ops->trampoline, NULL, 0,
> +				     (void *)ops->trampoline,
> +				     ops->trampoline_size);
	}
}

And afaict, that is wrong.

The thing is; arch_ftrace_update_trampoline() can actually *update* an
existing trampoline, as per the name. Yes it also creates a trampoline
if there isn't one already, but if there already is one, it will modify
it in-place.

I see the appeal of having this event in generic code; but I'm thinking
you'll need the update even in arch code anyway, at which point it'd
probably be easier to do all of this in arch code.

