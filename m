Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28463C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BCF20738
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TJk2wGpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHRHOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgHRHOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:14:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118ABC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 00:14:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kr4so9009610pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/dwpDf9Rw0FIDL5Sc/gG8pBkCydPXuy0KjMx4jHUik=;
        b=TJk2wGpKp5lkOsiP0L6dKI7P/t5To6aQ2Cnq6wOHLJwRdvC9z3RH7BxTBUoTJK4cQl
         xAOVRhA+nDpU/AlSI5Rdc2kE1DxHG8z66cjJAKSW4uqXxM0sN6C44MOfw8xOn/f5qBp/
         2po8Q5uZ4E1NsdNEuN7aS0lHMaUw/TsrdN5fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/dwpDf9Rw0FIDL5Sc/gG8pBkCydPXuy0KjMx4jHUik=;
        b=kfa/XJTeZ7ibOJZEOObFNQfriQ22xjSftTqr5SZIWdonNPXenPTfWftRgZtceoADA8
         vjC6sNIQ2hEeqFf2pZIVIS7XbltIuRUPWRF5wM2nOZq8aHqtjzfauGk8/Emn1lkc3AfA
         AC9JNOqqH6EBihyFx+IeVZtg3D7xoCi6DyXSkiiZzmVOU1hWESoZvL+Fdq6veKwTNXW3
         oQ2PCLhudIjoZUFF6ac+N45meMvrqh5eXOKqYmA+eS3wK0C6d0RVDPziRCU6ZoK0SpVL
         zhHfcMqwlg6oHF/0ofqy9a1e0S56MGW1VQII9ev5RZYOyHCVb/H1DdBvBFlRn6XinqT5
         tLBA==
X-Gm-Message-State: AOAM533iAvHHLgSchA/Sfkrg2RT5cm+vaZhSRTR89vVga7wsLSdbWZ4P
        M8eMbUDT/tacHaOEz0mvhmpiAw==
X-Google-Smtp-Source: ABdhPJy8zjg37MiRqEGZWaBawQE/Hc7rg5SJ3tv+YlvBGWoUmk0KK37NeNdgmQU8rECJ8aPAUoaoMA==
X-Received: by 2002:a17:902:9890:: with SMTP id s16mr14139705plp.332.1597734842657;
        Tue, 18 Aug 2020 00:14:02 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f693:9fff:fef4:a930])
        by smtp.gmail.com with ESMTPSA id w15sm22074294pjk.13.2020.08.18.00.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 00:14:02 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Stevens <stevensd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        virtio-dev@lists.oasis-open.org
Subject: [PATCH v7 2/3] virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
Date:   Tue, 18 Aug 2020 16:13:42 +0900
Message-Id: <20200818071343.3461203-3-stevensd@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200818071343.3461203-1-stevensd@chromium.org>
References: <20200818071343.3461203-1-stevensd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature allows the guest to request a UUID from the host for a
particular virtio_gpu resource. The UUID can then be shared with other
virtio devices, to allow the other host devices to access the
virtio_gpu's corresponding host resource.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 include/uapi/linux/virtio_gpu.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 0c85914d9369..9721d58b4d58 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -50,6 +50,10 @@
  * VIRTIO_GPU_CMD_GET_EDID
  */
 #define VIRTIO_GPU_F_EDID                1
+/*
+ * VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID
+ */
+#define VIRTIO_GPU_F_RESOURCE_UUID       2
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -66,6 +70,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
 	VIRTIO_GPU_CMD_GET_CAPSET,
 	VIRTIO_GPU_CMD_GET_EDID,
+	VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID,
 
 	/* 3d commands */
 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
@@ -87,6 +92,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET,
 	VIRTIO_GPU_RESP_OK_EDID,
+	VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
 
 	/* error responses */
 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -340,4 +346,17 @@ enum virtio_gpu_formats {
 	VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM  = 134,
 };
 
+/* VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID */
+struct virtio_gpu_resource_assign_uuid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_RESOURCE_UUID */
+struct virtio_gpu_resp_resource_uuid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__u8 uuid[16];
+};
+
 #endif
-- 
2.28.0.220.ged08abb693-goog

