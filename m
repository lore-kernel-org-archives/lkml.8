Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EF4C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A12214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgAOBwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:52:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:12035 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgAOBwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:52:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 17:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="213540998"
Received: from unknown (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 14 Jan 2020 17:52:11 -0800
Date:   Wed, 15 Jan 2020 09:52:21 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup.c: use is_vm_hugetlb_page() to check whether to
 follow huge
Message-ID: <20200115015221.GA8430@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200113070322.26627-1-richardw.yang@linux.intel.com>
 <3ec77382-900c-56b9-dcad-f8b24117b097@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ec77382-900c-56b9-dcad-f8b24117b097@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 11:07:03AM -0800, Ralph Campbell wrote:
>
>On 1/12/20 11:03 PM, Wei Yang wrote:
>> No functional change, just leverage the helper function to improve
>> readability as others.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>I had thought about doing this same thing. :-)

Ah, in Chinese, there is a saying: Heroes see the same :-)

>Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
>
>> ---
>>   mm/gup.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 7646bf993b25..7705929cc920 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -323,7 +323,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>>   	pmdval = READ_ONCE(*pmd);
>>   	if (pmd_none(pmdval))
>>   		return no_page_table(vma, flags);
>> -	if (pmd_huge(pmdval) && vma->vm_flags & VM_HUGETLB) {
>> +	if (pmd_huge(pmdval) && is_vm_hugetlb_page(vma)) {
>>   		page = follow_huge_pmd(mm, address, pmd, flags);
>>   		if (page)
>>   			return page;
>> @@ -433,7 +433,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
>>   	pud = pud_offset(p4dp, address);
>>   	if (pud_none(*pud))
>>   		return no_page_table(vma, flags);
>> -	if (pud_huge(*pud) && vma->vm_flags & VM_HUGETLB) {
>> +	if (pud_huge(*pud) && is_vm_hugetlb_page(vma)) {
>>   		page = follow_huge_pud(mm, address, pud, flags);
>>   		if (page)
>>   			return page;
>> 

-- 
Wei Yang
Help you, Help me
