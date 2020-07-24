Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E594C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38EBE20737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imQF+GYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgGXPcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:32:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26581 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726841AbgGXPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595604728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJ4eBzscfjVW65qtmfE+3zWCcQrF/o+JHEw2Tgi7GN0=;
        b=imQF+GYVLw878Wa1vYm/ctdiFqYOYhhCoB+q/EIF59ZnpXb3yo+4xeE5Uk0oWDbxniUsb9
        svxYtYf3jVyjc8ihkIykhhDjHvGLZIJyfOAf+XLwN+uWbAhGN4k3NZ4z7aFk5gwPhqDvbs
        yn4ViRuCPyzynKq6r7/ZOVaRi+d7xKM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-YsfiXKrpMcCYN2lH4vEa5Q-1; Fri, 24 Jul 2020 11:32:02 -0400
X-MC-Unique: YsfiXKrpMcCYN2lH4vEa5Q-1
Received: by mail-qt1-f200.google.com with SMTP id q7so6218256qtq.14
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 08:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJ4eBzscfjVW65qtmfE+3zWCcQrF/o+JHEw2Tgi7GN0=;
        b=rfJl4nsF23j6AJehVHtlbSZ7yO9FnyIOn+N1BKVxxKzCMbpo0hm0/EbMgsx7DwvLai
         iu8dTtr9oKyn8iYu7evKtmO4N/UUz9gaoroJVcrnHXUoCOE2ZG61BmkpFSm3rUHaXb1g
         M2PYNVpDPnszURpwWoWiUOdfuAr2Ssnpr/VnHCtUSIeF6Dl1AbvOn6WpKjbBZ5QELv33
         3wVFHg0Ci9O5C3NKA45y2iYlxbKrj70RO/rmM2s+cSjbYaZ8dfPFT9G5PRxeGhspX9ve
         RMS4rP6udqieb7t2nEwynj5V/5L0zcIxi2U639Xnm1g+1OeqcdDRTSMHqDW6WkECEGYK
         0UvQ==
X-Gm-Message-State: AOAM532lK0cC3fLrKQ0npn60iU8V1Z8EkcbOWEKhi1XAUQLejfaWXHJP
        63NgxZVcmyQin+cdVpYoEZqKtcbKrAjow3m+XRMxMivyTkdY9D53wI0KnxxN/f2TXtyUgsYtN3U
        1Wi5ZtN9YPsO0xMDoUBFIOdD1
X-Received: by 2002:aed:3048:: with SMTP id 66mr9938175qte.326.1595604722398;
        Fri, 24 Jul 2020 08:32:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4J1aqYKmKLi+dX777ViWvyYs+NSW35jxglqUjTkCAO9zSHuz2ha7vRzek0SkAosAOtvrSgg==
X-Received: by 2002:aed:3048:: with SMTP id 66mr9938139qte.326.1595604722091;
        Fri, 24 Jul 2020 08:32:02 -0700 (PDT)
Received: from x1.bristot.me (host-87-16-204-193.retail.telecomitalia.it. [87.16.204.193])
        by smtp.gmail.com with ESMTPSA id c33sm1683018qtk.40.2020.07.24.08.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 08:32:01 -0700 (PDT)
Subject: Re: [PATCH] sched/deadline: dome some cleanup for push_dl_task()
To:     Juri Lelli <juri.lelli@redhat.com>, Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
References: <20200706160442.GA19741@iZj6chx1xj0e0buvshuecpZ>
 <20200724071426.GD14912@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <16385ed9-eb44-3ea4-b10a-1e5ef993b33e@redhat.com>
Date:   Fri, 24 Jul 2020 17:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724071426.GD14912@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/20 9:14 AM, Juri Lelli wrote:
> Hi,
> 
> On 07/07/20 00:04, Peng Liu wrote:
>> 'commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq when pushing a task")'
>> introduced the update_rq_clock() to fix the "used-before-update" bug.
>>
>> 'commit f4904815f97a ("sched/deadline: Fix double accounting of rq/running bw in push & pull")'
>> took away the bug source(add_running_bw()).
>>
>> We no longer need to update rq_clock in advance, let activate_task()
>> worry about that.
>>
>> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
>> ---
>>  kernel/sched/deadline.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 504d2f51b0d6..c3fa11f84d93 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2104,13 +2104,7 @@ static int push_dl_task(struct rq *rq)
>>  
>>  	deactivate_task(rq, next_task, 0);
>>  	set_task_cpu(next_task, later_rq->cpu);
>> -
>> -	/*
>> -	 * Update the later_rq clock here, because the clock is used
>> -	 * by the cpufreq_update_util() inside __add_running_bw().
>> -	 */
>> -	update_rq_clock(later_rq);
>> -	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
>> +	activate_task(later_rq, next_task, 0);
>>  	ret = 1;
> The change looks good to me, since now add_running_bw() is called later
> by enqueue_task_dl(), but rq_clock has already been updated by core's
> enqueue_task().
> 
> Daniel, Dietmar, a second pair of eyes (since you authored the commits
> above)?
> 
> I'd chage subject to something like "sched/deadline: Stop updating
> rq_clock before pushing a task".

Looks good to me!

Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks
-- Daniel

