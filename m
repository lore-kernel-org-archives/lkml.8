Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC8C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7027B20658
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BT/Gq9iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgBFKOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:14:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21603 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728064AbgBFKOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580984084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILoRHHda+PqYCNA93STvliCKWA3E9VPhrVdonajAaSU=;
        b=BT/Gq9ivOPKhzqs7kZ1NM6kxAt3dF3pT5S64aMGPKyrtFNSv5dhXy0lSChuBND1ZtHUzmn
        fTxWorTRmJj65G4O/mH1k1q2IzmTdzx3jPoT6MOVi0moRH7izh0regCdBW4M1u8OEz/nOC
        Pmd8PD5ip/kKiYMwThy/xPScoa9/IOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-q4MWjhmSMFOhQ6qLr4ZWjw-1; Thu, 06 Feb 2020 05:14:39 -0500
X-MC-Unique: q4MWjhmSMFOhQ6qLr4ZWjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 426CE8010FA;
        Thu,  6 Feb 2020 10:14:37 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3B615C1B0;
        Thu,  6 Feb 2020 10:14:29 +0000 (UTC)
Subject: Re: [PATCH 1/3] iommu/uapi: Define uapi version and capabilities
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
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277724-66994-2-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <699faadb-e714-e36d-152a-5b650c0a403f@redhat.com>
Date:   Thu, 6 Feb 2020 11:14:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1580277724-66994-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,
On 1/29/20 7:02 AM, Jacob Pan wrote:
> Define a unified UAPI version to be used for compatibility
> checks between user and kernel.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index fcafb6401430..65a26c2519ee 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -8,6 +8,54 @@
>  
>  #include <linux/types.h>
>  
> +/**
> + * Current version of the IOMMU user API. This is intended for query
> + * between user and kernel to determine compatible data structures.
> + *
> + * Having a single UAPI version to govern the user-kernel data structures
> + * makes compatibility check straightforward. On the contrary, supporting
> + * combinations of multiple versions of the data can be a nightmare.
I would rather put the above justification in the commit msg and not here.
> + *
> + * UAPI version can be bumped up with the following rules:
> + * 1. All data structures passed between user and kernel space share
> + *    the same version number. i.e. any extension to to any structure
s/to to/to
> + *    results in version bump up.
in a version number increment?
> + *
> + * 2. Data structures are open to extension but closed to modification.> + *    New fields must be added at the end of each data structure with
> + *    64bit alignment. Flag bits can be added without size change but
> + *    existing ones cannot be altered.
> + *
> + * 3. Versions are backward compatible.
> + *
> + * 4. Version to size lookup is supported by kernel internal API for each
> + *    API function type. @version is mandatory for new data structures
> + *    and must be at the beginning with type of __u32.
> + */
> +#define IOMMU_UAPI_VERSION	1
> +static inline int iommu_get_uapi_version(void)
> +{
> +	return IOMMU_UAPI_VERSION;
> +}
> +
> +/*
> + * Supported UAPI features that can be reported to user space.
> + * These types represent the capability available in the kernel.
> + *
> + * REVISIT: UAPI version also implies the capabilities. Should we
> + * report them explicitly?
> + */
> +enum IOMMU_UAPI_DATA_TYPES {
> +	IOMMU_UAPI_BIND_GPASID,
> +	IOMMU_UAPI_CACHE_INVAL,
> +	IOMMU_UAPI_PAGE_RESP,
> +	NR_IOMMU_UAPI_TYPE,
> +};
> +
> +#define IOMMU_UAPI_CAP_MASK ((1 << IOMMU_UAPI_BIND_GPASID) |	\
> +				(1 << IOMMU_UAPI_CACHE_INVAL) |	\
> +				(1 << IOMMU_UAPI_PAGE_RESP))
> +
>  #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
>  #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
>  #define IOMMU_FAULT_PERM_EXEC	(1 << 2) /* exec */
> 
Thanks

Eric

