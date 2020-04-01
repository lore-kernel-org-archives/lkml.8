Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E184FC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87B4206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXbULbcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgDAN7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:59:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38632 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732783AbgDAN7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:59:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id c7so159383wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d3ubFjm4VVzuezD9K57VpIO57fRHdUfHFre4oE4/E04=;
        b=LXbULbcGmfMrHy9dOLNhW1kZDtfZBIl5/lz1iQa7oPRNngMcEJOD5l9icOrmOO3Djy
         EQqlHxTtbMGEE8mA6x2XBw2ECgbR9y6ZS1rqlC2xQfsHBjipC9cadM0uKuyexhvN0x93
         k80wEGBoqIiMrvi008KAnbEGbOywRBQBtrc6WJuf+RJTwHbrfp2xJ3ES2Blh9aaeV7MF
         sn5MWYTVT5jYkU50jZkgvTOzplUoQyJAZAAIRnuqgZIrY7YroC14n05NDSNQzdewB6oe
         m4jvH2JQRvBUQFqQV2RVjStv4Za6RmY7silH4dWxTZawFm1cPOKC6+mQDGBZAe7TTLko
         lODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3ubFjm4VVzuezD9K57VpIO57fRHdUfHFre4oE4/E04=;
        b=c/W6wraVe9LndsXKRHRKNRPZEd/p++J3zZ1Vkr5/3lHtdbuDMvsnhk3twfGe74KDBp
         6KjA+rz+C/0N8jmTjK0RvZ9DdSgJRV00t7bVt/Jjp+auxf/3iJtOKV+l1EQVFzVHajHE
         OH02AYs6gOSUfP9kGjD5Rjw6ho3htyRN6Bt/LkIx8C6w6Z61CKuZDp2l3gN9qrH80FQg
         kiCVQahw1Mcan5PcRqWbNhRQlmD2oxpdM3E4h9xSj5rG0nsWKN44Vw6ZzsWgjJvFWsUu
         yAEiBBSHUhdWcb2I206dDH3T+QIfsYVr/Z0AbqqIVIF15lqdF68sULB0nG2qczScePDG
         cE6g==
X-Gm-Message-State: ANhLgQ0YlWLEnyAJCjtPSyV709iMswvgxxJpnQyQRbd3jJd4RitTtgcJ
        KZT2Xv8oRBoAwGNHo4xVjjV6WQ==
X-Google-Smtp-Source: ADFU+vthmbr5J9ido3XqSuHL53iktFkKp5Zjtb6yGwfjf/rGGcpxQjJ5+XEG6T8A4hs6VdpG9JxD2w==
X-Received: by 2002:adf:ee8b:: with SMTP id b11mr6915157wro.404.1585749536778;
        Wed, 01 Apr 2020 06:58:56 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
        by smtp.gmail.com with ESMTPSA id a186sm2734787wmh.33.2020.04.01.06.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 06:58:56 -0700 (PDT)
Date:   Wed, 1 Apr 2020 15:58:48 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 07/10] iommu/ioasid: Use mutex instead of spinlock
Message-ID: <20200401135848.GH882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-8-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585158931-1825-8-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:55:28AM -0700, Jacob Pan wrote:
> Each IOASID or set could have multiple users with its own HW context
> to maintain. Often times access to the HW context requires thread context.
> For example, consumers of IOASIDs can register notification blocks to
> sync up its states. Having an atomic notifier is not feasible for these
> update operations.
> 
> This patch converts allocator lock from spinlock to mutex in preparation
> for IOASID notifier.

Unfortunately this doesn't work for SVA, which needs to call ioasid_free()
from the RCU callback of mmu_notifier_put(), which cannot sleep. We're
relying on MMU notifers this way to ensure that there is a single IOASID
per mm.

Thanks,
Jean
