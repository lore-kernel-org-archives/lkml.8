Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91378C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697C0206D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xl0QCpoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCFXqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:46:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32911 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726231AbgCFXqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583538396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lTUrg/boY4FBmBAf+w0ggxQJvpm8pYpnAaBMDLRjV3g=;
        b=Xl0QCpoGz9OkmMWwylALkQQeeem6tyv3/eROIh+MBWhJUieqRl2IWMfggnC7wQNJFs8gPY
        vDu+nG+/6vetfSSw5HUvU8lDLmdjv4oFbuj2swqytvg1kNmPd7RaQG+meT7Vxvu2qOpFxv
        MtiwVdpqTwwoXy/N4lWFH+TqDKZVdTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-Nvi-WvJDP-Wy3L08tQTKLw-1; Fri, 06 Mar 2020 18:46:32 -0500
X-MC-Unique: Nvi-WvJDP-Wy3L08tQTKLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21CE713F7;
        Fri,  6 Mar 2020 23:46:31 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1BCF73873;
        Fri,  6 Mar 2020 23:46:29 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Mikita Lipski <mikita.lipski@amd.com>,
        Sean Paul <seanpaul@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] drm/dp_mst: Rename drm_dp_mst_is_dp_mst_end_device() to be less redundant
Date:   Fri,  6 Mar 2020 18:46:19 -0500
Message-Id: <20200306234623.547525-2-lyude@redhat.com>
In-Reply-To: <20200306234623.547525-1-lyude@redhat.com>
References: <20200306234623.547525-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's already prefixed by dp_mst, so we don't really need to repeat
ourselves here. One of the changes I should have picked up originally
when reviewing MST DSC support.

There should be no functional changes here

Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Sean Paul <seanpaul@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 6c62ad8f4414..6714d8a5c558 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1937,7 +1937,7 @@ static u8 drm_dp_calculate_rad(struct drm_dp_mst_po=
rt *port,
 	return parent_lct + 1;
 }
=20
-static bool drm_dp_mst_is_dp_mst_end_device(u8 pdt, bool mcs)
+static bool drm_dp_mst_is_end_device(u8 pdt, bool mcs)
 {
 	switch (pdt) {
 	case DP_PEER_DEVICE_DP_LEGACY_CONV:
@@ -1967,13 +1967,13 @@ drm_dp_port_set_pdt(struct drm_dp_mst_port *port,=
 u8 new_pdt,
=20
 	/* Teardown the old pdt, if there is one */
 	if (port->pdt !=3D DP_PEER_DEVICE_NONE) {
-		if (drm_dp_mst_is_dp_mst_end_device(port->pdt, port->mcs)) {
+		if (drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
 			/*
 			 * If the new PDT would also have an i2c bus,
 			 * don't bother with reregistering it
 			 */
 			if (new_pdt !=3D DP_PEER_DEVICE_NONE &&
-			    drm_dp_mst_is_dp_mst_end_device(new_pdt, new_mcs)) {
+			    drm_dp_mst_is_end_device(new_pdt, new_mcs)) {
 				port->pdt =3D new_pdt;
 				port->mcs =3D new_mcs;
 				return 0;
@@ -1993,7 +1993,7 @@ drm_dp_port_set_pdt(struct drm_dp_mst_port *port, u=
8 new_pdt,
 	port->mcs =3D new_mcs;
=20
 	if (port->pdt !=3D DP_PEER_DEVICE_NONE) {
-		if (drm_dp_mst_is_dp_mst_end_device(port->pdt, port->mcs)) {
+		if (drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
 			/* add i2c over sideband */
 			ret =3D drm_dp_mst_register_i2c_bus(&port->aux);
 		} else {
@@ -2169,7 +2169,7 @@ drm_dp_mst_port_add_connector(struct drm_dp_mst_bra=
nch *mstb,
 	}
=20
 	if (port->pdt !=3D DP_PEER_DEVICE_NONE &&
-	    drm_dp_mst_is_dp_mst_end_device(port->pdt, port->mcs)) {
+	    drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
 		port->cached_edid =3D drm_get_edid(port->connector,
 						 &port->aux.ddc);
 		drm_connector_set_tile_property(port->connector);
--=20
2.24.1

