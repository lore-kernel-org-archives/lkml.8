Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11B9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829302078C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgENPOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:14:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:43961 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgENPOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:14:23 -0400
IronPort-SDR: Sho0QeQFLfDBiV9+4MG6HPL6SVxs7oDRuPaNbSLcUypcuIvM7UzAKS2RHImT3NfwIPRkmXnEoy
 GHX46GiyqeTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 08:14:22 -0700
IronPort-SDR: GPC+qMzbO5w3nXLk2I1zxCtLvHmDjizN++vGJHd3cNytQ/CKvIfb1WyQzRJ+RGggylclVZFo7I
 XmyHJ8E66PCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="266275355"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 14 May 2020 08:14:22 -0700
Date:   Thu, 14 May 2020 08:20:33 -0700
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
Subject: Re: [PATCH v13 2/8] iommu/vt-d: Use a helper function to skip agaw
 for SL
Message-ID: <20200514082033.54d2f621@jacob-builder>
In-Reply-To: <20200514055132.GB22388@infradead.org>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1589410909-38925-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200514055132.GB22388@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 22:51:32 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, May 13, 2020 at 04:01:43PM -0700, Jacob Pan wrote:
> > An Intel iommu domain uses 5-level page table by default. If the
> > iommu that the domain tries to attach supports less page levels,
> > the top level page tables should be skipped. Add a helper to do
> > this so that it could be used in other places.  
> 
> Please use up all 73 chars for the commit log.

Will do. thanks.
