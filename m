Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F4AC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF8B21973
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hofz04tB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgD2PpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgD2PpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:45:13 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2F8C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n4SiF6VzKpSikyxuEjK2tPE8HtYTsR9Hpkf9W1SwGK4=; b=Hofz04tBzULPDF6kymNT5agJJD
        AcLgCygy6kHRSAj1yIiXaRlusRHFvZN3QxcNO11oWAX1Saxo6asRdJ5suGan4TEkwDjYZ1gO8keeH
        E+R4e4ailrcVZ7wUhKJ/DO0lLwXNhaXpUMQB1i+cRZ1cf5us3ptQGxY5dHkrdqGVskbqigrUmdzEi
        kDk0ejMMJaphvwTHhUYb9v11gOt4azgRqkdyzvr1h1W+O4ohRBhy/enot050JZiCUELlhMF+pG0yH
        uAFNdo07ASL3QAbn7T/0sLVPIxcxucT4LyBr9o68/Ns7Nql8KkGf7mTTTNG6S5cfHMM1ir7aQTkNP
        6qXdvvqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTosr-0002JC-CU; Wed, 29 Apr 2020 15:44:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B8283011E8;
        Wed, 29 Apr 2020 17:44:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14BA720BD9729; Wed, 29 Apr 2020 17:44:23 +0200 (CEST)
Date:   Wed, 29 Apr 2020 17:44:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before text_poke()
Message-ID: <20200429154423.GM13592@hirez.programming.kicks-ass.net>
References: <20200429054857.66e8e333@oasis.local.home>
 <20200429105941.GQ30814@suse.de>
 <20200429082854.6e1796b5@oasis.local.home>
 <20200429100731.201312a9@gandalf.local.home>
 <20200429141004.GR30814@suse.de>
 <20200429103216.34b6f7aa@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429103216.34b6f7aa@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:32:16AM -0400, Steven Rostedt wrote:
> On Wed, 29 Apr 2020 16:10:04 +0200
> Joerg Roedel <jroedel@suse.de> wrote:
> 
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
> > Yeah, I was guessing something like this, init_mm has a mapping which
> > poking_mm has not. I currently try to reproduce this on one of my
> > machines.
> 
> Note, in use_temporary_mm(poking_mm), poking_mm only contains the page that

poking_mm should contain the full kernel map, the userspace part is 2
pages in a random location to alias two kernel pages.

So a vmalloc fault _should_ work.

> needs to be updated. But will get added to per_cpu(cpu_tlbstate.loaded_mm),
> which appears to be the one that's not updated.
> 
> -- Steve
