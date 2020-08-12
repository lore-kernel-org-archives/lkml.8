Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF2FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 23:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B742076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 23:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cED+jLi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHLXIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 19:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHLXIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 19:08:52 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DE9C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 16:08:52 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s23so2905205qtq.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 16:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O09p7FBmkSC5bGt4yJC6JUfHRS16trGW04HihAW61QI=;
        b=cED+jLi2wxGJ5jNf3hfzY7UYB1D/T5SPg+9q5PI0/A1zSo2s/2u6FnrlgbQ41nheam
         wV5sMRbfBT0j+hcks46gxh35qt7po6+sEYaUIiBCl7sK/YpOa4OaTwuDD7DYecBmP7+X
         mftXQ87YgNNWUpgepc752xesqMjItZAOsrejE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O09p7FBmkSC5bGt4yJC6JUfHRS16trGW04HihAW61QI=;
        b=thzE9gKZ4XaKj2dHb6KlF2zfi5zscAkp0ZnQw5FLv0EaoM04Zf454khk4uP0DK1HjH
         TPlNvc3tcufVlS3Mdzt1sUfKs8P8hSITqOfOj9OVYLURFvFu/ayeQez9J7wTqV8VR2GF
         YIUIHhkdHNfebFPZosJkZREHatUWGkoVYYNBNnA32FcEVsrf6ERrcU6rNmHsw4QFUSVl
         gJfvAH6he3LJZm4T6LGXQFrGXRJheIJHAInFOCisVAUPf7uDlwI+r/91matFBfdWaAlL
         vKKoziYYVeMEn6Ws4JWTsXKA4nQ1vG0bsHrDWzJwrDpLusvcIcXn4Q58Fw1EE2KyQ6XY
         30NQ==
X-Gm-Message-State: AOAM5334hU4YQGYydk86hXyq5TfDcn+GwA32JqSp8YjUgxQCxDhvZmNI
        44doRUcbnZmdU5cjFfUHi9Lm0Q==
X-Google-Smtp-Source: ABdhPJx7Qnn2THzxVwChuB1Pm240qxW2qSoUszK9W+Y1a3KYo3zz5BkQ9gGflr0TjO54oHPuDGBk7Q==
X-Received: by 2002:ac8:4256:: with SMTP id r22mr2228530qtm.367.1597273731097;
        Wed, 12 Aug 2020 16:08:51 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l45sm4407826qtf.11.2020.08.12.16.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 16:08:50 -0700 (PDT)
Date:   Wed, 12 Aug 2020 19:08:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     viremana@linux.microsoft.com,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
        =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
Subject: Re: [RFC PATCH 00/16] Core scheduling v6
Message-ID: <20200812230850.GA3511387@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
 <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
 <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
 <20200809164408.GA342447@google.com>
 <162a03cc-66c3-1999-83a2-deaad5aa04c8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162a03cc-66c3-1999-83a2-deaad5aa04c8@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:01:24AM +0800, Li, Aubrey wrote:
> Hi Joel,
> 
> On 2020/8/10 0:44, Joel Fernandes wrote:
> > Hi Aubrey,
> > 
> > Apologies for replying late as I was still looking into the details.
> > 
> > On Wed, Aug 05, 2020 at 11:57:20AM +0800, Li, Aubrey wrote:
> > [...]
> >> +/*
> >> + * Core scheduling policy:
> >> + * - CORE_SCHED_DISABLED: core scheduling is disabled.
> >> + * - CORE_COOKIE_MATCH: tasks with same cookie can run
> >> + *                     on the same core concurrently.
> >> + * - CORE_COOKIE_TRUST: trusted task can run with kernel
> >> 			thread on the same core concurrently. 
> >> + * - CORE_COOKIE_LONELY: tasks with cookie can run only
> >> + *                     with idle thread on the same core.
> >> + */
> >> +enum coresched_policy {
> >> +       CORE_SCHED_DISABLED,
> >> +       CORE_SCHED_COOKIE_MATCH,
> >> +	CORE_SCHED_COOKIE_TRUST,
> >> +       CORE_SCHED_COOKIE_LONELY,
> >> +};
> >>
> >> We can set policy to CORE_COOKIE_TRUST of uperf cgroup and fix this kind
> >> of performance regression. Not sure if this sounds attractive?
> > 
> > Instead of this, I think it can be something simpler IMHO:
> > 
> > 1. Consider all cookie-0 task as trusted. (Even right now, if you apply the
> >    core-scheduling patchset, such tasks will share a core and sniff on each
> >    other. So let us not pretend that such tasks are not trusted).
> > 
> > 2. All kernel threads and idle task would have a cookie 0 (so that will cover
> >    ksoftirqd reported in your original issue).
> > 
> > 3. Add a config option (CONFIG_SCHED_CORE_DEFAULT_TASKS_UNTRUSTED). Default
> >    enable it. Setting this option would tag all tasks that are forked from a
> >    cookie-0 task with their own cookie. Later on, such tasks can be added to
> >    a group. This cover's PeterZ's ask about having 'default untrusted').
> >    (Users like ChromeOS that don't want to userspace system processes to be
> >    tagged can disable this option so such tasks will be cookie-0).
> > 
> > 4. Allow prctl/cgroup interfaces to create groups of tasks and override the
> >    above behaviors.
> 
> How does uperf in a cgroup work with ksoftirqd? Are you suggesting I set uperf's
> cookie to be cookie-0 via prctl?

Yes, but let me try to understand better. There are 2 problems here I think:

1. ksoftirqd getting idled when HT is turned on, because uperf is sharing a
core with it: This should not be any worse than SMT OFF, because even SMT OFF
would also reduce ksoftirqd's CPU time just core sched is doing. Sure
core-scheduling adds some overhead with IPIs but such a huge drop of perf is
strange. Peter any thoughts on that?

2. Interface: To solve the performance problem, you are saying you want uperf
to share a core with ksoftirqd so that it is not forced into idle.  Why not
just keep uperf out of the cgroup? Then it will have cookie 0 and be able to
share core with kernel threads. About user-user isolation that you need, if
you tag any "untrusted" threads by adding it to CGroup, then there will
automatically isolated from uperf while allowing uperf to share CPU with
kernel threads.

Please let me know your thoughts and thanks,

 - Joel

> 
> Thanks,
> -Aubrey
> > 
> > 5. Document everything clearly so the semantics are clear both to the
> >    developers of core scheduling and to system administrators.
> > 
> > Note that, with the concept of "system trusted cookie", we can also do
> > optimizations like:
> > 1. Disable STIBP when switching into trusted tasks.
> > 2. Disable L1D flushing / verw stuff for L1TF/MDS issues, when switching into
> >    trusted tasks.
> > 
> > At least #1 seems to be biting enabling HT on ChromeOS right now, and one
> > other engineer requested I do something like #2 already.
> > 
> > Once we get full-syscall isolation working, threads belonging to a process
> > can also share a core so those can just share a core with the task-group
> > leader.
> > 
> >>> Is the uperf throughput worse with SMT+core-scheduling versus no-SMT ?
> >>
> >> This is a good question, from the data we measured by uperf,
> >> SMT+core-scheduling is 28.2% worse than no-SMT, :(
> > 
> > This is worrying for sure. :-(. We ought to debug/profile it more to see what
> > is causing the overhead. Me/Vineeth added it as a topic for LPC as well.
> > 
> > Any other thoughts from others on this?
> > 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> >>> thanks,
> >>>
> >>>  - Joel
> >>> PS: I am planning to write a patch behind a CONFIG option that tags
> >>> all processes (default untrusted) so everything gets a cookie which
> >>> some folks said was how they wanted (have a whitelist instead of
> >>> blacklist).
> >>>
> >>
> 
