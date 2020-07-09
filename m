Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64CBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91BAB20739
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgGIHKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:10:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:2891 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgGIHKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:10:15 -0400
IronPort-SDR: 4QnAR8WYFyZvLSQf6sGOIa6d01SEzEoBMwZqqg0X6VuH3EoAhWx5fT4utoXyZIPcIGRvvYcI4N
 2p4z0Q1fkbRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="127534960"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="127534960"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 00:10:14 -0700
IronPort-SDR: OBw5NJTJ7Znsq61PDeO9m7aYdCc4C2KPfERJMXwybxLxgfoRmIQZ34ipr+P+qESB5G1ZzMXP7x
 //IoscYm/CEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="316138822"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2020 00:10:12 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/4] iommu/vt-d: Add prq report and response support
Date:   Thu,  9 Jul 2020 15:05:33 +0800
Message-Id: <20200709070537.18473-1-baolu.lu@linux.intel.com>
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
v2->v3:
  - Adress Kevin's review comments
    https://lore.kernel.org/linux-iommu/20200706002535.9381-1-baolu.lu@linux.intel.com/T/#t
  - Set IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID flag
    https://lore.kernel.org/linux-iommu/20200706002535.9381-1-baolu.lu@linux.intel.com/T/#m0190af2f6cf967217e9def6fa0fed4e0fe5a477e

v1->v2:
  - v1 posted at https://lkml.org/lkml/2020/6/27/387
  - Remove unnecessary pci_get_domain_bus_and_slot()
  - Return error when sdev == NULL in intel_svm_page_response()

Lu Baolu (4):
  iommu/vt-d: Refactor device_to_iommu() helper
  iommu/vt-d: Add a helper to get svm and sdev for pasid
  iommu/vt-d: Report page request faults for guest SVA
  iommu/vt-d: Add page response ops support

 drivers/iommu/intel/iommu.c |  56 ++----
 drivers/iommu/intel/svm.c   | 332 ++++++++++++++++++++++++++++--------
 include/linux/intel-iommu.h |   6 +-
 3 files changed, 278 insertions(+), 116 deletions(-)

-- 
2.17.1

