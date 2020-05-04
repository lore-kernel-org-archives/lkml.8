Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB969C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE4F206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgEDREz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbgEDREz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:04:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD1D206C0;
        Mon,  4 May 2020 17:04:53 +0000 (UTC)
Date:   Mon, 4 May 2020 13:04:51 -0400
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
Subject: Re: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
 free_percpu()
Message-ID: <20200504130451.7aef72b1@gandalf.local.home>
In-Reply-To: <1533922227.82188.1588606723786.JavaMail.zimbra@efficios.com>
References: <20200429054857.66e8e333@oasis.local.home>
        <20200430191434.GC8135@suse.de>
        <20200430211308.74a994dc@oasis.local.home>
        <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
        <20200430223919.50861011@gandalf.local.home>
        <20200504151236.GI8135@suse.de>
        <99290786.82178.1588606126392.JavaMail.zimbra@efficios.com>
        <20200504153135.GJ8135@suse.de>
        <1533922227.82188.1588606723786.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 11:38:43 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On May 4, 2020, at 11:31 AM, Joerg Roedel jroedel@suse.de wrote:
> 
> > On Mon, May 04, 2020 at 11:28:46AM -0400, Mathieu Desnoyers wrote:  
> >> ----- On May 4, 2020, at 11:12 AM, Joerg Roedel jroedel@suse.de wrote:
> >> Placing this here is inefficient. It syncs mappings for each percpu allocation.
> >> I would recommend moving it right after __vmalloc() is called to allocate the
> >> underlying memory chunk instead:
> >> 
> >> static void *pcpu_mem_zalloc(size_t size, gfp_t gfp)
> >> {  
> > 
> > Tried this before, actually I put it into the caller of
> > pcpu_mem_zalloc(), but that didn't fix the problem for me. Stevens
> > test-case still hangs the machine.  
> 
> That's unexpected.
> 
> Did you confirm that those hangs were also caused by percpu allocations ?
> 
> Maybe adding the vmalloc_sync_mappings() at each percpu allocation happens
> to luckily sync mappings after some other vmalloc.
> 

It doesn't surprise me because my alloc_percpu() call never gets to that
path. But systemd does hit it for me earlier on.

-- Steve
