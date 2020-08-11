Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125AAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2AA20786
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJSLCxkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHKUFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbgHKUFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597176346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wo54Fztl+nW8iXS4XGGsRse4eb/aZW2O/0PU/MC/eQ=;
        b=VJSLCxkbmhbGSSdPfj3fIHxyq3J17GpJO0WAyQdAhUyJlkKxiod0WTcj1KQqFWOAUdIMQ6
        VyVlttr6OP3aSAu/eA+A3zhyunx2L+sVpaDpMMvXPTRKZ3bBaqLyrlbg/DxzfkbToIXydx
        W3YwcAz/LiZMYrrcty3ileozw3tQGy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-1k1xoX02P1K--Fza3wyMEQ-1; Tue, 11 Aug 2020 16:05:43 -0400
X-MC-Unique: 1k1xoX02P1K--Fza3wyMEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 887831DE5;
        Tue, 11 Aug 2020 20:05:42 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-119-184.rdu2.redhat.com [10.10.119.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 931645D9DD;
        Tue, 11 Aug 2020 20:05:41 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC 03/20] drm/nouveau/kms/nv50-: Just use drm_dp_dpcd_read() in nouveau_dp.c
Date:   Tue, 11 Aug 2020 16:04:40 -0400
Message-Id: <20200811200457.134743-4-lyude@redhat.com>
In-Reply-To: <20200811200457.134743-1-lyude@redhat.com>
References: <20200811200457.134743-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this actually logs accesses, we should probably always be using
this imho…

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index c4e9c21d4dd2b..8db9216d52c69 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -42,16 +42,12 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
 {
 	struct drm_device *dev = nv_encoder->base.base.dev;
 	struct nouveau_drm *drm = nouveau_drm(dev);
-	struct nvkm_i2c_aux *aux;
-	u8 dpcd[8];
+	struct drm_dp_aux *aux = &nv_connector->aux;
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	int ret;
 
-	aux = nv_encoder->aux;
-	if (!aux)
-		return -ENODEV;
-
-	ret = nvkm_rdaux(aux, DP_DPCD_REV, dpcd, sizeof(dpcd));
-	if (ret)
+	ret = drm_dp_dpcd_read(aux, DP_DPCD_REV, dpcd, DP_RECEIVER_CAP_SIZE);
+	if (ret != sizeof(dpcd))
 		return ret;
 
 	nv_encoder->dp.link_bw = 27000 * dpcd[1];
-- 
2.26.2

