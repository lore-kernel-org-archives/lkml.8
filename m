Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F8DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0959020C56
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653171;
	bh=b44jm7P6vI+Zkeiv9QWrWNQ5os3dfh9gfK08ciXU9CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IBk4Hn7RpqF2WKahRlTAcIV5chXfafnopzd2shoC8KlTUlrOBWgenZ145q2eB/nNt
	 2+9JEsXRlIvs6hiuEJiOAkFRKu5Zaw6rARx00GBWReu8G2nDtPFYdvFsrc9A3rLiNu
	 05gzzpSRSD/6Cw3cf0uD8mPf0+ITqdayOpCS648Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgGBB0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729013AbgGBBZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:25:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48CF820748;
        Thu,  2 Jul 2020 01:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653156;
        bh=b44jm7P6vI+Zkeiv9QWrWNQ5os3dfh9gfK08ciXU9CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KBGq8gq4fvW3te89WnQ0EaVBENOu6njvSWT8isUV85MuQQd+tnsM8aQM7KdrrE/+
         TFMONJjxDCZZMNdqP0kaChJytxeDgKIa8LGKc9OVlmAZKAau+FbSKmiry/TX0y9V7Q
         j0greQhXU5nNe5wJnr37k5GxGUfJI5kwzm4YT1aU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, Ashok Raj <ashok.raj@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 25/40] iommu/vt-d: Don't apply gfx quirks to untrusted devices
Date:   Wed,  1 Jul 2020 21:23:46 -0400
Message-Id: <20200702012402.2701121-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012402.2701121-1-sashal@kernel.org>
References: <20200702012402.2701121-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajat Jain <rajatja@google.com>

[ Upstream commit 67e8a5b18d41af9298db5c17193f671f235cce01 ]

Currently, an external malicious PCI device can masquerade the VID:PID
of faulty gfx devices, and thus apply iommu quirks to effectively
disable the IOMMU restrictions for itself.

Thus we need to ensure that the device we are applying quirks to, is
indeed an internal trusted device.

Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20200622231345.29722-4-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 773ac2b0d6068..4e91036cf5636 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5955,6 +5955,23 @@ static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
 	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
 }
 
+/*
+ * Check that the device does not live on an external facing PCI port that is
+ * marked as untrusted. Such devices should not be able to apply quirks and
+ * thus not be able to bypass the IOMMU restrictions.
+ */
+static bool risky_device(struct pci_dev *pdev)
+{
+	if (pdev->untrusted) {
+		pci_info(pdev,
+			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
+			 pdev->vendor, pdev->device);
+		pci_info(pdev, "Please check with your BIOS/Platform vendor about this\n");
+		return true;
+	}
+	return false;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5983,6 +6000,9 @@ const struct iommu_ops intel_iommu_ops = {
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
 {
+	if (risky_device(dev))
+		return;
+
 	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
 	dmar_map_gfx = 0;
 }
@@ -6024,6 +6044,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
+	if (risky_device(dev))
+		return;
+
 	/*
 	 * Mobile 4 Series Chipset neglects to set RWBF capability,
 	 * but needs it. Same seems to hold for the desktop versions.
@@ -6054,6 +6077,9 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 {
 	unsigned short ggc;
 
+	if (risky_device(dev))
+		return;
+
 	if (pci_read_config_word(dev, GGC, &ggc))
 		return;
 
@@ -6087,6 +6113,12 @@ static void __init check_tylersburg_isoch(void)
 	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
 	if (!pdev)
 		return;
+
+	if (risky_device(pdev)) {
+		pci_dev_put(pdev);
+		return;
+	}
+
 	pci_dev_put(pdev);
 
 	/* System Management Registers. Might be hidden, in which case
@@ -6096,6 +6128,11 @@ static void __init check_tylersburg_isoch(void)
 	if (!pdev)
 		return;
 
+	if (risky_device(pdev)) {
+		pci_dev_put(pdev);
+		return;
+	}
+
 	if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
 		pci_dev_put(pdev);
 		return;
-- 
2.25.1

