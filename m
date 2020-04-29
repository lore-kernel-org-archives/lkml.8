Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8982EC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6342E208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgD2OHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgD2OHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:07:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 907E22082E;
        Wed, 29 Apr 2020 14:07:32 +0000 (UTC)
Date:   Wed, 29 Apr 2020 10:07:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
Message-ID: <20200429100731.201312a9@gandalf.local.home>
In-Reply-To: <20200429082854.6e1796b5@oasis.local.home>
References: <20200429054857.66e8e333@oasis.local.home>
        <20200429105941.GQ30814@suse.de>
        <20200429082854.6e1796b5@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 08:28:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 29 Apr 2020 12:59:41 +0200
> Joerg Roedel <jroedel@suse.de> wrote:
> 
> > >   use_temporary_mm() {
> > >     switch_mm_irqs_off() {
> > >       load_new_mm_cr3() {
> > >         write_cr3() <<--- Lock up!    
> > 
> > I don't see how it could lock up in write_cr3(), at least on bare-metal.
> > What is the environment this happens, 32 or 64 bit, in a VM or
> > bare-metal?  
> 
> 64 bit bare-metal. In fact, it wasn't reproducible on a VM (according
> to Tzvetomir, who was just using a Fedora kernel). I only tried it on
> bare-metal.
> 
> > 
> > I think it is more likely that your lockup is actually a page-fault
> > loop, where the #PF handler does not map the faulting address correctly.  
> 
> Sounds reasonable.
> 
> > 
> > But I have to look closer into how text_poke() works before I can say
> > more.
> > 
> > Btw, in case it happens on x86-64, does it also happen without
> > vmalloc-stacks?  
> 
> Just tried it out with !CONFIG_VMAP_STACKS and it still locks up :-/

Talking with Mathieu about this on IRC, he pointed out that my code does
have a vzalloc() that is called:

in trace_pid_write()

	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);

This is done when -P1,2 is on the trace-cmd command line.

-- Steve
