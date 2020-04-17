Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E24C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7958120715
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGr4yqpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgDQTnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:43:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42557 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730795AbgDQTnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587152579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vrv+BRobzxfIw8uzQhGRUQB+JV4ocho5fjC/dYNzxUs=;
        b=bGr4yqppwnhHjenqxudy3wLNiwC5olL1yNowqrY8wBg+WSk2NQ0l9iElrCaJL1MicmcGOe
        sImAtU1pb+wfjIBzLTqjdJDUwdiwxCoA+OawLPojdVSKS2LTIJr0ROJ03sgt0AATO4Q4cI
        h4tV21qVxsbykKMigaEbmYSr9I5UmJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-fqHCkSp2OpS57S8DAXJqCg-1; Fri, 17 Apr 2020 15:42:57 -0400
X-MC-Unique: fqHCkSp2OpS57S8DAXJqCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A79A0149C0;
        Fri, 17 Apr 2020 19:42:55 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6661B5D9CA;
        Fri, 17 Apr 2020 19:42:54 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Takashi Iwai <tiwai@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 09/11] drm/nouveau/kms/nv50-: Expose nv50_outp_atom in disp.h
Date:   Fri, 17 Apr 2020 15:40:56 -0400
Message-Id: <20200417194145.36350-10-lyude@redhat.com>
In-Reply-To: <20200417194145.36350-1-lyude@redhat.com>
References: <20200417194145.36350-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
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

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
index 5be036b3b533..5d5661967d50 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -57,24 +57,6 @@
=20
 #include <subdev/bios/dp.h>
=20
-/***********************************************************************=
*******
- * Atomic state
- ***********************************************************************=
******/
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
 /***********************************************************************=
*******
  * EVO channel
  ***********************************************************************=
******/
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.h b/drivers/gpu/drm/no=
uveau/dispnv50/disp.h
index d54fe00ac3a3..8935ebce8ab0 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.h
@@ -70,6 +70,20 @@ struct nv50_dmac {
 	struct mutex lock;
 };
=20
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
 int nv50_dmac_create(struct nvif_device *device, struct nvif_object *dis=
p,
 		     const s32 *oclass, u8 head, void *data, u32 size,
 		     u64 syncbuf, struct nv50_dmac *dmac);
--=20
2.25.1

