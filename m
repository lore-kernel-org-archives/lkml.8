Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04815C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E159D20787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgEAKQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:16:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:39308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbgEAKQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:16:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F12ABAC91;
        Fri,  1 May 2020 10:16:10 +0000 (UTC)
Date:   Fri, 1 May 2020 12:16:08 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before text_poke()
Message-ID: <20200501101608.GE8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
 <20200429105941.GQ30814@suse.de>
 <20200429082854.6e1796b5@oasis.local.home>
 <20200429100731.201312a9@gandalf.local.home>
 <20200430141120.GA8135@suse.de>
 <20200430121136.6d7aeb22@gandalf.local.home>
 <20200430191434.GC8135@suse.de>
 <20200430211308.74a994dc@oasis.local.home>
 <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
 <20200430223919.50861011@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430223919.50861011@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:39:19PM -0400, Steven Rostedt wrote:
> I'll give the answer I gave to Joerg when he replied to my accidental
> private (not public) email:
> 
> Or even my original patch would be better than having the generic tracing
> code understanding the intrinsic properties of vmalloc() and
> alloc_percpu() on x86_64. I really don't think it is wise to have:
> 
> 	foo = alloc_percpu();
> 
> 	/*
> 	 * Because of some magic with the way alloc_percpu() works on
> 	 * x86_64, we need to synchronize the pgd of all the tables,
> 	 * otherwise the trace events that happen in x86_64 page fault
> 	 * handlers can't cope with accessing the chance that a
> 	 * alloc_percpu()'d memory might be touched in the page fault trace
> 	 * event. Oh, and we need to audit all alloc_percpu() and vmalloc()
> 	 * calls in tracing, because something might get triggered within a
> 	 * page fault trace event!
> 	 */
> 	vmalloc_sync_mappings();
> 
> That would be exactly what I add as a comment if it were to be added in the
> generic tracing code.
> 
> And we would need to audit any percpu alloc'd code in all tracing, or
> anything that might git hooked into something that hooks to the page fault
> trace point.
> 
> Since this worked for a decade without this, I'm strongly against adding it
> in the generic code due to some issues with a single architecture.

That is exactly the problem with vmalloc_sync_mappings()/unmappings().
It is not at all clear when it needs to be called and why, or even who
needs is responsible for calling it. The existing call-sites in Notifier
and ACPI code have no comment on why it is necessary to synchronize the
vmalloc mappings there.

It is only needed for x86, we could also get rid of it completely if:

	1) At x86-64 we pre-allocate all 64 P4D/PUD pages for the
	   vmalloc area in init_mm at boot time. This needs 256kb of
	   memory per system, most of it potentially unused as each
	   P4D/PUD maps 512GB of address space.

	2) At x86-32 we need to disable large pages for vmalloc/ioremap
	   mappings and pre-allocate the PTE pages for the vmalloc area
	   in init_mm. Depending on how much memory the system has and
	   the configured kernel/user split this might take more than 64
	   pages.

With that we could get rid of the vmalloc_sync interface and also the
vmalloc-fault code in general and reduce the complexity. This interface
has caused problems more than once. On the other side it would trade
memory usage against complexity.

Regards,

	Joerg
