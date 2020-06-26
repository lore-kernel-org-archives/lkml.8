Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1565C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959F82070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="OEgzlI5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgFZOgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgFZOgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:36:13 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D9C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:36:13 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j11so5566944oiw.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKPvIuViYkr2Snan7oWb6BknUAQBFXZsGLcEJyjgN3s=;
        b=OEgzlI5w7/Up5VvvUIIK5acs7tyqKHfsHucS2tiBIbjbNA9tGmVQ0G73RqId/wf7CU
         EmTf3pfEWkOzFZZzsiZqGFcrxKmeoRQdLqdLhbePumjuaIBhusqSpRPYvkeHDueQA2ap
         CoUU8BrMyeRnnjGOtmfUBCHTmCFpAVj7vDbGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKPvIuViYkr2Snan7oWb6BknUAQBFXZsGLcEJyjgN3s=;
        b=gh1tS8q4N1trhCtfPRbKPTWlDqgeuBNt2XiNme9r3p2No+rbQ88tRwsLD3T+928WXw
         zUpbbj2eNumRrYDpRpMjiowDawVOXXdqrfhiWSHvAdzJMW1mFB+jo/18JhG+vqVTwKxt
         pFHMArxuEoN/mThf8KXUcJixDMhiCDs94+I/Ic0G6lC4ZMXw30dwitJlcyESh8u11KwQ
         rqShqvgMNspl73/ndkijqRSEyQ3ZBhzjHJI0LMKqIRlZAaV/owFvhYky6r26o0BxScwv
         b6zDPnkoxsi4/aAPpl0K8Q2fvwHxzxxLAYttIBfldWLJ63V3KTBX+fYtiUhE64xlgzJt
         Ryqg==
X-Gm-Message-State: AOAM531r4I2gVzuGEZheDwahYfLA5e0Xc1j77MpDH91mkijJg35W6dwq
        XZBPHHY+fuFSskrfXoey5H7lG7cV4Y3swcTk3C7elQ==
X-Google-Smtp-Source: ABdhPJyOzZ9+MiOD65tZJCRwesIrg1PbM5h6xkTNOvC0zBWcPQweL3siO0ruooLGdvTN9EK0UFKs1pI/QOHl8Zs0fyA=
X-Received: by 2002:a54:4d9b:: with SMTP id y27mr2572873oix.115.1593182172986;
 Fri, 26 Jun 2020 07:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <CANaguZBQMarzMb-iXBEx8wJqkTYtRskTL+xQnShuAW7hP9UdqA@mail.gmail.com> <CAEXW_YSU5=ZUf-4j55av9Q8b+PRiM2DCKydM9Bv__mzL2MWx4g@mail.gmail.com>
In-Reply-To: <CAEXW_YSU5=ZUf-4j55av9Q8b+PRiM2DCKydM9Bv__mzL2MWx4g@mail.gmail.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Fri, 26 Jun 2020 10:36:01 -0400
Message-ID: <CANaguZCi7Gj5TSUfU5AZ5w1v=EEz23rdgUsSg1NVb3DBM+F6bA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 9:47 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Jun 25, 2020 at 4:12 PM Vineeth Remanan Pillai
> <vpillai@digitalocean.com> wrote:
> [...]
> > TODO lists:
> >
> >  - Interface discussions could not come to a conclusion in v5 and hence would
> >    like to restart the discussion and reach a consensus on it.
> >    - https://lwn.net/ml/linux-kernel/20200520222642.70679-1-joel@joelfernandes.org
>
> Thanks Vineeth, just want to add: I have a revised implementation of
> prctl(2) where you only pass a TID of a task you'd like to share a
> core with (credit to Peter for the idea [1]) so we can make use of
> ptrace_may_access() checks. I am currently finishing writing of
> kselftests for this and post it all once it is ready.
>
Thinking more about it, using TID/PID for prctl(2) and internally
using a task identifier to identify coresched group may have
limitations. A coresched group can exist longer than the lifetime
of a task and then there is a chance for that identifier to be
reused by a newer task which may or maynot be a part of the same
coresched group.

A way to overcome this is to have a coresched group with a seperate
identifier implemented internally and have mapping from task to the
group. And cgroup framework provides exactly that.

I feel we could use prctl for isolating individual tasks/processes
and use grouping frameworks like cgroup for core scheduling groups.
Cpu cgroup might not be a good idea as it has its own purpose. Users
might not always want a group of trusted tasks in the same cpu cgroup.
Or all the processes in an existing cpu cgroup might not be mutually
trusted as well.

What do you think about having a separate cgroup for coresched?
Both coresched cgroup and prctl() could co-exist where prctl could
be used to isolate individual process or task and coresched cgroup
to group trusted processes.

> However a question: If using the prctl(2) on a CGroup tagged task, we
> discussed in previous threads [2] to override the CGroup cookie such
> that the task may not share a core with any of the tasks in its CGroup
> anymore and I think Peter and Phil are Ok with.  My question though is
> - would that not be confusing for anyone looking at the CGroup
> filesystem's "tag" and "tasks" files?
>
Having a dedicated cgroup for coresched could solve this problem
as well. "coresched.tasks" inside the cgroup hierarchy would list all
the taskx in the group and prctl can override this and take it out
of the group.

> To resolve this, I am proposing to add a new CGroup file
> 'tasks.coresched' to the CGroup, and this will only contain tasks that
> were assigned cookies due to their CGroup residency. As soon as one
> prctl(2)'s the task, it will stop showing up in the CGroup's
> "tasks.coresched" file (unless of course it was requesting to
> prctl-share a core with someone in its CGroup itself). Are folks Ok
> with this solution?
>
As I mentioned above, IMHO cpu cgroups should not be used to account
for core scheduling as well. Cpu cgroups serve a different purpose
and overloading it with core scheduling would not be flexible and
scalable. But if there is a consensus to move forward with cpu cgroups,
adding this new file seems to be okay with me.

Thoughts/suggestions/concerns?

Thanks,
Vineeth
