Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33335C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B5020719
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgCQHFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:05:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:56620 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQHFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:05:13 -0400
IronPort-SDR: 1p1AfAsjooOPLpi+Gf+1K9YNzGPcaUVy9lu2niqrf/TB94YxllO32y9i4/ER/mi6PaJG5P9Cny
 YEev4YLsBvQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 00:05:13 -0700
IronPort-SDR: KhH0qzyCLlOIhb6zL/i+bFFfzSMHbL5pW7UQ5Cyeq1zAAFRVlKtusqJvUdomuIuad2W5jPRi87
 mMiVXz9o5iwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="267867281"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 00:05:10 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/5] iommu/vt-d: Add page request draining support
Date:   Tue, 17 Mar 2020 15:02:24 +0800
Message-Id: <20200317070229.21131-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a PASID is stopped or terminated, there can be pending
PRQs (requests that haven't received responses) in remapping
hardware. VT-d driver must drain the pending page requests so
that the pasid could be reused. The register level interface
for page request draining is defined in 7.11 of the VT-d spec.
This series adds the support for page requests draining.

This functionality was mainly developed and tested by
	Jacob Pan <jacob.jun.pan@linux.intel.com>
	Liu Yi L <yi.l.liu@intel.com>.
Thanks a lot.

Please help to review.

Best regards,
baolu

Jacob Pan (1):
  iommu/vt-d: Add page request draining support

Lu Baolu (4):
  iommu/vt-d: Add get_domain_info() helper
  iommu/vt-d: Refactor parameters for qi_submit_sync()
  iommu/vt-d: Multiple descriptors per qi_submit_sync()
  iommu/vt-d: Refactor prq_event_thread()

 drivers/iommu/dmar.c                |  50 ++++---
 drivers/iommu/intel-iommu.c         |  38 +++--
 drivers/iommu/intel-pasid.c         |  16 +--
 drivers/iommu/intel-svm.c           | 207 ++++++++++++++++++++++++----
 drivers/iommu/intel_irq_remapping.c |   2 +-
 include/linux/intel-iommu.h         |   9 +-
 6 files changed, 258 insertions(+), 64 deletions(-)

-- 
2.17.1

