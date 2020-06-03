Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC9DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB07206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyHgdnES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgFCNDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCNDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:03:23 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D487C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 06:03:22 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id m29so1528563qkm.17
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=db/kQaLQg+0T8fOHQ2nb3EujmTQZxSTonth9y+N64Uw=;
        b=hyHgdnESty+it4dM91ZX8qfTsvjopVZuLx7NZhlI7ymz/gMbMzfiSUOuSk3et7Fc3r
         NYzkXQpApAIQ1KtveTHMUkeKsGl38ohGlyaccallRwA2bVzLUyG1D7jJKbXQRh6QhSPT
         ZOZ7kWh0lu1nCNO95TPKVAst4EcTrn7qYt7HVUYmkDRel57RDygHEncjvFtJxpOpPumP
         JxBaRZb/MyjsAYom7lKZeRdDenDUO7d3xtH5yJq5siM/Lv2HHCYXWJPohh49YGUoNWdr
         imMezI6+UFIRUDX8opuJ/H3qsniO6imliwxPP1svQIExziR6B1TVg+alavwOiuic9UHW
         8FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=db/kQaLQg+0T8fOHQ2nb3EujmTQZxSTonth9y+N64Uw=;
        b=Xmt4NS/dnLjeYF23FYCfgdPAuOUY5z8HrOi0MOQyxjsbrYTcr0ewSrH9zXa1pyYx+f
         CqEwYzhjNDMIGEZde1amKlxvbKpnSNFIRf/1FEGWeOwsh+9xeYYmGeqUGvAtltPCqrYc
         0qJ7hVWbWdjLp7tVpXuLH3m3e0g/G0ivzGeEs6s6Onl4EG2zLfROv1J85ueDPmm/bGxS
         3/KYvdPUiTUkyHaK38HHlUc2tTexwdMbk+PW00kMtNet26mdQjk/DZZqOc/5u60xrMjs
         R2TaO/asQzrZwBG60+FmtYXNL8mu3fZJOdorLxlKzyjMbV7HRJtdpAppgwliWSgw5Ttd
         Q1Uw==
X-Gm-Message-State: AOAM530jPelOpnkZXSlUItL9LfaV4DYfKDzLd7Ki5eBLzVevoWUs4DJy
        z4/TUw9lSC82mwvZnuJlc8MWP7Mmv12g
X-Google-Smtp-Source: ABdhPJzCA2PDywVGKDjNV3Cc55Uhss57Yqby9p8/gWrwS/ZB5sXzZjsmUyQMBnxfrIOcPgZGdZ10I20m2iTW
X-Received: by 2002:ad4:4572:: with SMTP id o18mr30227802qvu.204.1591189400865;
 Wed, 03 Jun 2020 06:03:20 -0700 (PDT)
Date:   Wed,  3 Jun 2020 06:03:17 -0700
Message-Id: <20200603130317.94672-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH v4] iommu/vt-d: Don't apply gfx quirks to untrusted devices
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
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
v4: - Add Ashok Raj's "Reviewed-by"
    - Use pci_info() and split debug print cleanly into 2 statements. 
v3: - Separate out the warning mesage in a function to be called from
      other places. Change the warning string as suggested.
v2: - Change the warning print strings.
    - Add Lu Baolu's acknowledgement.

 drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e5..efd1e5de947b9 100644
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

