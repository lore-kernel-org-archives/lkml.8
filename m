Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2A9C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C76C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ph0i383T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgCPHS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:18:28 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50179 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbgCPHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:18:27 -0400
Received: by mail-pj1-f68.google.com with SMTP id o23so2036246pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 00:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eYiMJvzhgU8cefu9p/MQZ5kiTc4aQrMez5IEQVm5JBQ=;
        b=ph0i383Trlk3tr0BOHQ3ZTIv3dERcGn4yWxpSSs6S/wrY+6zqgZXPwiFfJHWt1FDzu
         nj0hvpHu7uTzjAZndTAYwvLRSQmpiJxAfdDCBkXGHYbGndjiiHjBeD9UXs7YMx/hSSM4
         eRvnqere1oSk7E3qTRQozUBhOK5LDOZ7ZpwGEta9Twx2/hs5Yq2prnbabIVPwok42HT6
         jE5k3QLttsVttRGloBRHySlYUeXhTCxdNEgw9W0ItWwXz1cgb/llw+sTGplvdoPS8UCG
         52onSfRLjWDZFpDzg4Oqhtlva4FaUWhPVMh2C4iXRXUQnNofg4IcO6oO969suLvkCBid
         eeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eYiMJvzhgU8cefu9p/MQZ5kiTc4aQrMez5IEQVm5JBQ=;
        b=cDOBBDLsu6kJXl/lnEaOBQ8iRW5SR5G4f8s2pJrQm+H+hpwxxXIdAVoVPGMJV3NEGJ
         /216tKXREwddTxVDqnGRyw12XaPW22QrGFDELYetkmQPnCvhv8grNAMykBSJOc5TAXie
         qzCQ4QeuP7kWIki5cT698ih7c/lcq4dipNRqlrLllQ1elOcHh628WJG9ZA3AiSiiK7fB
         G+SeBrqx7zFXTUpCZXDJw2QQxrooUkoiIZzNPMFpKFWp1kYMlGNmQ7WiS1vO1DSAd+MP
         7VjcqEONvx1K4NnE6EQKSFR5KUg01F4nVYkC8wZuGIDGcKpXPxJP4IamToHY89nupTpz
         8hBA==
X-Gm-Message-State: ANhLgQ3bPbQaMir9frmxwbl7F2NJeGwRVwH3UWlMgaC6TgbazqVW+/9J
        KR6dFs0cdvqrNCOyzb0k7Rw=
X-Google-Smtp-Source: ADFU+vsyHvb9S+87dueVvHsTA4hufzgoTni9cVQgu2qepNbFJTvGvm2nK8xbbO+q+yDYBQV43X4KZw==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr25968701plp.304.1584343107104;
        Mon, 16 Mar 2020 00:18:27 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id e9sm22170618pfl.179.2020.03.16.00.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 00:18:26 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH RESEND] drm/lease: fix potential race in fill_object_idr
Date:   Mon, 16 Mar 2020 15:18:23 +0800
Message-Id: <1584343103-13896-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should hold idr_mutex for idr_alloc.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/gpu/drm/drm_lease.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index b481caf..427ee21 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -418,6 +418,7 @@ static int fill_object_idr(struct drm_device *dev,
 		goto out_free_objects;
 	}
 
+	mutex_lock(&dev->mode_config.idr_mutex);
 	/* add their IDs to the lease request - taking into account
 	   universal planes */
 	for (o = 0; o < object_count; o++) {
@@ -437,7 +438,7 @@ static int fill_object_idr(struct drm_device *dev,
 		if (ret < 0) {
 			DRM_DEBUG_LEASE("Object %d cannot be inserted into leases (%d)\n",
 					object_id, ret);
-			goto out_free_objects;
+			goto out_unlock;
 		}
 		if (obj->type == DRM_MODE_OBJECT_CRTC && !universal_planes) {
 			struct drm_crtc *crtc = obj_to_crtc(obj);
@@ -445,20 +446,22 @@ static int fill_object_idr(struct drm_device *dev,
 			if (ret < 0) {
 				DRM_DEBUG_LEASE("Object primary plane %d cannot be inserted into leases (%d)\n",
 						object_id, ret);
-				goto out_free_objects;
+				goto out_unlock;
 			}
 			if (crtc->cursor) {
 				ret = idr_alloc(leases, &drm_lease_idr_object, crtc->cursor->base.id, crtc->cursor->base.id + 1, GFP_KERNEL);
 				if (ret < 0) {
 					DRM_DEBUG_LEASE("Object cursor plane %d cannot be inserted into leases (%d)\n",
 							object_id, ret);
-					goto out_free_objects;
+					goto out_unlock;
 				}
 			}
 		}
 	}
 
 	ret = 0;
+out_unlock:
+	mutex_unlock(&dev->mode_config.idr_mutex);
 out_free_objects:
 	for (o = 0; o < object_count; o++) {
 		if (objects[o])
-- 
1.8.3.1

