Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE0DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CA5206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wJWHTIkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436826AbgE1WBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436757AbgE1WAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:00:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CE7C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:00:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b6so420285qkh.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=htRLrA2JcstT/5/3aut7cM74yIFPpbJ6PQJKNNQheJI=;
        b=wJWHTIkRH74eNzRPlCgOboncNv2iVHO4Ta8nNhau9ohzL0TafoH/aBJaEoahtOW25/
         ndQSxiUDFXR8ssccuCmhQJ7bg6jB0FJZxkWK4ySQy+uPs26sy5Go0RO70jFKu/Q93xRH
         R1ZB4B1zW/JVnNpIP232M/TaWm1eyoARMrAME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=htRLrA2JcstT/5/3aut7cM74yIFPpbJ6PQJKNNQheJI=;
        b=PV28Jp4fJdJViYjZLG+jmyGOnsLpy/g4oRJEexKiTKVAa1sEFjECU02V/Vooeh+7F8
         LDhaHIUObpEKeJBUWiPTPmSWuzaihJLdO3oTNh3dbXuEqy9SLGOjzRoNAIXGkOGAiMYs
         pXNFnXFMybwlCObdZQ+kGhEJsoqn7sY1gZatObj88ns+wSYiIvTT2VU1oSRqZ7RgY519
         DxxxEIrIVeFanzIFCTV3IbwlRVtYmGDgI46vYJcY+ImhhDOSFShElLYI+BKyddduetgA
         f3CkP8nWkwNGyi58wuJHTT0j2Zk0gcNsQ8KnpnTuTg5dg8SdadpRaAVxnLqFkTCqaVLX
         Grlw==
X-Gm-Message-State: AOAM532KIJpDLKdnkH3X8NNR6K/tuxWFMYC8chq6qpRmAuZfY5/sWZr4
        vByDZ5meoOebyl5IUsHbTnHrTQ==
X-Google-Smtp-Source: ABdhPJwxQg+4A6WvDBEp0Rc1cgDenGoIxgR6MwKSCdwMgYcOcWY7zV0c/mScYBPPxDd+fTPbf124KA==
X-Received: by 2002:a37:8007:: with SMTP id b7mr5056618qkd.41.1590703248620;
        Thu, 28 May 2020 15:00:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 80sm5511600qkl.116.2020.05.28.15.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:00:48 -0700 (PDT)
Date:   Thu, 28 May 2020 18:00:47 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200528220047.GB211369@google.com>
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

Any idea why this choice of locking-based ring buffer implementation in BPF?
The ftrace ring buffer can support NMI interruptions as well for writes.

Also, is it possible for BPF to reuse the ftrace ring buffer implementation
or does it not meet the requirements?

thanks,

 - Joel

