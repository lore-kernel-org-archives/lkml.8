Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6FDC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9F62074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgD3OvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:51:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:59788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgD3OvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:51:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F409AC69;
        Thu, 30 Apr 2020 14:50:59 +0000 (UTC)
Date:   Thu, 30 Apr 2020 16:50:57 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before text_poke()
Message-ID: <20200430145057.GB8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
 <20200429105941.GQ30814@suse.de>
 <20200429082854.6e1796b5@oasis.local.home>
 <20200429100731.201312a9@gandalf.local.home>
 <20200430141120.GA8135@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430141120.GA8135@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:11:20PM +0200, Joerg Roedel wrote:
> The page-fault handler calls a tracing function which again ends up in
> trace_event_ignore_this_pid(), where it faults again. From here on the CPU is in
> a page-fault loop, which continues until the stack overflows (with
> CONFIG_VMAP_STACK).

Did some more testing to find out what this issue has to do with

	763802b53a42 x86/mm: split vmalloc_sync_all()

Above commit removes a call to vmalloc_sync_all() from the vmalloc
unmapping path, because that call caused severe performance regressions
on some workloads and was not needed on x86-64 anyway.

But that call caused vmalloc_sync_all() to be called regularily on
x86-64 machines, so that all page-tables were more likely to be in sync.

The call was introduced by commit

	3f8fd02b1bf1 mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()

to fix a correctness issue on x86-32 PAE systems, which also need
unmappings of large pages in the vmalloc area to be synchronized.

This additional call to vmalloc_sync_all() did hide the problem. I
verified it by reverting both of the above commits on v5.7-rc3 and
testing on that kernel. The problem is reproducible there too, the box
hangs hard.

So the underlying problem is that a vmalloc()'ed tracing buffer is used
to trace the page-fault handler, so that it has no chance of faulting in
the buffer address to poking_mm and maybe other PGDs.

The right fix is to call vmalloc_sync_mappings() right after allocating
tracing or perf buffers via v[zm]alloc().

Regards,

	Joerg
