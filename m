Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686AAC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B22D206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgGWP0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgGWP0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:26:47 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7678A206D8;
        Thu, 23 Jul 2020 15:26:46 +0000 (UTC)
Date:   Thu, 23 Jul 2020 11:26:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "mingo@redhat.com" <mingo@redhat.com>, kernel <kernel@axis.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dynamic debug: allow printing to trace event
Message-ID: <20200723112644.7759f82f@oasis.local.home>
In-Reply-To: <20200723105735.mqfkfbljjda7qz7n@axis.com>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com>
        <20200721173045.540ae500@oasis.local.home>
        <87eep3zmg9.fsf@jogness.linutronix.de>
        <20200722144952.2mewrgebgkyr2zyf@axis.com>
        <20200722112823.3ba72d31@oasis.local.home>
        <20200723105735.mqfkfbljjda7qz7n@axis.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 12:57:35 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> Would it be acceptable to just use a fixed size for the event?  At least
> for my own debugging use cases it's preferable to just have to increase
> the trace buffer size in case it's insufficient, rather than to have to
> restort to one-off debugging code.

There's two other options.

Option 1, is to allocate 256 bytes times 4 (in case of interruption,
where you have a separate buffer for every context - normal, softirq,
irq, nmi), and use it like I do for stack traces in the latest kernel
(see __ftrace_stack_trace() in kernel/trace/trace.c)

Option 2, would be to use trace_array_vprintk(), but you need to create
your own instance to do so to keep from messing with the top level buffer.

-- Steve


