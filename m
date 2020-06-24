Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7310EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C4A2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbfVggG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389278AbgFXXEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:04:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36262 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389182AbgFXXEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593039846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZYhBvbDDNRy7VCCeT+Z/3+KFjbOGADAaOoqLREGB6A=;
        b=QbfVggG1VP3mq6AOkNz6Y0y5dtVD3p5qFUv4nedvM86GevfVlrEVocx8Wa3q9D2GxpiXjs
        9U/JwI/Uxdn/WK/uef7ye0uFkcla67PJy7gkugWCW+J/KS+/QpiZUFygOe4DggyB7AKDyI
        mRiOgdWWKyPEd6T3q8JI7fMrb4jLW+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-9bCOW_7rNx-PTrKHNLxfKw-1; Wed, 24 Jun 2020 19:04:02 -0400
X-MC-Unique: 9bCOW_7rNx-PTrKHNLxfKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCD2D18585A2;
        Wed, 24 Jun 2020 23:04:00 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-115-214.rdu2.redhat.com [10.10.115.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30377101E662;
        Wed, 24 Jun 2020 23:03:59 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v7 09/11] drm/nouveau/kms/nv50-: Expose nv50_outp_atom in disp.h
Date:   Wed, 24 Jun 2020 19:03:16 -0400
Message-Id: <20200624230318.126256-10-lyude@redhat.com>
In-Reply-To: <20200624230318.126256-1-lyude@redhat.com>
References: <20200624230318.126256-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make sure that we flush disable updates at the right time
when disabling CRCs, we'll need to be able to look at the outp state to
see if we're changing it at the same time that we're disabling CRCs.

So, expose the struct in disp.h.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 18 ------------------
 drivers/gpu/drm/nouveau/dispnv50/disp.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 368069a5b181a..090882794f7d6 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -57,24 +57,6 @@
 
 #include <subdev/bios/dp.h>
 
-/******************************************************************************
- * Atomic state
- *****************************************************************************/
-
-struct nv50_outp_atom {
-	struct list_head head;
-
-	struct drm_encoder *encoder;
-	bool flush_disable;
-
-	union nv50_outp_atom_mask {
-		struct {
-			bool ctrl:1;
-		};
-		u8 mask;
-	} set, clr;
-};
-
 /******************************************************************************
  * EVO channel
  *****************************************************************************/
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.h b/drivers/gpu/drm/nouveau/dispnv50/disp.h
index 696e70a6b98b6..c7b72fa850995 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.h
@@ -71,6 +71,20 @@ struct nv50_dmac {
 	struct mutex lock;
 };
 
+struct nv50_outp_atom {
+	struct list_head head;
+
+	struct drm_encoder *encoder;
+	bool flush_disable;
+
+	union nv50_outp_atom_mask {
+		struct {
+			bool ctrl:1;
+		};
+		u8 mask;
+	} set, clr;
+};
+
 int nv50_dmac_create(struct nvif_device *device, struct nvif_object *disp,
 		     const s32 *oclass, u8 head, void *data, u32 size,
 		     u64 syncbuf, struct nv50_dmac *dmac);
-- 
2.26.2

