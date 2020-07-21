Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53280C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6F920720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbgGUQn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:43:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:40813 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730413AbgGUQn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:43:56 -0400
IronPort-SDR: XxF+bN7rJQ0pYaEOiXknqbn2zRz5baWbuWKB44xfZMDUv9SM3ayUfHezymVJrH7Pk+joVM6A5G
 RGJagWb1jruA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="211721497"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="211721497"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 09:43:51 -0700
IronPort-SDR: tvBGo5/vj8Hw4z/+tOnsFPU8J7wngj4GEC2ybIAzdR9szlNPVhkmsfb3wVcQ6xAQxi4PMAmdHX
 GxBYxLVdSIQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="318390375"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2020 09:43:51 -0700
Date:   Tue, 21 Jul 2020 09:50:36 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Handle non-page aligned address
Message-ID: <20200721095036.1977e3bf@jacob-builder>
In-Reply-To: <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

Not sure what state is this patch in, there is a bug in this patch
(see below), shall I send out an updated version of this one only? or
another incremental patch.

Thanks,

Jacob

On Mon,  6 Jul 2020 17:12:51 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> From: Liu Yi L <yi.l.liu@intel.com>
> 
> Address information for device TLB invalidation comes from userspace
> when device is directly assigned to a guest with vIOMMU support.
> VT-d requires page aligned address. This patch checks and enforce
> address to be page aligned, otherwise reserved bits can be set in the
> invalidation descriptor. Unrecoverable fault will be reported due to
> non-zero value in the reserved bits.
> 
> Fixes: 61a06a16e36d8 ("iommu/vt-d: Support flushing more translation
> cache types")
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> ---
>  drivers/iommu/intel/dmar.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d9f973fa1190..b2c53bada905 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1455,9 +1455,25 @@ void qi_flush_dev_iotlb_pasid(struct
> intel_iommu *iommu, u16 sid, u16 pfsid,
>  	 * Max Invs Pending (MIP) is set to 0 for now until we have
> DIT in
>  	 * ECAP.
>  	 */
> -	desc.qw1 |= addr & ~mask;
> -	if (size_order)
> +	if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
> +		pr_warn_ratelimited("Invalidate non-aligned address
> %llx, order %d\n", addr, size_order); +
> +	/* Take page address */
> +	desc.qw1 = QI_DEV_EIOTLB_ADDR(addr);
> +
> +	if (size_order) {
> +		/*
> +		 * Existing 0s in address below size_order may be
> the least
> +		 * significant bit, we must set them to 1s to avoid
> having
> +		 * smaller size than desired.
> +		 */
> +		desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT,
> +					VTD_PAGE_SHIFT);
Yi reported the issue, it should be:
desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
					VTD_PAGE_SHIFT);

> +		/* Clear size_order bit to indicate size */
> +		desc.qw1 &= ~mask;
> +		/* Set the S bit to indicate flushing more than 1
> page */ desc.qw1 |= QI_DEV_EIOTLB_SIZE;
> +	}
>  
>  	qi_submit_sync(iommu, &desc, 1, 0);
>  }

[Jacob Pan]

