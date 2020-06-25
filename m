Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9696DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54602206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbgFYHOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:14:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:13736 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgFYHOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:14:50 -0400
IronPort-SDR: wRUedW7T4//lWZsAOrVJYs7Fv3VzdqOj87YbqEm225Ci7HHDC8U0Fg7Bw5s89N4DhBNPgSujZD
 JnGsmf17lNJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="144837017"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="144837017"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 00:14:50 -0700
IronPort-SDR: w47I9gFwO6EZJAPwFd8bIKjFiO5zXkZG+10Nj28WZ4b0buMefjrHmCJVy58iStzSX96HOxu/LX
 2fau0pEKiWjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="263856440"
Received: from yijiangw-mobl1.ccr.corp.intel.com (HELO [10.255.28.52]) ([10.255.28.52])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2020 00:14:46 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 1/7] iommu/vt-d: Enforce PASID devTLB field mask
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-2-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a38e22f0-10a8-8f3a-3e61-e44701aa7e7e@linux.intel.com>
Date:   Thu, 25 Jun 2020 15:14:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592926996-47914-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/23 23:43, Jacob Pan wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> Set proper masks to avoid invalid input spillover to reserved bits.
> 

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   include/linux/intel-iommu.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 4100bd224f5c..729386ca8122 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -380,8 +380,8 @@ enum {
>   
>   #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>   #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
> -#define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
> -#define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
> +#define QI_DEV_EIOTLB_GLOB(g)	((u64)(g) & 0x1)
> +#define QI_DEV_EIOTLB_PASID(p)	((u64)((p) & 0xfffff) << 32)
>   #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
>   #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
>   #define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
> 
