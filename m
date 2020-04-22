Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B53C38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 05:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57CF62075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 05:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgDVFwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 01:52:31 -0400
Received: from verein.lst.de ([213.95.11.211]:50226 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgDVFwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 01:52:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8C51968C4E; Wed, 22 Apr 2020 07:52:29 +0200 (CEST)
Date:   Wed, 22 Apr 2020 07:52:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH hmm 2/5] mm/hmm: make hmm_range_fault return 0 or -1
Message-ID: <20200422055229.GB22366@lst.de>
References: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com> <2-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:21:43PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> hmm_vma_walk->last is supposed to be updated after every write to the
> pfns, so that it can be returned by hmm_range_fault(). However, this is
> not done consistently. Fortunately nothing checks the return code of
> hmm_range_fault() for anything other than error.
> 
> More importantly last must be set before returning -EBUSY as it is used to
> prevent reading an output pfn as an input flags when the loop restarts.
> 
> For clarity and simplicity make hmm_range_fault() return 0 or -ERRNO. Only
> set last when returning -EBUSY.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  Documentation/vm/hmm.rst                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 ++--
>  drivers/gpu/drm/nouveau/nouveau_svm.c   |  6 +++---
>  include/linux/hmm.h                     |  2 +-
>  mm/hmm.c                                | 25 +++++++++----------------
>  5 files changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
> index 4e3e9362afeb10..9924f2caa0184c 100644
> --- a/Documentation/vm/hmm.rst
> +++ b/Documentation/vm/hmm.rst
> @@ -161,7 +161,7 @@ device must complete the update before the driver callback returns.
>  When the device driver wants to populate a range of virtual addresses, it can
>  use::
>  
> -  long hmm_range_fault(struct hmm_range *range);
> +  int hmm_range_fault(struct hmm_range *range);
>  
>  It will trigger a page fault on missing or read-only entries if write access is
>  requested (see below). Page faults use the generic mm page fault code path just
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6309ff72bd7876..efc1329a019127 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -852,12 +852,12 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>  	down_read(&mm->mmap_sem);
>  	r = hmm_range_fault(range);
>  	up_read(&mm->mmap_sem);
> -	if (unlikely(r <= 0)) {
> +	if (unlikely(r)) {
>  		/*
>  		 * FIXME: This timeout should encompass the retry from
>  		 * mmu_interval_read_retry() as well.
>  		 */
> -		if ((r == 0 || r == -EBUSY) && !time_after(jiffies, timeout))
> +		if ((r == -EBUSY) && !time_after(jiffies, timeout))

Please also kill the superflous inner braces here.

> + * Return: 0 or -ERRNO with one of the following status codes:

Maybe say something like:

    * Returns 0 on success or one of the following error codes:

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
