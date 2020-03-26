Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E03C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F3920719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rraUU7pK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCZJXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:23:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgCZJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SJ7pKkFmOx4wZcVtsAMqTLL+aY8+TznGxguEO/eMcF8=; b=rraUU7pKT8SQVUhoAACLX9Iy0L
        8ucSnvQs55LudOn8+d/KB0VLh3mfZl8JpOKRTFvlMC4qC3eZnWKZY4cmCY/SUbikGBf9w4mFt8gmi
        SiT16HNVVvWtH7w7sIW+CnNZIJSdUQbYOYIjyBL8+Gv4Sxq7xozcS/ui1iZOhMk4YTeh94OtWoS2I
        QvLTvMaIr7zLuSp9EA6m3G8LX2NRRNpQzOkbk0ze2y+MAx1a0z033F5LPSuHgyFqJfeExCBWgJ8PW
        EectoCcGNpjguntiCu7KVuf7P05mlWIGk0LaT4bviMu/epED+rn3qB6zpjh118scTWkfyzY5jRtDg
        32DDZiwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHOjM-0008Nc-Q3; Thu, 26 Mar 2020 09:23:16 +0000
Date:   Thu, 26 Mar 2020 02:23:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200326092316.GA31648@infradead.org>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 04:17:05PM -0700, Jacob Pan wrote:
> Having a single UAPI version to govern the user-kernel data structures
> makes compatibility check straightforward. On the contrary, supporting
> combinations of multiple versions of the data can be a nightmare to
> maintain.
> 
> This patch defines a unified UAPI version to be used for compatibility
> checks between user and kernel.

This is bullshit.  Version numbers don't scale and we've avoided them
everywhere.  You need need flags specifying specific behavior.

> +#define IOMMU_UAPI_VERSION	1
> +static inline int iommu_get_uapi_version(void)
> +{
> +	return IOMMU_UAPI_VERSION;
> +}

Also inline functions like this in UAPI headers that actually get
included by userspace programs simply don't work.
