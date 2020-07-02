Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B521EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3B520870
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGBQfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:35:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgGBQfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:35:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46DB5ADD3;
        Thu,  2 Jul 2020 16:35:32 +0000 (UTC)
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
To:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Peter Zijlstra <peterz@infradead.org>
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz>
 <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
 <20200702162202.GI18446@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <57270a15-a792-5175-757b-c4bde6da3694@suse.cz>
Date:   Thu, 2 Jul 2020 18:35:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702162202.GI18446@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 6:22 PM, Michal Hocko wrote:
> On Wed 01-07-20 11:45:52, Roman Gushchin wrote:
> [...]
>> >From c97afecd32c0db5e024be9ba72f43d22974f5bcd Mon Sep 17 00:00:00 2001
>> From: Roman Gushchin <guro@fb.com>
>> Date: Wed, 1 Jul 2020 11:05:32 -0700
>> Subject: [PATCH] mm: kmem: make memcg_kmem_enabled() irreversible
>> 
>> Historically the kernel memory accounting was an opt-in feature, which
>> could be enabled for individual cgroups. But now it's not true, and
>> it's on by default both on cgroup v1 and cgroup v2.  And as long as a
>> user has at least one non-root memory cgroup, the kernel memory
>> accounting is on. So in most setups it's either always on (if memory
>> cgroups are in use and kmem accounting is not disabled), either always
>> off (otherwise).
>> 
>> memcg_kmem_enabled() is used in many places to guard the kernel memory
>> accounting code. If memcg_kmem_enabled() can reverse from returning
>> true to returning false (as now), we can't rely on it on release paths
>> and have to check if it was on before.
>> 
>> If we'll make memcg_kmem_enabled() irreversible (always returning true
>> after returning it for the first time), it'll make the general logic
>> more simple and robust. It also will allow to guard some checks which
>> otherwise would stay unguarded.
>> 
>> Signed-off-by: Roman Gushchin <guro@fb.com>

Fixes: ? or let Andrew squash it to some patch of your series (it's in mmotm I
think)?

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But see below:

>> ---
>>  mm/memcontrol.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 50ae77f3985e..2d018a51c941 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3582,7 +3582,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
>>  	objcg->memcg = memcg;
>>  	rcu_assign_pointer(memcg->objcg, objcg);
>>  
>> -	static_branch_inc(&memcg_kmem_enabled_key);
>> +	if (!memcg_kmem_enabled())
>> +		static_branch_inc(&memcg_kmem_enabled_key);
> 
> Wouldn't be static_branch_enable() more readable?

Yes, and drop the if(). It will just do nothing and return if already enabled.
Maybe slightly less efficient, but this is not a fast path anyway, and it feels
weird to modify the static key in a branch controlled by the static key itself
(CC peterz in case he wants to add something).

>>  	/*
>>  	 * A memory cgroup is considered kmem-online as soon as it gets
>>  	 * kmemcg_id. Setting the id after enabling static branching will
>> @@ -3643,9 +3644,6 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
>>  	/* css_alloc() failed, offlining didn't happen */
>>  	if (unlikely(memcg->kmem_state == KMEM_ONLINE))
>>  		memcg_offline_kmem(memcg);
>> -
>> -	if (memcg->kmem_state == KMEM_ALLOCATED)
>> -		static_branch_dec(&memcg_kmem_enabled_key);
>>  }
>>  #else
>>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>> -- 
>> 2.26.2
> 

