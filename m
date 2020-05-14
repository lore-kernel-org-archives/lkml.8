Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1111C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECCB205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K5wJuD01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgENFyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgENFyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:54:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4811CC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WVUCicfVAsvxT9MgllLfS1iSzrWh85EnWnC6RBOjG5c=; b=K5wJuD01WQj+Qa7Y/el5mdYWFg
        Dj4XUHbyRLVYVxCA3CRL4vu6+Op8znMzrVbz9RmvFbJ/Nl8/3UnVVL64IgHasmuUEhX6ho6liPmRF
        XAwERUGWpnpuOitYoiVaOtUn7U6p26K4cAf9sOpnEaaCxKhfW/pnzTFinEBfiUYfRsSY+GKD9c/5w
        exGxRZi9C9JdleSUMsoBZ9/vMZmPb3koptQT46Wv+28cLa6Usg7mhlBk50Qsh31vqyjMKQxUfFg8E
        l9fPs3T5NlCXphPUaU3t6f+xb9lcoqB3/D1JuMYPTnO8UOUHgcJDvsjH7UQYhKVTdS2ARZUbYplWy
        GrUmuvdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZ6p6-0003pV-59; Thu, 14 May 2020 05:54:24 +0000
Date:   Wed, 13 May 2020 22:54:24 -0700
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
Subject: Re: [PATCH v13 3/8] iommu/vt-d: Add nested translation helper
 function
Message-ID: <20200514055424.GC22388@infradead.org>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1589410909-38925-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589410909-38925-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	 * 1. CPU vs. IOMMU
> +	 * 2. Guest vs. Host.
> +	 */
> +	switch (addr_width) {
> +#ifdef CONFIG_X86
> +	case ADDR_WIDTH_5LEVEL:
> +		if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> +		    cap_5lp_support(iommu->cap)) {
> +			pasid_set_flpm(pte, 1);
> +		} else {
> +			dev_err_ratelimited(dev, "5-level paging not supported\n");
> +			return -EINVAL;
> +		}
> +		break;

The normal style would be to handle the early error return first:

		if (!cpu_feature_enabled(X86_FEATURE_LA57) ||
		    !cap_5lp_support(iommu->cap)) {
			dev_err_ratelimited(dev,
				"5-level paging not supported\n");
			return -EINVAL;
		}

		pasid_set_flpm(pte, 1);
		break;

