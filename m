Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE17CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46B221739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583174675;
	bh=hDtYO3C32pwwl+j+MIKuWJFXKB5fFLSdOPcA9MD/Zes=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=reJ/CwjsoeNPW3WTV0yXETsa0n4Ix8vM+uoWI8a2kliFJZCVZJFcuPLA+eMDwZ5OT
	 cqae6UVtVFcgY3Ahu0RsarNtZOvOcpNAxQF+Prea3qAPMuhilh1izM3hcop+uOTopO
	 2DBjvNTeBXaTFpSC4g42DclRKviLC2f0fZL2xr3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgCBSoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:44:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgCBSoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:44:34 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B59DE2072A;
        Mon,  2 Mar 2020 18:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583174673;
        bh=hDtYO3C32pwwl+j+MIKuWJFXKB5fFLSdOPcA9MD/Zes=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RRLY9a1vrOr7Yi49JbXWmSNy5zp6GZtYlcn8bvKtrZwt1hgP/l4qIclinDZnBfQGD
         5SZM2CmoDaDWIjnzIqh5oJrVim+7Ln4mmyp/WsUnIwIsj+vrhH/2aqN7Ptaa/z36nn
         p63w8tyULbT8h0OQq2UyzOz4pDkmbGaa2vWKxFkM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 91C0B35226C8; Mon,  2 Mar 2020 10:44:33 -0800 (PST)
Date:   Mon, 2 Mar 2020 10:44:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model/Documentation: Fix "conflict"
 definition
Message-ID: <20200302184433.GL2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200302172101.157917-1-elver@google.com>
 <Pine.LNX.4.44L0.2003021256130.1555-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003021256130.1555-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 12:56:59PM -0500, Alan Stern wrote:
> On Mon, 2 Mar 2020, Marco Elver wrote:
> 
> > The definition of "conflict" should not include the type of access nor
> > whether the accesses are concurrent or not, which this patch addresses.
> > The definition of "data race" remains unchanged.
> > 
> > The definition of "conflict" as we know it and is cited by various
> > papers on memory consistency models appeared in [1]: "Two accesses to
> > the same variable conflict if at least one is a write; two operations
> > conflict if they execute conflicting accesses."
> > 
> > The LKMM as well as the C11 memory model are adaptations of
> > data-race-free, which are based on the work in [2]. Necessarily, we need
> > both conflicting data operations (plain) and synchronization operations
> > (marked). For example, C11's definition is based on [3], which defines a
> > "data race" as: "Two memory operations conflict if they access the same
> > memory location, and at least one of them is a store, atomic store, or
> > atomic read-modify-write operation. In a sequentially consistent
> > execution, two memory operations from different threads form a type 1
> > data race if they conflict, at least one of them is a data operation,
> > and they are adjacent in <T (i.e., they may be executed concurrently)."
> > 
> > [1] D. Shasha, M. Snir, "Efficient and Correct Execution of Parallel
> >     Programs that Share Memory", 1988.
> > 	URL: http://snir.cs.illinois.edu/listed/J21.pdf
> > 
> > [2] S. Adve, "Designing Memory Consistency Models for Shared-Memory
> >     Multiprocessors", 1993.
> > 	URL: http://sadve.cs.illinois.edu/Publications/thesis.pdf
> > 
> > [3] H.-J. Boehm, S. Adve, "Foundations of the C++ Concurrency Memory
> >     Model", 2008.
> > 	URL: https://www.hpl.hp.com/techreports/2008/HPL-2008-56.pdf
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> > Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > ---
> > v3:
> > * Apply Alan's suggestion.
> > * s/two race candidates/race candidates/
> 
> Looks good!

Applied, thank you both!

							Thanx, Paul
