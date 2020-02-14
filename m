Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C058C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FA92168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUooLahy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgBNNgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:36:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26760 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728083AbgBNNgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581687412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=GPmWxWPeWyJ4yanqYjqxsJb9kwmyfMzyZLJQdEXDG7w=;
        b=jUooLahymxccqZnQGbXaolLGHi/pEoqo6Rl9WKKlmLG3gyfw2uzBQc5SbHBAhfTqWxdJbF
        FvRTcWA7dTDSkwN4oUGDNFs+DfHbGuq2lsDHY6RGbPeEnFSAz9LZc8YKXyRyo/Om5WtNub
        HEBApgfY29BH4bVSeBxgT5gjFgXFuHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-eg9f1bVuMrOagcdCz0u9Aw-1; Fri, 14 Feb 2020 08:36:50 -0500
X-MC-Unique: eg9f1bVuMrOagcdCz0u9Aw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 875D8107ACCA;
        Fri, 14 Feb 2020 13:36:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com [10.36.117.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A2065DD72;
        Fri, 14 Feb 2020 13:36:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D33741747F; Fri, 14 Feb 2020 14:36:45 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/qxl: don't take vga ports on rev5+
Date:   Fri, 14 Feb 2020 14:36:45 +0100
Message-Id: <20200214133645.30977-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qemu 5.0 introduces a new qxl hardware revision 5.  Unlike revision 4
(and below) the device doesn't switch back into vga compatibility mode
when someone touches the vga ports.  So we don't have to reserve the
vga ports any more to avoid that happening.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 4fda3f9b29f4..afea743989dd 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -93,7 +93,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto disable_pci;
 
-	if (is_vga(pdev)) {
+	if (is_vga(pdev) && pdev->revision < 5) {
 		ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
 		if (ret) {
 			DRM_ERROR("can't get legacy vga ioports\n");
@@ -124,7 +124,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 unload:
 	qxl_device_fini(qdev);
 put_vga:
-	if (is_vga(pdev))
+	if (is_vga(pdev) && pdev->revision < 5)
 		vga_put(pdev, VGA_RSRC_LEGACY_IO);
 disable_pci:
 	pci_disable_device(pdev);
@@ -155,7 +155,7 @@ qxl_pci_remove(struct pci_dev *pdev)
 
 	drm_dev_unregister(dev);
 	drm_atomic_helper_shutdown(dev);
-	if (is_vga(pdev))
+	if (is_vga(pdev) && pdev->revision < 5)
 		vga_put(pdev, VGA_RSRC_LEGACY_IO);
 	drm_dev_put(dev);
 }
-- 
2.18.2

