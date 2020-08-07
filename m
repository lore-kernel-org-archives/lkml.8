Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624E1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A10520866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6SQMNwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgHGVeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726804AbgHGVeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596836062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o2fOsP31iqD+NVP7vZuFT60+fYRTZ6+2U2X/HkQb/bM=;
        b=R6SQMNwb0KTx1FxmoNoj/YqPYeXdIxCMT4gUQIAIUUHHR2WXjfrGNfcvYy/E8RE0JN3zqJ
        NR3elETEPi0b8qIE9C0eBvnI/uoDT7wznqDdYBOmvUttuP7Ff8Ui0BJoNqwkbR+XVamQzR
        07enIGMLnMwAxx22DFmNijpHziyjzSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-ayioxAteOTi6apMmkRxoNA-1; Fri, 07 Aug 2020 17:34:18 -0400
X-MC-Unique: ayioxAteOTi6apMmkRxoNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAC151923763;
        Fri,  7 Aug 2020 21:34:14 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-119-194.rdu2.redhat.com [10.10.119.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB5B5108BC;
        Fri,  7 Aug 2020 21:34:10 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Nirmoy Das <nirmoy.aiemd@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/nouveau/kms/nv50-: Program notifier offset before requesting disp caps
Date:   Fri,  7 Aug 2020 17:34:03 -0400
Message-Id: <20200807213405.442877-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not entirely sure why this never came up when I originally tested this
(maybe some BIOSes already have this setup?) but the ->caps_init vfunc
appears to cause the display engine to throw an exception on driver
init, at least on my ThinkPad P72:

nouveau 0000:01:00.0: disp: chid 0 mthd 008c data 00000000 0000508c 0000102b

This is magic nvidia speak for "You need to have the DMA notifier offset
programmed before you can call NV507D_GET_CAPABILITIES." So, let's fix
this by doing that, and also perform an update afterwards to prevent
racing with the GPU when reading capabilities.

Changes since v1:
* Don't just program the DMA notifier offset, make sure to actually
  perform an update

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 4a2cb4181b07 ("drm/nouveau/kms/nv50-: Probe SOR and PIOR caps for DP interlacing support")
Cc: <stable@vger.kernel.org> # v5.8+
---
 drivers/gpu/drm/nouveau/dispnv50/core507d.c | 22 +++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/core507d.c b/drivers/gpu/drm/nouveau/dispnv50/core507d.c
index ad1f09a143aa4..fc4bf9ca59f85 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/core507d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/core507d.c
@@ -77,14 +77,32 @@ core507d_ntfy_init(struct nouveau_bo *bo, u32 offset)
 int
 core507d_caps_init(struct nouveau_drm *drm, struct nv50_disp *disp)
 {
+	struct nv50_core *core = disp->core;
 	struct nvif_push *push = disp->core->chan.push;
+	u32 interlock[NV50_DISP_INTERLOCK__SIZE] = {0};
 	int ret;
 
-	if ((ret = PUSH_WAIT(push, 2)))
+	core->func->ntfy_init(disp->sync, NV50_DISP_CORE_NTFY);
+
+	if ((ret = PUSH_WAIT(push, 4)))
 		return ret;
 
+	PUSH_MTHD(push, NV507D, SET_NOTIFIER_CONTROL,
+		  NVDEF(NV507D, SET_NOTIFIER_CONTROL, MODE, WRITE) |
+		  NVVAL(NV507D, SET_NOTIFIER_CONTROL, OFFSET, NV50_DISP_CORE_NTFY >> 2) |
+		  NVDEF(NV507D, SET_NOTIFIER_CONTROL, NOTIFY, ENABLE));
 	PUSH_MTHD(push, NV507D, GET_CAPABILITIES, 0x00000000);
-	return PUSH_KICK(push);
+
+	ret = PUSH_KICK(push);
+	if (ret)
+		return ret;
+
+	core->func->update(core, interlock, false);
+	if (core->func->ntfy_wait_done(disp->sync, NV50_DISP_CORE_NTFY,
+				       core->chan.base.device))
+		NV_ERROR(drm, "core notifier timeout\n");
+
+	return 0;
 }
 
 int
-- 
2.26.2

