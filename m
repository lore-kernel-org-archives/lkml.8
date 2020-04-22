Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE870C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DBA20882
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xDufRllK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDVRw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:52:56 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:6267
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbgDVRwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:52:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTVhhybvo5wjFOdPvCFKmhZy0WZX+nwUaDxB2dzQh8tdmSU/8GL9bh967AWbpbLWgc0WKTesZNysh7F0YOtCyQuJXgeWKAyMqgIlWbazxQ7WgQvwkJhO+tSRiVwEfOGPpSpOHU4DDhAu0CTWRdxxcIW7MsN0yUMqwaLaV1k4ev7hiiaJx4Md8Qvuaz80p9Gzg6BS/jZlxbeF/ZCMB2at1M06eTHICbaScWTTnQ0g1C4I5O9RyVIxCkbRqsQRmLD61Y0EiSl4qJCX29+6JZ73iSZ1Nx0HJ3JrVN6QutXIoX0oHAslPfHOr7VJ4PGobVDKydyZwFWA1vrhSmXyDXLD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suVau5EiBBUObCzCKexirZYCHmeuzKwKnG2q4nEOzeo=;
 b=eiNqWGaoAMNNDZ9SdRVYyTPfveVXJ4QiIgCQN0cfr+UKONUTRwz4eh/vIJBPOm9o9q09pBvWJa2RK5VjXbe9b7RFSuyXmJxCeV1e8AUQ1+3jLvtbDvwskTMmRAZT13CfveDNyHtqNoRBoTmqa+UKUxoyfqxn7VmBMRhhPxJu1j0iNlqKvDMWYLFB5TmFKr1p0k4wu0j0klrC0jPRoF05a0Kj9zOvltfMCmwxHJi5Kb6i6WbYyx26rLLoH5rUfQ0F6ORLVlD9CF4q7MiGpWX1pM3/ifbKpZ1BsyFM2hAMarqE+7IxXlcIVzWJmIz7qX9ZGxa/GtUdXRiUPwJGn1sbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suVau5EiBBUObCzCKexirZYCHmeuzKwKnG2q4nEOzeo=;
 b=xDufRllKZNptCO2HErv7emJj8Lv0dVLBRRRL9bR1ADmVhQpBDMAZT0H3h9VaBNeh8FL5uA3S6ucwU/1Xs2ytPjBTnArGhuZxljuvTmziOyiT+eOIskoJslPVJX3Dr1AdTtqqIvhPJtrcz7uohk/xsCFh0nqZDc2lGsFKqs/j0is=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2432.namprd12.prod.outlook.com (2603:10b6:802:29::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 17:52:36 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 17:52:36 +0000
Subject: Re: [PATCH hmm 5/5] mm/hmm: remove the customizable pfn format from
 hmm_range_fault
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Yang, Philip" <Philip.Yang@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org
References: <5-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ec276ac2-a346-5728-4ac6-9c9bd9ffcd41@amd.com>
Date:   Wed, 22 Apr 2020 13:52:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <5-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::22) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by YQBPR01CA0086.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 17:52:34 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38dbb970-3dde-4c64-16c6-08d7e6e5f091
X-MS-TrafficTypeDiagnostic: SN1PR12MB2432:|SN1PR12MB2432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2432FA816401C59FEBF9BD8192D20@SN1PR12MB2432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(86362001)(31686004)(66556008)(44832011)(2616005)(4326008)(956004)(31696002)(66476007)(186003)(6486002)(66946007)(16526019)(26005)(36756003)(54906003)(110136005)(7416002)(316002)(16576012)(8936002)(5660300002)(478600001)(30864003)(2906002)(8676002)(6636002)(81156014)(52116002)(21314003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bJqRGyQuymUYqx3R2Di2ElOTQ+GG984VY+gG7SmF3RJWjdcQ/LGQ/vqxIYMoNHNlZR/WBSi0AUI+n74ZcPUwu6igN5knW13BQl5Z6udwhWxpC9Hd0Jx7JbCuwpctZlyKv2r6e+tapSTDybB3X7YeTn1pXVEJ1Di8lL9zI+FzHnJ/mOqHLDW1t/v/X7vklc8gPjtxaeOB0LWNTVxT/agLlAQ6g1P+EeI8+uH8UOkC9L9nkBLkzCA3dIMDzSHfaKJE1HP1G/5aSNfZNBau6ZaKzVKvzKwWFaHyjqWcXTZ9uc9mGZ/GTNBUFK13WYK0X1yujId90dMLhGJ1CR60v5p0tnzuZBCbEhnlxPy3acIFU1hcJFPa0hYmAmLUnhXnTijjvgdPZoxRAEv16t3c3e8l4nt4Z3NkWAlJQzMGNDRkw901ilOfpy6fvtS/Yu/E4as8j6iuW3wRANJDO3Sb6btb8h5L7RnPBlwxmF21ZhXIZI=
X-MS-Exchange-AntiSpam-MessageData: A/p+nH/3LM4XiR/cMcwuziDTYW5C5gGM9FDiDY/+410MT9g1zjqJob0o1KrmHpn7zOkmrtbzE0JJ7VSlYMdOKqCeTMy888QaUFLUWBuqAwzYyAK1ZjA6jgrL3MNVvq3byYL9FzWUffY34mk2qoaKhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dbb970-3dde-4c64-16c6-08d7e6e5f091
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 17:52:35.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyV1rsnAsduW7VxFHfLYG3sE2GmBr6piPWuszR6qTa5uhCrqrTDZjF6jFlasjYNpfePf4gpA+dnpGIsu1Rdcvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Philip Yang]

Am 2020-04-21 um 8:21 p.m. schrieb Jason Gunthorpe:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> Presumably the intent here was that hmm_range_fault() could put the data
> into some HW specific format and thus avoid some work. However, nothing
> actually does that, and it isn't clear how anything actually could do that
> as hmm_range_fault() provides CPU addresses which must be DMA mapped.
>
> Perhaps there is some special HW that does not need DMA mapping, but we
> don't have any examples of this, and the theoretical performance win of
> avoiding an extra scan over the pfns array doesn't seem worth the
> complexity. Plus pfns needs to be scanned anyhow to sort out any
> DEVICE_PRIVATE pages.
>
> This version replaces the uint64_t with an usigned long containing a pfn
> and fix flags. On input flags is filled with the HMM_PFN_REQ_* values, on
> successful output it is filled with HMM_PFN_* values, describing the state
> of the pages.
>
> amdgpu is simple to convert, it doesn't use snapshot and doesn't use
> per-page flags.
>
> nouveau uses only 16 hmm_pte entries at most (ie fits in a few cache
> lines), and it sweeps over its pfns array a couple of times anyhow.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hi Jason,

I pointed out a typo in the documentation inline. Other than that, the
series is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

I'll try to build it and run some basic tests later.


> ---
>  Documentation/vm/hmm.rst                |  26 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  35 ++----
>  drivers/gpu/drm/nouveau/nouveau_dmem.c  |  60 +++++++--
>  drivers/gpu/drm/nouveau/nouveau_dmem.h  |   4 +-
>  drivers/gpu/drm/nouveau/nouveau_svm.c   |  52 ++++----
>  include/linux/hmm.h                     |  99 ++++++---------
>  mm/hmm.c                                | 160 +++++++++++-------------
>  7 files changed, 204 insertions(+), 232 deletions(-)
>
> diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
> index 9924f2caa0184c..73a9b8c858e5d9 100644
> --- a/Documentation/vm/hmm.rst
> +++ b/Documentation/vm/hmm.rst
> @@ -185,9 +185,6 @@ The usage pattern is::
>        range.start = ...;
>        range.end = ...;
>        range.pfns = ...;
> -      range.flags = ...;
> -      range.values = ...;
> -      range.pfn_shift = ...;
>  
>        if (!mmget_not_zero(interval_sub->notifier.mm))
>            return -EFAULT;
> @@ -229,15 +226,10 @@ The hmm_range struct has 2 fields, default_flags and pfn_flags_mask, that specif
>  fault or snapshot policy for the whole range instead of having to set them
>  for each entry in the pfns array.
>  
> -For instance, if the device flags for range.flags are::
> +For instance if the device driver wants pages for a range with at least read
> +permission, it sets::
>  
> -    range.flags[HMM_PFN_VALID] = (1 << 63);
> -    range.flags[HMM_PFN_WRITE] = (1 << 62);
> -
> -and the device driver wants pages for a range with at least read permission,
> -it sets::
> -
> -    range->default_flags = (1 << 63);
> +    range->default_flags = HMM_PFN_REQ_VALID;

This should be HMM_PFN_REQ_FAULT.


>      range->pfn_flags_mask = 0;
>  
>  and calls hmm_range_fault() as described above. This will fill fault all pages
> @@ -246,18 +238,18 @@ in the range with at least read permission.
>  Now let's say the driver wants to do the same except for one page in the range for
>  which it wants to have write permission. Now driver set::
>  
> -    range->default_flags = (1 << 63);
> -    range->pfn_flags_mask = (1 << 62);
> -    range->pfns[index_of_write] = (1 << 62);
> +    range->default_flags = HMM_PFN_REQ_VALID;

HMM_PFN_REQ_FAULT

Regards,
  Felix


> +    range->pfn_flags_mask = HMM_PFN_REQ_WRITE;
> +    range->pfns[index_of_write] = HMM_PFN_REQ_WRITE;
>  
>  With this, HMM will fault in all pages with at least read (i.e., valid) and for the
>  address == range->start + (index_of_write << PAGE_SHIFT) it will fault with
>  write permission i.e., if the CPU pte does not have write permission set then HMM
>  will call handle_mm_fault().
>  
> -Note that HMM will populate the pfns array with write permission for any page
> -that is mapped with CPU write permission no matter what values are set
> -in default_flags or pfn_flags_mask.
> +After hmm_range_fault completes the flag bits are set to the current state of
> +the page tables, ie HMM_PFN_VALID | HMM_PFN_WRITE will be set if the page is
> +writable.
>  
>  
>  Represent and manage device memory from core kernel point of view
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 449083f9f8a2bf..bcfa8c26647d5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -766,17 +766,6 @@ struct amdgpu_ttm_tt {
>  };
>  
>  #ifdef CONFIG_DRM_AMDGPU_USERPTR
> -/* flags used by HMM internal, not related to CPU/GPU PTE flags */
> -static const uint64_t hmm_range_flags[HMM_PFN_FLAG_MAX] = {
> -	(1 << 0), /* HMM_PFN_VALID */
> -	(1 << 1), /* HMM_PFN_WRITE */
> -};
> -
> -static const uint64_t hmm_range_values[HMM_PFN_VALUE_MAX] = {
> -	0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
> -	0, /* HMM_PFN_NONE */
> -};
> -
>  /**
>   * amdgpu_ttm_tt_get_user_pages - get device accessible pages that back user
>   * memory and start HMM tracking CPU page table update
> @@ -815,18 +804,15 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>  		goto out;
>  	}
>  	range->notifier = &bo->notifier;
> -	range->flags = hmm_range_flags;
> -	range->values = hmm_range_values;
> -	range->pfn_shift = PAGE_SHIFT;
>  	range->start = bo->notifier.interval_tree.start;
>  	range->end = bo->notifier.interval_tree.last + 1;
> -	range->default_flags = hmm_range_flags[HMM_PFN_VALID];
> +	range->default_flags = HMM_PFN_REQ_FAULT;
>  	if (!amdgpu_ttm_tt_is_readonly(ttm))
> -		range->default_flags |= range->flags[HMM_PFN_WRITE];
> +		range->default_flags |= HMM_PFN_REQ_WRITE;
>  
> -	range->pfns = kvmalloc_array(ttm->num_pages, sizeof(*range->pfns),
> -				     GFP_KERNEL);
> -	if (unlikely(!range->pfns)) {
> +	range->hmm_pfns = kvmalloc_array(ttm->num_pages,
> +					 sizeof(*range->hmm_pfns), GFP_KERNEL);
> +	if (unlikely(!range->hmm_pfns)) {
>  		r = -ENOMEM;
>  		goto out_free_ranges;
>  	}
> @@ -867,7 +853,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>  	 * the notifier_lock, and mmu_interval_read_retry() must be done first.
>  	 */
>  	for (i = 0; i < ttm->num_pages; i++)
> -		pages[i] = hmm_device_entry_to_page(range, range->pfns[i]);
> +		pages[i] = hmm_pfn_to_page(range->hmm_pfns[i]);
>  
>  	gtt->range = range;
>  	mmput(mm);
> @@ -877,7 +863,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>  out_unlock:
>  	up_read(&mm->mmap_sem);
>  out_free_pfns:
> -	kvfree(range->pfns);
> +	kvfree(range->hmm_pfns);
>  out_free_ranges:
>  	kfree(range);
>  out:
> @@ -902,7 +888,7 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
>  	DRM_DEBUG_DRIVER("user_pages_done 0x%llx pages 0x%lx\n",
>  		gtt->userptr, ttm->num_pages);
>  
> -	WARN_ONCE(!gtt->range || !gtt->range->pfns,
> +	WARN_ONCE(!gtt->range || !gtt->range->hmm_pfns,
>  		"No user pages to check\n");
>  
>  	if (gtt->range) {
> @@ -912,7 +898,7 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
>  		 */
>  		r = mmu_interval_read_retry(gtt->range->notifier,
>  					 gtt->range->notifier_seq);
> -		kvfree(gtt->range->pfns);
> +		kvfree(gtt->range->hmm_pfns);
>  		kfree(gtt->range);
>  		gtt->range = NULL;
>  	}
> @@ -1003,8 +989,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
>  
>  		for (i = 0; i < ttm->num_pages; i++) {
>  			if (ttm->pages[i] !=
> -				hmm_device_entry_to_page(gtt->range,
> -					      gtt->range->pfns[i]))
> +			    hmm_pfn_to_page(gtt->range->hmm_pfns[i]))
>  				break;
>  		}
>  
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index ad89e09a0be39a..07876fb0e1d665 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -672,27 +672,61 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
>  	return ret;
>  }
>  
> -void
> -nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
> -			 struct hmm_range *range)
> +void nouveau_hmm_convert_pfn(struct nouveau_drm *drm, struct hmm_range *range,
> +			     u64 *ioctl_addr)
>  {
>  	unsigned long i, npages;
>  
> +	/*
> +	 * The ioctl_addr prepared here is passed through nvif_object_ioctl()
> +	 * to an eventual DMA map on some call chain like:
> +	 *    nouveau_svm_fault():
> +	 *      args.i.m.method = NVIF_VMM_V0_PFNMAP
> +	 *      nouveau_range_fault()
> +	 *       nvif_object_ioctl()
> +	 *        client->driver->ioctl()
> +	 *           struct nvif_driver nvif_driver_nvkm:
> +	 *             .ioctl = nvkm_client_ioctl
> +	 *            nvkm_ioctl()
> +	 *             nvkm_ioctl_path()
> +	 *               nvkm_ioctl_v0[type].func(..)
> +	 *               nvkm_ioctl_mthd()
> +	 *                nvkm_object_mthd()
> +	 *                   struct nvkm_object_func nvkm_uvmm:
> +	 *                     .mthd = nvkm_uvmm_mthd
> +	 *                    nvkm_uvmm_mthd()
> +	 *                     nvkm_uvmm_mthd_pfnmap()
> +	 *                      nvkm_vmm_pfn_map()
> +	 *                       nvkm_vmm_ptes_get_map()
> +	 *                        func == gp100_vmm_pgt_pfn
> +	 *                         struct nvkm_vmm_desc_func gp100_vmm_desc_spt:
> +	 *                           .pfn = gp100_vmm_pgt_pfn
> +	 *                          nvkm_vmm_iter()
> +	 *                           REF_PTES == func == gp100_vmm_pgt_pfn()
> +	 *			      dma_map_page()
> +	 *
> +	 * This is all just encoding the internal hmm reprensetation into a
> +	 * different nouveau internal representation.
> +	 */
>  	npages = (range->end - range->start) >> PAGE_SHIFT;
>  	for (i = 0; i < npages; ++i) {
>  		struct page *page;
> -		uint64_t addr;
>  
> -		page = hmm_device_entry_to_page(range, range->pfns[i]);
> -		if (page == NULL)
> -			continue;
> -
> -		if (!is_device_private_page(page))
> +		if (!(range->hmm_pfns[i] & HMM_PFN_VALID)) {
> +			ioctl_addr[i] = 0;
>  			continue;
> +		}
>  
> -		addr = nouveau_dmem_page_addr(page);
> -		range->pfns[i] &= ((1UL << range->pfn_shift) - 1);
> -		range->pfns[i] |= (addr >> PAGE_SHIFT) << range->pfn_shift;
> -		range->pfns[i] |= NVIF_VMM_PFNMAP_V0_VRAM;
> +		page = hmm_pfn_to_page(range->hmm_pfns[i]);
> +		if (is_device_private_page(page))
> +			ioctl_addr[i] = nouveau_dmem_page_addr(page) |
> +					NVIF_VMM_PFNMAP_V0_V |
> +					NVIF_VMM_PFNMAP_V0_VRAM;
> +		else
> +			ioctl_addr[i] = page_to_phys(page) |
> +					NVIF_VMM_PFNMAP_V0_V |
> +					NVIF_VMM_PFNMAP_V0_HOST;
> +		if (range->hmm_pfns[i] & HMM_PFN_WRITE)
> +			ioctl_addr[i] |= NVIF_VMM_PFNMAP_V0_W;
>  	}
>  }
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.h b/drivers/gpu/drm/nouveau/nouveau_dmem.h
> index 92394be5d64923..4607c0be7dd062 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.h
> @@ -38,8 +38,8 @@ int nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
>  			     unsigned long start,
>  			     unsigned long end);
>  
> -void nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
> -			      struct hmm_range *range);
> +void nouveau_hmm_convert_pfn(struct nouveau_drm *drm, struct hmm_range *range,
> +			     u64 *ioctl_addr);
>  #else /* IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM) */
>  static inline void nouveau_dmem_init(struct nouveau_drm *drm) {}
>  static inline void nouveau_dmem_fini(struct nouveau_drm *drm) {}
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index cf0d9bd61bebf9..d1059bce091192 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -369,18 +369,6 @@ nouveau_svmm_init(struct drm_device *dev, void *data,
>  	return ret;
>  }
>  
> -static const u64
> -nouveau_svm_pfn_flags[HMM_PFN_FLAG_MAX] = {
> -	[HMM_PFN_VALID         ] = NVIF_VMM_PFNMAP_V0_V,
> -	[HMM_PFN_WRITE         ] = NVIF_VMM_PFNMAP_V0_W,
> -};
> -
> -static const u64
> -nouveau_svm_pfn_values[HMM_PFN_VALUE_MAX] = {
> -	[HMM_PFN_ERROR  ] = ~NVIF_VMM_PFNMAP_V0_V,
> -	[HMM_PFN_NONE   ] =  NVIF_VMM_PFNMAP_V0_NONE,
> -};
> -
>  /* Issue fault replay for GPU to retry accesses that faulted previously. */
>  static void
>  nouveau_svm_fault_replay(struct nouveau_svm *svm)
> @@ -520,7 +508,8 @@ static const struct mmu_interval_notifier_ops nouveau_svm_mni_ops = {
>  
>  static int nouveau_range_fault(struct nouveau_svmm *svmm,
>  			       struct nouveau_drm *drm, void *data, u32 size,
> -			       u64 *pfns, struct svm_notifier *notifier)
> +			       unsigned long hmm_pfns[], u64 *ioctl_addr,
> +			       struct svm_notifier *notifier)
>  {
>  	unsigned long timeout =
>  		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> @@ -529,10 +518,8 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
>  		.notifier = &notifier->notifier,
>  		.start = notifier->notifier.interval_tree.start,
>  		.end = notifier->notifier.interval_tree.last + 1,
> -		.pfns = pfns,
> -		.flags = nouveau_svm_pfn_flags,
> -		.values = nouveau_svm_pfn_values,
> -		.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT,
> +		.pfn_flags_mask = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
> +		.hmm_pfns = hmm_pfns,
>  	};
>  	struct mm_struct *mm = notifier->notifier.mm;
>  	int ret;
> @@ -542,12 +529,15 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
>  			return -EBUSY;
>  
>  		range.notifier_seq = mmu_interval_read_begin(range.notifier);
> -		range.default_flags = 0;
> -		range.pfn_flags_mask = -1UL;
>  		down_read(&mm->mmap_sem);
>  		ret = hmm_range_fault(&range);
>  		up_read(&mm->mmap_sem);
>  		if (ret) {
> +			/*
> +			 * FIXME: the input PFN_REQ flags are destroyed on
> +			 * -EBUSY, we need to regenerate them, also for the
> +			 * other continue below
> +			 */
>  			if (ret == -EBUSY)
>  				continue;
>  			return ret;
> @@ -562,7 +552,7 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
>  		break;
>  	}
>  
> -	nouveau_dmem_convert_pfn(drm, &range);
> +	nouveau_hmm_convert_pfn(drm, &range, ioctl_addr);
>  
>  	svmm->vmm->vmm.object.client->super = true;
>  	ret = nvif_object_ioctl(&svmm->vmm->vmm.object, data, size, NULL);
> @@ -589,6 +579,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
>  		} i;
>  		u64 phys[16];
>  	} args;
> +	unsigned long hmm_pfns[ARRAY_SIZE(args.phys)];
>  	struct vm_area_struct *vma;
>  	u64 inst, start, limit;
>  	int fi, fn, pi, fill;
> @@ -704,12 +695,17 @@ nouveau_svm_fault(struct nvif_notify *notify)
>  			 * access flags.
>  			 *XXX: atomic?
>  			 */
> -			if (buffer->fault[fn]->access != 0 /* READ. */ &&
> -			    buffer->fault[fn]->access != 3 /* PREFETCH. */) {
> -				args.phys[pi++] = NVIF_VMM_PFNMAP_V0_V |
> -						  NVIF_VMM_PFNMAP_V0_W;
> -			} else {
> -				args.phys[pi++] = NVIF_VMM_PFNMAP_V0_V;
> +			switch (buffer->fault[fn]->access) {
> +			case 0: /* READ. */
> +				hmm_pfns[pi++] = HMM_PFN_REQ_FAULT;
> +				break;
> +			case 3: /* PREFETCH. */
> +				hmm_pfns[pi++] = 0;
> +				break;
> +			default:
> +				hmm_pfns[pi++] = HMM_PFN_REQ_FAULT |
> +						 HMM_PFN_REQ_WRITE;
> +				break;
>  			}
>  			args.i.p.size = pi << PAGE_SHIFT;
>  
> @@ -737,7 +733,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
>  			fill = (buffer->fault[fn    ]->addr -
>  				buffer->fault[fn - 1]->addr) >> PAGE_SHIFT;
>  			while (--fill)
> -				args.phys[pi++] = NVIF_VMM_PFNMAP_V0_NONE;
> +				hmm_pfns[pi++] = 0;
>  		}
>  
>  		SVMM_DBG(svmm, "wndw %016llx-%016llx covering %d fault(s)",
> @@ -753,7 +749,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
>  			ret = nouveau_range_fault(
>  				svmm, svm->drm, &args,
>  				sizeof(args.i) + pi * sizeof(args.phys[0]),
> -				args.phys, &notifier);
> +				hmm_pfns, args.phys, &notifier);
>  			mmu_interval_notifier_remove(&notifier.notifier);
>  		}
>  		mmput(mm);
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 81c302c884c0e3..e72529786f16f8 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -19,45 +19,45 @@
>  #include <linux/mmu_notifier.h>
>  
>  /*
> - * hmm_pfn_flag_e - HMM flag enums
> + * On output:
> + * 0             - The page is faultable and a future call with 
> + *                 HMM_PFN_REQ_FAULT could succeed.
> + * HMM_PFN_VALID - the pfn field points to a valid PFN. This PFN is at
> + *                 least readable. If dev_private_owner is !NULL then this could
> + *                 point at a DEVICE_PRIVATE page.
> + * HMM_PFN_WRITE - if the page memory can be written to (requires HMM_PFN_VALID)
> + * HMM_PFN_ERROR - accessing the pfn is impossible and the device should
> + *                 fail. ie poisoned memory, special pages, no vma, etc
>   *
> - * Flags:
> - * HMM_PFN_VALID: pfn is valid. It has, at least, read permission.
> - * HMM_PFN_WRITE: CPU page table has write permission set
> - *
> - * The driver provides a flags array for mapping page protections to device
> - * PTE bits. If the driver valid bit for an entry is bit 3,
> - * i.e., (entry & (1 << 3)), then the driver must provide
> - * an array in hmm_range.flags with hmm_range.flags[HMM_PFN_VALID] == 1 << 3.
> - * Same logic apply to all flags. This is the same idea as vm_page_prot in vma
> - * except that this is per device driver rather than per architecture.
> + * On input:
> + * 0                 - Return the current state of the page, do not fault it.
> + * HMM_PFN_REQ_FAULT - The output must have HMM_PFN_VALID or hmm_range_fault()
> + *                     will fail
> + * HMM_PFN_REQ_WRITE - The output must have HMM_PFN_WRITE or hmm_range_fault()
> + *                     will fail. Must be combined with HMM_PFN_REQ_FAULT.
>   */
> -enum hmm_pfn_flag_e {
> -	HMM_PFN_VALID = 0,
> -	HMM_PFN_WRITE,
> -	HMM_PFN_FLAG_MAX
> +enum hmm_pfn_flags {
> +	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
> +	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
> +	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
> +
> +	HMM_PFN_REQ_FAULT = HMM_PFN_VALID,
> +	HMM_PFN_REQ_WRITE = HMM_PFN_WRITE,
> +
> +	HMM_PFN_FLAGS = HMM_PFN_VALID | HMM_PFN_WRITE | HMM_PFN_ERROR,
>  };
>  
>  /*
> - * hmm_pfn_value_e - HMM pfn special value
> - *
> - * Flags:
> - * HMM_PFN_ERROR: corresponding CPU page table entry points to poisoned memory
> - * HMM_PFN_NONE: corresponding CPU page table entry is pte_none()
> + * hmm_pfn_to_page() - return struct page pointed to by a device entry
>   *
> - * Driver provides values for none entry, error entry, and special entry.
> - * Driver can alias (i.e., use same value) error and special, but
> - * it should not alias none with error or special.
> - *
> - * HMM pfn value returned by hmm_vma_get_pfns() or hmm_vma_fault() will be:
> - * hmm_range.values[HMM_PFN_ERROR] if CPU page table entry is poisonous,
> - * hmm_range.values[HMM_PFN_NONE] if there is no CPU page table entry,
> + * This must be called under the caller 'user_lock' after a successful
> + * mmu_interval_read_begin(). The caller must have tested for HMM_PFN_VALID
> + * already.
>   */
> -enum hmm_pfn_value_e {
> -	HMM_PFN_ERROR,
> -	HMM_PFN_NONE,
> -	HMM_PFN_VALUE_MAX
> -};
> +static inline struct page *hmm_pfn_to_page(unsigned long hmm_pfn)
> +{
> +	return pfn_to_page(hmm_pfn & ~HMM_PFN_FLAGS);
> +}
>  
>  /*
>   * struct hmm_range - track invalidation lock on virtual address range
> @@ -66,12 +66,9 @@ enum hmm_pfn_value_e {
>   * @notifier_seq: result of mmu_interval_read_begin()
>   * @start: range virtual start address (inclusive)
>   * @end: range virtual end address (exclusive)
> - * @pfns: array of pfns (big enough for the range)
> - * @flags: pfn flags to match device driver page table
> - * @values: pfn value for some special case (none, special, error, ...)
> + * @hmm_pfns: array of pfns (big enough for the range)
>   * @default_flags: default flags for the range (write, read, ... see hmm doc)
>   * @pfn_flags_mask: allows to mask pfn flags so that only default_flags matter
> - * @pfn_shift: pfn shift value (should be <= PAGE_SHIFT)
>   * @dev_private_owner: owner of device private pages
>   */
>  struct hmm_range {
> @@ -79,36 +76,12 @@ struct hmm_range {
>  	unsigned long		notifier_seq;
>  	unsigned long		start;
>  	unsigned long		end;
> -	uint64_t		*pfns;
> -	const uint64_t		*flags;
> -	const uint64_t		*values;
> -	uint64_t		default_flags;
> -	uint64_t		pfn_flags_mask;
> -	uint8_t			pfn_shift;
> +	unsigned long		*hmm_pfns;
> +	unsigned long		default_flags;
> +	unsigned long		pfn_flags_mask;
>  	void			*dev_private_owner;
>  };
>  
> -/*
> - * hmm_device_entry_to_page() - return struct page pointed to by a device entry
> - * @range: range use to decode device entry value
> - * @entry: device entry value to get corresponding struct page from
> - * Return: struct page pointer if entry is a valid, NULL otherwise
> - *
> - * If the device entry is valid (ie valid flag set) then return the struct page
> - * matching the entry value. Otherwise return NULL.
> - */
> -static inline struct page *hmm_device_entry_to_page(const struct hmm_range *range,
> -						    uint64_t entry)
> -{
> -	if (entry == range->values[HMM_PFN_NONE])
> -		return NULL;
> -	if (entry == range->values[HMM_PFN_ERROR])
> -		return NULL;
> -	if (!(entry & range->flags[HMM_PFN_VALID]))
> -		return NULL;
> -	return pfn_to_page(entry >> range->pfn_shift);
> -}
> -
>  /*
>   * Please see Documentation/vm/hmm.rst for how to use the range API.
>   */
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 2693393dc14b30..c1c96d4cc0554c 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -37,28 +37,13 @@ enum {
>  	HMM_NEED_ALL_BITS = HMM_NEED_FAULT | HMM_NEED_WRITE_FAULT,
>  };
>  
> -/*
> - * hmm_device_entry_from_pfn() - create a valid device entry value from pfn
> - * @range: range use to encode HMM pfn value
> - * @pfn: pfn value for which to create the device entry
> - * Return: valid device entry for the pfn
> - */
> -static uint64_t hmm_device_entry_from_pfn(const struct hmm_range *range,
> -					  unsigned long pfn)
> -{
> -	return (pfn << range->pfn_shift) | range->flags[HMM_PFN_VALID];
> -}
> -
>  static int hmm_pfns_fill(unsigned long addr, unsigned long end,
> -		struct hmm_range *range, enum hmm_pfn_value_e value)
> +			 struct hmm_range *range, unsigned long cpu_flags)
>  {
> -	uint64_t *pfns = range->pfns;
> -	unsigned long i;
> +	unsigned long i = (addr - range->start) >> PAGE_SHIFT;
>  
> -	i = (addr - range->start) >> PAGE_SHIFT;
>  	for (; addr < end; addr += PAGE_SIZE, i++)
> -		pfns[i] = range->values[value];
> -
> +		range->hmm_pfns[i] = cpu_flags;
>  	return 0;
>  }
>  
> @@ -96,7 +81,8 @@ static int hmm_vma_fault(unsigned long addr, unsigned long end,
>  }
>  
>  static unsigned int hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
> -				       uint64_t pfns, uint64_t cpu_flags)
> +				       unsigned long pfn_req_flags,
> +				       unsigned long cpu_flags)
>  {
>  	struct hmm_range *range = hmm_vma_walk->range;
>  
> @@ -110,27 +96,28 @@ static unsigned int hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
>  	 * waste to have the user pre-fill the pfn arrays with a default
>  	 * flags value.
>  	 */
> -	pfns = (pfns & range->pfn_flags_mask) | range->default_flags;
> +	pfn_req_flags &= range->pfn_flags_mask;
> +	pfn_req_flags |= range->default_flags;
>  
>  	/* We aren't ask to do anything ... */
> -	if (!(pfns & range->flags[HMM_PFN_VALID]))
> +	if (!(pfn_req_flags & HMM_PFN_REQ_FAULT))
>  		return 0;
>  
>  	/* Need to write fault ? */
> -	if ((pfns & range->flags[HMM_PFN_WRITE]) &&
> -	    !(cpu_flags & range->flags[HMM_PFN_WRITE]))
> +	if ((pfn_req_flags & HMM_PFN_REQ_WRITE) &&
> +	    !(cpu_flags & HMM_PFN_WRITE))
>  		return HMM_NEED_FAULT | HMM_NEED_WRITE_FAULT;
>  
>  	/* If CPU page table is not valid then we need to fault */
> -	if (!(cpu_flags & range->flags[HMM_PFN_VALID]))
> +	if (!(cpu_flags & HMM_PFN_VALID))
>  		return HMM_NEED_FAULT;
>  	return 0;
>  }
>  
>  static unsigned int
>  hmm_range_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
> -		     const uint64_t *pfns, unsigned long npages,
> -		     uint64_t cpu_flags)
> +		     const unsigned long hmm_pfns[], unsigned long npages,
> +		     unsigned long cpu_flags)
>  {
>  	struct hmm_range *range = hmm_vma_walk->range;
>  	unsigned int required_fault = 0;
> @@ -142,12 +129,12 @@ hmm_range_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
>  	 * hmm_pte_need_fault() will always return 0.
>  	 */
>  	if (!((range->default_flags | range->pfn_flags_mask) &
> -	      range->flags[HMM_PFN_VALID]))
> +	      HMM_PFN_REQ_FAULT))
>  		return 0;
>  
>  	for (i = 0; i < npages; ++i) {
> -		required_fault |=
> -			hmm_pte_need_fault(hmm_vma_walk, pfns[i], cpu_flags);
> +		required_fault |= hmm_pte_need_fault(hmm_vma_walk, hmm_pfns[i],
> +						     cpu_flags);
>  		if (required_fault == HMM_NEED_ALL_BITS)
>  			return required_fault;
>  	}
> @@ -161,12 +148,13 @@ static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
>  	struct hmm_range *range = hmm_vma_walk->range;
>  	unsigned int required_fault;
>  	unsigned long i, npages;
> -	uint64_t *pfns;
> +	unsigned long *hmm_pfns;
>  
>  	i = (addr - range->start) >> PAGE_SHIFT;
>  	npages = (end - addr) >> PAGE_SHIFT;
> -	pfns = &range->pfns[i];
> -	required_fault = hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0);
> +	hmm_pfns = &range->hmm_pfns[i];
> +	required_fault =
> +		hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0);
>  	if (!walk->vma) {
>  		if (required_fault)
>  			return -EFAULT;
> @@ -174,44 +162,44 @@ static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
>  	}
>  	if (required_fault)
>  		return hmm_vma_fault(addr, end, required_fault, walk);
> -	return hmm_pfns_fill(addr, end, range, HMM_PFN_NONE);
> +	return hmm_pfns_fill(addr, end, range, 0);
>  }
>  
> -static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
> +static inline unsigned long pmd_to_hmm_pfn_flags(struct hmm_range *range,
> +						 pmd_t pmd)
>  {
>  	if (pmd_protnone(pmd))
>  		return 0;
> -	return pmd_write(pmd) ? range->flags[HMM_PFN_VALID] |
> -				range->flags[HMM_PFN_WRITE] :
> -				range->flags[HMM_PFN_VALID];
> +	return pmd_write(pmd) ? (HMM_PFN_VALID | HMM_PFN_WRITE) : HMM_PFN_VALID;
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
> -		unsigned long end, uint64_t *pfns, pmd_t pmd)
> +			      unsigned long end, unsigned long hmm_pfns[],
> +			      pmd_t pmd)
>  {
>  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>  	struct hmm_range *range = hmm_vma_walk->range;
>  	unsigned long pfn, npages, i;
>  	unsigned int required_fault;
> -	uint64_t cpu_flags;
> +	unsigned long cpu_flags;
>  
>  	npages = (end - addr) >> PAGE_SHIFT;
>  	cpu_flags = pmd_to_hmm_pfn_flags(range, pmd);
>  	required_fault =
> -		hmm_range_need_fault(hmm_vma_walk, pfns, npages, cpu_flags);
> +		hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, cpu_flags);
>  	if (required_fault)
>  		return hmm_vma_fault(addr, end, required_fault, walk);
>  
>  	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
>  	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
> -		pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
> +		hmm_pfns[i] = pfn | cpu_flags;
>  	return 0;
>  }
>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>  /* stub to allow the code below to compile */
>  int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
> -		unsigned long end, uint64_t *pfns, pmd_t pmd);
> +		unsigned long end, unsigned long hmm_pfns[], pmd_t pmd);
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  static inline bool hmm_is_device_private_entry(struct hmm_range *range,
> @@ -222,31 +210,31 @@ static inline bool hmm_is_device_private_entry(struct hmm_range *range,
>  		range->dev_private_owner;
>  }
>  
> -static inline uint64_t pte_to_hmm_pfn_flags(struct hmm_range *range, pte_t pte)
> +static inline unsigned long pte_to_hmm_pfn_flags(struct hmm_range *range,
> +						 pte_t pte)
>  {
>  	if (pte_none(pte) || !pte_present(pte) || pte_protnone(pte))
>  		return 0;
> -	return pte_write(pte) ? range->flags[HMM_PFN_VALID] |
> -				range->flags[HMM_PFN_WRITE] :
> -				range->flags[HMM_PFN_VALID];
> +	return pte_write(pte) ? (HMM_PFN_VALID | HMM_PFN_WRITE) : HMM_PFN_VALID;
>  }
>  
>  static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  			      unsigned long end, pmd_t *pmdp, pte_t *ptep,
> -			      uint64_t *pfn)
> +			      unsigned long *hmm_pfn)
>  {
>  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>  	struct hmm_range *range = hmm_vma_walk->range;
>  	unsigned int required_fault;
> -	uint64_t cpu_flags;
> +	unsigned long cpu_flags;
>  	pte_t pte = *ptep;
> -	uint64_t orig_pfn = *pfn;
> +	uint64_t pfn_req_flags = *hmm_pfn;
>  
>  	if (pte_none(pte)) {
> -		required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0);
> +		required_fault =
> +			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
>  		if (required_fault)
>  			goto fault;
> -		*pfn = range->values[HMM_PFN_NONE];
> +		*hmm_pfn = 0;
>  		return 0;
>  	}
>  
> @@ -258,17 +246,18 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  		 * the PFN even if not present.
>  		 */
>  		if (hmm_is_device_private_entry(range, entry)) {
> -			*pfn = hmm_device_entry_from_pfn(range,
> -				device_private_entry_to_pfn(entry));
> -			*pfn |= range->flags[HMM_PFN_VALID];
> +			cpu_flags = HMM_PFN_VALID;
>  			if (is_write_device_private_entry(entry))
> -				*pfn |= range->flags[HMM_PFN_WRITE];
> +				cpu_flags |= HMM_PFN_WRITE;
> +			*hmm_pfn = device_private_entry_to_pfn(entry) |
> +					cpu_flags;
>  			return 0;
>  		}
>  
> -		required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0);
> +		required_fault =
> +			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
>  		if (!required_fault) {
> -			*pfn = range->values[HMM_PFN_NONE];
> +			*hmm_pfn = 0;
>  			return 0;
>  		}
>  
> @@ -288,7 +277,8 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  	}
>  
>  	cpu_flags = pte_to_hmm_pfn_flags(range, pte);
> -	required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags);
> +	required_fault =
> +		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
>  	if (required_fault)
>  		goto fault;
>  
> @@ -297,15 +287,15 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  	 * fall through and treat it like a normal page.
>  	 */
>  	if (pte_special(pte) && !is_zero_pfn(pte_pfn(pte))) {
> -		if (hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0)) {
> +		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
>  			pte_unmap(ptep);
>  			return -EFAULT;
>  		}
> -		*pfn = range->values[HMM_PFN_ERROR];
> +		*hmm_pfn = HMM_PFN_ERROR;
>  		return 0;
>  	}
>  
> -	*pfn = hmm_device_entry_from_pfn(range, pte_pfn(pte)) | cpu_flags;
> +	*hmm_pfn = pte_pfn(pte) | cpu_flags;
>  	return 0;
>  
>  fault:
> @@ -321,7 +311,8 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  {
>  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>  	struct hmm_range *range = hmm_vma_walk->range;
> -	uint64_t *pfns = &range->pfns[(start - range->start) >> PAGE_SHIFT];
> +	unsigned long *hmm_pfns =
> +		&range->hmm_pfns[(start - range->start) >> PAGE_SHIFT];
>  	unsigned long npages = (end - start) >> PAGE_SHIFT;
>  	unsigned long addr = start;
>  	pte_t *ptep;
> @@ -333,16 +324,16 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  		return hmm_vma_walk_hole(start, end, -1, walk);
>  
>  	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
> -		if (hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0)) {
> +		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0)) {
>  			hmm_vma_walk->last = addr;
>  			pmd_migration_entry_wait(walk->mm, pmdp);
>  			return -EBUSY;
>  		}
> -		return hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
> +		return hmm_pfns_fill(start, end, range, 0);
>  	}
>  
>  	if (!pmd_present(pmd)) {
> -		if (hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0))
> +		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
>  			return -EFAULT;
>  		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
>  	}
> @@ -362,7 +353,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
>  			goto again;
>  
> -		return hmm_vma_handle_pmd(walk, addr, end, pfns, pmd);
> +		return hmm_vma_handle_pmd(walk, addr, end, hmm_pfns, pmd);
>  	}
>  
>  	/*
> @@ -372,16 +363,16 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  	 * recover.
>  	 */
>  	if (pmd_bad(pmd)) {
> -		if (hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0))
> +		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
>  			return -EFAULT;
>  		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
>  	}
>  
>  	ptep = pte_offset_map(pmdp, addr);
> -	for (; addr < end; addr += PAGE_SIZE, ptep++, pfns++) {
> +	for (; addr < end; addr += PAGE_SIZE, ptep++, hmm_pfns++) {
>  		int r;
>  
> -		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, pfns);
> +		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, hmm_pfns);
>  		if (r) {
>  			/* hmm_vma_handle_pte() did pte_unmap() */
>  			return r;
> @@ -393,13 +384,12 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  
>  #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && \
>      defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> -static inline uint64_t pud_to_hmm_pfn_flags(struct hmm_range *range, pud_t pud)
> +static inline unsigned long pud_to_hmm_pfn_flags(struct hmm_range *range,
> +						 pud_t pud)
>  {
>  	if (!pud_present(pud))
>  		return 0;
> -	return pud_write(pud) ? range->flags[HMM_PFN_VALID] |
> -				range->flags[HMM_PFN_WRITE] :
> -				range->flags[HMM_PFN_VALID];
> +	return pud_write(pud) ? (HMM_PFN_VALID | HMM_PFN_WRITE) : HMM_PFN_VALID;
>  }
>  
>  static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
> @@ -427,7 +417,8 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>  	if (pud_huge(pud) && pud_devmap(pud)) {
>  		unsigned long i, npages, pfn;
>  		unsigned int required_fault;
> -		uint64_t *pfns, cpu_flags;
> +		unsigned long *hmm_pfns;
> +		unsigned long cpu_flags;
>  
>  		if (!pud_present(pud)) {
>  			spin_unlock(ptl);
> @@ -436,10 +427,10 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>  
>  		i = (addr - range->start) >> PAGE_SHIFT;
>  		npages = (end - addr) >> PAGE_SHIFT;
> -		pfns = &range->pfns[i];
> +		hmm_pfns = &range->hmm_pfns[i];
>  
>  		cpu_flags = pud_to_hmm_pfn_flags(range, pud);
> -		required_fault = hmm_range_need_fault(hmm_vma_walk, pfns,
> +		required_fault = hmm_range_need_fault(hmm_vma_walk, hmm_pfns,
>  						      npages, cpu_flags);
>  		if (required_fault) {
>  			spin_unlock(ptl);
> @@ -448,8 +439,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>  
>  		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>  		for (i = 0; i < npages; ++i, ++pfn)
> -			pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
> -				  cpu_flags;
> +			hmm_pfns[i] = pfn | cpu_flags;
>  		goto out_unlock;
>  	}
>  
> @@ -473,8 +463,9 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>  	struct hmm_range *range = hmm_vma_walk->range;
>  	struct vm_area_struct *vma = walk->vma;
> -	uint64_t orig_pfn, cpu_flags;
>  	unsigned int required_fault;
> +	unsigned long pfn_req_flags;
> +	unsigned long cpu_flags;
>  	spinlock_t *ptl;
>  	pte_t entry;
>  
> @@ -482,9 +473,10 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  	entry = huge_ptep_get(pte);
>  
>  	i = (start - range->start) >> PAGE_SHIFT;
> -	orig_pfn = range->pfns[i];
> +	pfn_req_flags = range->hmm_pfns[i];
>  	cpu_flags = pte_to_hmm_pfn_flags(range, entry);
> -	required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags);
> +	required_fault =
> +		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
>  	if (required_fault) {
>  		spin_unlock(ptl);
>  		return hmm_vma_fault(addr, end, required_fault, walk);
> @@ -492,8 +484,8 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  
>  	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
>  	for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
> -		range->pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
> -				 cpu_flags;
> +		range->hmm_pfns[i] = pfn | cpu_flags;
> +
>  	spin_unlock(ptl);
>  	return 0;
>  }
> @@ -524,7 +516,7 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
>  	 * failure.
>  	 */
>  	if (hmm_range_need_fault(hmm_vma_walk,
> -				 range->pfns +
> +				 range->hmm_pfns +
>  					 ((start - range->start) >> PAGE_SHIFT),
>  				 (end - start) >> PAGE_SHIFT, 0))
>  		return -EFAULT;
