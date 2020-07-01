Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B82C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44AB2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cs4f4Qil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgGALnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:43:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32123 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730289AbgGALnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:43:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593603826; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ZxvZ3ZHrYJEH6ORrIltAoxRTJ6ts5ysgirylJWWdaHQ=; b=cs4f4QilY8NYtPC2c5mpg/7Wmjhfw0fVfk0QZpbconxCPKmf++YeMFSxrCvvt0fbZ9w3ycLU
 1O5iEcwiByfPrx+/GW0c/WGdlM2Vw1lFVArOgB5tpe4LOi0mD/OzloQPCqx8lANTvSWkpEQ8
 0GT4r3sIcG1ITl/lBGFsPtu1UQE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5efc76edad153efa3468cb64 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 01 Jul 2020 11:43:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 042CBC433A1; Wed,  1 Jul 2020 11:43:40 +0000 (UTC)
Received: from [10.231.195.151] (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6725DC433C8;
        Wed,  1 Jul 2020 11:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6725DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=zijuhu@codeaurora.org
Subject: Re: [PATCH v1] sched/cfs: Fix pick_next_entity() implementation error
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1593598026-2451-1-git-send-email-zijuhu@codeaurora.org>
 <CAKfTPtBn0Bh4DjSs_nATYPvRt5Ks2Dg8n0TH7vuxtFfKFTxG5A@mail.gmail.com>
From:   Zijun Hu <zijuhu@codeaurora.org>
Message-ID: <a2134b46-88b5-9260-1b6f-60f5b189e86c@codeaurora.org>
Date:   Wed, 1 Jul 2020 19:43:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBn0Bh4DjSs_nATYPvRt5Ks2Dg8n0TH7vuxtFfKFTxG5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks for your explanation.
you are right. @lest should be used as reference point to compare.
Please ignore this patch.

On 7/1/2020 6:47 PM, Vincent Guittot wrote:
> On Wed, 1 Jul 2020 at 12:07, Zijun Hu <zijuhu@codeaurora.org> wrote:
>>
>> sched_entity @se not static @left should be compared
>> to pick up @cfs_rq->next.
> 
> Could you elaborate why ?
> 
> left is the leftmost sched_entity and the one that should be used.
> 
> se != left means that left should be skipped after a yield and the
> next se in the rbtree is not "far" from left although it has higher
> vruntime
> 
> if we finally want to use last or next instead of se, we must ensure
> that they are still not "far" from left otherwise you can promote a
> sched entity that ends up having a really high vruntime
> 
>>
>> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
>> ---
>>  kernel/sched/fair.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 658aa7a2ae6f..4790f2d851ad 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4452,13 +4452,13 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>         /*
>>          * Prefer last buddy, try to return the CPU to a preempted task.
>>          */
>> -       if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
>> +       if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, se) < 1)
>>                 se = cfs_rq->last;
>>
>>         /*
>>          * Someone really wants this to run. If it's not unfair, run it.
>>          */
>> -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
>> +       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, se) < 1)
>>                 se = cfs_rq->next;
>>
>>         clear_buddies(cfs_rq, se);
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>>
