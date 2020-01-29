Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7EFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D254C2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pdUzwkY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgA2O4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:56:13 -0500
Received: from mail-eopbgr690083.outbound.protection.outlook.com ([40.107.69.83]:57085
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbgA2O4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:56:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx3XKawfR9Uh8ZYzSoOm7cK9fifR9mL6yLchaGJOIhPRqQfRcHoiErvy/80pu3zjUQU/mDlKwsLyPXxl/FWjhNPmvLGdXisljpHMyysZbD8ToUF2Jk7/jjQV1xaJj3j1Jlwl5v3UYSp+/Z4dvEFNQqMHDQSm7j91n5+cqyZZSNbNNoz59JVAyLQfINTL2VE+36IUPI6eYWUysFtTj4hGmzKLbKF/NcBxrgw+AgbJxQpNIJlHMlBeDqMmF0gBLqObR3tO1kNnihdGQxq3rOb1CUPS7pfJx7uWnUuu+Lib8TeYUJztXp+z/FbKTLUYKlcYRWrgVqBuA/cls24tIAfTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUhtwYaagQLLywbromCnv0dVL9Vbxs8Bg1+eSa46dms=;
 b=JE9JduHMmJhzxA1MNYuLwNzWgJrd6jU1/zj0xx39SuOB3ZToGgSAfz+biOvNeGe3wtvYvMhKEIPsg557ny8XkhAbJY5i6HbOCevrJnVBGLpwiGFy7vgV2ydK2r9Nte9VOre+hOdvx2GEe2vWSVKdK6UOjXpscdNlHUBk8fsbwKIPAWf1psTmnUk5BKkEvxTxN98w1M0Eem6hXaxyGiulYKYAQQ/XXXSSBTWwf2eCjDavc2UGm/q0PvsIKA0n+RDTFWBGH2MnULd9J9WyS6dxItuiYL/gfmcOTYuAehfxHX+9H4urwLNuW27OOr7HN9EMU6QgjVkfOSNH/QlTpY9fyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUhtwYaagQLLywbromCnv0dVL9Vbxs8Bg1+eSa46dms=;
 b=pdUzwkY5VhTJ4nEB41gMQlGPb2EzrksXDITbJM9BmeUsI4Yj5ow0sZQ8JiVlsgxNGUwI8b/BCEMDlsuBdcDRF2Amwjjs8LuT0NJ54Vm3mZ09YDUtjJ7YsiaLQSjCH2DS9YjticfPfnIFB6vfp3BuO7Xfr8kpj9GWDiJBY+4QWmY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1435.namprd12.prod.outlook.com (10.168.240.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Wed, 29 Jan 2020 14:56:02 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 14:56:02 +0000
Subject: Re: [PATCH 5/9] mm, drm/ttm, drm/vmwgfx: Support huge TTM pagefaults
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bc30bf7e-5c96-0272-6e7e-64d22490d6a2@amd.com>
Date:   Wed, 29 Jan 2020 15:55:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200124090940.26571-6-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0103.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::44) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR06CA0103.eurprd06.prod.outlook.com (2603:10a6:208:fa::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Wed, 29 Jan 2020 14:55:59 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c494af1-9a07-4d6b-2f52-08d7a4cb5be5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1435FAD0E509043F863AAA1283050@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02973C87BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(39850400004)(376002)(346002)(199004)(189003)(4326008)(478600001)(6666004)(31686004)(66574012)(36756003)(2616005)(54906003)(5660300002)(52116002)(66476007)(16526019)(66556008)(66946007)(81166006)(81156014)(6486002)(316002)(186003)(31696002)(86362001)(8676002)(2906002)(7416002)(8936002)(14583001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1435;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQ59mzG7bexgyn27Ao/uF+pRMoOYRXEbvq6socuLBa5HW85K+vWA1Q/85wwHQ+aEy6ClQLzdt11kQwyrlUqRPNkldD4QeJwbJbcQrReH4YruXe2nEmGWE2BDoijrk3YFBIk86yKTb7jAVspdIwGgr0e/4wjNDW4o/jg6HwdDZLY/cm92LWb8awtPCFFTm54a3iBB+opZ3doWx9ilda+H6AwFMrVCaTTBdOStwFC2E2hdnG63DyCyKzylUVb/MhiPR8cNa5Jj+9eqnJkLNX+TQj0BA9kZmq9QxHmLZik12YPBAR91IkoCUmuVCR1VIPXEacLmJQzNYpvXTZ/1BKGqGknGOhPS9SPAYC0USCAuzimEcI8Kneca3K0imSJ7RhHIrtqTKUEckW0sarwWMzSzsFo11ny1cwDbH4OsVioxJZ7DbKXdZ3/Wn+rFkvkiHD+e2Rqyr/Qombu59icgwgFDvJFyElOLR5aojAG+jxrwr2Uo5pSQNIHIuxxL0J54X6ez
X-MS-Exchange-AntiSpam-MessageData: t2TcOJLD7VoFl9GJS/cbkS2KxwHC8OZrJ6eoaAHaNIKHaaiwx75WiNEZY4FzvExcqZ5UprB7Bp0jeYIEEQ7X3PoINe9qRfCi6zGM95wsuXSiVUXJdtCHLFjRjGQrFHDjqyE46lE8TJ71b9XUFyfEGsngImdd4WtMCXjf10NMrMJgU8i4ZEsL9I7q6fnOkWi8sBJ8Xt6g+mzb4Lzmp6zAkQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c494af1-9a07-4d6b-2f52-08d7a4cb5be5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 14:56:02.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6We7HE/3zzuwllzF3H3Ihddu4erUYK5WyfW+TH9AxyFUx/myfAWZ9RKB38Gq6yHa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.01.20 um 10:09 schrieb Thomas Hellström (VMware):
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> Support huge (PMD-size and PUD-size) page-table entries by providing a
> huge_fault() callback.
> We still support private mappings and write-notify by splitting the huge
> page-table entries on write-access.
>
> Note that for huge page-faults to occur, either the kernel needs to be
> compiled with trans-huge-pages always enabled, or the kernel needs to be
> compiled with trans-huge-pages enabled using madvise, and the user-space
> app needs to call madvise() to enable trans-huge pages on a per-mapping
> basis.
>
> Furthermore huge page-faults will not succeed unless buffer objects and
> user-space addresses are aligned on huge page size boundaries.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Roland Scheidegger <sroland@vmware.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo_vm.c            | 145 ++++++++++++++++++++-
>   drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c |   2 +-
>   include/drm/ttm/ttm_bo_api.h               |   3 +-
>   3 files changed, 145 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 389128b8c4dd..49704261a00d 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -156,6 +156,89 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
>   }
>   EXPORT_SYMBOL(ttm_bo_vm_reserve);
>   
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +/**
> + * ttm_bo_vm_insert_huge - Insert a pfn for PUD or PMD faults
> + * @vmf: Fault data
> + * @bo: The buffer object
> + * @page_offset: Page offset from bo start
> + * @fault_page_size: The size of the fault in pages.
> + * @pgprot: The page protections.
> + * Does additional checking whether it's possible to insert a PUD or PMD
> + * pfn and performs the insertion.
> + *
> + * Return: VM_FAULT_NOPAGE on successful insertion, VM_FAULT_FALLBACK if
> + * a huge fault was not possible, and a VM_FAULT_ERROR code otherwise.
> + */
> +static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
> +					struct ttm_buffer_object *bo,
> +					pgoff_t page_offset,
> +					pgoff_t fault_page_size,
> +					pgprot_t pgprot)
> +{
> +	pgoff_t i;
> +	vm_fault_t ret;
> +	unsigned long pfn;
> +	pfn_t pfnt;
> +	struct ttm_tt *ttm = bo->ttm;
> +	bool write = vmf->flags & FAULT_FLAG_WRITE;
> +
> +	/* Fault should not cross bo boundary. */
> +	page_offset &= ~(fault_page_size - 1);
> +	if (page_offset + fault_page_size > bo->num_pages)
> +		goto out_fallback;
> +
> +	if (bo->mem.bus.is_iomem)
> +		pfn = ttm_bo_io_mem_pfn(bo, page_offset);
> +	else
> +		pfn = page_to_pfn(ttm->pages[page_offset]);
> +
> +	/* pfn must be fault_page_size aligned. */
> +	if ((pfn & (fault_page_size - 1)) != 0)
> +		goto out_fallback;
> +
> +	/* Check that memory is contiguous. */
> +	if (!bo->mem.bus.is_iomem)
> +		for (i = 1; i < fault_page_size; ++i) {
> +			if (page_to_pfn(ttm->pages[page_offset + i]) != pfn + i)
> +				goto out_fallback;
> +		}
> +	/* IO mem without the io_mem_pfn callback is always contiguous. */
> +	else if (bo->bdev->driver->io_mem_pfn)
> +		for (i = 1; i < fault_page_size; ++i) {
> +			if (ttm_bo_io_mem_pfn(bo, page_offset + i) != pfn + i)
> +				goto out_fallback;
> +		}

Maybe add {} to the if to make clear where things start/end.

> +
> +	pfnt = __pfn_to_pfn_t(pfn, PFN_DEV);
> +	if (fault_page_size == (HPAGE_PMD_SIZE >> PAGE_SHIFT))
> +		ret = vmf_insert_pfn_pmd_prot(vmf, pfnt, pgprot, write);
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +	else if (fault_page_size == (HPAGE_PUD_SIZE >> PAGE_SHIFT))
> +		ret = vmf_insert_pfn_pud_prot(vmf, pfnt, pgprot, write);
> +#endif
> +	else
> +		WARN_ON_ONCE(ret = VM_FAULT_FALLBACK);
> +
> +	if (ret != VM_FAULT_NOPAGE)
> +		goto out_fallback;
> +
> +	return VM_FAULT_NOPAGE;
> +out_fallback:
> +	count_vm_event(THP_FAULT_FALLBACK);
> +	return VM_FAULT_FALLBACK;

This doesn't seem to match the function documentation since we never 
return ret here as far as I can see.

Apart from those comments it looks like that should work,
Christian.

> +}
> +#else
> +static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
> +					struct ttm_buffer_object *bo,
> +					pgoff_t page_offset,
> +					pgoff_t fault_page_size,
> +					pgprot_t pgprot)
> +{
> +	return VM_FAULT_NOPAGE;
> +}
> +#endif
> +
>   /**
>    * ttm_bo_vm_fault_reserved - TTM fault helper
>    * @vmf: The struct vm_fault given as argument to the fault callback
> @@ -163,6 +246,7 @@ EXPORT_SYMBOL(ttm_bo_vm_reserve);
>    * @num_prefault: Maximum number of prefault pages. The caller may want to
>    * specify this based on madvice settings and the size of the GPU object
>    * backed by the memory.
> + * @fault_page_size: The size of the fault in pages.
>    *
>    * This function inserts one or more page table entries pointing to the
>    * memory backing the buffer object, and then returns a return code
> @@ -176,7 +260,8 @@ EXPORT_SYMBOL(ttm_bo_vm_reserve);
>    */
>   vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>   				    pgprot_t prot,
> -				    pgoff_t num_prefault)
> +				    pgoff_t num_prefault,
> +				    pgoff_t fault_page_size)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct ttm_buffer_object *bo = vma->vm_private_data;
> @@ -268,6 +353,13 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>   		prot = pgprot_decrypted(prot);
>   	}
>   
> +	/* We don't prefault on huge faults. Yet. */
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && fault_page_size != 1) {
> +		ret = ttm_bo_vm_insert_huge(vmf, bo, page_offset,
> +					    fault_page_size, prot);
> +		goto out_io_unlock;
> +	}
> +
>   	/*
>   	 * Speculatively prefault a number of pages. Only error on
>   	 * first page.
> @@ -334,7 +426,7 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   		return ret;
>   
>   	prot = vma->vm_page_prot;
> -	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT);
> +	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT, 1);
>   	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
>   		return ret;
>   
> @@ -344,6 +436,50 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   }
>   EXPORT_SYMBOL(ttm_bo_vm_fault);
>   
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static vm_fault_t ttm_bo_vm_huge_fault(struct vm_fault *vmf,
> +				       enum page_entry_size pe_size)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	pgprot_t prot;
> +	struct ttm_buffer_object *bo = vma->vm_private_data;
> +	vm_fault_t ret;
> +	pgoff_t fault_page_size = 0;
> +	bool write = vmf->flags & FAULT_FLAG_WRITE;
> +
> +	switch (pe_size) {
> +	case PE_SIZE_PMD:
> +		fault_page_size = HPAGE_PMD_SIZE >> PAGE_SHIFT;
> +		break;
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +	case PE_SIZE_PUD:
> +		fault_page_size = HPAGE_PUD_SIZE >> PAGE_SHIFT;
> +		break;
> +#endif
> +	default:
> +		WARN_ON_ONCE(1);
> +		return VM_FAULT_FALLBACK;
> +	}
> +
> +	/* Fallback on write dirty-tracking or COW */
> +	if (write && !(pgprot_val(vmf->vma->vm_page_prot) & _PAGE_RW))
> +		return VM_FAULT_FALLBACK;
> +
> +	ret = ttm_bo_vm_reserve(bo, vmf);
> +	if (ret)
> +		return ret;
> +
> +	prot = vm_get_page_prot(vma->vm_flags);
> +	ret = ttm_bo_vm_fault_reserved(vmf, prot, 1, fault_page_size);
> +	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
> +		return ret;
> +
> +	dma_resv_unlock(bo->base.resv);
> +
> +	return ret;
> +}
> +#endif
> +
>   void ttm_bo_vm_open(struct vm_area_struct *vma)
>   {
>   	struct ttm_buffer_object *bo = vma->vm_private_data;
> @@ -445,7 +581,10 @@ static const struct vm_operations_struct ttm_bo_vm_ops = {
>   	.fault = ttm_bo_vm_fault,
>   	.open = ttm_bo_vm_open,
>   	.close = ttm_bo_vm_close,
> -	.access = ttm_bo_vm_access
> +	.access = ttm_bo_vm_access,
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	.huge_fault = ttm_bo_vm_huge_fault,
> +#endif
>   };
>   
>   static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_bo_device *bdev,
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
> index f07aa857587c..17a5dca7b921 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
> @@ -477,7 +477,7 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
>   	else
>   		prot = vm_get_page_prot(vma->vm_flags);
>   
> -	ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault);
> +	ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault, 1);
>   	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
>   		return ret;
>   
> diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
> index 66ca49db9633..4fc90d53aa15 100644
> --- a/include/drm/ttm/ttm_bo_api.h
> +++ b/include/drm/ttm/ttm_bo_api.h
> @@ -732,7 +732,8 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
>   
>   vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>   				    pgprot_t prot,
> -				    pgoff_t num_prefault);
> +				    pgoff_t num_prefault,
> +				    pgoff_t fault_page_size);
>   
>   vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf);
>   

