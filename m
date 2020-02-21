Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC97C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD573207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgBUJ6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:58:03 -0500
Received: from foss.arm.com ([217.140.110.172]:35472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgBUJ6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:58:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C165F31B;
        Fri, 21 Feb 2020 01:58:02 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F23693F68F;
        Fri, 21 Feb 2020 01:58:00 -0800 (PST)
Subject: Re: [PATCH v2 3/5] sched/pelt: Remove unused runnable load average
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-4-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e115029f-d577-ba31-e8b1-bb0d1a3f0f80@arm.com>
Date:   Fri, 21 Feb 2020 10:57:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214152729.6059-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2020 16:27, Vincent Guittot wrote:

[...]

fdef CONFIG_SMP
> @@ -2940,15 +2913,12 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  		u32 divider = LOAD_AVG_MAX - 1024 + se->avg.period_contrib;
>  
>  		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
> -		se->avg.runnable_load_avg =
> -			div_u64(se_runnable(se) * se->avg.runnable_load_sum, divider);
>  	} while (0);
>  #endif
>  
>  	enqueue_load_avg(cfs_rq, se);
>  	if (se->on_rq) {
>  		account_entity_enqueue(cfs_rq, se);
> -		enqueue_runnable_load_avg(cfs_rq, se);
>  	}

Nit pick: No curly brackets needed anymore.

[...]
