Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E90DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573B92070C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgGGBjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:39:02 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52954 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbgGGBjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:39:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U1zQdn5_1594085936;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U1zQdn5_1594085936)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Jul 2020 09:38:56 +0800
Date:   Tue, 7 Jul 2020 09:38:56 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, vbabka@suse.cz, willy@infradead.org,
        thomas_os@shipmail.org, thellstrom@vmware.com,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        aneesh.kumar@linux.ibm.com, peterx@redhat.com, walken@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: Re: [RESEND Patch v2 3/4] mm/mremap: calculate extent in one place
Message-ID: <20200707013856.GA27805@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
 <20200626135216.24314-4-richard.weiyang@linux.alibaba.com>
 <20200706100729.y2wbkpc4tyvjojzg@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706100729.y2wbkpc4tyvjojzg@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 01:07:29PM +0300, Kirill A. Shutemov wrote:
>On Fri, Jun 26, 2020 at 09:52:15PM +0800, Wei Yang wrote:
>> Page tables is moved on the base of PMD. This requires both source
>> and destination range should meet the requirement.
>> 
>> Current code works well since move_huge_pmd() and move_normal_pmd()
>> would check old_addr and new_addr again. And then return to move_ptes()
>> if the either of them is not aligned.
>> 
>> In stead of calculating the extent separately, it is better to calculate
>> in one place, so we know it is not necessary to try move pmd. By doing
>> so, the logic seems a little clear.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  mm/mremap.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index de27b12c8a5a..a30b3e86cc99 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -258,6 +258,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>>  		extent = next - old_addr;
>>  		if (extent > old_end - old_addr)
>>  			extent = old_end - old_addr;
>> +		next = (new_addr + PMD_SIZE) & PMD_MASK;
>
>Please use round_up() for both 'next' calculations.
>

I took another close look into this, seems this is not a good suggestion.

   round_up(new_addr, PMD_SIZE)

would be new_addr when new_addr is PMD_SIZE aligned, which is not what we
expect.

>> +		if (extent > next - new_addr)
>> +			extent = next - new_addr;
>>  		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
>>  		if (!old_pmd)
>>  			continue;
>> @@ -301,9 +304,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>>  
>>  		if (pte_alloc(new_vma->vm_mm, new_pmd))
>>  			break;
>> -		next = (new_addr + PMD_SIZE) & PMD_MASK;
>> -		if (extent > next - new_addr)
>> -			extent = next - new_addr;
>>  		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
>>  			  new_pmd, new_addr, need_rmap_locks);
>>  	}
>> -- 
>> 2.20.1 (Apple Git-117)
>> 
>
>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
