Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE50C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26EB920774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbgFWNCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:02:13 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60600 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729504AbgFWNCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:02:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U0W2oo1_1592917329;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0W2oo1_1592917329)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 21:02:10 +0800
Date:   Tue, 23 Jun 2020 21:02:09 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200623130209.GA8347@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <414b4cbf-02f5-0e90-df92-c0889e9ad65b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414b4cbf-02f5-0e90-df92-c0889e9ad65b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:44:02PM +0200, David Hildenbrand wrote:
>On 23.06.20 11:42, Wei Yang wrote:
>> For early sections, we assumes its memmap will never be partially
>> removed. But current behavior breaks this.
>> 
>> Let's correct it.
>> 
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> ---
>>  mm/sparse.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index b2b9a3e34696..1a0069f492f5 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -825,10 +825,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>>  		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
>>  	}
>>  
>> -	if (section_is_early && memmap)
>> -		free_map_bootmem(memmap);
>> -	else
>> +	if (!section_is_early)
>>  		depopulate_section_memmap(pfn, nr_pages, altmap);
>> +	else if (memmap)
>> +		free_map_bootmem(memmap);
>>  
>>  	if (empty)
>>  		ms->section_mem_map = (unsigned long)NULL;
>> 
>
>Agreed, that's what pfn_valid() and section_activate() expect.
>
>"If we hot-add memory into such a section then we do not need to
>populate the memmap and can simply reuse what is already there." - this
>is the case when hot-adding sub-sections into partially populated early
>sections, and has to be the case when re-hot-adding after hot-removing.
>
>Acked-by: David Hildenbrand <david@redhat.com>
>
>
>I am also not convinced that the complicated sparse_decode_mem_map()
>handling in that function is required - ms->section_mem_map &
>SECTION_MAP_MASK is sufficient for this use case of removing the memmap
>of a full early section once empty.
>

You mean remove this line?

    	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);

Then what to passed to free_map_bootmem() ?

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
