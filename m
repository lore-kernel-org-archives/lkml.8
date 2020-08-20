Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBD9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1528B2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="INF+mv1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgHTWhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgHTWhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:37:45 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47F1C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:37:44 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id o2so1706628qvk.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CQre410z5sGS8Rs1cXo97FI9t6nJ1f4yE8P5wfDuI3E=;
        b=INF+mv1REoCdw0hR7V1TQUVe8djNEFNRqO7Fk/1X0LPJpSk2T4VFBtqZlfq4PsVsXQ
         XPT194VPT9rjh0n0+D0pp4hTmQqpas7e5bRSMGzMo8ZoZaeTCGr66q8UZthljgqgN6GN
         8IZah/PjUSFKAfAlPN1YsRWr+UlB5KY2Xl+yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQre410z5sGS8Rs1cXo97FI9t6nJ1f4yE8P5wfDuI3E=;
        b=kw6dgEO8pwf/tg2J3AvF0owNh9Nni9XHd1ugpLP8HGA87LSbAuWrTfVxZRM4E1Q+mh
         6ZWGrWC9lJvS58W+xkQPbpQ4iB4bHKLMKGKDY0ygRMs+1njYkn1DkECGjhrq+sSPZwsb
         ShddfmadVsejfAyc/UAg7z5eQbBo3AJTUBuVVuZ7oECEUSbbgx8BRZrx91EBPtrGaAZn
         xYexADEeFUUxx4wg0tcQC2FC7N+yovtyoU3EkY8CQw6OgDMhuXmkRWv97LSwNnVlVwJg
         5Bwj6QtXftw/wO6JZhyolr/EJ0utWpccfyfgu5z9579d5XkId1aYRTnkkl34O3Q7JCRK
         WfMg==
X-Gm-Message-State: AOAM53054MtM+VVGdPSua/jWpEH3DW5dECNy+DazvdAQIvkJuz8Lv/ie
        mS3I1an543uphSsnO6g5zHDsow==
X-Google-Smtp-Source: ABdhPJwQkINpxQzpdGP+cBUv5yuLXHAc4op7hqcWZMHcS+6K/wnhhLtnw0HXoMXcPFLIw+zrFd1x4A==
X-Received: by 2002:a0c:bd0c:: with SMTP id m12mr1042717qvg.49.1597963063733;
        Thu, 20 Aug 2020 15:37:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id b23sm4371817qtp.41.2020.08.20.15.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:37:43 -0700 (PDT)
Date:   Thu, 20 Aug 2020 18:37:42 -0400
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
Message-ID: <20200820223742.GA120898@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
 <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
 <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
 <20200809164408.GA342447@google.com>
 <162a03cc-66c3-1999-83a2-deaad5aa04c8@linux.intel.com>
 <20200812230850.GA3511387@google.com>
 <5a39735d-dfd8-bdec-f068-81895799640e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a39735d-dfd8-bdec-f068-81895799640e@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 12:28:17PM +0800, Li, Aubrey wrote:
> On 2020/8/13 7:08, Joel Fernandes wrote:
> > On Wed, Aug 12, 2020 at 10:01:24AM +0800, Li, Aubrey wrote:
> >> Hi Joel,
> >>
> >> On 2020/8/10 0:44, Joel Fernandes wrote:
> >>> Hi Aubrey,
> >>>
> >>> Apologies for replying late as I was still looking into the details.
> >>>
> >>> On Wed, Aug 05, 2020 at 11:57:20AM +0800, Li, Aubrey wrote:
> >>> [...]
> >>>> +/*
> >>>> + * Core scheduling policy:
> >>>> + * - CORE_SCHED_DISABLED: core scheduling is disabled.
> >>>> + * - CORE_COOKIE_MATCH: tasks with same cookie can run
> >>>> + *                     on the same core concurrently.
> >>>> + * - CORE_COOKIE_TRUST: trusted task can run with kernel
> >>>> 			thread on the same core concurrently. 
> >>>> + * - CORE_COOKIE_LONELY: tasks with cookie can run only
> >>>> + *                     with idle thread on the same core.
> >>>> + */
> >>>> +enum coresched_policy {
> >>>> +       CORE_SCHED_DISABLED,
> >>>> +       CORE_SCHED_COOKIE_MATCH,
> >>>> +	CORE_SCHED_COOKIE_TRUST,
> >>>> +       CORE_SCHED_COOKIE_LONELY,
> >>>> +};
> >>>>
> >>>> We can set policy to CORE_COOKIE_TRUST of uperf cgroup and fix this kind
> >>>> of performance regression. Not sure if this sounds attractive?
> >>>
> >>> Instead of this, I think it can be something simpler IMHO:
> >>>
> >>> 1. Consider all cookie-0 task as trusted. (Even right now, if you apply the
> >>>    core-scheduling patchset, such tasks will share a core and sniff on each
> >>>    other. So let us not pretend that such tasks are not trusted).
> >>>
> >>> 2. All kernel threads and idle task would have a cookie 0 (so that will cover
> >>>    ksoftirqd reported in your original issue).
> >>>
> >>> 3. Add a config option (CONFIG_SCHED_CORE_DEFAULT_TASKS_UNTRUSTED). Default
> >>>    enable it. Setting this option would tag all tasks that are forked from a
> >>>    cookie-0 task with their own cookie. Later on, such tasks can be added to
> >>>    a group. This cover's PeterZ's ask about having 'default untrusted').
> >>>    (Users like ChromeOS that don't want to userspace system processes to be
> >>>    tagged can disable this option so such tasks will be cookie-0).
> >>>
> >>> 4. Allow prctl/cgroup interfaces to create groups of tasks and override the
> >>>    above behaviors.
> >>
> >> How does uperf in a cgroup work with ksoftirqd? Are you suggesting I set uperf's
> >> cookie to be cookie-0 via prctl?
> > 
> > Yes, but let me try to understand better. There are 2 problems here I think:
> > 
> > 1. ksoftirqd getting idled when HT is turned on, because uperf is sharing a
> > core with it: This should not be any worse than SMT OFF, because even SMT OFF
> > would also reduce ksoftirqd's CPU time just core sched is doing. Sure
> > core-scheduling adds some overhead with IPIs but such a huge drop of perf is
> > strange. Peter any thoughts on that?
> > 
> > 2. Interface: To solve the performance problem, you are saying you want uperf
> > to share a core with ksoftirqd so that it is not forced into idle.  Why not
> > just keep uperf out of the cgroup?
> 
> I guess this is unacceptable for who runs their apps in container and vm.

I think let us forget about #2, that's just a workaround.  #1 is probably
what we should look into for your problem. Was talking to Vineeth earlier, is
it possible that the fairness issues that Aaron and Peter are looking into is
causing the performance problem here?

So like, if ksoftirqd being higher prio is making the vruntime delta between
2 CFS tasks sharing a core to be quite high, then it causes the core-wide
min_vruntime to be high. Then if uperf gets enqueued, it will get starved by
ksoftirqd and not able to run till ksoftirqd's vruntime catches up.

Other than that, the only other thing (AFAIK) is the IPI/scheduler overhead
is giving uperf worse performance than SMT-off and we ought to reduce the
overhead some how. Does a kernel perf profile show you any smoking guns?

thanks,

 - Joel

> 
> Thanks,
> -Aubrey
> 
> > Then it will have cookie 0 and be able to
> > share core with kernel threads. About user-user isolation that you need, if
> > you tag any "untrusted" threads by adding it to CGroup, then there will
> > automatically isolated from uperf while allowing uperf to share CPU with
> > kernel threads.
> > 
> > Please let me know your thoughts and thanks,
> > 
> >  - Joel
> > 
> >>
> >> Thanks,
> >> -Aubrey
> >>>
> >>> 5. Document everything clearly so the semantics are clear both to the
> >>>    developers of core scheduling and to system administrators.
> >>>
> >>> Note that, with the concept of "system trusted cookie", we can also do
> >>> optimizations like:
> >>> 1. Disable STIBP when switching into trusted tasks.
> >>> 2. Disable L1D flushing / verw stuff for L1TF/MDS issues, when switching into
> >>>    trusted tasks.
> >>>
> >>> At least #1 seems to be biting enabling HT on ChromeOS right now, and one
> >>> other engineer requested I do something like #2 already.
> >>>
> >>> Once we get full-syscall isolation working, threads belonging to a process
> >>> can also share a core so those can just share a core with the task-group
> >>> leader.
> >>>
> >>>>> Is the uperf throughput worse with SMT+core-scheduling versus no-SMT ?
> >>>>
> >>>> This is a good question, from the data we measured by uperf,
> >>>> SMT+core-scheduling is 28.2% worse than no-SMT, :(
> >>>
> >>> This is worrying for sure. :-(. We ought to debug/profile it more to see what
> >>> is causing the overhead. Me/Vineeth added it as a topic for LPC as well.
> >>>
> >>> Any other thoughts from others on this?
> >>>
> >>> thanks,
> >>>
> >>>  - Joel
> >>>
> >>>
> >>>>> thanks,
> >>>>>
> >>>>>  - Joel
> >>>>> PS: I am planning to write a patch behind a CONFIG option that tags
> >>>>> all processes (default untrusted) so everything gets a cookie which
> >>>>> some folks said was how they wanted (have a whitelist instead of
> >>>>> blacklist).
> >>>>>
> >>>>
> >>
> 
