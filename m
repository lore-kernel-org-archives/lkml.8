Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE501C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D0220772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeF7uKfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgGBIvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:51:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46265 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726042AbgGBIvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593679863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rL9RIKx4hz19hS1SSEqW7f8vI579//zx822fB8l/eH8=;
        b=IeF7uKfboJ7Ykm/s+JkM1+ND6ecujg8GsBzFc+X7dUJzCloMzO0fcq8AZ6azPLF+tm3mVO
        5wzKE9jQ7i/poND5d5+C3G8TQ2QNQwwerGl5COgyEBDVLKRj6zxjQihOZPr2XEXO70is5s
        6J19evejIoymZ2yZ2eYWxrhxAuWpNQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-bmm9GuxKOKuOkDM4eXsy6Q-1; Thu, 02 Jul 2020 04:50:59 -0400
X-MC-Unique: bmm9GuxKOKuOkDM4eXsy6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32068879513;
        Thu,  2 Jul 2020 08:50:58 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4040D10098A4;
        Thu,  2 Jul 2020 08:50:56 +0000 (UTC)
Subject: Re: [PATCH v3 7/7] iommu/vt-d: Disable multiple GPASID-dev bind
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593617636-79385-8-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <67186ca8-6af2-7ef2-a238-49fcfa5bc398@redhat.com>
Date:   Thu, 2 Jul 2020 10:50:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1593617636-79385-8-git-send-email-jacob.jun.pan@linux.intel.com>
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
> For the unlikely use case where multiple aux domains from the same pdev
> are attached to a single guest and then bound to a single process
> (thus same PASID) within that guest, we cannot easily support this case
> by refcounting the number of users. As there is only one SL page table
> per PASID while we have multiple aux domains thus multiple SL page tables
> for the same PASID.
> 
> Extra unbinding guest PASID can happen due to race between normal and
> exception cases. Termination of one aux domain may affect others unless
> we actively track and switch aux domains to ensure the validity of SL
> page tables and TLB states in the shared PASID entry.
> 
> Support for sharing second level PGDs across domains can reduce the
> complexity but this is not available due to the limitations on VFIO
> container architecture. We can revisit this decision once sharing PGDs
> are available.
> 
> Overall, the complexity and potential glitch do not warrant this unlikely
> use case thereby removed by this patch.
> 
> Fixes: 56722a4398a30 ("iommu/vt-d: Add bind guest PASID support")
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/iommu/intel/svm.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 6c87c807a0ab..d386853121a2 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -277,20 +277,16 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  			goto out;
>  		}
>  
> +		/*
> +		 * Do not allow multiple bindings of the same device-PASID since
> +		 * there is only one SL page tables per PASID. We may revisit
> +		 * once sharing PGD across domains are supported.
> +		 */
>  		for_each_svm_dev(sdev, svm, dev) {
> -			/*
> -			 * For devices with aux domains, we should allow
> -			 * multiple bind calls with the same PASID and pdev.
> -			 */
> -			if (iommu_dev_feature_enabled(dev,
> -						      IOMMU_DEV_FEAT_AUX)) {
> -				sdev->users++;
> -			} else {
> -				dev_warn_ratelimited(dev,
> -						     "Already bound with PASID %u\n",
> -						     svm->pasid);
> -				ret = -EBUSY;
> -			}
> +			dev_warn_ratelimited(dev,
> +					     "Already bound with PASID %u\n",
> +					     svm->pasid);
> +			ret = -EBUSY;
>  			goto out;
>  		}
>  	} else {
> 

