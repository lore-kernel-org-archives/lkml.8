Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3E5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96E120663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGGAmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:42:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:35105 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgGGAmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:42:35 -0400
IronPort-SDR: rGhtpAEjZM/AkiShXaEeIRGqqA/K0fo5UP1biigW4NENkbehCwH6dR6HVIwjiVEiyPzKVaiLlc
 hbipL7diJWew==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="147532222"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="147532222"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 17:42:33 -0700
IronPort-SDR: u4JunD8GPdQ6hA34qVhYuO63vCPCxTcen2WvjRSBrrm5DJ4/junCz4v1flKrG9dikpy48GBL+R
 8CqVuteqoZnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="279439564"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040) ([10.239.13.16])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2020 17:42:31 -0700
Date:   Tue, 7 Jul 2020 08:31:41 +0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] vfio: type1: fix kthread use case
Message-ID: <20200707003140.GA20022@joy-OptiPlex-7040>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20200706104915.11460-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706104915.11460-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 06:49:15PM +0800, Hillf Danton wrote:
> 
> It's incorrect to tell out if a task is kthread without checking
> PF_KTHREAD at all.
> 
> What's also fixed, if no need to be in a seperate patch, is to
> invoke kthread_use_mm() without checking the current mm first as
> the kthread may hold a mm struct atm and it's not the right place
> to switch mm.
> 
> Fixes: 8d46c0cca5f4 ("vfio: introduce vfio_dma_rw to read/write a range of IOVAs")
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Markus Elfring <Markus.Elfring@web.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2798,7 +2798,8 @@ static int vfio_iommu_type1_dma_rw_chunk
>  	struct mm_struct *mm;
>  	unsigned long vaddr;
>  	struct vfio_dma *dma;
> -	bool kthread = current->mm == NULL;
> +	bool kthread = current->flags & PF_KTHREAD;
> +	bool use_mm = current->mm == NULL;
is it acceptable to just rename "kthread" to "kthread_no_use_mm"?

I think "current->mm == NULL" in itself implies kthread and not use_mm,
as a user thread is not able to have "current->mm == NULL", right?


Thanks
Yan

>  	size_t offset;
>  
>  	*copied = 0;
> @@ -2812,11 +2813,10 @@ static int vfio_iommu_type1_dma_rw_chunk
>  		return -EPERM;
>  
>  	mm = get_task_mm(dma->task);
> -
>  	if (!mm)
>  		return -EPERM;
>  
> -	if (kthread)
> +	if (kthread && use_mm)
>  		kthread_use_mm(mm);
>  	else if (current->mm != mm)
>  		goto out;
> @@ -2843,7 +2843,7 @@ static int vfio_iommu_type1_dma_rw_chunk
>  	} else
>  		*copied = copy_from_user(data, (void __user *)vaddr,
>  					   count) ? 0 : count;
> -	if (kthread)
> +	if (kthread && use_mm)
>  		kthread_unuse_mm(mm);
>  out:
>  	mmput(mm);
> --
> 
