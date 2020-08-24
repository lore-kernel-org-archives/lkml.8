Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4975BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1193B20639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpgWGZy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHXSdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:33:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46764 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725962AbgHXSdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598293991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nDN8OKH/igdTXe1JZhVc/ikuMKRfmf49543jqaV4qUQ=;
        b=SpgWGZy0tgRKoq1XiRyUwdLTr7fK8nJWYpDy3k0M4dWJdc8a45Q3lnRRiGzxI4lCoE/p05
        QaTFHOrcC+chY+nY8pizhUPA0m21otrRHFNAcnh4UxDF4nmNWqXU10IwLmTJuUQtP7CkqP
        PLHvwUjjOVGCMgfQnnn9h3Ek/Uepf5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-8WE-K4HYMnGsgDHFsvC9Ng-1; Mon, 24 Aug 2020 14:33:08 -0400
X-MC-Unique: 8WE-K4HYMnGsgDHFsvC9Ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B85081F018;
        Mon, 24 Aug 2020 18:33:06 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-114-60.rdu2.redhat.com [10.10.114.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E1465C22A;
        Mon, 24 Aug 2020 18:33:02 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/nouveau/kms/nv50-: Log SOR/PIOR caps
Date:   Mon, 24 Aug 2020 14:32:53 -0400
Message-Id: <20200824183253.826343-3-lyude@redhat.com>
In-Reply-To: <20200824183253.826343-1-lyude@redhat.com>
References: <20200824183253.826343-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I'm almost certain I didn't get capability checking right for
pre-volta chipsets, let's start logging any caps we find to make things
like this obvious in the future.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 800b7757252e3..6210ee1c145a2 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -258,6 +258,14 @@ evo_kick(u32 *push, struct nv50_dmac *evoc)
 /******************************************************************************
  * Output path helpers
  *****************************************************************************/
+static void
+nv50_outp_dump_caps(struct nouveau_drm *drm,
+		    struct nouveau_encoder *outp)
+{
+	NV_DEBUG(drm, "%s caps: dp_interlace=%d\n",
+		 outp->base.base.name, outp->caps.dp_interlace);
+}
+
 static void
 nv50_outp_release(struct nouveau_encoder *nv_encoder)
 {
@@ -1715,6 +1723,7 @@ nv50_sor_create(struct drm_connector *connector, struct dcb_output *dcbe)
 	drm_connector_attach_encoder(connector, encoder);
 
 	disp->core->func->sor->get_caps(disp, nv_encoder, ffs(dcbe->or) - 1);
+	nv50_outp_dump_caps(drm, nv_encoder);
 
 	if (dcbe->type == DCB_OUTPUT_DP) {
 		struct nvkm_i2c_aux *aux =
@@ -1875,6 +1884,7 @@ nv50_pior_create(struct drm_connector *connector, struct dcb_output *dcbe)
 	drm_connector_attach_encoder(connector, encoder);
 
 	disp->core->func->pior->get_caps(disp, nv_encoder, ffs(dcbe->or) - 1);
+	nv50_outp_dump_caps(drm, nv_encoder);
 
 	return 0;
 }
-- 
2.26.2

