Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F185C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33EBB225A9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFUHDVhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgGNRGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgGNRGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:06:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7D6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:06:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x9so13828797ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJm1t05Po+4zMDPtcYKWN6mq9hRYhZ2nPxkmsCyOr24=;
        b=YFUHDVhbmo2BE82epN9X+RBzoGuQ33R+C8QlLDl9UdOt3MugA50jkrz+IZtWeQP3Rr
         K2nZyW3QpQ8P4lsjq3W8trDYdOO/vvT6NdbngPPVAz5T/emdWDUDmMJZ9SSPU4aQJels
         EhLtbe4AJpozRVltCRsh6itCqiTfU+T5d5Sca8W6eUvO5GiFfwiWqlAntQB0S1grDn9M
         vIhFBjfDrHfJCbGVr1UtzDNvCRYgcUTPq3dD1PdSQSPbjIxTaMHNvE6lAxDd4l1Gl4LS
         LpcrAWbnzgctnXwKPDm73JFdhCeD3Z3S/Kl2AJUY1Xgn1jmdWRxQWc8pZRH3bs5kZ/5G
         tu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJm1t05Po+4zMDPtcYKWN6mq9hRYhZ2nPxkmsCyOr24=;
        b=QX0vXej5ibIvjNMM/bCJjOFgVy90cmTL97X9SsGJDaWDiR4sHRaZkt8SrMoZ3iFxHE
         K1i/u4YYmUe/53fYxkvy4HPozE5EcSxs62pWJyY+CMe/COYSqOng62ewZI21GhKC6+U1
         WMLh5UMl9akIT0Lt6ZSxRp2blQnp+Nam+OLHHqPBY9rw9yTZzish5KZ5uqJJ1wD+ya/4
         2rYoEgxWB5nRTuEuI6uC5J6p0DF4M4bb7WNju5AGq3UUAa7cOi6/MLrUn1YLJllEGk8+
         zFpVuQs5Rq0MZzO14sgVOtnDp4HH6mSC8lko0LJlgrfyU/TqAerQe9INdCZgSiI/K4jF
         8oZA==
X-Gm-Message-State: AOAM533F6xo5lGBIUc7UUKHzJyf/5OCRgw3ZKKUfitztSCQhjo53iECj
        Gcmy+dfMujtHoNU/POGl4pwmgNxCoRxcedCPad0O5A==
X-Google-Smtp-Source: ABdhPJzOC6CjYLel9eH/OOKj47rWug4PTe2I9vQX76lHAcRj6LUhq0/z4PIWfRdHxGTPUlSZECOhQNSxt+o1cNv9oCo=
X-Received: by 2002:a05:651c:10f:: with SMTP id a15mr2612138ljb.192.1594746403269;
 Tue, 14 Jul 2020 10:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200709194718.189231-1-guro@fb.com> <20200710122917.GB3022@dhcp22.suse.cz>
 <CALvZod6Yk8QoZjbNkGE8-qeOD187Nu-+VwasoROGZs_UsMgbEQ@mail.gmail.com>
 <20200710184205.GB350256@carbon.dhcp.thefacebook.com> <CALvZod45_zVaFhvw-wc9b6-Fth=fZo5Fo6xCwRVkrWC6ZprYyw@mail.gmail.com>
 <20200714153817.GA215857@cmpxchg.org>
In-Reply-To: <20200714153817.GA215857@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 14 Jul 2020 10:06:32 -0700
Message-ID: <CALvZod5n+KF9c6VCMVVrdYqwk+PY6K0AoQQU+mDEk85Ozz_NJg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: avoid workload stalls when lowering memory.high
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Domas Mituzas <domas@fb.com>, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 8:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Jul 10, 2020 at 12:19:37PM -0700, Shakeel Butt wrote:
> > On Fri, Jul 10, 2020 at 11:42 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Fri, Jul 10, 2020 at 07:12:22AM -0700, Shakeel Butt wrote:
> > > > On Fri, Jul 10, 2020 at 5:29 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > >
> > > > > On Thu 09-07-20 12:47:18, Roman Gushchin wrote:
> > > > > > Memory.high limit is implemented in a way such that the kernel
> > > > > > penalizes all threads which are allocating a memory over the limit.
> > > > > > Forcing all threads into the synchronous reclaim and adding some
> > > > > > artificial delays allows to slow down the memory consumption and
> > > > > > potentially give some time for userspace oom handlers/resource control
> > > > > > agents to react.
> > > > > >
> > > > > > It works nicely if the memory usage is hitting the limit from below,
> > > > > > however it works sub-optimal if a user adjusts memory.high to a value
> > > > > > way below the current memory usage. It basically forces all workload
> > > > > > threads (doing any memory allocations) into the synchronous reclaim
> > > > > > and sleep. This makes the workload completely unresponsive for
> > > > > > a long period of time and can also lead to a system-wide contention on
> > > > > > lru locks. It can happen even if the workload is not actually tight on
> > > > > > memory and has, for example, a ton of cold pagecache.
> > > > > >
> > > > > > In the current implementation writing to memory.high causes an atomic
> > > > > > update of page counter's high value followed by an attempt to reclaim
> > > > > > enough memory to fit into the new limit. To fix the problem described
> > > > > > above, all we need is to change the order of execution: try to push
> > > > > > the memory usage under the limit first, and only then set the new
> > > > > > high limit.
> > > > >
> > > > > Shakeel would this help with your pro-active reclaim usecase? It would
> > > > > require to reset the high limit right after the reclaim returns which is
> > > > > quite ugly but it would at least not require a completely new interface.
> > > > > You would simply do
> > > > >         high = current - to_reclaim
> > > > >         echo $high > memory.high
> > > > >         echo infinity > memory.high # To prevent direct reclaim
> > > > >                                     # allocation stalls
> > > > >
> > > >
> > > > This will reduce the chance of stalls but the interface is still
> > > > non-delegatable i.e. applications can not change their own memory.high
> > > > for the use-cases like application controlled proactive reclaim and
> > > > uswapd.
> > >
> > > Can you, please, elaborate a bit more on this? I didn't understand
> > > why.
> > >
> >
> > Sure. Do we want memory.high a CFTYPE_NS_DELEGATABLE type file? I
> > don't think so otherwise any job on a system can change their
> > memory.high and can adversely impact the isolation and memory
> > scheduling of the system.
> >
> > Next we have to agree that there are valid use-cases to allow
> > applications to reclaim from their cgroups and I think uswapd and
> > proactive reclaim are valid use-cases. Let's suppose memory.high is
> > the only way to trigger reclaim but the application can not write to
> > their top level memory.high, so, it has to create a dummy cgroup of
> > which it has write access to memory.high and has to move itself to
> > that dummy cgroup to use memory.high to trigger reclaim for
> > uswapd/proactive-reclaim.
>
> For what it's worth, for proactive reclaim driven by userspace, we're
> currently carrying a hacky memory.high.tmp in our private tree. It
> takes a limit and a timeout, so that in case the daemon crashes during
> a dip in memory consumption no unsafe limits are left behind.
>
> We haven't upstreamed it because it's not clear yet how exactly the
> interface should look like. The userspace daemon is still
> evolving. But I think we're going to need *some form* of a dedicated
> knob to make this operation safe.
>

We have an internal interface memory.try_to_free_pages and we echo the
number of bytes we want to reclaim from that memcg. No manipulation of
limits or need to restore them.

> As far as permissions to self-pressurize go - I'm curious how you make
> that safe? How do you keep the reclaim daemon from accidentally
> putting excessive pressure on its own cgroup that may interfere with
> the very act of backing off the limit again?
>

That's a good and important question. Internally we don't have uswapd
use-case (self pressure) and for proactive reclaim we do something
similar to your setup. The jobs have a dedicated sub-container to run
the reclaimer binary and the actual workload runs in the sibling
container. The reclaimer keeps pressuring the sibling (not the job's
root container) to reclaim proactively.

Yang Shi was looking into per-memcg kswapd and having an interface
which would benefit his use-case as well should be preferred IMO.

> The way we do this right now is having the reclaimer daemon in a
> dedicated top-level cgroup with memory.min protection.
>
> This works well because we have a comprehensive cgroup setup anyway
> and need to protect this daemon (it's oomd - the proactive reclaimer,
> senpai, is a plugin) for other reasons as well. But it's probably a
> royal pain to use if you don't have all of that infrastructure.
>
> One possible idea to make this simpler would be to have a limit knob
> that has a psi/pressure blowout valve. This way you could specify your
> tolerances for paging and what constitutes "cold" memory, and the
> limit unsets itself when pressure moves into harmful territory. This
> would make it safe to use when the reclaimer becomes unresponsive or
> dies altogether, which makes it safe to use from within the
> cgroup. And being separate from max and high means we can delegate it.

I like this idea and agree with having a separate interface from max
and high. Though why do we want to think of this interface as a limit
interface. Are there additional benefits or use-cases which can
benefit from this semantic?
