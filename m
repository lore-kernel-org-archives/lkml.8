Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8811AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB46206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qzu6ZnEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgFRVS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgFRVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:18:54 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64445C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3Dm+I7D9RKyOIbZMbxKT9Wei/FsX5NRFTyP+KZIpNwQ=; b=Qzu6ZnEKBiWgEIfK+WIx8Lo5iX
        3eQkHOWnSdk9+aR9EuORGqSVeulvhp9SqjW+wKva3uYjkcOd9Vvx2hSk+nFuVyRqOrogRrRg7YjIF
        EkuzLFy3Zo0OChAa8/NdjX8J2L/xo+yt16pqoyv0vLRQ7HhQ7XYqPx/j8R/Nhabe7CLs6jgFmdFEu
        XMQO9vQ4SGfLIAltmibs7Am1fnBtAlvGCzD2vTtrPLdPsCI/pBFcqiUr6wl2pFJ8tQuNUDTULi1O7
        kG9QM/NF7qrOox9uqBx7Pjrjb7pRve+FAJLqkVHSzh78uiCvb74kXE96FwyTO4gpegxsDsMs4nNKH
        ++5pbt4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jm1vV-0008ME-La; Thu, 18 Jun 2020 21:18:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 479D53017B7;
        Thu, 18 Jun 2020 23:18:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A3D7201F7DB7; Thu, 18 Jun 2020 23:18:23 +0200 (CEST)
Date:   Thu, 18 Jun 2020 23:18:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>, jthierry@redhat.com,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 1/7] x86/entry: Fix #UD vs WARN more
Message-ID: <20200618211823.GP576905@hirez.programming.kicks-ass.net>
References: <20200618190207.GO576905@hirez.programming.kicks-ass.net>
 <257B4193-08FB-4B3E-85E9-6C512B52C2C2@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <257B4193-08FB-4B3E-85E9-6C512B52C2C2@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 12:29:50PM -0700, Andy Lutomirski wrote:
> 
> > On Jun 18, 2020, at 12:02 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > ﻿On Thu, Jun 18, 2020 at 11:36:53AM -0700, Andy Lutomirski wrote:
> > 
> >> I wasn't imagining going far down the rabbit hole at all -- I think
> >> that, at most, we should cover the path for when the fault wasn't a
> >> BUG/WARN in the first place.  I admit that, for #UD in particular,
> >> this isn't a big deal, but if it were a different vector, this could
> >> matter.
> > 
> > Right, so there's 3 cases for ud2:
> > 
> > - WARN;  ud2,  bug_entry, recovers
> > - BUG;   ud2,  bug_entry, dies
> > - UBSAN; ud2, !bug_entry, dies
> 
> 4. The #UD matches an extable entry. I don’t know whether this ever happens for real.

#UD yes, ud2 instruction, not so much.

> The failure is still a bit farfetched: we’d need an extable to hit in
> an inconsistent state where we blow up due to a lack of entry
> handling.

Right, by noinstr checking the instruction is actually ud2 I think we
mostly good. There really aren't that many places that emit ud2.

> But I think you might need some IRQ fiddling. With your patch, a WARN
> with IRQs on will execute the printk code with IRQs off without
> lockstep handling, and an appropriately configured debugging kernel
> may get a recursive splat.  Or if irq tracing somehow notices that
> IRQs got turned off, the warning recovery might return back to an IF=1
> context with IRQs traced as off.
> 
> So maybe also do an untraced cond_local_irq_enable()?  After all, if
> we’re trying to report a bug from IRQs on, it should be okay to have
> IRQs on while reporting it. It might even work better than having IRQs
> off.

Yes, very good point. Now I want to go look at the old code... I'll frob
something tomorrow, brain is pretty fried by now.
