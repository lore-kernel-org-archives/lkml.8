Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE10FC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E8520772
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIWjfJoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgCRAnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:43:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51502 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbgCRAnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584492193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+U3K2ZnU8H4wZYTpzN2SyKFp37L2cRm6uvx4dgrw6Y=;
        b=CIWjfJoOrStIp+TV/odBsAWQfHry2lZ1YnnbxVueEtgNXUUpbIwAekmrbIiNhzS0lCioKg
        3nT4h2JC99w5pqBS5UaCRV51peH6+RCqZhMs1yz4fAMZIulKuU+hNlXWNXNq7/nyru/dMz
        pPoQEfKk1BfjtzAWGqwZI9rCZ9j/4c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-W4M7n5xTPFqDVU2hEJjPmw-1; Tue, 17 Mar 2020 20:43:06 -0400
X-MC-Unique: W4M7n5xTPFqDVU2hEJjPmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C23913E2;
        Wed, 18 Mar 2020 00:43:04 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-113-173.rdu2.redhat.com [10.10.113.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C176560BE0;
        Wed, 18 Mar 2020 00:42:56 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] drm/nouveau/kms/nv50-: Move hard-coded object handles into header
Date:   Tue, 17 Mar 2020 20:41:05 -0400
Message-Id: <20200318004159.235623-9-lyude@redhat.com>
In-Reply-To: <20200318004159.235623-1-lyude@redhat.com>
References: <20200318004159.235623-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While most of the functionality on Nvidia GPUs doesn't require using an
explicit handle instead of the main VRAM handle + offset, there are a
couple of places that do require explicit handles, such as CRC
functionality. Since this means we're about to add another
nouveau-chosen handle, let's just go ahead and move any hard-coded
handles into a single header. This is just to keep things slightly
organized, and to make it a little bit easier if we need to add more
handles in the future.

This patch should contain no functional changes.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c    |  7 +++++--
 drivers/gpu/drm/nouveau/dispnv50/handles.h | 15 +++++++++++++++
 drivers/gpu/drm/nouveau/dispnv50/wndw.c    |  3 ++-
 3 files changed, 22 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/handles.h

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
index ef01f2473947..bfea85782d0e 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -26,6 +26,7 @@
 #include "core.h"
 #include "head.h"
 #include "wndw.h"
+#include "handles.h"
=20
 #include <linux/dma-mapping.h>
 #include <linux/hdmi.h>
@@ -153,7 +154,8 @@ nv50_dmac_create(struct nvif_device *device, struct n=
vif_object *disp,
 	if (!syncbuf)
 		return 0;
=20
-	ret =3D nvif_object_init(&dmac->base.user, 0xf0000000, NV_DMA_IN_MEMORY=
,
+	ret =3D nvif_object_init(&dmac->base.user, NV50_DISP_HANDLE_SYNCBUF,
+			       NV_DMA_IN_MEMORY,
 			       &(struct nv_dma_v0) {
 					.target =3D NV_DMA_V0_TARGET_VRAM,
 					.access =3D NV_DMA_V0_ACCESS_RDWR,
@@ -164,7 +166,8 @@ nv50_dmac_create(struct nvif_device *device, struct n=
vif_object *disp,
 	if (ret)
 		return ret;
=20
-	ret =3D nvif_object_init(&dmac->base.user, 0xf0000001, NV_DMA_IN_MEMORY=
,
+	ret =3D nvif_object_init(&dmac->base.user, NV50_DISP_HANDLE_VRAM,
+			       NV_DMA_IN_MEMORY,
 			       &(struct nv_dma_v0) {
 					.target =3D NV_DMA_V0_TARGET_VRAM,
 					.access =3D NV_DMA_V0_ACCESS_RDWR,
diff --git a/drivers/gpu/drm/nouveau/dispnv50/handles.h b/drivers/gpu/drm=
/nouveau/dispnv50/handles.h
new file mode 100644
index 000000000000..e3a62c7a0d08
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/dispnv50/handles.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: MIT */
+#ifndef __NV50_KMS_HANDLES_H__
+#define __NV50_KMS_HANDLES_H__
+
+/*
+ * Various hard-coded object handles that nouveau uses. These are made-u=
p by
+ * nouveau developers, not Nvidia. The only significance of the handles =
chosen
+ * is that they must all be unique.
+ */
+#define NV50_DISP_HANDLE_SYNCBUF                                        =
0xf0000000
+#define NV50_DISP_HANDLE_VRAM                                           =
0xf0000001
+
+#define NV50_DISP_HANDLE_WNDW_CTX(kind)                        (0xfb0000=
00 | kind)
+
+#endif /* !__NV50_KMS_HANDLES_H__ */
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/no=
uveau/dispnv50/wndw.c
index 39cca8eaa066..cb67a715bd69 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -21,6 +21,7 @@
  */
 #include "wndw.h"
 #include "wimm.h"
+#include "handles.h"
=20
 #include <nvif/class.h>
 #include <nvif/cl0002.h>
@@ -44,7 +45,7 @@ nv50_wndw_ctxdma_new(struct nv50_wndw *wndw, struct nou=
veau_framebuffer *fb)
 	struct nouveau_drm *drm =3D nouveau_drm(fb->base.dev);
 	struct nv50_wndw_ctxdma *ctxdma;
 	const u8    kind =3D fb->nvbo->kind;
-	const u32 handle =3D 0xfb000000 | kind;
+	const u32 handle =3D NV50_DISP_HANDLE_WNDW_CTX(kind);
 	struct {
 		struct nv_dma_v0 base;
 		union {
--=20
2.24.1

