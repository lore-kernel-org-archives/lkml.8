Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4948CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDC0206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Jl/QqwDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDGBVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:21:42 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18303 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGBVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:21:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8bd5700000>; Mon, 06 Apr 2020 18:20:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 18:21:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Apr 2020 18:21:40 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Apr
 2020 01:21:40 +0000
Received: from [10.2.60.145] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Apr 2020
 01:21:39 +0000
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
To:     NeilBrown <neilb@suse.de>, Michal Hocko <mhocko@kernel.org>
CC:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200403083543.11552-1-mhocko@kernel.org>
 <20200403083543.11552-2-mhocko@kernel.org>
 <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com>
 <87blo8xnz2.fsf@notabene.neil.brown.name>
 <20200406070137.GC19426@dhcp22.suse.cz>
 <4f861f07-4b47-8ddc-f783-10201ea302d3@nvidia.com>
 <875zecw1n6.fsf@notabene.neil.brown.name>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <34cb5019-9fab-4dfd-db48-c3f88fe5614c@nvidia.com>
Date:   Mon, 6 Apr 2020 18:21:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <875zecw1n6.fsf@notabene.neil.brown.name>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586222448; bh=LYXDUK+GJft3mnfsdxuky7tVzUNlHTrLGp5zc2o/mDo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Jl/QqwDKYXHNIQohfKGwFXrYefebguhhbbIxJJtXWn2OBMU2XSKkvCx9qNgcIb/nS
         XqJru4pynZpuMwAtLpfjpZIRVoJBQUWu6qG19aN3w4VWYFL8DRqitD2ArHjWsz7lEb
         ZhCgVC9skTQdSs2jfmiMpjl6BZbe3Jse6/tVWkSplo0FqnJKPUdN6lzaLgenWyWLBB
         dsQKEHwk1WbcBYwWwnGhiHgHI0kTmPyq4mSYlN7bGrhb5bYSd+nt/Mkd4A5Kna0Ih3
         PHKFGIDW2IYetxeHBldIHbi4ayfJd3VGaDRvRkCSLY72eZ6Tt6ah1IGd4iwFDDLr3F
         1n19FqbN5jQYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/20 6:00 PM, NeilBrown wrote:
...
>>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>>> index e5b817cb86e7..9cacef1a3ee0 100644
>>> --- a/include/linux/gfp.h
>>> +++ b/include/linux/gfp.h
>>> @@ -110,6 +110,11 @@ struct vm_area_struct;
>>>     * the caller guarantees the allocation will allow more memory to be freed
>>>     * very shortly e.g. process exiting or swapping. Users either should
>>>     * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
>>> + * Users of this flag have to be extremely careful to not deplete the reserve
>>> + * completely and implement a throttling mechanism which controls the consumption
>>> + * of the reserve based on the amount of freed memory.
>>> + * Usage of a pre-allocated pool (e.g. mempool) should be always considered before
>>> + * using this flag.
> 
> I think this version is pretty good.
> 
>>>     *
>>>     * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
>>>     * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
>>>
>>
>> Hi Michal and all,
>>
>> How about using approximately this wording instead? I found Neil's wording to be
>> especially helpful so I mixed it in. (Also fixed a couple of slight 80-col overruns.)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index be2754841369..c247a911d8c7 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -111,6 +111,15 @@ struct vm_area_struct;
>>     * very shortly e.g. process exiting or swapping. Users either should
>>     * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
>>     *
>> + * To be extra clear: users of __GFP_MEMALLOC must be working to free other
>> + * memory, and that other memory needs to be freed "soon"; specifically, before
>> + * the reserve is exhausted. This generally implies a throttling mechanism that
>> + * balances the amount of __GFP_MEMALLOC memory used against the amount that the
>> + * caller is about to free.
> 
> I don't like this change. "balances the amount ... is about to free"
> does say anything about time, so it doesn't seem to be about throttling.
> 
> I think it is hard to write rules because the rules are a bit spongey.
> 
> With mempools, we have a nice clear rule.  When you allocate from a
> mempool you must have a clear path to freeing that allocation which will
> not block on memory allocation except from a subordinate mempool.  This
> implies a partial ordering between mempools.  When you have layered
> block devices the path through the layers from filesystem down to
> hardware defines the order.  It isn't enforced, but it is quite easy to
> reason about.
> 
> GFP_MEMALLOC effectively provides multiple mempools.  So it could
> theoretically deadlock if multiple long dependency chains
> happened. i.e. if 1000 threads each make a GFP_MEMALLOC allocation and
> then need to make another one before the first can be freed - then you
> hit problems.  There is no formal way to guarantee that this doesn't
> happen.  We just say "be gentle" and minimize the users of this flag,
> and keep more memory in reserve than we really need.
> Note that 'threads' here might not be Linux tasks.  If you have an IO
> request that proceed asynchronously, moving from queue to queue and
> being handled by different task, then each one is a "thread" for the
> purpose of understanding mem-alloc dependency.
> 
> So maybe what I really should focus on is not how quickly things happen,
> but how many happen concurrently.  The idea of throttling is to allow
> previous requests to complete before we start too many more.
> 
> With Swap-over-NFS, some of the things that might need to be allocated
> are routing table entries.  These scale with the number of NFS servers
> rather than the number of IO requests, so they are not going to cause
> concurrency problems.
> We also need memory to store replies, but these never exceed the number
> of pending requests, so there is limited concurrency there.
> NFS can send a lot of requests in parallel, but the main limit is the
> RPC "slot table" and while that grows dynamically, it does so with
> GFP_NOFS, so it can block or fail (I wonder if that should explicitly
> disable the use of the reserves).
> 
> So there a limit on concurrency imposed by non-GFP_MEMALLOC allocations
> 
> So ... maybe the documentation should say that boundless concurrency of
> allocations (i.e. one module allocating a boundless number of times
> before previous allocations are freed) must be avoided.
> 

Well, that's a good discussion that you just wrote, above, and I think it
demonstrates that it's hard to describe the situation in just a couple of
sentences. With that in mind, perhaps it's best to take the above notes
as a starting point, adjust them slightly and drop them into
Documentation/core-api/memory-allocation.rst ?

Then the comments here could refer to it.


thanks,
-- 
John Hubbard
NVIDIA
