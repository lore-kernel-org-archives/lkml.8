Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F112C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6157720768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393731AbgDOH5M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:57:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:5698 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390630AbgDOH5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:57:11 -0400
IronPort-SDR: E5ev1TVf2mM0mIZ3SfO8nWm4pmtssxmJkhxC7r5IPNu4O83TgkV3KKIjIGTaayJmz1J3oJU/KD
 qWuLPK/YXYbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 00:57:11 -0700
IronPort-SDR: duupAcieAe2PFajTeb6R5W3wjVPdK9W9u9YT+zNk5DnJXl7l7cdULN187mGQvvosYMdxM1nNL+
 PisPjyxt6mjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="453838877"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2020 00:57:11 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 00:57:10 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 00:57:10 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.7]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 15:57:08 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/7] iommu/vt-d: Add page request draining support
Thread-Topic: [PATCH v2 0/7] iommu/vt-d: Add page request draining support
Thread-Index: AQHWEubGFdWwTRJ930mQo8Wb1/6Ng6h5z/pA
Date:   Wed, 15 Apr 2020 07:57:07 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D820475@SHSMSX104.ccr.corp.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
In-Reply-To: <20200415052542.30421-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 15, 2020 1:26 PM
> 
> When a PASID is stopped or terminated, there can be pending PRQs
> (requests that haven't received responses) in the software and
> remapping hardware. The pending page requests must be drained
> so that the pasid could be reused. The register level interface
> for page request draining is defined in 7.11 of the VT-d spec.
> This series adds the support for page requests draining.

7.11 doesn't include register-level interface. It just talks about
the general requirements on system software, endpoint device
and its driver.

Thanks
Kevin

> 
> This includes two parts:
>  - PATCH 1/7 ~ 3/7: refactor the qi_submit_sync() to support
>    multiple descriptors per submission which will be used by
>    PATCH 6/7.
>  - PATCH 4/7 ~ 7/7: add page request drain support after a
>    pasid entry is torn down due to an unbind operation.
> 
> Please help to review.
> 
> Best regards,
> baolu
> 
> Change log:
>  v1->v2:
>   - Fix race between multiple prq handling threads
> 
> Lu Baolu (7):
>   iommu/vt-d: Refactor parameters for qi_submit_sync()
>   iommu/vt-d: Multiple descriptors per qi_submit_sync()
>   iommu/vt-d: debugfs: Add support to show inv queue internals
>   iommu/vt-d: Refactor prq_event_thread()
>   iommu/vt-d: Save prq descriptors in an internal list
>   iommu/vt-d: Add page request draining support
>   iommu/vt-d: Remove redundant IOTLB flush
> 
>  drivers/iommu/dmar.c                |  63 +++--
>  drivers/iommu/intel-iommu-debugfs.c |  62 +++++
>  drivers/iommu/intel-pasid.c         |   4 +-
>  drivers/iommu/intel-svm.c           | 383 ++++++++++++++++++----------
>  drivers/iommu/intel_irq_remapping.c |   2 +-
>  include/linux/intel-iommu.h         |  12 +-
>  6 files changed, 369 insertions(+), 157 deletions(-)
> 
> --
> 2.17.1

