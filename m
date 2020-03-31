Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7E4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544BA20848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FFlNEE/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgCaH4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:56:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgCaH4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tVPpfazcLCn+rGmQCgJ5zFx/4NhoiRWfcsMxHXRN42o=; b=FFlNEE/nlwmrb0Bytn4bR4slz5
        DIFgIBF6s9N6avl/FcU0oeGua2Y42YpqPuAivHRf8axXjj4MQSNcS3ne3ktFngaVB0i+Y3P2EUwWN
        V2KClLrxzs589LKw7aEYMNJlL09rtXUi2Po090dVhWbpr40z+H/Ag4UoKqPZBQxEDdURIwGcdqkk6
        q8EjEixndcchbHD/9Kf8bIMkWXZ03ArAmUaQ9rl7ja4K1T6yM4KUyunlW40SfWl7qiqV7rKKzYoU6
        S16zsX2EoWgfit+02B9oGzvIfX43eDvQEiiL6ljkaebIIMhilw8jrQyo0IyP6ftKMn+nzxHpAN/ey
        zvQoSzBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJBkh-0001Rp-Pp; Tue, 31 Mar 2020 07:56:03 +0000
Date:   Tue, 31 Mar 2020 00:56:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     alex.williamson@redhat.com, eric.auger@redhat.com,
        jean-philippe@linaro.org, kevin.tian@intel.com,
        ashok.raj@intel.com, kvm@vger.kernel.org, jun.j.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com, hao.wu@intel.com
Subject: Re: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Message-ID: <20200331075603.GB26583@infradead.org>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -2629,6 +2638,46 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		}
>  		kfree(gbind_data);
>  		return ret;
> +	} else if (cmd == VFIO_IOMMU_CACHE_INVALIDATE) {

Please refactor the spaghetti in this ioctl handler to use a switch
statement and a helper function per command before growing it even more.

> +		/* Get the version of struct iommu_cache_invalidate_info */
> +		if (copy_from_user(&version,
> +			(void __user *) (arg + minsz), sizeof(version)))
> +			return -EFAULT;
> +
> +		info_size = iommu_uapi_get_data_size(
> +					IOMMU_UAPI_CACHE_INVAL, version);
> +
> +		cache_info = kzalloc(info_size, GFP_KERNEL);
> +		if (!cache_info)
> +			return -ENOMEM;
> +
> +		if (copy_from_user(cache_info,
> +			(void __user *) (arg + minsz), info_size)) {

The user might have changed the version while you were allocating and
freeing the memory, introducing potentially exploitable racing
conditions.
