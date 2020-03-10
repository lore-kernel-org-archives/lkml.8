Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B37C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F492208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuYlaXcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgCJSye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:54:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21614 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726315AbgCJSyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583866472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tfWAqDJSy2TS3rSjSPeoUBDDQXeAXUxi8vtSix20tLo=;
        b=XuYlaXcjDe2vduMp2NFc6aGUDLmpDzmrKahWcaQQxh78sBN+uT4uf2QTMKLAQRO04AmaY4
        9MSmsosxLr2tWWcIAIYeUJzK8WrQRqK6P8oqm6n7CMrunlBnhf7NQv2Z1dIfnpBPM8d0Ae
        KjVOon3AXkiUvcqHFaWAgFh7zTvwrDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-fDJ7kBknPIC-hVHXFnedTQ-1; Tue, 10 Mar 2020 14:54:30 -0400
X-MC-Unique: fDJ7kBknPIC-hVHXFnedTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 273B618C35A0;
        Tue, 10 Mar 2020 18:54:28 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A6E673865;
        Tue, 10 Mar 2020 18:54:26 +0000 (UTC)
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
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915/mst: Hookup DRM DP MST late_register/early_unregister callbacks
Date:   Tue, 10 Mar 2020 14:54:16 -0400
Message-Id: <20200310185417.1588984-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i915 can enable aux device nodes for DP MST by calling
drm_dp_mst_connector_late_register()/drm_dp_mst_connector_early_unregiste=
r(),
so let's hook that up.

Changes since v1:
* Call intel_connector_register/unregister() from
  intel_dp_mst_connector_late_register/unregister() so we don't lose
  error injection - Ville Syrj=C3=A4l=C3=A4

Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: "Lee, Shawn C" <shawn.c.lee@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 28 +++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
index d53978ed3c12..9311c10f5b1b 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -548,12 +548,36 @@ static int intel_dp_mst_get_ddc_modes(struct drm_co=
nnector *connector)
 	return ret;
 }
=20
+static int
+intel_dp_mst_connector_late_register(struct drm_connector *connector)
+{
+	struct intel_connector *intel_connector =3D to_intel_connector(connecto=
r);
+	int ret;
+
+	ret =3D drm_dp_mst_connector_late_register(connector,
+						 intel_connector->port);
+	if (ret < 0)
+		return ret;
+
+	return intel_connector_register(connector);
+}
+
+static void
+intel_dp_mst_connector_early_unregister(struct drm_connector *connector)
+{
+	struct intel_connector *intel_connector =3D to_intel_connector(connecto=
r);
+
+	intel_connector_unregister(connector);
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

