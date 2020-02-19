Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BFCC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F74208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1YTSyvj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBSPF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:05:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50850 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSPF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CmpNQkTd3vKnTq7/TH/RtMx5e3zbH2m4y+mEOQjw6BA=; b=1YTSyvj8g/pdWWys4wIaEv5bRJ
        qJyFJIjYB4oK5I7Iy0dp2rthMCM03ED3LLgk6XlGpU5goYtIqBYawszo4VXN+zS/vHonBsS9RjbZl
        9rgiiswz71jqImDv0ysKRU1jeYLEA/NDfJcjym7gT3//6hiskVsHQZarFROJQD1jmOGTZ16p+EwnT
        mJ+CZwF6A4sO3s3kZRli9MhFHjLNsKJDZBjtlzB9vNXmXrc6HK66RGK+DA3IrpAZuIUF4uYTMy8zj
        TtvL2T9s+da9RUlqLsEVQv6hJmk5qCJ4YIJ/bsEuaLy+3+GoDSLy8iLbTp6QqaG2j9JHvm4zykXEq
        p4CKmuAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4QuU-0007V7-IS; Wed, 19 Feb 2020 15:05:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D9A1300565;
        Wed, 19 Feb 2020 16:03:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58B032871C337; Wed, 19 Feb 2020 16:05:07 +0100 (CET)
Date:   Wed, 19 Feb 2020 16:05:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200219150507.GD18400@hirez.programming.kicks-ass.net>
References: <20200218173150.GK14449@zn.tnic>
 <CALCETrXbitwGKcEbCF84y0aEGz+B4LL_bj-_njgyXBJA74abOA@mail.gmail.com>
 <20200219081541.GG14914@hirez.programming.kicks-ass.net>
 <20200219092115.3b3cccd9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219092115.3b3cccd9@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:21:15AM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2020 09:15:41 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > 
> > > Tony, etc, can you ask your Intel contacts who care about this kind of
> > > thing to stop twiddling their thumbs and FIX IT?  The easy fix is
> > > utterly trivial.  Add a new instruction IRET_NON_NMI.  It does
> > > *exactly* the same thing as IRET except that it does not unmask NMIs.
> > > (It also doesn't unmask NMIs if it faults.)  No fancy design work.
> > > Future improvements can still happen on top of this.  
> > 
> > Yes please! Of course, we're stuck with the existing NMI entry crap
> > forever because legacy, but it would make all things NMI so much saner.
> 
> What would be nice is to have a NMI_IRET, that is defined as something
> that wont break legacy CPUs. Where it could be just a nop iret, or maybe
> if possible a "lock iret"? That is, not have a IRET_NON_NMI, as that
> would be all over the place, but just the iret for NMI itself. As
> that's in one place.

I don't think that matters much; alternatives should be able to deal
with all that either which way around.
