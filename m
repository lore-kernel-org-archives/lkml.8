Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D2BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2D620709
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQIXSOMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCFXtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:49:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36706 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgCFXtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583538572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77mV7dMChSrLWq5rIbMFOAlvL63d0ZbvZ9seihNouTU=;
        b=JQIXSOMhPJgYyH558fmTXQI6gBk4bVfqnCZ5KRYOK+mPzl6t8ht+Rdd1T7RyncyOj5eSwZ
        dxyvF5rv/yTJzhi+kaMQOURlDCljNfj9oWlD+bLyLeRCaMgkJGGzM9QGWL+2hywoGCpGRD
        aLAqtCSHdJ6iH7srJpA3vabWjU2U1/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-G7T3Kw1sPsy-SN61B098Vw-1; Fri, 06 Mar 2020 18:49:30 -0500
X-MC-Unique: G7T3Kw1sPsy-SN61B098Vw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FBA51005509;
        Fri,  6 Mar 2020 23:49:29 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D58591D9D;
        Fri,  6 Mar 2020 23:49:28 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Sean Paul <sean@poorly.run>,
        Hans de Goede <hdegoede@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/dp_mst: Fix drm_dp_check_mstb_guid() return code
Date:   Fri,  6 Mar 2020 18:49:22 -0500
Message-Id: <20200306234923.547873-3-lyude@redhat.com>
In-Reply-To: <20200306234923.547873-1-lyude@redhat.com>
References: <20200306234923.547873-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We actually expect this to return a 0 on success, or negative error code
on failure. In order to do that, we check whether or not we managed to
write the whole GUID and then return 0 if so, otherwise return a
negative error code. Also, let's add an error message here so it's a
little more obvious when this fails in the middle of a link address
probe.

This should fix issues with certain MST hubs seemingly stopping for no
reason in the middle of the link address probe process.

Fixes: cb897542c6d2 ("drm/dp_mst: Fix W=3D1 warnings")
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index e421c2d13267..b2ec6e8634ed 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2092,7 +2092,10 @@ static int drm_dp_check_mstb_guid(struct drm_dp_ms=
t_branch *mstb, u8 *guid)
 		}
 	}
=20
-	return ret;
+	if (ret < 16 && ret > 0)
+		return -EPROTO;
+
+	return ret =3D=3D 16 ? 0 : ret;
 }
=20
 static void build_mst_prop_path(const struct drm_dp_mst_branch *mstb,
@@ -2907,8 +2910,14 @@ static int drm_dp_send_link_address(struct drm_dp_=
mst_topology_mgr *mgr,
 	drm_dp_dump_link_address(reply);
=20
 	ret =3D drm_dp_check_mstb_guid(mstb, reply->guid);
-	if (ret)
+	if (ret) {
+		char buf[64];
+
+		drm_dp_mst_rad_to_str(mstb->rad, mstb->lct, buf, sizeof(buf));
+		DRM_ERROR("GUID check on %s failed: %d\n",
+			  buf, ret);
 		goto out;
+	}
=20
 	for (i =3D 0; i < reply->nports; i++) {
 		port_mask |=3D BIT(reply->ports[i].port_number);
--=20
2.24.1

