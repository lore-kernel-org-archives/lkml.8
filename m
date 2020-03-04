Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8391AC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA5622B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+Ps3L3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgCDRud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:50:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37537 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388403AbgCDRu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:50:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id q23so3018630ljm.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YanxhDNwSrOQ8EEY63icXGm0gGnIdDmC5NC1S8xKJaQ=;
        b=s+Ps3L3aloOq7/NilQpwIe3UQ0kxFVT7tQEak79iSy5xKTVd9hDlCq0Ylq5ZOF1CBI
         cFVEjLyQC7pecWUzFANZ7gTSxz5Th66Kay3SzBvtcDIabWc7byndjvriOuRJV6P2pvrs
         /BnMCaNQUFFiYBKS3+imIwgztiNDjeROsE7gZzQL7DspM4BJGNbSR0cQOoebaTt6Wfy9
         waDR6Ul7ceU+uK4G5vrjuB6bF/ykHRbjvxtUnAdAjmHwy3Z6DVgLogeF0PcpkXgy2zXK
         7WyP1DzBpOurb4KTvWDQNitWI7gFtfbNCy4XOLT1JKUu3GmYQwrr4yd1M7h1HUCkvxm3
         d0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YanxhDNwSrOQ8EEY63icXGm0gGnIdDmC5NC1S8xKJaQ=;
        b=VGzLBJJ1eBVt3zgQ6ftdgSpaJvkvQVx4fAEm4pslGtqAF6sPZ54PqP3mDn9EuTk3UL
         ko/tz3Mdb+enCnH/nBIzOEAFDeP5An1EXe9pPgM0wOrCev5U26q5SJ/QA3F5TjCrPpEF
         AvRaj2G2Fl6n2zghSf1K3gYeij36VpB25uL6jW1YMt88F5SlsHgsqu9+0td1nlmcJyQs
         79fOQhf7p4J2Q9jWNtzUgRqcDr2v+CcsTt0QswufxF8FPzJgjaees75VdWJ51wjbbDXX
         ZOQh3Ew8F8j9uFm7DkcAoOl0koUyIrYiC5Hz1UfsSW/g39NOauMk+Se3MLNwEj+ekRdF
         ioug==
X-Gm-Message-State: ANhLgQ1kjb8Vft4Iazg272NhEx/rqGRRz5sXITXqgn7bjld6SyzCHWfj
        /DQFlwXlH9P3gDphC8P14KkmILxdWy3yy1oo3l0nyg==
X-Google-Smtp-Source: ADFU+vugR28AJaRLbZ4M2FnsU/0hysorMlPynp1fbMwBBqDBNVDfKBAUmVQdVEzs3kaemubGGVLU2X1ioHfnquWHVJc=
X-Received: by 2002:a2e:8546:: with SMTP id u6mr27796ljj.21.1583344227317;
 Wed, 04 Mar 2020 09:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20200304151748.26135-1-vincent.guittot@linaro.org>
In-Reply-To: <20200304151748.26135-1-vincent.guittot@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Mar 2020 18:50:14 +0100
Message-ID: <CAKfTPtBDeTg0MEsazrtNRObL9nC2wjZTwo944kjZ7O8H0-n4nQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair : fix reordering of enqueue_task_fair
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>, Tao Zhou <zhout@vivaldi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 16:17, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> Even when a cgroup is throttled, the group se of a child cgroup can still
> be enqueued and its gse->on_rq stays true. When a task is enqueued on such
> child, we still have to update the load_avg and increase h_nr_running of
> the throttled cfs. Nevertheless, the 1st for_each_sched_entity loop is
> skipped because of gse->on_rq == true and the 2nd loop because the cfs is
> throttled whereas we have to update both load_avg with the old
> h_nr_running and increment h_nr_running in such case.
>
> Note that the update of load_avg will effectively happen only once in order
> to sync with the throttled time. Next call for updating load_avg will stop
> early because the clock stays unchanged.
>
> Fixes: 6d4d22468dae ("sched/fair: Reorder enqueue/dequeue_task_fair path")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Please ignore this patch, it's not enough to fix all cases


>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fcc968669aea..22d827fc46c3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5432,7 +5432,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 cfs_rq = cfs_rq_of(se);
>
>                 /* end evaluation on encountering a throttled cfs_rq */
> -               if (cfs_rq_throttled(cfs_rq))
> +               if (!se->on_rq && cfs_rq_throttled(cfs_rq))
>                         goto enqueue_throttle;
>
>                 update_load_avg(cfs_rq, se, UPDATE_TG);
> --
> 2.17.1
>
