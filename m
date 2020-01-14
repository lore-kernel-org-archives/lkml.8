Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAEFC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1328E24673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HV4Ss7qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgANSWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:22:50 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6052 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANSWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:22:49 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1e06e40000>; Tue, 14 Jan 2020 10:22:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jan 2020 10:22:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jan 2020 10:22:48 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 18:22:48 +0000
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
To:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>, Qian Cai <cai@lca.pw>,
        <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        <linux-kernel@vger.kernel.org>
References: <49fa7dea-00ac-155f-e7b7-eeca206556b5@arm.com>
 <6A58E80B-7A5F-4CAD-ACF1-89BCCBE4D3B1@lca.pw>
 <a0bfcebe-a0f4-95ef-0973-8edd3780d013@redhat.com>
 <f6487dc1-c962-67aa-131e-2eec4f6ca686@arm.com>
 <20200114091013.GD19428@dhcp22.suse.cz>
 <1f3ff7fc-2f6b-d8e5-85a5-078f0e1a0daf@suse.cz>
 <20200114113230.GM19428@dhcp22.suse.cz>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <958fa7cd-0e88-3387-d4bf-e8bfcfdb256b@nvidia.com>
Date:   Tue, 14 Jan 2020 10:22:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200114113230.GM19428@dhcp22.suse.cz>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579026148; bh=AZqymOqr9EyUGtO2Cg1HbIfDXScrw+fAop2z07tend0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HV4Ss7qAUWmz8CskpNaubXEos1oKIpA0V4O/+wwsexFWDkalTnlcHm3kauygHymrb
         BJlzzzwjc5yflpWlHvlkHMxCNomUcX63rEni6aOeGVqDkZf/7vxT9QQ6T1DSWzgd5d
         rruiNfdxBmH8y45lbE0lWOSaOZQ5TcuGhrafzzhySpU56jjPuzHX1TymPqoCN524zd
         ROWn9lc03dLL6fkYiPlF9Ajs7UacHzEH3OfJGEyzY585zZK5VmGuJkHMxnr7HBiP1y
         FPyb17pugR97pum5qLHhwoBd08ALeS5ywwknomS0vv/quXnLRwPMvG1Wa56EU2ke9O
         ZVayeAg3wzBwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/20 3:32 AM, Michal Hocko wrote:
> On Tue 14-01-20 11:23:52, Vlastimil Babka wrote:
>> On 1/14/20 10:10 AM, Michal Hocko wrote:
>>> [Cc Ralph]
>>>> The reason is dump_page() does not print page->flags universally
>>>> and only does so for KSM, Anon and File pages while excluding
>>>> reserved pages at boot. Wondering should not we make printing
>>>> page->flags universal ?
>>>
>>> We used to do that and this caught me as a surprise when looking again.
>>> This is a result of 76a1850e4572 ("mm/debug.c: __dump_page() prints an
>>> extra line") which is a cleanup patch and I suspect this result was not
>>> anticipated.
>>>
>>> The following will do the trick but I cannot really say I like the code
>>> duplication. pr_cont in this case sounds like a much cleaner solution to
>>> me.
>>
>> How about this then?
> 
> Yes makes sense as well.
> 
>> diff --git mm/debug.c mm/debug.c
>> index 0461df1207cb..6a52316af839 100644
>> --- mm/debug.c
>> +++ mm/debug.c
>> @@ -47,6 +47,7 @@ void __dump_page(struct page *page, const char *reason)
>>   	struct address_space *mapping;
>>   	bool page_poisoned = PagePoisoned(page);
>>   	int mapcount;
>> +	char *type = "";
>>   
>>   	/*
>>   	 * If struct page is poisoned don't access Page*() functions as that
>> @@ -78,9 +79,9 @@ void __dump_page(struct page *page, const char *reason)
>>   			page, page_ref_count(page), mapcount,
>>   			page->mapping, page_to_pgoff(page));
>>   	if (PageKsm(page))
>> -		pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
>> +		type = "ksm ";
>>   	else if (PageAnon(page))
>> -		pr_warn("anon flags: %#lx(%pGp)\n", page->flags, &page->flags);
>> +		type = "anon ";
>>   	else if (mapping) {
>>   		if (mapping->host && mapping->host->i_dentry.first) {
>>   			struct dentry *dentry;
>> @@ -88,10 +89,11 @@ void __dump_page(struct page *page, const char *reason)
>>   			pr_warn("%ps name:\"%pd\"\n", mapping->a_ops, dentry);
>>   		} else
>>   			pr_warn("%ps\n", mapping->a_ops);
>> -		pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>>   	}
>>   	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
>>   
>> +	pr_warn("%sflags: %#lx(%pGp)\n", type, page->flags, &page->flags);
>> +
>>   hex_only:
>>   	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>>   			sizeof(unsigned long), page,
>>
> 
Looks good to me. Thanks for the clean up.
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
