Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E71C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD0B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgD2Qws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Qws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:52:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E08C3208FE;
        Wed, 29 Apr 2020 16:52:46 +0000 (UTC)
Date:   Wed, 29 Apr 2020 12:52:45 -0400
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
Message-ID: <20200429125245.5a804f62@gandalf.local.home>
In-Reply-To: <20200429162026.GT30814@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
        <20200429105941.GQ30814@suse.de>
        <20200429082854.6e1796b5@oasis.local.home>
        <20200429100731.201312a9@gandalf.local.home>
        <20200429161747.GS30814@suse.de>
        <20200429162026.GT30814@suse.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 18:20:26 +0200
Joerg Roedel <jroedel@suse.de> wrote:

> On Wed, Apr 29, 2020 at 06:17:47PM +0200, Joerg Roedel wrote:
> > On Wed, Apr 29, 2020 at 10:07:31AM -0400, Steven Rostedt wrote:  
> > > Talking with Mathieu about this on IRC, he pointed out that my code does
> > > have a vzalloc() that is called:
> > > 
> > > in trace_pid_write()
> > > 
> > > 	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
> > > 
> > > This is done when -P1,2 is on the trace-cmd command line.  
> > 
> > And that buffer is written to at any function entry?  
> 
> What I meant to say, is it possible that the page-fault handler does not
> complete because at its beginning it calls into trace-code and faults
> again on the same address?
> 

It should be read only at sched_switch.

Basically, it's a big bitmask, where each bit represents a possible process
id (can be 2 gigs if we allow all positive ints!).

Then, it is only written when setting it up. Bits 1 and 2 are set here
(-P1,2). At context switch, next->pid is checked against this bitmask, and
if it is set, it means we should allow this process to be traced.

This mask should only be accessed at sched_switch time, not at other times.
And it may read any possible page in that mask depending on the process id
of the next task to be scheduled in.

-- Steve
