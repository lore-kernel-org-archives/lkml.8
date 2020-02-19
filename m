Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E14EC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAFF24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBSOVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgBSOVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:21:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03B6206ED;
        Wed, 19 Feb 2020 14:21:16 +0000 (UTC)
Date:   Wed, 19 Feb 2020 09:21:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200219092115.3b3cccd9@gandalf.local.home>
In-Reply-To: <20200219081541.GG14914@hirez.programming.kicks-ass.net>
References: <20200218173150.GK14449@zn.tnic>
        <CALCETrXbitwGKcEbCF84y0aEGz+B4LL_bj-_njgyXBJA74abOA@mail.gmail.com>
        <20200219081541.GG14914@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 09:15:41 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > 
> > Tony, etc, can you ask your Intel contacts who care about this kind of
> > thing to stop twiddling their thumbs and FIX IT?  The easy fix is
> > utterly trivial.  Add a new instruction IRET_NON_NMI.  It does
> > *exactly* the same thing as IRET except that it does not unmask NMIs.
> > (It also doesn't unmask NMIs if it faults.)  No fancy design work.
> > Future improvements can still happen on top of this.  
> 
> Yes please! Of course, we're stuck with the existing NMI entry crap
> forever because legacy, but it would make all things NMI so much saner.

What would be nice is to have a NMI_IRET, that is defined as something
that wont break legacy CPUs. Where it could be just a nop iret, or maybe
if possible a "lock iret"? That is, not have a IRET_NON_NMI, as that
would be all over the place, but just the iret for NMI itself. As
that's in one place.

-- Steve
