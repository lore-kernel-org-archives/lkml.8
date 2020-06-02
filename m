Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77B42063A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g9X7wqQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBFpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgFBFpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:45:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB42C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 22:45:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f187so15886232ybc.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 22:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qiAGy0O4D5sZPZBUDOyzmafsREfPwQ+6o5+tiGkldzk=;
        b=g9X7wqQHkwSsE67PytiDLtUkVlKt2EmXQ0Z2WRZ0Xh3f9+7wmd6h5PI65oCiURIzef
         MvAXbSoNA7xpUP+3svirF5JhGDvXQZ1hGiTiID+6+4TXZMqd9HGHl42YU8KYdn1jlXX1
         FMt8vXzUeNYIsYo7VzJ9wNA04qeDpKks+ZwPzp1zSUn24ptdkw6dUktr1kvqHK1hj/Dh
         RbuIe+jX/KArQ5VsuwdkY5TYXdHBF42uQJwZ9RNePDGIoHfqlRknnDTaAHMFGPsBlaKN
         2MW4rywYhNxn+jhu9c2wfi6Jt/pIxSZxA7DPdJ0zojBygsgLVkYPzDrLC7UFgRFc/Tqb
         QJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qiAGy0O4D5sZPZBUDOyzmafsREfPwQ+6o5+tiGkldzk=;
        b=LTwuxLBJxmEpYp1gIycEeAk47JVRKQYlMCdAtZsiWPyTl8EyYL0gVJgB1bkEBwC4IL
         2SfyNsg/Y1stxhfA5TMIbG1JPk+jyWWczlvPRucDssrVe9hCFRcrESeR1Y+cAXMibVJS
         NN3xsQSIi07z4zPWE08Cu+TQzQFhkzWGHP7nArWkaS6fyOImBnbQ429v+PtC1U9gHHUg
         k7tV/bKYdzBRmqUxLVQF8Sfl6jZW+DdtuFFhBeVm9IhNYZqzMldGGH+PEjRgEgYF1n5l
         3B6lLk9wSwwS8CUWOUX0tPmVvsH2fw6jsj82eacgN8xK+PoyQra5wZv3Tn0EKTqvZ4cn
         Hb6A==
X-Gm-Message-State: AOAM532fObq19onginz7M2SHHA8FV34ik5LCBNDL782YccXB8g/zJMiR
        l0mPBIR+tJD0VWvv/8q8nLGchbGSsRBf
X-Google-Smtp-Source: ABdhPJxQRom+GrIfagQbwRffGMeJJ+pGvfAJjE78cF4/2hejCZlko1O5W4bBRi7rlSUMctQMMaNTzCgul32z
X-Received: by 2002:a25:fc5:: with SMTP id 188mr39503234ybp.429.1591076722056;
 Mon, 01 Jun 2020 22:45:22 -0700 (PDT)
Date:   Mon,  1 Jun 2020 22:45:17 -0700
Message-Id: <20200602054517.191244-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] iommu/vt-d: Don't apply gfx quirks to untrusted devices
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
---
 drivers/iommu/intel-iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e5..f2a480168a02f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -6214,6 +6214,11 @@ const struct iommu_ops intel_iommu_ops = {
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
 {
+	if (dev->untrusted) {
+		pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
+		return;
+	}
+
 	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
 	dmar_map_gfx = 0;
 }
@@ -6255,6 +6260,11 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
+	if (dev->untrusted) {
+		pci_warn(dev, "skipping iommu quirk for untrusted dev\n");
+		return;
+	}
+
 	/*
 	 * Mobile 4 Series Chipset neglects to set RWBF capability,
 	 * but needs it. Same seems to hold for the desktop versions.
@@ -6285,6 +6295,11 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 {
 	unsigned short ggc;
 
+	if (dev->untrusted) {
+		pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
+		return;
+	}
+
 	if (pci_read_config_word(dev, GGC, &ggc))
 		return;
 
@@ -6318,6 +6333,13 @@ static void __init check_tylersburg_isoch(void)
 	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
 	if (!pdev)
 		return;
+
+	if (pdev->untrusted) {
+		pci_warn(pdev, "skipping iommu quirk due to untrusted dev\n");
+		pci_dev_put(pdev);
+		return;
+	}
+
 	pci_dev_put(pdev);
 
 	/* System Management Registers. Might be hidden, in which case
@@ -6327,6 +6349,12 @@ static void __init check_tylersburg_isoch(void)
 	if (!pdev)
 		return;
 
+	if (pdev->untrusted) {
+		pci_warn(pdev, "skipping iommu quirk due to untrusted dev\n");
+		pci_dev_put(pdev);
+		return;
+	}
+
 	if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
 		pci_dev_put(pdev);
 		return;
-- 
2.27.0.rc2.251.g90737beb825-goog

