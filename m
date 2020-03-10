Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264B7C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19EE20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCJNlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgCJNlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:41:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF57205F4;
        Tue, 10 Mar 2020 13:41:00 +0000 (UTC)
Date:   Tue, 10 Mar 2020 09:40:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [patch part-II V2 09/13] x86/entry/common: Split hardirq
 tracing into lockdep and ftrace parts
Message-ID: <20200310094058.1239cf2f@gandalf.local.home>
In-Reply-To: <20200310112045.GD29372@zn.tnic>
References: <20200308222359.370649591@linutronix.de>
        <20200308222609.825111830@linutronix.de>
        <20200310112045.GD29372@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 12:20:45 +0100
Borislav Petkov <bp@alien8.de> wrote:

> > +
> > +	/*
> > +	 * Tell the tracer about the irq state as well before enabling
> > +	 * interrupts.
> > +	 */
> > +	__trace_hardirqs_off();  
> 
> I wonder if those "__" variants should be named something else to
> denote better the difference between __trace_hardirqs_{on,off} and
> trace_hardirqs_{on,off}. Latter does the _rcuidle variant and lockdep
> annotation but
> 
> 	trace_hardirqs_{on,off}_rcuidle_lockdep()
> 
> sounds yuck.
> 
> Maybe lockdep_trace_hardirqs_{on,off}()...
> 
> Blergh, I can't think of a good name ATM.

Kernel developers are not good at naming ;-) This is one of the original
pieces of code that came in with the original addition of tracing, where we
had the "Ingo notation" of something like:

  trace() {
	[..]
	_trace();
	[..]
  }

  _trace() {
	[..]
	__trace();
	[..]
  }

  __trace() {
	[..]
	___trace();
	[..]
  }

  ___trace() {
	[..]
	____trace();
	[..]
  }

  ____trace() {
	[..]
	_____trace();
	[..]
  }

  _____trace() {
	[..]
  }

-- Steve
