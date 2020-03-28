Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACE4C2D0E7
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA622073B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RgiI7AVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgC1B2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 21:28:38 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3975 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1B2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 21:28:38 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7ea8380000>; Fri, 27 Mar 2020 18:28:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 27 Mar 2020 18:28:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 27 Mar 2020 18:28:37 -0700
Received: from [10.2.58.50] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 28 Mar
 2020 01:28:37 +0000
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>, <david@redhat.com>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
 <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
 <20200328002616.kjtf7dpkqbugyzi2@master>
 <97a6bf40-792b-6216-d35b-691027c85aad@nvidia.com>
 <20200328011031.olsaehwdev2gqdsn@master>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <40facd34-40b2-0925-90ca-a4c53fc520e8@nvidia.com>
Date:   Fri, 27 Mar 2020 18:28:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328011031.olsaehwdev2gqdsn@master>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585358904; bh=4ZdoLhpeCl5eOQ49GFbds6K+x5pnaKcmo16+au32dnM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RgiI7AVXQXAkRF6pVEN0tDCSFfXnakhk6m/mU7qN1FgbjQSK40jywNeTFGzlwtkHg
         TrFoDlVMQZyLrYO1dZnp2ErM4roJuIW/2j/nqorFAb1WlG8wRpDmAIVuUKlFxWPHgM
         8jmDG7iKqoJlHJvfGWhaLqdwUp1Nl2lz+bB5Y6ExaCWpYFDLZy0Di6P/CGsl3SYU1l
         1q6VxwfQ3bC8I0070TXqmkdp5hBCXruocFzOwPmY3hEbwHd+K6fkNkvKi1GPrtamf4
         X7uy9SVZ9UOePaPbkWHLOBRvSqKfVIIpwOnUmbFfEa+caMF7eouj6x4PjNgv/LC16W
         pioJgsOMjajrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/20 6:10 PM, Wei Yang wrote:
...
>> It's not just about preserving the value. Sometimes it's about stack space.
>> Here's the trade-offs for static variables within a function:
>>
>> Advantages of static variables within a function (compared to non-static
>> variables, also within a function):
>> -----------------------------------
>>
>> * Doesn't use any of the scarce kernel stack space
>> * Preserves values (not always necessarily and advantage)
>>
>> Disadvantages:
>> -----------------------------------
>>
>> * Removes basic thread safety: multiple threads can no longer independently
>>   call the function without getting interaction, and generally that means
>>   data corruption.
>>
>> So here, I suspect that the original motivation was probably to conserve stack
>> space, and the author likely observed that there was no concurrency to worry
>> about: the function was only being called by one thread at a time.  Given those
>> constraints (which I haven't confirmed just yet, btw), a static function variable
>> fits well.
>>
>>>
>>> My suggestion is to remove the static and define it {0} instead of memset
>>> every time. Is my understanding correct here?
>>
>>
>> Not completely:
>>
>> a) First of all, "instead of memset every time" is a misconception, because
>>    there is still a memset happening every time with {0}. It's just that the
>>    compiler silently writes that code for you, and you don't see it on the
>>    screen. But it's still there.
>>
>> b) Switching away from a static to an on-stack variable requires that you first
>>    verify that stack space is not an issue. Or, if you determine that this
>>    function needs the per-thread isolation that a non-static variable provides,
>>    then you can switch to either an on-stack variable, or a *alloc() function.
>>
> 
> I think you get some point. While one more question about stack and static. If
> one function is thread safe, which factor determines whether we choose on
> stack value or static? Any reference size? It looks currently we don't have a
> guide line for this.
> 


There's not really any general guideline, but applying the points above (plus keeping
in mind that kernel stack space is quite small) to each case, you'll come to a good
answer.

In this case, if we really are only ever calling this function in one thread at a time,
then it's probably best to let the "conserve stack space" point win. Which leads to
just leaving the code nearly as-is. The only thing left to do would be to (optionally,
because this is an exceedingly minor point) delete the arguably misleading "= {0}" part.
And as Jason points out, doing so also moves node_order into .bss :

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4bd35eb83d34..cb4b07458249 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5607,7 +5607,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
  
  static void build_zonelists(pg_data_t *pgdat)
  {
-       static int node_order[MAX_NUMNODES] = {0};
+       static int node_order[MAX_NUMNODES];
         int node, load, nr_nodes = 0;
         nodemask_t used_mask = NODE_MASK_NONE;
         int local_node, prev_node;



Further note: On my current testing .config, I've got MAX_NUMNODES set to 64, which makes
256 bytes required for node_order array. 256 bytes on a 16KB stack is a little bit above
my mental watermark for "that's too much in today's kernels".


thanks,
-- 
John Hubbard
NVIDIA


