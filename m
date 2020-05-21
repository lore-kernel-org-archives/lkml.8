Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8651DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA0A207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgEUJ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:57:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:44010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbgEUJ5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:57:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 39AEEAB76;
        Thu, 21 May 2020 09:57:16 +0000 (UTC)
Subject: Re: [PATCH v3 03/19] mm: memcg: convert vmstat slab counters to bytes
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-4-guro@fb.com>
 <b72ff85a-22aa-f55d-41ee-2ddee00674a7@suse.cz>
 <20200520192652.GA278395@carbon.dhcp.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <21975f76-f58f-14ef-9547-7e32afac1681@suse.cz>
Date:   Thu, 21 May 2020 11:57:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520192652.GA278395@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 9:26 PM, Roman Gushchin wrote:
> On Wed, May 20, 2020 at 02:25:22PM +0200, Vlastimil Babka wrote:
>> 
>> However __mod_node_page_state() and mode_node_state() will now branch always. I
>> wonder if the "API clean" goal is worth it...
> 
> You mean just adding a special write-side helper which will perform a conversion
> and put VM_WARN_ON_ONCE() into generic write-side helpers?

What I mean is that maybe node/global helpers should assume page granularity,
and lruvec/memcg helpers do the check is they should convert from bytes to pages
when calling node/global helpers. Then there would be no extra branches in
node/global helpers. But maybe it's not worth saving those branches, dunno.

>> 
>> > --- a/mm/memcontrol.c
>> > +++ b/mm/memcontrol.c
>> > @@ -1409,9 +1409,8 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>> >  		       (u64)memcg_page_state(memcg, MEMCG_KERNEL_STACK_KB) *
>> >  		       1024);
>> >  	seq_buf_printf(&s, "slab %llu\n",
>> > -		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE) +
>> > -			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE)) *
>> > -		       PAGE_SIZE);
>> > +		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
>> > +			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B)));
>> >  	seq_buf_printf(&s, "sock %llu\n",
>> >  		       (u64)memcg_page_state(memcg, MEMCG_SOCK) *
>> >  		       PAGE_SIZE);
>> > @@ -1445,11 +1444,9 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>> >  			       PAGE_SIZE);
>> >  
>> >  	seq_buf_printf(&s, "slab_reclaimable %llu\n",
>> > -		       (u64)memcg_page_state(memcg, NR_SLAB_RECLAIMABLE) *
>> > -		       PAGE_SIZE);
>> > +		       (u64)memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B));
>> >  	seq_buf_printf(&s, "slab_unreclaimable %llu\n",
>> > -		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE) *
>> > -		       PAGE_SIZE);
>> > +		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B));
>> 
>> So here we are now printing in bytes instead of pages, right? That's fine for
>> OOM report, but in sysfs aren't we breaking existing users?
>> 
> 
> Hm, but it was in bytes previously, look at that x * PAGE_SIZE.

Yeah, that's what I managed to overlook, sorry.

> Or do you mean that now it can be not rounded to PAGE_SIZE?
> If so, I don't think it breaks any expectations.
> 
> Thanks!
> 

