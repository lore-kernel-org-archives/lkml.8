Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1D4C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9FC207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGoJQsVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgBTMPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:15:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39698 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgBTMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:15:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so3977373ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 04:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wX4V1UheDmuot5IRmUUdrVTof92dfeslHq15kYKoeNs=;
        b=PGoJQsVld646DIOjw+RVmY7+5kMlwWcOBw0HxjVGVVN0tjmUE8hCeUynGEMnYyKoK3
         jm66gNDG0UNlB4Zs+mFLmj3EAO1lEGTZI5DSIBuT6sNytZi9/sdxAQSCtNv1FFwx57cR
         dQms4/rZkhiDwKE+iUJzObH9HLid4inRr/mt+aSAfb2fg8+58iaMRc44qS3X5eUu4PaI
         SDpZ9P5xayOz5SE9QfK6JmZeJcaQ0NRPYw6qxXsZ0rdgTiaT3vTTfwl3FASlDYLjx/3x
         OScqVRl8Y4OEDUIzTgw7OAZP2I11q7jmy7oFHS3TT1M+aFRLz6/mnhFxME29MsouxiSz
         uzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wX4V1UheDmuot5IRmUUdrVTof92dfeslHq15kYKoeNs=;
        b=rJy8OuUfYuErxgMdO0zmG1xGz3cepB7n6Lz+BXe6zTvOKFnZGwU7hgLME1wruj/IdT
         vCIv2i9BBroh8A1SBAz3yXE9iLBKNMeAhA8fdvrLE5bp4JhumyXFeRMCxJu8qkVFR/7O
         zl3qrUNDbdo/8lxSoz3MZ9DsFKE043QZ6+mvFoWmtz3IJtxZyS8FrgoSWaP7arFJqUUc
         5+YcptXJfIaGHTIgq4a6A2BEzrgGaEgjcWr3AHYEU8pisj40QXDg92/oXa8/ZzxdiT3X
         SZ3NphFSwYoB64zhg5Y9y8p7pKj6qVa9YdcLGqQNxoSWF+LiPZDdcEuRNesCkCseujUm
         MkXQ==
X-Gm-Message-State: APjAAAVoDh9R/Dd/Qdrb1bg8cLGgy5qg7UTg3pv2AjNvPIThMn43njmM
        2JwvDdPZs4nvnG6HteEa5PrPv167xU6CRd/Hpw69hw==
X-Google-Smtp-Source: APXvYqz4yyofCR0lbXU6fCxkggfH0fVN79PIkCNRSUKFZerQxG1oJURlQH5QQ/DVH/+t3/wwiAHfaBCKbAYSOdIYlHw=
X-Received: by 2002:a2e:9596:: with SMTP id w22mr17671924ljh.21.1582200932224;
 Thu, 20 Feb 2020 04:15:32 -0800 (PST)
MIME-Version: 1.0
References: <1582183784-13502-1-git-send-email-qiwuchen55@gmail.com>
 <CAKfTPtDzb9XD5wrMhcvGn+dz27nh58taDrdp36YHKNusp739Og@mail.gmail.com>
 <20200220100915.GA14721@cqw-OptiPlex-7050> <CAKfTPtCm-Vn1YAC8j-XFLritQxQ-B7d=pqO9U6=c2vCuTNUpsg@mail.gmail.com>
In-Reply-To: <CAKfTPtCm-Vn1YAC8j-XFLritQxQ-B7d=pqO9U6=c2vCuTNUpsg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Feb 2020 13:15:20 +0100
Message-ID: <CAKfTPtBS=HhBvp2ps1SZXc--WoXO_ZOY=+5o7RJ9vDgi9eLAqA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: add !se->on_rq check before dequeue entity
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chenqiwu <chenqiwu@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 at 11:31, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 20 Feb 2020 at 11:09, chenqiwu <qiwuchen55@gmail.com> wrote:
> >
> > On Thu, Feb 20, 2020 at 10:38:02AM +0100, Vincent Guittot wrote:
> > > On Thu, 20 Feb 2020 at 08:29, <qiwuchen55@gmail.com> wrote:
> > > >
> > > > From: chenqiwu <chenqiwu@xiaomi.com>
> > > >
> > > > We igonre checking for !se->on_rq condition before dequeue one
> > > > entity from cfs rq. It must be required in case the entity has
> > > > been dequeued.
> > >
> > > Do you have a use case that triggers this situation ?
> > >
> > > This is the only way to reach this situation seems to be dequeuing a
> > > task on a throttled cfs_rq
> > >
> > Sorry, I have no use case triggers this situation. It's just found by
> > reading code.
> > I agree the situation you mentioned above may have a racy with
> > dequeue_task_fair() in the following code path:
> > __schedule
> >         pick_next_task_fair
> >                 put_prev_entity
> >                         check_cfs_rq_runtime
> >                                 throttle_cfs_rq
> >                                         dequeue_entity
> >
> > So this check is worth to be added for dequeue_task_fair().
>
> In fact the check is already done thanks to the: if (cfs_rq_throttled(cfs_rq))
> AFAICT, there is no other way to enqueue a task on a cfs_rq for which
> the group entity is not enqueued

Hmm i have been too quick in my reply. I wanted to say:
AFAICT, there is no other way to dequeue a task from a cfs_rq for
which the group entity is not enqueued
