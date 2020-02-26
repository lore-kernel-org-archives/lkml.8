Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4684FC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7702072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOvVEIuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgBZTEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:04:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42566 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgBZTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:04:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so109290pgs.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 11:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t4Ymq0wxAYLuYTgvSM3hAABbndMMrFALAZeqIqFcSao=;
        b=OOvVEIuQQnOlnqpJCPs6X9Bp9f6QZ4KOBED/1NBLO3umkCEpjHrC1Ui+ywDpXyEcM1
         QOe2BnC7DMY/3mBdN4q8kOecW66G4YXoO8xjjJ8RDPNkdJLLFL70D3/g8XGSXa5wGemf
         O6BRp0MtFRAy71cqNc2kdIRpnx3R+E6BsLhkymL4mqCfnixOcs92uDS8d9FeX1aE0Ska
         clYmF5+MgiRxVK5X/S6FcKhFtUSy3pStKZWpj7Q7AuljBlL8DFAMnm+UjjveU4JdtBNF
         FNXLFYYWdOCvX4faeVi9OeU+85e1Ew4fG56yBOBClGM9fwfaFJT47Td5Qgg1orvB76WV
         m6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=t4Ymq0wxAYLuYTgvSM3hAABbndMMrFALAZeqIqFcSao=;
        b=YsusvpUGlD4vTg1iZgFPcFhH7grY852YcTGZrgh2dsblBYR9gIO7xWBKP2dkqG1S1t
         XTUnnlsO8edjA90A7CAO+vwBSYlGV/h+yEdmF35mkTexUbmBxvSYFELAos1t0Hrbl6j/
         62No2/vRqKAs43y9oebkcl/XGMQzlgp8UduJz7COm3X3MGQG9dDMG4k1F4IedBNJzCZB
         W6DSpAoOQ55KSLCgdu2drsyFxFm68lw1kwo4/By4SIKpWlpFthiaJ29NWH16YBjEd7i7
         9vbOxYetSdkBenq0ydMZ/IrNO6fg45+QCCvymw5b98IZ46V1kMbpe2g0E+jUzLVMpXlA
         4qFQ==
X-Gm-Message-State: APjAAAX3WBIB0lvv+pFOaQDGV4hGL6UqVMMLbA9ItER3wuCdS4hJhnfi
        OKN+Or4YfIhR6GjpPc9CNtM3eQ==
X-Google-Smtp-Source: APXvYqySx3oyjyD1hWfHyYSEKiNiSUS9b6MJen8NZSb7LGieNxEK1aRjr5CxqgtsuPJ1o32RMq0bFA==
X-Received: by 2002:a62:52d0:: with SMTP id g199mr100564pfb.241.1582743883050;
        Wed, 26 Feb 2020 11:04:43 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id p17sm3840362pfn.31.2020.02.26.11.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 11:04:42 -0800 (PST)
From:   bsegall@google.com
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com, hdanton@sina.com,
        zhout@vivaldi.net
Subject: Re: [PATCH] sched/fair: fix runnable_avg for throttled cfs
References: <20200226181640.21664-1-vincent.guittot@linaro.org>
Date:   Wed, 26 Feb 2020 11:04:40 -0800
In-Reply-To: <20200226181640.21664-1-vincent.guittot@linaro.org> (Vincent
        Guittot's message of "Wed, 26 Feb 2020 19:16:40 +0100")
Message-ID: <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guittot <vincent.guittot@linaro.org> writes:

> When a cfs_rq is throttled, its group entity is dequeued and its running
> tasks are removed. We must update runnable_avg with current h_nr_running
> and update group_se->runnable_weight with new h_nr_running at each level
> of the hierarchy.

You'll also need to do this for task enqueue/dequeue inside of a
throttled hierarchy, I'm pretty sure.

>
> Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> This patch applies on top of tip/sched/core
>
>  kernel/sched/fair.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fcc968669aea..6d46974e9be7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4703,6 +4703,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  
>  		if (dequeue)
>  			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> +		else {
> +			update_load_avg(qcfs_rq, se, 0);
> +			se_update_runnable(se);
> +		}
> +
>  		qcfs_rq->h_nr_running -= task_delta;
>  		qcfs_rq->idle_h_nr_running -= idle_task_delta;
>  
> @@ -4772,6 +4777,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  		cfs_rq = cfs_rq_of(se);
>  		if (enqueue)
>  			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> +		else {
> +			update_load_avg(cfs_rq, se, 0);


> +			se_update_runnable(se);
> +		}
> +
>  		cfs_rq->h_nr_running += task_delta;
>  		cfs_rq->idle_h_nr_running += idle_task_delta;
