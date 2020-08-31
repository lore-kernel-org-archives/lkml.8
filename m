Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEBDC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681AF206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nnEChR4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgHaWrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgHaWrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:47:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983F9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:47:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e1so10913656ybk.14
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=KBtyw/RYmlSgJJ/27vILnBFPPzBvH0RegA0nLlpxjlc=;
        b=nnEChR4K+kZlMdchOSixR5K21N3MsHT5xPfBEgSVkZXGongrjChO3I7h8kr/CGDMBC
         sGviFdx1h3/Tr5iMkCZbp/FBMn1qlItT2Kfioxj2eAz2JyXOXzYNjtXhkqVPBeIiSHHF
         rGg2TxIvihlgbskgiRErmigMMuqleULXJZdhBpAcIGkbSPbX5XtRqgRReiuKUg4eu5IB
         vGc/fk2HD+HqM9XuzviczaRE2FK/7JCCabaHAE/Gg2xnsbqlrOCA3iAQFf7mKd6iL3qt
         iQ2BBgoUcXHyj1f9dzW2uPSS/qm34k389mPb6NUdEUg9sJaz4oTAfIrkIs3LTieXuLxL
         B5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=KBtyw/RYmlSgJJ/27vILnBFPPzBvH0RegA0nLlpxjlc=;
        b=IYhIbGUph1i9HS4BsJKOp+/FByyrj6Y3mi04Tw2YX/cZgLh6JVT/9f5GTauO796q2e
         qVW3pKguF9verZwj3RJtvF809e3EAFqTocA50vzMgHf6whlM91JU2lrK55ruAirryVuL
         g746OhiO5RP790QmBXlg8GHdyFikahC3tTPMGwmWKIP5beAXUaB2x+Uk+kzpJ7jUuIvI
         vVxLdlgee5KUpNmGw+aFzXWX1kT6/53Fvg/7iYrPHkKsyKGJzJN3R5In1jMoEE6Zei1S
         +uDhzNmuzcO1f2/6WLAz0dTr6+v0e0SGmu4yh5+bDKH6VDaFvyglaqWZvbR778J7AJ+Q
         cIyw==
X-Gm-Message-State: AOAM530gytRrgAyXVTZfrvz9FJENLs8bOIZnZEIHVsSUyxZmuV0Wwb+X
        NN3PCqWXgyg3wwcRwalJ6NJ0Cm49a1gDyw==
X-Google-Smtp-Source: ABdhPJyvEDGNzHiqwlI3HHsIGPS4iLco1NHQNc0Bx5jyBoa+GGnjWSSsU0rXGmvaNYJAt0/xbcOItFPNatE32A==
X-Received: from doughorn0.sfo.corp.google.com ([2620:15c:8:15:5265:f3ff:fe2c:51b7])
 (user=doughorn job=sendgmr) by 2002:a25:e06:: with SMTP id
 6mr5614705ybo.80.1598914066435; Mon, 31 Aug 2020 15:47:46 -0700 (PDT)
Date:   Mon, 31 Aug 2020 15:47:42 -0700
Message-Id: <20200831224742.1342039-1-doughorn@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH] Fix use after free in get_capset_info callback.
From:   Doug Horn <doughorn@google.com>
To:     airlied@linux.ie, kraxel@redhat.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Doug Horn <doughorn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a response to virtio_gpu_cmd_get_capset_info takes longer than
five seconds to return, the callback will access freed kernel memory
in vg->capsets.

Signed-off-by: Doug Horn <doughorn@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c |  2 ++
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 75d0dc2f6d28..5ba389e0a02f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -80,8 +80,10 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
 					 vgdev->capsets[i].id > 0, 5 * HZ);
 		if (ret == 0) {
 			DRM_ERROR("timed out waiting for cap set %d\n", i);
+			spin_lock(&vgdev->display_info_lock);
 			kfree(vgdev->capsets);
 			vgdev->capsets = NULL;
+			spin_unlock(&vgdev->display_info_lock);
 			return;
 		}
 		DRM_INFO("cap set %d: id %d, max-version %d, max-size %d\n",
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c93c2db35aaf..7436705ba5a2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -684,9 +684,13 @@ static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device *vgdev,
 	int i = le32_to_cpu(cmd->capset_index);
 
 	spin_lock(&vgdev->display_info_lock);
-	vgdev->capsets[i].id = le32_to_cpu(resp->capset_id);
-	vgdev->capsets[i].max_version = le32_to_cpu(resp->capset_max_version);
-	vgdev->capsets[i].max_size = le32_to_cpu(resp->capset_max_size);
+	if (vgdev->capsets) {
+		vgdev->capsets[i].id = le32_to_cpu(resp->capset_id);
+		vgdev->capsets[i].max_version = le32_to_cpu(resp->capset_max_version);
+		vgdev->capsets[i].max_size = le32_to_cpu(resp->capset_max_size);
+	} else {
+		DRM_ERROR("invalid capset memory.");
+	}
 	spin_unlock(&vgdev->display_info_lock);
 	wake_up(&vgdev->resp_wq);
 }
-- 
2.28.0.402.g5ffc5be6b7-goog

