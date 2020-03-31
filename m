Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F09C2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC9D207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzKLw+CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbgCaU6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:58:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26161 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731236AbgCaU6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585688283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9TxpyWj+Au+l7FDdZORjZAyVa0RQ8jLqCZnOYPH8wQ=;
        b=UzKLw+CLkeRfoIRCPaMlcil2F9/6jLjECYStcdHHnyKx/u6qymLtSvninDbBdM/0BDSb+W
        ZuCC9gA2usufvHVYDM4nB9AHsgufvQwlCz7uBHz4LtYb4uK0v8aKQ5tEduAcGy7u9GLHQT
        cd0H+T/00GLvqJAsBieNUHJa8diwvGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-tCYDMqX-PZGPyEAzwuGBIg-1; Tue, 31 Mar 2020 16:58:02 -0400
X-MC-Unique: tCYDMqX-PZGPyEAzwuGBIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF82C1005509;
        Tue, 31 Mar 2020 20:57:59 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-88.rdu2.redhat.com [10.10.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97BFB98A52;
        Tue, 31 Mar 2020 20:57:55 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Francis <David.Francis@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/amd/amdgpu_dm/mst: Stop printing extra messages in dm_dp_add_mst_connector()
Date:   Tue, 31 Mar 2020 16:57:36 -0400
Message-Id: <20200331205740.135525-4-lyude@redhat.com>
In-Reply-To: <20200331205740.135525-1-lyude@redhat.com>
References: <20200331205740.135525-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can already trace the creation and destruction of connectors using
DRM, and we definitely don't need to be printing info messages on
connector hotplugs as well. So, get rid of these.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 09025ccc68ca..d56b758bcce5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -433,13 +433,8 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_m=
gr *mgr,
 	 */
 	amdgpu_dm_connector_funcs_reset(connector);
=20
-	DRM_INFO("DM_MST: added connector: %p [id: %d] [master: %p]\n",
-		 aconnector, connector->base.id, aconnector->mst_port);
-
 	drm_dp_mst_get_port_malloc(port);
=20
-	DRM_DEBUG_KMS(":%d\n", connector->base.id);
-
 	return connector;
 }
=20
--=20
2.25.1

