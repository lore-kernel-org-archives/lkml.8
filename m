Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD7DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF6C2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgFIMfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:35:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:37253 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgFIMfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:35:13 -0400
IronPort-SDR: 0wMAF2qIV6Jlcnzld7vKWADiHb15TU/7Qu+8Pxm2Xg5mM6M1UVZLy/ox+lQqTMmTXpHEB0MHX3
 ULiX9KHlxevw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 05:35:11 -0700
IronPort-SDR: c3Gq4jgpD1P0U/nhnJpthh+H0kg5i1mggj34q/eXOuRBSP0ANXFhu5AIkMrQfvREtM73cL88xK
 VMuM2TwGLrnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; 
   d="scan'208";a="379724594"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 09 Jun 2020 05:35:10 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 09 Jun 2020 15:35:09 +0300
Date:   Tue, 9 Jun 2020 15:35:09 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PCI ACS for platform opt in hint
Message-ID: <20200609123509.GP247495@lahna.fi.intel.com>
References: <20200608231720.27740-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608231720.27740-1-baolu.lu@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 07:17:20AM +0800, Lu Baolu wrote:
> PCI ACS is disabled if Intel IOMMU is off by default or intel_iommu=off
> is used in command line. Unfortunately, Intel IOMMU will be forced on if
> there're devices sitting on an external facing PCI port that is marked
> as untrusted (for example, thunderbolt peripherals). That means, PCI ACS
> is disabled while Intel IOMMU is forced on to isolate those devices. As
> the result, the devices of an MFD will be grouped by a single group even
> the ACS is supported on device.
> 
> [    0.691263] pci 0000:00:07.1: Adding to iommu group 3
> [    0.691277] pci 0000:00:07.2: Adding to iommu group 3
> [    0.691292] pci 0000:00:07.3: Adding to iommu group 3
> 
> Fix it by requesting PCI ACS when Intel IOMMU is detected with platform
> opt in hint.
> 
> Fixes: 89a6079df791a ("iommu/vt-d: Force IOMMU on for platform opt in hint")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
