Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F6C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1CB20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JA2+gqdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBLMoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:44:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28075 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725887AbgBLMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581511446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hw0/W8D/Tq9lQe7PvCgtUb+BdMjG4YZ0IreP5BC1hFc=;
        b=JA2+gqdcb6MhJiLj+yqTLcbw8RzSlhSq+DqLuRYUrHlNKIzDDxKUUUXzsjiAPX9gYm4HWu
        IRnfad403zO3QWT3tATavk5Hzbmvbj7vcKqhrjQZcgCwcsEYrVJ2UgFyUsMVfszFYUNKYR
        s1ODipQoByLHVRcHu7/wWB1CHk0xC2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-VdayoA1AML-JVJj2TL9u4w-1; Wed, 12 Feb 2020 07:43:56 -0500
X-MC-Unique: VdayoA1AML-JVJj2TL9u4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2611D19251A0;
        Wed, 12 Feb 2020 12:43:54 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 767AC60499;
        Wed, 12 Feb 2020 12:43:46 +0000 (UTC)
Subject: Re: [PATCH V9 02/10] iommu/uapi: Define a mask for bind data
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277713-66934-3-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c51ba1a1-343d-c458-1529-5f9fb11d13b9@redhat.com>
Date:   Wed, 12 Feb 2020 13:43:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1580277713-66934-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 1/29/20 7:01 AM, Jacob Pan wrote:
> Memory type related guest PASID bind data can be grouped together for
> one simple check.
Those are flags related to memory type.
> Link: https://lore.kernel.org/linux-iommu/20200109095123.17ed5e6b@jacob-builder/
not sure the link is really helpful.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 4ad3496e5c43..fcafb6401430 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -284,7 +284,10 @@ struct iommu_gpasid_bind_data_vtd {
>  	__u32 pat;
>  	__u32 emt;
>  };
> -
> +#define IOMMU_SVA_VTD_GPASID_EMT_MASK	(IOMMU_SVA_VTD_GPASID_CD | \
> +					 IOMMU_SVA_VTD_GPASID_EMTE | \
> +					 IOMMU_SVA_VTD_GPASID_PCD |  \
> +					 IOMMU_SVA_VTD_GPASID_PWT)
Why EMT rather than MT or MTS?
the spec says:
Those fields are treated as Reserved(0) for implementations not
supporting Memory Type (MTS=0 in Extended Capability Register).

>  /**
>   * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
>   * @version:	Version of this data structure
> 

Thanks

Eric

