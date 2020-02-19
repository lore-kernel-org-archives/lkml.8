Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D28C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2362465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="INN9ZHKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgBSQ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:26:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36333 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSQ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:26:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so1026071ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 08:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAUIgzNVSjCaZCZcVDjF9RShTwUDVddbn/sJaXgNE8Q=;
        b=INN9ZHKLYkbuQDSc9NqdIbYEvtoq0e4O4ocezXGSkkhSbjDYYzOZCGAQohSP5zbdgz
         9G8r36hoOz6xjQ2NN3etzcC9G3WN1YULT4hS8bRbJZHCRRHjDlmIQufClyj4SzfjHYht
         Une46e/kNZwrEKhEgj1e9IVk7AsHp6pKIDTD4YnuRnOb4bbhl9KnGtmBpWz88ZYvTQMN
         PK7WasPJRSa0Mt9jPRgQnLPbDSsgf2zA3mgyKjzH+jTv86w0iEnl6mOMQTDfUI2PxnPJ
         2G5Q1AgcOeO+lqKkvctm2LfbjuE4GRFGOPopgeM7alpGtSQVSYd00pHZRAHespg56RJn
         znKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAUIgzNVSjCaZCZcVDjF9RShTwUDVddbn/sJaXgNE8Q=;
        b=Xdpzlo1ijSaamJzBvTX88hXKxx2lVKhBmYESGTD+Qkk2uqTxpB+3fdOpJl9UcD5TwW
         otYAelaHCNlhlEG/lzwbURq3s+NM+yAQeNWfF/dzNQLSa0XO/ZhBplLU14+iQ7vfxL7b
         ucIHo1IawPsbxNK0s6z/FJQEdaV4spQWOCC0oZb180LRhH9EfBXhVVyQc6xNhbafmpML
         uex8vNyaQil1/SCj39DI9sqeR6Q3fwV9p7eFAujJnSKWTYCas7sKD2zS82O52izMDUh0
         +q0JuSJtiAB+COZdyZyBQaIbhyKEcOkntOTX2lK6dN7YvFHffsyQKhRYN+Td0hiAFqz7
         Pw/g==
X-Gm-Message-State: APjAAAWeY1rvPioBOB9EkiU/SsjcA4rsPpguMsSX517PywDwFX0d2AS6
        bYoQadKkacGNESxBX5+d21BBMBSXDNqL7naNDXeBbg==
X-Google-Smtp-Source: APXvYqwd3Ij/qe0jrmbzLccktLVoAyjYRagZSX3FKkkwZZxk27y0FE1/6fm1cUOC+rsnWtGh1fCTbdK+7pgC73JF54Q=
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr16518252ljl.65.1582129582999;
 Wed, 19 Feb 2020 08:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-2-vincent.guittot@linaro.org> <ee38d205-b356-9474-785e-e514d81b7d7f@arm.com>
 <20200218132203.GB14914@hirez.programming.kicks-ass.net> <CAKfTPtB3qudK8aMq2cx==4RW8t1pz6ymz1Ti0r8oO4TefWzMRw@mail.gmail.com>
 <c18ab89e-d635-e370-6cbb-6015b404d906@arm.com>
In-Reply-To: <c18ab89e-d635-e370-6cbb-6015b404d906@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Feb 2020 17:26:11 +0100
Message-ID: <CAKfTPtCbHb2X30gNqNp5sukrg9U-hC6rvWC0dj8d1DawNL4D3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] sched/fair: Reorder enqueue/dequeue_task_fair path
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 at 12:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 18/02/2020 15:15, Vincent Guittot wrote:
> > On Tue, 18 Feb 2020 at 14:22, Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Tue, Feb 18, 2020 at 01:37:37PM +0100, Dietmar Eggemann wrote:
> >>> On 14/02/2020 16:27, Vincent Guittot wrote:
> >>>> The walk through the cgroup hierarchy during the enqueue/dequeue of a task
> >>>> is split in 2 distinct parts for throttled cfs_rq without any added value
> >>>> but making code less readable.
> >>>>
> >>>> Change the code ordering such that everything related to a cfs_rq
> >>>> (throttled or not) will be done in the same loop.
> >>>>
> >>>> In addition, the same steps ordering is used when updating a cfs_rq:
> >>>> - update_load_avg
> >>>> - update_cfs_group
> >>>> - update *h_nr_running
> >>>
> >>> Is this code change really necessary? You pay with two extra goto's. We
> >>> still have the two for_each_sched_entity(se)'s because of 'if
> >>> (se->on_rq); break;'.
> >>
> >> IIRC he relies on the presented ordering in patch #5 -- adding the
> >> running_avg metric.
> >
> > Yes, that's the main reason, updating load_avg before h_nr_running
>
> My hunch is you refer to the new function:
>
> static inline void se_update_runnable(struct sched_entity *se)
> {
>         if (!entity_is_task(se))
>                 se->runnable_weight = se->my_q->h_nr_running;
> }
>
> I don't see the dependency to the 'update_load_avg -> h_nr_running'
> order since it operates on se->my_q, not cfs_rq = cfs_rq_of(se), i.e.
> se->cfs_rq.
>
> What do I miss here?

update_load_avg() updates both se and cfs_rq so if you update
cfs_rq->h_nr_running before calling update_load_avg() like in the 2nd
for_each_sched_entity, you will update cfs_rq runnable_avg for the
past time slot with the new h_nr_running value instead of the previous
value.
