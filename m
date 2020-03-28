Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5523CC2D0EE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4352082F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nJsCH9lJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgC1A7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:59:33 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5403 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgC1A7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:59:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7ea1440000>; Fri, 27 Mar 2020 17:58:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 27 Mar 2020 17:59:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 27 Mar 2020 17:59:31 -0700
Received: from [10.2.58.50] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 28 Mar
 2020 00:59:31 +0000
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>, <david@redhat.com>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
 <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
 <20200328002616.kjtf7dpkqbugyzi2@master>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <97a6bf40-792b-6216-d35b-691027c85aad@nvidia.com>
Date:   Fri, 27 Mar 2020 17:59:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328002616.kjtf7dpkqbugyzi2@master>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585357124; bh=INqxeXB2KvcAJdTq0p9g/PfZMMiN/uXlz75p4EJ7hPs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nJsCH9lJyqVwPMxvMHCouIMuBEfMLTgEJeYW985LA03p5ko//MtAVptCTRQ8j2Lzd
         s7gdUdfzfQrKXxva4KUKj2c5qI0VCIGbezMXpNRSp+M+ulwkMWxWjErbKTt2pWjsdV
         L9lrXOJh8iiPFwS+njQbv77frNJmBYlUe//2yBJeI0ogZMfhqWK9O8bQqSxDnZBgm8
         kOi9+CXUTp4c2tAfBic2Q0bzjraYuD3O3VO9XR8OC+yGhOs+HKhSK5mP4W5JfNgnuZ
         9NL2/5XCLDMLUUz/XdyqPE2g67HmgfKHGWj2lfuC9nsZNzjfe0MGAX6T2hmvsjCVRL
         bmTHuyL5GuPjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/20 5:26 PM, Wei Yang wrote:
> On Fri, Mar 27, 2020 at 03:37:57PM -0700, John Hubbard wrote:
>> On 3/27/20 3:01 PM, Wei Yang wrote:
>>> Since we always clear node_order before getting it, we can leverage
>>> compiler to do this instead of at run time.
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> ---
>>>    mm/page_alloc.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index dfcf2682ed40..49dd1f25c000 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5585,7 +5585,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
>>>    static void build_zonelists(pg_data_t *pgdat)
>>>    {
>>> -	static int node_order[MAX_NUMNODES];
>>> +	static int node_order[MAX_NUMNODES] = {0};
>>
>>
>> Looks wrong: now the single instance of node_order is initialized just once by
>> the compiler. And that means that only the first caller of this function
>> gets a zeroed node_order array...
>>
> 
> What a shame on me. You are right, I miss the static word.
> 
> Well, then I am curious about why we want to define it as static. Each time we
> call this function, node_order would be set to 0 and find_next_best_node()
> would sort a proper value into it. I don't see the reason to reserve it in a
> global area and be used next time.

It's not just about preserving the value. Sometimes it's about stack space.
Here's the trade-offs for static variables within a function:

Advantages of static variables within a function (compared to non-static
variables, also within a function):
-----------------------------------

* Doesn't use any of the scarce kernel stack space
* Preserves values (not always necessarily and advantage)

Disadvantages:
-----------------------------------

* Removes basic thread safety: multiple threads can no longer independently
   call the function without getting interaction, and generally that means
   data corruption.

So here, I suspect that the original motivation was probably to conserve stack
space, and the author likely observed that there was no concurrency to worry
about: the function was only being called by one thread at a time.  Given those
constraints (which I haven't confirmed just yet, btw), a static function variable
fits well.

> 
> My suggestion is to remove the static and define it {0} instead of memset
> every time. Is my understanding correct here?


Not completely:

a) First of all, "instead of memset every time" is a misconception, because
    there is still a memset happening every time with {0}. It's just that the
    compiler silently writes that code for you, and you don't see it on the
    screen. But it's still there.

b) Switching away from a static to an on-stack variable requires that you first
    verify that stack space is not an issue. Or, if you determine that this
    function needs the per-thread isolation that a non-static variable provides,
    then you can switch to either an on-stack variable, or a *alloc() function.



thanks,
-- 
John Hubbard
NVIDIA
