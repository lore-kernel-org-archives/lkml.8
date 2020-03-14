Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FDAC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E27B206FA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCNBJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 21:09:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:43136 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgCNBJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:09:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 18:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,550,1574150400"; 
   d="scan'208";a="266912386"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2020 18:09:41 -0700
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
Subject: [PATCH v2 0/6] Replace private domain with per-group default domain
Date:   Sat, 14 Mar 2020 09:06:59 +0800
Message-Id: <20200314010705.30711-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices are reqired to use a specific type (identity or dma)
of default domain when they are used with a vendor iommu. When the
system level default domain type is different from it, the vendor
iommu driver has to request a new default domain with either
iommu_request_dma_domain_for_dev() or iommu_request_dm_for_dev()
in the add_dev() callback. Unfortunately, these two helpers only
work when the group hasn't been assigned to any other devices,
hence, some vendor iommu driver has to use a private domain if
it fails to request a new default one.

This patch series aims to remove the private domain requirement
in vendor iommu driver with enabling the iommu generic code to
support configuring per-group default domain. It introduces a
new callback in iommu_ops, named def_domain_type(), so that
the iommu generic code could check whether a device is required
to use any specific type of default domain during the process of
device probing.

If unlikely a device requires a special default domain type other
than that in use, iommu probe procedure will either allocate a new
domain according to the specified domain type, or (if the group has
other devices sitting in it) change the default domain. The vendor
iommu driver which exposes the def_domain_type callback should
guarantee that there're no multiple devices belonging to a same
group require differnt types of default domain.

Please help to review.

Best regards,
baolu

Change log:
v1->v2:
 - Rename the iommu ops callback to def_domain_type

Lu Baolu (5):
  iommu: Configure default domain with def_domain_type
  iommu/vt-d: Don't force 32bit devices to uses DMA domain
  iommu/vt-d: Don't force PCI sub-hierarchy to use DMA domain
  iommu/vt-d: Add def_domain_type callback
  iommu/vt-d: Apply per-device dma_ops

Sai Praneeth Prakhya (1):
  iommu: Add def_domain_type() callback in iommu_ops

 drivers/iommu/intel-iommu.c | 453 +++---------------------------------
 drivers/iommu/iommu.c       |  93 +++++++-
 include/linux/iommu.h       |   6 +
 3 files changed, 126 insertions(+), 426 deletions(-)

-- 
2.17.1

