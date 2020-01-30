Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40066C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC8E214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="hjOfqnyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgA3N3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:29:53 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:48002 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbgA3N3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:29:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 13FC24682E;
        Thu, 30 Jan 2020 14:29:50 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=hjOfqnyH;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9b6136BA26Yc; Thu, 30 Jan 2020 14:29:48 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 7B3EE40979;
        Thu, 30 Jan 2020 14:29:44 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 9E48B360093;
        Thu, 30 Jan 2020 14:29:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1580390984; bh=MhnzOXoppfZHCpRyS3zxHusuHTp4sS+W6DeNE1hrFUg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hjOfqnyH+y54HDnpIWXrpyGqZ2VqqtSvpCTnQw64MkO1/NJd6rwtkanfmrBjOPMBS
         TKjBrPGdRWGNQmU8QjdPimKq2r6I8bL0tRUG6KmRKeW++w/gh6n3DY/+Mv26I1ljct
         RWvpkaXxqdHqbuajuJR0ksiF7FJv6ZN1EsKQTYuQ=
Subject: Re: [PATCH 5/9] mm, drm/ttm, drm/vmwgfx: Support huge TTM pagefaults
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Roland Scheidegger <sroland@vmware.com>
References: <20200124090940.26571-1-thomas_os@shipmail.org>
 <20200124090940.26571-6-thomas_os@shipmail.org>
 <bc30bf7e-5c96-0272-6e7e-64d22490d6a2@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <615c9c1f-2e53-2c0e-7722-661bcf81554d@shipmail.org>
Date:   Thu, 30 Jan 2020 14:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bc30bf7e-5c96-0272-6e7e-64d22490d6a2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/20 3:55 PM, Christian König wrote:
> Am 24.01.20 um 10:09 schrieb Thomas Hellström (VMware):
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> Support huge (PMD-size and PUD-size) page-table entries by providing a
>> huge_fault() callback.
>> We still support private mappings and write-notify by splitting the huge
>> page-table entries on write-access.
>>
>> Note that for huge page-faults to occur, either the kernel needs to be
>> compiled with trans-huge-pages always enabled, or the kernel needs to be
>> compiled with trans-huge-pages enabled using madvise, and the user-space
>> app needs to call madvise() to enable trans-huge pages on a per-mapping
>> basis.
>>
>> Furthermore huge page-faults will not succeed unless buffer objects and
>> user-space addresses are aligned on huge page size boundaries.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>> Cc: "Christian König" <christian.koenig@amd.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>> Reviewed-by: Roland Scheidegger <sroland@vmware.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo_vm.c            | 145 ++++++++++++++++++++-
>>   drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c |   2 +-
>>   include/drm/ttm/ttm_bo_api.h               |   3 +-
>>   3 files changed, 145 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c 
>> b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> index 389128b8c4dd..49704261a00d 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> @@ -156,6 +156,89 @@ vm_fault_t ttm_bo_vm_reserve(struct 
>> ttm_buffer_object *bo,
>>   }
>>   EXPORT_SYMBOL(ttm_bo_vm_reserve);
>>   +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +/**
>> + * ttm_bo_vm_insert_huge - Insert a pfn for PUD or PMD faults
>> + * @vmf: Fault data
>> + * @bo: The buffer object
>> + * @page_offset: Page offset from bo start
>> + * @fault_page_size: The size of the fault in pages.
>> + * @pgprot: The page protections.
>> + * Does additional checking whether it's possible to insert a PUD or 
>> PMD
>> + * pfn and performs the insertion.
>> + *
>> + * Return: VM_FAULT_NOPAGE on successful insertion, 
>> VM_FAULT_FALLBACK if
>> + * a huge fault was not possible, and a VM_FAULT_ERROR code otherwise.
>> + */
>> +static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
>> +                    struct ttm_buffer_object *bo,
>> +                    pgoff_t page_offset,
>> +                    pgoff_t fault_page_size,
>> +                    pgprot_t pgprot)
>> +{
>> +    pgoff_t i;
>> +    vm_fault_t ret;
>> +    unsigned long pfn;
>> +    pfn_t pfnt;
>> +    struct ttm_tt *ttm = bo->ttm;
>> +    bool write = vmf->flags & FAULT_FLAG_WRITE;
>> +
>> +    /* Fault should not cross bo boundary. */
>> +    page_offset &= ~(fault_page_size - 1);
>> +    if (page_offset + fault_page_size > bo->num_pages)
>> +        goto out_fallback;
>> +
>> +    if (bo->mem.bus.is_iomem)
>> +        pfn = ttm_bo_io_mem_pfn(bo, page_offset);
>> +    else
>> +        pfn = page_to_pfn(ttm->pages[page_offset]);
>> +
>> +    /* pfn must be fault_page_size aligned. */
>> +    if ((pfn & (fault_page_size - 1)) != 0)
>> +        goto out_fallback;
>> +
>> +    /* Check that memory is contiguous. */
>> +    if (!bo->mem.bus.is_iomem)
>> +        for (i = 1; i < fault_page_size; ++i) {
>> +            if (page_to_pfn(ttm->pages[page_offset + i]) != pfn + i)
>> +                goto out_fallback;
>> +        }
>> +    /* IO mem without the io_mem_pfn callback is always contiguous. */
>> +    else if (bo->bdev->driver->io_mem_pfn)
>> +        for (i = 1; i < fault_page_size; ++i) {
>> +            if (ttm_bo_io_mem_pfn(bo, page_offset + i) != pfn + i)
>> +                goto out_fallback;
>> +        }
>
> Maybe add {} to the if to make clear where things start/end.
>
>> +
>> +    pfnt = __pfn_to_pfn_t(pfn, PFN_DEV);
>> +    if (fault_page_size == (HPAGE_PMD_SIZE >> PAGE_SHIFT))
>> +        ret = vmf_insert_pfn_pmd_prot(vmf, pfnt, pgprot, write);
>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>> +    else if (fault_page_size == (HPAGE_PUD_SIZE >> PAGE_SHIFT))
>> +        ret = vmf_insert_pfn_pud_prot(vmf, pfnt, pgprot, write);
>> +#endif
>> +    else
>> +        WARN_ON_ONCE(ret = VM_FAULT_FALLBACK);
>> +
>> +    if (ret != VM_FAULT_NOPAGE)
>> +        goto out_fallback;
>> +
>> +    return VM_FAULT_NOPAGE;
>> +out_fallback:
>> +    count_vm_event(THP_FAULT_FALLBACK);
>> +    return VM_FAULT_FALLBACK;
>
> This doesn't seem to match the function documentation since we never 
> return ret here as far as I can see.
>
> Apart from those comments it looks like that should work,
> Christian.


Thanks for reviewing, Christian. I'll update the next version with your 
feedback.

/Thomas


