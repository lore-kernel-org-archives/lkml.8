Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E9AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A101206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQtN9xhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHTSa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:30:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25446 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727772AbgHTSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597948237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcFp48n/aLMtpSE/1lSAUTj8bSRshm4WBYhHn9wvw8Q=;
        b=TQtN9xhSgjc7wSaHCQBHN9G7rKkc0PxW4NMMRL3DJGyGjIZqtDAH9o+vP4wpEP5yXMs+Yy
        XpYsDRQqGyhuTP/1Wh5EqpyjNLKsPDLea6Y8fGFsMNuCqePCr8yTEkYp1UrnMM5qStds+8
        NjSOKl9/fQZ7k7vFS+H3RbbTOSDqZD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-pp1d7sf5NR6FEbRycNTjng-1; Thu, 20 Aug 2020 14:30:35 -0400
X-MC-Unique: pp1d7sf5NR6FEbRycNTjng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8000801AE7;
        Thu, 20 Aug 2020 18:30:33 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-42.rdu2.redhat.com [10.10.120.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85A465DA74;
        Thu, 20 Aug 2020 18:30:32 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 05/20] drm/nouveau/kms: Don't clear DP_MST_CTRL DPCD in nv50_mstm_new()
Date:   Thu, 20 Aug 2020 14:29:57 -0400
Message-Id: <20200820183012.288794-6-lyude@redhat.com>
In-Reply-To: <20200820183012.288794-1-lyude@redhat.com>
References: <20200820183012.288794-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since fa3cdf8d0b09 ("drm/nouveau: Reset MST branching unit before
enabling") we've been clearing DP_MST_CTRL before we start enabling MST.
Since then clearing DP_MST_CTRL in nv50_mstm_new() has been unnecessary
and redundant, so let's remove it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e7874877da858..c4d138f0ca054 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1535,17 +1535,6 @@ nv50_mstm_new(struct nouveau_encoder *outp, struct drm_dp_aux *aux, int aux_max,
 	struct drm_device *dev = outp->base.base.dev;
 	struct nv50_mstm *mstm;
 	int ret;
-	u8 dpcd;
-
-	/* This is a workaround for some monitors not functioning
-	 * correctly in MST mode on initial module load.  I think
-	 * some bad interaction with the VBIOS may be responsible.
-	 *
-	 * A good ol' off and on again seems to work here ;)
-	 */
-	ret = drm_dp_dpcd_readb(aux, DP_DPCD_REV, &dpcd);
-	if (ret >= 0 && dpcd >= 0x12)
-		drm_dp_dpcd_writeb(aux, DP_MSTM_CTRL, 0);
 
 	if (!(mstm = *pmstm = kzalloc(sizeof(*mstm), GFP_KERNEL)))
 		return -ENOMEM;
-- 
2.26.2

