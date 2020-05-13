Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B031CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518EA2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTGi3Stk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbgEMSZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389984AbgEMSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:25:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF6AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:25:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t11so125260pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g7U6aq5RgzQmHrGYBROYeMS0Va30d5oAriHP6zIA1V4=;
        b=oTGi3StkMpejRJZN1WFud+tiJxeCdWFHd4inApl0Rek7UC7vgbWXvcUYMQEQYyFid+
         s0wn1eGElHRqhxKEE53ISQumYsGXCPpSg2+XcPUaY3ZngSblIU6YcY8N5mvHRMxfHZ1w
         K/L/rasDZR3wG7zDI/D2zaylIHNxaZ3mUZS/lLeQVPjjhjuLdsh5jzOuBRkmqiMpG9QE
         QXgoByscALR0rw3372ZT2BDS2EwEzKX0zlPvk2hGPjA6AkRYhm7MHGJy346xDowOcY+x
         xrExd6GWASf2DxEakypjJoSYYhz1aHuHopi47YTovE1tEgK//9iwO+OjwhnU2xs4c8hf
         B0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=g7U6aq5RgzQmHrGYBROYeMS0Va30d5oAriHP6zIA1V4=;
        b=f/BkNWnU1YLBDfoIYIzYLvABafcDNMfu2hzS2BSFomt8cWIGeXMnBGHZf4GoxwOWiC
         pCPKXQku7B19Y0bpyJaL1hTQy94/sxs+yh5qo02T2S8yhUOiMGN6lFBTW6EDFGWrI6xW
         WCHiNaKd4z+geBMsFWEhK73Vlo97bRRSYCQ3coayP2eWtvOEp8NBmNCwTxbo7IAnHMQ5
         eNOhFfYhw0tiOmY+kh3b0zgtqBg/TFU6swPkhyPvPpg+HKeB89yyN0sIwIX6xBDdFXkD
         OOwkW640VbQ+XG3QJZLWuFHfcq9QOPh8k3Ri/dPjzH4dsMBVRXOXENzYLF3a6BFmraHJ
         hGcg==
X-Gm-Message-State: AOAM530ZAtxVLQfxY9GlmX8F5Tx7lAr6HYhty4MPgVKw4zXweGXJUlkg
        x0uWziocAItA2j4UUNkM16nwiA==
X-Google-Smtp-Source: ABdhPJyrqkXIx/2D3BJT4EbSsb+vn+P/hFzHptvpaX0sijS6eVaC7FWZXNcc4YEV9D3lzNQlvEp/3w==
X-Received: by 2002:a65:6694:: with SMTP id b20mr526467pgw.303.1589394333284;
        Wed, 13 May 2020 11:25:33 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id o25sm307904pgn.84.2020.05.13.11.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:25:32 -0700 (PDT)
From:   bsegall@google.com
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        ouwen210@hotmail.com, pkondeti@codeaurora.org
Subject: Re: [PATCH v3] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
References: <20200513135528.4742-1-vincent.guittot@linaro.org>
Date:   Wed, 13 May 2020 11:25:30 -0700
In-Reply-To: <20200513135528.4742-1-vincent.guittot@linaro.org> (Vincent
        Guittot's message of "Wed, 13 May 2020 15:55:28 +0200")
Message-ID: <xm26tv0jk7z9.fsf@google.com>
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
> Reported-by Tao Zhou <zohooouoto@zoho.com.cn>
> Reviewed-by: Phil Auld <pauld@redhat.com>

Reveiewed-by: Ben Segall <bsegall@google.com>

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>
> v3 changes:
>   - remove the unused enqueue variable
>
>  kernel/sched/fair.c | 42 ++++++++++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4e12ba882663..9a58874ef104 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4792,7 +4792,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	struct rq *rq = rq_of(cfs_rq);
>  	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
>  	struct sched_entity *se;
> -	int enqueue = 1;
>  	long task_delta, idle_task_delta;
>  
>  	se = cfs_rq->tg->se[cpu_of(rq)];
> @@ -4816,26 +4815,44 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
> -	if (!se)
> -		add_nr_running(rq, task_delta);
> +	/* At this point se is NULL and we are at root level*/
> +	add_nr_running(rq, task_delta);
>  
> +unthrottle_throttle:
>  	/*
>  	 * The cfs_rq_throttled() breaks in the above iteration can result in
>  	 * incomplete leaf list maintenance, resulting in triggering the
> @@ -4844,7 +4861,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
>  
> -		list_add_leaf_cfs_rq(cfs_rq);
> +		if (list_add_leaf_cfs_rq(cfs_rq))
> +			break;
>  	}
>  
>  	assert_list_leaf_cfs_rq(rq);
