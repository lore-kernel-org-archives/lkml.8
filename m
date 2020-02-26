Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3432AC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBE224670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBZU7V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:59:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgBZU7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:59:21 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D627724656;
        Wed, 26 Feb 2020 20:59:19 +0000 (UTC)
Date:   Wed, 26 Feb 2020 15:59:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 02/10] x86/mce: Disable tracing and kprobes on
 do_machine_check()
Message-ID: <20200226155918.125e0ad8@gandalf.local.home>
In-Reply-To: <F7C318D0-D9B8-4984-AE84-2E903837EED5@amacapital.net>
References: <20200226185945.GC18400@hirez.programming.kicks-ass.net>
        <F7C318D0-D9B8-4984-AE84-2E903837EED5@amacapital.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 11:09:03 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> > On Feb 26, 2020, at 10:59 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > ﻿On Wed, Feb 26, 2020 at 07:42:37PM +0100, Borislav Petkov wrote:  
> >> On Wed, Feb 26, 2020 at 09:28:51AM -0800, Andy Lutomirski wrote:  
> >>>> It entirely depends on what the goal is :-/ On the one hand I see why
> >>>> people might want function tracing / kprobes enabled, OTOH it's all
> >>>> mighty frigging scary. Any tracing/probing/whatever on an MCE has the
> >>>> potential to make a bad situation worse -- not unlike the same on #DF.  
> >> 
> >> FWIW, I had this at the beginning of the #MC handler in a feeble attempt
> >> to poke at this:
> >> 
> >> +       hw_breakpoint_disable();
> >> +       static_key_disable(&__tracepoint_read_msr.key);
> >> +       tracing_off();  
> > 
> > You can't do static_key_disable() from an IST  
> 
> Can we set a percpu variable saying “in some stupid context, don’t trace”?

Matter's what kind of tracing you care about? "tracing_off()" only stops
writing to the ring buffer, but all the mechanisms are still in place (the
things you want to stop).

And "tracing" is not the issue. The issue is usually the breakpoint that is
added to modify the jump labels to enable tracing, or a flag that has a
trace event do a user space stack dump. It's not tracing you want to stop,
its the other parts that are attached to tracing that makes it dangerous.

-- Steve
