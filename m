Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6A1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2C020756
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgENPZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:25:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:42920 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENPZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:25:35 -0400
IronPort-SDR: /rKbp9lSq4uFDVylUEPvhTK9wfLK1N2G0sik70JIZ7FqtZxi54OuXiU2MQTeENBOZ9x7bBxcm5
 SIFeUsYN5ULA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 08:25:34 -0700
IronPort-SDR: Ng2hBVYJXHRSIZgay8eUBPE0EZoRJvviZ2qMfzj8FYvf8AGmaHPL90x4D+uUNQg0wv84fsgGmS
 hylSshRCqn8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="298071283"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga002.fm.intel.com with ESMTP; 14 May 2020 08:25:33 -0700
Date:   Thu, 14 May 2020 08:31:43 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
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
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v13 3/8] iommu/vt-d: Add nested translation helper
 function
Message-ID: <20200514083143.6400d813@jacob-builder>
In-Reply-To: <20200514055424.GC22388@infradead.org>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1589410909-38925-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200514055424.GC22388@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 22:54:24 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> > +	 * 1. CPU vs. IOMMU
> > +	 * 2. Guest vs. Host.
> > +	 */
> > +	switch (addr_width) {
> > +#ifdef CONFIG_X86
> > +	case ADDR_WIDTH_5LEVEL:
> > +		if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> > +		    cap_5lp_support(iommu->cap)) {
> > +			pasid_set_flpm(pte, 1);
> > +		} else {
> > +			dev_err_ratelimited(dev, "5-level paging
> > not supported\n");
> > +			return -EINVAL;
> > +		}
> > +		break;  
> 
> The normal style would be to handle the early error return first:
> 
> 		if (!cpu_feature_enabled(X86_FEATURE_LA57) ||
> 		    !cap_5lp_support(iommu->cap)) {
> 			dev_err_ratelimited(dev,
> 				"5-level paging not supported\n");
> 			return -EINVAL;
> 		}
> 
> 		pasid_set_flpm(pte, 1);
> 		break;
> 

Sounds good. I was thinking in positive logic.

thanks
