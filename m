Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A37C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472062078E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgCZQi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:38:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:32663 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbgCZQi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:38:58 -0400
IronPort-SDR: CUG/gTmwJiNJB8jUdADp7XLfPtxKDzV+2l1oUWuZ6Jq0/WbESkYkLSrf3B5fOurAict4yMI3Rk
 0OAje6PQIynQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 09:38:58 -0700
IronPort-SDR: 5qAPNHMPSfUJ2crJnR1N0kbPgi0WNOKmtBXLIv/QW9b1irnPu+DsZbog/yh3hn+zQuOdOnAb5L
 +QiA/Z+IxVng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="326618818"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2020 09:38:58 -0700
Date:   Thu, 26 Mar 2020 09:44:42 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200326094442.5be042ce@jacob-builder>
In-Reply-To: <20200326092316.GA31648@infradead.org>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200326092316.GA31648@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thanks for the review. Please see my comments inline.

On Thu, 26 Mar 2020 02:23:16 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Mar 25, 2020 at 04:17:05PM -0700, Jacob Pan wrote:
> > Having a single UAPI version to govern the user-kernel data
> > structures makes compatibility check straightforward. On the
> > contrary, supporting combinations of multiple versions of the data
> > can be a nightmare to maintain.
> > 
> > This patch defines a unified UAPI version to be used for
> > compatibility checks between user and kernel.  
> 
> This is bullshit.  Version numbers don't scale and we've avoided them
> everywhere.  You need need flags specifying specific behavior.
> 
We have flags or the equivalent in each UAPI structures. The flags
are used for checking validity of extensions as well. And you are right
we can use them for checking specific behavior.

So we have two options here:
1. Have a overall version for a quick compatibility check while
starting a VM. If not compatible, we will stop guest SVA entirely.

2. Let each API calls check its own capabilities/flags at runtime. It
may fail later on and lead to more complex error handling.
For example, guest starts with SVA support, allocate a PASID, bind
guest PASID works great. Then when IO page fault happens, it try to do
page request service and found out certain flags are not compatible.
This case is more complex to handle.

I am guessing your proposal is #2. right?

Overall, we don;t expect much change to the UAPI other than adding some
vendor specific part of the union. Is the scalability concern based on
frequent changes?

> > +#define IOMMU_UAPI_VERSION	1
> > +static inline int iommu_get_uapi_version(void)
> > +{
> > +	return IOMMU_UAPI_VERSION;
> > +}  
> 
> Also inline functions like this in UAPI headers that actually get
> included by userspace programs simply don't work.

I will remove that, user can just use IOMMU_UAPI_VERSION directly.
