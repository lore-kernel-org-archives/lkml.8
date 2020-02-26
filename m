Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BA5C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD952084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+L1wubO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgBZHbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 02:31:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32997 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgBZHbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 02:31:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so1682168wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 23:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hxZUYP0cQ4s+D1GPGSIg13NXENyBceeLiQgMnelW0Co=;
        b=Z+L1wubOJ3gGRnqhuT1ZwDooxjKXaCTM3VWsZWLORPJqa9xxtrRYrmREYRwCw2YgO8
         HKl4+knUWCmhZWZozBrcMIJxyqPx5GGSKZnevRzh1xx0OnU/NP6lHxYJfz5lWO3sNl50
         iCRv3J5KH6YTeU5Jc1PD1pzvs4WdjkRnoRVGoOXrX1eH4VtS+U69d210rHLWlJB9C4wQ
         B522/8AkfM69ES4+RnCqMnsj+cefCm9/rN54vriduVWNm+Iro0L+qHn63iB2Y2WutZyr
         PCzo0LYEIiYvMJ4ZOsuGTEbSHq3w9FkXCz6rM11iGmi05xhHj526rEq3R+XF8Vw35qkN
         XvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxZUYP0cQ4s+D1GPGSIg13NXENyBceeLiQgMnelW0Co=;
        b=sG5COZsDkoUfSr4QVGcNRAsKrd87M4lb2P0p9cqZX0jDzqX0PO17ay3HyJEcYvENTw
         ZoasROn2/oYoWbKxEYl1d0+g5RIAWNmT8ocUb+mEW1Ucklpqp/RPn3nclESQE7CZ7Lw1
         IAS9U0xEtgi6C+XHC+GkET5ZoVKw3HB4y9oyuLusCemHsiUJGT3vNj5Ecd5OLhxqot3E
         ipwjFjAMNDPRbr4sQ7qTAG7uFVx+zdJ4JSoMATMk2DP5GCI3/o/TaKBduXvdd0bXuf0E
         HeXNmrm0tdol6zLP/A9/8lBzDtXhCf9tLqOpTlhCCAbL25dyT2jaitbgEnGZx5uAsIMF
         GSBQ==
X-Gm-Message-State: APjAAAUJDsH5NxodJf7IATN5dthtiK6t0cmSJZI39jhrJoafJ32KwKRE
        SNrMUDKcamHEEVFdSNHkAgpQQw==
X-Google-Smtp-Source: APXvYqymA4NRK8kSBnwzL1y5IBNFVoBdWsFFIcv2KQ0MszGN1eA/UpfEau7j9Zkxfu5RLu4gn4+TSw==
X-Received: by 2002:adf:e884:: with SMTP id d4mr3961692wrm.12.1582702293931;
        Tue, 25 Feb 2020 23:31:33 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t187sm1820680wmt.25.2020.02.25.23.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 23:31:33 -0800 (PST)
Date:   Wed, 26 Feb 2020 08:31:27 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Replace intel SVM APIs with generic SVA
 APIs
Message-ID: <20200226073127.GA438595@myrica>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200225191034.GA29045@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225191034.GA29045@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:10:34AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 24, 2020 at 03:26:37PM -0800, Jacob Pan wrote:
> > This patch is an initial step to replace Intel SVM code with the
> > following IOMMU SVA ops:
> > intel_svm_bind_mm() => iommu_sva_bind_device()
> > intel_svm_unbind_mm() => iommu_sva_unbind_device()
> > intel_svm_is_pasid_valid() => iommu_sva_get_pasid()
> 
> How did either set APIs end up being added to the kernel without users
> to start with?
> 
> Please remove both the old intel and the iommu ones given that neither
> has any users.

The hisilicon crypto accelerator will be using the new API in v5.7
https://lore.kernel.org/linux-iommu/1581407665-13504-1-git-send-email-zhangfei.gao@linaro.org/

Thanks,
Jean
