Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1C6C2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C509721556
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607571;
	bh=9VJsLzw6WQVDD3O/6pkEdJQA2rnG1UciyKn9E9/Lk50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hjUSHViPB4P6Jj15Rwl1lvz0OMx1KQstAfPJk4zrUQQMg+9uSehWJoBPSGM2074lw
	 9pm+5Yd2ipdGWyzcrP9kkgJDVJUEmlODfFBSCPQf+RQnhUIL/MMmYxBMkz2E2d4dmZ
	 6iT6cYeT2YnjlT6+U723iZYlXsuZq+/JvalSaCMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgDKMTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbgDKMT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:19:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1AB220644;
        Sat, 11 Apr 2020 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607568;
        bh=9VJsLzw6WQVDD3O/6pkEdJQA2rnG1UciyKn9E9/Lk50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0sArldAla1Btw4N4qWSC14qkF28FE2mm5EJ/btbL8bOzeRo09KnsVmJ+ZlipDrol
         zrR7N8T7IicK0K7shM3Z5NzsuYSUUG0bWZvMR2klecsgKYuvudxQ6vn6HzxlQ2J06j
         AAsNoQSckYwKyO/YPS+lBfKYwpZttxedO5JVeMkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        John Donnelly <john.p.donnelly@oracle.com>
Subject: [PATCH 5.5 31/44] iommu/vt-d: Allow devices with RMRRs to use identity domain
Date:   Sat, 11 Apr 2020 14:09:51 +0200
Message-Id: <20200411115459.984976335@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115456.934174282@linuxfoundation.org>
References: <20200411115456.934174282@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

commit 9235cb13d7d17baba0b3a9277381258361e95c16 upstream.

Since commit ea2447f700cab ("intel-iommu: Prevent devices with
RMRRs from being placed into SI Domain"), the Intel IOMMU driver
doesn't allow any devices with RMRR locked to use the identity
domain. This was added to to fix the issue where the RMRR info
for devices being placed in and out of the identity domain gets
lost. This identity maps all RMRRs when setting up the identity
domain, so that devices with RMRRs could also use it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: John Donnelly <john.p.donnelly@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-iommu.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2767,10 +2767,8 @@ static int __init si_domain_init(int hw)
 	}
 
 	/*
-	 * Normally we use DMA domains for devices which have RMRRs. But we
-	 * loose this requirement for graphic and usb devices. Identity map
-	 * the RMRRs for graphic and USB devices so that they could use the
-	 * si_domain.
+	 * Identity map the RMRRs so that devices with RMRRs could also use
+	 * the si_domain.
 	 */
 	for_each_rmrr_units(rmrr) {
 		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
@@ -2778,9 +2776,6 @@ static int __init si_domain_init(int hw)
 			unsigned long long start = rmrr->base_address;
 			unsigned long long end = rmrr->end_address;
 
-			if (device_is_rmrr_locked(dev))
-				continue;
-
 			if (WARN_ON(end < start ||
 				    end >> agaw_to_width(si_domain->agaw)))
 				continue;
@@ -2919,9 +2914,6 @@ static int device_def_domain_type(struct
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
-		if (device_is_rmrr_locked(dev))
-			return IOMMU_DOMAIN_DMA;
-
 		/*
 		 * Prevent any device marked as untrusted from getting
 		 * placed into the statically identity mapping domain.
@@ -2959,9 +2951,6 @@ static int device_def_domain_type(struct
 				return IOMMU_DOMAIN_DMA;
 		} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_PCI_BRIDGE)
 			return IOMMU_DOMAIN_DMA;
-	} else {
-		if (device_has_rmrr(dev))
-			return IOMMU_DOMAIN_DMA;
 	}
 
 	return (iommu_identity_mapping & IDENTMAP_ALL) ?


