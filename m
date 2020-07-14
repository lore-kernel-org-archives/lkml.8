Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CECC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940CD221EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TSj2JWpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGNPcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgGNPcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:32:23 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D257C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:32:23 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g2so11987911lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqbV9Nb2FFz6+EoRL68dxT5M8+4XjqDj51J15tcXDqg=;
        b=TSj2JWpT7atvmen6t6ki58YuhCN+eCwS79p1FUpE9N5QRc+YVPKIylEYF0XkIn4ojQ
         n9suCH/mse8LpARQjWFyAmnQQG0mvE33JDrl17LlBdjqrYyEL9XR6TR6HiAFx+zpPWIr
         b5XktYTaXhyiCxoBVFk5GQL7BaHSXNlwa1350f0SSaFmwxjcwNbrhA45tedwUJmdGTOM
         R2aqL+w9fA84Yr2PcgKKOSYcl0XcukNRMlHnUtQ0XFG4iff9z3cKFx2hUNLQa24maz5n
         zDrxLrKus91Kvqk2I+ooprMV7o9sVg5RMk4V30ubIx6uafPYDXZBqYldm7a2fS0PVExk
         ABPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqbV9Nb2FFz6+EoRL68dxT5M8+4XjqDj51J15tcXDqg=;
        b=qAwHHN2WF3TXIyAIpaLZQ2IonCLJyVl2qIjkDRVT2eUMBmSvMeVRjC326L4gmjGP8n
         gBmRnaHZujRNZM/RPtN0JmHPnKmO4BHfcfgrgyN0jGtWQ++rPFXF9ERu8ESIYHcDx3dc
         dwP6Fvxm4/K/caHrVhQAmlCQm0Xifat1Ux5bXey1fd2/mutDWxBKd2kYcxv0pbBmRHGp
         fzYXUdYeEMZCuNjyImScYiCDA2emdAdm4YdVmz7DrIg0vAMCc+2dLLioSRN4kYP1XQkO
         8hjTxIZgDyDM7SqJmvXDc6urZyq6f1J353ShSnxavxDQpBs+r46KRBFiQkONuBaKmfbj
         /Q2g==
X-Gm-Message-State: AOAM533cNrbsL9kNRfFqE0nz+lqsgafnvjYPH9GjSJKhLyX2/y9jJZr7
        E2KzD2Bb15zSShX4zmqYOentmrEtVjKpgxT2AlflWL6Y
X-Google-Smtp-Source: ABdhPJyshvzFFUz5zSXNdPHetv2lNNpNn7NtKemJ5lODpGTU4sd+e4L4n9wEfQ3JXg5wqbW0yojfA047VaG29mbX/Bg=
X-Received: by 2002:a05:6512:3f1:: with SMTP id n17mr2470898lfq.125.1594740741307;
 Tue, 14 Jul 2020 08:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200709194718.189231-1-guro@fb.com> <20200710122917.GB3022@dhcp22.suse.cz>
 <CALvZod6Yk8QoZjbNkGE8-qeOD187Nu-+VwasoROGZs_UsMgbEQ@mail.gmail.com>
 <20200710184205.GB350256@carbon.dhcp.thefacebook.com> <CALvZod45_zVaFhvw-wc9b6-Fth=fZo5Fo6xCwRVkrWC6ZprYyw@mail.gmail.com>
 <20200714084123.GG24642@dhcp22.suse.cz>
In-Reply-To: <20200714084123.GG24642@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 14 Jul 2020 08:32:09 -0700
Message-ID: <CALvZod6kw++JnZnyYVg4-u2vNQ7SLMFh3qKG1xu7_AahdmXhdg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: avoid workload stalls when lowering memory.high
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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

On Tue, Jul 14, 2020 at 1:41 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 10-07-20 12:19:37, Shakeel Butt wrote:
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
>
> Is this really the case? There should always be a parent cgroup that
> overrides the setting.

Can you explain a bit more? I don't see any requirement of having a
layer of cgroup between root and the job cgroup. Internally we
schedule jobs as top level cgroups. There do exist jobs which are a
combination of other jobs and there we do use an additional layer of
cgroup (similar to pods running multiple containers in kubernetes).
Surely we can add a layer for all the jobs but it comes with an
overhead and at scale that overhead is not negligible.

> Also you can always set the hard limit if you do
> not want to add another layer of cgroup in the hierarchy before
> delegation. Or am I missing something?
>

Yes, we can set memory.max though it has different oom semantics and
not really a replacement for memory.high.
