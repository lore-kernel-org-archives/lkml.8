Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D729C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1FBF20708
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgEGA7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 20:59:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:26590 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgEGA7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:59:04 -0400
IronPort-SDR: F9CnFysz0Y0DxUvgceAnqgyN3L6E7mqNAQCFnWYfoC6xM6CwF1745GxdjxbFbV3ay6DbS+Azgs
 PzedYohv/ORw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 17:59:04 -0700
IronPort-SDR: HBHWzTc5qEKEfQUKVT27+UvyCL1wQmiUGmuWH1fJqN9zIu8Fpx9F4aaGHTinu4dkggs9ne6hVm
 /jojBFq9QJhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="407461777"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by orsmga004.jf.intel.com with ESMTP; 06 May 2020 17:59:00 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 0/5] iommu/vt-d: Add page request draining support
Date:   Thu,  7 May 2020 08:55:29 +0800
Message-Id: <20200507005534.3080-1-baolu.lu@linux.intel.com>
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

Best regards,
baolu

Change log:
v3->v4:
  - Remove prq drain in mm notifier;
  - Set PASID FPD bit when pasid is cleared in mm notifier and clear
    it in unbound().

 v2->v3:
  - Address Kevin's review comments
    - Squash the first 2 patches together;
    - The prq thread is serialized, no need to consider reentrance;
    - Ensure no new-coming prq before drain prq in queue;
    - Handle page request overflow case.

 v1->v2:
  - Fix race between multiple prq handling threads.

Lu Baolu (5):
  iommu/vt-d: Multiple descriptors per qi_submit_sync()
  iommu/vt-d: debugfs: Add support to show inv queue internals
  iommu/vt-d: Disable non-recoverable fault processing before unbind
  iommu/vt-d: Add page request draining support
  iommu/vt-d: Remove redundant IOTLB flush

 drivers/iommu/dmar.c                |  63 ++++++++------
 drivers/iommu/intel-iommu-debugfs.c |  62 ++++++++++++++
 drivers/iommu/intel-iommu.c         |   4 +-
 drivers/iommu/intel-pasid.c         |  30 +++++--
 drivers/iommu/intel-pasid.h         |   3 +-
 drivers/iommu/intel-svm.c           | 123 ++++++++++++++++++++++++----
 drivers/iommu/intel_irq_remapping.c |   2 +-
 include/linux/intel-iommu.h         |  13 ++-
 8 files changed, 247 insertions(+), 53 deletions(-)

-- 
2.17.1

