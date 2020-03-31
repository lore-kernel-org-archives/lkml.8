Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4689EC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BD020BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fM8E2cfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgCaU6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:58:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26435 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbgCaU6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585688282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPyLCEva4DWYdYHhnQT+EM7KXWL0IAHW//2poJNhujY=;
        b=fM8E2cfkatQ696fkz1ZoFvtlA+TEVMmVfji2Ijk9Ne4aTZ6y5T5YvPJAvRFhP2CF7zteBz
        YOyUKJJ7mOXZ37uu6wBnw6cDAwhu82BPAn59SlVw9QbslXqOFUwYlcuz6wKIxkmlyR21lY
        yJTxJzwvfGfXs/Bf68NrgX0GBUkTSgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-NqFd0o_HN22aVI13ZZqAsQ-1; Tue, 31 Mar 2020 16:57:56 -0400
X-MC-Unique: NqFd0o_HN22aVI13ZZqAsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C16D149D0;
        Tue, 31 Mar 2020 20:57:54 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-113-88.rdu2.redhat.com [10.10.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D80F99DE4;
        Tue, 31 Mar 2020 20:57:51 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/amd/amdgpu_dm/mst: Remove ->destroy_connector() callback
Date:   Tue, 31 Mar 2020 16:57:35 -0400
Message-Id: <20200331205740.135525-3-lyude@redhat.com>
In-Reply-To: <20200331205740.135525-1-lyude@redhat.com>
References: <20200331205740.135525-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pankaj Bharadiya started cleaning up the MST connector callbacks a while
ago, as I pointed out that they are the same across every driver and
don't serve much purpose. There was one callback that was left over
though from amdgpu, that we delayed removing due to not being completely
sure as to whether or not it was needed.

So, I've read through said callback and can confirm it's not at all
needed. Pretty much all of the work that is done in
dm_dp_destroy_mst_connector() can be done in
dm_dp_mst_connector_destroy(). Additionally, I've removed some bits that
didn't actually do anything:

* Removed DRM_INFO message we were printing, this shouldn't be info
  level and there's more appropriate drm debugging flags that should be
  used instead
* Removed amdgpu_dm_update_freesync_caps() - reading into this function,
  it doesn't actually do anything important and I'm not sure why it was
  ever being called here
* Stop clearing aconnector->dc_sink - this also doesn't do anything
* Stop clearing link settings in dc_link - this also doesn't do anything
* Also, use shorter variable

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 39 ++++++-------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7b3303efb1ff..09025ccc68ca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -136,16 +136,23 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux=
 *aux,
 static void
 dm_dp_mst_connector_destroy(struct drm_connector *connector)
 {
-	struct amdgpu_dm_connector *amdgpu_dm_connector =3D to_amdgpu_dm_connec=
tor(connector);
-	struct amdgpu_encoder *amdgpu_encoder =3D amdgpu_dm_connector->mst_enco=
der;
+	struct amdgpu_dm_connector *aconnector =3D
+		to_amdgpu_dm_connector(connector);
+	struct amdgpu_encoder *amdgpu_encoder =3D aconnector->mst_encoder;
=20
-	kfree(amdgpu_dm_connector->edid);
+	if (aconnector->dc_sink) {
+		dc_link_remove_remote_sink(aconnector->dc_link,
+					   aconnector->dc_sink);
+		dc_sink_release(aconnector->dc_sink);
+	}
+
+	kfree(aconnector->edid);
=20
 	drm_encoder_cleanup(&amdgpu_encoder->base);
 	kfree(amdgpu_encoder);
 	drm_connector_cleanup(connector);
-	drm_dp_mst_put_port_malloc(amdgpu_dm_connector->port);
-	kfree(amdgpu_dm_connector);
+	drm_dp_mst_put_port_malloc(aconnector->port);
+	kfree(aconnector);
 }
=20
 static int
@@ -436,30 +443,8 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_m=
gr *mgr,
 	return connector;
 }
=20
-static void dm_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *=
mgr,
-					struct drm_connector *connector)
-{
-	struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(conne=
ctor);
-
-	DRM_INFO("DM_MST: Disabling connector: %p [id: %d] [master: %p]\n",
-		 aconnector, connector->base.id, aconnector->mst_port);
-
-	if (aconnector->dc_sink) {
-		amdgpu_dm_update_freesync_caps(connector, NULL);
-		dc_link_remove_remote_sink(aconnector->dc_link,
-					   aconnector->dc_sink);
-		dc_sink_release(aconnector->dc_sink);
-		aconnector->dc_sink =3D NULL;
-		aconnector->dc_link->cur_link_settings.lane_count =3D 0;
-	}
-
-	drm_connector_unregister(connector);
-	drm_connector_put(connector);
-}
-
 static const struct drm_dp_mst_topology_cbs dm_mst_cbs =3D {
 	.add_connector =3D dm_dp_add_mst_connector,
-	.destroy_connector =3D dm_dp_destroy_mst_connector,
 };
=20
 void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm=
,
--=20
2.25.1

