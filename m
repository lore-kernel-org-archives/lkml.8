Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD8DCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D906820673
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1++C4FV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgELS7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELS7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:59:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4CAC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:59:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 145so6784130pfw.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r/7av/wBuBjyXx7XMiK2qASAvEvs+Io5wqGx7zancQ4=;
        b=V1++C4FVyDcfv1SYZmzbp9TLiQyj1wT0X9ityBNfvWRnkqClPrBhdh9ctbk4zgBPwJ
         uoi0I7y5hL6a3Q6z7f7KZT/6hcUdkqIQXFVT0P1xXa+89++fBBi+N0kpj8OJNTaXrsto
         xzxvs3wsCgFlVwvMs6Y0AAii1nsDaPw6hykj2X0h2OaGLNImRu77EaniqWQVSW3QWYiq
         qHooGpL0lmuYrMvamY1yWlkveRmiUOGJSezD+j6kYYQ/5O8FyTItttA4ViCNtyBVoIuX
         Fmi3OQPHkoOkjBSMPUWvOsbDeRS4cMW3l0g02KbOJMgEDw8wDCkmXpycIzEkKWPMJqDe
         FsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=r/7av/wBuBjyXx7XMiK2qASAvEvs+Io5wqGx7zancQ4=;
        b=cdgQhr1dlLPRuqSsl4adL1oto3f5De9VKAYrJO995nEdTvzLq3NeqPjJxsDN01M+TW
         zVGPOnJjjbeOhXQvP95wpbtVD7qzTMCbkXBzlitZyN0eO9jieOsA2uAYG+AFJEHCc3RE
         yl7DkGiMH6cz6aRO9tboo4VMEvdHI7lT2omFySjMYablH9HARs/udtXidLBv8JHPXKlW
         utRMtwXwz3j2tNslAFvacX9F+eRhh+cohHYE8tK5qs+4I4THLdlBPUiyM5Dvd9JsTxfZ
         40Zkry1mSaCb3odZ2sfUKKbYuxNOO2/1NQmVdnYNrs+ebh0m/tJqZijyXxrUv8lqG2q1
         L3GA==
X-Gm-Message-State: AGi0PubPbNQMl+nU7ds8L+Sg3COU2wCcF0FZ8IIpLeHtNZxazyakYzEL
        khRlmTJgknpIugKvfUqHMmjvpA==
X-Google-Smtp-Source: APiQypI3TWGOcHimb5sU+EUSVm2lmwS2z/UodeO0Bnn5EQBdhmVpNDVXP8XHE23pJbWh5gtxtL8Gaw==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr22497515pfh.150.1589309947986;
        Tue, 12 May 2020 11:59:07 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id q1sm3080218pfg.194.2020.05.12.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 11:59:06 -0700 (PDT)
From:   bsegall@google.com
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        ouwen210@hotmail.com
Subject: Re: [PATCH] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
References: <20200511191320.31854-1-vincent.guittot@linaro.org>
Date:   Tue, 12 May 2020 11:59:04 -0700
In-Reply-To: <20200511191320.31854-1-vincent.guittot@linaro.org> (Vincent
        Guittot's message of "Mon, 11 May 2020 21:13:20 +0200")
Message-ID: <xm263685kmiv.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guittot <vincent.guittot@linaro.org> writes:

> Although not exactly identical, unthrottle_cfs_rq() and enqueue_task_fair()
> are quite close and follow the same sequence for enqueuing an entity in the
> cfs hierarchy. Modify unthrottle_cfs_rq() to use the same pattern as
> enqueue_task_fair(). This fixes a problem already faced with the latter and
> add an optimization in the last for_each_sched_entity loop.
>
> Fixes: fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> Reported-by Tao Zhou <zohooouoto@zoho.com.cn>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>
> This path applies on top of 20200507203612.GF19331@lorien.usersys.redhat.com
> and fixes similar problem for unthrottle_cfs_rq()
>
>  kernel/sched/fair.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e2450c2e0747..4b73518aa25c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4803,26 +4803,44 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	idle_task_delta = cfs_rq->idle_h_nr_running;
>  	for_each_sched_entity(se) {
>  		if (se->on_rq)
> -			enqueue = 0;
> +			break;
> +		cfs_rq = cfs_rq_of(se);
> +		enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
>  
> +		cfs_rq->h_nr_running += task_delta;
> +		cfs_rq->idle_h_nr_running += idle_task_delta;
> +
> +		/* end evaluation on encountering a throttled cfs_rq */
> +		if (cfs_rq_throttled(cfs_rq))
> +			goto unthrottle_throttle;
> +	}
> +
> +	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
> -		if (enqueue) {
> -			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> -		} else {
> -			update_load_avg(cfs_rq, se, 0);
> -			se_update_runnable(se);
> -		}
> +
> +		update_load_avg(cfs_rq, se, UPDATE_TG);
> +		se_update_runnable(se);
>  
>  		cfs_rq->h_nr_running += task_delta;
>  		cfs_rq->idle_h_nr_running += idle_task_delta;
>  
> +
> +		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(cfs_rq))
> -			break;
> +			goto unthrottle_throttle;
> +
> +		/*
> +		 * One parent has been throttled and cfs_rq removed from the
> +		 * list. Add it back to not break the leaf list.
> +		 */
> +		if (throttled_hierarchy(cfs_rq))
> +			list_add_leaf_cfs_rq(cfs_rq);
>  	}
>  
>  	if (!se)

The if is no longer necessary, unlike in enqueue, where the skip goto
goes to this if statement rather than past (but enqueue could be changed
to match this). Also in general if we are making these loops absolutely
identical we should probably pull them out to a common function (ideally
including the goto target and following loop as well).

>  		add_nr_running(rq, task_delta);
>  
> +unthrottle_throttle:
>  	/*
>  	 * The cfs_rq_throttled() breaks in the above iteration can result in
>  	 * incomplete leaf list maintenance, resulting in triggering the
> @@ -4831,7 +4849,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
>  
> -		list_add_leaf_cfs_rq(cfs_rq);
> +		if (list_add_leaf_cfs_rq(cfs_rq))
> +			break;

Do we also need to handle the case of tg_unthrottle_up followed by early exit
from unthrottle_cfs_rq? I do not have enough of an idea what
list_add_leaf_cfs_rq is doing to say.

>  	}
>  
>  	assert_list_leaf_cfs_rq(rq);
