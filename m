Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD55C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C09206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="E0T+ouj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHIQoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIQoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 12:44:12 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B1C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 09:44:11 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so3147425qvo.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VtVUcbqA/O73EOSUUlMvyg/Az0u0gAuQ6qRQ4VdVDjQ=;
        b=E0T+ouj/gm9ezQDrznurtjO9fbYkBjs/PaHDBFowTFWpw9rPmyCLEWDZqz7S1GySXD
         5ro+pqAdWhINcPeN2Ytdd+yegA8c6hgg0FsaKN3fcLTnnvoennBckoBvMjJd/d2VaTPp
         PQDV0jMhgltAOS280vFGqyN4pimIjXvnWQKS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VtVUcbqA/O73EOSUUlMvyg/Az0u0gAuQ6qRQ4VdVDjQ=;
        b=OVrvzkLJAaA3mPVLHzqBQITlw4E3S+U2osNcGiGPJQZBj72NorWSjlHorljg4gyllP
         v5aiCnh5qpJrBvKZCDgBmtDDqY05rVB/cCNPNgsHyzx1iltZgWw2fEhxPWl6hUOF8SKb
         6Gch0birbj3ybUGYeg3ARJ+5RSImJfOSmnBYoke2LTXbQduCIx3mDi/QkT0ytxqvntQs
         HZfuiAXWdyuHF/tuUeS9m1bzYgW7elWcWsGg1f+2WzsLzU30iUoLnWEJYli1DJzVBYh/
         U6/3tSULMg+yByIBqm7H4ojZBHJwrQ6RpV2bCI+L6BpEqBh6VQrpiO8z9uGqf6IZxgeC
         F+Ww==
X-Gm-Message-State: AOAM531WNTXr//EUYNDMdVfHDYu6xifr7GdU+wj2DnK8SmMUqYvGNb8O
        5BWyegPGHLPR25biKLfQfjMICg==
X-Google-Smtp-Source: ABdhPJyKeHBg0TXoYIMgPREwAltlUPuvuVPjyksh8hkUKqC4pz0KNXpC2FrozeVyJDVjLUCBj2sw6g==
X-Received: by 2002:ad4:46ac:: with SMTP id br12mr24597161qvb.236.1596991450241;
        Sun, 09 Aug 2020 09:44:10 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id k1sm11778846qkf.12.2020.08.09.09.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:44:09 -0700 (PDT)
Date:   Sun, 9 Aug 2020 12:44:08 -0400
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
Message-ID: <20200809164408.GA342447@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
 <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
 <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aubrey,

Apologies for replying late as I was still looking into the details.

On Wed, Aug 05, 2020 at 11:57:20AM +0800, Li, Aubrey wrote:
[...]
> +/*
> + * Core scheduling policy:
> + * - CORE_SCHED_DISABLED: core scheduling is disabled.
> + * - CORE_COOKIE_MATCH: tasks with same cookie can run
> + *                     on the same core concurrently.
> + * - CORE_COOKIE_TRUST: trusted task can run with kernel
> 			thread on the same core concurrently. 
> + * - CORE_COOKIE_LONELY: tasks with cookie can run only
> + *                     with idle thread on the same core.
> + */
> +enum coresched_policy {
> +       CORE_SCHED_DISABLED,
> +       CORE_SCHED_COOKIE_MATCH,
> +	CORE_SCHED_COOKIE_TRUST,
> +       CORE_SCHED_COOKIE_LONELY,
> +};
> 
> We can set policy to CORE_COOKIE_TRUST of uperf cgroup and fix this kind
> of performance regression. Not sure if this sounds attractive?

Instead of this, I think it can be something simpler IMHO:

1. Consider all cookie-0 task as trusted. (Even right now, if you apply the
   core-scheduling patchset, such tasks will share a core and sniff on each
   other. So let us not pretend that such tasks are not trusted).

2. All kernel threads and idle task would have a cookie 0 (so that will cover
   ksoftirqd reported in your original issue).

3. Add a config option (CONFIG_SCHED_CORE_DEFAULT_TASKS_UNTRUSTED). Default
   enable it. Setting this option would tag all tasks that are forked from a
   cookie-0 task with their own cookie. Later on, such tasks can be added to
   a group. This cover's PeterZ's ask about having 'default untrusted').
   (Users like ChromeOS that don't want to userspace system processes to be
   tagged can disable this option so such tasks will be cookie-0).

4. Allow prctl/cgroup interfaces to create groups of tasks and override the
   above behaviors.

5. Document everything clearly so the semantics are clear both to the
   developers of core scheduling and to system administrators.

Note that, with the concept of "system trusted cookie", we can also do
optimizations like:
1. Disable STIBP when switching into trusted tasks.
2. Disable L1D flushing / verw stuff for L1TF/MDS issues, when switching into
   trusted tasks.

At least #1 seems to be biting enabling HT on ChromeOS right now, and one
other engineer requested I do something like #2 already.

Once we get full-syscall isolation working, threads belonging to a process
can also share a core so those can just share a core with the task-group
leader.

> > Is the uperf throughput worse with SMT+core-scheduling versus no-SMT ?
> 
> This is a good question, from the data we measured by uperf,
> SMT+core-scheduling is 28.2% worse than no-SMT, :(

This is worrying for sure. :-(. We ought to debug/profile it more to see what
is causing the overhead. Me/Vineeth added it as a topic for LPC as well.

Any other thoughts from others on this?

thanks,

 - Joel


> > thanks,
> > 
> >  - Joel
> > PS: I am planning to write a patch behind a CONFIG option that tags
> > all processes (default untrusted) so everything gets a cookie which
> > some folks said was how they wanted (have a whitelist instead of
> > blacklist).
> > 
> 
