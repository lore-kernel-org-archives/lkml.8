Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65DCC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904A4206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+UqotWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCFXqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:46:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26665 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726635AbgCFXqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583538396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAsFUhVug5fJyJAMadtYHV3EUxQSrSAlUDGJD5b20xc=;
        b=F+UqotWq85CPbyjEt7BnzvsxGKRqVsoei8lxQ3Kt1T6KNp3EQdt7wmqZzCWSOYJwGvrkVT
        ZaCZa4ewVOuZ4vfE9Y/7Y1RaJjiUJKY/TxSpOeXsvgMlMiro9hqWsecGc5t0pormMzhogw
        LoECT+FtwVuytQlQyVTU/42LgX8dxHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-N_Oni4haN3W_mIZi2XWErw-1; Fri, 06 Mar 2020 18:46:34 -0500
X-MC-Unique: N_Oni4haN3W_mIZi2XWErw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5B44800D4E;
        Fri,  6 Mar 2020 23:46:32 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72D6373873;
        Fri,  6 Mar 2020 23:46:31 +0000 (UTC)
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
Subject: [PATCH v2 2/4] drm/dp_mst: Use full_pbn instead of available_pbn for bandwidth checks
Date:   Fri,  6 Mar 2020 18:46:20 -0500
Message-Id: <20200306234623.547525-3-lyude@redhat.com>
In-Reply-To: <20200306234623.547525-1-lyude@redhat.com>
References: <20200306234623.547525-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DisplayPort specifications are fun. For a while, it's been really
unclear to us what available_pbn actually does. There's a somewhat vague
explanation in the DisplayPort spec (starting from 1.2) that partially
explains it:

  The minimum payload bandwidth number supported by the path. Each node
  updates this number with its available payload bandwidth number if its
  payload bandwidth number is less than that in the Message Transaction
  reply.

So, it sounds like available_pbn represents the smallest link rate in
use between the source and the branch device. Cool, so full_pbn is just
the highest possible PBN that the branch device supports right?

Well, we assumed that for quite a while until Sean Paul noticed that on
some MST hubs, available_pbn will actually get set to 0 whenever there's
any active payloads on the respective branch device. This caused quite a
bit of confusion since clearing the payload ID table would end up fixing
the available_pbn value.

So, we just went with that until commit cd82d82cbc04 ("drm/dp_mst: Add
branch bandwidth validation to MST atomic check") started breaking
people's setups due to us getting erroneous available_pbn values. So, we
did some more digging and got confused until we finally looked at the
definition for full_pbn:

  The bandwidth of the link at the trained link rate and lane count
  between the DP Source device and the DP Sink device with no time slots
  allocated to VC Payloads, represented as a Payload Bandwidth Number. As
  with the Available_Payload_Bandwidth_Number, this number is determined
  by the link with the lowest lane count and link rate.

That's what we get for not reading specs closely enough, hehe. So, since
full_pbn is definitely what we want for doing bandwidth restriction
checks - let's start using that instead and ignore available_pbn
entirely.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: cd82d82cbc04 ("drm/dp_mst: Add branch bandwidth validation to MST =
atomic check")
Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 15 +++++++--------
 include/drm/drm_dp_mst_helper.h       |  4 ++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 6714d8a5c558..79ebb871230b 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2306,7 +2306,7 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_m=
st_branch *mstb,
 								port);
 			}
 		} else {
-			port->available_pbn =3D 0;
+			port->full_pbn =3D 0;
 		}
 	}
=20
@@ -2401,7 +2401,7 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branc=
h *mstb,
 		if (port->ddps) {
 			dowork =3D true;
 		} else {
-			port->available_pbn =3D 0;
+			port->full_pbn =3D 0;
 		}
 	}
=20
@@ -2553,7 +2553,7 @@ static int drm_dp_check_and_send_link_address(struc=
t drm_dp_mst_topology_mgr *mg
 		if (port->input || !port->ddps)
 			continue;
=20
-		if (!port->available_pbn) {
+		if (!port->full_pbn) {
 			drm_modeset_lock(&mgr->base.lock, NULL);
 			drm_dp_send_enum_path_resources(mgr, mstb, port);
 			drm_modeset_unlock(&mgr->base.lock);
@@ -2999,8 +2999,7 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_t=
opology_mgr *mgr,
 				      path_res->port_number,
 				      path_res->full_payload_bw_number,
 				      path_res->avail_payload_bw_number);
-			port->available_pbn =3D
-				path_res->avail_payload_bw_number;
+			port->full_pbn =3D path_res->full_payload_bw_number;
 			port->fec_capable =3D path_res->fec_capable;
 		}
 	}
@@ -3585,7 +3584,7 @@ drm_dp_mst_topology_mgr_invalidate_mstb(struct drm_=
dp_mst_branch *mstb)
=20
 	list_for_each_entry(port, &mstb->ports, next) {
 		/* The PBN for each port will also need to be re-probed */
-		port->available_pbn =3D 0;
+		port->full_pbn =3D 0;
=20
 		if (port->mstb)
 			drm_dp_mst_topology_mgr_invalidate_mstb(port->mstb);
@@ -4853,8 +4852,8 @@ int drm_dp_mst_atomic_check_bw_limit(struct drm_dp_=
mst_branch *branch,
 			if (drm_dp_mst_atomic_check_bw_limit(port->mstb, mst_state))
 				return -ENOSPC;
=20
-		if (port->available_pbn > 0)
-			pbn_limit =3D port->available_pbn;
+		if (port->full_pbn > 0)
+			pbn_limit =3D port->full_pbn;
 	}
 	DRM_DEBUG_ATOMIC("[MST BRANCH:%p] branch has %d PBN available\n",
 			 branch, pbn_limit);
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_hel=
per.h
index 5483f888712a..1d4c996cb92d 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -81,7 +81,7 @@ struct drm_dp_vcpi {
  * &drm_dp_mst_topology_mgr.base.lock.
  * @num_sdp_stream_sinks: Number of stream sinks. Protected by
  * &drm_dp_mst_topology_mgr.base.lock.
- * @available_pbn: Available bandwidth for this port. Protected by
+ * @full_pbn: Max possible bandwidth for this port. Protected by
  * &drm_dp_mst_topology_mgr.base.lock.
  * @next: link to next port on this branch device
  * @aux: i2c aux transport to talk to device connected to this port, pro=
tected
@@ -126,7 +126,7 @@ struct drm_dp_mst_port {
 	u8 dpcd_rev;
 	u8 num_sdp_streams;
 	u8 num_sdp_stream_sinks;
-	uint16_t available_pbn;
+	uint16_t full_pbn;
 	struct list_head next;
 	/**
 	 * @mstb: the branch device connected to this port, if there is one.
--=20
2.24.1

