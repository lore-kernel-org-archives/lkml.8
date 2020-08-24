Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE3DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914FD2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2v3mqTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHXTu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHXTu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:50:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95EAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 12:50:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so9569064wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cCM7PPSur5Wa86ipxp4yrwvV4Jg+pki/oGxjmYN8bM=;
        b=F2v3mqTD/C2wz/b4hZT4CdeaPH1Z5GqkgMyHs7zkcpwxkVuACJlRGWgNLnLzEXfblA
         CgZoSpegpo4eOU/TIX7PpO/z53eQPm6ujEJzzm8vwJ4kGb9KPa5OBvSgJKsL/rprQyJA
         zr9a775/+W6OOxqMZ6Um8fteIhvOVDS7S07UCJ+jB/8VQm4NwcfebEltquSJrEx/GnKc
         4OWjweLfZandKbojZ5EwpxSNi9bhblONK1ClCDbGhYeaHMyxWi0XtxiPSAkh2ZE2D04J
         U56Pdf9fXMdAq8oyQoUzYu24QEYoqjJ8tQCOLT2p6r4Knbw/Q79Puh5vj8N3QbzTLX6P
         5OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cCM7PPSur5Wa86ipxp4yrwvV4Jg+pki/oGxjmYN8bM=;
        b=amFcmgzMhhUn0e43lY9v2DG74sN63fl4uU+ZCRh796TeQMkmnOIWdxS1UtoT7VqY7m
         9wF/NEV2j4M53VJYcCoCjRjQPrqwO2Wz78117zaUw91BJayoRznksBGfVnmuDrmzgL/m
         Q4pPPED4uz5rlSe8zva4ki+jhQlNTW9KU3wd/xrohT3EDCNtwRIbk5f0DgpuAZbdUeZt
         Qzljo4jTNislvKzzQ4d+4KOb+KSUgVR16dqBuGuCX9kbcKs4YhnG0gP/xwMLz2qlj9U+
         5lhV9tebPgdmYd3IH7Z6dWAR/9KD7n2kiRRyOJQCyLk12Yk7w3Y7ALs4QgSalyN0/LXD
         gngg==
X-Gm-Message-State: AOAM530hIicH+wmGtULNOS/aTPi64dfEj81CrwiPgrOhFR1EZc6a1NuE
        PerDuAWkk9vqM+x70kdj0Lr7K1UgWNJj7T5ocxk=
X-Google-Smtp-Source: ABdhPJx+uikEK5VRC1mqvOhnPMid9Yj5npN28zfNA3Z248o+/lsjGeHFJwBFlH+6459sNJR15aWX/QUNT4ey8gWCAro=
X-Received: by 2002:a1c:63c4:: with SMTP id x187mr785782wmb.62.1598298624101;
 Mon, 24 Aug 2020 12:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200822030155.GA414063@google.com>
In-Reply-To: <20200822030155.GA414063@google.com>
From:   Dhaval Giani <dhaval.giani@gmail.com>
Date:   Mon, 24 Aug 2020 12:50:12 -0700
Message-ID: <CAPhKKr_7Hz=+f+P1+1ZADw+4GEfH+oLbgO0UALFWEYwNxZg4qw@mail.gmail.com>
Subject: Re: [RFC] Design proposal for upstream core-scheduling interface
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        JulienDesfossez@google.com,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>, paulmck@kernel.org,
        joshdon@google.com, xii@google.com, haoluo@google.com,
        Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:01 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hello!
> Core-scheduling aims to allow making it safe for more than 1 task that trust
> each other to safely share hyperthreads within a CPU core [1]. This results
> in a performance improvement for workloads that can benefit from using
> hyperthreading safely while limiting core-sharing when it is not safe.
>
> Currently no universally agreed set of interface exists and companies have
> been hacking up their own interface to make use of the patches. This post
> aims to list usecases which I got after talking to various people at Google
> and Oracle. After which actual development of code to add interfaces can follow.
>
> The below text uses the terms cookie and tag interchangeably. Further, cookie
> of 0 is assumed to indicate a trusted process - such as kernel threads or
> system daemons. By default, if nothing is tagged then everything is
> considered trusted since the scheduler assumes all tasks are a match for each
> other.
>
> Usecase 1: Google's cloud group tags CGroups with a 32-bit integer. This
> int32 is split into 2 parts, the color and the id. The color can only be set
> by privileged processes and the id can be set by anyone. The CGroup structure
> looks like:
>
>    A         B
>   / \      / \ \
>  C   D    E  F  G
>
> Here A and B are container CGroups for 2 jobs are assigned a color by a
> privileged daemon. The job itself has more sub-CGroups within (for ex, B has
> E, F and G). When these sub-CGroups are spawned, they inherit the color from
> the parent. An unprivileged user can then set an id for the sub-CGroup
> without the knowledge of the privileged daemon if it desires to add further
> isolation. This setting of id can be an unprivileged operation because the
> root daemon has already isolated A and B.
>
> Usecase 2: Chrome browser - tagging renderers. In Chrome, each tab opened
> spawns a renderer. A renderer is a sandboxed process and it is assumed it
> could run arbitrary code (Javascript etc). When a renderer is created, a
> prctl call is made to tag the renderer. Every thread that is spawned by the
> renderer is also tagged. Essentially this turns SMT off for the renderer, but
> still gives a performance boost due to privileged system threads being able
> to share a core. The tagging also forbids the renderer from sharing a core
> with privileged system processes. In the future, we plan to allow threads to
> share a core as well (especially once we get syscall-isolation upstreamed.
> Patches were posted recently for the same [2]).
>
> Usecase 3: ChromeOS VMs - each vCPU thread that is created by the VMM is
> tagged thus disallowing core sharing between the vCPU thread and any other
> thread on the system. This is because such VMs may run arbitrary user code
> and attack both the guest and the host systems sharing the core.
>
> Usecase 4: Oracle - Setting a sub-CGroup as trusted (cookie 0). Chris Hyser
> talked to me on IRC that in a CGroup hierarcy, some CGroups should be allowed
> to not have to share its parent's CGroup tag. In fact, it should be allowed to
> untag the child CGroup if needed thus allowing them to share a core with
> trusted tasks. Others have had similar requirements.
>

Just to augment this. This doesn't necessarily need to be cgroup
based. We do have a need where certain processes want to be tagged
separately from others, which are in the same cgroup hierarchy. The
standard mechanism for this is nested cgroups. With a unified
hierarchy, and with cgroup tagging, I am unsure what this really
means. Consider

root
|- A
    |- A1
    |- A2

If A is tagged, can processes in A1 and A2 share a core? Should they
share a core? In some cases we might be OK with them sharing cores
just to get some of the performance back. Core scheduling really needs
to be limited to just the processes that we want to protect.

> Proposal for tagging
> --------------------
> We have to support both CGroup and non-CGroup users. CGroup may be overkill
> for some and the CGroup v2 unified hierarchy may be too inflexible.
> Regardless, we must support CGroup due its easy of use and existing users.
>
> For Usecase #1
> ----------
> Usecase #1 requires a 2-level tagging mechanism. I propose 2 new files
> to the CPU controller:
> - tag : a boolean (0/1). If set, this CGroup and all sub-CGroups will be
>   tagged.  (In the kernel, the cookie will be derived from the pointer value
>   of a ref-counted cookie object.). If reset, then the CGroup will inherit
>   the parent CGroup's cookie if there is one.
>
> - color : The ref-counted object will be aligned say to a 256-byte boundary
>   (for example), then the lower 8 bits of the pointer can be used to specify
>   color. Together, the pointer with the color will form a cookie used by the
>   scheduler.
>
> Note that if 2 CGroups belong to 2 different tagged hierarchies, then setting
> their color to be the same does not imply that the 2 groups will share a
> core. This is key.

Why? If I tag them the same, the expectation is they can share a core.
As you set, the colour is set by a privileged process.

> Also, to support usecase #4, we could add a third tag
> value -- 2, along with the usual 0 and 1 to suggest that the CGroup can share
> a core with cookie-0 tasks (Chris Hyser feel free to add any more comments
> here).

Would this not be the same as colour = null or something like that?

>
> For Usecase #2
> --------------
> We could add an interface that Peter suggested where 2 PIDs A and B want to
> share a core. So if A wants to share a core with B, then it issues
> prctl(SET_CORE_SHARE, B). ptrace_may_access() can be used to restrict access.
> For renderers though, we want to likely allow a renderer to share a core
> exclusive with only threads within a renderer and no one else. To support
> this, renderer A could simply issue prctl(SET_CORE_SHARE, A).
>
> For Usecase #3
> --------------
> By default, all threads within a process will share a core. This makes the
> most sense because threads in a process share the same virtual address space.
> However, for virtual machines in ChromeOS, we would like vCPU threads to not
> share a core with other vCPU threads as mentioned above. To support this,
> when a vCPU thread is forked, a new clone flag - CLONE_NEW_CORE_TAG could be
> introduced to cause the forked thread to not share a core with its parent.
> This could also support usecase #2 in the future (instead of prctl, a new
> renderer being forked can simply be passed CLONE_NEW_CORE_TAG which will tag the
> forked process or thread even if the forking process is not tagged).
>
> Other considerations:
> - To share a core anyway even if tags don't match: If we assume that the only
>   purpose of core-scheduling is to enforce security, then if the kernel knows
>   that CPUs are not vulnerable then cores can be shared anyway, whether the
>   tasks are tagged or not (Suggested-by PeterZ).
>

Who knows which CPUs are vulnerable or not? Is there a way to have a
"paranoid" mode, where you don't trust the "vulnerable" list?

> - Addition of a new CGroup controller: Instead of CPU controller, it may be
>   better to add a new CGroup controller in case the CPU controller is not
>   attached to some parts of the hierarchy and it is still desirable to use
>   CGroup interface for core tagging.
>

I agree with this. However, how will this work in a unified cgroup v2
hierrachy is an open question for me. There are lots of questions
about what happens with various interactions. Specifically as we start
using nested cgroups. (Goes to take a tylenol to make head stop
hurting)

> - Co-existence of CGroup with prctl/clone. The prctl/clone tagging should
>   always be made to override CGroup. For this purpose, I propose a new
>   'tasks_no_cg_tag' or a similar file in the CGroup controller. This file
>   will list all tasks that don't associate with the CGroup's tag. NOTE: I am not
>   sure yet how this new file will work with prctl/clone-tagging of individual
>   threads in a non-thread-mode CGroup v2 usage.
>

Umm. I think this should follow the same semantics as for cpuset /
taskset. cpuset is the group mechanism and taskset is the individual
thread mechanism. If I were to reset it in the cgroup later on, it
would be very confusing as to why a task did not get coloured the
right way.

> - Differences in tagging of a forked task (!CLONE_THREAD): If a process is
>   a part of a CGroup and is forked, then the child process is automatically
>   added to that CGroup. If such CGroup was tagged before, then the child is
>   automatically tagged. However, it may be desired to give the child its own
>   tag. In this case also, the earlier CLONE_NEW_CORE_TAG flag can be used to
>   achieve this behavior. If the forking process was not a part of a CGroup
>   but got a tag through other means before, then by default a !CLONE_THREAD
>   fork would imply CLONE_NEW_CORE_TAG. However, to turns this off, a
>   CLONE_CORE_TAG flag can be added (forking process's tag will be inheritted
>   by the child).
>

I feel like the cgroup exceptions can be punted to another day. I have
no objections to the forking mechanism outside cgroup though.

Dhaval
