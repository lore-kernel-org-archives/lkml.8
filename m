Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC77C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF3520714
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foron7Oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgCRAEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:04:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51592 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbgCRAEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584489869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HQPIeCdfVTClx20kgdMHYVnwS6rUV5YZEErwS5TMOy0=;
        b=foron7OahQbSKi8svkIO7c/2AxO70MtwpeQYYREnJF2qbFrQO838ucOHF7z4UMycW7+MiK
        MjwTflxVxw6JilIYE8IBqMRGMCQH0j5AIX654s26ve52k+/m4UF8yCx/ih8DWmETIpBtNW
        Pp/c0YGQCQSV8ILqtCEsDHVabYDi8PY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-jVmTE72rP-2ACgXwWWjQYg-1; Tue, 17 Mar 2020 20:04:28 -0400
X-MC-Unique: jVmTE72rP-2ACgXwWWjQYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C398800D50;
        Wed, 18 Mar 2020 00:04:26 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-113-173.rdu2.redhat.com [10.10.113.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 660F55D9E2;
        Wed, 18 Mar 2020 00:04:25 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/nouveau/connector: Fix indenting in nouveau_connector_detect()
Date:   Tue, 17 Mar 2020 20:04:22 -0400
Message-Id: <20200318000423.205005-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
index 9a9a7f5003d3..0d42a7e5deff 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -582,7 +582,7 @@ nouveau_connector_detect(struct drm_connector *connec=
tor, bool force)
 			nv_connector->edid =3D drm_get_edid(connector, i2c);
=20
 		drm_connector_update_edid_property(connector,
-							nv_connector->edid);
+						   nv_connector->edid);
 		if (!nv_connector->edid) {
 			NV_ERROR(drm, "DDC responded, but no EDID for %s\n",
 				 connector->name);
@@ -635,7 +635,7 @@ nouveau_connector_detect(struct drm_connector *connec=
tor, bool force)
 						encoder->helper_private;
=20
 		if (helper->detect(encoder, connector) =3D=3D
-						connector_status_connected) {
+		    connector_status_connected) {
 			nouveau_connector_set_encoder(connector, nv_encoder);
 			conn_status =3D connector_status_connected;
 			goto out;
--=20
2.24.1

