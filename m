Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D411C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64422070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="dWaJ80zP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgGFOij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgGFOij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:38:39 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0F0C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:38:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n24so29586358otr.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+a5PAWxNUrsOAktzAQ6qcvhd13M9KTgN23TQirRmIs=;
        b=dWaJ80zPfhhaJj836zmKkqP/zu0PsIpU3iGbSXlYmvygnK2yTaYMTk/2Wk27a052Vc
         HYecdl6EIvToag7c/i4iUHldMygvRYUzHWQ/A3d5P+o+hKj+giIbOdbzgs2KAFFFc9pK
         Z2fdJ7cC3lSvGJQZYC80jXYt0oa/EVyOghHxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+a5PAWxNUrsOAktzAQ6qcvhd13M9KTgN23TQirRmIs=;
        b=KYLcJXqK3UgAsKCimzphby/SVWmlfL+SfYL9uF2nqxlgQHIEFF8u5cFkWK0wHS33lM
         zqyi9q9nZSrFgt5nXVM1FL1NiRtWBeAJzZHeO1zVAw853pgawNIP9ZSUVQJAv4gIn0wz
         3pw0uvDssCXDM3Cl7m0y2xn0u6NPA9NRyvgjm0X82VulqjyVCtZc91IjyC5oDmPnKbgG
         /Zq/xHkMABEBbcXoYBbH3i57SK1hX8eJs0eOcs64Fq4XxAtmFeyqsvImtoqAbHCEfwyv
         LanYKevHG8+0ToXkW05D/MJ+bPguCuE3sIY2iAATJRZDp0pGhL9j93CmgBbUDv18duDd
         jPRA==
X-Gm-Message-State: AOAM533/1f8rgxfeU0F72MEypQ1BT7kOJS2PbZIbVL4Oc39fk2pdcBY9
        qvbBKbHtB8sO8yTx2kuZLUR3QTF1u2YvgaTazITTbw==
X-Google-Smtp-Source: ABdhPJycpiCgK3gdl+8VGquCg9Gt2HU7NOoGbmnOlkzAUKFsob/6MVC5eFOO+YfO+GZ1r4eir9r0w8zZsXxPqhM0+HI=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr42238348otn.75.1594046317956;
 Mon, 06 Jul 2020 07:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <ed924e2cb450a4cce4a1b5a2c44d29e968467154.1593530334.git.vpillai@digitalocean.com>
 <20200701232847.GA439212@google.com> <CANaguZDtZrXbjmot2crLM0ComgY=NfqxWYs7GzUEY8aLeaUVrg@mail.gmail.com>
 <20200706140928.GA170866@google.com>
In-Reply-To: <20200706140928.GA170866@google.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Mon, 6 Jul 2020 10:38:27 -0400
Message-ID: <CANaguZAJk=yCGiiSh1y1gYYh_9ZfO94VT4vNjYjR_SY=_0ao-A@mail.gmail.com>
Subject: Re: [RFC PATCH 06/16] sched: Add core wide task selection and scheduling.
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
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
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 10:09 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > I am not sure if this can happen. If the other sibling sets core_pick, it
> > will be under the core wide lock and it should set the core_sched_seq also
> > before releasing the lock. So when this cpu tries, it would see the core_pick
> > before resetting it. Is this the same case you were mentioning? Sorry if I
> > misunderstood the case you mentioned..
>
> If you have a case where you have 3 siblings all trying to enter the schedule
> loop. Call them A, B and C.
>
> A picks something for B in core_pick. Now C comes and resets B's core_pick
> before running the mega-loop, hoping to select something for it shortly.
> However, C then does an unconstrained pick and forgets to set B's pick to
> something.
>
> I don't know if this can really happen - but this is why I added the warning
> in the end of the patch. I think we should make the code more robust and
> handle these kind of cases.
>
I don't think this can happen. Each of the sibling takes the core wide
lock before calling into pick_next _task. So this should not happen.

> Again, it is about making the code more robust. Why should not set
> rq->core_pick when we pick something? As we discussed in the private
> discussion - we should make the code robust and consistent. Correctness is
> not enough, the code has to be robust and maintainable.
>
> I think in our private discussion, you agreed with me that there is no harm
> in setting core_pick in this case.
>
I agreed there was no harm, because we wanted to use that in the last
check after 'done' label. But now I see that adding that check after
done label cause the WARN_ON to fire even in valid case. Firing the
WARN_ON in valid case is not good. So, if that WARN_ON check can be
removed, adding this is not necessary IMHO.

> > cpumask_copy(&select_mask, cpu_smt_mask(cpu));
> > if (unlikely(cpumask_test_cpu(cpu, &select_mask))) {
> >     cpumask_set_cpu(cpu, &select_mask);
> >     need_sync = false;
> > }
>
> Nah, more lines of code for no good no reason, plus another branch right? I'd
> like to leave my one liner alone than adding 4 more lines :-)
>
Remember, this is the fast path. Every schedule() except for our sync
IPI reaches here. And we are sure that smt_cpumask will not have cpu
only on hotplug cases which is very rare. I feel adding more code to
make it clear that this setting is not needed always and also optimizing for
the fast path is what I was looking for.

> > By setting need_sync to false, we will do an unconstrained pick and will
> > not sync with other siblings. I guess we need to reset need_sync after
> > or in the following for_each_cpu loop, because the loop may set it.
>
> I don't know if we want to add more conditions really and make it more
> confusing. If anything, I believe we should simplify the existing code more TBH.
>
I don't think its more confusing. This hotplug is really a rare case
and we should wrap it in a unlikely conditional IMHO. Comments can
make the reasoning more clear. We are saving two things here: one
is the always setting of cpu mask and second is the unnecessary syncing
of the siblings during hotplug.

> > I think we would not need these here. core_pick needs to be set only
> > for siblings if we are picking a task for them. For unconstrained pick,
> > we pick only for ourselves. Also, core_sched_seq need not be synced here.
> > We might already be synced with the existing core->core_pick_seq. Even
> > if it is not synced, I don't think it will cause an issue in subsequent
> > schedule events.
>
> As discussed both privately and above, there is no harm and it is good to
> keep the code consistent. I'd rather have any task picking set core_pick and
> core_sched_seq to prevent confusion.
>
> And if anything is resetting an existing ->core_pick of a sibling in the
> selection loop, it better set it to something sane.
>
As I mentioned, I was okay with this as you are using this down in the
WARN_ON check. But the WARN_ON check triggers even on valid cases which
is bad. I don't think setting this here will make code more robust IMHO.
core_pick is already NULL and I would like it to be that way unless there
is a compelling reason to set it. The reason is, we could find any bad
cases entering the pick condition above if this is NULL(it will crash).

> > >  done:
> > > +       /*
> > > +        * If we reset a sibling's core_pick, make sure that we picked a task
> > > +        * for it, this is because we might have reset it though it was set to
> > > +        * something by another selector. In this case we cannot leave it as
> > > +        * NULL and should have found something for it.
> > > +        */
> > > +       for_each_cpu(i, &select_mask) {
> > > +               WARN_ON_ONCE(!cpu_rq(i)->core_pick);
> > > +       }
> > > +
> > I think this check will not be true always. For unconstrained pick, we
> > do not pick tasks for siblings and hence do not set core_pick for them.
> > So this WARN_ON will fire for unconstrained pick. Easily reproducible
> > by creating an empty cgroup and tagging it. Then only unconstrained
> > picks will happen and this WARN_ON fires. I guess this check after the
> > done label does not hold and could be removed.
>
> As discussed above, > 2 SMT case, we don't really know if the warning will
> fire or not. I would rather keep the warning just in case for the future.
>
I think I was not clear last time. This WARN_ON will fire on valid cases
if you have this check here. As I mentioned unconstrained pick, picks only
for that cpu and not to any other siblings. This is by design. So for
unconstrained pick, core_pick of all siblings will be NULL. We jump to done
label on unconstrained pick and this for loop goes through all the siblings
and finds that its core_pick is not set. Then thei WARN_ON will fire. I have
reproduced this. We do not want it to fire as it is the correct logic not to
set core_pick for unconstrained pick. Please let me know if this is not clear.

Thanks,
Vineeth
