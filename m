Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6198CC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4C9206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3RL3zUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgDQTm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:42:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48454 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730795AbgDQTm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587152575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Wa1HP20qp3SN02zSjfdgT5NopC4hJK85x9aaSY60KI=;
        b=e3RL3zUq34dMPBqBGFPcmrYhNZAX2Wwj7YysxwBn+FgUJWnk5ANze0bqDj78rLoAYrgkKb
        ob7birQRLpGa2CGq1bLF7LDwwk3XGKy+ztr0cX3mtDDWT3IU5L9dFBp7z3g4g92O727ZJc
        6PmzwP/y9eWrrY9kz+NSZYuwKvmhFdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-oCvdjNSsMJGoa-YvpfO86A-1; Fri, 17 Apr 2020 15:42:54 -0400
X-MC-Unique: oCvdjNSsMJGoa-YvpfO86A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BA9F800D5C;
        Fri, 17 Apr 2020 19:42:52 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22A115D9CA;
        Fri, 17 Apr 2020 19:42:50 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 08/11] drm/nouveau/kms/nv140-: Track wndw mappings in nv50_head_atom
Date:   Fri, 17 Apr 2020 15:40:55 -0400
Message-Id: <20200417194145.36350-9-lyude@redhat.com>
In-Reply-To: <20200417194145.36350-1-lyude@redhat.com>
References: <20200417194145.36350-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we're not quite ready yet to add support for flexible wndw
mappings, we are going to need to at least keep track of the static wndw
mappings we're currently using in each head's atomic state. We'll likely
use this in the future to implement real flexible window mapping, but
the primary reason we'll need this is for CRC support.

See: on nvidia hardware, each CRC entry in the CRC notifier dma context
has a "tag". This tag corresponds to the nth update on a specific
EVO/NvDisplay channel, which itself is referred to as the "controlling
channel". For gf119+ this can be the core channel, ovly channel, or base
channel. Since we don't expose CRC entry tags to userspace, we simply
ignore this feature and always use the core channel as the controlling
channel. Simple.

Things get a little bit more complicated on gv100+ though. GV100+ only
lets us set the controlling channel to a specific wndw channel, and that
wndw must be owned by the head that we're grabbing CRCs when we enable
CRC generation. Thus, we always need to make sure that each atomic head
state has at least one wndw that is mapped to the head, which will be
used as the controlling channel.

Note that since we don't have flexible wndw mappings yet, we don't
expect to run into any scenarios yet where we'd have a head with no
mapped wndws. When we do add support for flexible wndw mappings however,
we'll need to make sure that we handle reprogramming CRC capture if our
controlling wndw is moved to another head (and potentially reject the
new head state entirely if we can't find another available wndw to
replace it).

With that being said, nouveau currently tracks wndw visibility on heads.
It does not keep track of the actual ownership mappings, which are
(currently) statically programmed. To fix this, we introduce another
bitmask into nv50_head_atom.wndw to keep track of ownership separately
from visibility. We then introduce a nv50_head callback to handle
populating the wndw ownership map, and call it during the atomic check
phase when core->assign_windows is set to true.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/atom.h     |  1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 16 ++++++++++++++++
 drivers/gpu/drm/nouveau/dispnv50/head.h     |  2 ++
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c | 10 ++++++++++
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c |  2 ++
 5 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/atom.h b/drivers/gpu/drm/no=
uveau/dispnv50/atom.h
index 24f7700768da..62faaf60f47a 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/atom.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/atom.h
@@ -18,6 +18,7 @@ struct nv50_head_atom {
=20
 	struct {
 		u32 mask;
+		u32 owned;
 		u32 olut;
 	} wndw;
=20
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
index 6be9df1820c5..5be036b3b533 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2254,12 +2254,28 @@ static int
 nv50_disp_atomic_check(struct drm_device *dev, struct drm_atomic_state *=
state)
 {
 	struct nv50_atom *atom =3D nv50_atom(state);
+	struct nv50_core *core =3D nv50_disp(dev)->core;
 	struct drm_connector_state *old_connector_state, *new_connector_state;
 	struct drm_connector *connector;
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_crtc *crtc;
+	struct nv50_head *head;
+	struct nv50_head_atom *asyh;
 	int ret, i;
=20
+	if (core->assign_windows && core->func->head->static_wndw_map) {
+		drm_for_each_crtc(crtc, dev) {
+			new_crtc_state =3D drm_atomic_get_crtc_state(state,
+								   crtc);
+			if (IS_ERR(new_crtc_state))
+				return PTR_ERR(new_crtc_state);
+
+			head =3D nv50_head(crtc);
+			asyh =3D nv50_head_atom(new_crtc_state);
+			core->func->head->static_wndw_map(head, asyh);
+		}
+	}
+
 	/* We need to handle colour management on a per-plane basis. */
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		if (new_crtc_state->color_mgmt_changed) {
diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.h b/drivers/gpu/drm/no=
uveau/dispnv50/head.h
index c32b27cdaefc..c05bbba9e247 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.h
@@ -40,6 +40,7 @@ struct nv50_head_func {
 	void (*dither)(struct nv50_head *, struct nv50_head_atom *);
 	void (*procamp)(struct nv50_head *, struct nv50_head_atom *);
 	void (*or)(struct nv50_head *, struct nv50_head_atom *);
+	void (*static_wndw_map)(struct nv50_head *, struct nv50_head_atom *);
 };
=20
 extern const struct nv50_head_func head507d;
@@ -86,6 +87,7 @@ int headc37d_curs_format(struct nv50_head *, struct nv5=
0_wndw_atom *,
 void headc37d_curs_set(struct nv50_head *, struct nv50_head_atom *);
 void headc37d_curs_clr(struct nv50_head *);
 void headc37d_dither(struct nv50_head *, struct nv50_head_atom *);
+void headc37d_static_wndw_map(struct nv50_head *, struct nv50_head_atom =
*);
=20
 extern const struct nv50_head_func headc57d;
 #endif
diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc37d.c b/drivers/gpu/dr=
m/nouveau/dispnv50/headc37d.c
index 68920f8d9c79..cf5a68f4021a 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc37d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc37d.c
@@ -203,6 +203,15 @@ headc37d_view(struct nv50_head *head, struct nv50_he=
ad_atom *asyh)
 	}
 }
=20
+void
+headc37d_static_wndw_map(struct nv50_head *head, struct nv50_head_atom *=
asyh)
+{
+	int i, end;
+
+	for (i =3D head->base.index * 2, end =3D i + 2; i < end; i++)
+		asyh->wndw.owned |=3D BIT(i);
+}
+
 const struct nv50_head_func
 headc37d =3D {
 	.view =3D headc37d_view,
@@ -218,4 +227,5 @@ headc37d =3D {
 	.dither =3D headc37d_dither,
 	.procamp =3D headc37d_procamp,
 	.or =3D headc37d_or,
+	.static_wndw_map =3D headc37d_static_wndw_map,
 };
diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/dr=
m/nouveau/dispnv50/headc57d.c
index 0296cd1d761f..65e3b60804c6 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
@@ -210,4 +210,6 @@ headc57d =3D {
 	.dither =3D headc37d_dither,
 	.procamp =3D headc57d_procamp,
 	.or =3D headc57d_or,
+	/* TODO: flexible window mappings */
+	.static_wndw_map =3D headc37d_static_wndw_map,
 };
--=20
2.25.1

