Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B72C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E168206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gEO+LzPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgDUNp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728479AbgDUNp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:45:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91428C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=POGJrVExxdA9MDb+BsugRMcKuT3plb5RMj3ABn2kSS8=; b=gEO+LzPdLUvdOHmKBlj8KfN50A
        Pxb3lkIE8zJ+TpVUaicWJ3uP1oAHyX6KCXQMP02xPnDA8IerjRA+LmghJ0quGgvpk7RvbrnQLlSim
        elVn1tRSPuoThlGIabLS3TL9ODOxW4B+7LKsCWIgRMRTnIMWLhaWgKemnb8v0ENgHuaZJWciCQCpI
        J4I/c2zL7tURBsQtO7uCL0tINVjr0ZvJOd3e+HVUYh+sSIhSA8dIHPRtrG9w0OStzewic5A7bjj/+
        wcm7vI5sH0nTxMfyvQ5ol/6xR0gmmBL75CihovmgKzSnLEKGYSFZRaIKws0kSRPhLC/O8f4BShcD9
        SFgdh1sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQtD1-0008CM-Ja; Tue, 21 Apr 2020 13:45:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD274306AF8;
        Tue, 21 Apr 2020 15:45:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 900F42BAC7929; Tue, 21 Apr 2020 15:45:04 +0200 (CEST)
Date:   Tue, 21 Apr 2020 15:45:04 +0200
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
Subject: Re: [PATCH V6 08/15] ftrace: Add perf text poke events for ftrace
 trampolines
Message-ID: <20200421134504.GQ20730@hirez.programming.kicks-ass.net>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
 <20200405201327.7332-9-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405201327.7332-9-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 11:13:20PM +0300, Adrian Hunter wrote:
> Add perf text poke events for ftrace trampolines when created and when
> freed.

Maybe also put in a little more detail on the various events. Because
arch_ftrace_update_trampoline() can also generate text_poke_bp() events,
to update an existing trampoline.

A diagram, like with the kprobes thing perhaps.

> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  kernel/trace/ftrace.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 398d58b8ffa5..3318f7eca76c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2792,6 +2792,13 @@ static void ftrace_trampoline_free(struct ftrace_ops *ops)
>  {
>  	if (ops && (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP) &&
>  	    ops->trampoline) {
> +		/*
> +		 * Record the text poke event before the ksymbol unregister
> +		 * event.
> +		 */
> +		perf_event_text_poke((void *)ops->trampoline,
> +				     (void *)ops->trampoline,
> +				     ops->trampoline_size, NULL, 0);
>  		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
>  				   ops->trampoline, ops->trampoline_size,
>  				   true, FTRACE_TRAMPOLINE_SYM);
> @@ -6816,6 +6823,13 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
>  		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
>  				   ops->trampoline, ops->trampoline_size, false,
>  				   FTRACE_TRAMPOLINE_SYM);
> +		/*
> +		 * Record the perf text poke event after the ksymbol register
> +		 * event.
> +		 */
> +		perf_event_text_poke((void *)ops->trampoline, NULL, 0,
> +				     (void *)ops->trampoline,
> +				     ops->trampoline_size);
>  	}
>  }
>  
> -- 
> 2.17.1
> 
