Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A37EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97462078A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407951AbgDPG1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:27:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:28084 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407996AbgDPG1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:27:06 -0400
IronPort-SDR: YNq4ss/oPiPXVo5z/XMOuiGelGyIUmsrGWygjSI8DXOMq3xuhCQPb1ayYf91Jr1NXebSjhlcs2
 /Ll7kexx/NWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 23:27:06 -0700
IronPort-SDR: dv7ZeaZqSqQD1m3XJF5id1Sh44URsCqzejypAsEWfIENW6XR2A8p/sqJRgp3+L1lXomWMDkut6
 VXmqq46m2ZBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="277881075"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2020 23:27:02 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/3] Replace private domain with per-group default domain
Date:   Thu, 16 Apr 2020 14:23:51 +0800
Message-Id: <20200416062354.10307-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices are required to use a specific type (identity or dma)
of default domain when they are used with a vendor iommu. When the
system level default domain type is different from it, the vendor
iommu driver has to request a new default domain with either
iommu_request_dma_domain_for_dev() or iommu_request_dm_for_dev()
in the add_dev() callback. Unfortunately, these two helpers only
work when the group hasn't been assigned to any other devices,
hence, some vendor iommu driver has to use a private domain if
it fails to request a new default one.

Joerg proposed an on-going proposal which makes the default domain
framework to support configuring per-group default domain during
boot process.

https://lkml.org/lkml/2020/4/14/616

Hence, there is no need to keep the private domain implementation
in the Intel IOMMU driver. This patch series aims to remove it.

Best regards,
baolu

Change log:
v2->v3:
 - Port necessary patches on the top of Joerg's new proposal.
   https://lkml.org/lkml/2020/4/14/616
   The per-group default domain proposed previously in this series
   will be deprecated due to a race concern between domain switching
   and device driver probing.

v1->v2:
 - Rename the iommu ops callback to def_domain_type

Lu Baolu (3):
  iommu/vt-d: Allow 32bit devices to uses DMA domain
  iommu/vt-d: Allow PCI sub-hierarchy to use DMA domain
  iommu/vt-d: Apply per-device dma_ops

 drivers/iommu/intel-iommu.c | 396 +++---------------------------------
 1 file changed, 26 insertions(+), 370 deletions(-)

-- 
2.17.1

