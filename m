Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3D6C2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460E52080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uft9gX/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbgCaVWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:22:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28339 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728245AbgCaVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585689764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eex3SHts6rbpYBfbz4mSibBnrbBxISm/iRw73/lBaoQ=;
        b=Uft9gX/XqTmuaGYDMxlqDKVXxtplONvs/LRo4HMErw+TzOibauPI60H4wrN2anhNRi37U2
        raCtexoIlbnaEptrHbcRevXm1428+saqlEYx6O+Oy82qtOhux3jYN8g0GasfBmjgyKAlde
        8EdZ90n2eBqj4ypo0sOsFhlSfE87lQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-J37X7zepM-qZ1gBslB-yRg-1; Tue, 31 Mar 2020 17:22:42 -0400
X-MC-Unique: J37X7zepM-qZ1gBslB-yRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CB4A18B5F6A;
        Tue, 31 Mar 2020 21:22:40 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-88.rdu2.redhat.com [10.10.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0ABA5C1BB;
        Tue, 31 Mar 2020 21:22:36 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/amdgpu_dm/mst: Remove useless sideband tracing
Date:   Tue, 31 Mar 2020 17:22:23 -0400
Message-Id: <20200331212228.139219-2-lyude@redhat.com>
In-Reply-To: <20200331212228.139219-1-lyude@redhat.com>
References: <20200331212228.139219-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already trace DPCD reads/writes on both MST and SST, there's no
reason to have this code here (plus, toggling these things with a
define at the top of the file isn't how we do things in the kernel).

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 43 -------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index e8208df420d9..7f2293016446 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -41,53 +41,10 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
=20
-
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dc/dcn20/dcn20_resource.h"
 #endif
=20
-/* #define TRACE_DPCD */
-
-#ifdef TRACE_DPCD
-#define SIDE_BAND_MSG(address) (address >=3D DP_SIDEBAND_MSG_DOWN_REQ_BA=
SE && address < DP_SINK_COUNT_ESI)
-
-static inline char *side_band_msg_type_to_str(uint32_t address)
-{
-	static char str[10] =3D {0};
-
-	if (address < DP_SIDEBAND_MSG_UP_REP_BASE)
-		strcpy(str, "DOWN_REQ");
-	else if (address < DP_SIDEBAND_MSG_DOWN_REP_BASE)
-		strcpy(str, "UP_REP");
-	else if (address < DP_SIDEBAND_MSG_UP_REQ_BASE)
-		strcpy(str, "DOWN_REP");
-	else
-		strcpy(str, "UP_REQ");
-
-	return str;
-}
-
-static void log_dpcd(uint8_t type,
-		     uint32_t address,
-		     uint8_t *data,
-		     uint32_t size,
-		     bool res)
-{
-	DRM_DEBUG_KMS("Op: %s, addr: %04x, SideBand Msg: %s, Op res: %s\n",
-			(type =3D=3D DP_AUX_NATIVE_READ) ||
-			(type =3D=3D DP_AUX_I2C_READ) ?
-					"Read" : "Write",
-			address,
-			SIDE_BAND_MSG(address) ?
-					side_band_msg_type_to_str(address) : "Nop",
-			res ? "OK" : "Fail");
-
-	if (res) {
-		print_hex_dump(KERN_INFO, "Body: ", DUMP_PREFIX_NONE, 16, 1, data, siz=
e, false);
-	}
-}
-#endif
-
 static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 				  struct drm_dp_aux_msg *msg)
 {
--=20
2.25.1

