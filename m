Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339AFC433EB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145E620658
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbgGVPZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbgGVPZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:25:28 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08FC4206F5;
        Wed, 22 Jul 2020 15:25:26 +0000 (UTC)
Date:   Wed, 22 Jul 2020 11:25:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        jbaron@akamai.com, mingo@redhat.com, kernel@axis.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dynamic debug: allow printing to trace event
Message-ID: <20200722112525.694880d3@oasis.local.home>
In-Reply-To: <87eep3zmg9.fsf@jogness.linutronix.de>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com>
 <20200721173045.540ae500@oasis.local.home>
 <87eep3zmg9.fsf@jogness.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 15:58:22 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> >> +static void dynamic_printk(unsigned int flags, const char *fmt, ...)
> >> +{
> >> +	if (flags & _DPRINTK_FLAGS_TRACE) {
> >> +		va_list args;
> >> +
> >> +		va_start(args, fmt);
> >> +		/*
> >> +		 * All callers include the KERN_DEBUG prefix to keep the
> >> +		 * vprintk case simple; strip it out for tracing.
> >> +		 */
> >> +		dynamic_trace(fmt + strlen(KERN_DEBUG), args);  
> 
> Do we really need a separate tracing event for this? Why not just:
> 
>                 ftrace_vprintk(fmt + strlen(KERN_DEBUG), args);

It must be an event, one that can be enabled or disabled separately
from trace_printk().

If you are asking if this could be something like trace_printk(), which
ftrace_vprintk() is. The reason for that nasty banner when people use
trace_printk() is to keep developers from using it as their personal
debugging tool in production.

A trace_printk() can not be discretely disabled. It's either totally
on, or totally off. And since it is used for debugging, if there's
trace_printk()s all over the kernel, you will have to deal with the
noise of everyone else's trace_printk(), making trace_printk() useless.

Thus, NAK on using ftrace_vprintk() here.

-- Steve
