Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0160207CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3lEsn2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgEVJka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgEVJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:40:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B003C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 02:40:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y18so4967026pfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KO+7XeLC6MB+qc6NKA+XaMM/cWkIpr+AjUjswagPQq4=;
        b=Y3lEsn2h+bkVBZdfY47jUAMze38ZyQvr+d1fRgje7JFkVzg3FnTyENFJ8sLX//qspZ
         rKvcgH6z0K0VrIH+mhNUmqTzN5hlU1sg/eouznJUKMObsSvUCx+5E57Yju5ZAvx3hZwq
         MTsxP4bkO79VYdECSfFqoZa9N9OcPQmp73iuS92Cd54jMdUxvE+Pap+niKbwS8h5WOd+
         fnPMOBoVHH8h7/TR40bsyc2iUGN3/f/1IsWWIa83gLpku2BXCMxQM9LQmj5AKS5xpRVl
         CKvdDMaWoXZ6oWYn+E1oDvWYxBDaIOyBFRMbrM3ANtLAenQ5G4m+3Byuz+0XZXdSWzVU
         +vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KO+7XeLC6MB+qc6NKA+XaMM/cWkIpr+AjUjswagPQq4=;
        b=AwRnMyYvoO2wn4dVsQrOc+ZRJveZ7qenJVqjoqszXZpa2g0I1wGOjxi9Wm/LnGQKsp
         QDI+w/gKE2JUMHoJoutEeYWFdoI9QVdufvzzg6RXOOQdDDTmv+aLMilGqOe5Y+YV8ksm
         /ZYMIzX/J//Qu4suVInxOY8+BSw1wQmJEMuqCyU6vIrd4Pn4tFIU0r8TSvmBC7+g3ioS
         x7nXeKzz/1lNYxkcCDKIK7elohLLFBTn10SDqMu+iCTL7TCtqWyEf/7HLPVOsz+eG+gb
         dMvsUCgsxkkmJZIcVkw9AauwpAj5IwC+LzhULlvA3BGLUAHgfKXU0z6GjVpfNvJyZJJg
         E1WA==
X-Gm-Message-State: AOAM532DyED7N6DCxW9dkmgXgbwT2gRh40o+bfyoWC9TNepqVo78kRjE
        naAxkuqtch0xYNyQRMPXb4U=
X-Google-Smtp-Source: ABdhPJzK7zrfgi4rFoaPZT4bWJlZAbAkvu8fv7tswZftWCj5Xne5/TRbXnrjgEoJ0mWtPdP1tdzUrA==
X-Received: by 2002:a62:e801:: with SMTP id c1mr3039197pfi.217.1590140428662;
        Fri, 22 May 2020 02:40:28 -0700 (PDT)
Received: from aaronlu-desktop ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id r2sm6645891pfq.194.2020.05.22.02.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 02:40:27 -0700 (PDT)
Date:   Fri, 22 May 2020 17:40:19 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH updated v2] sched/fair: core wide cfs task priority
 comparison
Message-ID: <20200522094019.GA8245@aaronlu-desktop>
References: <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop>
 <20200424142443.GA263207@aaronlu-desktop>
 <20200506143506.GH5298@hirez.programming.kicks-ass.net>
 <20200508084419.GA120223@aaronlu-desktop>
 <20200508090925.GV5298@hirez.programming.kicks-ass.net>
 <20200508123457.GA122180@aaronlu-desktop>
 <20200514130248.GD2940@hirez.programming.kicks-ass.net>
 <20200516034230.GA72980@aaronlu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516034230.GA72980@aaronlu-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 11:42:30AM +0800, Aaron Lu wrote:
> On Thu, May 14, 2020 at 03:02:48PM +0200, Peter Zijlstra wrote:
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4476,6 +4473,16 @@ next_class:;
> >  		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
> >  	}
> >  
> > +	/* XXX SMT2 only */
> > +	if (new_active == 1 && old_active > 1) {
> 
> There is a case when incompatible task appears but we failed to 'drop
> into single-rq mode' per the above condition check. The TLDR is: when
> there is a task that sits on the sibling rq with the same cookie as
> 'max', new_active will be 2 instead of 1 and that would cause us missing
> the chance to do a sync of core min_vruntime.

FWIW: when I disable the feature of running cookie_pick task on sibling
and thus enforce a strict single-rq mode, Peter's patch works well for
the scenario described below.

> This is how it happens:
> 1) 2 tasks of the same cgroup with different weight running on 2 siblings,
>    say cg0_A with weight 1024 bound at cpu0 and cg0_B with weight 2 bound
>    at cpu1(assume cpu0 and cpu1 are siblings);
> 2) Since new_active == 2, we didn't trigger min_vruntime sync. For
>    simplicity, let's assume both siblings' root cfs_rq's min_vruntime and
>    core_vruntime are all at 0 now;
> 3) let the two tasks run a while;
> 4) a new task cg1_C of another cgroup gets queued on cpu1. Since cpu1's
>    existing task has a very small weight, its cfs_rq's min_vruntime can
>    be much larger than cpu0's cfs_rq min_vruntime. So cg1_C's vruntime is
>    much larger than cg0_A's and the 'max' of the core wide task
>    selection goes to cg0_A;
> 5) Now I suppose we should drop into single-rq mode and by doing a sync
>    of core min_vruntime, cg1_C's turn shall come. But the problem is, our
>    current selection logic prefer not to waste CPU time so after decides
>    cg0_A as the 'max', the sibling will also do a cookie_pick() and
>    get cg0_B to run. This is where problem asises: new_active is 2
>    instead of the expected 1.
> 6) Due to we didn't do the sync of core min_vruntime, the newly queued
>    cg1_C shall wait a long time before cg0_A's vruntime catches up.

P.S. this is what I did to enforce a strict single-rq mode:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1fa5b48b742a..0f5580bc7e96 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4411,7 +4411,7 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 	    (!max || prio_less(max, class_pick)))
 		return class_pick;
 
-	return cookie_pick;
+	return NULL;
 }
 
 static struct task_struct *
