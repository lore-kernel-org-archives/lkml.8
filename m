Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE44EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A90922C9F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrgHoVFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHGLEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:04:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38606 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726233AbgHGKzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596797712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=dwLIkWycUo2T9/Q0kymfmBAUfQhGmHg/IIypAw8eWxY=;
        b=JrgHoVFbgE4FDEs/md22VknySFBnRXWHAi8rpXfaqnFEKv0cGC+zLrKI/hX3aUOBpyYCsp
        Cxs0TyE6g7eUF8bbhOvCYRAD6pv6LYJzw7Zeo1fWckvDgYwIxewdDGGY2LSPqYgLCyHB4q
        y2SwYA2h+w4dYDAhFFynsuyaqg0RE54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-n8usaWB9OYGy695j6f2rgw-1; Fri, 07 Aug 2020 06:55:09 -0400
X-MC-Unique: n8usaWB9OYGy695j6f2rgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50D5080BCAB;
        Fri,  7 Aug 2020 10:55:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 621086179D;
        Fri,  7 Aug 2020 10:55:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9513F9CBC; Fri,  7 Aug 2020 12:55:01 +0200 (CEST)
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
Subject: [PATCH v2] drm/qxl: don't take vga ports on rev5+
Date:   Fri,  7 Aug 2020 12:55:01 +0200
Message-Id: <20200807105501.24599-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
index 13872b882775..6e7f16f4cec7 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -96,7 +96,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto disable_pci;
 
-	if (is_vga(pdev)) {
+	if (is_vga(pdev) && pdev->revision < 5) {
 		ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
 		if (ret) {
 			DRM_ERROR("can't get legacy vga ioports\n");
@@ -127,7 +127,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 }
 
-- 
2.18.4

