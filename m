Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3537DC28CBC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 02:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9082073E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 02:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgEACjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 22:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgEACjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 22:39:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A57B2071C;
        Fri,  1 May 2020 02:39:20 +0000 (UTC)
Date:   Thu, 30 Apr 2020 22:39:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
Message-ID: <20200430223919.50861011@gandalf.local.home>
In-Reply-To: <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
References: <20200429054857.66e8e333@oasis.local.home>
        <20200429105941.GQ30814@suse.de>
        <20200429082854.6e1796b5@oasis.local.home>
        <20200429100731.201312a9@gandalf.local.home>
        <20200430141120.GA8135@suse.de>
        <20200430121136.6d7aeb22@gandalf.local.home>
        <20200430191434.GC8135@suse.de>
        <20200430211308.74a994dc@oasis.local.home>
        <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 22:26:55 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Apr 30, 2020, at 9:13 PM, rostedt rostedt@goodmis.org wrote:
> 
> > [ Joerg, sending again this time not just to you. (hit reply to sender
> >  and not reply to all). Feel free to resend what you wrote before to this ]
> > 
> > On Thu, 30 Apr 2020 21:14:34 +0200
> > Joerg Roedel <jroedel@suse.de> wrote:
> >   
> >> And alloc_percpu() calls down into pcpu_alloc(), which allocates new
> >> percpu chunks using vmalloc() on x86. And there we are again in the
> >> vmalloc area.  
> > 
> > So after a vmalloc() is made, should the page tables be synced?  
> 
> Why should it ? Usually, the page fault handler is able to resolve the
> resulting minor page faults lazily.
> 
> > 
> > This is a rather subtle bug, and I don't think it should be the caller of
> > percpu_alloc() that needs to call vmalloc_sync_mappings().  
> 
> Who said tracing was easy ? ;-)

But anyone can hook to a tracepoint, and then if they hook to one that is
in the page fault handler, and they use vmalloc, they can lock up the
machine.

> 
> > What's your suggestion for a fix?  
> 
> I know the question is not addressed to me, but here are my 2 cents:
> 
> It's subtle because ftrace is tracing the page fault handler through
> tracepoints. It would not make sense to slow down all vmalloc or
> percpu_alloc() just because tracing recurses when tracing page faults.

What's so damn special about alloc_percpu()? It's definitely not a fast
path. And it's not used often.

> 
> I think the right approach to solve this is to call vmalloc_sync_mappings()
> before any vmalloc'd memory ends up being observable by instrumentation.
> This can be achieved by adding a vmalloc_sync_mappings call on tracepoint
> registration like I proposed in my patchset a few week ago:
> 
> https://lore.kernel.org/r/20200409193543.18115-2-mathieu.desnoyers@efficios.com
> 
> The tracers just have to make sure they perform their vmalloc'd memory
> allocation before registering the tracepoint which can touch it, else they
> need to issue vmalloc_sync_mappings() on their own before making the
> newly allocated memory observable by instrumentation.
> 
> This approach is not new: register_die_notifier() does exactly that today.
> 

I'll give the answer I gave to Joerg when he replied to my accidental
private (not public) email:

Or even my original patch would be better than having the generic tracing
code understanding the intrinsic properties of vmalloc() and
alloc_percpu() on x86_64. I really don't think it is wise to have:

	foo = alloc_percpu();

	/*
	 * Because of some magic with the way alloc_percpu() works on
	 * x86_64, we need to synchronize the pgd of all the tables,
	 * otherwise the trace events that happen in x86_64 page fault
	 * handlers can't cope with accessing the chance that a
	 * alloc_percpu()'d memory might be touched in the page fault trace
	 * event. Oh, and we need to audit all alloc_percpu() and vmalloc()
	 * calls in tracing, because something might get triggered within a
	 * page fault trace event!
	 */
	vmalloc_sync_mappings();

That would be exactly what I add as a comment if it were to be added in the
generic tracing code.

And we would need to audit any percpu alloc'd code in all tracing, or
anything that might git hooked into something that hooks to the page fault
trace point.

Since this worked for a decade without this, I'm strongly against adding it
in the generic code due to some issues with a single architecture.

-- Steve

