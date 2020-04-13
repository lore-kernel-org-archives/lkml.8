Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C41C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C40320735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pp3345.net header.i=@pp3345.net header.b="hD2DOXr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbgDMVvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:51:44 -0400
Received: from saul.pp3345.net ([163.172.111.124]:56718 "EHLO saul.pp3345.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389227AbgDMVvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:51:42 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: dev@pp3345.net)
        by saul.pp3345.net (Postcow) with ESMTPSA id 9D70E9A45EE;
        Mon, 13 Apr 2020 23:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pp3345.net; s=saul;
        t=1586814207; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:autocrypt;
        bh=zKLpvb4399IPLBTYUy54gr53ZNSHE8t5s2HLC/LNoMM=;
        b=hD2DOXr4dAVFZaqYX0188tAp0uW3dKdkH8mQApK2H5IYYeQsXEjVIJxkwjtUBVyd2gMxBB
        A71usZOWzSTQ8/gxX8wf0GoZJk0sxEDCV3i1EB2D2t2An9diuyBKe7vgU9UXTrMihPMHpv
        jnkD0SdomK9flmTiyD1dweKNf9pHgzLY80EytZbZjDeozW6HO1htV287JiOe81563zjZmv
        faOq5UDiYvTYo00FiinCOOtGykSHH5SdUff950eWqGk83dAjgoYY/Hw7Ey5cH5SU3Bp/Ps
        1cHImZFoH8irPg9xgiYhhiHytgz/9wBt11k4nqrA67q9XgXwNXMBPzyV/zLAFw==
From:   Yussuf Khalil <dev@pp3345.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Yussuf Khalil <dev@pp3345.net>
Subject: [PATCH 4/5] drm/atomic-helper: Consider RGB quantization changes to be mode changes
Date:   Mon, 13 Apr 2020 23:40:25 +0200
Message-Id: <20200413214024.46500-5-dev@pp3345.net>
In-Reply-To: <20200413214024.46500-1-dev@pp3345.net>
References: <20200413214024.46500-1-dev@pp3345.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure RGB quantization range changes are applied immediately.

Signed-off-by: Yussuf Khalil <dev@pp3345.net>
---
 drivers/gpu/drm/drm_atomic_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 85d163f16801..b74e90a2b214 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -686,6 +686,12 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 			if (old_connector_state->max_requested_bpc !=
 			    new_connector_state->max_requested_bpc)
 				new_crtc_state->connectors_changed = true;
+
+			if (drm_connector_state_select_rgb_quantization_range(
+				old_connector_state, &new_crtc_state->mode) !=
+			    drm_connector_state_select_rgb_quantization_range(
+				new_connector_state, &new_crtc_state->mode))
+				new_crtc_state->mode_changed = true;
 		}
 
 		if (funcs->atomic_check)
-- 
2.26.0

