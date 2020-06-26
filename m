Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD79C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE3E20706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="q0FhC1BI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgFZPKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgFZPKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:10:31 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1180C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:10:30 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id g11so4639710qvs.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e+rU3wQ+15Y5dUu7AZJ0biGdIOcHjZidZ4RqjjuYwPI=;
        b=q0FhC1BIGj/8iZjjNBXyZ8lw70iJ3bg0LsYd4RwM10Frn1+XlpAfKG5H6/oOK7c5mZ
         TOo45Yp55o5q+pz/BzGz8KlhI8ZdbaEjuVi4ybmtkIScvxXgsSsrayEhjRKt4LOndRPl
         tms0ueRUd6oiwE540fZ0D1CE9Lb1tVyX6B2Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+rU3wQ+15Y5dUu7AZJ0biGdIOcHjZidZ4RqjjuYwPI=;
        b=ZQmC53AxWhP4xQFYaby82mtj5MEG7inomd9Czvfcvd34z7Lp9khkGXWx5d887DtABt
         h6QxhX1WDocL/8MKQlVHneGSR3k8nEAB2HR8eL+GwfiyKQFrcjfuayrGeGTAndy7HbUD
         XcFlTwQerqE+GyiEu248Ra+mRIWClwlpJ55EBNrWxNi76Ch8OoMtQRWGp+eNntLHhcM6
         hqQbsu46xVHx8iAX7/mukHLDqh2c7iyg1VwgufOxmDRK2dp4CYmxWohLA3cFez3W5+my
         IiNvHDD5Qwu/YjYQKqSyOOCHrEpxLgQr+Li6Rr9h2nn7PADKhzrO+HZh5/e5mWieKinX
         wlmw==
X-Gm-Message-State: AOAM531b3+VpQU2nF4BvB9Z7QyymD704IYFumEQjP7Fa4kEf07OKz8k+
        l16989vuUiKUi/dlKUWOBcCVLg==
X-Google-Smtp-Source: ABdhPJyLOKHaIWEJ5QdVeug1CZZlpiFr9D7V3Q2MZI/mYnagEk3JA7qI0vO/UXzdyR5Bc+NMv8oARg==
X-Received: by 2002:a0c:e008:: with SMTP id j8mr59005qvk.87.1593184229767;
        Fri, 26 Jun 2020 08:10:29 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p128sm6729042qka.47.2020.06.26.08.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:10:29 -0700 (PDT)
Date:   Fri, 26 Jun 2020 11:10:28 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
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
        Paul Turner <pjt@google.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
Message-ID: <20200626151028.GA538235@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <CANaguZBQMarzMb-iXBEx8wJqkTYtRskTL+xQnShuAW7hP9UdqA@mail.gmail.com>
 <CAEXW_YSU5=ZUf-4j55av9Q8b+PRiM2DCKydM9Bv__mzL2MWx4g@mail.gmail.com>
 <CANaguZCi7Gj5TSUfU5AZ5w1v=EEz23rdgUsSg1NVb3DBM+F6bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZCi7Gj5TSUfU5AZ5w1v=EEz23rdgUsSg1NVb3DBM+F6bA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 10:36:01AM -0400, Vineeth Remanan Pillai wrote:
> On Thu, Jun 25, 2020 at 9:47 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Thu, Jun 25, 2020 at 4:12 PM Vineeth Remanan Pillai
> > <vpillai@digitalocean.com> wrote:
> > [...]
> > > TODO lists:
> > >
> > >  - Interface discussions could not come to a conclusion in v5 and hence would
> > >    like to restart the discussion and reach a consensus on it.
> > >    - https://lwn.net/ml/linux-kernel/20200520222642.70679-1-joel@joelfernandes.org
> >
> > Thanks Vineeth, just want to add: I have a revised implementation of
> > prctl(2) where you only pass a TID of a task you'd like to share a
> > core with (credit to Peter for the idea [1]) so we can make use of
> > ptrace_may_access() checks. I am currently finishing writing of
> > kselftests for this and post it all once it is ready.
> >
> Thinking more about it, using TID/PID for prctl(2) and internally
> using a task identifier to identify coresched group may have
> limitations. A coresched group can exist longer than the lifetime
> of a task and then there is a chance for that identifier to be
> reused by a newer task which may or maynot be a part of the same
> coresched group.

True, for the prctl(2) tagging (a task wanting to share core with
another) we will need some way of internally identifying groups which does
not depend on any value that can be reused for another purpose.

[..]
> What do you think about having a separate cgroup for coresched?
> Both coresched cgroup and prctl() could co-exist where prctl could
> be used to isolate individual process or task and coresched cgroup
> to group trusted processes.

This sounds like a fine idea to me. I wonder how Tejun and Peter feel about
having a new attribute-less CGroup controller for core-scheduling and just
use that for tagging. (No need to even have a tag file, just adding/removing
to/from CGroup will tag).

> > However a question: If using the prctl(2) on a CGroup tagged task, we
> > discussed in previous threads [2] to override the CGroup cookie such
> > that the task may not share a core with any of the tasks in its CGroup
> > anymore and I think Peter and Phil are Ok with.  My question though is
> > - would that not be confusing for anyone looking at the CGroup
> > filesystem's "tag" and "tasks" files?
> >
> Having a dedicated cgroup for coresched could solve this problem
> as well. "coresched.tasks" inside the cgroup hierarchy would list all
> the taskx in the group and prctl can override this and take it out
> of the group.

We don't even need coresched.tasks, just the existing 'tasks' of CGroups can
be used.

> > To resolve this, I am proposing to add a new CGroup file
> > 'tasks.coresched' to the CGroup, and this will only contain tasks that
> > were assigned cookies due to their CGroup residency. As soon as one
> > prctl(2)'s the task, it will stop showing up in the CGroup's
> > "tasks.coresched" file (unless of course it was requesting to
> > prctl-share a core with someone in its CGroup itself). Are folks Ok
> > with this solution?
> >
> As I mentioned above, IMHO cpu cgroups should not be used to account
> for core scheduling as well. Cpu cgroups serve a different purpose
> and overloading it with core scheduling would not be flexible and
> scalable. But if there is a consensus to move forward with cpu cgroups,
> adding this new file seems to be okay with me.

Yes, this is the problem. Many people use CPU controller CGroups already for
other purposes. In that case, tagging a CGroup would make all the entities in
the group be able to share a core, which may not always make sense. May be a
new CGroup controller is the answer (?).

thanks,

 - Joel

