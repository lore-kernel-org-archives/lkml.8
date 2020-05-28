Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1A8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A810208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OqS/QpZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436711AbgE1Vs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436611AbgE1Vs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:48:26 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736ABC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:48:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z80so470215qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ObSt1n+sON0AnimchOO9CMzGTDqwAegnfy7EUyM2WHk=;
        b=OqS/QpZ3lCGXJg0nDVCz+2iqN/kApfGrVdZCjy/U055rqKuVpm9gAQ6GjPkvqQ+zrH
         SAflj/Lptc3O4XWr2Hz51tNwohI1BaLQulX8MYynNbfQsI5vYcjiLUtJVj5C4d5noKQ+
         7DUoh4xfssrHaUKI64+pS2ieabDxVGlrwSsGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ObSt1n+sON0AnimchOO9CMzGTDqwAegnfy7EUyM2WHk=;
        b=jTFHGsN1R5lSmZ5trzjVTmcqM1BJ1Pedvztg0DU8Oh5BQLJzPzhHkiPWN/IIObDbrJ
         9H55st/0t83woSe0IDblJFIdsc6a/5YROVxcr6fkbUsfXCBHsOzAeTZZtwluP0/1d198
         RefKctRZ2WZSpZ1rRpbZFb6JekB2ypHh3Zc/1duyAdyGNLPYwy5MTFhX9MJ7sMwKd9SZ
         ujWj93UbIkkX5lcrp2+CRpk4h7iq4lHR9dGQ8wW1ICTO4OejTlfAibc8wYyzRtahd4g4
         oSmBtINW1Eazsb2N37nNeO9MePfLPJ8zmTAwbycKYC+JAFW0Q4UboVxbz2s8D12fgJoW
         s85A==
X-Gm-Message-State: AOAM533mp+bggDUyeJ4TvB4MIc+5mZPUVFjnCLmJoKJ/0mjxxFrRIiwo
        GlJzMne1xn8wWblNh2ot8GBqYA==
X-Google-Smtp-Source: ABdhPJwjnvloshNe5HEBiCg7pAnSK5h4W+nwUCYvm4X+s1L/d2OCLwncq8HyIDIEUetxgblfvG5cKw==
X-Received: by 2002:a37:6845:: with SMTP id d66mr5096984qkc.229.1590702504369;
        Thu, 28 May 2020 14:48:24 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j22sm5763247qke.117.2020.05.28.14.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:48:23 -0700 (PDT)
Date:   Thu, 28 May 2020 17:48:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200528214823.GA211369@google.com>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525145325.GB2066@tardis>
 <CAEf4BzYCjbnU=cNyLnYRoZdMPKnBP4w8t+VRkXrC1GW-aFVkEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYCjbnU=cNyLnYRoZdMPKnBP4w8t+VRkXrC1GW-aFVkEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:38:23AM -0700, Andrii Nakryiko wrote:
> On Mon, May 25, 2020 at 7:53 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hi Andrii,
> >
> > On Fri, May 22, 2020 at 12:38:21PM -0700, Andrii Nakryiko wrote:
> > > On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> > > > On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> > > > > On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> > > > > > On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > > > > > > Hello!
> > > > > > >
> > > > > > > Just wanted to call your attention to some pretty cool and pretty serious
> > > > > > > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > > > > > >
> > > > > > > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> > > > > > >
> > > > > > > Thoughts?
> > > > > >
> > > > > > I find:
> > > > > >
> > > > > >         smp_wmb()
> > > > > >         smp_store_release()
> > > > > >
> > > > > > a _very_ weird construct. What is that supposed to even do?
> > > > >
> > > > > Indeed, it looks like one or the other of those is redundant (depending
> > > > > on the context).
> > > >
> > > > Probably.  Peter instead asked what it was supposed to even do.  ;-)
> > >
> > > I agree, I think smp_wmb() is redundant here. Can't remember why I thought
> > > that it's necessary, this algorithm went through a bunch of iterations,
> > > starting as completely lockless, also using READ_ONCE/WRITE_ONCE at some
> > > point, and settling on smp_read_acquire/smp_store_release, eventually. Maybe
> > > there was some reason, but might be that I was just over-cautious. See reply
> > > on patch thread as well ([0]).
> > >
> > >   [0] https://lore.kernel.org/bpf/CAEf4Bza26AbRMtWcoD5+TFhnmnU6p5YJ8zO+SoAJCDtp1jVhcQ@mail.gmail.com/
> > >
> >
> > While we are at it, could you explain a bit on why you use
> > smp_store_release() on consumer_pos? I ask because IIUC, consumer_pos is
> > only updated at consumer side, and there is no other write at consumer
> > side that we want to order with the write to consumer_pos. So I fail
> > to find why smp_store_release() is necessary.
> >
> > I did the following modification on litmus tests, and I didn't see
> > different results (on States) between two versions of litmus tests.
> >
> 
> This is needed to ensure that producer can reliably detect whether it
> needs to trigger poll notification.

Boqun's question is on the consumer side though. Are you saying that on the
consumer side, the loads prior to the smp_store_release() on the consumer
side should have been seen by the consumer?  You are already using
smp_load_acquire() so that should be satisified already because the
smp_load_acquire() makes sure that the smp_load_acquire()'s happens before
any future loads and stores.

> Basically, consumer caught up at
> about same time as producer commits new record, we need to make sure
> that:
>   - either consumer sees updated producer_pos > consumer_pos, and thus
> knows that there is more data to consumer (but producer might not send
> notification of new data in this case);
>   - or producer sees that consumer already caught up (i.e.,
> consumer_pos == producer_pos before currently committed record), and
> in such case will definitely send notifications.

Could you set a variable on the producer side to emulate a notification, and
check that in the conditions at the end?

thanks,

 - Joel

> 
> This is critical for correctness of epoll notifications.
> Unfortunately, litmus tests don't test this notification aspect, as I
> haven't originally figured out the invariant that can be defined to
> validate this. I'll give it another thought, though, maybe this time
> I'll come up with something.
> 
> > Regards,
> > Boqun
> >
> 
> [...]
