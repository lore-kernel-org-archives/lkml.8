Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1467C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87922070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDRAUsLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgEKWmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 18:42:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34194 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbgEKWmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589236941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vnS9moR/03Fuc5IhvDycJBr5v1hCjCl8WSLZ1VfpQs=;
        b=LDRAUsLqiFTcwGfzKCP9WWEmXzSi/gc5mQu7trOSTliSCNNTA6tvrVCG9i+tGKR5VrcvXB
        GWPZD8gnX+DQR2f6v7Z4umTixZpvozS7F+xoTWuJNCbC/GbnwIhvd/ZZgUOnsTK8BHjBL7
        WBNmo/c2WPJwciyRpb75IC4KHRRRXs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-Pc5E5hYRObuUWr_7rUNMlQ-1; Mon, 11 May 2020 18:42:20 -0400
X-MC-Unique: Pc5E5hYRObuUWr_7rUNMlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62B99475;
        Mon, 11 May 2020 22:42:18 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-117-238.rdu2.redhat.com [10.10.117.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 368BE77F2E;
        Mon, 11 May 2020 22:42:17 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] drm/nouveau/kms/nv50-: Initialize core channel in nouveau_display_create()
Date:   Mon, 11 May 2020 18:41:23 -0400
Message-Id: <20200511224148.598468-2-lyude@redhat.com>
In-Reply-To: <20200511224148.598468-1-lyude@redhat.com>
References: <20200511224148.598468-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need the core channel initialized and ready by the time that we
start creating modesetting objects, so that we can call the
NV507D_GET_CAPABILITIES method to make the hardware expose it's
modesetting capabilities for later probing.

So, when loading the driver prepare the core channel from within
nouveau_display_create(). Everywhere else, we initialize the core
channel during resume.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 6be9df1820c5..05b458b16e3f 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2369,7 +2369,8 @@ nv50_display_init(struct drm_device *dev, bool resume, bool runtime)
 	struct drm_encoder *encoder;
 	struct drm_plane *plane;
 
-	core->func->init(core);
+	if (resume || runtime)
+		core->func->init(core);
 
 	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
 		if (encoder->encoder_type != DRM_MODE_ENCODER_DPMST) {
@@ -2456,6 +2457,8 @@ nv50_display_create(struct drm_device *dev)
 	if (ret)
 		goto out;
 
+	disp->core->func->init(disp->core);
+
 	/* create crtc objects to represent the hw heads */
 	if (disp->disp->object.oclass >= GV100_DISP)
 		crtcs = nvif_rd32(&device->object, 0x610060) & 0xff;
-- 
2.26.2

