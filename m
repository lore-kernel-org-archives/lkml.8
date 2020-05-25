Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEB4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0C2207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590428745;
	bh=hqdBoQQ8vJVPjbbwArrndRqys2kpD1XuzZn61430EJI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=z2TY0ngv3WJUiMO9rOQUYMfUn1SmCGYXCb6SEU6qEkTjYOSfJFErEp9PDWZxXN/ch
	 jkrKCE3VraRhfh1oiTSQiL7YawNJDDZ8Acgt0vd1m4cdIMBexeFnthyuMfOFlF7r5/
	 vrY8yn4fK+vwTIw6qxyNFifb3+h+O8+7D1S4juLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbgEYRpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 13:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbgEYRpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 13:45:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31420206DD;
        Mon, 25 May 2020 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590428744;
        bh=hqdBoQQ8vJVPjbbwArrndRqys2kpD1XuzZn61430EJI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MveVTah++a7WlGUvLZ4lmrML8SC0fNODbuYJpeOSVvOyNmezWCiVdZDZ3iLppZkj5
         pQt3C+pN75Ww5Hs5RgEqHX7oxdV8oM+r4WXDnqBpUXBRzBtc0D65zwR5EkXk3DPqka
         R0Qhg20ZVdlmFuYaUZTw6ld2g0hAaTywV+qmRGC0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 114F03522846; Mon, 25 May 2020 10:45:44 -0700 (PDT)
Date:   Mon, 25 May 2020 10:45:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200525174544.GA21495@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72>
 <20200525170257.GA325280@hirez.programming.kicks-ass.net>
 <20200525172154.GZ2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525172154.GZ2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 10:21:54AM -0700, Paul E. McKenney wrote:
> On Mon, May 25, 2020 at 07:02:57PM +0200, Peter Zijlstra wrote:
> > On Mon, May 25, 2020 at 08:47:30AM -0700, Paul E. McKenney wrote:
> > > On Mon, May 25, 2020 at 01:25:21PM +0200, Peter Zijlstra wrote:
> > 
> > > > That is; how can you use a spinlock on the producer side at all?
> > > 
> > > So even trylock is now forbidden in NMI handlers?  If so, why?
> > 
> > The litmus tests don't have trylock.
> 
> Fair point.
> 
> > But you made me look at the actual patch:
> > 
> > +static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
> > +{
> > +	unsigned long cons_pos, prod_pos, new_prod_pos, flags;
> > +	u32 len, pg_off;
> > +	struct bpf_ringbuf_hdr *hdr;
> > +
> > +	if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
> > +		return NULL;
> > +
> > +	len = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
> > +	cons_pos = smp_load_acquire(&rb->consumer_pos);
> > +
> > +	if (in_nmi()) {
> > +		if (!spin_trylock_irqsave(&rb->spinlock, flags))
> > +			return NULL;
> > +	} else {
> > +		spin_lock_irqsave(&rb->spinlock, flags);
> > +	}
> > 
> > And that is of course utter crap. That's like saying you don't care
> > about your NMI data.
> 
> Almost.  It is really saying that -if- there is sufficient lock
> contention, printk()s will be lost.  Just as they always have been if
> there is more printk() volume than can be accommodated.

s/printk()/BPF output/

One of those days...  :-/

							Thanx, Paul
