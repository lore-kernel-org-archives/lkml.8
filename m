Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F043C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62AB2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UKrpwvRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgBSIQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:16:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46068 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgBSIQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fz8LT+4esfX6yBhrJ0QEH4biUnsulpI1jbUWNtcaXug=; b=UKrpwvRqPUrThLBLzWAaJMaHt1
        95+P+1Gfr0p2/Jddo4PzxuvJadJcvHwlgv6hewmQMjs7kziZ10dxHZH7pFSVfTtfvDx4AXy4egGY2
        0DKJb2W+kyzOAA7iRXrTbnAvW5vdBa2w/D9pszwZc2KAKBT4GiqvLjxzQN/UyTIgwcru4k7lAh1xe
        Na0pPEYKr5jv3jiY0JtqfKatTpulfvTdKnzrVIzGJ2RIy9E7svOGiURcM9aDVEslFmwpvdDGKl1iN
        a3pqJVFvA+/UGcHDTHBshNY8rtNQr1DnOMalyYBpm6CE0BKMyzEqpdL5SPhI02DL4oa5S7OQawfq4
        wxx7qAWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4KWG-0000lW-J5; Wed, 19 Feb 2020 08:15:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8045F30414E;
        Wed, 19 Feb 2020 09:13:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C732120206D9B; Wed, 19 Feb 2020 09:15:41 +0100 (CET)
Date:   Wed, 19 Feb 2020 09:15:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200219081541.GG14914@hirez.programming.kicks-ass.net>
References: <20200218173150.GK14449@zn.tnic>
 <CALCETrXbitwGKcEbCF84y0aEGz+B4LL_bj-_njgyXBJA74abOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXbitwGKcEbCF84y0aEGz+B4LL_bj-_njgyXBJA74abOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:15:57PM -0800, Andy Lutomirski wrote:
> On Tue, Feb 18, 2020 at 9:31 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > Ok,
> >
> > so Peter raised this question on IRC today, that the #MC handler needs
> > to disable all kinds of tracing/kprobing and etc exceptions happening
> > while handling an #MC. And I guess we can talk about supporting some
> > exceptions but #MC is usually nasty enough to not care about tracing
> > when former happens.
> >
> 
> It's worth noting that MCE is utterly, terminally screwed under high
> load.  In particular:
> 
> Step 1: NMI (due to perf).
> 
> immediately thereafter (before any of the entry asm runs)
> 
> Step 2: MCE (due to recoverable memory failure or remote CPU MCE)
> 
> Step 3: MCE does its thing and does IRET
> 
> Step 4: NMI
> 
> We are toast.
> 
> Tony, etc, can you ask your Intel contacts who care about this kind of
> thing to stop twiddling their thumbs and FIX IT?  The easy fix is
> utterly trivial.  Add a new instruction IRET_NON_NMI.  It does
> *exactly* the same thing as IRET except that it does not unmask NMIs.
> (It also doesn't unmask NMIs if it faults.)  No fancy design work.
> Future improvements can still happen on top of this.

Yes please! Of course, we're stuck with the existing NMI entry crap
forever because legacy, but it would make all things NMI so much saner.
