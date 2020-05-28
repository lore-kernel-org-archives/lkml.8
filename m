Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0714C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA332075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XQFqBpIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391297AbgE1Ovx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391291AbgE1Ovs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:51:48 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB59C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:51:48 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so227337qts.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DVKMB7bdx4hZdWJaPth0Vx4taU+rZZkkf4siI8dvSmE=;
        b=XQFqBpIaNh6PHNp0rq+EenGmA56ETfW4/J5dbXVPB6FWH6JO75BIqPYtnpMw5hETxW
         J5hMP0rUZ4km4nokM8dJ1Au1RrT0YMviuQdU7QJ1tK/jTo5E2pt2uVABYY6YSAjt32Fy
         ZdahfJ9h3F/IIKrfYainfEpjjnsd3FjeltAjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DVKMB7bdx4hZdWJaPth0Vx4taU+rZZkkf4siI8dvSmE=;
        b=DXDKliRq+XvkQ/fJ7mZS4KypJmpeyUvFXYVTt6Kf3vgnx8evvH4artMEQCBPz2ZMB3
         XrJL9xNUQi5ItLlCeKibfWfX1JIbq/Ww5iquXgD2qU9mc96JufXx/TATIbXAJJuCSr6r
         PWFSDT6Lqb/l6puPr0r9AIyJT80uKhxt9c3qIbzlCi526xme56SyWQ7abi8lFoWPcZ5F
         zp5zmlHuEDk1cXRYIHRgen2yHhaCdRwnp5oZaM8pKPQ7UwMbSujsgZvmJYHQJLP9ob+f
         pQp488dGCv4rZXEQXprc3X4ygGaVQX6WUIEZAr5Mn8KA0QaoaYmCIc028DuPSyxugisF
         AdnQ==
X-Gm-Message-State: AOAM533Z5zC3q1kXnwqpeSATysQYes8muuAh4HLj3NUMG1KrF5FcfNAv
        6ZsiySbCsIhkHNcUDZmKcZ9j3g==
X-Google-Smtp-Source: ABdhPJx2XClClB02Iu5WvE2CcVwldOmBz6jrXOf43clwhKn+xQ9M6IPvsQJecyS07tm1SFa8s9S59A==
X-Received: by 2002:ac8:2979:: with SMTP id z54mr3575361qtz.14.1590677507372;
        Thu, 28 May 2020 07:51:47 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j22sm4952261qke.117.2020.05.28.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:51:46 -0700 (PDT)
Date:   Thu, 28 May 2020 10:51:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, derkling@google.com
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling interface
Message-ID: <20200528145146.GB87103@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org>
 <20200521085122.GF325280@hirez.programming.kicks-ass.net>
 <20200521134705.GA140701@google.com>
 <20200522125905.GM325280@hirez.programming.kicks-ass.net>
 <20200522213524.GD213825@google.com>
 <20200524140046.GA5598@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524140046.GA5598@lorien.usersys.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 10:00:46AM -0400, Phil Auld wrote:
> On Fri, May 22, 2020 at 05:35:24PM -0400 Joel Fernandes wrote:
> > On Fri, May 22, 2020 at 02:59:05PM +0200, Peter Zijlstra wrote:
> > [..]
> > > > > It doens't allow tasks for form their own groups (by for example setting
> > > > > the key to that of another task).
> > > > 
> > > > So for this, I was thinking of making the prctl pass in an integer. And 0
> > > > would mean untagged. Does that sound good to you?
> > > 
> > > A TID, I think. If you pass your own TID, you tag yourself as
> > > not-sharing. If you tag yourself with another tasks's TID, you can do
> > > ptrace tests to see if you're allowed to observe their junk.
> > 
> > But that would require a bunch of tasks agreeing on which TID to tag with.
> > For example, if 2 tasks tag with each other's TID, then they would have
> > different tags and not share.
> > 
> > What's wrong with passing in an integer instead? In any case, we would do the
> > CAP_SYS_ADMIN check to limit who can do it.
> > 
> > Also, one thing CGroup interface allows is an external process to set the
> > cookie, so I am wondering if we should use sched_setattr(2) instead of, or in
> > addition to, the prctl(2). That way, we can drop the CGroup interface
> > completely. How do you feel about that?
> >
> 
> I think it should be an arbitrary 64bit value, in both interfaces to avoid
> any potential reuse security issues. 
> 
> I think the cgroup interface could be extended not to be a boolean but take
> the value. With 0 being untagged as now.
> 
> And sched_setattr could be used to set it on a per task basis.

Yeah, something like this will be needed.

> > > > More seriously, the reason I did it this way is the prctl-tagging is a bit
> > > > incompatible with CGroup tagging:
> > > > 
> > > > 1. What happens if 2 tasks are in a tagged CGroup and one of them changes
> > > > their cookie through prctl? Do they still remain in the tagged CGroup but are
> > > > now going to not trust each other? Do they get removed from the CGroup? This
> > > > is why I made the prctl fail with -EBUSY in such cases.

In util-clamp's design (which has task-specific attribute and task-group
attribute), it seems for that the priority is task-specific value first, then
the group one, then the system-wide one.

Perhaps a similar design can be adopted for this interface. So probably we
should let the per-task interface not fail if the task was already in CGroup
and rather prioritize its value first before looking at the group one?

Uclamp's comments:

 * The effective clamp bucket index of a task depends on, by increasing
 * priority:
 * - the task specific clamp value, when explicitly requested from userspace
 * - the task group effective clamp value, for tasks not either in the root
 *   group or in an autogroup
 * - the system default clamp value, defined by the sysadmin

> > > > 
> > > > 2. What happens if 2 tagged tasks with different cookies are added to a
> > > > tagged CGroup? Do we fail the addition of the tasks to the group, or do we
> > > > override their cookie (like I'm doing)?
> > > 
> > > For #2 I think I prefer failure.
> > > 
> > > But having the rationale spelled out in documentation (man-pages for
> > > example) is important.
> > 
> > If we drop the CGroup interface, this would avoid both #1 and #2.
> >
> 
> I believe both are useful.  Personally, I think the per-task setting should
> win over the cgroup tagging. In that case #1 just falls out.

Cool, this is similar to what I mentioned above.

> And #2 pretty
> much as well. Nothing would happen to the tagged task as they were added
> to the cgroup. They'd keep their explicitly assigned tags and everything
> should "just work". There are other reasons to be in a cpu cgroup together
> than just the core scheduling tag.

Well ok, so there's no reason to fail them the addition to CGroup of a
prctl-tagged task then, we can let it succeed but prioritize the
task-specific attribute over the group-specific one.

> There are a few other edge cases, like if you are in a cgroup, but have
> been tagged explicitly with sched_setattr and then get untagged (presumably
> by setting 0) do you get the cgroup tag or just stay untagged? I think based
> on per-task winning you'd stay untagged. I supposed you could move out and
> back in the cgroup to get the tag reapplied (Or maybe the cgroup interface
> could just be reused with the same value to re-tag everyone who's untagged).

If we maintain a task-specific tag and a group-specific tag, then I think
both tags can coexist and the final tag is decided on priority basis
mentioned above.

So before getting into CGroup, I think first we develop the task-specific
tagging mechanism like Peter was suggesting. So let us talk about that. I
will reply to the other thread Vineeth started while CC'ing you. In
particular, I like Peter's idea about user land passing a TID to share a core
with.

thanks,

 - Joel


> 
> 
> 
> Cheers,
> Phil
> 
> 
> > thanks,
> > 
> >  - Joel
> > 
> 
> -- 
> 
