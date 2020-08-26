Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77E1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6FD2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFMKhCNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgHZS0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgHZSZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598466349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Ly95VK7jkIZiZEcROtGVBS75XVPK0F3LgwAuMw9+Cg=;
        b=YFMKhCNe3ls+FFUQopLc1ZMJ/+liLqb4HBVy2qsQUQb3eiFFAAPh3/0k8jzjAi3XvIprB1
        XKJ9rRjO/NTgUk+IzJGIJpjhsSbKDLlBtn3OdLKMtfBS4L7ugF/EeVU/eZHYZri84BggJ0
        Ps5YCiSViFK8darT3fdryZry2FseZ0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-N5xedtFkO-mlxcW2G1KcOQ-1; Wed, 26 Aug 2020 14:25:45 -0400
X-MC-Unique: N5xedtFkO-mlxcW2G1KcOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2E0B100670A;
        Wed, 26 Aug 2020 18:25:43 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-119-77.rdu2.redhat.com [10.10.119.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE14A100238E;
        Wed, 26 Aug 2020 18:25:42 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 10/20] drm/nouveau/kms: Use new drm_dp_read_mst_cap() helper for checking MST caps
Date:   Wed, 26 Aug 2020 14:24:46 -0400
Message-Id: <20200826182456.322681-11-lyude@redhat.com>
In-Reply-To: <20200826182456.322681-1-lyude@redhat.com>
References: <20200826182456.322681-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 032afc73e2a33..a5934064a75ea 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -44,7 +44,6 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
 	struct nv50_mstm *mstm = NULL;
 	int ret;
 	u8 *dpcd = outp->dp.dpcd;
-	u8 tmp;
 
 	ret = drm_dp_dpcd_read(aux, DP_DPCD_REV, dpcd, DP_RECEIVER_CAP_SIZE);
 	if (ret == DP_RECEIVER_CAP_SIZE && dpcd[DP_DPCD_REV]) {
@@ -56,19 +55,10 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
 		return connector_status_disconnected;
 	}
 
-	if (nouveau_mst)
+	if (nouveau_mst) {
 		mstm = outp->dp.mstm;
-
-	if (mstm) {
-		if (dpcd[DP_DPCD_REV] >= DP_DPCD_REV_12) {
-			ret = drm_dp_dpcd_readb(aux, DP_MSTM_CAP, &tmp);
-			if (ret < 0)
-				return connector_status_disconnected;
-
-			mstm->can_mst = !!(tmp & DP_MST_CAP);
-		} else {
-			mstm->can_mst = false;
-		}
+		if (mstm)
+			mstm->can_mst = drm_dp_read_mst_cap(aux, dpcd);
 	}
 
 	return connector_status_connected;
-- 
2.26.2

