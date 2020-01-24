Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948E6C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6C72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcAzv2LM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgAXBIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:08:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28028 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729559AbgAXBIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579828088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MACu9eh0JEDCpTCpJs0kAJqbqqu5eAOpE4LnFleGthU=;
        b=KcAzv2LM0YWRHRs6KTp9OAoKzxCNagq/7ut5IRJGzRpW878VJiSimDE26G6edgyDnln093
        64bkAweaVdRe6FmooiJIjYNDnnYxDD6jfcmKxDleGEBr0A81373cT5w/RPH/hRemSriOFw
        Bnf/C9+nn9zivDmoG51lKZdrpGddMZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-c3DPU0T_NZi4TwsFF38BNg-1; Thu, 23 Jan 2020 20:08:06 -0500
X-MC-Unique: c3DPU0T_NZi4TwsFF38BNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DF1E800D48;
        Fri, 24 Jan 2020 01:08:04 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-124-168.rdu2.redhat.com [10.10.124.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E28065D9E2;
        Fri, 24 Jan 2020 01:07:59 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Stop using the DRIVER debugging flag for vblank debugging messages
Date:   Thu, 23 Jan 2020 20:07:42 -0500
Message-Id: <20200124010744.102849-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are some very loud debug statements that get printed on every
vblank when driver level debug printing is enabled in DRM, and doesn't
really tell us anything that isn't related to vblanks. So let's move
this over to the proper debug flag to be a little less spammy with our
debug output.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9402374d2466..3675e1c32707 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -407,8 +407,9 @@ static void dm_vupdate_high_irq(void *interrupt_param=
s)
 	if (acrtc) {
 		acrtc_state =3D to_dm_crtc_state(acrtc->base.state);
=20
-		DRM_DEBUG_DRIVER("crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
-				 amdgpu_dm_vrr_active(acrtc_state));
+		DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
+			      acrtc->crtc_id,
+			      amdgpu_dm_vrr_active(acrtc_state));
=20
 		/* Core vblank handling is done here after end of front-porch in
 		 * vrr mode, as vblank timestamping will give valid results
@@ -458,8 +459,9 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	if (acrtc) {
 		acrtc_state =3D to_dm_crtc_state(acrtc->base.state);
=20
-		DRM_DEBUG_DRIVER("crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
-				 amdgpu_dm_vrr_active(acrtc_state));
+		DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
+			      acrtc->crtc_id,
+			      amdgpu_dm_vrr_active(acrtc_state));
=20
 		/* Core vblank handling at start of front-porch is only possible
 		 * in non-vrr mode, as only there vblank timestamping will give
@@ -522,8 +524,8 @@ static void dm_dcn_crtc_high_irq(void *interrupt_para=
ms)
=20
 	acrtc_state =3D to_dm_crtc_state(acrtc->base.state);
=20
-	DRM_DEBUG_DRIVER("crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
-				amdgpu_dm_vrr_active(acrtc_state));
+	DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
+		      amdgpu_dm_vrr_active(acrtc_state));
=20
 	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
 	drm_crtc_handle_vblank(&acrtc->base);
--=20
2.24.1

