Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294EDC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06473207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgBQV5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbgBQV5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 16:57:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E3232064C;
        Mon, 17 Feb 2020 21:57:16 +0000 (UTC)
Date:   Mon, 17 Feb 2020 16:57:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jann Horn <jannh@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Message-ID: <20200217165714.1080cfd2@gandalf.local.home>
In-Reply-To: <CAG48ez0owFet0E43UAGd7sV9Oi0yhVpWTmy4W+Vm5+0q=74-DA@mail.gmail.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
        <20190110203023.GL2861@worktop.programming.kicks-ass.net>
        <20190110205226.iburt6mrddsxnjpk@treble>
        <CAG48ez0owFet0E43UAGd7sV9Oi0yhVpWTmy4W+Vm5+0q=74-DA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 22:10:27 +0100
Jann Horn <jannh@google.com> wrote:

> On Thu, Jan 10, 2019 at 9:52 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Thu, Jan 10, 2019 at 09:30:23PM +0100, Peter Zijlstra wrote:  
> > > On Wed, Jan 09, 2019 at 04:59:35PM -0600, Josh Poimboeuf wrote:  
> > > > With this version, I stopped trying to use text_poke_bp(), and instead
> > > > went with a different approach: if the call site destination doesn't
> > > > cross a cacheline boundary, just do an atomic write.  Otherwise, keep
> > > > using the trampoline indefinitely.  
> > >  
> > > > - Get rid of the use of text_poke_bp(), in favor of atomic writes.
> > > >   Out-of-line calls will be promoted to inline only if the call sites
> > > >   don't cross cache line boundaries. [Linus/Andy]  
> > >
> > > Can we perserve why text_poke_bp() didn't work? I seem to have forgotten
> > > again. The problem was poking the return address onto the stack from the
> > > int3 handler, or something along those lines?  
> >
> > Right, emulating a call instruction from the #BP handler is ugly,
> > because you have to somehow grow the stack to make room for the return
> > address.  Personally I liked the idea of shifting the iret frame by 16
> > bytes in the #DB entry code, but others hated it.
> >
> > So many bad-but-not-completely-unacceptable options to choose from.  
> 
> Silly suggestion from someone who has skimmed the thread:
> 
> Wouldn't a retpoline-style trampoline solve this without needing
> memory allocations? Let the interrupt handler stash the destination in
> a percpu variable and clear IF in regs->flags. Something like:

Linus actually suggested something similar, but for ftrace, but after
implementing it, it was hard to get right, and caused havoc with
utilities like lockdep, and also shadow stacks.

See this thread:

  https://lore.kernel.org/linux-kselftest/CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com/


 -- Steve
