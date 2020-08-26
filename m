Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEF6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F86320737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C66HPdRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHZSZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726818AbgHZSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598466321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmTNhsPZLdpUnVNZa+gMWlRtbGSg6BTHeH385f0X4wk=;
        b=C66HPdRmQVLk6G6JYwVcEnnarTT592qERH4SL3nNSc6mruztJBjldzdFcfCSRCVGHrXmc2
        rHrpF495Klo+1SzBQ5ZR/NZmZ4820yyTgiFxWUWLuMbXKMnPrdJJUzUTbI5yKOK9Tly+9Q
        Ck+eV+uT7TMElSlW+VOdSJa0XuCdIlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-9dUyMF0FOw6-veo4YNJYIA-1; Wed, 26 Aug 2020 14:25:18 -0400
X-MC-Unique: 9dUyMF0FOw6-veo4YNJYIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4F5410066FE;
        Wed, 26 Aug 2020 18:25:16 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-119-77.rdu2.redhat.com [10.10.119.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE716100238E;
        Wed, 26 Aug 2020 18:25:15 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 04/20] drm/nouveau/kms/nv50-: Use macros for DP registers in nouveau_dp.c
Date:   Wed, 26 Aug 2020 14:24:40 -0400
Message-Id: <20200826182456.322681-5-lyude@redhat.com>
In-Reply-To: <20200826182456.322681-1-lyude@redhat.com>
References: <20200826182456.322681-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 8db9216d52c69..4030806e3522b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -50,11 +50,13 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
 	if (ret != sizeof(dpcd))
 		return ret;
 
-	nv_encoder->dp.link_bw = 27000 * dpcd[1];
-	nv_encoder->dp.link_nr = dpcd[2] & DP_MAX_LANE_COUNT_MASK;
+	nv_encoder->dp.link_bw = 27000 * dpcd[DP_MAX_LINK_RATE];
+	nv_encoder->dp.link_nr =
+		dpcd[DP_MAX_LANE_COUNT] & DP_MAX_LANE_COUNT_MASK;
 
 	NV_DEBUG(drm, "display: %dx%d dpcd 0x%02x\n",
-		 nv_encoder->dp.link_nr, nv_encoder->dp.link_bw, dpcd[0]);
+		 nv_encoder->dp.link_nr, nv_encoder->dp.link_bw,
+		 dpcd[DP_DPCD_REV]);
 	NV_DEBUG(drm, "encoder: %dx%d\n",
 		 nv_encoder->dcb->dpconf.link_nr,
 		 nv_encoder->dcb->dpconf.link_bw);
-- 
2.26.2

