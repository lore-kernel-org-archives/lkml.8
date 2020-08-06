Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEE9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42DFD221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RG/OxOWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHFXCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:02:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49817 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbgHFXCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596754920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xesw/0R7dO8ukumL0049322cMVGw9mWIzQSjuD9xFrA=;
        b=RG/OxOWb6ftBbHUIdOXUjYp3B3tUL5bd1wvqf26wuFEOg1lkkdm7PqUAEJ3oLep4PCoDzp
        fEJ6bXVug1PCgRS4lwZM54EFBW9nvRjZdvlbEL7X79ESnCqE2eToU9HqVLGd9S1K7+qsqv
        sryhvdPQBB8OcX0gcW6Nyw9QPyk26Js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-8qtPoFiXOM-dqQZRmzKUyg-1; Thu, 06 Aug 2020 19:01:56 -0400
X-MC-Unique: 8qtPoFiXOM-dqQZRmzKUyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02E7A106B243;
        Thu,  6 Aug 2020 23:01:55 +0000 (UTC)
Received: from Whitewolf.redhat.com (unknown [10.10.119.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 874145D994;
        Thu,  6 Aug 2020 23:01:53 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Nirmoy Das <nirmoy.aiemd@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/nouveau/kms/nv50-: Program notifier offset before requesting disp caps
Date:   Thu,  6 Aug 2020 19:01:29 -0400
Message-Id: <20200806230129.324035-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
this by doing that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 4a2cb4181b07 ("drm/nouveau/kms/nv50-: Probe SOR and PIOR caps for DP interlacing support")
Cc: <stable@vger.kernel.org> # v5.8+
---
 drivers/gpu/drm/nouveau/dispnv50/core507d.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/core507d.c b/drivers/gpu/drm/nouveau/dispnv50/core507d.c
index ad1f09a143aa4..c984080ce99f2 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/core507d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/core507d.c
@@ -80,11 +80,19 @@ core507d_caps_init(struct nouveau_drm *drm, struct nv50_disp *disp)
 	struct nvif_push *push = disp->core->chan.push;
 	int ret;
 
-	if ((ret = PUSH_WAIT(push, 2)))
+	if ((ret = PUSH_WAIT(push, 4)))
 		return ret;
 
+	PUSH_MTHD(push, NV507D, SET_NOTIFIER_CONTROL,
+		  NVDEF(NV507D, SET_NOTIFIER_CONTROL, MODE, WRITE) |
+		  NVVAL(NV507D, SET_NOTIFIER_CONTROL, OFFSET, NV50_DISP_CORE_NTFY >> 2) |
+		  NVDEF(NV507D, SET_NOTIFIER_CONTROL, NOTIFY, ENABLE));
 	PUSH_MTHD(push, NV507D, GET_CAPABILITIES, 0x00000000);
-	return PUSH_KICK(push);
+	ret = PUSH_KICK(push);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 int
-- 
2.26.2

