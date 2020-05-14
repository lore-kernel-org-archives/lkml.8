Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3A8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D677D206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHyzcWqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgENF7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgENF7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:59:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C57C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M+qxD2Cel9ucZihBKyiJsuzooLuAoDllAt0yCxikIeQ=; b=hHyzcWqb/n45md9Y7kA0vEetZQ
        9GYNLJhY1t7JkNqD2wIthFRQWnlzHnHMZbl1BVg0L90kJ2CvlhPX5i3R9VEV08LR/vbC43YwQ87Cm
        oZYTjRfjtxVfOQUaBKm8OpVXZAdkrcHbFeQFhX3FETapL0DjyHnHKdvnVn7k0tZsF6AOsU5VKrDLk
        QB8u/VeY2CqbdKwgEQHf96c0yAtae5IiBJcEsB1Wn7xVMPcz5Fr8kYsAf8dmMTKyWFrQPEXCIP9vk
        +k08oJopswkSdNTBlFYTX4mIzoE7PPtO7mhc70S3g5MltNvwEdGpVVFwAyLLvWoiZC54lzb7zBbTg
        1qUcjySg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZ6u2-0006mS-Ry; Thu, 14 May 2020 05:59:30 +0000
Date:   Wed, 13 May 2020 22:59:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v13 4/8] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200514055930.GD22388@infradead.org>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1589410909-38925-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589410909-38925-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (dev_is_pci(dev)) {
> +		/* VT-d supports devices with full 20 bit PASIDs only */
> +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> +			return -EINVAL;
> +	} else {
> +		return -ENOTSUPP;
> +	}

This looks strange.  Why not:

	if (!dev_is_pci(dev)) {
		return -ENOTSUPP;

	/* VT-d supports devices with full 20 bit PASIDs only */
	if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
		return -EINVAL;

> +		for_each_svm_dev(sdev, svm, dev) {
> +			/*
> +			 * For devices with aux domains, we should allow multiple
> +			 * bind calls with the same PASID and pdev.
> +			 */
> +			if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)) {
> +				sdev->users++;
> +			} else {
> +				dev_warn_ratelimited(dev, "Already bound with PASID %u\n",
> +						svm->pasid);
> +				ret = -EBUSY;
> +			}
> +			goto out;

Is this intentionally a for loop that jumps out of the loop after
the first device?

> +	/*
> +	 * PASID table is per device for better security. Therefore, for
> +	 * each bind of a new device even with an existing PASID, we need to
> +	 * call the nested mode setup function here.
> +	 */
> +	spin_lock(&iommu->lock);
> +	ret = intel_pasid_setup_nested(iommu,
> +				       dev,
> +				       (pgd_t *)data->gpgd,
> +				       data->hpasid,
> +				       &data->vtd,
> +				       dmar_domain,
> +				       data->addr_width);

Why not:

	et = intel_pasid_setup_nested(iommu, dev, (pgd_t *)data->gpgd,
			data->hpasid, &data->vtd, dmar_domain,
			data->addr_width);

?

> +	for_each_svm_dev(sdev, svm, dev) {
> +		ret = 0;

		...

> +		break;
> +	}

Same only looks at the first device style.  Why dos it only care about
the first device?  That needs at least a comment, and probably a
first_svm_dev or so heper to make it explicit.
