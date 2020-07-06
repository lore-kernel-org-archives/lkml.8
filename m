Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA09C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808F220737
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGFAaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 20:30:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:32284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbgGFAaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 20:30:11 -0400
IronPort-SDR: QWFlGMfW8VRyK3F9pTdv6QN3W5kUJSkrN0yYMpBydH4DECJk19ZDY8OWYzu4j7c4JPBad7DGqT
 0InHt1rWQ+Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="212331317"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="212331317"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 17:30:10 -0700
IronPort-SDR: Iics2lKfEiEEFtnVFe3qwfMztH0gnI+NifAvr9us7R8JwdBerX7Lw7q/YmSGTB542tYs22Xg/A
 MOMBvnMoYjiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="266404912"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jul 2020 17:30:07 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/4] iommu/vt-d: Add prq report and response support
Date:   Mon,  6 Jul 2020 08:25:31 +0800
Message-Id: <20200706002535.9381-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds page request event reporting and response support to
the Intel IOMMU driver. This is necessary when the page requests must
be processed by any component other than the vendor IOMMU driver. For
example, when a guest page table was bound to a PASID through the
iommu_ops->sva_bind_gpasid() api, the page requests should be routed to
the guest, and after the page is served, the device should be responded
with the result.

Your review comments are very appreciated.

Best regards,
baolu

Change log:
v1->v2:
  - v1 posted at https://lkml.org/lkml/2020/6/27/387
  - Remove unnecessary pci_get_domain_bus_and_slot()
  - Return error when sdev == NULL in intel_svm_page_response()

Lu Baolu (4):
  iommu/vt-d: Refactor device_to_iommu() helper
  iommu/vt-d: Add a helper to get svm and sdev for pasid
  iommu/vt-d: Report page request faults for guest SVA
  iommu/vt-d: Add page response ops support

 drivers/iommu/intel/iommu.c |  56 ++-----
 drivers/iommu/intel/svm.c   | 302 +++++++++++++++++++++++++++---------
 include/linux/intel-iommu.h |   6 +-
 3 files changed, 248 insertions(+), 116 deletions(-)

-- 
2.17.1

