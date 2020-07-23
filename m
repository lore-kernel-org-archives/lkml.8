Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD255C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981C8207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t0bE2dT9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4M+ARpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgGWOCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:02:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgGWOCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:02:46 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595512964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gd/ucxZolDmpxhtFGJf0Gpvd8lew4aL+qNNCJx4SFco=;
        b=t0bE2dT9EJRN0sTAI0Zlg4Hkmb8V8v/1lLZpOTfdvsRj3i70sqyoyrW2u39JoERXvvQGv1
        qSxvz4lW03txJ/XgDiBLl7c9z6XQsBR04idz21ndei/+s7awQz4M7GKWZkK1f0sgbFYLLR
        UpBiPYa3pqG1mD/nrgYHThdIJDZXWIxg9hFceks79CvC3i17MJxaaqy/1YR2fs0h0u5m27
        K1o6sBGaoS5c3dyTT9iBmDO82s/j14tlcH7kjsP88hU+anrxovJOoiCA5n4hbteT3tkmo0
        TWGCIvnKuzZYrMtvAWIgrrJHnm9iI3WQw+joYibt6kPeA8rotPd9EhhE0YBEhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595512964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gd/ucxZolDmpxhtFGJf0Gpvd8lew4aL+qNNCJx4SFco=;
        b=f4M+ARpWIRJFgFZbldb5kttRxUwnCdjsn8/xKQMAOc/ykNhyxX2eCsP4QOteAc4wHy2SnM
        KEN8FtqBysrDCiBA==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        jbaron@akamai.com, mingo@redhat.com, kernel@axis.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dynamic debug: allow printing to trace event
In-Reply-To: <20200722112525.694880d3@oasis.local.home>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com> <20200721173045.540ae500@oasis.local.home> <87eep3zmg9.fsf@jogness.linutronix.de> <20200722112525.694880d3@oasis.local.home>
Date:   Thu, 23 Jul 2020 16:08:44 +0206
Message-ID: <87blk6cosb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-22, Steven Rostedt <rostedt@goodmis.org> wrote:
>>> +static void dynamic_printk(unsigned int flags, const char *fmt, ...)
>>> +{
>>> +	if (flags & _DPRINTK_FLAGS_TRACE) {
>>> +		va_list args;
>>> +
>>> +		va_start(args, fmt);
>>> +		/*
>>> +		 * All callers include the KERN_DEBUG prefix to keep the
>>> +		 * vprintk case simple; strip it out for tracing.
>>> +		 */
>>> +		dynamic_trace(fmt + strlen(KERN_DEBUG), args);  
>> 
>> Do we really need a separate tracing event for this? Why not just:
>> 
>>                 ftrace_vprintk(fmt + strlen(KERN_DEBUG), args);
>
> It must be an event, one that can be enabled or disabled separately
> from trace_printk().
>
> If you are asking if this could be something like trace_printk(),
> which ftrace_vprintk() is. The reason for that nasty banner when
> people use trace_printk() is to keep developers from using it as their
> personal debugging tool in production.
>
> A trace_printk() can not be discretely disabled. It's either totally
> on, or totally off. And since it is used for debugging, if there's
> trace_printk()s all over the kernel, you will have to deal with the
> noise of everyone else's trace_printk(), making trace_printk()
> useless.

I understand and agree with your concern about trace_printk(). But it
seems to me that trace_printk() via pr_debug() should be OK because
there is discrete control per message implemented. Yes, more code is
necessary to distinguish between the two, such as letting dynamic_printk
use an internal function that does not trigger a splat. But I think that
is reasonable.

For me a trace event represents a specific point in the kernel code. But
this new printk trace event, instead, represents general log
redirection. I do not oppose it, but it feels like a hack to me. In
contrast, simply setting a dynamic printk flag to write the message
string to the trace buffer (without also activating some pseudo trace
event) feels more natural.

Just sharing my thoughts, as requested.

John Ogness
