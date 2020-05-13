Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C1DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338E6205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ps4su1Y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbgEMSWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733175AbgEMSWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:22:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74AEC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:22:23 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n11so106028pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TMTeeS+qHfUDmCK6kT5bUDLfQ02N/DtNPUczs5Qvh9Y=;
        b=ps4su1Y/sPg4J5lnm7KmedPpbm358owUPg0jN1SMqblXFokdoITAi5ivYJBndbA/NG
         fQr9YUCLQRygYcvgkHzNzQvebo54ZEa8+ofeUXdH/P9eAzwzWe0USTn82ImD2e9wjKib
         0KJrcc/VE6eeLMiH74kumcfB5Wb9wodQOSGXZMVrkha6Zh5jPydL0l4quFkn8aatWPvy
         VEKmLvRLsy0VRUhYwlT3G9WnktoT8IXhym8UESNkOUx8Y/9pDS3CsoZFDlqbPkde6El7
         SVngf8/wEHdmfslheg1fBgE1hou0Q7EENlHDSAhNeS5HEOKczbJHgeTJ1VgS4f+wDxh7
         2ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=TMTeeS+qHfUDmCK6kT5bUDLfQ02N/DtNPUczs5Qvh9Y=;
        b=PdZGK+YeITOsbiWOzewi0X32chbG9qOvY4i9bdi1HgX+Arx+RVZr9vFSxbwWjR03/l
         12oNP3CH4erl1SGV3qbG+NF85SRb105Iy8uB6dWQyt7TWugDbNIEfXC7RIP1xNtm3AZN
         p8GG632Nvn87sx0OIYp2GBOoQh/yMDw8otg56uEKgsTkWYCEP0eOi+AEJVm1TnDCQ3Gi
         EX+PMlvaFON9AZ8dAcQhMDcWXPeNbOCt50JvSdGHiUtuuP+huKHCA813gtmAmZflEZu/
         IcXlJ3DpmQ+F2hRM6PI0EjJZnbxcmG8Bf8Zei8eKVgt6rMD41HPLojPG9orFQ7T/Sdcw
         r6jg==
X-Gm-Message-State: AOAM531vNgv3QNpm+H13sdQ+b+o2EVSrL9Wwgz3Z/Q+LYp69fwzqD/If
        p/8FZdboMmiiTYiqz3ioTsJCSwx7xPjsXw==
X-Google-Smtp-Source: ABdhPJyTaqwkqLpqR1pnqPvOM4D+Vlm7VGlllBAw5cXsvg93wK0Vd3MsAznG0Sci8zpB/D+kgeFi6g==
X-Received: by 2002:a63:3ec3:: with SMTP id l186mr555948pga.228.1589394142998;
        Wed, 13 May 2020 11:22:22 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id a23sm200519pfo.145.2020.05.13.11.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:22:19 -0700 (PDT)
From:   bsegall@google.com
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ben Segall <bsegall@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Tao Zhou <ouwen210@hotmail.com>
Subject: Re: [PATCH] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
References: <20200511191320.31854-1-vincent.guittot@linaro.org>
        <xm263685kmiv.fsf@google.com>
        <CAKfTPtBkJxjCxhDJUrz3aQ-3VKkC+kHTC1-4j+D2fWi7EtS+oA@mail.gmail.com>
Date:   Wed, 13 May 2020 11:22:18 -0700
In-Reply-To: <CAKfTPtBkJxjCxhDJUrz3aQ-3VKkC+kHTC1-4j+D2fWi7EtS+oA@mail.gmail.com>
        (Vincent Guittot's message of "Wed, 13 May 2020 09:11:13 +0200")
Message-ID: <xm26y2pvk84l.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guittot <vincent.guittot@linaro.org> writes:

> On Tue, 12 May 2020 at 20:59, <bsegall@google.com> wrote:
>>
>> Vincent Guittot <vincent.guittot@linaro.org> writes:
>>
>> > Although not exactly identical, unthrottle_cfs_rq() and enqueue_task_fair()
>> > are quite close and follow the same sequence for enqueuing an entity in the
>> > cfs hierarchy. Modify unthrottle_cfs_rq() to use the same pattern as
>> > enqueue_task_fair(). This fixes a problem already faced with the latter and
>> > add an optimization in the last for_each_sched_entity loop.
>> >
>> > Fixes: fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
>> > Reported-by Tao Zhou <zohooouoto@zoho.com.cn>
>> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> > ---
>> >
>> > This path applies on top of 20200507203612.GF19331@lorien.usersys.redhat.com
>> > and fixes similar problem for unthrottle_cfs_rq()
>> >
>> >  kernel/sched/fair.c | 37 ++++++++++++++++++++++++++++---------
>> >  1 file changed, 28 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index e2450c2e0747..4b73518aa25c 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -4803,26 +4803,44 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>> >       idle_task_delta = cfs_rq->idle_h_nr_running;
>> >       for_each_sched_entity(se) {
>> >               if (se->on_rq)
>> > -                     enqueue = 0;
>> > +                     break;
>> > +             cfs_rq = cfs_rq_of(se);
>> > +             enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
>> >
>> > +             cfs_rq->h_nr_running += task_delta;
>> > +             cfs_rq->idle_h_nr_running += idle_task_delta;
>> > +
>> > +             /* end evaluation on encountering a throttled cfs_rq */
>> > +             if (cfs_rq_throttled(cfs_rq))
>> > +                     goto unthrottle_throttle;
>> > +     }
>> > +
>> > +     for_each_sched_entity(se) {
>> >               cfs_rq = cfs_rq_of(se);
>> > -             if (enqueue) {
>> > -                     enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
>> > -             } else {
>> > -                     update_load_avg(cfs_rq, se, 0);
>> > -                     se_update_runnable(se);
>> > -             }
>> > +
>> > +             update_load_avg(cfs_rq, se, UPDATE_TG);
>> > +             se_update_runnable(se);
>> >
>> >               cfs_rq->h_nr_running += task_delta;
>> >               cfs_rq->idle_h_nr_running += idle_task_delta;
>> >
>> > +
>> > +             /* end evaluation on encountering a throttled cfs_rq */
>> >               if (cfs_rq_throttled(cfs_rq))
>> > -                     break;
>> > +                     goto unthrottle_throttle;
>> > +
>> > +             /*
>> > +              * One parent has been throttled and cfs_rq removed from the
>> > +              * list. Add it back to not break the leaf list.
>> > +              */
>> > +             if (throttled_hierarchy(cfs_rq))
>> > +                     list_add_leaf_cfs_rq(cfs_rq);
>> >       }
>> >
>> >       if (!se)
>>
>> The if is no longer necessary, unlike in enqueue, where the skip goto
>
> Yes. Good point
>
>> goes to this if statement rather than past (but enqueue could be changed
>> to match this). Also in general if we are making these loops absolutely
>
> There is a patch on mailing that skip the if statement. I'm going to
> update it to remove the if
>
>> identical we should probably pull them out to a common function (ideally
>> including the goto target and following loop as well).
>
> I tried that but was not convinced by the result which generated a lot
> of arguments. I didn't want to delay the fix for such cleanup but I
> will have a closer look after. Also the same kind identical sequence
> and clean up can be done with dequeue_task_fair and throtthle_cfs_rq.
> But Those don't have the problem we are fixing here
>
>>
>> >               add_nr_running(rq, task_delta);
>> >
>> > +unthrottle_throttle:
>> >       /*
>> >        * The cfs_rq_throttled() breaks in the above iteration can result in
>> >        * incomplete leaf list maintenance, resulting in triggering the
>> > @@ -4831,7 +4849,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>> >       for_each_sched_entity(se) {
>> >               cfs_rq = cfs_rq_of(se);
>> >
>> > -             list_add_leaf_cfs_rq(cfs_rq);
>> > +             if (list_add_leaf_cfs_rq(cfs_rq))
>> > +                     break;
>>
>> Do we also need to handle the case of tg_unthrottle_up followed by early exit
>> from unthrottle_cfs_rq? I do not have enough of an idea what
>> list_add_leaf_cfs_rq is doing to say.
>
> If you are speaking about the 'if (!cfs_rq->load.weight) return;"
> after walk_tg_tree_from(). I also thought it was needed but after more
> analyses, I concluded that if cfs_rq->load.weight == 0 , no child has
> been added in the leaf_cfs_rq_list in such case

Hmm, yes, if load.weight is 0 it should not have done anything there.

>
>
>>
>> >       }
>> >
>> >       assert_list_leaf_cfs_rq(rq);
