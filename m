Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74C2C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3CB2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgA2F5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:57:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:55027 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgA2F4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:56:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 21:56:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,376,1574150400"; 
   d="scan'208";a="252500707"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2020 21:56:51 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/3] IOMMU user API enhancement
Date:   Tue, 28 Jan 2020 22:02:01 -0800
Message-Id: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU user API header was introduced to support nested DMA translation and
related fault handling. The current UAPI data structures consist of three
areas that cover the interactions between host kernel and guest:
 - fault handling
 - cache invalidation
 - bind guest page tables, i.e. guest PASID

With future extension in mind, the UAPI structures passed from user to kernel
always starts with a mandatory version field (u32). While this is flexible
for extensions of individual structures, it is difficult to maintain support
of combinations of different version numbers.

This patchset introduces a unified UAPI version number that governs all the
UAPI data structure versions. When userspace query UAPI version for check on
compatibility, a single match would be sufficient.

After UAPI version check, users such as VFIO can also retrieve the matching
data structure size based on version and type. Kernel IOMMU UAPI support is
always backward compatible. Data structures are also only open to extension
and closed to modifications.

The introduction of UAPI version does not change the existing UAPI but rather
simplify the data structure version and size matching.

Thanks,

Jacob

Jacob Pan (3):
  iommu/uapi: Define uapi version and capabilities
  iommu/uapi: Use unified UAPI version
  iommu/uapi: Add helper function for size lookup

 drivers/iommu/intel-iommu.c |  3 ++-
 drivers/iommu/intel-svm.c   |  2 +-
 drivers/iommu/iommu.c       | 25 +++++++++++++++++++-
 include/linux/iommu.h       |  6 +++++
 include/uapi/linux/iommu.h  | 57 ++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 84 insertions(+), 9 deletions(-)

-- 
2.7.4

