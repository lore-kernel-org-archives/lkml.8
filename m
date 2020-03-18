Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD389C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FE7206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A25Jj/vR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgCRAmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:42:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51786 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727408AbgCRAmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584492164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uqPAYguVEZWqPeMAuR/XQRE/Rb26pO/ctNUZpEKUECE=;
        b=A25Jj/vRjUijpXRVZ2J9QEdQgQVJRHwWxqe95ZaygL7wW0M47PSlTby8IS3fwppI57YtTs
        83Q/CMvh5to27ltWHj9ijEKw+EJTF4N1REOGo8aa0094zCqaBiYCwTLgs9emEDKx+rvwTP
        RLPC7TWHj1rqwVT/Poa9pmFMeuDGVX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-ZgUK4iL1OOaOVJnBP8s68A-1; Tue, 17 Mar 2020 20:42:36 -0400
X-MC-Unique: ZgUK4iL1OOaOVJnBP8s68A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A07DD800D50;
        Wed, 18 Mar 2020 00:42:35 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-113-173.rdu2.redhat.com [10.10.113.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A783360BE0;
        Wed, 18 Mar 2020 00:42:34 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] drm/nouveau/kms/nv140-: Don't modify depth in state during atomic commit
Date:   Tue, 17 Mar 2020 20:41:00 -0400
Message-Id: <20200318004159.235623-4-lyude@redhat.com>
In-Reply-To: <20200318004159.235623-1-lyude@redhat.com>
References: <20200318004159.235623-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
2.24.1

