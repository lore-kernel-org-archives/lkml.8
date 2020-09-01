Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67577C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37393206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lqe9meLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgIARJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732470AbgIARIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598980133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/K3itRNGDBjecxllh4C4p9hfEhx4LxfXXlrS6JO9Q0=;
        b=Lqe9meLtYn98xnr0romEpt0VPzO+wU58W6MLWaas32rlMpT7UH72Z6eqBX92CWElgbSBnN
        ttRoQ4SectMV4hVGbX24f1ljKAb765UeyOtOCd4anWwOwPYi0zISz0eUUi9ecABDmlamKg
        lWgLz94weGZrLTL2U2M5pXYwRHNY7OA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-4-MR4TRsOMu058QrcOsSYQ-1; Tue, 01 Sep 2020 13:08:52 -0400
X-MC-Unique: 4-MR4TRsOMu058QrcOsSYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B2E7107B26B;
        Tue,  1 Sep 2020 17:08:50 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B26EF7B931;
        Tue,  1 Sep 2020 17:08:46 +0000 (UTC)
Subject: Re: [PATCH v2 9/9] iommu/vt-d: Store guest PASID during bind
To:     Jacob Pan <jacob.pan.linux@gmail.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-10-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <60feda75-5862-c898-97b1-1f5eafdb8d8c@redhat.com>
Date:   Tue, 1 Sep 2020 19:08:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1598070918-21321-10-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,
On 8/22/20 6:35 AM, Jacob Pan wrote:
> IOASID core maintains the guest-host mapping in the form of SPID and
> IOASID. This patch assigns the guest PASID (if valid) as SPID while
> binding guest page table with a host PASID. This mapping will be used
> for lookup and notifications.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index d8a5efa75095..4c958b1aec4c 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -406,6 +406,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  		if (data->flags & IOMMU_SVA_GPASID_VAL) {
>  			svm->gpasid = data->gpasid;
>  			svm->flags |= SVM_FLAG_GUEST_PASID;
> +			ioasid_attach_spid(data->hpasid, data->gpasid);
don't you want to handle the returned value?
>  		}
>  		svm->iommu = iommu;
>  		/*
> @@ -517,6 +518,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
>  				ioasid_attach_data(pasid, NULL);
>  				ioasid_notify(pasid, IOASID_UNBIND,
>  					IOASID_NOTIFY_SET);
> +				ioasid_attach_spid(pasid, INVALID_IOASID);
So this answers my previous question ;-) but won't it enter the if
(!ioasid_data) path and fail to reset the spid?

Eric
>  				kfree(svm);
>  			}
>  		}
> 

