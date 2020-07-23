Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833CAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66BF720737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgGWPja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgGWPj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:39:29 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA748206D8;
        Thu, 23 Jul 2020 15:39:28 +0000 (UTC)
Date:   Thu, 23 Jul 2020 11:39:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        jbaron@akamai.com, mingo@redhat.com, kernel@axis.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dynamic debug: allow printing to trace event
Message-ID: <20200723113927.581af808@oasis.local.home>
In-Reply-To: <87blk6cosb.fsf@jogness.linutronix.de>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com>
        <20200721173045.540ae500@oasis.local.home>
        <87eep3zmg9.fsf@jogness.linutronix.de>
        <20200722112525.694880d3@oasis.local.home>
        <87blk6cosb.fsf@jogness.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 16:08:44 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> For me a trace event represents a specific point in the kernel code. But
> this new printk trace event, instead, represents general log
> redirection. I do not oppose it, but it feels like a hack to me. In
> contrast, simply setting a dynamic printk flag to write the message
> string to the trace buffer (without also activating some pseudo trace
> event) feels more natural.

I agree with your sentiment. But my experience with the kernel is, if
you create an API for one subsystem, other subsystems are destined to
(ab)use it.

Now, trace_array_vprintk() is available too, which acts just like
trace_printk(), but requires creating a separate trace buffer to write
to. I'm fine with this because it wont cause noise in the top level
buffer.


> 
> Just sharing my thoughts, as requested.

Appreciated ;-)

-- Steve
