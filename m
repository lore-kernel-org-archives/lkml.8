Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CE0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8510A20874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaOM/sLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgGBHQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:16:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21365 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbgGBHQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593674203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OY7VrL1a59Qxq0BBbOuXh6ED5q1CVp62vwIhZmJJ8VQ=;
        b=BaOM/sLa7mJ31vg9AwjWvYBuq0Lh2Pu8DSDHlzXKylC/IFhrjIkKQc0WuKA4aWLq07r79q
        ybZHNdDYdKMfbxrV+IH+Ewrfaz4b9330LLJu6H3BXTwFeYbF4kRxpl9luWjjXc90IRviQr
        M+fuZZOgq58OqqjRz/SG1GOLAws/ojU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-laIbpHlZNWC6OsI8747z3Q-1; Thu, 02 Jul 2020 03:16:38 -0400
X-MC-Unique: laIbpHlZNWC6OsI8747z3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB4378015F7;
        Thu,  2 Jul 2020 07:16:36 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C64345DAB0;
        Thu,  2 Jul 2020 07:16:34 +0000 (UTC)
Subject: Re: [PATCH v3 1/7] iommu/vt-d: Enforce PASID devTLB field mask
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593617636-79385-2-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <0c76fbb7-8844-6a72-5249-934ed0a5c10b@redhat.com>
Date:   Thu, 2 Jul 2020 09:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1593617636-79385-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/1/20 5:33 PM, Jacob Pan wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> Set proper masks to avoid invalid input spillover to reserved bits.
> 
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>


> ---
>  include/linux/intel-iommu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 4100bd224f5c..729386ca8122 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -380,8 +380,8 @@ enum {
>  
>  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
> -#define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
> -#define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
> +#define QI_DEV_EIOTLB_GLOB(g)	((u64)(g) & 0x1)
> +#define QI_DEV_EIOTLB_PASID(p)	((u64)((p) & 0xfffff) << 32)
>  #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
>  #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
>  #define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
> 

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

