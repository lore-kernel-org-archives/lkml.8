Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA222C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1542076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403856AbgFYKF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:05:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:60553 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390534AbgFYKF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:05:56 -0400
IronPort-SDR: rGH1UWW8A0wyD1E2Qx2UDVU5/U4MQ4EZErbgGTuUiJRwCfFbOE4rvgH+cjsOzlP1bHYX1t/Tx5
 KYzUvDdMLWtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="206359329"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="206359329"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 03:05:56 -0700
IronPort-SDR: c+Co+VmB1WTtrlI6kcp0N8A7BmK4d8S1lQJbB+I9/YDZ6Kp89MC7d5jze3qGxeuGGoWNakeL7F
 KQtz8k/Qi/Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="263886455"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.28.52]) ([10.255.28.52])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2020 03:05:53 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 4/7] iommu/vt-d: Handle non-page aligned address
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-5-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <037cb7cf-1336-f546-7f45-c35caf19930f@linux.intel.com>
Date:   Thu, 25 Jun 2020 18:05:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592926996-47914-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/6/23 23:43, Jacob Pan wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> Address information for device TLB invalidation comes from userspace
> when device is directly assigned to a guest with vIOMMU support.
> VT-d requires page aligned address. This patch checks and enforce
> address to be page aligned, otherwise reserved bits can be set in the
> invalidation descriptor. Unrecoverable fault will be reported due to
> non-zero value in the reserved bits.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d9f973fa1190..53f4e5003620 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1455,9 +1455,24 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>   	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
>   	 * ECAP.
>   	 */
> -	desc.qw1 |= addr & ~mask;
> -	if (size_order)
> +	if (addr & ~VTD_PAGE_MASK)
> +		pr_warn_ratelimited("Invalidate non-page aligned address %llx\n", addr);
> +
> +	if (size_order) {
> +		/* Take page address */
> +		desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr);

If size_order == 0 (that means only a single page is about to be
invalidated), do you still need to set ADDR field of the descriptor?

Best regards,
baolu

> +		/*
> +		 * Existing 0s in address below size_order may be the least
> +		 * significant bit, we must set them to 1s to avoid having
> +		 * smaller size than desired.
> +		 */
> +		desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT,
> +					VTD_PAGE_SHIFT);
> +		/* Clear size_order bit to indicate size */
> +		desc.qw1 &= ~mask;
> +		/* Set the S bit to indicate flushing more than 1 page */
>   		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
> +	}
>   
>   	qi_submit_sync(iommu, &desc, 1, 0);
>   }
> 
