Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87852C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB342078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgH0FbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:31:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37744 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgH0FbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:31:00 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1kBAUz-0004Xq-NR
        for linux-kernel@vger.kernel.org; Thu, 27 Aug 2020 05:30:57 +0000
Received: by mail-pf1-f200.google.com with SMTP id d3so3237292pfh.17
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 22:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bf2rqF6BAK5D4hPugV7d7delD8442g8W9XT02V7+aCE=;
        b=PuYnjnBGxN31Y7RHLxJ00wEa0a8g+wYqQ3s8BQXE6Zc7q5DrWnbxFuRv0OkMd3XHOb
         My2LWb/5lxnlD20DQNgBT3uoLJQQUfNLahGlr5IbCY87tYog8r73ZEzG1Ne+8t1m/16Z
         vntkKqSMVTdcIPTB4nnzNuS/UM3sJ+S5zWAV7LUbfEt9f+avPH0jK2e8zcaKaaCTw7yo
         phW7JZmEfOa8TLjQ8UAUMfa0JCmH1FRrsY6RYzV1I0f0vWeWWWhTPOlUf14J1eBrJGOa
         3brRT9a3VjrgfnqU/kV7LBNOnVbG68sDeak8e6lX4PQSPTDtreX5erCgn5lTkFBqS1Ff
         uuBQ==
X-Gm-Message-State: AOAM53027v6opbEzEEskUNEISTLZFFL8UopVMttyBNNG6JUauPFHS9de
        mZTo7CRFmh1zhNVY3WgriHqQrRUQe3sLSaNcwQrJn3fjsBvISWo6X+D3GL3wxRxRXgVj3D1dOwT
        JdVjLbeZnQ+5YkB73f+kL786IvXmrhk5LjnS+EOPTGw==
X-Received: by 2002:a63:af47:: with SMTP id s7mr13687768pgo.335.1598506256182;
        Wed, 26 Aug 2020 22:30:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqTU9o5RiGepVidVskRAeoiz/nKhzhE7ecXbU0gvHzio5d3WOpAq9QOlQgyA8tcBUo/I2/rg==
X-Received: by 2002:a63:af47:: with SMTP id s7mr13687753pgo.335.1598506255857;
        Wed, 26 Aug 2020 22:30:55 -0700 (PDT)
Received: from canonical.com (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id n68sm1000195pfn.145.2020.08.26.22.30.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Aug 2020 22:30:55 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     anthony.wong@canonical.com
Subject: [PATCH] drm/dp: For MST hub, Get max_link_rate&max_lane from extended rx capability field if EXTENDED_RECEIVER_CAPABILITY_FILED_PRESENT is set.
Date:   Thu, 27 Aug 2020 13:30:53 +0800
Message-Id: <20200827053053.11271-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, DRM get the capability of the mst hub only from DP_DPCD_REV and
get the slower speed even the mst hub can run in the faster speed.

As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1, read the DP_DP13_DPCD_REV to
get the faster capability.
If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0, read DP_DPCD_REV.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 67dd72ea200e..3b84c6801281 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3497,6 +3497,8 @@ static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, u8  dp_link_count)
 int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool mst_state)
 {
 	int ret = 0;
+	u8 dpcd_ext = 0;
+	unsigned int dpcd_offset = 0;
 	struct drm_dp_mst_branch *mstb = NULL;
 
 	mutex_lock(&mgr->payload_lock);
@@ -3510,9 +3512,15 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		struct drm_dp_payload reset_pay;
 
 		WARN_ON(mgr->mst_primary);
+		drm_dp_dpcd_read(mgr->aux,
+				 DP_TRAINING_AUX_RD_INTERVAL,
+				 &dpcd_ext, sizeof(dpcd_ext));
+
+		dpcd_offset =
+			((dpcd_ext & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT) ?  DP_DP13_DPCD_REV : DP_DPCD_REV);
 
 		/* get dpcd info */
-		ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd, DP_RECEIVER_CAP_SIZE);
+		ret = drm_dp_dpcd_read(mgr->aux, dpcd_offset, mgr->dpcd, DP_RECEIVER_CAP_SIZE);
 		if (ret != DP_RECEIVER_CAP_SIZE) {
 			DRM_DEBUG_KMS("failed to read DPCD\n");
 			goto out_unlock;
-- 
2.25.1

