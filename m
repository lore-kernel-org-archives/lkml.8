Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A21C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022EF20706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUMkAeb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgHXWMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgHXWMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:12:47 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74ABC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:12:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id s16so7577123qtn.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVYt2QkTwn+6HxgI4uqLidhUAN1P9VyFLQ0r/+5q+fg=;
        b=rUMkAeb6fh2EYfhhQL3mkV8d2YOL59x1EA7+xq2PqiJmTmhpHt10n73yGRqxLBM5U6
         ub7qZsVdY/59Wex/ZDjfUgw8tt9N1aNzuJjm8PRloZSXpYbeDlrREIwwCiPtzx4c5/+I
         SbUa2nV8eMuGlALStHzrCoRLzUMrUN7yh7TPk+et6TpujenFUMJWElPSPicEzhKBA8F1
         FvOPbClO3HI/0JxhKrgRuhlGAQ3HCcCQRQKHMXVaPlWsA+li1uDmNOAyk5xdr0lQQVt1
         qI/9inFjlHavcMWCWWlQFTmMW/wt542bemzIHAi3kMuQMP78zoKoN75xebbFTN/Y32ms
         +AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVYt2QkTwn+6HxgI4uqLidhUAN1P9VyFLQ0r/+5q+fg=;
        b=PzJQwNXpS36+76RD85gwwcu/GWIqOF2nC7m6nWVJv4WLUX2bp2dlNBPPVLPPBWLwq5
         f+rih+MdA1wYcG32UNzfeggbm+T+S3onrXr3+cQvz22dcCsOsjMpp4D6yvN1+zRwvImP
         NFHD1u3J+OnFC97peaEzw4yXxkhPtYXnVOdbqYPkjIiLGOG4P8vz14GDagzyw1biYQGH
         MoRUnaO2nbZlHUWSQ9hw+4nq52dNaDpRdXTIOSBvxPbOP+ey3RYdRjgr85v4cPGUZxuR
         yTyjZlt1RryDjln88hLfDhN8Ol/or9mdDFRLlThOBY4wC7XNgfrC0gjjHr7wnhcBpABn
         0vcg==
X-Gm-Message-State: AOAM531oJNHqEIZlG0DaiFk/MjGpYZz2BeVCSXrvW4EBMFAwnwTmvzzs
        puT3JlZVZJSAIQk1ntvWGAxRxILgIJ8CqyYEgieQrg==
X-Google-Smtp-Source: ABdhPJzDiqFhaJ9bt/yP67o+J6KQ73XL1ZTWuzTYPGV04rVMqcr9vV3X3d3HUY+drwY6e2bxZDip4D+EAAPRLwe1t1s=
X-Received: by 2002:ac8:2f2c:: with SMTP id j41mr7064791qta.258.1598307164408;
 Mon, 24 Aug 2020 15:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200822030155.GA414063@google.com> <CAPhKKr_7Hz=+f+P1+1ZADw+4GEfH+oLbgO0UALFWEYwNxZg4qw@mail.gmail.com>
In-Reply-To: <CAPhKKr_7Hz=+f+P1+1ZADw+4GEfH+oLbgO0UALFWEYwNxZg4qw@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 24 Aug 2020 18:12:30 -0400
Message-ID: <CAJWu+ooxGD6SqnpjTxsxi4NRuDvb4OqRHFUd0mreYtaWTm1dSQ@mail.gmail.com>
Subject: Re: [RFC] Design proposal for upstream core-scheduling interface
To:     Dhaval Giani <dhaval.giani@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        JulienDesfossez@google.com,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Don <joshdon@google.com>, Xi Wang <xii@google.com>,
        Hao Luo <haoluo@google.com>,
        Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dhaval,

On Mon, Aug 24, 2020 at 3:50 PM Dhaval Giani <dhaval.giani@gmail.com> wrote:
>
> On Fri, Aug 21, 2020 at 8:01 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hello!
> > Core-scheduling aims to allow making it safe for more than 1 task that trust
> > each other to safely share hyperthreads within a CPU core [1]. This results
> > in a performance improvement for workloads that can benefit from using
> > hyperthreading safely while limiting core-sharing when it is not safe.
> >
> > Currently no universally agreed set of interface exists and companies have
> > been hacking up their own interface to make use of the patches. This post
> > aims to list usecases which I got after talking to various people at Google
> > and Oracle. After which actual development of code to add interfaces can follow.
> >
> > The below text uses the terms cookie and tag interchangeably. Further, cookie
> > of 0 is assumed to indicate a trusted process - such as kernel threads or
> > system daemons. By default, if nothing is tagged then everything is
> > considered trusted since the scheduler assumes all tasks are a match for each
> > other.
> >
> > Usecase 1: Google's cloud group tags CGroups with a 32-bit integer. This
> > int32 is split into 2 parts, the color and the id. The color can only be set
> > by privileged processes and the id can be set by anyone. The CGroup structure
> > looks like:
> >
> >    A         B
> >   / \      / \ \
> >  C   D    E  F  G
> >
> > Here A and B are container CGroups for 2 jobs are assigned a color by a
> > privileged daemon. The job itself has more sub-CGroups within (for ex, B has
> > E, F and G). When these sub-CGroups are spawned, they inherit the color from
> > the parent. An unprivileged user can then set an id for the sub-CGroup
> > without the knowledge of the privileged daemon if it desires to add further
> > isolation. This setting of id can be an unprivileged operation because the
> > root daemon has already isolated A and B.
> >
> > Usecase 2: Chrome browser - tagging renderers. In Chrome, each tab opened
> > spawns a renderer. A renderer is a sandboxed process and it is assumed it
> > could run arbitrary code (Javascript etc). When a renderer is created, a
> > prctl call is made to tag the renderer. Every thread that is spawned by the
> > renderer is also tagged. Essentially this turns SMT off for the renderer, but
> > still gives a performance boost due to privileged system threads being able
> > to share a core. The tagging also forbids the renderer from sharing a core
> > with privileged system processes. In the future, we plan to allow threads to
> > share a core as well (especially once we get syscall-isolation upstreamed.
> > Patches were posted recently for the same [2]).
> >
> > Usecase 3: ChromeOS VMs - each vCPU thread that is created by the VMM is
> > tagged thus disallowing core sharing between the vCPU thread and any other
> > thread on the system. This is because such VMs may run arbitrary user code
> > and attack both the guest and the host systems sharing the core.
> >
> > Usecase 4: Oracle - Setting a sub-CGroup as trusted (cookie 0). Chris Hyser
> > talked to me on IRC that in a CGroup hierarcy, some CGroups should be allowed
> > to not have to share its parent's CGroup tag. In fact, it should be allowed to
> > untag the child CGroup if needed thus allowing them to share a core with
> > trusted tasks. Others have had similar requirements.
> >
>
> Just to augment this. This doesn't necessarily need to be cgroup
> based. We do have a need where certain processes want to be tagged
> separately from others, which are in the same cgroup hierarchy. The
> standard mechanism for this is nested cgroups. With a unified
> hierarchy, and with cgroup tagging, I am unsure what this really
> means. Consider
>
> root
> |- A
>     |- A1
>     |- A2
>
> If A is tagged, can processes in A1 and A2 share a core? Should they
> share a core? In some cases we might be OK with them sharing cores
> just to get some of the performance back. Core scheduling really needs
> to be limited to just the processes that we want to protect.

Yeah this is exactly why Vineeth was suggesting separate FS without
nested hierarchies. The CGroupv2 unified hierarchy may be too
restrictive to pick and chose which nested or non-nested
sub-hierarchies want to share a core if the root of any (sub)hierarchy
is tagged. As mentioned in CGroup v2 documentation, someone thought it
is a good idea to kill the CGroup v1's non-unified flexibility so here
we are. Don't get me wrong, it has advantages but then the lack of
flexibility results in issues as these.  BTW,  there are other
usecases where CGroup v2 has shown to be inflexible at my employer.

The other option is a new system call to share a core between pid A
and pid B and the user can create arbitrary relationships as they
choose.

>
> > Proposal for tagging
> > --------------------
> > We have to support both CGroup and non-CGroup users. CGroup may be overkill
> > for some and the CGroup v2 unified hierarchy may be too inflexible.
> > Regardless, we must support CGroup due its easy of use and existing users.
> >
> > For Usecase #1
> > ----------
> > Usecase #1 requires a 2-level tagging mechanism. I propose 2 new files
> > to the CPU controller:
> > - tag : a boolean (0/1). If set, this CGroup and all sub-CGroups will be
> >   tagged.  (In the kernel, the cookie will be derived from the pointer value
> >   of a ref-counted cookie object.). If reset, then the CGroup will inherit
> >   the parent CGroup's cookie if there is one.
> >
> > - color : The ref-counted object will be aligned say to a 256-byte boundary
> >   (for example), then the lower 8 bits of the pointer can be used to specify
> >   color. Together, the pointer with the color will form a cookie used by the
> >   scheduler.
> >
> > Note that if 2 CGroups belong to 2 different tagged hierarchies, then setting
> > their color to be the same does not imply that the 2 groups will share a
> > core. This is key.
>
> Why? If I tag them the same, the expectation is they can share a core.
> As you set, the colour is set by a privileged process.

The color can be used along with 'tag' to provide a second-level of
isolation. So like, a container can decide to further create isolation
within itself, but the system daemon that creates the container need
not worry since the container is already isolated from other
containers, owing to the first-level of isolation via the tag file.

> > Also, to support usecase #4, we could add a third tag
> > value -- 2, along with the usual 0 and 1 to suggest that the CGroup can share
> > a core with cookie-0 tasks (Chris Hyser feel free to add any more comments
> > here).
>
> Would this not be the same as colour = null or something like that?

That could be done.

> > For Usecase #2
> > --------------
> > We could add an interface that Peter suggested where 2 PIDs A and B want to
> > share a core. So if A wants to share a core with B, then it issues
> > prctl(SET_CORE_SHARE, B). ptrace_may_access() can be used to restrict access.
> > For renderers though, we want to likely allow a renderer to share a core
> > exclusive with only threads within a renderer and no one else. To support
> > this, renderer A could simply issue prctl(SET_CORE_SHARE, A).
> >
> > For Usecase #3
> > --------------
> > By default, all threads within a process will share a core. This makes the
> > most sense because threads in a process share the same virtual address space.
> > However, for virtual machines in ChromeOS, we would like vCPU threads to not
> > share a core with other vCPU threads as mentioned above. To support this,
> > when a vCPU thread is forked, a new clone flag - CLONE_NEW_CORE_TAG could be
> > introduced to cause the forked thread to not share a core with its parent.
> > This could also support usecase #2 in the future (instead of prctl, a new
> > renderer being forked can simply be passed CLONE_NEW_CORE_TAG which will tag the
> > forked process or thread even if the forking process is not tagged).
> >
> > Other considerations:
> > - To share a core anyway even if tags don't match: If we assume that the only
> >   purpose of core-scheduling is to enforce security, then if the kernel knows
> >   that CPUs are not vulnerable then cores can be shared anyway, whether the
> >   tasks are tagged or not (Suggested-by PeterZ).
> >
>
> Who knows which CPUs are vulnerable or not? Is there a way to have a
> "paranoid" mode, where you don't trust the "vulnerable" list?

That's upto the arch right, I haven't dug too much into how this
works, but I know sysfs shows if a CPU has some vulnerabilities or not
such as if microcode is present to do flushing, or not.

> > - Addition of a new CGroup controller: Instead of CPU controller, it may be
> >   better to add a new CGroup controller in case the CPU controller is not
> >   attached to some parts of the hierarchy and it is still desirable to use
> >   CGroup interface for core tagging.
> >
>
> I agree with this. However, how will this work in a unified cgroup v2
> hierrachy is an open question for me. There are lots of questions
> about what happens with various interactions. Specifically as we start
> using nested cgroups. (Goes to take a tylenol to make head stop
> hurting)

Exactly. Consider my reply on the first para repeated here.

> > - Co-existence of CGroup with prctl/clone. The prctl/clone tagging should
> >   always be made to override CGroup. For this purpose, I propose a new
> >   'tasks_no_cg_tag' or a similar file in the CGroup controller. This file
> >   will list all tasks that don't associate with the CGroup's tag. NOTE: I am not
> >   sure yet how this new file will work with prctl/clone-tagging of individual
> >   threads in a non-thread-mode CGroup v2 usage.
> >
>
> Umm. I think this should follow the same semantics as for cpuset /
> taskset. cpuset is the group mechanism and taskset is the individual
> thread mechanism. If I were to reset it in the cgroup later on, it
> would be very confusing as to why a task did not get coloured the
> right way.

For cpuset, the cpuset rules and other mechanisms like
sched_setaffinity will obey it. I am not sure if that will make sense
for tagging though. Are you saying the prctl should fail to tag
something if cgroup has already tagged?

> > - Differences in tagging of a forked task (!CLONE_THREAD): If a process is
> >   a part of a CGroup and is forked, then the child process is automatically
> >   added to that CGroup. If such CGroup was tagged before, then the child is
> >   automatically tagged. However, it may be desired to give the child its own
> >   tag. In this case also, the earlier CLONE_NEW_CORE_TAG flag can be used to
> >   achieve this behavior. If the forking process was not a part of a CGroup
> >   but got a tag through other means before, then by default a !CLONE_THREAD
> >   fork would imply CLONE_NEW_CORE_TAG. However, to turns this off, a
> >   CLONE_CORE_TAG flag can be added (forking process's tag will be inheritted
> >   by the child).
> >
>
> I feel like the cgroup exceptions can be punted to another day. I have
> no objections to the forking mechanism outside cgroup though.

Yeah, this part of my email was just about how forking of a task in a
cgroup behaves wrt tagging. Since it gets a bit weird , I was
suggesting the use of earlier mentioned flags.

Thanks.
