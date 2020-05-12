Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96AAC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917332137B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgELJAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:00:25 -0400
Received: from foss.arm.com ([217.140.110.172]:49724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729357AbgELJAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:00:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D3F61FB;
        Tue, 12 May 2020 02:00:19 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A6B13F305;
        Tue, 12 May 2020 02:00:18 -0700 (PDT)
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
To:     Phil Auld <pauld@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com>
 <CAKfTPtAztaT_===uTs6feFp4ZwPX=+UJKHwOoTOVSdsERNG3WQ@mail.gmail.com>
 <20200511204410.GI13245@lorien.usersys.redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9b95fb7d-68e2-bb69-1293-af2017be4cdb@arm.com>
Date:   Tue, 12 May 2020 11:00:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511204410.GI13245@lorien.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2020 22:44, Phil Auld wrote:
> On Mon, May 11, 2020 at 09:25:43PM +0200 Vincent Guittot wrote:
>> On Thu, 7 May 2020 at 22:36, Phil Auld <pauld@redhat.com> wrote:
>>>
>>> sched/fair: Fix enqueue_task_fair warning some more
>>>
>>> The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
>>> did not fully resolve the issues with the rq->tmp_alone_branch !=
>>> &rq->leaf_cfs_rq_list warning in enqueue_task_fair. There is a case where
>>> the first for_each_sched_entity loop exits due to on_rq, having incompletely
>>> updated the list.  In this case the second for_each_sched_entity loop can
>>> further modify se. The later code to fix up the list management fails to do
>>> what is needed because se no longer points to the sched_entity which broke
>>> out of the first loop.
>>>
>>> Address this by calling leaf_add_rq_list if there are throttled parents while
>>> doing the second for_each_sched_entity loop.
>>>
>>
>> Fixes: fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
>>
>>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> Signed-off-by: Phil Auld <pauld@redhat.com>
>>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>
>> With the Fixes tag and the typo mentioned by Tao
>>
> 
> Right, that last line of the commit message should read "list_add_leaf_cfs_rq"
> 
> 
>> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> Thanks Vincent.
> 
> Peter/Ingo, do you want me to resend or can you fix when applying?


Maybe you could add that 'the throttled parent was already added back to
the list by a task enqueue in a parallel child hierarchy'.

IMHO, this is part of the description because otherwise the throttled
parent would have connected the branch.

And the not-adding of the intermediate child cfs_rq would have gone
unnoticed.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]
