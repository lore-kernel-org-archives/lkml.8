Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E82C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F4F2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e3+2T5N+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633306AbgDNUme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729251AbgDNUmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:42:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958F5C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f6MlGhTrcfhE1matnY+gFa+jGAtYKA2T1KF8VNUMpDE=; b=e3+2T5N+0nfY8EtcHFc1NCkWQG
        FaeuviunEq6Wm0GkCubBuH66TIFCjGuHLfcqqEzA31UTQtFMnKL0IMjud4r7RsPGNlTTGlZO2GpG4
        KTnhLkSX/o5DC+G53S0e8WNc4ZeiNbYx64khP15zkcWFLOAExY7Rqcz8J1f3z4RK6vK0Jf8YVhgLt
        zuQPLCXMwyeDiX4kZG0FZzqXogloO2Uk8ZgibofNW5e4wFZ2KrTstwcJoE5WxgtvsswTmmj72JIgi
        UirhkeJ1Me/WQjy1XlUriJ27VDRV2KXfC2tbSuM7DjbTAUCEv50/ksza4Gie2K9Mxmtz2p9m/Ts7T
        QneatjUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOSNm-0001ZJ-Rr; Tue, 14 Apr 2020 20:42:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F899980FA9; Tue, 14 Apr 2020 22:42:08 +0200 (CEST)
Date:   Tue, 14 Apr 2020 22:42:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barret Rhoden <brho@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com
Subject: Re: perf: add cond_resched() to task_function_call()
Message-ID: <20200414204208.GI2483@worktop.programming.kicks-ass.net>
References: <20200414190351.16893-1-brho@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414190351.16893-1-brho@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 03:03:51PM -0400, Barret Rhoden wrote:
> Under rare circumstances, task_function_call() can repeatedly fail and
> cause a soft lockup.
> 
> There is a slight race where the process is no longer running on the cpu
> we targeted by the time remote_function() runs.  The code will simply
> try again.  If we are very unlucky, this will continue to fail, until a
> watchdog fires.  This can happen in a heavily loaded, multi-core virtual
> machine.

Sigh,.. virt again :/

> Reported-by: syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>  kernel/events/core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 55e44417f66d..65c2c05e24c2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -99,7 +99,7 @@ static void remote_function(void *data)
>   *
>   * returns: @func return value, or
>   *	    -ESRCH  - when the process isn't running
> - *	    -EAGAIN - when the process moved away
> + *	    -ENXIO  - when the cpu the process was on has gone offline
>   */

Hurm.. I don't think that was actually intended behaviour. As long as
the task lives we ought to retry. Luckily I don't think the current code
cares much, it'll loop again on the caller side.

With the exception of perf_cgroup_attach() that is, that might actually
be broken because of this.

>  static int
>  task_function_call(struct task_struct *p, remote_function_f func, void *info)
> @@ -112,11 +112,15 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
>  	};
>  	int ret;
>  
> -	do {
> -		ret = smp_call_function_single(task_cpu(p), remote_function, &data, 1);
> +	while (1) {
> +		ret = smp_call_function_single(task_cpu(p), remote_function,
> +					       &data, 1);
>  		if (!ret)
>  			ret = data.ret;
> -	} while (ret == -EAGAIN);
> +		if (ret != -EAGAIN)
> +			break;
> +		cond_resched();
> +	}

So how about we make that:

	for (;;) {
		ret = smp_call_function_single(task_cpu(p), remote_function, &data, 1);
		ret = !ret ? data.ret : -EAGAIN;

		if (ret != -EAGAIN)
			break;

		cond_resched();
	}

Or something like that, hmmm?
