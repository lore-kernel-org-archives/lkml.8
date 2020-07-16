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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE308C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4082206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrLlztx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGPHwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:52:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44798 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725867AbgGPHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594885942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u05tKeUEsAaeYGPCQa0ls+uddt7PTxRvgt5ZWaTMPQo=;
        b=UrLlztx0U+FjvxZZB80rSUpbgEoucONh4bt/jpaqFKvHDouRWtf+HxClB4iM1JwDYPv5I8
        ehoxGa4j8nnasR80FwBcCaAIRderKL6d7NkbFB3aOwRQ0LNZnFk6EnknV9gucnAY9bBNp4
        uhQPuE7Hv6cL8wG4f4hs71IFpmm7QT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-Xb-UOX7jPue6gqhzV6DN-Q-1; Thu, 16 Jul 2020 03:52:19 -0400
X-MC-Unique: Xb-UOX7jPue6gqhzV6DN-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B41DBC746A;
        Thu, 16 Jul 2020 07:52:17 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC70C1002391;
        Thu, 16 Jul 2020 07:52:15 +0000 (UTC)
Subject: Re: [PATCH v4 3/7] iommu/vt-d: Fix PASID devTLB invalidation
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>
References: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594080774-33413-4-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <caab5726-e322-7da0-bcd0-2353a43be929@redhat.com>
Date:   Thu, 16 Jul 2020 09:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594080774-33413-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 7/7/20 2:12 AM, Jacob Pan wrote:
> DevTLB flush can be used for both DMA request with and without PASIDs.
> The former uses PASID#0 (RID2PASID), latter uses non-zero PASID for SVA
> usage.
> 
> This patch adds a check for PASID value such that devTLB flush with
> PASID is used for SVA case. This is more efficient in that multiple
> PASIDs can be used by a single device, when tearing down a PASID entry
> we shall flush only the devTLB specific to a PASID.
> 
> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table")
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
sent on v3.

Thanks

Eric
> ---
>  drivers/iommu/intel/pasid.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index c81f0f17c6ba..fa0154cce537 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -486,7 +486,16 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>  	qdep = info->ats_qdep;
>  	pfsid = info->pfsid;
>  
> -	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
> +	/*
> +	 * When PASID 0 is used, it indicates RID2PASID(DMA request w/o PASID),
> +	 * devTLB flush w/o PASID should be used. For non-zero PASID under
> +	 * SVA usage, device could do DMA with multiple PASIDs. It is more
> +	 * efficient to flush devTLB specific to the PASID.
> +	 */
> +	if (pasid == PASID_RID2PASID)
> +		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
> +	else
> +		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
>  }
>  
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
> 

