Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDADC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C608205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Px07Vdw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgENFvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgENFvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:51:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426CBC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lHQOBRbPUcOA6NMwZdI6zLolOSP00QCntLQdV40Av9E=; b=Px07Vdw5BpOFOzujPzASdTSwFW
        bjuw5xdheRtkq0QEcHGcQqzmfHrO+zwDb8uEXhN5/5kjnBvkrCs3PMFIff20rlMpUH0GR75GZrv0M
        42zdElDOf2GKoOAlEcaK5eiOJM3869hphcggLE384dQe0Tk5wCKFcoXyFrFQdwVDmdiZHgDjPksD/
        jQMk2B9zA6dY6/JNbJiZVj4lEPJM7DrM6gfx3+bfMEeXsnKuEyDZ1fX0JY8eXFLIfEIIF3xlA2sg5
        W0EFzo64gCt+OWNnuV7lMh+r9sUGY5UMqtZpAZH7iBKkGSwm1MjOzUv31lhD6wtXMqEUUWWmiYoSJ
        SVDiaEbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZ6mK-0003fq-Ed; Thu, 14 May 2020 05:51:32 +0000
Date:   Wed, 13 May 2020 22:51:32 -0700
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
Subject: Re: [PATCH v13 2/8] iommu/vt-d: Use a helper function to skip agaw
 for SL
Message-ID: <20200514055132.GB22388@infradead.org>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1589410909-38925-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589410909-38925-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 04:01:43PM -0700, Jacob Pan wrote:
> An Intel iommu domain uses 5-level page table by default. If the
> iommu that the domain tries to attach supports less page levels,
> the top level page tables should be skipped. Add a helper to do
> this so that it could be used in other places.

Please use up all 73 chars for the commit log.
