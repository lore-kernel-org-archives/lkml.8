Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC948C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A27222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581588249;
	bh=Z6nftmq7JNaTrmiiMEw1a3aSpCEEwo051FSLj6v+n1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ydji+0FL3zHodjrh0st25dkwFuRv0KBhjg66K6ukw8gtr5ZUWyJIPqdPingFUpEku
	 KLri3/qtYOwalcVIritGJ/w9cbKwvW4RaZF6I6JGCjBf5XSaw443hC6jPvOqtXM2Hp
	 ZgfiuvBhdvwZxclYOigSv0eUD81cZDRCm286hlIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgBMKEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:04:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbgBMKEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:04:08 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 996C42073C;
        Thu, 13 Feb 2020 10:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581588248;
        bh=Z6nftmq7JNaTrmiiMEw1a3aSpCEEwo051FSLj6v+n1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ca9dCV5da4xBo9tGQNQvbCi2Madj6+NmjnrM2KG7PGrC0nrxjRGScqZJ+AAqeytd
         PaMwy2pwiLwyG764P9qIyiAMZd1CMdWDTfzC7E6iZ4DHq8iiGszguSEG/XqhgKy+qh
         4PMKuvIlDoX+GqYLV0h+3vLBLrFry+Fis/i4q81Q=
Date:   Thu, 13 Feb 2020 10:04:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de,
        Stefan Asserhall load and store 
        <stefan.asserhall@xilinx.com>, Boqun Feng <boqun.feng@gmail.com>,
        paulmck@kernel.org
Subject: Re: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Message-ID: <20200213100403.GA1405@willie-the-truck>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
 <20200212155500.GB14973@hirez.programming.kicks-ass.net>
 <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
 <20200213085849.GL14897@hirez.programming.kicks-ass.net>
 <20200213091651.GA14946@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213091651.GA14946@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:16:51AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 13, 2020 at 09:58:49AM +0100, Peter Zijlstra wrote:
> 
> > The thing is, your bog standard LL/SC _SHOULD_ fail the SC if someone
> > else does a regular store to the same variable. See the example in
> > Documentation/atomic_t.txt.
> > 
> > That is, a competing SW/SWI should result in the interconnect responding
> > with something other than EXOKAY, the SWX should fail and MSR[C] <- 1.
> 
> The thing is; we have code that relies on this behaviour. There are a
> few crusty SMP archs that sorta-kinda limp along (mostly by disabling
> some of the code and praying the rest doesn't trigger too often), but we
> really should not allow more broken SMP archs.

I did find this in the linked pdf:

  | If the store [swx] is successful, the sequence of instructions from
  | the semaphore load to the semaphore store appear to be executed
  | atomically - no other device modified the semaphore location between
  | the read and the update.

which sounds like we're ok, although it could be better worded.

One part I haven't figured out is what happens if you take an interrupt
between the lwx and the swx and whether you can end up succeeding thanks
to somebody else's reservation. Also, the manual is silent about the
interaction with TLB invalidation and just refers to "address" when
talking about the reservation. What happens if a user thread triggers
CoW while another is in the middle of a lwx/swx?

Will
