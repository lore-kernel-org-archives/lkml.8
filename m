Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBACC2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CA320735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="ih91VCgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgDMPAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgDMPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:00:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D5DC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:00:42 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i3so9555855ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jy5m+JSS9axJA1aUUKOnEP/2vQVM4tf4Fj0Xx7p6asY=;
        b=ih91VCggyLJYHB7AGsZ6Y8UgWmptcPgtxL/1bWcQ8c/TQyLZQtdr2eutN35JVVwRre
         yrJAdJNp6g3V9UQYxxeVqx7oav9aXe1HtrKTcwzYIV44+WtEsy60H8kap/u1JGWJ/EyS
         n1BHb3Hu1G3mxgX2vzJoMzpj0AMXtCTu1uC8q+SnCVz3O4Z7nbYlE+Or/UvGoiaoqdDf
         BdRFU5b04t8W/+rM4BrcF+VITmOGwwbY2lGxYjMtixXJXXyjGaacOybrQNd/QmGnNxOz
         T4cfwAb6TiCcOvibfRFjYGrYGqFQHO4jTVNm4acIJZpOYOxpwI9zi7qtQL9A/Qh+MnMl
         OW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jy5m+JSS9axJA1aUUKOnEP/2vQVM4tf4Fj0Xx7p6asY=;
        b=d6keKedf2U/kTylbYZjodOEgfraXSYs70qZ0qa0iHaLQSWbdp25bLHdhLs5C0YCv+7
         VEnH6D1HLbSFk995kRwYr3fxhNWmNTEWFNiqF63bj9T0WI38DK+ZmOwv3Epl0SH1ZCjK
         keZ8FC6uJFw3wIEdSB59KqebMp/40x1+pKEoI42bQyTImEknaPW2Xva1IwNdDO85F4h6
         DQt8xlKRtPvx5+lfem3jmps8OqN36yzpvurHT7vvmEW6QnkXWVhcwr0pI5KZWsHLiqPg
         WyjYbfd5AvkyUVi1IFdWAleq2C4eJtDgq57/tpu5CKubHMq1dpgSlM/4feSD/YqxONJV
         IvZw==
X-Gm-Message-State: AGi0PuZfj/A8pmbYQaIxlwuKCUCFDYQS0jb4fl7IVrjbogycTzW0ujnG
        SOiA19OH85+RmF7lMddwLwd7BdRQzd3TI+f0QkXJjqiz7jRJsXpN
X-Google-Smtp-Source: APiQypJnvqVsqGf2509fS+CvuSUhzf5Rmrje0bxZeL6I5VgIZYAnEUO6Ygp01Sen4+8CSk4PHw9K6hMdtr/ZHTk9srQ=
X-Received: by 2002:a02:650f:: with SMTP id u15mr16677578jab.53.1586790041299;
 Mon, 13 Apr 2020 08:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200406121008.62903-1-songmuchun@bytedance.com> <xm26imico4wg.fsf@google.com>
In-Reply-To: <xm26imico4wg.fsf@google.com>
From:   =?UTF-8?B?5a6L54mn5pil?= <songmuchun@bytedance.com>
Date:   Mon, 13 Apr 2020 23:00:04 +0800
Message-ID: <CAMZfGtXjvKdKUVtNKWqLd01PATArMezumm+gX+edLXuRtQ6eiA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] sched/fair: Fix call walk_tg_tree_from()
 without hold rcu_lock
To:     Benjamin Segall <bsegall@google.com>, mingo@kernel.org,
        peterz@infradead.org, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 2:17 AM <bsegall@google.com> wrote:
>
> Muchun Song <songmuchun@bytedance.com> writes:
>
> > The walk_tg_tree_from() caller must hold rcu_lock, but the caller
> > do not call rcu_read_lock() in the unthrottle_cfs_rq(). The
> > unthrottle_cfs_rq() is used in 3 places. There are
> > distribute_cfs_runtime(), unthrottle_offline_cfs_rqs() and
> > tg_set_cfs_bandwidth(). The former 2 already hold the rcu lock,
> > but the last one does not. So fix it with calling rcu_read_lock()
> > in the unthrottle_cfs_rq().
>
> It might be a tiny bit better to put it in the tg_set_cfs_bandwidth
> instead, but the other two sources were kinda by accident, so this is
> reasonable too.
>
> Reviewed-by: Ben Segall <bsegall@google.com>
>
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  kernel/sched/fair.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6f05843c76d7d..870853c47b63c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4782,7 +4782,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >       raw_spin_unlock(&cfs_b->lock);
> >
> >       /* update hierarchical throttle state */
> > +     rcu_read_lock();
> >       walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
> > +     rcu_read_unlock();
> >
> >       if (!cfs_rq->load.weight)
> >               return;

Ping guys?

-- 
Yours,
Muchun
