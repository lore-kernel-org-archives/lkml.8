Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C9FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7ED2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZQAAKHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgGPHwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:52:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22299 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbgGPHwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594885922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zwh3uv/4dKOUDKuvTiQugEhD9LKpVaA1KJEov11HNA=;
        b=XZQAAKHBIjeQ6YO3V45litMoaKslbOoMz9lm+yxZ6BCKFjReGnbxlXmAebzqtu6Urp1B7s
        aAv8yeZDGCePnIzDQObz/OLkj1Eet0wnbf+35rl97ln3I6rjfuihENWJSuZJ38xpwumdaB
        Xb19ADZ2wVs5/BF3A5yGGsuT5OxqvyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-leaykoy7M9GUz5dciJ2ADQ-1; Thu, 16 Jul 2020 03:52:00 -0400
X-MC-Unique: leaykoy7M9GUz5dciJ2ADQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A915E107BEF5;
        Thu, 16 Jul 2020 07:51:58 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F72F2B6D6;
        Thu, 16 Jul 2020 07:51:56 +0000 (UTC)
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Handle non-page aligned address
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>
References: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <889b3fcd-482a-46b7-7b95-19555f73f907@redhat.com>
Date:   Thu, 16 Jul 2020 09:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 7/7/20 2:12 AM, Jacob Pan wrote:
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> ---
>  drivers/iommu/intel/dmar.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d9f973fa1190..b2c53bada905 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1455,9 +1455,25 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
>  	 * ECAP.
>  	 */
> -	desc.qw1 |= addr & ~mask;
> -	if (size_order)
> +	if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
> +		pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n", addr, size_order);
> +
> +	/* Take page address */
> +	desc.qw1 = QI_DEV_EIOTLB_ADDR(addr);
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
>  		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
> +	}
>  
>  	qi_submit_sync(iommu, &desc, 1, 0);
>  }
> 

