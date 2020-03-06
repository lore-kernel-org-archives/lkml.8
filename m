Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB07AC10F26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9401F206D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iq3SToaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCFXql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:46:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39115 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726674AbgCFXqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583538397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9RmJSlccTvU8mlTIA7x4XcUPMjO0l6ilMljMhGOAI5Y=;
        b=Iq3SToaBJYhURgkbJTeXcocE6EXXAaUvjZ+CMNCgTljf9gwKz66NXcQWEHc6HXVNfd3nEZ
        vdoUI7y6/n4N2w4UWdvRPYynPJmnELsfCArANOS0eRn6w9z+ROEPl7R0A96AdwbICM6NuZ
        2fDdyW+S0uRlbTn0h+dqnE0Vyqw5CFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-jFjZfsLLPRyCTGmH_Adl-Q-1; Fri, 06 Mar 2020 18:46:35 -0500
X-MC-Unique: jFjZfsLLPRyCTGmH_Adl-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 125C8800053;
        Fri,  6 Mar 2020 23:46:34 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F02487389A;
        Fri,  6 Mar 2020 23:46:32 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Mikita Lipski <mikita.lipski@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] drm/dp_mst: Reprobe path resources in CSN handler
Date:   Fri,  6 Mar 2020 18:46:21 -0500
Message-Id: <20200306234623.547525-4-lyude@redhat.com>
In-Reply-To: <20200306234623.547525-1-lyude@redhat.com>
References: <20200306234623.547525-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to punt off reprobing path resources to the link address probe
work, but now that we handle CSNs asynchronously from the driver's HPD
handling we can do whatever the heck we want from the CSN!

So, reprobe the path resources from drm_dp_mst_handle_conn_stat(). Also,
get rid of the path resource reprobing code in
drm_dp_check_and_send_link_address() since it's needlessly complicated
when we already reprobe path resources from
drm_dp_handle_link_address_port(). And finally, teach
drm_dp_send_enum_path_resources() to return 1 on PBN changes so we know
if we need to send another hotplug or not.

This fixes issues where we've indicated to userspace that a port has
just been connected, before we actually probed it's available PBN -
something that results in unexpected atomic check failures.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: cd82d82cbc04 ("drm/dp_mst: Add branch bandwidth validation to MST =
atomic check")
Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 48 ++++++++++++++-------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 79ebb871230b..b81ad444c24f 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2299,12 +2299,16 @@ drm_dp_mst_handle_link_address_port(struct drm_dp=
_mst_branch *mstb,
 		mutex_unlock(&mgr->lock);
 	}
=20
-	if (old_ddps !=3D port->ddps) {
-		if (port->ddps) {
-			if (!port->input) {
-				drm_dp_send_enum_path_resources(mgr, mstb,
-								port);
-			}
+	/*
+	 * Reprobe PBN caps on both hotplug, and when re-probing the link
+	 * for our parent mstb
+	 */
+	if (old_ddps !=3D port->ddps || !created) {
+		if (port->ddps && !port->input) {
+			ret =3D drm_dp_send_enum_path_resources(mgr, mstb,
+							      port);
+			if (ret =3D=3D 1)
+				changed =3D true;
 		} else {
 			port->full_pbn =3D 0;
 		}
@@ -2398,11 +2402,10 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_bra=
nch *mstb,
 	port->ddps =3D conn_stat->displayport_device_plug_status;
=20
 	if (old_ddps !=3D port->ddps) {
-		if (port->ddps) {
-			dowork =3D true;
-		} else {
+		if (port->ddps && !port->input)
+			drm_dp_send_enum_path_resources(mgr, mstb, port);
+		else
 			port->full_pbn =3D 0;
-		}
 	}
=20
 	new_pdt =3D port->input ? DP_PEER_DEVICE_NONE : conn_stat->peer_device_=
type;
@@ -2553,13 +2556,6 @@ static int drm_dp_check_and_send_link_address(stru=
ct drm_dp_mst_topology_mgr *mg
 		if (port->input || !port->ddps)
 			continue;
=20
-		if (!port->full_pbn) {
-			drm_modeset_lock(&mgr->base.lock, NULL);
-			drm_dp_send_enum_path_resources(mgr, mstb, port);
-			drm_modeset_unlock(&mgr->base.lock);
-			changed =3D true;
-		}
-
 		if (port->mstb)
 			mstb_child =3D drm_dp_mst_topology_get_mstb_validated(
 			    mgr, port->mstb);
@@ -2987,6 +2983,7 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_t=
opology_mgr *mgr,
=20
 	ret =3D drm_dp_mst_wait_tx_reply(mstb, txmsg);
 	if (ret > 0) {
+		ret =3D 0;
 		path_res =3D &txmsg->reply.u.path_resources;
=20
 		if (txmsg->reply.reply_type =3D=3D DP_SIDEBAND_REPLY_NAK) {
@@ -2999,13 +2996,22 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst=
_topology_mgr *mgr,
 				      path_res->port_number,
 				      path_res->full_payload_bw_number,
 				      path_res->avail_payload_bw_number);
+
+			/*
+			 * If something changed, make sure we send a
+			 * hotplug
+			 */
+			if (port->full_pbn !=3D path_res->full_payload_bw_number ||
+			    port->fec_capable !=3D path_res->fec_capable)
+				ret =3D 1;
+
 			port->full_pbn =3D path_res->full_payload_bw_number;
 			port->fec_capable =3D path_res->fec_capable;
 		}
 	}
=20
 	kfree(txmsg);
-	return 0;
+	return ret;
 }
=20
 static struct drm_dp_mst_port *drm_dp_get_last_connected_port_to_mstb(st=
ruct drm_dp_mst_branch *mstb)
@@ -3582,13 +3588,9 @@ drm_dp_mst_topology_mgr_invalidate_mstb(struct drm=
_dp_mst_branch *mstb)
 	/* The link address will need to be re-sent on resume */
 	mstb->link_address_sent =3D false;
=20
-	list_for_each_entry(port, &mstb->ports, next) {
-		/* The PBN for each port will also need to be re-probed */
-		port->full_pbn =3D 0;
-
+	list_for_each_entry(port, &mstb->ports, next)
 		if (port->mstb)
 			drm_dp_mst_topology_mgr_invalidate_mstb(port->mstb);
-	}
 }
=20
 /**
--=20
2.24.1

