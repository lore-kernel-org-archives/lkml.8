Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A56C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7B9206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgDVIJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:09:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:3118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVIJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:09:22 -0400
IronPort-SDR: SjwJpBwfe4wHCh4ayL/YBGaSQZ7FjFkdBFGySeM+LnnSM3Yto9xtuIxHYRojSuip/2ZEW6sMAJ
 SkP9sUwBrw4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 01:09:22 -0700
IronPort-SDR: NYAah0qsiK+CbyM/jO/clQIEDbrOCPop07kDA389yxLeqORC7eqQWTB0w7sqRpL07tXgPNqWp+
 jEk/3J5OMTAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="365609616"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2020 01:09:20 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/4] iommu/vt-d: Add page request draining support
Date:   Wed, 22 Apr 2020 16:06:07 +0800
Message-Id: <20200422080611.15689-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a PASID is stopped or terminated, there can be pending PRQs
(requests that haven't received responses) in the software and
remapping hardware. The pending page requests must be drained
so that the pasid could be reused. The chapter 7.10 in the VT-d
specification specifies the software steps to drain pending page
requests and responses.

This includes two parts:
 - PATCH 1/4 ~ 2/4: refactor the qi_submit_sync() to support multiple
   descriptors per submission which will be used in the following
   patch.
 - PATCH 3/4 ~ 4/4: add page request drain support after a pasid entry
   is torn down.

Please help to review.

Best regards,
baolu

Change log:
 v2->v3:
  - Address Kevin's review comments
    - Squash the first 2 patches together;
    - The prq thread is serialized, no need to consider reentrance;
    - Ensure no new-coming prq before drain prq in queue;
    - Handle page request overflow case.

 v1->v2:
  - Fix race between multiple prq handling threads.


Lu Baolu (4):
  iommu/vt-d: Multiple descriptors per qi_submit_sync()
  iommu/vt-d: debugfs: Add support to show inv queue internals
  iommu/vt-d: Add page request draining support
  iommu/vt-d: Remove redundant IOTLB flush

 drivers/iommu/dmar.c                |  63 +++++++++-------
 drivers/iommu/intel-iommu-debugfs.c |  62 +++++++++++++++
 drivers/iommu/intel-pasid.c         |   4 +-
 drivers/iommu/intel-svm.c           | 112 +++++++++++++++++++++++++---
 drivers/iommu/intel_irq_remapping.c |   2 +-
 include/linux/intel-iommu.h         |  13 +++-
 6 files changed, 216 insertions(+), 40 deletions(-)

-- 
2.17.1

