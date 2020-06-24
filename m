Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831DCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FCB20899
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389045AbgFXGNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:13:45 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59793 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387817AbgFXGNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:13:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U0Zjl4J_1592979220;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0Zjl4J_1592979220)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 14:13:40 +0800
Date:   Wed, 24 Jun 2020 14:13:40 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org, bhe@redhat.com,
        linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200624061340.GA11552@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <20200623151828.GA31426@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623151828.GA31426@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 05:18:28PM +0200, Michal Hocko wrote:
>On Tue 23-06-20 17:42:58, Wei Yang wrote:
>> For early sections, we assumes its memmap will never be partially
>> removed. But current behavior breaks this.
>> 
>> Let's correct it.
>> 
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>
>Can a user trigger this or is this a theoretical bug?

Let me rewrite the changelog a little. Look forward any comments.

   For early sections, its memmap is handled specially even sub-section is
   enabled. The memmap could only be populated as a whole.
   
   Quoted from the comment of section_activate():
   
       * The early init code does not consider partially populated
       * initial sections, it simply assumes that memory will never be
       * referenced.  If we hot-add memory into such a section then we
       * do not need to populate the memmap and can simply reuse what
       * is already there.
   
   While current section_deactivate() breaks this rule. When hot-remove a
   sub-section, section_deactivate() would depopulate its memmap. The
   consequence is if we hot-add this subsection again, its memmap never get
   proper populated.

>
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
>
>This begs a comment.
>
>>  		depopulate_section_memmap(pfn, nr_pages, altmap);
>> +	else if (memmap)
>> +		free_map_bootmem(memmap);
>>  
>>  	if (empty)
>>  		ms->section_mem_map = (unsigned long)NULL;
>> -- 
>> 2.20.1 (Apple Git-117)
>> 
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
