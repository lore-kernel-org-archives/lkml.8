Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D4BC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D4C2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="XXGCTssw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgDQMFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:05:30 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:6138
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbgDQMFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:05:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbP1Zf4IvZe03uIr5IvkMNSAwpgWXFR/7EzeTGSgFjze8Bvg6Jx+HNoll/m+Myoa31CprMBQECBTQN9yzNfwzcWTzR3kSRVJ1ebj0MG5AWrtGM/i9mGWxHzRsYMYuOWuMLKjndFeCQrdgXzgnqEju+dk1dFNK4qJ7YhQ5jn5ek7VrwJK/hT7DbxBaGNqLGohRa1WNYraTtTvl9Pkuv9n12VGxqeM9uK/K4gdpnpC/qKjZp6VniYoFd4IyOyzTKnhT+GGP71l+hcE2V2pzMqM+eVX3BYdck6qqDQ0LWrcIjHwRNnABLA3jkJ/YerzLnkjTxTfWpurO7Xabz6K7nmzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkD42ByhbNwi94QJGmnHaS5lKcIhqmgu7XnLw/6ye8M=;
 b=Q7K8EnnxgstzzrukawwTfkneXgocBvQkweIvCuejOXPFr4u+odZk//Oa9Kf7zOgW7Q3T1VQPAT7Z32gUbI1LbgZRG9GePa5IEO1QeldXxNf2N5izlYD2pZWqBwx/UDYDeazB+DCowsMgkMrklVB5d4mQyxnZ7ldrgmxLWJhEjisfLp/qaw6qT20O9cfqbbLKKpslFhSlc7FS+BfEVg4LzO1qaJjgBHARZWV3yM1ZfKp58N4pocjp+K+P/lZ/cZ9tJxcAVQAQvp/HxUnkko/b4sadekfcjykdEzyocRAoWzARxjyaRnA5zLk9MItQx+t8MpzCgoW7GD7hmYszmTLrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkD42ByhbNwi94QJGmnHaS5lKcIhqmgu7XnLw/6ye8M=;
 b=XXGCTsswxM1e9ZZMNqniPfdZxVZkgtn7C8lmuP0XoDLEZw1cimOaIr0LooycNKVAn5SyMIQdumiUv0V0+iup+A5O3bulln2hexq8ct8vDRQ7KDRM7uCpKbeXH453cVLe3cKtPlt6DELn+QBtWMKMlpIUc55xNW1nFrowPy0NBmQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com; 
Received: from HE1PR0302MB2682.eurprd03.prod.outlook.com (2603:10a6:3:f5::14)
 by HE1PR0302MB2811.eurprd03.prod.outlook.com (2603:10a6:3:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 12:05:25 +0000
Received: from HE1PR0302MB2682.eurprd03.prod.outlook.com
 ([fe80::b10a:8b9d:1a18:6b2]) by HE1PR0302MB2682.eurprd03.prod.outlook.com
 ([fe80::b10a:8b9d:1a18:6b2%9]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 12:05:25 +0000
Subject: Re: [PATCH, RFC] x86/mm/pat: Restore large pages after fragmentation
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
 <0a28e6e8-3f18-0bbb-a4d0-ee88060f7e90@nextfour.com>
 <20200417114251.oy22udm3b2as32t5@box>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <01262964-e643-da03-5bd9-53c199ef094c@nextfour.com>
Date:   Fri, 17 Apr 2020 15:05:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200417114251.oy22udm3b2as32t5@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1P191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::17)
 To HE1PR0302MB2682.eurprd03.prod.outlook.com (2603:10a6:3:f5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.10.99.7] (194.157.170.35) by HE1P191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 12:05:24 +0000
X-Originating-IP: [194.157.170.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f0c2523-8425-4224-1ccc-08d7e2c79c88
X-MS-TrafficTypeDiagnostic: HE1PR0302MB2811:
X-Microsoft-Antispam-PRVS: <HE1PR0302MB28115FCF7A462E27DA86D72883D90@HE1PR0302MB2811.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0302MB2682.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(376002)(366004)(39830400003)(346002)(396003)(2906002)(31686004)(956004)(2616005)(16526019)(186003)(6486002)(5660300002)(66476007)(8676002)(81156014)(508600001)(4326008)(36756003)(966005)(54906003)(16576012)(6916009)(8936002)(52116002)(86362001)(316002)(26005)(7416002)(31696002)(66556008)(66946007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nextfour.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTfRa09WamMlHTHDqMo3Jd2vXKltSl3ZnZiySRH94x+WgnHzpSjUkxBqRIpIVzsxZlfghq1REZc0GiwtQaflFf7Zbcft5uABtILTHXtUkwj4tneqza9/zLIO2Lwe4ux0z9K48a4SgdEzgOctEt8qc+ylb+H0olIkFF4bAsdyWoJj3JKOO2QDN/9kT/5cHwnDdZk1we/JzMsqaSCrjnFJWDuJ9OjS3ghsQ7vl2clWlraYTj3UESrvsDx2QSs8d1wShltE2lD/5vdyMjMYLd8WN9LuuW1soCtF8rarLqZbLz9r2sV46bd18n7dB2zPNQtOr4opQUt/QFNXTTNWhBKa9aGWMLLj1ylkUWt/z2t5gu9FEJIGq9u6WZa3evNAxrIDNfIrakuHsKZC8IZ0a7QZjVFjDNDbvv4unIya445JgDAfWr6ET2G/pc+2X1+Xp09JbT3l40rEOht6xMF1x/B3SfkLyfdMtxMWVu9ogyoN2ZHGMHx/ZBkraEGmiH1hvblZ9PMbPWgqSFWixnfWfm5FEA==
X-MS-Exchange-AntiSpam-MessageData: vviUZVJ46spgVf9pSrOZE5D00ZoJ8SRBlRv+TMtaMIQG5JbfISN7+jC7kQg1SE1GOwt29qeYuY4gEbOnNMdxDaWxFQOBq3Qi2OyFfEmfMDX4R54N2KNdroHb/LjVwmglDGlVgnGi4C4Ho1+z7BhmYg==
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0c2523-8425-4224-1ccc-08d7e2c79c88
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 12:05:25.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hewjikgtGzrrnIcxNX3o+Fucyy0d7wjy5l6e9+8m4iceUKdy0DSX+2Y/mJnKYaKJ5Fo1jFH/f+j61w9ioRJdmqy2HsAJR1hjSGXmNMuJZm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.4.2020 14.42, Kirill A. Shutemov wrote:
> On Fri, Apr 17, 2020 at 03:52:28AM +0300, Mika Penttilä wrote:
>> Hi!
>>
>> On 17.4.2020 0.32, Kirill A. Shutemov wrote:
>>> Change of attributes of the pages may lead to fragmentation of direct
>>> mapping over time and performance degradation as result.
>>>
>>> With current code it's one way road: kernel tries to avoid splitting
>>> large pages, but it doesn't restore them back even if page attributes
>>> got compatible again.
>>>
>>> Any change to the mapping may potentially allow to restore large page.
>>>
>>> Hook up into cpa_flush() path to check if there's any pages to be
>>> recovered in PUD_SIZE range around pages we've just touched.
>>>
>>> CPUs don't like[1] to have to have TLB entries of different size for the
>>> same memory, but looks like it's okay as long as these entries have
>>> matching attributes[2]. Therefore it's critical to flush TLB before any
>>> following changes to the mapping.
>>>
>>> Note that we already allow for multiple TLB entries of different sizes
>>> for the same memory now in split_large_page() path. It's not a new
>>> situation.
>>>
>>> set_memory_4k() provides a way to use 4k pages on purpose. Kernel must
>>> not remap such pages as large. Re-use one of software PTE bits to
>>> indicate such pages.
>>>
>>> [1] See Erratum 383 of AMD Family 10h Processors
>>> [2] https://lore.kernel.org/linux-mm/1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com/
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> ---
>>>    arch/x86/include/asm/pgtable_types.h |   2 +
>>>    arch/x86/mm/pat/set_memory.c         | 191 ++++++++++++++++++++++++++-
>>>    2 files changed, 188 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
>>> index b6606fe6cfdf..11ed34804343 100644
>>> --- a/arch/x86/include/asm/pgtable_types.h
>>> +++ b/arch/x86/include/asm/pgtable_types.h
>>> @@ -34,6 +34,7 @@
>>>    #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
>>>    #define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
>>>    #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
>>> +#define _PAGE_BIT_KERNEL_4K	_PAGE_BIT_SOFTW3 /* page must not be converted to large */
>>>    #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
>>>    /* If _PAGE_BIT_PRESENT is clear, we use these: */
>>> @@ -56,6 +57,7 @@
>>>    #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
>>>    #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
>>>    #define _PAGE_CPA_TEST	(_AT(pteval_t, 1) << _PAGE_BIT_CPA_TEST)
>>> +#define _PAGE_KERNEL_4K	(_AT(pteval_t, 1) << _PAGE_BIT_KERNEL_4K)
>>>    #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>>>    #define _PAGE_PKEY_BIT0	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT0)
>>>    #define _PAGE_PKEY_BIT1	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT1)
>>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>>> index 5414fabad1ae..7cb04a436d86 100644
>>> --- a/arch/x86/mm/pat/set_memory.c
>>> +++ b/arch/x86/mm/pat/set_memory.c
>>> @@ -344,22 +344,56 @@ static void __cpa_flush_tlb(void *data)
>>>    		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
>>>    }
>>> +static void restore_large_pages(unsigned long addr, struct list_head *pgtables);
>>> +
>>> +static void cpa_restore_large_pages(struct cpa_data *cpa,
>>> +		struct list_head *pgtables)
>>> +{
>>> +	unsigned long start, addr, end;
>>> +	int i;
>>> +
>>> +	if (cpa->flags & CPA_PAGES_ARRAY) {
>>> +		for (i = 0; i < cpa->numpages; i++)
>>> +			restore_large_pages(__cpa_addr(cpa, i), pgtables);
>>> +		return;
>>> +	}
>>> +
>>> +	start = __cpa_addr(cpa, 0);
>>> +	end = start + PAGE_SIZE * cpa->numpages;
>>> +
>>> +	for (addr = start; addr >= start && addr < end; addr += PUD_SIZE)
>>> +		restore_large_pages(addr, pgtables);
>>> +}
>>> +
>>>    static void cpa_flush(struct cpa_data *data, int cache)
>>>    {
>>> +	LIST_HEAD(pgtables);
>>> +	struct page *page, *tmp;
>>>    	struct cpa_data *cpa = data;
>>>    	unsigned int i;
>>>    	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
>>> +	cpa_restore_large_pages(data, &pgtables);
>>> +
>>>    	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
>>>    		cpa_flush_all(cache);
>>> +		list_for_each_entry_safe(page, tmp, &pgtables, lru) {
>>> +			list_del(&page->lru);
>>> +			__free_page(page);
>>> +		}
>>>    		return;
>>>    	}
>>> -	if (cpa->numpages <= tlb_single_page_flush_ceiling)
>>> -		on_each_cpu(__cpa_flush_tlb, cpa, 1);
>>> -	else
>>> +	if (cpa->numpages > tlb_single_page_flush_ceiling || !list_empty(&pgtables))
>>>    		flush_tlb_all();
>>> +	else
>>> +		on_each_cpu(__cpa_flush_tlb, cpa, 1);
>>> +
>>> +	list_for_each_entry_safe(page, tmp, &pgtables, lru) {
>>> +		list_del(&page->lru);
>>> +		__free_page(page);
>>> +	}
>>
>> The pagetable pages are freed here but ren't you leaking the leaf 4K pages
>> (except the first which is made large)?
> Huh? There's no way to convert one 4k to large page. We convert all pages
> in large page region to the large page.
>

Doh, sure and sorry , was short of coffee ...

--Mika

