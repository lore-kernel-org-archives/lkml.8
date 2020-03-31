Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEF1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9786720658
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzYVMoYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgCaJ21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:28:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35382 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730031AbgCaJ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585646906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//E29gBKS0R3M2BLI8jALgB6AWrOyofC4LvAyn35IUU=;
        b=BzYVMoYoTddBoWK23AzCi5K/puQOjtTx4TfJUqhy8bXULwp9m9yTd9gx8/wr2Gk/Eklv6c
        d9chSFOvT9RUEzDmn8GL4wSmnT04stQEWspG2rVVAAxPXN2wSnl9tCDhbkgsSHIy7awyip
        /8lYjm+MXGW3s3hwB0/Xh7bkf/YMi5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-kwx-1qeAOiShSC9ZnEZQvw-1; Tue, 31 Mar 2020 05:28:24 -0400
X-MC-Unique: kwx-1qeAOiShSC9ZnEZQvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CC18DBA7;
        Tue, 31 Mar 2020 09:28:23 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF01050BEE;
        Tue, 31 Mar 2020 09:28:18 +0000 (UTC)
Subject: Re: [PATCH] iommu/vt-d: Fix PASID cache flush
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Raj Ashok <ashok.raj@intel.com>
References: <1585610725-78316-1-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <53be1d27-6348-56db-7eac-6734f92f123d@redhat.com>
Date:   Tue, 31 Mar 2020 11:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1585610725-78316-1-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 3/31/20 1:25 AM, Jacob Pan wrote:
> PASID cache type and shift of granularity bits are missing in
> the current code.
> 
> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table
> interface")
> 
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/iommu/intel-pasid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 22b30f10b396..57d05b0fbafc 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -365,7 +365,8 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>  {
>  	struct qi_desc desc;
>  
> -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL | QI_PC_PASID(pasid);
> +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> +		   QI_PC_PASID(pasid) | QI_PC_TYPE;
>  	desc.qw1 = 0;
>  	desc.qw2 = 0;
>  	desc.qw3 = 0;
> 

