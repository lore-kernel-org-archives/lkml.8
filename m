Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB93BC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC8C206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMMrnf6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgDCUIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:08:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42151 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgDCUIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585944493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7uc0abaBqg3jPG1aiHeqKdJXYGxUjBqIactIjvdhvw=;
        b=PMMrnf6D+Tq5U9Bp3/eB9b5coy3aBw8wQbNT8FnblILsdo+kq3fi7FwVKNrb1IH3AitXye
        oBL5vxsfVpfdMqs5KVH4YcspaMOvf4BTOEte4x9XS1sBoOHif4ZsZyOGHWuX9FRMSPaIit
        QPBpPI9ksj2KnREM/h66Cvt64P0omnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-nDPF8ENjP6myDwElzna6ag-1; Fri, 03 Apr 2020 16:08:11 -0400
X-MC-Unique: nDPF8ENjP6myDwElzna6ag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8B9D801A00;
        Fri,  3 Apr 2020 20:08:09 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-117-203.rdu2.redhat.com [10.10.117.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 916095C28F;
        Fri,  3 Apr 2020 20:08:06 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>, stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Todd Previte <tprevite@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/dp_mst: Reformat drm_dp_check_act_status() a bit
Date:   Fri,  3 Apr 2020 16:07:54 -0400
Message-Id: <20200403200757.886443-3-lyude@redhat.com>
In-Reply-To: <20200403200757.886443-1-lyude@redhat.com>
References: <20200403200757.886443-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just add a bit more line wrapping, get rid of some extraneous
whitespace, remove an unneeded goto label, and move around some variable
declarations. No functional changes here.

Signed-off-by: Lyude Paul <lyude@redhat.com>
[this isn't a fix, but it's needed for the fix that comes after this]
Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0=
.6)")
Cc: Sean Paul <sean@poorly.run>
Cc: <stable@vger.kernel.org> # v3.17+
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 2b9ce965f044..7aaf184a2e5f 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4473,33 +4473,31 @@ static int drm_dp_dpcd_write_payload(struct drm_d=
p_mst_topology_mgr *mgr,
  */
 int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
 {
+	int count =3D 0, ret;
 	u8 status;
-	int ret;
-	int count =3D 0;
=20
 	do {
-		ret =3D drm_dp_dpcd_readb(mgr->aux, DP_PAYLOAD_TABLE_UPDATE_STATUS, &s=
tatus);
-
+		ret =3D drm_dp_dpcd_readb(mgr->aux,
+					DP_PAYLOAD_TABLE_UPDATE_STATUS,
+					&status);
 		if (ret < 0) {
-			DRM_DEBUG_KMS("failed to read payload table status %d\n", ret);
-			goto fail;
+			DRM_DEBUG_KMS("failed to read payload table status %d\n",
+				      ret);
+			return ret;
 		}
=20
 		if (status & DP_PAYLOAD_ACT_HANDLED)
 			break;
 		count++;
 		udelay(100);
-
 	} while (count < 30);
=20
 	if (!(status & DP_PAYLOAD_ACT_HANDLED)) {
-		DRM_DEBUG_KMS("failed to get ACT bit %d after %d retries\n", status, c=
ount);
-		ret =3D -EINVAL;
-		goto fail;
+		DRM_DEBUG_KMS("failed to get ACT bit %d after %d retries\n",
+			      status, count);
+		return -EINVAL;
 	}
 	return 0;
-fail:
-	return ret;
 }
 EXPORT_SYMBOL(drm_dp_check_act_status);
=20
--=20
2.25.1

