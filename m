Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849CAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5513C20C09
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwNZ5fcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbgFXXD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:03:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20037 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388140AbgFXXDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593039833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8VYE8zT0ZZk/gQDPSYsv+TzjOnRAhnxP4MI/7fpLnk=;
        b=FwNZ5fcJw+aMPOknGjbocRurCX8ok0Pd0ioI3pE4qz7L7QC3pfaEQOt3OjP3CyD0bhOJ5M
        hvVHqARDTA3FkoDdGujQqma5pmrW2uygjkezF+WBa0Fhd08Wpj3sdiZPIRZMv8YkQUFxYi
        V9FlcRtfUpQmRzKCjBSgQN4m678G1Tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-sjw2w1K5MTq6NdJsVYDP2w-1; Wed, 24 Jun 2020 19:03:45 -0400
X-MC-Unique: sjw2w1K5MTq6NdJsVYDP2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA967802ED4;
        Wed, 24 Jun 2020 23:03:43 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-115-214.rdu2.redhat.com [10.10.115.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B925F1001B07;
        Wed, 24 Jun 2020 23:03:42 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v7 05/11] drm/nouveau/kms/nv140-: Don't modify depth in state during atomic commit
Date:   Wed, 24 Jun 2020 19:03:12 -0400
Message-Id: <20200624230318.126256-6-lyude@redhat.com>
In-Reply-To: <20200624230318.126256-1-lyude@redhat.com>
References: <20200624230318.126256-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

