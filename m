Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720F9C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B85220EDD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGNJup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:50:45 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46853 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbgGNJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:50:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U2iItPC_1594720227;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2iItPC_1594720227)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jul 2020 17:50:27 +0800
Date:   Tue, 14 Jul 2020 17:50:27 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: hide nr_nodes in the internal of
 for_each_node_mask_to_[alloc|free]
Message-ID: <20200714095027.GA86480@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200714073404.84863-1-richard.weiyang@linux.alibaba.com>
 <cd1651a0-35c6-7535-5782-ce7e31cc26e8@suse.cz>
 <807a1e32-926b-2882-740b-6484b8dca2b6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <807a1e32-926b-2882-740b-6484b8dca2b6@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:22:03AM +0200, Vlastimil Babka wrote:
>On 7/14/20 11:13 AM, Vlastimil Babka wrote:
>> On 7/14/20 9:34 AM, Wei Yang wrote:
>>> The second parameter of for_each_node_mask_to_[alloc|free] is a loop
>>> variant, which is not used outside of loop iteration.
>>> 
>>> Let's hide this.
>>> 
>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>> ---
>>>  mm/hugetlb.c | 38 ++++++++++++++++++++------------------
>>>  1 file changed, 20 insertions(+), 18 deletions(-)
>>> 
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 57ece74e3aae..9c3d15fb317e 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1196,17 +1196,19 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>>>  	return nid;
>>>  }
>>>  
>>> -#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
>>> -	for (nr_nodes = nodes_weight(*mask);				\
>>> -		nr_nodes > 0 &&						\
>>> +#define for_each_node_mask_to_alloc(hs, node, mask)			\
>>> +	int __nr_nodes;							\
>>> +	for (__nr_nodes = nodes_weight(*mask);				\
>> 
>> The problem with this is that if I use the macro twice in the same block, this
>> will redefine __nr_nodes and fail to compile, no?
>> In that case it's better to avoid setting up this trap, IMHO.
>
>Ah, and it will also generate the following warning, if the use of for_each*
>macro is not the first thing after variable declarations, but there's another
>statement before:
>
>warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>
>Instead we should switch to C99 and declare it as "for (int __nr_nodes" :P

Thanks, I haven't notice the problem you mentioned.

Let me fix this.

-- 
Wei Yang
Help you, Help me
