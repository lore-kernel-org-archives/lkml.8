Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F0C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5B02465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+p7OrQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAVTnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:43:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47775 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725827AbgAVTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579722222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5tEuUkKDhsAj/8wgfLzijJY2JLpoVThoT94FD+ztjuA=;
        b=A+p7OrQuEDOIxnUhG2PVzrTcN7HejjrFr2bfUKM19ByTXP9QZQK4tmsHRKcpL6Xq6TkKg2
        URS99DxuU7hlb/NedvG5q8hZBARH/34XPPTxcNL34/yJhM1jNRh1hsK6H/652+aHOgxsto
        bS+OjOs7H0HNx5olP/fnAzayGRdVXZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-nKyCzFggNiS1Ck3kiyDaKg-1; Wed, 22 Jan 2020 14:43:38 -0500
X-MC-Unique: nKyCzFggNiS1Ck3kiyDaKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9547803776;
        Wed, 22 Jan 2020 19:43:35 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB5C219C5B;
        Wed, 22 Jan 2020 19:43:31 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>, Wayne Lin <Wayne.Lin@amd.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/dp_mst: Fix clearing payload state on topology disable
Date:   Wed, 22 Jan 2020 14:43:20 -0500
Message-Id: <20200122194321.14953-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issues caused by:

64e62bdf04ab ("drm/dp_mst: Remove VCPI while disabling topology mgr")

Prompted me to take a closer look at how we clear the payload state in
general when disabling the topology, and it turns out there's actually
two subtle issues here.

The first is that we're not grabbing &mgr.payload_lock when clearing the
payloads in drm_dp_mst_topology_mgr_set_mst(). Seeing as the canonical
lock order is &mgr.payload_lock -> &mgr.lock (because we always want
&mgr.lock to be the inner-most lock so topology validation always
works), this makes perfect sense. It also means that -technically- there
could be racing between someone calling
drm_dp_mst_topology_mgr_set_mst() to disable the topology, along with a
modeset occurring that's modifying the payload state at the same time.

The second is the more obvious issue that Wayne Lin discovered, that
we're not clearing proposed_payloads when disabling the topology.

I actually can't see any obvious places where the racing caused by the
first issue would break something, and it could be that some of our
higher-level locks already prevent this by happenstance, but better safe
then sorry. So, let's make it so that drm_dp_mst_topology_mgr_set_mst()
first grabs &mgr.payload_lock followed by &mgr.lock so that we never
race when modifying the payload state. Then, we also clear
proposed_payloads to fix the original issue of enabling a new topology
with a dirty payload state. This doesn't clear any of the drm_dp_vcpi
structures, but those are getting destroyed along with the ports anyway.

Changes since v1:
* Use sizeof(mgr->payloads[0])/sizeof(mgr->proposed_vcpis[0]) instead -
  vsyrjala

Cc: Sean Paul <sean@poorly.run>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 3649e82b963d..23cf46bfef74 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3501,6 +3501,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_m=
st_topology_mgr *mgr, bool ms
 	int ret =3D 0;
 	struct drm_dp_mst_branch *mstb =3D NULL;
=20
+	mutex_lock(&mgr->payload_lock);
 	mutex_lock(&mgr->lock);
 	if (mst_state =3D=3D mgr->mst_state)
 		goto out_unlock;
@@ -3559,7 +3560,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_=
mst_topology_mgr *mgr, bool ms
 		/* this can fail if the device is gone */
 		drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL, 0);
 		ret =3D 0;
-		memset(mgr->payloads, 0, mgr->max_payloads * sizeof(struct drm_dp_payl=
oad));
+		memset(mgr->payloads, 0,
+		       mgr->max_payloads * sizeof(mgr->payloads[0]));
+		memset(mgr->proposed_vcpis, 0,
+		       mgr->max_payloads * sizeof(mgr->proposed_vcpis[0]));
 		mgr->payload_mask =3D 0;
 		set_bit(0, &mgr->payload_mask);
 		mgr->vcpi_mask =3D 0;
@@ -3568,6 +3572,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_m=
st_topology_mgr *mgr, bool ms
=20
 out_unlock:
 	mutex_unlock(&mgr->lock);
+	mutex_unlock(&mgr->payload_lock);
 	if (mstb)
 		drm_dp_mst_topology_put_mstb(mstb);
 	return ret;
--=20
2.24.1

