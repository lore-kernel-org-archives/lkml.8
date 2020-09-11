Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8239C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B5721D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgIKDol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:44:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52194 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIKDoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:44:38 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1kGZzG-0008DT-Uj
        for linux-kernel@vger.kernel.org; Fri, 11 Sep 2020 03:44:35 +0000
Received: by mail-pj1-f72.google.com with SMTP id x21so1267419pjp.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 20:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oBCdh9AHVKn2pvKDjPYbf2p/ubia6a1LMjcyX5qUih0=;
        b=blGfPs16Mg0pvPx31ca9ugXIbxC7OxTHR45hpfmRJYbUSdLbftiq/xlJJHXeglDg7P
         uccdQy7WLRNRCYMdrZ2kCWy5INcBudibY8YQOKHfCRg/4btSMsV8vM78fFA+AdJFu0LZ
         qfPHSZzMNm9yCERmUsDdX+zYvW8MRSnU7o/ldf6mj822Xi34FcY6vKO7m+cg+3qsU6NX
         VrUXRN1W8/Cs1WQ12aZj6o0cmRFBJNpNVNNx8SPMfpPZUb+NKL3Q/+jbWCx08YUOyP0f
         77pJTcvASSbpkFECRhdwbntU1vA8AQCF3G0WdMqtf+GoH/ZORtYZ6EW0PYjGbTe8iVJ/
         nPBA==
X-Gm-Message-State: AOAM530mi8RjswzkpxCGSmwWN9u4MnY7CDQmIMlyVnQIbCYQv0dT3dp/
        Nb5vnr5IExjC2enSDoeojb3NVPa+B8rRgfvJElt5HkGrGUCO1N9nFmpKKxPB/gVIarXEByF8rmZ
        OcWtz4PZKcJb/q0rHIxXzTl0V9zJl+UD41K3nYH+f2Q==
X-Received: by 2002:a17:902:c253:: with SMTP id 19mr52937plg.65.1599795873446;
        Thu, 10 Sep 2020 20:44:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY4uaVpMyLnMtK0DRHCZhKP7Ii+rxYMe3wFJYMXiN3+HVrxw7f0xI1ZOkDROwv497nOMpnJg==
X-Received: by 2002:a17:902:c253:: with SMTP id 19mr52922plg.65.1599795873124;
        Thu, 10 Sep 2020 20:44:33 -0700 (PDT)
Received: from canonical.com (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id q7sm415031pgg.10.2020.09.10.20.44.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Sep 2020 20:44:32 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     anthony.wong@canonical.com
Subject: [PATCH v3] drm/dp_mst: Retrieve extended DPCD caps for topology manager
Date:   Fri, 11 Sep 2020 11:44:31 +0800
Message-Id: <20200911034431.29059-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1, read the DP_DP13_DPCD_REV to
get the faster capability.
If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0, read DP_DPCD_REV.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
Changelog:
1. Adjust the commit message.
2. use drm_dbg_kms instead and print the return code.
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 7753c718ddf9..63f8809b9aa4 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3671,8 +3671,6 @@ EXPORT_SYMBOL(drm_dp_read_mst_cap);
 int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool mst_state)
 {
 	int ret = 0;
-	u8 dpcd_ext = 0;
-	unsigned int dpcd_offset = 0;
 	struct drm_dp_mst_branch *mstb = NULL;
 
 	mutex_lock(&mgr->payload_lock);
@@ -3686,17 +3684,11 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		struct drm_dp_payload reset_pay;
 
 		WARN_ON(mgr->mst_primary);
-		drm_dp_dpcd_read(mgr->aux,
-				 DP_TRAINING_AUX_RD_INTERVAL,
-				 &dpcd_ext, sizeof(dpcd_ext));
-
-		dpcd_offset =
-			((dpcd_ext & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT) ?  DP_DP13_DPCD_REV : DP_DPCD_REV);
 
 		/* get dpcd info */
-		ret = drm_dp_dpcd_read(mgr->aux, dpcd_offset, mgr->dpcd, DP_RECEIVER_CAP_SIZE);
-		if (ret != DP_RECEIVER_CAP_SIZE) {
-			DRM_DEBUG_KMS("failed to read DPCD\n");
+		ret = drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd);
+		if (ret < 0) {
+			drm_dbg_kms(mgr->dev, "failed to read DPCD, ret %d\n", ret);
 			goto out_unlock;
 		}
 
-- 
2.25.1

