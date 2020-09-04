Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27191C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA27F2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6pX3bOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgIDU2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:28:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40485 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727921AbgIDU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599251320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BWp0AAI+VZUu8qz/13ssyrVxYR5SrJ8VDuwzkJreei0=;
        b=D6pX3bOYWhbkisbpj9i7EySEbgezcqwg8vlOD/VTQcJQBTVDtoJj/ygKld2aSV/13XLuGZ
        Ye0g3RQYGdnZ6UPE+4kWfq/mNuKdb+uTTExrfe3TFpcy8B4n9mTxD8SF5E+nHwG3nQff7v
        OYAtC7KqihXD7ENhZGMzggWi0KJd8Es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-4WJb22XZMNCaxKXeeacgtQ-1; Fri, 04 Sep 2020 16:28:38 -0400
X-MC-Unique: 4WJb22XZMNCaxKXeeacgtQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F82610BBECF;
        Fri,  4 Sep 2020 20:28:28 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-1.rdu2.redhat.com [10.10.118.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95FE360C05;
        Fri,  4 Sep 2020 20:28:24 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/2] drm/nouveau/kms/nv50-: Log SOR/PIOR caps
Date:   Fri,  4 Sep 2020 16:27:59 -0400
Message-Id: <20200904202813.1260202-2-lyude@redhat.com>
In-Reply-To: <20200904202813.1260202-1-lyude@redhat.com>
References: <20200904202813.1260202-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index 7799530e07c1f..376add0faacc3 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -303,6 +303,14 @@ nv50_dmac_create(struct nvif_device *device, struct nvif_object *disp,
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
@@ -1819,6 +1827,7 @@ nv50_sor_create(struct drm_connector *connector, struct dcb_output *dcbe)
 	drm_connector_attach_encoder(connector, encoder);
 
 	disp->core->func->sor->get_caps(disp, nv_encoder, ffs(dcbe->or) - 1);
+	nv50_outp_dump_caps(drm, nv_encoder);
 
 	if (dcbe->type == DCB_OUTPUT_DP) {
 		struct nvkm_i2c_aux *aux =
@@ -1989,6 +1998,7 @@ nv50_pior_create(struct drm_connector *connector, struct dcb_output *dcbe)
 	drm_connector_attach_encoder(connector, encoder);
 
 	disp->core->func->pior->get_caps(disp, nv_encoder, ffs(dcbe->or) - 1);
+	nv50_outp_dump_caps(drm, nv_encoder);
 
 	return 0;
 }
-- 
2.26.2

