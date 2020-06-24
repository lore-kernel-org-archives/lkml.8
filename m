Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA646C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9579B21532
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsDqcQFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbgFXXEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:04:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24164 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729587AbgFXXDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593039832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dmkn5ElK0S49yC+YYieD973IcE+n74T+jY14yBT/f54=;
        b=UsDqcQFRwl9iRe50IkeuqEwKjthq5NxKAmQK2+RL44u7t0qu0+g5SnErQeBvnuAnk2Yyka
        o1Pb19n+vlcb8u/9J1LqJHTXZ0Qqm9JdF81tBxfyxy55cGMJmzp+jgwZWykwAz4wQfN3Av
        z6mw/9RFOsZeGJYpOFWVi5IG2Ig2xco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-sqbsBC6bOkm3BP6HNuSNlw-1; Wed, 24 Jun 2020 19:03:48 -0400
X-MC-Unique: sqbsBC6bOkm3BP6HNuSNlw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73CBD184D162;
        Wed, 24 Jun 2020 23:03:46 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-115-214.rdu2.redhat.com [10.10.115.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C23A1001B07;
        Wed, 24 Jun 2020 23:03:45 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v7 06/11] drm/nouveau/kms/nv50-: Fix disabling dithering
Date:   Wed, 24 Jun 2020 19:03:13 -0400
Message-Id: <20200624230318.126256-7-lyude@redhat.com>
In-Reply-To: <20200624230318.126256-1-lyude@redhat.com>
References: <20200624230318.126256-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we expose the ability to turn off hardware dithering for nouveau,
we actually make the mistake of turning it on anyway, due to
dithering_depth containing a non-zero value if our dithering depth isn't
also set to 6 bpc.

So, fix it by never enabling dithering when it's disabled.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/head.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
index e29ea40e7c334..72bc3bce396a7 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
@@ -84,18 +84,20 @@ nv50_head_atomic_check_dither(struct nv50_head_atom *armh,
 {
 	u32 mode = 0x00;
 
-	if (asyc->dither.mode == DITHERING_MODE_AUTO) {
-		if (asyh->base.depth > asyh->or.bpc * 3)
-			mode = DITHERING_MODE_DYNAMIC2X2;
-	} else {
-		mode = asyc->dither.mode;
-	}
+	if (asyc->dither.mode) {
+		if (asyc->dither.mode == DITHERING_MODE_AUTO) {
+			if (asyh->base.depth > asyh->or.bpc * 3)
+				mode = DITHERING_MODE_DYNAMIC2X2;
+		} else {
+			mode = asyc->dither.mode;
+		}
 
-	if (asyc->dither.depth == DITHERING_DEPTH_AUTO) {
-		if (asyh->or.bpc >= 8)
-			mode |= DITHERING_DEPTH_8BPC;
-	} else {
-		mode |= asyc->dither.depth;
+		if (asyc->dither.depth == DITHERING_DEPTH_AUTO) {
+			if (asyh->or.bpc >= 8)
+				mode |= DITHERING_DEPTH_8BPC;
+		} else {
+			mode |= asyc->dither.depth;
+		}
 	}
 
 	asyh->dither.enable = mode;
-- 
2.26.2

