Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10896C33CAC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B0F21582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FHz9qg9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBDC5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:57:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44847 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbgBDC5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:57:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id g3so3192542pgs.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raQvSM5V/uMvgqOsdMStTvPP8E1jqsk9wa9DPg9FZM8=;
        b=FHz9qg9vqBt1VTVoYCNd2qaYaNJG/29qmMaSm30O/XXyzEZe4S/DF7cLRmDUeCoytY
         UikEMN5nN/TsyisDq8bLb9d3/9TkBMebeVUnBNtqg3gnJ/FMhrsZvYtni0l134SO5H76
         VYfoFzJW5VGyyJ+wGiX0LjKbVeKPI+Dgvb93A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raQvSM5V/uMvgqOsdMStTvPP8E1jqsk9wa9DPg9FZM8=;
        b=pn2HsiFqk9tJ80xlfCV8IgQ/vHfRT4K9d4ZYXfnSQt3rIkSxILvbkGWs4HPWtt284x
         UQ40tfpRO03em3sAxm7SE1TeDOvFgib773+BE2xfjTqt9bl9XMiqjaI8X93IUXik57xE
         lBOCpOAWREPs6jOMH8gVBj+raRQJ9OOlvjf3h5JpZE4ab4W8KuKghstG/qFbJw/6oevL
         QiI93CbHBRAwq3tyDh6D/6u+BjpUjEjUj+985/zB22HJ362NavfZIr+lcJfpKoODfq2/
         1Qu5W4zXZFihgznBeBYPRrovURWY3wY6kF1481F/1GTYWrZxi4K2+AU/H/3yHXEuQR6c
         GO5w==
X-Gm-Message-State: APjAAAWHYBPkfJUw0lohucbKC/zgnZ6hNsCdz92vp+19WjBHXTizMbE/
        Lq/cBRLqME6xP4HkyI1xgnXySw==
X-Google-Smtp-Source: APXvYqyniqRgXTBNCmKcTESug8rjHaeK7Uxfak70Cz/Vrue0dxlUhVtDJIqEBQzy/JDyESeD9UdZ0w==
X-Received: by 2002:a62:be0a:: with SMTP id l10mr29348868pff.110.1580785041112;
        Mon, 03 Feb 2020 18:57:21 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e1sm22491971pfl.98.2020.02.03.18.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:57:20 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCHv2 09/12] videobuf2: let user-space know if driver supports cache hints
Date:   Tue,  4 Feb 2020 11:56:38 +0900
Message-Id: <20200204025641.218376-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204025641.218376-1-senozhatsky@chromium.org>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS to fill_buf_caps(), which
is set when queue supports user-space cache management hints.

Change-Id: Ieac93f3726c61fd3b88e02c36980c1f3c7a82ecc
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/media/uapi/v4l/vidioc-reqbufs.rst | 7 +++++++
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 2 ++
 include/uapi/linux/videodev2.h                  | 1 +
 3 files changed, 10 insertions(+)

diff --git a/Documentation/media/uapi/v4l/vidioc-reqbufs.rst b/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
index 9741dac0d5b3..80603f57eb8a 100644
--- a/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
+++ b/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
@@ -165,6 +165,13 @@ aborting or finishing any DMA in progress, an implicit
       - Only valid for stateless decoders. If set, then userspace can set the
         ``V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF`` flag to hold off on returning the
 	capture buffer until the OUTPUT timestamp changes.
+    * - ``V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS``
+      - 0x00000040
+      - Set when the queue/buffer support memory consistency and cache
+        management hints. See :ref:`V4L2_FLAG_MEMORY_NON_CONSISTENT`,
+        :ref:`V4L2_BUF_FLAG_NO_CACHE_INVALIDATE` and
+        :ref:`V4L2_BUF_FLAG_NO_CACHE_CLEAN`.
+
 
 Return Value
 ============
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index eb5d1306cb03..22ae0ff64684 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -698,6 +698,8 @@ static void fill_buf_caps(struct vb2_queue *q, u32 *caps)
 		*caps |= V4L2_BUF_CAP_SUPPORTS_DMABUF;
 	if (q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF)
 		*caps |= V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF;
+	if (q->allow_cache_hints)
+		*caps |= V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS;
 #ifdef CONFIG_MEDIA_CONTROLLER_REQUEST_API
 	if (q->supports_requests)
 		*caps |= V4L2_BUF_CAP_SUPPORTS_REQUESTS;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 169a8cf345ed..12b1bd220347 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -951,6 +951,7 @@ struct v4l2_requestbuffers {
 #define V4L2_BUF_CAP_SUPPORTS_REQUESTS			(1 << 3)
 #define V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS		(1 << 4)
 #define V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF	(1 << 5)
+#define V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS		(1 << 6)
 
 /**
  * struct v4l2_plane - plane info for multi-planar buffers
-- 
2.25.0.341.g760bfbb309-goog

