Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEE7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C6520705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ghx2r4PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgEDUZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgEDUZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:25:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF436C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QzyVcYGaTfWfjc7VbJBysUnAPUBFtQMrS3LJCoW4qx4=; b=Ghx2r4PAYhFnjL9dYaES0XeM2N
        XKvwjzcSLVO6rksH3dGoAxPT8DUJN8DpcpwJOPXZW1FDNcwnrdi53jyxcSgdeNeQTWN03JAYAfP35
        DabS1v0x1dgvMEdoczf0O372kT7GSWzg6wruFRHskFi6+UvzTsDBTsly50ZOwmo+sQTUIVcKHBLcT
        4K56jCGJOq8KKEyNE7Mo0x4QVlqKaQHWsYTJ4mxl7sWWQeAZYRO96SCS61WuZDNL2YRPQuLT+QaYt
        jJ58uqnEiCSCrUDmYPTeqSqNrif5FSt+fQKRfXq+wrj1j8KDYyynPnJw60mIgKXerI90gia9eomWi
        8SYFlNVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVhep-0007Fq-At; Mon, 04 May 2020 20:25:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 970D7305E45;
        Mon,  4 May 2020 22:25:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 817822B13518F; Mon,  4 May 2020 22:25:40 +0200 (CEST)
Date:   Mon, 4 May 2020 22:25:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
 free_percpu()
Message-ID: <20200504202540.GD5298@hirez.programming.kicks-ass.net>
References: <20200429105941.GQ30814@suse.de>
 <20200429082854.6e1796b5@oasis.local.home>
 <20200429100731.201312a9@gandalf.local.home>
 <20200430141120.GA8135@suse.de>
 <20200430121136.6d7aeb22@gandalf.local.home>
 <20200430191434.GC8135@suse.de>
 <20200430211308.74a994dc@oasis.local.home>
 <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
 <20200430223919.50861011@gandalf.local.home>
 <20200504151236.GI8135@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504151236.GI8135@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 05:12:36PM +0200, Joerg Roedel wrote:
> On Thu, Apr 30, 2020 at 10:39:19PM -0400, Steven Rostedt wrote:
> > What's so damn special about alloc_percpu()? It's definitely not a fast
> > path. And it's not used often.
> 
> Okay, I fixed it in the percpu code. It is definitly not a nice
> solution, but having to call vmalloc_sync_mappings/unmappings() is not a
> nice solution at any place in the code. Here is the patch which fixes
> this issue for me. I am also not sure what to put in the Fixes tag, as
> it is related to tracing code accessing per-cpu data from the page-fault
> handler, not sure when this got introduced. Maybe someone else can
> provide a meaningful Fixes- or stable tag.
> 
> I also have an idea in mind how to make this all more robust and get rid
> of the vmalloc_sync_mappings/unmappings() interface, will show more when
> I know it works the way I think it does.

I'm only following this with half an eye atm, but one solution is to
pull the vmalloc fault out of the trace path entirely.

With the current code that is 'interesting', but with the pile of
patches Thomas is sitting on that would be quite feasible.
