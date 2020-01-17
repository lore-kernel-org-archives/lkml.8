Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0590C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0CC2464B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOxaEJbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgAQWsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:48:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35462 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726975AbgAQWsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579301280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hEreOJSuBCTx2oP66raYQVfUU+2kOiqBdBJ+OggsyuA=;
        b=jOxaEJbj0fjeqNrJ6aT99+jpDgj5xZjD9hvntDYCZNN4rOeCY3+Gl+cK4xgB3GQBStAnQR
        pArJ62HaTNjbxZbLc3aHnBRQdWBxgamJTKWzGF1Obn2i0xRbZFAadqGHoENScQw6uwx8hy
        1Su5tl0D8j2qnA0spRa6MGFtB11EYiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-7wTFAP3gPre9UXcLsWG6bQ-1; Fri, 17 Jan 2020 17:47:59 -0500
X-MC-Unique: 7wTFAP3gPre9UXcLsWG6bQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A5FEDB64;
        Fri, 17 Jan 2020 22:47:57 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AED005DA32;
        Fri, 17 Jan 2020 22:47:53 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/dp_mst: Fix indenting in drm_dp_mst_topology_mgr_set_mst()
Date:   Fri, 17 Jan 2020 17:47:48 -0500
Message-Id: <20200117224749.128994-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has always bugged me but somehow I've never remembered to actually
fix it. So let's do that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 8fd85a33ed1b..89c2a7505cbd 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3521,7 +3521,9 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_m=
st_topology_mgr *mgr, bool ms
 		drm_dp_mst_topology_get_mstb(mgr->mst_primary);
=20
 		ret =3D drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
-							 DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
+					 DP_MST_EN |
+					 DP_UP_REQ_EN |
+					 DP_UPSTREAM_IS_SRC);
 		if (ret < 0)
 			goto out_unlock;
=20
--=20
2.24.1

