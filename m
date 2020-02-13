Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF14CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48F320873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DSCPjlb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgBMKPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:15:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45562 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbgBMKPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bNCq+dgtxrSstYcy+afH47TIY+l0yWJ0gHPmupfZ/rg=; b=DSCPjlb3F/7wEMM6wb3IcUzUyP
        yfNqr0Q4gtchQzVp2nLVEDQHm3mQBEO0whbrfUOlrhksN4FYlsyyqMbZSw9I1dShcQSkr5fDtJvQq
        +o1pISyGPG+NZFlbcr5Jy45JrTCDPY5rBKvlTuMhNSHPOVVikqTGsCyEs0lRz+XkIqLmL30jGWXve
        uAAwJJtpNnhs3WQzsDmWyTmvXx330zPKzzvusTCMLZrwEfQW0SPjNLcOC4D3qn5B5/HQ+MbDY2bet
        jos3kBHmwomYp4JdBzgZjTIMOtSg88jb0P1VhsB2LojhVQFeKgw8RWhImU70QQURHq9t6mtq/L/3E
        z3cwCT4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2BX2-0007dy-MF; Thu, 13 Feb 2020 10:15:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 282D53013A4;
        Thu, 13 Feb 2020 11:13:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78BCB2B2E4991; Thu, 13 Feb 2020 11:15:38 +0100 (CET)
Date:   Thu, 13 Feb 2020 11:15:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de,
        Stefan Asserhall load and store 
        <stefan.asserhall@xilinx.com>, Boqun Feng <boqun.feng@gmail.com>,
        paulmck@kernel.org
Subject: Re: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Message-ID: <20200213101538.GN14897@hirez.programming.kicks-ass.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
 <20200212155500.GB14973@hirez.programming.kicks-ass.net>
 <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
 <20200213085849.GL14897@hirez.programming.kicks-ass.net>
 <20200213091651.GA14946@hirez.programming.kicks-ass.net>
 <20200213100403.GA1405@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213100403.GA1405@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:04:03AM +0000, Will Deacon wrote:
> On Thu, Feb 13, 2020 at 10:16:51AM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 13, 2020 at 09:58:49AM +0100, Peter Zijlstra wrote:
> > 
> > > The thing is, your bog standard LL/SC _SHOULD_ fail the SC if someone
> > > else does a regular store to the same variable. See the example in
> > > Documentation/atomic_t.txt.
> > > 
> > > That is, a competing SW/SWI should result in the interconnect responding
> > > with something other than EXOKAY, the SWX should fail and MSR[C] <- 1.
> > 
> > The thing is; we have code that relies on this behaviour. There are a
> > few crusty SMP archs that sorta-kinda limp along (mostly by disabling
> > some of the code and praying the rest doesn't trigger too often), but we
> > really should not allow more broken SMP archs.
> 
> I did find this in the linked pdf:
> 
>   | If the store [swx] is successful, the sequence of instructions from
>   | the semaphore load to the semaphore store appear to be executed
>   | atomically - no other device modified the semaphore location between
>   | the read and the update.
> 
> which sounds like we're ok, although it could be better worded.
> 
> One part I haven't figured out is what happens if you take an interrupt
> between the lwx and the swx and whether you can end up succeeding thanks
> to somebody else's reservation. Also, the manual is silent about the
> interaction with TLB invalidation and just refers to "address" when
> talking about the reservation. What happens if a user thread triggers
> CoW while another is in the middle of a lwx/swx?

Page 79, Table 2-40 has the note:

"All of these events will clear the reservation bit, used together with
the LWX and SWX instructions to implement mutual exclusion,..."


