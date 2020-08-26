Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC99C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB312080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgHZMVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:21:45 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55028 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729263AbgHZMVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:21:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U6vWez3_1598444499;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6vWez3_1598444499)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Aug 2020 20:21:39 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] mm: memcg: Fix memcg reclaim soft lockup
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1598426822-93737-1-git-send-email-xlpang@linux.alibaba.com>
 <20200826081102.GM22869@dhcp22.suse.cz>
 <99efed0e-050a-e313-46ab-8fe6228839d5@linux.alibaba.com>
 <20200826110015.GO22869@dhcp22.suse.cz>
 <f0122b2d-4740-2caf-3c4f-009a513426e3@linux.alibaba.com>
 <20200826120740.GP22869@dhcp22.suse.cz>
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <19eb48db-7d5e-0f55-5dfc-6a71274fd896@linux.alibaba.com>
Date:   Wed, 26 Aug 2020 20:21:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826120740.GP22869@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/26 下午8:07, Michal Hocko wrote:
> On Wed 26-08-20 20:00:47, xunlei wrote:
>> On 2020/8/26 下午7:00, Michal Hocko wrote:
>>> On Wed 26-08-20 18:41:18, xunlei wrote:
>>>> On 2020/8/26 下午4:11, Michal Hocko wrote:
>>>>> On Wed 26-08-20 15:27:02, Xunlei Pang wrote:
>>>>>> We've met softlockup with "CONFIG_PREEMPT_NONE=y", when
>>>>>> the target memcg doesn't have any reclaimable memory.
>>>>>
>>>>> Do you have any scenario when this happens or is this some sort of a
>>>>> test case?
>>>>
>>>> It can happen on tiny guest scenarios.
>>>
>>> OK, you made me more curious. If this is a tiny guest and this is a hard
>>> limit reclaim path then we should trigger an oom killer which should
>>> kill the offender and that in turn bail out from the try_charge lopp
>>> (see should_force_charge). So how come this repeats enough in your setup
>>> that it causes soft lockups?
>>>
>>
>> should_force_charge() is false, the current trapped in endless loop is
>> not the oom victim.
> 
> How is that possible? If the oom killer kills a task and that doesn't
> resolve the oom situation then it would go after another one until all
> tasks are killed. Or is your task living outside of the memcg it tries
> to charge?
> 

All tasks are in memcgs. Looks like the first oom victim is not finished
(unable to schedule), later mem_cgroup_oom()->...->oom_evaluate_task()
will set oc->chosen to -1 and abort.
