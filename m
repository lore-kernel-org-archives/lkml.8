Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC3CC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DBA206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgELA4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:56:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:36642 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgELA4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:56:35 -0400
IronPort-SDR: FdxSaoSTi91oPsNbnmcuPF+a4Bbf00J6mZ5SwllUtUJ8ezTfcC9a1x/T8h7xm/jOtX5EhPsdR4
 3/1nvAi6P+9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 17:56:35 -0700
IronPort-SDR: cvFulzHyc6zjTWxm9v/k/Dr4cBjfdprX5LLtXpTnSCmkLw4FzgeER4Z6Wu9a7KqJtd1/9rezdz
 3CmU5/liMPUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="286458375"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 17:56:33 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 0/5] iommu/vt-d: Add page request draining support
Date:   Tue, 12 May 2020 08:53:02 +0800
Message-Id: <20200512005307.19860-1-baolu.lu@linux.intel.com>
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
 - PATCH 1/5 ~ 2/5: refactor the qi_submit_sync() to support multiple
   descriptors per submission which will be used in the following
   patch.
 - PATCH 3/5 ~ 5/5: add page request drain support after a pasid entry
   is torn down.

This series is based on Jacob's vSVA support hence the guest pasid
could also be drained.

https://lkml.org/lkml/2020/4/21/1038

Best regards,
baolu

Change log:
v4->v5:
  - Only set FPD bit in PASID entry when entry changed from present
    to non-present;
  - Check pri_support in drain helper;
  - Refine the wait/completion usage.

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
 drivers/iommu/intel-pasid.h         |   4 +-
 drivers/iommu/intel-svm.c           | 128 ++++++++++++++++++++++++----
 drivers/iommu/intel_irq_remapping.c |   2 +-
 include/linux/intel-iommu.h         |  13 ++-
 8 files changed, 253 insertions(+), 53 deletions(-)

-- 
2.17.1

