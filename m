Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EF1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80FE20884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxHl6+nM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgGBHQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:16:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34847 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgGBHQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593674190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LhGy6abGzglbul8z63H3tg9U5bdEBih//NkKnz9rsiY=;
        b=dxHl6+nM9fiv/hXYlyZZ3HNmcwhJGsmIM15ResGd1qZBW0fV/Ta21Gq+3gU3g/tW2qFaZ0
        Br2vzqpHdTwPQrXKwRr2ezUbMGxDIr1K48pcmBcD00AZOYXWeD02hz7VpVPaP09sBnzC5L
        s9pzxrjS4LSiGQfZ0keyE3S+hNYYEdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-2eFf2ebaO0eviYtmoxw0AA-1; Thu, 02 Jul 2020 03:16:26 -0400
X-MC-Unique: 2eFf2ebaO0eviYtmoxw0AA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1751F18A8220;
        Thu,  2 Jul 2020 07:16:25 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE7CA1002388;
        Thu,  2 Jul 2020 07:16:22 +0000 (UTC)
Subject: Re: [PATCH v3 3/7] iommu/vt-d: Fix PASID devTLB invalidation
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593617636-79385-4-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c67cb732-6d40-e0b6-d65b-b007926d51fb@redhat.com>
Date:   Thu, 2 Jul 2020 09:16:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1593617636-79385-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 7/1/20 5:33 PM, Jacob Pan wrote:
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
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

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

