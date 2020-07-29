Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C323BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A339A2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AC6I72s0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgG2UDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:03:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26955 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726824AbgG2UDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596053030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QeyS6hEHiK3c3NVQsKxvW8k7HJvPYBCqvPsl0jPPbrg=;
        b=AC6I72s0MNejLJkpvizw7rA92PgnBOw1iTpLhE5UaCygkWu5NFrXmWtlwXIi+MlaIT8WUb
        HuizyLnxzX+grPvKZa8vphvmz9+jf4+9sgCfdhhcyD0zZVxKwTu2EBN6gc3F7w3/e8//3z
        zylfxjCnUFrHv5NBPwS5Ua8pI51PmS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-lV5JfxIrNgqWJ0JBZrb2PA-1; Wed, 29 Jul 2020 16:03:46 -0400
X-MC-Unique: lV5JfxIrNgqWJ0JBZrb2PA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C6D98017FB;
        Wed, 29 Jul 2020 20:03:44 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A82F5C6C0;
        Wed, 29 Jul 2020 20:03:43 +0000 (UTC)
Date:   Wed, 29 Jul 2020 14:03:43 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iommu: Check IOMMU_DEV_FEAT_AUX feature in aux
 api's
Message-ID: <20200729140343.2b7047b2@x1.home>
In-Reply-To: <20200714055703.5510-2-baolu.lu@linux.intel.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
        <20200714055703.5510-2-baolu.lu@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 13:57:00 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> The iommu aux-domain api's work only when IOMMU_DEV_FEAT_AUX is enabled
> for the device. Add this check to avoid misuse.

Shouldn't this really be the IOMMU driver's responsibility to test?  If
nothing else, iommu_dev_feature_enabled() needs to get the iommu_ops
from dev->bus->iommu_ops, which is presumably the same iommu_ops we're
then calling from domain->ops to attach/detach the device, so it'd be
more efficient for the IOMMU driver to error on devices that don't
support aux.  Thanks,

Alex

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1ed1e14a1f0c..e1fdd3531d65 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2725,11 +2725,13 @@ EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
>   */
>  int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
>  {
> -	int ret = -ENODEV;
> +	int ret;
>  
> -	if (domain->ops->aux_attach_dev)
> -		ret = domain->ops->aux_attach_dev(domain, dev);
> +	if (!iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX) ||
> +	    !domain->ops->aux_attach_dev)
> +		return -ENODEV;
>  
> +	ret = domain->ops->aux_attach_dev(domain, dev);
>  	if (!ret)
>  		trace_attach_device_to_domain(dev);
>  
> @@ -2748,12 +2750,12 @@ EXPORT_SYMBOL_GPL(iommu_aux_detach_device);
>  
>  int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>  {
> -	int ret = -ENODEV;
> +	if (!iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX) ||
> +	    !domain->ops->aux_get_pasid)
> +		return -ENODEV;
>  
> -	if (domain->ops->aux_get_pasid)
> -		ret = domain->ops->aux_get_pasid(domain, dev);
> +	return domain->ops->aux_get_pasid(domain, dev);
>  
> -	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>  

