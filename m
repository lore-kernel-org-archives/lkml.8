Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08041C47247
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E297A20721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgEFCDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:03:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:39086 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgEFCDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:03:13 -0400
IronPort-SDR: EHMDYK9SA0tAO3jOEB9kgtT7ndAPGBMYCuXNttR912vRTNvc8j1PWp27Uf2FB0UhahCDnY/0bZ
 f0wyCymTNtuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 19:03:11 -0700
IronPort-SDR: EYAQbLoNwp3XOKfPvss+uAsi4T3AQA8oKDTXzARQK2Q7Pz/yFy6xL0UxT0Tn0+l5p7SFL0V+nt
 bOQXjH65zT6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,357,1583222400"; 
   d="scan'208";a="369645032"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2020 19:03:07 -0700
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
Subject: [PATCH v4 0/3] Replace private domain with per-group default domain
Date:   Wed,  6 May 2020 09:59:44 +0800
Message-Id: <20200506015947.28662-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices are required to use a specific type (identity or dma) of
default domain when they are used with a vendor iommu. When the system
level default domain type is different from it, the vendor iommu driver
has to request a new default domain with either
iommu_request_dma_domain_for_dev() or iommu_request_dm_for_dev() in the
add_dev() callback. Unfortunately, these two helpers only work when the
group hasn't been assigned to any other devices, hence, some vendor iommu
driver has to use a private domain if it fails to request a new default
one.

Joerg proposed an on-going proposal which makes the default domain
framework to support configuring per-group default domain during boot
process.

https://lkml.org/lkml/2020/4/14/616
[This has been applied in iommu/next.]

Hence, there is no need to keep the private domain implementation
in the Intel IOMMU driver. This patch series aims to remove it.

Best regards,
baolu

Change log:
v3->v4:
 - Make the commit message of the first patch more comprehensive.

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

