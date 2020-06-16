Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824CCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F14207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592334041;
	bh=gvebHjvAyLPJF/qhOC3nn20GbiVzxCamnFLA9V36sjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tF8xtRbjvA0/zR4m3RBcNiEotQc6eEBjoiMPy+kWXnRvXoxJ4PsA/YUMTrRrzT0E3
	 LzfezeuRChqRrpQiYKtYw3joTENf26OYMzvaTN9wiN4ZpVM5ytRY1tY6roJVmFU8tz
	 XxorDqql+FrDeMhX5WTEBFgf6cMR9dWLNR9zpVho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgFPTAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgFPTAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:00:39 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5168D20739;
        Tue, 16 Jun 2020 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592334038;
        bh=gvebHjvAyLPJF/qhOC3nn20GbiVzxCamnFLA9V36sjs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BXJGiOY3aQLiseFicR4MV0NApUp6pohwCYcX1GZuK1mIkB1xGoNxwcl+riHA68Ec0
         AjuxNIyHMBqrlFsynHI3k3vN2WyQY5A26O1LRvDnNpbf6RFnC3jQBleXzeD5+OlzkT
         3vxHIxoSwRpW9enlsQWN0JYSdv8ffP/mMykOorcc=
Date:   Tue, 16 Jun 2020 12:00:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 02/25] mm: Introduce mm_fault_accounting()
Message-Id: <20200616120037.e96d8d9b42e615f3b8da222f@linux-foundation.org>
In-Reply-To: <20200615231917.GA6307@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
        <20200615221607.7764-3-peterx@redhat.com>
        <CAHk-=wh3KYWKMPWYcyu9c-UPAwCXMcN86Wr5xyivCumWxEi7AQ@mail.gmail.com>
        <20200615231917.GA6307@xz-x1>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 19:19:17 -0400 Peter Xu <peterx@redhat.com> wrote:

> On Mon, Jun 15, 2020 at 03:32:40PM -0700, Linus Torvalds wrote:
> > On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Provide this helper for doing memory page fault accounting across archs.  It
> > > can be defined unconditionally because perf_sw_event() is always defined, and
> > > perf_sw_event() will be a no-op if !CONFIG_PERF_EVENTS.
> > 
> > Well, the downside is that now it forces a separate I$ miss and all
> > those extra arguments because it's a out-of-line function and the
> > compiler won't see that they all go away.
> > 
> > Yeah, maybe some day maybe we'll have LTO and these kinds of things
> > will not matter. And maybe they already don't. But it seems kind of
> > sad to basically force non-optimal code generation from this series.
> 
> I tried to make it static inline firstly in linux/mm.h, however it'll need to
> have linux/mm.h include linux/perf_event.h which seems to have created a loop
> dependency of headers.  I verified current code will at least generate inlined
> functions too for x86 (no mm_fault_accounting() in "objdump -t vmlinux") with
> gcc10.
> 
> Another alternative is to make it a macro, it's just that I feel the function
> definition is a bit cleaner.  Any further suggestions welcomed too.

Could create a new header file mm_fault.h which includes mm.h and
perf_event.h.  A later cleanup could move other fault-related things
into that header and add the appropriate inclusions into files which
use these things.

btw, I think mm_account_fault() might be a better name for this function.

And some (kerneldoc) documentation would be nice.  Although this
function is pretty self-evident.

> > 
> > Why would you export the symbol, btw? Page fault handling is never a module.
> 
> I followed handle_mm_fault() which is exported too, since potentially
> mm_fault_accounting() should always be called in the same context of
> handle_mm_fault().  Or do you prefer me to drop it?

Let's not add an unneeded export.  If someone for some reason needs it
later, it can be added then.

