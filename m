Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F30C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1099120746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEDTKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgEDTKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:10:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 447F8206C0;
        Mon,  4 May 2020 19:10:08 +0000 (UTC)
Date:   Mon, 4 May 2020 15:10:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joerg Roedel <jroedel@suse.de>
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
Subject: Re: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
 free_percpu()
Message-ID: <20200504151006.69d2a16c@gandalf.local.home>
In-Reply-To: <20200504183832.GL8135@suse.de>
References: <20200429082854.6e1796b5@oasis.local.home>
        <20200429100731.201312a9@gandalf.local.home>
        <20200430141120.GA8135@suse.de>
        <20200430121136.6d7aeb22@gandalf.local.home>
        <20200430191434.GC8135@suse.de>
        <20200430211308.74a994dc@oasis.local.home>
        <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
        <20200430223919.50861011@gandalf.local.home>
        <20200504151236.GI8135@suse.de>
        <20200504134042.178409c3@gandalf.local.home>
        <20200504183832.GL8135@suse.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 20:38:32 +0200
Joerg Roedel <jroedel@suse.de> wrote:

> Fair point, but this just shows how problematic it is to call something
> like vmalloc_sync_mappings() from a lower-level kernel API function.
> The obvious fix for this would be to make pgd_lock irq-safe, but this is
> getting more and more ridiculous.

Yeah, it's just getting more deeper into the rabbit hole.

> 
> I know you don't like to have a vmalloc_sync_mappings() call in the
> tracing code, but can you live with it until we get rid of this broken
> interface?

I'm fine with adding it to the tracing code (with that ridiculous
comment! ;-)

I'll even tag is as stable, but again, it's uncertain what commit that it
"fixes".

> 
> My plan for this is to use a small bitmap to track in the vmalloc and
> the (x86-)ioremap code at which levels of the page-tables the code made
> changes and combine that with an architecture-dependend mask to decide
> whether anything needs to be synced.
> 
> On x86-64 the sync would be necessary at most 64 times after boot, so I
> think this will only have a very small performance impact, even with
> VMAP_STACKS. And as a bonus it would also get rid of vmalloc faulting on
> x86, fixing the issue with tracing too.

Just because tracing get's a workaround, let's hopefully not get distracted
and forgot to add this. It looks like the best solution is to not need the
vmalloc_sync_mappings() call in the future. But, as we are about to release
trace-cmd with a feature that reliably triggers the bug, I can't wait for
the proper fix.

-- Steve
