Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071CCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32A920786
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtyBOjlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgHKUGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:06:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54677 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726258AbgHKUF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597176356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcFp48n/aLMtpSE/1lSAUTj8bSRshm4WBYhHn9wvw8Q=;
        b=VtyBOjlc3cOnm8MS1lsV4SwB9i5ON9WpQ4AbrT6pTGT0ir4x+oN/22xxclGozeyV2++Dw/
        XgseigwAloUCRe/cF13eY1vWcXA7olQ79k5efA2IuNbQRr403bV5iIGitop5vKWmUUenii
        mUFYbOuNvC24UMEMVbvQ9VLcV1dzH1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-5u0jNafaM5KBtOc9swDD7w-1; Tue, 11 Aug 2020 16:05:53 -0400
X-MC-Unique: 5u0jNafaM5KBtOc9swDD7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 161818014D8;
        Tue, 11 Aug 2020 20:05:52 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-119-184.rdu2.redhat.com [10.10.119.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F0F45D9DD;
        Tue, 11 Aug 2020 20:05:45 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC 05/20] drm/nouveau/kms: Don't clear DP_MST_CTRL DPCD in nv50_mstm_new()
Date:   Tue, 11 Aug 2020 16:04:42 -0400
Message-Id: <20200811200457.134743-6-lyude@redhat.com>
In-Reply-To: <20200811200457.134743-1-lyude@redhat.com>
References: <20200811200457.134743-1-lyude@redhat.com>
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

