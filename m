Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8425120672
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfCcznYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbgG1RxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgG1RxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:53:03 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A191DC0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:53:03 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h1so15490504otq.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKg/T7h0+IcTaK5sUlD4aWvye+DlJgPV3ZmHWAi13uI=;
        b=JfCcznYJ81m3a0At/Be2Y2JYfjKwPlt6ZvDDzpat6zy5UirlLyfFw6bwxGRMSxiv45
         crBwqmJglqNwLoQfJQv+/LKg874OK2/ESad0O1E9lMCHBrW8zGNpzL1vssmEioQjgpqi
         eO/ohUweePRfsKX+Gl9ov0i94DSrukleVQA33EPxcMA4mCoNb8zVExwu8Trdg9E3zPPS
         FWOAo1Ac1L5He1cXSbtt0JIgTTi05SMihVLcv4ewsOPcx9c3DPuiASTuAeO5Kun1aqoo
         S+kiCfXuXe/6AXpm9G7CHHwrSKECYDDkVTZ+BrxW6K3Ee3iTihaAKAw/Zp1HHjnoXSY2
         kuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKg/T7h0+IcTaK5sUlD4aWvye+DlJgPV3ZmHWAi13uI=;
        b=YizHy4NGZpM3gpZ+otXzt4iuLIL0z9rElRZ/kUUfNqJG+RFKo+Ln0CeUSMzqSQdzUL
         zeqnE/EUPA7JXM5wvKiCzl3vC75niB+b9cfSX3fTo/bEDB4EGp2mpWXvZP57NpeerrhS
         IeaHcs0COagadR6cckCtqF7wPWca6XPzkpmCjyKIVf4qT992nPHnpJBqIw13L4KGhjrZ
         gmmBPBr+cuFg4Jov4VxZt2x4kJ2xTgM50pzo0LKJ6qwdJmzEABWVHyCweaIJirUVjFS4
         ULyiRP/Qn9L7gWDVHGdKhgFwHH1ZMeI7uYzQ9ZDcrrhV+MyENFOYn1EIbJykCcjWlXC7
         Gg2g==
X-Gm-Message-State: AOAM531t0e0gb1vtCbPWTQvNGYhjnCyDKEoysJObdPQZhbfTxl9v9GFl
        uRcd4gPewHniKP8KVG6tYRnVgQQIMgliSE2yth5kzA==
X-Google-Smtp-Source: ABdhPJzmXx1pqXlX+hxB+cERg9Jlz6OfIP6uiv1gDCb0IzhgSzQ22bcKV9NI+dVTtlhbop5X1LpMpzz/rU1r99oj5qg=
X-Received: by 2002:a05:6830:1093:: with SMTP id y19mr25784978oto.204.1595958782660;
 Tue, 28 Jul 2020 10:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200728070131.1629670-1-xii@google.com> <20200728103907.GT119549@hirez.programming.kicks-ass.net>
In-Reply-To: <20200728103907.GT119549@hirez.programming.kicks-ass.net>
From:   Xi Wang <xii@google.com>
Date:   Tue, 28 Jul 2020 10:54:22 -0700
Message-ID: <CAOBoifg6Cm2P+HUH0mS1tNpVMa1giWDwKbQ6FofWGZoz1tTt5A@mail.gmail.com>
Subject: Re: [PATCH] sched: Make select_idle_sibling search domain configurable
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 3:39 AM <peterz@infradead.org> wrote:
>
> On Tue, Jul 28, 2020 at 12:01:31AM -0700, Xi Wang wrote:
> > The scope of select_idle_sibling idle cpu search is LLC. This
> > becomes a problem for the AMD CCX architecture, as the sd_llc is only
> > 4 cores. On a many core machine, the range of search is too small to
> > reach a satisfactory level of statistical multiplexing / efficient
> > utilization of short idle time slices.
> >
> > With this patch idle sibling search is detached from LLC and it
> > becomes run time configurable. To reduce search and migration
> > overheads, a presearch domain is added. The presearch domain will be
> > searched first before the "main search" domain, e.g.:
> >
> > sysctl_sched_wake_idle_domain == 2 ("MC" domain)
> > sysctl_sched_wake_idle_presearch_domain == 1 ("DIE" domain)
> >
> > Presearch will go through 4 cores of a CCX. If no idle cpu is found
> > during presearch, full search will go through the remaining cores of
> > a cpu socket.
>
> *groan*, this is horrific :-(
>
> It is also in direct conflict with people wanting to make it smaller.
>
> On top of that, a domain number is a terrible terrible interface. They
> aren't even available without SCHED_DEBUG on.
>
> What is the inter-L3 latency? Going by this that had better be awesome.
> And if this Infinity Fabric stuff if highly effective in effectively
> merging L3s -- analogous to what Intel does with it's cache slices, then
> should we not change the AMD topology setup instead of this 'thing'?
>
> Also, this commit:
>
>   051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain")
>
> seems to suggest L3 is actually bigger. Suravee, can you please comment?

I think 051f3ca02e46 was still saying 4 cores sharing an L3 but there
is another numa layer which is 8 cores or 2 * 4 core L3 groups. This
should be the chiplet layer.

I don't have precise data but some anecdotes are: The latency
difference between inter 4 core group access and inter 8 core group
access is not huge. Also my experience from Intel machines was that
accessing L3 data across numa domains (also across cpu socket) was not
too bad until the link bandwidth was saturated. I am hoping the
bandwidth situation is better for AMD as L3 groups are smaller.
Another factor is sometimes the trade off is spending 10s of us of
sched overhead vs time slicing at ~12.5ms latency.

What makes the decision trickly is the configuration can depend on
applications and the scale of the system. For a system with 8 cores,
running it the old way with 2 * 4 core LLCs might be the best
decision. For a system with a lot more cores, the number of threads on
the machine would also scale up, which means more potential to create
a dynamic imbalance. I have another (even more horrific) patch for
auto configuring the sysctls, which has (nnext is the size of the next
higher sched domain):

/*
* Widen the range of idle core search if llc domain is too small, both in
* absolute sense and when compared to the next higher level domain.
*/
if (nllc < min(24, nnext / 4)) {
        sysctl_sched_wake_idle_domain = next_level;
        sysctl_sched_wake_idle_presearch_domain = llc_level;
        /* Also make new idle search domain params more like default llc */
        sysctl_sched_wake_idle_domain_tune_flags = 1;
}

-Xi
