Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA701C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5BE20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JR3GeYwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCJS3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:29:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37866 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbgCJS3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583864948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kG5+PQP3ksQc5cU9/4J1Z7ERE0FS8MynHoBNfI6/fdw=;
        b=JR3GeYwg9z7Q1G+ZB7XX8EzYF/EW5uSUfny8yFJh6H2dwh1mrdKMr4EUD6sIpt1BoE4APU
        hq7tB5ErUdCBwV/wL5cuOBBJWi1mwUJTI2sXPpeGt72usrx446c/5b/bUCl83rSjOUBFma
        27Omul1i01aBlWHcp31mAdDP193Hahk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-l4peUl40OXeRVkokqsvQiA-1; Tue, 10 Mar 2020 14:29:04 -0400
X-MC-Unique: l4peUl40OXeRVkokqsvQiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDD5F800D4E;
        Tue, 10 Mar 2020 18:29:01 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D11C5D9CA;
        Tue, 10 Mar 2020 18:28:59 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        "Lee, Shawn C" <shawn.c.lee@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/mst: Hookup DRM DP MST late_register/early_unregister callbacks
Date:   Tue, 10 Mar 2020 14:28:54 -0400
Message-Id: <20200310182856.1587752-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i915 can enable aux device nodes for DP MST by calling
drm_dp_mst_connector_late_register()/drm_dp_mst_connector_early_unregiste=
r(),
so let's hook that up.

Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: "Lee, Shawn C" <shawn.c.lee@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 22 +++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
index d53978ed3c12..bcff2e06ead6 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -548,12 +548,30 @@ static int intel_dp_mst_get_ddc_modes(struct drm_co=
nnector *connector)
 	return ret;
 }
=20
+static int
+intel_dp_mst_connector_late_register(struct drm_connector *connector)
+{
+	struct intel_connector *intel_connector =3D to_intel_connector(connecto=
r);
+
+	return drm_dp_mst_connector_late_register(connector,
+						  intel_connector->port);
+}
+
+static void
+intel_dp_mst_connector_early_unregister(struct drm_connector *connector)
+{
+	struct intel_connector *intel_connector =3D to_intel_connector(connecto=
r);
+
+	drm_dp_mst_connector_early_unregister(connector,
+					      intel_connector->port);
+}
+
 static const struct drm_connector_funcs intel_dp_mst_connector_funcs =3D=
 {
 	.fill_modes =3D drm_helper_probe_single_connector_modes,
 	.atomic_get_property =3D intel_digital_connector_atomic_get_property,
 	.atomic_set_property =3D intel_digital_connector_atomic_set_property,
-	.late_register =3D intel_connector_register,
-	.early_unregister =3D intel_connector_unregister,
+	.late_register =3D intel_dp_mst_connector_late_register,
+	.early_unregister =3D intel_dp_mst_connector_early_unregister,
 	.destroy =3D intel_connector_destroy,
 	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state =3D intel_digital_connector_duplicate_state,
--=20
2.24.1

