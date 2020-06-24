Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF60C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BE92073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389710AbgFXH0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:26:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52789 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgFXH0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:26:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so1321328wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=wrvOwF9wh+nTXc2fUGXN2YrRPrEsDTdoftOpa9p4cx0=;
        b=kLn/RQYGrhMQpfbxU7ns+X7GH9DEHNDG2ngdXjyvNJJ1NXz9wfqkf3OVLkCCCY1wVX
         he9NC7Zy4WAtHWGg3cTYRnERwi4Xcg1RgcDEk2T69sH0BISjwsFlmgF0Zf/ioAVsNTo/
         JO7IKDAvgVu75w3N94THeUx6eqOBEfnHiku2svyp1oWny4ttZFJ493VdtvNsp2N6LlY6
         Ftj2n6WHOB3ZGQBb2PeE8pRD9yLlNW0JzKv/BJJfIQWRlVdfChIhzW0lFyzpJknf6Oi+
         cVihz6Y/1ksm2qTUJDIDuEsEIroEX4ON/GYCp/I1Se8sPe2ggnCQG2DjV9XGdDGG/hIL
         /W+g==
X-Gm-Message-State: AOAM533z3mglBU4hz9IIc/QZh1zEL5fVXCSzKWkpPqsoZuhaDFng//SD
        5if4nsmlxEhHpSSAWUiDUs+soRk7iNxLSA==
X-Google-Smtp-Source: ABdhPJwzYXJTeznGwgPhjbbC2nK1j5xIVpef7c//pggkFTdNMhMIytRHZ/6p8NHwakJBRJWsqQ8yEg==
X-Received: by 2002:a1c:c902:: with SMTP id f2mr235866wmb.53.1592983609207;
        Wed, 24 Jun 2020 00:26:49 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id a4sm17444733wrg.80.2020.06.24.00.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 00:26:48 -0700 (PDT)
References: <20200619172011.5810-1-qais.yousef@arm.com> <20200619172011.5810-2-qais.yousef@arm.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched/uclamp: Fix initialization of strut uclamp_rq
In-reply-to: <20200619172011.5810-2-qais.yousef@arm.com>
Message-ID: <87sgekorfq.derkling@matbug.net>
Date:   Wed, 24 Jun 2020 09:26:17 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Qais,

On Fri, Jun 19, 2020 at 19:20:10 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

> struct uclamp_rq was zeroed out entirely in assumption that in the first
> call to uclamp_rq_inc() they'd be initialized correctly in accordance to
> default settings.
>
> But when next patch introduces a static key to skip
> uclamp_rq_{inc,dec}() until userspace opts in to use uclamp, schedutil
> will fail to perform any frequency changes because the
> rq->uclamp[UCLAMP_MAX].value is zeroed at init and stays as such. Which
> means all rqs are capped to 0 by default.

Does not this means the problem is more likely with uclamp_rq_util_with(),
which should be guarded?

Otherwise, we will also keep doing useless min/max aggregations each
time schedutil calls that function, thus not completely removing
uclamp overheads while user-space has not opted in.

What about dropping this and add the guard in the following patch, along
with the others?

> Fix it by making sure we do proper initialization at init without

>
> Fix it by making sure we do proper initialization at init without
> relying on uclamp_rq_inc() doing it later.
>
> Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> CC: Patrick Bellasi <patrick.bellasi@matbug.net>
> Cc: Chris Redpath <chris.redpath@arm.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/sched/core.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a43c84c27c6f..4265861e13e9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1248,6 +1248,22 @@ static void uclamp_fork(struct task_struct *p)
>  	}
>  }
>  
> +static void __init init_uclamp_rq(struct rq *rq)
> +{
> +	enum uclamp_id clamp_id;
> +	struct uclamp_rq *uc_rq = rq->uclamp;
> +
> +	for_each_clamp_id(clamp_id) {
> +		memset(uc_rq[clamp_id].bucket,
> +		       0,
> +		       sizeof(struct uclamp_bucket)*UCLAMP_BUCKETS);
> +
> +		uc_rq[clamp_id].value = uclamp_none(clamp_id);
> +	}
> +
> +	rq->uclamp_flags = 0;
> +}
> +
>  static void __init init_uclamp(void)
>  {
>  	struct uclamp_se uc_max = {};
> @@ -1256,11 +1272,8 @@ static void __init init_uclamp(void)
>  
>  	mutex_init(&uclamp_mutex);
>  
> -	for_each_possible_cpu(cpu) {
> -		memset(&cpu_rq(cpu)->uclamp, 0,
> -				sizeof(struct uclamp_rq)*UCLAMP_CNT);
> -		cpu_rq(cpu)->uclamp_flags = 0;
> -	}
> +	for_each_possible_cpu(cpu)
> +		init_uclamp_rq(cpu_rq(cpu));
>  
>  	for_each_clamp_id(clamp_id) {
>  		uclamp_se_set(&init_task.uclamp_req[clamp_id],

