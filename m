Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F824C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384FF2073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aA3CxAPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgGCQ1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGCQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:27:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72944C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 09:27:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id t25so33058172lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KcSwCD8ehLU/B3QNKmMXqmLG2nfUoa8CRrvpDaEqynw=;
        b=aA3CxAPywsEECYk7HA55y/TnZvUHyMJa+H7L7zkuPqWu+SFym0bgvdxpKDd6b5IFKo
         lsiajzdRGT0ACjkznuQLwoDoHR/1dPiP5VltP4vTuxOUJ21D2bXNmG5QWs8GW0jw2Omx
         Tzi39QUCzgkVoA+HKdzc4bozQi7kKP8tEl99FFwHKOBcZscgh2d5GxAi4UWLOu9xu4W8
         CujI1ALU/QEdHaMY7GTwT4v3eVcYy0xRr+ugX8rAiZTTdiCBdz30ay/hr6Xiz8NucxNb
         cYmHkQvMmjHajlRViCjJK1B9fMQnj2Br/meo/+mtVi4Fbqwp+l5mpBdzx4jArAYe5q1c
         QDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcSwCD8ehLU/B3QNKmMXqmLG2nfUoa8CRrvpDaEqynw=;
        b=nAVdbdCvkTMoSX5OC3lxVzA7v4R0rCGrLPD6qt/UI7bdT5awMHtmVWbu3Q5Rp6epw3
         x+0fhKDSi/k0cEt/77bjBxQSeJu8TUgUuEScu/xV9Atr9UcyXaGtRHNRQoe25d0n2pwV
         ez0b/vIDsUxpwoaA/EfJhKcb3kmN63Br8cWlRoC7QpVUwprGCA6jKlg4Vd9LvP4fQq4R
         /7dKOHFklbKBaHA2jR4QDXZv+cPKMxx8sHEqD7QBOEGY9vfLA0ofA1g14MKmEnZ0QSlK
         GeFjHkopMLBeqLFJWSBVJHwwwsf4CbgyEr9UNU9wkFjaR9d3TWymc2e16y9KNEAf7JLk
         CbRw==
X-Gm-Message-State: AOAM532kECoCuDO/IeW4ribeeR+zUy5ogJrmhdOhWBeWc9DIoD+ABRKc
        rInUayWbzgy2brYe0oonxtbwHO8c8Q9IdzVXzo64HQ==
X-Google-Smtp-Source: ABdhPJytgNJa60ASLPPZfeIcxsiunKccYp8qRVzYACKj6fdI1vtw8On/o+zuRfEIOb8lyzsf+OESOnVprVcq/3zSils=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr20800065ljp.347.1593793651592;
 Fri, 03 Jul 2020 09:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200702152222.2630760-1-shakeelb@google.com> <20200703063548.GM18446@dhcp22.suse.cz>
 <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com> <20200703155021.GB114903@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200703155021.GB114903@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 3 Jul 2020 09:27:19 -0700
Message-ID: <CALvZod5Z4=1CijJp0QRnx+pdH=Me6sYPXASCxVATnshU0RW-Qw@mail.gmail.com>
Subject: Re: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 8:50 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Jul 03, 2020 at 07:23:14AM -0700, Shakeel Butt wrote:
> > On Thu, Jul 2, 2020 at 11:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 02-07-20 08:22:22, Shakeel Butt wrote:
> > > [...]
> > > > Interface options:
> > > > ------------------
> > > >
> > > > 1) memcg interface e.g. 'echo 10M > memory.reclaim'
> > > >
> > > > + simple
> > > > + can be extended to target specific type of memory (anon, file, kmem).
> > > > - most probably restricted to cgroup v2.
> > > >
> > > > 2) fadvise(PAGEOUT) on cgroup_dir_fd
> > > >
> > > > + more general and applicable to other FSes (actually we are using
> > > > something similar for tmpfs).
> > > > + can be extended in future to just age the LRUs instead of reclaim or
> > > > some new use cases.
> > >
> > > Could you explain why memory.high as an interface to trigger pro-active
> > > memory reclaim is not sufficient. Also memory.low limit to protect
> > > latency sensitve workloads?
>
> I initially liked the proposal, but after some thoughts I've realized
> that I don't know a good use case where memory.high is less useful.
> Shakeel, what's the typical use case you thinking of?
> Who and how will use the new interface?
>
> >
> > Yes, we can use memory.high to trigger [proactive] reclaim in a memcg
> > but note that it can also introduce stalls in the application running
> > in that memcg. Let's suppose the memory.current of a memcg is 100MiB
> > and we want to reclaim 20MiB from it, we can set the memory.high to
> > 80MiB but any allocation attempt from the application running in that
> > memcg can get stalled/throttled. I want the functionality of the
> > reclaim without potential stalls.
>
> But reclaiming some pagecache/swapping out anon pages can always
> generate some stalls caused by pagefaults, no?
>

Thanks for looking into the proposal. Let me answer both of your
questions together. I have added the two use-cases but let me explain
the proactive reclaim a bit more as we actually use that in our
production.

We have defined tolerable refault rates for the applications based on
their type (latency sensitive or not). Proactive reclaim is triggered
in the application based on their current refault rates and usage. If
the current refault rate exceeds the tolerable refault rate then
stop/slowdown the proactive reclaim.

For the second question, yes, each individual refault can induce the
stall as well but we have more control on that stall as compared to
stalls due to reclaim. For us almost all the reclaimable memory is
anon and we use compression based swap, so, the cost of each refault
is fixed and a couple of microseconds.

I think the next question is what about the refaults from disk or
source with highly variable cost. Usually the latency sensitive
applications remove such uncertainty by mlocking the pages backed by
such backends (e.g. mlocking the executable) or at least that is the
case for us.

Thanks,
Shakeel
