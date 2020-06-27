Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324CFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1C82067D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 19:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4ouv1qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgF0Tr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 15:47:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43882 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726721AbgF0TrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 15:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593287241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8VYE8zT0ZZk/gQDPSYsv+TzjOnRAhnxP4MI/7fpLnk=;
        b=f4ouv1qfrUenZQMsv8pcjexpRBhmlYTZKfBOLXQeasf+Nv7Aa0AkcL3GklRboKlThn7XoG
        gTzXli0wvVVsoRduFbcggpDcktq/Xf0Q65SzeXy1TbX2K3aVmifIULs+lx24MIaFEtnXiI
        uMMX2ITFNVeMy1aZ9DEYNEuLcWl6f6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-_I_CBXGvMTu0L_uCS-RwaQ-1; Sat, 27 Jun 2020 15:47:14 -0400
X-MC-Unique: _I_CBXGvMTu0L_uCS-RwaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D0CE10059A4;
        Sat, 27 Jun 2020 19:47:13 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-112-223.rdu2.redhat.com [10.10.112.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53FF779309;
        Sat, 27 Jun 2020 19:47:12 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v8 4/9] drm/nouveau/kms/nv140-: Don't modify depth in state during atomic commit
Date:   Sat, 27 Jun 2020 15:46:52 -0400
Message-Id: <20200627194657.156514-5-lyude@redhat.com>
In-Reply-To: <20200627194657.156514-1-lyude@redhat.com>
References: <20200627194657.156514-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc37d.c b/drivers/gpu/drm/nouveau/dispnv50/headc37d.c
index 4a9a32b89f746..9ef3c603fc43e 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc37d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc37d.c
@@ -27,17 +27,20 @@ static void
 headc37d_or(struct nv50_head *head, struct nv50_head_atom *asyh)
 {
 	struct nv50_dmac *core = &nv50_disp(head->base.base.dev)->core->chan;
+	u8 depth;
 	u32 *push;
+
 	if ((push = evo_wait(core, 2))) {
 		/*XXX: This is a dirty hack until OR depth handling is
 		 *     improved later for deep colour etc.
 		 */
 		switch (asyh->or.depth) {
-		case 6: asyh->or.depth = 5; break;
-		case 5: asyh->or.depth = 4; break;
-		case 2: asyh->or.depth = 1; break;
-		case 0:	asyh->or.depth = 4; break;
+		case 6: depth = 5; break;
+		case 5: depth = 4; break;
+		case 2: depth = 1; break;
+		case 0:	depth = 4; break;
 		default:
+			depth = asyh->or.depth;
 			WARN_ON(1);
 			break;
 		}
diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
index 859131a8bc3c8..97141eb8e75ab 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
@@ -27,17 +27,20 @@ static void
 headc57d_or(struct nv50_head *head, struct nv50_head_atom *asyh)
 {
 	struct nv50_dmac *core = &nv50_disp(head->base.base.dev)->core->chan;
+	u8 depth;
 	u32 *push;
+
 	if ((push = evo_wait(core, 2))) {
 		/*XXX: This is a dirty hack until OR depth handling is
 		 *     improved later for deep colour etc.
 		 */
 		switch (asyh->or.depth) {
-		case 6: asyh->or.depth = 5; break;
-		case 5: asyh->or.depth = 4; break;
-		case 2: asyh->or.depth = 1; break;
-		case 0:	asyh->or.depth = 4; break;
+		case 6: depth = 5; break;
+		case 5: depth = 4; break;
+		case 2: depth = 1; break;
+		case 0:	depth = 4; break;
 		default:
+			depth = asyh->or.depth;
 			WARN_ON(1);
 			break;
 		}
-- 
2.26.2

