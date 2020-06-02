Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799A6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A352072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOcja528"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgFBSlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBSlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:41:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B20C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:41:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k186so18232285ybc.19
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8tpv364uuoi5MEZfjTVmpI+b4taGRM4u8bQyj2pnBh4=;
        b=SOcja528ER/iTI2CrS98AHZhtT0sh74Df7GwIHRhAXIZCMLzeHsm+NOtlMuRMDQZ6x
         6hZOXLkrhV70Ou5JOEP+OHc6ERc0icCN6IKVYkf3ju6LMJls+zT1a/p24k8T0BLO109F
         k9kQU8UBno4rcsBxDFoMbosDTDLkmr+EJzJ3bta+cIFHwLy7avzrxODzrwf6AThuk0K7
         LNqiVoEm3tWJ3IoBuWitZFxHXHwY3bwx4JQlI80R2TieckjWrVF15cA+XaBP+DPnge+M
         0exYfssplAHJL0+eBQE0unWoxqw9ZMEtxQTS3qUZ9tLl1Xz/44i2Ef7PdMx+H9KbAzro
         2J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8tpv364uuoi5MEZfjTVmpI+b4taGRM4u8bQyj2pnBh4=;
        b=sGIcpPhOUlxW9gver2rNuXvBIpaiIq6V1OQdj14Zkg8wnQWYQvaFqG2dSTTL/l+XGB
         8balo6qkUUuTl5ri4A1BNaKduJP6SrFBXaWBfmOy8e8Ccqd1SATOozI0ykv3Wwdnexaz
         QpEPuPtoEpRzFWCpeEQePLYWJMqcoR3gyMA8S8bkhQGT4PVg3fF3txOxgLNZGqPbHv2C
         C/zNdhm1Ef4gwERUYmNvO0i74+0Vy2uEkVSYqs89K8wjRlcP0LD2NnXMO5iGBYkOB+fX
         eJjhTYKloAP3HLmV5i8++xEUKVzj1rOYdNbJNmnHotv/MoOREtHIHU0Ity2NtDSkyaRO
         2BsA==
X-Gm-Message-State: AOAM532p4WPihciQixWBulB/YiCmwrQdgb2fkAoBt9bIo8q3lcmAVv6b
        JzlMdOS07R5omrKCHxmNjbEPfjwZ3Ulw
X-Google-Smtp-Source: ABdhPJyhb8sVgjMH1V+zDqj3cCk0pEWzt3uIaVGtWHCpt+IVA/OQmIcUX6iRC8BXRiQLzMJHvueq2dHh2VLz
X-Received: by 2002:a5b:785:: with SMTP id b5mr21343779ybq.96.1591123297999;
 Tue, 02 Jun 2020 11:41:37 -0700 (PDT)
Date:   Tue,  2 Jun 2020 11:41:33 -0700
Message-Id: <20200602184133.75525-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH v2] iommu/vt-d: Don't apply gfx quirks to untrusted devices
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
V2: - Change the warning print strings.
    - Add Lu Baolu's acknowledgement.

 drivers/iommu/intel-iommu.c | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e5..fdfbea4ff8cb3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -6214,6 +6214,13 @@ const struct iommu_ops intel_iommu_ops = {
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
 {
+	if (dev->untrusted) {
+		pci_warn(dev,
+			 "Skipping IOMMU quirk %s() for potentially untrusted device\n",
+			 __func__);
+		return;
+	}
+
 	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
 	dmar_map_gfx = 0;
 }
@@ -6255,6 +6262,13 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
+	if (dev->untrusted) {
+		pci_warn(dev,
+			 "Skipping IOMMU quirk %s() for potentially untrusted device\n",
+			 __func__);
+		return;
+	}
+
 	/*
 	 * Mobile 4 Series Chipset neglects to set RWBF capability,
 	 * but needs it. Same seems to hold for the desktop versions.
@@ -6285,6 +6299,13 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 {
 	unsigned short ggc;
 
+	if (dev->untrusted) {
+		pci_warn(dev,
+			 "Skipping IOMMU quirk %s() for potentially untrusted device\n",
+			 __func__);
+		return;
+	}
+
 	if (pci_read_config_word(dev, GGC, &ggc))
 		return;
 
@@ -6318,6 +6339,15 @@ static void __init check_tylersburg_isoch(void)
 	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
 	if (!pdev)
 		return;
+
+	if (pdev->untrusted) {
+		pci_warn(pdev,
+			 "Skipping IOMMU quirk %s() for potentially untrusted device\n",
+			 __func__);
+		pci_dev_put(pdev);
+		return;
+	}
+
 	pci_dev_put(pdev);
 
 	/* System Management Registers. Might be hidden, in which case
@@ -6327,6 +6357,14 @@ static void __init check_tylersburg_isoch(void)
 	if (!pdev)
 		return;
 
+	if (pdev->untrusted) {
+		pci_warn(pdev,
+			 "Skipping IOMMU quirk %s() for potentially untrusted device\n",
+			 __func__);
+		pci_dev_put(pdev);
+		return;
+	}
+
 	if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
 		pci_dev_put(pdev);
 		return;
-- 
2.27.0.rc2.251.g90737beb825-goog

