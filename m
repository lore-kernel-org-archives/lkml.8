Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A795CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D41F20771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgGABNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:13:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:22548 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgGABNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:13:18 -0400
IronPort-SDR: 6uA7wujzWwwh8LXhIVo+glDoLXCieqXX0diYYSWNxssSbNCcCxrqTpwZBtHq3e5YzX3T3uXOcW
 ZvMHZBq1FPsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="231288168"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="231288168"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 18:13:18 -0700
IronPort-SDR: VYutfgbgIMZ4TlUzjptdoaJK09UCLU0LpY58EUhXvHnExS3Abyc/b6W5GdCU77qEG0dhRCk1VD
 uZSl05yHkGJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="265263416"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2020 18:13:15 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 4/7] iommu/vt-d: Handle non-page aligned address
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593551258-39854-5-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5543656c-9b38-5fe6-7372-9a61a1269b5d@linux.intel.com>
Date:   Wed, 1 Jul 2020 09:08:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593551258-39854-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 5:07 AM, Jacob Pan wrote:
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

Fixes: 61a06a16e36d8 ("iommu/vt-d: Support flushing more translation 
cache types")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/dmar.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d9f973fa1190..3899f3161071 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1455,9 +1455,25 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>   	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
>   	 * ECAP.
>   	 */
> -	desc.qw1 |= addr & ~mask;
> -	if (size_order)
> +	if (addr & ~VTD_PAGE_MASK)
> +		pr_warn_ratelimited("Invalidate non-page aligned address %llx\n", addr);
> +
> +	/* Take page address */
> +	desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr);
> +
> +	if (size_order) {
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
