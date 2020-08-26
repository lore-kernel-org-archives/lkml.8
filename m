Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD77FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EBF20786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgHZKl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:41:29 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:59233 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728410AbgHZKlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:41:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U6vGXYm_1598438478;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6vGXYm_1598438478)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Aug 2020 18:41:18 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] mm: memcg: Fix memcg reclaim soft lockup
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1598426822-93737-1-git-send-email-xlpang@linux.alibaba.com>
 <20200826081102.GM22869@dhcp22.suse.cz>
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <99efed0e-050a-e313-46ab-8fe6228839d5@linux.alibaba.com>
Date:   Wed, 26 Aug 2020 18:41:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826081102.GM22869@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/26 ÏÂÎç4:11, Michal Hocko wrote:
> On Wed 26-08-20 15:27:02, Xunlei Pang wrote:
>> We've met softlockup with "CONFIG_PREEMPT_NONE=y", when
>> the target memcg doesn't have any reclaimable memory.
> 
> Do you have any scenario when this happens or is this some sort of a
> test case?

It can happen on tiny guest scenarios.

> 
>> It can be easily reproduced as below:
>>  watchdog: BUG: soft lockup - CPU#0 stuck for 111s![memcg_test:2204]
>>  CPU: 0 PID: 2204 Comm: memcg_test Not tainted 5.9.0-rc2+ #12
>>  Call Trace:
>>   shrink_lruvec+0x49f/0x640
>>   shrink_node+0x2a6/0x6f0
>>   do_try_to_free_pages+0xe9/0x3e0
>>   try_to_free_mem_cgroup_pages+0xef/0x1f0
>>   try_charge+0x2c1/0x750
>>   mem_cgroup_charge+0xd7/0x240
>>   __add_to_page_cache_locked+0x2fd/0x370
>>   add_to_page_cache_lru+0x4a/0xc0
>>   pagecache_get_page+0x10b/0x2f0
>>   filemap_fault+0x661/0xad0
>>   ext4_filemap_fault+0x2c/0x40
>>   __do_fault+0x4d/0xf9
>>   handle_mm_fault+0x1080/0x1790
>>
>> It only happens on our 1-vcpu instances, because there's no chance
>> for oom reaper to run to reclaim the to-be-killed process.
>>
>> Add cond_resched() in such cases at the beginning of shrink_lruvec()
>> to give up the cpu to others.
> 
> I do agree that we need a cond_resched but I cannot say I would like
> this patch. The primary reason is that it doesn't catch all cases when
> the memcg is not reclaimable. For example it wouldn't reschedule if the
> memcg is protected by low/min. What do you think about this instead?
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 99e1796eb833..bbdc38b58cc5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2617,6 +2617,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  
>  		mem_cgroup_calculate_protection(target_memcg, memcg);
>  
> +		cond_resched();
> +
>  		if (mem_cgroup_below_min(memcg)) {
>  			/*
>  			 * Hard protection.
> 
> This should catch both cases. I even have a vague recollection that
> somebody has proposed something in that direction but I cannot remember
> what has happened with that patch.
> 

It's the endless "retry" in try_charge() that caused the softlockup, and
I think mem_cgroup_protected() will eventually return MEMCG_PROT_NONE,
and shrink_node_memcgs() will call shrink_lruvec() for memcg
self-reclaim cases, so it's not a problem here.

But adding cond_resched() at upper shrink_node_memcgs() may eliminate
potential similar issues, I have no objection with this approach.
I tested it and works well, will send v2 later.
