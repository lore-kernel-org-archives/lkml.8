Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DC4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F772078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHZTcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgHZTcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:32:06 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6CB92076C;
        Wed, 26 Aug 2020 19:32:04 +0000 (UTC)
Date:   Wed, 26 Aug 2020 15:32:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        jbaron@akamai.com, mingo@redhat.com,
        Nicolas Boichat <drinkcat@chromium.org>, kernel@axis.com,
        corbet@lwn.net, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dynamic debug: allow printing to trace event
Message-ID: <20200826153203.1a65c35d@oasis.local.home>
In-Reply-To: <651f7ec449dfb28006bbc0b018d4f6e506bcda80.camel@perches.com>
References: <20200825153338.17061-1-vincent.whitchurch@axis.com>
        <20200825153338.17061-3-vincent.whitchurch@axis.com>
        <651f7ec449dfb28006bbc0b018d4f6e506bcda80.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 08:53:25 -0700
Joe Perches <joe@perches.com> wrote:

> > The print buffer is statically allocated and managed using code borrowed
> > from __ftrace_trace_stack() and is limited to 256 bytes (four of these
> > are allocated per CPU to handle the various contexts); anything larger
> > will be truncated.  
> 
> There is an effort to avoid using trace_printk and the like
> so perhaps this feature should have the same compile time
> guard.

No, this is fine for being in a production kernel. Basically, these are
simply debug printk()s that can also be put into the trace buffer. The
key difference to trace_printk() is that they are an event that needs
to be enabled to write into the buffer.

The problem I'm avoiding with not letting people add trace_printk() is
that trace_printk() should be used when a developer is trying to debug
some code. The *only* trace_printk()s should be the ones that developer
adds (because it only shows what they want to find).

trace_printk()s are enabled by default, and they have a special
switch to disable. But it is an all or nothing switch. They either
enable all of them, or disable all of them. No in between.

Now if we allow trace_printk()s to be scattered through the kernel,
when someone wants to use trace_printk() for their own debugging, and
it is turned on, now the trace buffer is filled with a bunch of "noise"
from all these other trace_printk()s that are scattered around, and the
trace_printk()s that the poor developer added are lost among the sea of
other trace_printk()s, making their trace_printk()s useless.

That is the reason I try hard not letting trace_printk() enter into the
kernel.

-- Steve
