Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB2FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C082067B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWFlQGg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgFBX0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgFBX0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:26:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA10CC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:26:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k15so1072925ybt.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NynG8XTmY06ZJBNFnLG4IHgPIRP64YxzgsMAMDjv2W8=;
        b=LWFlQGg6pL6oyAUYXPL9fpD43ADEegVgD8UlcvNOPsLJJDFXrNrNrmGLKqEKIHpEsR
         RNz9nTGMOc3LBWWiobW+3ns/Ttc4Ky71CnxJwaTq+BuKaGOQh6qttsS3jU30DQ792d4T
         YBFt2VAsxMg9b821uHv6Boc5xHmfdEhbXh4wAVmaHtqQLEg+z0ZED9spNAyyP6sy/iV+
         cVbLTPCsF+Y1NCt+Ka2VOdvfrAdfS2WkTx5h4V1pB/4iSkqpZ4HzUnoXjFJCmDArbCN3
         ikG2DMBXAnlbno20z7uC/RkNndIRmZuqP+QjMCaM3q5a4qyYf19GJmvvi0tTzk2zvi2y
         b7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NynG8XTmY06ZJBNFnLG4IHgPIRP64YxzgsMAMDjv2W8=;
        b=pzbLWJbB7DrlxK324bu/LQunr+mQO2nd+z0RGdeZ7HUF5mG9yS520nVEz7TLHjVMJk
         wVKpsgwxgtSAjH2yYJEHNxORRzWchSx0snDLovUi6EGozJzXLPn8Gk1LRxa4vlJZVZ7A
         NQtpljST7CdQRp6a0US20lqHvBqvlmLnsJSrUAJU+jJKz9e0d/LYSWAINilVvyTgV0EH
         5DO7fMe1ft0dLFr+Ila8A+pKRR5OfbJj+1pheXFSSSxMLuc0EGAAmCnb97ytQd2W97z1
         zGM94VuLG7i53nUZU8W7DAU3Zyp2GSH6eBs94eM1wSTyME6PmMoEVIKJp25/uo+Pg8Ib
         9mhg==
X-Gm-Message-State: AOAM530gdPtV/d1sH23UnTr0Mg0MtNQbTaDRwe5SYqtEy3iwH6RvpZXR
        DDWnUmM/GrWZU6lHLC+TxTwISzP3Rtib
X-Google-Smtp-Source: ABdhPJy7StIRmqY8PtQKaVBItShwpG3VOObe8CYIJhXNAvjpzjPuiuVIy8eYCXkZ+LuoN7XKfnI74pyyRrTh
X-Received: by 2002:a25:258f:: with SMTP id l137mr37546571ybl.221.1591140366131;
 Tue, 02 Jun 2020 16:26:06 -0700 (PDT)
Date:   Tue,  2 Jun 2020 16:26:02 -0700
Message-Id: <20200602232602.156049-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted devices
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        pmalani@google.com, bleung@google.com, levinale@google.com,
        zsm@google.com, mnissler@google.com, tbroch@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, an external malicious PCI device can masquerade the VID:PID
of faulty gfx devices, and thus apply iommu quirks to effectively
disable the IOMMU restrictions for itself.

Thus we need to ensure that the device we are applying quirks to, is
indeed an internal trusted device.

Signed-off-by: Rajat Jain <rajatja@google.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
---
v3: - Separate out the warning mesage in a function to be called from
      other places. Change the warning string as suggested.
v2: - Change the warning print strings.
    - Add Lu Baolu's acknowledgement.

 drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e5..dc859f02985a0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -6185,6 +6185,23 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 
+/*
+ * Check that the device does not live on an external facing PCI port that is
+ * marked as untrusted. Such devices should not be able to apply quirks and
+ * thus not be able to bypass the IOMMU restrictions.
+ */
+static bool risky_device(struct pci_dev *pdev)
+{
+	if (pdev->untrusted) {
+		pci_warn(pdev,
+			 "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
+			 " PCI link. Please check with your BIOS/Platform"
+			 " vendor about this\n", pdev->vendor, pdev->device);
+		return true;
+	}
+	return false;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -6214,6 +6231,9 @@ const struct iommu_ops intel_iommu_ops = {
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
 {
+	if (risky_device(dev))
+		return;
+
 	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
 	dmar_map_gfx = 0;
 }
@@ -6255,6 +6275,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
+	if (risky_device(dev))
+		return;
+
 	/*
 	 * Mobile 4 Series Chipset neglects to set RWBF capability,
 	 * but needs it. Same seems to hold for the desktop versions.
@@ -6285,6 +6308,9 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 {
 	unsigned short ggc;
 
+	if (risky_device(dev))
+		return;
+
 	if (pci_read_config_word(dev, GGC, &ggc))
 		return;
 
@@ -6318,6 +6344,12 @@ static void __init check_tylersburg_isoch(void)
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
@@ -6327,6 +6359,11 @@ static void __init check_tylersburg_isoch(void)
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
2.27.0.rc2.251.g90737beb825-goog

