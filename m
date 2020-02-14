Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9F5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71876217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpD7Rej7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgBNHmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:42:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45099 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgBNHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:42:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so9564635ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQl2fPZWBUOHIJky2IPox4Wz8tIBDZoSHsVEhz1alas=;
        b=lpD7Rej7j7S4fMq0VFHkaElUJCXGDB+yxw+6cuJXsg2pP8PvXThNdaSQFzzH9R1ZRV
         pS57gIZ0dqAf5t5H7oT34k+C9HvI7Yu71H0mgoxmxLuXHueMhBmGANQprllh0/hvQ3C/
         A8Qr6KzLjqevDhWXtVW8eqhiRHvqLN6/qwHrU7x8eYlRAFkTgePbXzELZZU6Cz91o7dt
         nhD1N7M06E7qPZjG/JQNuFkomHzjngaCX8dXgysHHeKxdW2TW271HhsW6qZpcs+0JYXw
         2QfUyeoAZiviXWBC+8CcngCTMs1yOogavxp+LkWpvxb0gzYjiyNw/x5h8YD6jbuCPZk7
         pZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQl2fPZWBUOHIJky2IPox4Wz8tIBDZoSHsVEhz1alas=;
        b=kLfoRwoN7pFioBl0R6Fin1rtUX5b3baQ6ByoFRQ9bbsxaqaQYAyugc5d4vD48I2K3C
         ses3MqLDbP/ZFbzAEyFkuENM7XnLYYqSlYBemOHvTFImWYfxIBx+4a1nuXxhNSpWKMAi
         vaBbUlwCuioZoOyNJrUYqhP114byaZ+AaWkOzGbNkjscZ3XGPGzQqBoER7w0dGUk/+iC
         ADqy3zQ/2b5kQNi5LGLRaVORcZfuMLSwpKgq2/Tshc5GwBBBXkAo+jU2bqt3Kle9oMdq
         bpXb9swc3VRxGb6K8yskrd7p3q0ls3zACS9gAxyiXA9EgUslfGfp7AyC1gQdz1q7kHtR
         w4sA==
X-Gm-Message-State: APjAAAXW0ri6s+RouwgCYltMtXXNxqLLkvABs/zYPqYRzOTqvIcBOOyV
        H67zek7B3mvQAULyae3jU6w/kO49bpdLA+7i9rp/pw==
X-Google-Smtp-Source: APXvYqz9OqjMtqQuzymsD9U80WaSrSlfz6OVRbvRi0sEXEiFahyUJBWeLWjCwsm7cLHcyv/5Kw+CSqqcnDALbcZ1Oz8=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr1151449ljg.154.1581666169997;
 Thu, 13 Feb 2020 23:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-4-vincent.guittot@linaro.org> <20200212143023.GV3420@suse.de>
In-Reply-To: <20200212143023.GV3420@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 14 Feb 2020 08:42:38 +0100
Message-ID: <CAKfTPtCV1joNNrnpr-KFDhnDnJbzciUnXOneA=AyZnh4x8j=hQ@mail.gmail.com>
Subject: Re: [RFC 3/4] sched/fair: replace runnable load average by runnable average
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 at 15:30, Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Feb 11, 2020 at 06:46:50PM +0100, Vincent Guittot wrote:
> > Now that runnable_load_avg is not more used, we can replace it by a new
> > signal that will highlight the runnable pressure on a cfs_rq. This signal
> > track the waiting time of tasks on rq and can help to better define the
> > state of rqs.
> >
> > At now, only util_avg is used to define the state of a rq:
> >   A rq with more that around 80% of utilization and more than 1 tasks is
> >   considered as overloaded.
> >
> > But the util_avg signal of a rq can become temporaly low after that a task
> > migrated onto another rq which can bias the classification of the rq.
> >
> > When tasks compete for the same rq, their runnable average signal will be
> > higher than util_avg as it will include the waiting time and we can use
> > this signal to better classify cfs_rqs.
> >
> > The new runnable_avg will track the runnable time of a task which simply
> > adds the waiting time to the running time. The runnbale _avg of cfs_rq
> > will be the /Sum of se's runnable_avg and the runnable_avg of group entity
> > will follow the one of the rq similarly to util_avg.
> >
>
> s/runnbale/runnable/
>
> Otherwise, all I can do is give a heads-up that I will not be able to
> review this patch and the next patch properly in the short-term. While the
> new metric appears to have a sensible definition, I've not spent enough
> time comparing/contrasting the pro's and con's of PELT implementation
> details or their consequences. I am not confident I can accurately
> predict whether this is better or if there are corner cases that make
> poor placement decisions based on fast changes of runnable_avg. At least
> not within a reasonable amount of time.

ok. understood

>
> This caught my attention though
>
> > @@ -4065,8 +4018,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >        *   - Add its new weight to cfs_rq->load.weight
> >        */
> >       update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
> > +     se_update_runnable(se);
> >       update_cfs_group(se);
> > -     enqueue_runnable_load_avg(cfs_rq, se);
> >       account_entity_enqueue(cfs_rq, se);
> >
> >       if (flags & ENQUEUE_WAKEUP)
>
> I don't think the ordering matters any more because of what was removed
> from update_cfs_group. Unfortunately, I'm not 100% confident so am
> bringing it to your attention in case it does.

Yes. I have just tried to keep the same order with
se_update_runnable() just below update_load_avg() like for other
places

>
> --
> Mel Gorman
> SUSE Labs
