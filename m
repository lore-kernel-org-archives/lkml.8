Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F6EC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22DB2076E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgF1Ahx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 20:37:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:54808 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgF1Ahx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 20:37:53 -0400
IronPort-SDR: nRZutuVKU5irHpvcQVPC//+V1fi3Dbl4Hi7F2DlL/Y+PZSudYYpF2M6F5LaQ4T9Wc1VM1GmI5u
 Df8my3iYIoGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="144805152"
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="scan'208";a="144805152"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2020 17:37:52 -0700
IronPort-SDR: j6OM7XnrZ+9iuGMNOEj3FL6aaSkLAEzzuZQGB7FREz9MHFJskQrH1gleXce3tHXRPqXLS1Nrfb
 flyp96BmTt1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="scan'208";a="302695000"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2020 17:37:50 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/4] iommu/vt-d: Add prq report and response support
Date:   Sun, 28 Jun 2020 08:33:28 +0800
Message-Id: <20200628003332.5720-1-baolu.lu@linux.intel.com>
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

Lu Baolu (4):
  iommu/vt-d: Refactor device_to_iommu() helper
  iommu/vt-d: Add a helper to get svm and sdev for pasid
  iommu/vt-d: Report page request faults for guest SVA
  iommu/vt-d: Add page response ops support

 drivers/iommu/intel/iommu.c |  56 +++----
 drivers/iommu/intel/svm.c   | 285 ++++++++++++++++++++++++++++--------
 include/linux/intel-iommu.h |   6 +-
 3 files changed, 246 insertions(+), 101 deletions(-)

-- 
2.17.1

