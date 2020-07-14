Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06A1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC961221FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGNKCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:02:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:54808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgGNKCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:02:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39D44AD12;
        Tue, 14 Jul 2020 10:02:41 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: hide nr_nodes in the internal of
 for_each_node_mask_to_[alloc|free]
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200714073404.84863-1-richard.weiyang@linux.alibaba.com>
 <cd1651a0-35c6-7535-5782-ce7e31cc26e8@suse.cz>
 <807a1e32-926b-2882-740b-6484b8dca2b6@suse.cz>
 <20200714095713.GA86690@L-31X9LVDL-1304.local>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e0d384a7-34bc-43ce-dc20-db4808b0f736@suse.cz>
Date:   Tue, 14 Jul 2020 12:02:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714095713.GA86690@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 11:57 AM, Wei Yang wrote:
> On Tue, Jul 14, 2020 at 11:22:03AM +0200, Vlastimil Babka wrote:
>>On 7/14/20 11:13 AM, Vlastimil Babka wrote:
>>> On 7/14/20 9:34 AM, Wei Yang wrote:
>>>> The second parameter of for_each_node_mask_to_[alloc|free] is a loop
>>>> variant, which is not used outside of loop iteration.
>>>> 
>>>> Let's hide this.
>>>> 
>>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>> ---
>>>>  mm/hugetlb.c | 38 ++++++++++++++++++++------------------
>>>>  1 file changed, 20 insertions(+), 18 deletions(-)
>>>> 
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 57ece74e3aae..9c3d15fb317e 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -1196,17 +1196,19 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>>>>  	return nid;
>>>>  }
>>>>  
>>>> -#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
>>>> -	for (nr_nodes = nodes_weight(*mask);				\
>>>> -		nr_nodes > 0 &&						\
>>>> +#define for_each_node_mask_to_alloc(hs, node, mask)			\
>>>> +	int __nr_nodes;							\
>>>> +	for (__nr_nodes = nodes_weight(*mask);				\
>>> 
>>> The problem with this is that if I use the macro twice in the same block, this
>>> will redefine __nr_nodes and fail to compile, no?
>>> In that case it's better to avoid setting up this trap, IMHO.
>>
>>Ah, and it will also generate the following warning, if the use of for_each*
>>macro is not the first thing after variable declarations, but there's another
>>statement before:
>>
>>warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>>
>>Instead we should switch to C99 and declare it as "for (int __nr_nodes" :P
> 
> Hmm... I tried what you suggested, but compiler complains.
> 
> 'for' loop initial declarations are only allowed in C99 or C11 mode

Yes, by "we should switch to C99" I meant that the kernel kbuild system would
need to switch. Not a trivial change...
Without that, I don't see how your patch is possible to do safely.
