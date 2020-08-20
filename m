Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76735C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4725A206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkNHG4tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgHTSal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:30:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40830 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727078AbgHTSad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597948232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wo54Fztl+nW8iXS4XGGsRse4eb/aZW2O/0PU/MC/eQ=;
        b=KkNHG4tkMV9x0ibIaOXE4CB5QJxbMzm/yAe18kYizSQf60VIjEEwMroMJ57VO9pgvZ8dxh
        Teus0vBuX5/RrhiiIQxpNGg1M3xEKvmeWU22lE2FRgGBY0sH/6Lv5dZ+dWSEUHElJR5fac
        FpQF5UVup0mSEDTmG0BttxNePoA4CQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-JYB9XUS1OZ6hqCyjGe2Vfw-1; Thu, 20 Aug 2020 14:30:31 -0400
X-MC-Unique: JYB9XUS1OZ6hqCyjGe2Vfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6CE28030AD;
        Thu, 20 Aug 2020 18:30:29 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-42.rdu2.redhat.com [10.10.120.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 270B75DA74;
        Thu, 20 Aug 2020 18:30:29 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 03/20] drm/nouveau/kms/nv50-: Just use drm_dp_dpcd_read() in nouveau_dp.c
Date:   Thu, 20 Aug 2020 14:29:55 -0400
Message-Id: <20200820183012.288794-4-lyude@redhat.com>
In-Reply-To: <20200820183012.288794-1-lyude@redhat.com>
References: <20200820183012.288794-1-lyude@redhat.com>
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

