Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD892C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06B520769
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 12:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgCVM1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 08:27:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:23953 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgCVM1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 08:27:33 -0400
IronPort-SDR: RZk2mM5o64gNf2wmRLEQMDAl4zHstOavOESo07JjzkUT950FtTlt9sT+jWun8gSQlXw5UPeNt6
 n47y3M7Q+l3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 05:27:32 -0700
IronPort-SDR: JTj7uc0RiWhatZgQOskzWH3SQgaANaBTrPWHGcjeB0aAHqUXXZDrkkbmGHYOeY5sGRaaqQUQso
 t0QFsS+FgF1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,292,1580803200"; 
   d="scan'208";a="356846585"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2020 05:27:32 -0700
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, eric.auger@redhat.com
Cc:     kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        joro@8bytes.org, ashok.raj@intel.com, yi.l.liu@intel.com,
        jun.j.tian@intel.com, yi.y.sun@intel.com, jean-philippe@linaro.org,
        peterx@redhat.com, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, hao.wu@intel.com
Subject: [PATCH v1 1/2] vfio/pci: Expose PCIe PASID capability to guest
Date:   Sun, 22 Mar 2020 05:33:13 -0700
Message-Id: <1584880394-11184-2-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yi L <yi.l.liu@intel.com>

This patch exposes PCIe PASID capability to guest. Existing vfio_pci
driver hides it from guest by setting the capability length as 0 in
pci_ext_cap_length[].

This capability is required for vSVA enabling on pass-through PCIe
devices.

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 90c0b80..4b9af99 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -95,7 +95,7 @@ static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX + 1] = {
 	[PCI_EXT_CAP_ID_LTR]	=	PCI_EXT_CAP_LTR_SIZEOF,
 	[PCI_EXT_CAP_ID_SECPCI]	=	0,	/* not yet */
 	[PCI_EXT_CAP_ID_PMUX]	=	0,	/* not yet */
-	[PCI_EXT_CAP_ID_PASID]	=	0,	/* not yet */
+	[PCI_EXT_CAP_ID_PASID]	=	PCI_EXT_CAP_PASID_SIZEOF,
 };
 
 /*
-- 
2.7.4

