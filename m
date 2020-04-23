Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47F4C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C7E21556
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgDWGYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:24:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54211 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWGYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 02:24:07 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jRVHG-0000u2-Ic; Thu, 23 Apr 2020 06:24:03 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bskeggs@redhat.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] drm/nouveau: Use generic helper to check _PR3 presence
Date:   Thu, 23 Apr 2020 14:23:58 +0800
Message-Id: <20200423062358.1810-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace nouveau_pr3_present() in favor of a more generic one,
pci_pr3_present().

Also the presence of upstream bridge _PR3 doesn't need to go hand in
hand with device's _DSM, so check _PR3 before _DSM.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/nouveau/nouveau_acpi.c | 44 ++++++--------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index fe3a10255c36..b84dff1b0f28 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -212,37 +212,6 @@ static const struct vga_switcheroo_handler nouveau_dsm_handler = {
 	.get_client_id = nouveau_dsm_get_client_id,
 };
 
-/*
- * Firmware supporting Windows 8 or later do not use _DSM to put the device into
- * D3cold, they instead rely on disabling power resources on the parent.
- */
-static bool nouveau_pr3_present(struct pci_dev *pdev)
-{
-	struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
-	struct acpi_device *parent_adev;
-
-	if (!parent_pdev)
-		return false;
-
-	if (!parent_pdev->bridge_d3) {
-		/*
-		 * Parent PCI bridge is currently not power managed.
-		 * Since userspace can change these afterwards to be on
-		 * the safe side we stick with _DSM and prevent usage of
-		 * _PR3 from the bridge.
-		 */
-		pci_d3cold_disable(pdev);
-		return false;
-	}
-
-	parent_adev = ACPI_COMPANION(&parent_pdev->dev);
-	if (!parent_adev)
-		return false;
-
-	return parent_adev->power.flags.power_resources &&
-		acpi_has_method(parent_adev->handle, "_PR3");
-}
-
 static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out,
 				  bool *has_mux, bool *has_opt,
 				  bool *has_opt_flags, bool *has_pr3)
@@ -250,6 +219,16 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
 	acpi_handle dhandle;
 	bool supports_mux;
 	int optimus_funcs;
+	struct pci_dev *parent_pdev;
+
+	*has_pr3 = false;
+	parent_pdev = pci_upstream_bridge(pdev);
+	if (parent_pdev) {
+		if (parent_pdev->bridge_d3)
+			*has_pr3 = pci_pr3_present(parent_pdev);
+		else
+			pci_d3cold_disable(pdev);
+	}
 
 	dhandle = ACPI_HANDLE(&pdev->dev);
 	if (!dhandle)
@@ -270,7 +249,6 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
 	*has_mux = supports_mux;
 	*has_opt = !!optimus_funcs;
 	*has_opt_flags = optimus_funcs & (1 << NOUVEAU_DSM_OPTIMUS_FLAGS);
-	*has_pr3 = false;
 
 	if (optimus_funcs) {
 		uint32_t result;
@@ -280,8 +258,6 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
 			 (result & OPTIMUS_ENABLED) ? "enabled" : "disabled",
 			 (result & OPTIMUS_DYNAMIC_PWR_CAP) ? "dynamic power, " : "",
 			 (result & OPTIMUS_HDA_CODEC_MASK) ? "hda bios codec supported" : "");
-
-		*has_pr3 = nouveau_pr3_present(pdev);
 	}
 }
 
-- 
2.17.1

