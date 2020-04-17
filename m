Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABEEC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63EC920715
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObPGvJr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgDQTmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:42:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730709AbgDQTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587152563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJPxlq5Ma2a0sJ7/1LPS5ltc7hZTfE2W5c8nSEX7ldI=;
        b=ObPGvJr1thVg0vk6KW8p4CJWMPrzpMoRh9CzOLkrRpwA4m9osQPJAGWOiUzpj4Ya3gQe31
        3DTdqaZvhPBaqBtjith/btGm15w9nffjCdYWamFoezMhDHRt/iR8SLqKbaMAp3AB4V2319
        Tu+irCHiZXn80n8IQ5EpBfRaaAYsyVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-xGIxsbQ7MUeO_u8W1RYntA-1; Fri, 17 Apr 2020 15:42:38 -0400
X-MC-Unique: xGIxsbQ7MUeO_u8W1RYntA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F36301926DA2;
        Fri, 17 Apr 2020 19:42:36 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 233DC5D9CA;
        Fri, 17 Apr 2020 19:42:36 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC v3 05/11] drm/nouveau/kms/nv140-: Don't modify depth in state during atomic commit
Date:   Fri, 17 Apr 2020 15:40:52 -0400
Message-Id: <20200417194145.36350-6-lyude@redhat.com>
In-Reply-To: <20200417194145.36350-1-lyude@redhat.com>
References: <20200417194145.36350-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we modify the depth value stored in the atomic state when
performing a commit in order to workaround the fact we haven't
implemented support for depths higher then 10 yet. This isn't idempotent
though, as it will happen every atomic commit where we modify the OR
state even if the head's depth in the atomic state hasn't been modified.

Normally this wouldn't matter, since we don't modify OR state outside of
modesets, but since the CRC capture region is implemented as part of the
OR state in hardware we'll want to make sure all commits modifying OR
state are idempotent so as to avoid changing the depth unexpectedly.

So, fix this by simply not writing the reduced depth value we come up
with to the atomic state.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c | 11 +++++++----
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc37d.c b/drivers/gpu/dr=
m/nouveau/dispnv50/headc37d.c
index 00011ce109a6..68920f8d9c79 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc37d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc37d.c
@@ -27,17 +27,20 @@ static void
 headc37d_or(struct nv50_head *head, struct nv50_head_atom *asyh)
 {
 	struct nv50_dmac *core =3D &nv50_disp(head->base.base.dev)->core->chan;
+	u8 depth;
 	u32 *push;
+
 	if ((push =3D evo_wait(core, 2))) {
 		/*XXX: This is a dirty hack until OR depth handling is
 		 *     improved later for deep colour etc.
 		 */
 		switch (asyh->or.depth) {
-		case 6: asyh->or.depth =3D 5; break;
-		case 5: asyh->or.depth =3D 4; break;
-		case 2: asyh->or.depth =3D 1; break;
-		case 0:	asyh->or.depth =3D 4; break;
+		case 6: depth =3D 5; break;
+		case 5: depth =3D 4; break;
+		case 2: depth =3D 1; break;
+		case 0:	depth =3D 4; break;
 		default:
+			depth =3D asyh->or.depth;
 			WARN_ON(1);
 			break;
 		}
diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/dr=
m/nouveau/dispnv50/headc57d.c
index 938d910a1b1e..0296cd1d761f 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
@@ -27,17 +27,20 @@ static void
 headc57d_or(struct nv50_head *head, struct nv50_head_atom *asyh)
 {
 	struct nv50_dmac *core =3D &nv50_disp(head->base.base.dev)->core->chan;
+	u8 depth;
 	u32 *push;
+
 	if ((push =3D evo_wait(core, 2))) {
 		/*XXX: This is a dirty hack until OR depth handling is
 		 *     improved later for deep colour etc.
 		 */
 		switch (asyh->or.depth) {
-		case 6: asyh->or.depth =3D 5; break;
-		case 5: asyh->or.depth =3D 4; break;
-		case 2: asyh->or.depth =3D 1; break;
-		case 0:	asyh->or.depth =3D 4; break;
+		case 6: depth =3D 5; break;
+		case 5: depth =3D 4; break;
+		case 2: depth =3D 1; break;
+		case 0:	depth =3D 4; break;
 		default:
+			depth =3D asyh->or.depth;
 			WARN_ON(1);
 			break;
 		}
--=20
2.25.1

