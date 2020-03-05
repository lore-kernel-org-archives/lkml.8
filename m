Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF74C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C2A20726
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhJu0NM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCESjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:39:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37364 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgCESjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:39:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so3179466pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sw2rwPmYk39Rql13/D5MwH/TM4ln6aLBcc4RXpyiuv0=;
        b=bhJu0NM03saYyYog8nkfx4KBFaAqwgBKfGTqEl8Q911knPHjD9sFKnMdIkuJTPprBp
         TRtYH2dIdbh/HLDNRuGbrut8QH9JDd3013inySC6sd2m8oBlegn/SfNMZth9YxnRUG2G
         HEMuUQx7VRlgKxfLVW/ABEBUHDg15YVlPYTQJJhu2be7PEYOp70gXhEftcsG6CtO1vEb
         coufMtzGW2PbRbg8YbwooRqIUdP5GpsWPikLMICpXIUaeGL3JyrBqjfLur+gCPOBPIB0
         pke9Kd/uiA5hYkLA8JB6UtY5iIqOIZGAqkPhQUEfliL1Xa+Du73L99N6Yfu/mXykQoMA
         CILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=sw2rwPmYk39Rql13/D5MwH/TM4ln6aLBcc4RXpyiuv0=;
        b=RGDVQOIWtIpWUm6VPxV00sbigjzr8nyCfUwHEzFWnqFoBJ54Za+a+Y5QvWYfw83GmX
         k3Yjf2gRXVCouDBurUGz/G6XQuvMe5Ty0EJV9LE9P8tUrwcPtyP+8SdDyqwOp8z5MG9D
         qpCHkGa+OBPyTQbAIq/FGGnrEm9b+Hnf0SBFWSA1IcvuJ2BKlFNDeacTtZ7N1O/JVQXW
         nzryq3cxPt3x/4bh6FJWcUlWOkP89sRD2yw98oRaMV2aWpbk4wstw2i8fWouGKioBqsY
         n8tir1mrPlvNviLzprvMJm6h5M0uLB1Z3sshQKQnROyG4SDPgHmTLbKprud9Cgxp6w7Y
         marg==
X-Gm-Message-State: ANhLgQ2Rd7oytawxl00p+OhmrOrGBacfYIDrfuJJlmj5MyWuiBzGpnqt
        +DGUbDVaQ4l1iBqVogaM5M1AMA==
X-Google-Smtp-Source: ADFU+vuCLS2anqHUGeY9TD58VLE0cYY7IQa2xah6fUp6Ma3O5xQ/K/lY2AR7cF4LH5KAxUwqhaRnGg==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr8671132pgh.96.1583433574483;
        Thu, 05 Mar 2020 10:39:34 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id p21sm32698489pfn.103.2020.03.05.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:39:33 -0800 (PST)
From:   bsegall@google.com
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com, hdanton@sina.com,
        zhout@vivaldi.net
Subject: Re: [PATCH v2] sched/fair : fix reordering of enqueue_task_fair
References: <20200305074829.22792-1-vincent.guittot@linaro.org>
Date:   Thu, 05 Mar 2020 10:39:31 -0800
In-Reply-To: <20200305074829.22792-1-vincent.guittot@linaro.org> (Vincent
        Guittot's message of "Thu, 5 Mar 2020 08:48:29 +0100")
Message-ID: <xm26k13y4pek.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guittot <vincent.guittot@linaro.org> writes:

> Even when a cgroup is throttled, the group se of a child cgroup can still
> be enqueued and its gse->on_rq stays true. When a task is enqueued on such
> child, we still have to update the load_avg and increase
> h_nr_running of the throttled cfs. Nevertheless, the 1st
> for_each_sched_entity loop is skipped because of gse->on_rq == true and the
> 2nd loop because the cfs is throttled whereas we have to update both
> load_avg with the old h_nr_running and increase h_nr_running in such case.
> Note that the update of load_avg will effectively happen only once in order
> to sync up to the throttled time. Next call for updating load_avg will stop
> early because the clock stays unchanged.
>
> Fixes: 6d4d22468dae ("sched/fair: Reorder enqueue/dequeue_task_fair path")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fcc968669aea..5b232d261842 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5431,16 +5431,16 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
>  
> -		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(cfs_rq))
> -			goto enqueue_throttle;
> -
>  		update_load_avg(cfs_rq, se, UPDATE_TG);
>  		se_update_runnable(se);
>  		update_cfs_group(se);
>  
>  		cfs_rq->h_nr_running++;
>  		cfs_rq->idle_h_nr_running += idle_h_nr_running;
> +
> +		/* end evaluation on encountering a throttled cfs_rq */
> +		if (cfs_rq_throttled(cfs_rq))
> +			goto enqueue_throttle;
>  	}
>  
>  enqueue_throttle:


I think there's an equivalent issue on dequeue as well, though that's
much rarer to trigger (but still possible). I think the same fix works
there too?
