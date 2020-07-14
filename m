Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA49C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030EF22404
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="t36hGhq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGNPjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgGNPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:39:09 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EDBC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:39:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id e11so15992422qkm.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=udaIJS0JTvOfLh22C6s5PXq+hAqCuMLbXynj9AvwNfw=;
        b=t36hGhq6fYlBHr3reEL60xJ9Hsqz2Fh7uaCmdq4G7aSIKOJe29wosZHkhylqlO8iMu
         rEUj1WtiMn6zd2vO1VFwPwLC6alSQ2GNbrY4E9StreSKDQasc6/Rbn27Un3RDSeFMCjY
         GFsVNP2u8YW/HcTOxNyQ1Pfdta0FENBlljwec8KQsrk2jaJARDlUdeFLLpxS3V+w6N2+
         77W/AJFo+Oak5RIhf/dgVKowiHgAMf5exTiensoa5uRk/A/WsbFazxULX7O+KFL+nNEy
         PWtH/EmzaVyQTEj44kB/MBC7iRhZUoWr7RtxTcqQWlSaYPHiqcrdfbbAXvsv6rZVAVA4
         rHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=udaIJS0JTvOfLh22C6s5PXq+hAqCuMLbXynj9AvwNfw=;
        b=jVpNkoGVTv/a/y1j7KoTthgfB13S9oIdBlr7D1qluCpAMlIuF0WJeTwxW/3Ev9Av7b
         RbCcWjkkhg+ww3tFTBirWnFEcbloqVWAaR6CsLbAArULVQ0ijRbMF9tp0eZXlnkAsmuS
         BRCP2WAoSDkWzMQlgyRC50IyLZWVJG7dpAzaT0Rapg4pqfD7DNKD6LeQ8QV1DXPrVmbA
         miNV5bYQB1L1d3jpniictEXYpDWjvaJpOi6hpnZ6eWsNcHK6iJFI+uW+95qIQMRMFy5B
         drRmoz171u7Zpy7jCz8VD4NOsVwIIrieT74GwQxts+dh5cNncBjtCyRDQ7v6M4zO2743
         6Q+g==
X-Gm-Message-State: AOAM532Wmn5QBw51Drubz0stiravyLAUrnJ4esOnivpr3LwV9fPouZLf
        03ccyo3JWsrgWmLtNVzyVm3pRA==
X-Google-Smtp-Source: ABdhPJzdVJ1fec3PNIF6e8LFfx5i8dQrP7XaYGWW7sAdQ8zlpK2plTnJt8cwSZLekO4Zy5KH4fMU7Q==
X-Received: by 2002:a05:620a:2298:: with SMTP id o24mr5050638qkh.73.1594741147787;
        Tue, 14 Jul 2020 08:39:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:81a8])
        by smtp.gmail.com with ESMTPSA id d14sm2791142qkl.9.2020.07.14.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 08:39:06 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:38:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Domas Mituzas <domas@fb.com>, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm: memcontrol: avoid workload stalls when lowering
 memory.high
Message-ID: <20200714153817.GA215857@cmpxchg.org>
References: <20200709194718.189231-1-guro@fb.com>
 <20200710122917.GB3022@dhcp22.suse.cz>
 <CALvZod6Yk8QoZjbNkGE8-qeOD187Nu-+VwasoROGZs_UsMgbEQ@mail.gmail.com>
 <20200710184205.GB350256@carbon.dhcp.thefacebook.com>
 <CALvZod45_zVaFhvw-wc9b6-Fth=fZo5Fo6xCwRVkrWC6ZprYyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod45_zVaFhvw-wc9b6-Fth=fZo5Fo6xCwRVkrWC6ZprYyw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:19:37PM -0700, Shakeel Butt wrote:
> On Fri, Jul 10, 2020 at 11:42 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Jul 10, 2020 at 07:12:22AM -0700, Shakeel Butt wrote:
> > > On Fri, Jul 10, 2020 at 5:29 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Thu 09-07-20 12:47:18, Roman Gushchin wrote:
> > > > > Memory.high limit is implemented in a way such that the kernel
> > > > > penalizes all threads which are allocating a memory over the limit.
> > > > > Forcing all threads into the synchronous reclaim and adding some
> > > > > artificial delays allows to slow down the memory consumption and
> > > > > potentially give some time for userspace oom handlers/resource control
> > > > > agents to react.
> > > > >
> > > > > It works nicely if the memory usage is hitting the limit from below,
> > > > > however it works sub-optimal if a user adjusts memory.high to a value
> > > > > way below the current memory usage. It basically forces all workload
> > > > > threads (doing any memory allocations) into the synchronous reclaim
> > > > > and sleep. This makes the workload completely unresponsive for
> > > > > a long period of time and can also lead to a system-wide contention on
> > > > > lru locks. It can happen even if the workload is not actually tight on
> > > > > memory and has, for example, a ton of cold pagecache.
> > > > >
> > > > > In the current implementation writing to memory.high causes an atomic
> > > > > update of page counter's high value followed by an attempt to reclaim
> > > > > enough memory to fit into the new limit. To fix the problem described
> > > > > above, all we need is to change the order of execution: try to push
> > > > > the memory usage under the limit first, and only then set the new
> > > > > high limit.
> > > >
> > > > Shakeel would this help with your pro-active reclaim usecase? It would
> > > > require to reset the high limit right after the reclaim returns which is
> > > > quite ugly but it would at least not require a completely new interface.
> > > > You would simply do
> > > >         high = current - to_reclaim
> > > >         echo $high > memory.high
> > > >         echo infinity > memory.high # To prevent direct reclaim
> > > >                                     # allocation stalls
> > > >
> > >
> > > This will reduce the chance of stalls but the interface is still
> > > non-delegatable i.e. applications can not change their own memory.high
> > > for the use-cases like application controlled proactive reclaim and
> > > uswapd.
> >
> > Can you, please, elaborate a bit more on this? I didn't understand
> > why.
> >
> 
> Sure. Do we want memory.high a CFTYPE_NS_DELEGATABLE type file? I
> don't think so otherwise any job on a system can change their
> memory.high and can adversely impact the isolation and memory
> scheduling of the system.
> 
> Next we have to agree that there are valid use-cases to allow
> applications to reclaim from their cgroups and I think uswapd and
> proactive reclaim are valid use-cases. Let's suppose memory.high is
> the only way to trigger reclaim but the application can not write to
> their top level memory.high, so, it has to create a dummy cgroup of
> which it has write access to memory.high and has to move itself to
> that dummy cgroup to use memory.high to trigger reclaim for
> uswapd/proactive-reclaim.

For what it's worth, for proactive reclaim driven by userspace, we're
currently carrying a hacky memory.high.tmp in our private tree. It
takes a limit and a timeout, so that in case the daemon crashes during
a dip in memory consumption no unsafe limits are left behind.

We haven't upstreamed it because it's not clear yet how exactly the
interface should look like. The userspace daemon is still
evolving. But I think we're going to need *some form* of a dedicated
knob to make this operation safe.

As far as permissions to self-pressurize go - I'm curious how you make
that safe? How do you keep the reclaim daemon from accidentally
putting excessive pressure on its own cgroup that may interfere with
the very act of backing off the limit again?

The way we do this right now is having the reclaimer daemon in a
dedicated top-level cgroup with memory.min protection.

This works well because we have a comprehensive cgroup setup anyway
and need to protect this daemon (it's oomd - the proactive reclaimer,
senpai, is a plugin) for other reasons as well. But it's probably a
royal pain to use if you don't have all of that infrastructure.

One possible idea to make this simpler would be to have a limit knob
that has a psi/pressure blowout valve. This way you could specify your
tolerances for paging and what constitutes "cold" memory, and the
limit unsets itself when pressure moves into harmful territory. This
would make it safe to use when the reclaimer becomes unresponsive or
dies altogether, which makes it safe to use from within the
cgroup. And being separate from max and high means we can delegate it.
