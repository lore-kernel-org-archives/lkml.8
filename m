Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FE7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4EB221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgHFR1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:27:39 -0400
Received: from foss.arm.com ([217.140.110.172]:45934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729265AbgHFR1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:27:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFDE911B3;
        Thu,  6 Aug 2020 07:48:56 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C8F43F887;
        Thu,  6 Aug 2020 07:48:52 -0700 (PDT)
Subject: Re: [PATCH RFC] sched/fair: simplfy the work when reweighting entity
To:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
Cc:     Jiang Biao <benbjiang@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200804071222.31675-1-benbjiang@tencent.com>
 <f9eab9a5-c7c2-dbf3-834b-abd9c376f92c@arm.com>
 <8FA38F12-3CB4-46A9-B654-92DC384D3103@tencent.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c97da668-09ec-4368-cfd4-13cbbbd6a4a5@arm.com>
Date:   Thu, 6 Aug 2020 16:48:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8FA38F12-3CB4-46A9-B654-92DC384D3103@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2020 04:42, benbjiang(蒋彪) wrote:
> 
> 
>> On Aug 6, 2020, at 12:21 AM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 04/08/2020 09:12, Jiang Biao wrote:
>>> If a se is on_rq when reweighting entity, all we need should be
>>> updating the load of cfs_rq, other dequeue/enqueue works could be
>>> redundant, such as,
>>> * account_numa_dequeue/account_numa_enqueue
>>> * list_del/list_add from/into cfs_tasks
>>> * nr_running--/nr_running++
>>
>> I think this could make sense. Have you spotted a code path where this
>> gives you a change?
>>
>> I guess only for a task on the rq, so: entity_is_task(se) && se->on_rq
> Yes, you're right. No other code path I spotted except what you list below.
> 
>>
>>> Just simplfy the work. Could be helpful for the hot path.
>>
>> IMHO hotpath is update_cfs_group() -> reweight_entity() but this is only
>> called for '!entity_is_task(se)'.
>>
>> See
>>
>> 3290         if (!gcfs_rq)
>> 3291                 return;
>>
>> in update_cfs_group().
> Yes, It is.
> But *nr_running--/nr_running++* works are still redundant for
> ‘!entity_is_task(se)' hot path. :)

True.

> Besides, I guess we could simplify the logic and make it cleaner and
> more readable with this patch.

Yes.

> If it could make sense to you, would you mind if I resend the patch
> with the commit log amended?

LGTM so why not?

>> The 'entity_is_task(se)' case is
>>
>> set_load_weight(struct task_struct *p, ...) -> reweight_task(p, ...) ->
>> reweight_entity(..., &p->se, ...)
>>
>> but here !se->on_rq.
> Yes, indeed.

[...]
