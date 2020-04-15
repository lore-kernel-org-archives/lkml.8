Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27E2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAD92076A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407900AbgDOF3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:29:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:30107 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389364AbgDOF3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:29:01 -0400
IronPort-SDR: cACbbizbj4GSYsniv1iDto6uUkJIRri6Bpo4XM3FgVj5I5vHAFennK8L8eCfyHkapV8dH7QaSD
 nvOFQxxvE4xw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 22:29:00 -0700
IronPort-SDR: 7MxBb7rl7r0a399Q743Ii+47fUxTTEONxEMePjuwNCoPfGk8H/nKEWgA45CJgDJLFvSzGt7EtG
 0F8+uQNETuWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; 
   d="scan'208";a="277504145"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2020 22:28:58 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/7] iommu/vt-d: Add page request draining support
Date:   Wed, 15 Apr 2020 13:25:35 +0800
Message-Id: <20200415052542.30421-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a PASID is stopped or terminated, there can be pending PRQs
(requests that haven't received responses) in the software and
remapping hardware. The pending page requests must be drained
so that the pasid could be reused. The register level interface
for page request draining is defined in 7.11 of the VT-d spec.
This series adds the support for page requests draining.

This includes two parts:
 - PATCH 1/7 ~ 3/7: refactor the qi_submit_sync() to support
   multiple descriptors per submission which will be used by
   PATCH 6/7.
 - PATCH 4/7 ~ 7/7: add page request drain support after a
   pasid entry is torn down due to an unbind operation.

Please help to review.

Best regards,
baolu

Change log:
 v1->v2:
  - Fix race between multiple prq handling threads

Lu Baolu (7):
  iommu/vt-d: Refactor parameters for qi_submit_sync()
  iommu/vt-d: Multiple descriptors per qi_submit_sync()
  iommu/vt-d: debugfs: Add support to show inv queue internals
  iommu/vt-d: Refactor prq_event_thread()
  iommu/vt-d: Save prq descriptors in an internal list
  iommu/vt-d: Add page request draining support
  iommu/vt-d: Remove redundant IOTLB flush

 drivers/iommu/dmar.c                |  63 +++--
 drivers/iommu/intel-iommu-debugfs.c |  62 +++++
 drivers/iommu/intel-pasid.c         |   4 +-
 drivers/iommu/intel-svm.c           | 383 ++++++++++++++++++----------
 drivers/iommu/intel_irq_remapping.c |   2 +-
 include/linux/intel-iommu.h         |  12 +-
 6 files changed, 369 insertions(+), 157 deletions(-)

-- 
2.17.1

