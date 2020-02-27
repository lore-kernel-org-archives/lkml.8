Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF7BC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8172467B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOAKr1Bb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgB0TRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:17:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43432 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgB0TRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:17:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id s1so314691pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 11:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lt2aiMvSn5mHkwPcdsg2fYxrXIptbHTHrhZXKCcaiFU=;
        b=nOAKr1BbymZc61P63Fa3xHW6MhUt6gbniRcWRJqoeSPBE5jKkDMV/JY2iBuLRAoS1k
         WK86AxiVCQui9A7O7RocR6LboFaiPexj9nmI4eF5HzOBLJi/+mn5uzSB+AC4+xgwmz9W
         fXIaJe5H4i1aJkqkOK/DVcU4lbqW7UCEj5itbiK9An+IfxptrTStnE3Yyg2HrRROTr+n
         YCajkXK5k9MvcvsTqf7oTuOm0fLLOmQyeDnzXID60+TDGNIuMoFqkCjP8Jlvk3l/Cjv5
         /m5IGwiBkj28x4YLa29uXouhF81aVyIw3pIg5rv5zkgmy73Z4jdNuEYrRdXBtJJC4sgo
         2sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=lt2aiMvSn5mHkwPcdsg2fYxrXIptbHTHrhZXKCcaiFU=;
        b=kHp66FWtOdobEIG+DDTlbBU5ehDV+IEDitQXJ7SxijWU6ac2m7Sow4y/gKG9M+dkyu
         aU7I+vFkePefTf4+YNn7dilvJP9UDYvCtKfCPGYLsVYf4b8/1WpfgoouethLUtr2+TOE
         uzklUxdW7dMw7ZLrDYBn7WDdjC2dT361vHSehAO7F1XaQa4yi5OZJ/CR9qL45AOiH+Np
         PsORjIp6cRcy7HzZv0hMpTkF2Z7XybXIBGXFtoQ4w5ma9SWvVfY9V6L3QZlzOrkv7CQn
         7RAg/a4rcQQRMi2EEPHEBzPJhHfgiTKvWpvPP6lvjWqrPjDGbue6cwF+bjZm6/vZi0je
         ZvGQ==
X-Gm-Message-State: APjAAAWC0bLnQgcoz2ydPcxzl7xWSYFDUlN2dbPrLapbpSffAbepjbHQ
        /TsufvmeyIvoRUS8H9VHvHvtXw==
X-Google-Smtp-Source: APXvYqwg90JZY4Sw2hy74FW89dMmaVvMErWfp2rXRGeJfOpl0OEI5GxNNLI8FAZLTMNx2FsyW5W8zw==
X-Received: by 2002:a63:e044:: with SMTP id n4mr802423pgj.338.1582831068272;
        Thu, 27 Feb 2020 11:17:48 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id o73sm7382812pje.7.2020.02.27.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:17:47 -0800 (PST)
From:   bsegall@google.com
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com, hdanton@sina.com,
        zhout@vivaldi.net
Subject: Re: [PATCH v2] sched/fair: fix runnable_avg for throttled cfs
References: <20200227154115.8332-1-vincent.guittot@linaro.org>
Date:   Thu, 27 Feb 2020 11:17:46 -0800
In-Reply-To: <20200227154115.8332-1-vincent.guittot@linaro.org> (Vincent
        Guittot's message of "Thu, 27 Feb 2020 16:41:15 +0100")
Message-ID: <xm26ftevu9et.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guittot <vincent.guittot@linaro.org> writes:

> When a cfs_rq is throttled, its group entity is dequeued and its running
> tasks are removed. We must update runnable_avg with the old h_nr_running
> and update group_se->runnable_weight with the new h_nr_running at each
> level of the hierarchy.

Looks good to me.

Reviewed-by: Ben Segall <bsegall@google.com>

>
> Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> This patch applies on top of tip/sched/core
>
> Changes since v1:
> - update commit message
> - add missing {}
>
>  kernel/sched/fair.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fcc968669aea..22d067279269 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4701,8 +4701,13 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  		if (!se->on_rq)
>  			break;
>  
> -		if (dequeue)
> +		if (dequeue) {
>  			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> +		} else {
> +			update_load_avg(qcfs_rq, se, 0);
> +			se_update_runnable(se);
> +		}
> +
>  		qcfs_rq->h_nr_running -= task_delta;
>  		qcfs_rq->idle_h_nr_running -= idle_task_delta;
>  
> @@ -4770,8 +4775,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  			enqueue = 0;
>  
>  		cfs_rq = cfs_rq_of(se);
> -		if (enqueue)
> +		if (enqueue) {
>  			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> +		} else {
> +			update_load_avg(cfs_rq, se, 0);
> +			se_update_runnable(se);
> +		}
> +
>  		cfs_rq->h_nr_running += task_delta;
>  		cfs_rq->idle_h_nr_running += idle_task_delta;
