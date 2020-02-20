Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E4CC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462A724672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L95S4k+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBTKbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:31:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41603 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgBTKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:31:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so3643559ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ombemeBuSWqa0cr6v8Icg8IDYVOYL7pKXjeA/5N6FzM=;
        b=L95S4k+QmoSueLaeSj3bsP8Cf9yA01n5JDC8JpELKhHbDR5xkkjjQXDe/+1HONIaFl
         Fi6PRFHV9ZVoVQ8DbMN/wxni9kBThoUZHw24GGeLFgb6snambZACeGM+7CL8jKN5mjNu
         lPj0MSeii4XJyQZ1u67d3k+oQbu6pCLeg4IOsg79YT67xMHBePNJOA9c84JG/u48v5UO
         ksl0v0Qt3Nh94vIrrxmb/d/4HLJhciaCUpwqC4Rsqv+PVYQs2LM6LhchzrHdEjY9ZueJ
         rvtzi38RZbbgefIiFJY7xWnK1R7h1yY6xIpdwDSFXj89ivGg36M4QSYlPxevKS5KGI8T
         Q3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ombemeBuSWqa0cr6v8Icg8IDYVOYL7pKXjeA/5N6FzM=;
        b=eCjCfSO4Iwfvu8kAvFQ9AO88gXYWWhtkQeKWu3ssh/ATVai2fY3lWvRwzqI7zOwvq9
         1v0VWDeYTwuPbJRxU6C8+N4z13aZHNsCreQFKwqS1mRj9v0zEK2F9cldtBR1ZFqdorh6
         Xr1AwHS9axp9ljyFvUHrQqQL06UpVAw2L4flfATRY7+vSUqVd282Tm6PS5VwOVRnJWjD
         m2abfv1Hj9oV8coE/wR9E1Y109X06/SakMT+CPo7skJePmjZ+wjKKzZZ1fsr8i2phlr0
         XTAxhbBcPrsdMwtgRhqDE/zKnxBbKD2uMgy05NM/NjwH9gWHua9OPlVD4ZBdmZULlCc2
         iyEA==
X-Gm-Message-State: APjAAAUXWPyoU28Qjogbfcv5VjXJZlrvdES2biLlMzhbfZ3OTySe9W8F
        /3Dft7ff/APdwIK/rKYESLeZiam7ddE8589caXEL0Q==
X-Google-Smtp-Source: APXvYqwnkhN82t7bmsO6FQeHCgOkS46PlgZ3YUcENV9JCtgDVFgH3zadu7vOARUTzKxgvF5miRfOu5+vUG+6DG8dTMI=
X-Received: by 2002:a2e:8699:: with SMTP id l25mr17761213lji.137.1582194695210;
 Thu, 20 Feb 2020 02:31:35 -0800 (PST)
MIME-Version: 1.0
References: <1582183784-13502-1-git-send-email-qiwuchen55@gmail.com>
 <CAKfTPtDzb9XD5wrMhcvGn+dz27nh58taDrdp36YHKNusp739Og@mail.gmail.com> <20200220100915.GA14721@cqw-OptiPlex-7050>
In-Reply-To: <20200220100915.GA14721@cqw-OptiPlex-7050>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Feb 2020 11:31:23 +0100
Message-ID: <CAKfTPtCm-Vn1YAC8j-XFLritQxQ-B7d=pqO9U6=c2vCuTNUpsg@mail.gmail.com>
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

On Thu, 20 Feb 2020 at 11:09, chenqiwu <qiwuchen55@gmail.com> wrote:
>
> On Thu, Feb 20, 2020 at 10:38:02AM +0100, Vincent Guittot wrote:
> > On Thu, 20 Feb 2020 at 08:29, <qiwuchen55@gmail.com> wrote:
> > >
> > > From: chenqiwu <chenqiwu@xiaomi.com>
> > >
> > > We igonre checking for !se->on_rq condition before dequeue one
> > > entity from cfs rq. It must be required in case the entity has
> > > been dequeued.
> >
> > Do you have a use case that triggers this situation ?
> >
> > This is the only way to reach this situation seems to be dequeuing a
> > task on a throttled cfs_rq
> >
> Sorry, I have no use case triggers this situation. It's just found by
> reading code.
> I agree the situation you mentioned above may have a racy with
> dequeue_task_fair() in the following code path:
> __schedule
>         pick_next_task_fair
>                 put_prev_entity
>                         check_cfs_rq_runtime
>                                 throttle_cfs_rq
>                                         dequeue_entity
>
> So this check is worth to be added for dequeue_task_fair().

In fact the check is already done thanks to the: if (cfs_rq_throttled(cfs_rq))
AFAICT, there is no other way to enqueue a task on a cfs_rq for which
the group entity is not enqueued
