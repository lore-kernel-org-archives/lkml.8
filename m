Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8556EC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5799D24699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cMCH26pC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCBEMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:12:37 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36441 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgCBEMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:12:36 -0500
Received: by mail-pj1-f68.google.com with SMTP id d7so883258pjw.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 20:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6z/dbpsAJ3nyjiLy5ZTWHYE+yf0r+oxWKfI3Of1Dd4=;
        b=cMCH26pCmXb3Ya2wfhiu8tj4o9hBtdJTJvGiu/xRjRKtuOF90yWeozt5trOBt/q2Uh
         oJ/Yr5KSJIkgOBWJVex2mw3e9nakc8rJFN4iqFW+ZZwfgBAdxs6ubuCYhs1vG4eypZBQ
         UP/sm6YJo8UaB2p71u2a6c/QskLzlYYJHAH38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6z/dbpsAJ3nyjiLy5ZTWHYE+yf0r+oxWKfI3Of1Dd4=;
        b=j3XRYgoiLy1nb332s6cBB1DqXOyQ/RQeUi6PulynRGxzA4SQBF6KwoAyCwVXvOK4g6
         iCbwz8sQgcz57Bbncr/imG/LkG2CbPMexXaWAGPFmxGwtplHLkZ/TMeMmpL+A3N6lCGp
         J8vcwF68qwlaxD4BKtAPqtZSekpij2iVvN7a5zhjngdnOFBgi9hzwkLE2WbdlFiPFRWQ
         VUMPJlbvBLH0Ok91pVLC0AXMJYWq6sajxONMlIhgtrKNtukwRJaz5OCoozgtvOyS/m4H
         hMqO2QuOI1lmp9KgqKP70KVkTx/dzWcbyNIVs1wIOe+zU46iGthbRclTxMHRiWH6mfD7
         59YQ==
X-Gm-Message-State: APjAAAVTqhKdeIrBkBnAP7Z+fgXN82JR8GENFDvt9/BdndxgEoVuNG5p
        gGL2pYxX0dlSKzGIE57NybEWwQ==
X-Google-Smtp-Source: APXvYqwtEuZtuxBPXd8Au6k+ScE/CbCrd3xcRWfZ+WvodYsbeu4koyiICkTyQCwIBXocLulDsiOH7w==
X-Received: by 2002:a17:902:8f91:: with SMTP id z17mr16134724plo.234.1583122355107;
        Sun, 01 Mar 2020 20:12:35 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id d82sm1698114pfd.187.2020.03.01.20.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 20:12:34 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 02/11] videobuf2: handle V4L2 buffer cache flags
Date:   Mon,  2 Mar 2020 13:12:04 +0900
Message-Id: <20200302041213.27662-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200302041213.27662-1-senozhatsky@chromium.org>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set video buffer cache management flags corresponding to V4L2 cache
flags.

Both ->prepare() and ->finish() cache management hints should be
passed during this stage (buffer preparation), because there is
no other way for user-space to tell V4L2 to avoid ->finish() cache
flush.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/common/videobuf2/videobuf2-v4l2.c   | 49 +++++++++++++++++++
 include/media/videobuf2-core.h                | 11 +++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index eb5d5db96552..2a604bd7793a 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -199,6 +199,15 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
 	vbuf->request_fd = -1;
 	vbuf->is_held = false;
 
+	/*
+	 * Clear buffer cache flags if queue does not support user space hints.
+	 * That's to indicate to userspace that these flags won't work.
+	 */
+	if (!vb2_queue_allows_cache_hints(q)) {
+		b->flags &= ~V4L2_BUF_FLAG_NO_CACHE_INVALIDATE;
+		b->flags &= ~V4L2_BUF_FLAG_NO_CACHE_CLEAN;
+	}
+
 	if (V4L2_TYPE_IS_MULTIPLANAR(b->type)) {
 		switch (b->memory) {
 		case VB2_MEMORY_USERPTR:
@@ -337,6 +346,45 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
 	return 0;
 }
 
+static void set_buffer_cache_hints(struct vb2_queue *q,
+				   struct vb2_buffer *vb,
+				   struct v4l2_buffer *b)
+{
+	/*
+	 * DMA exporter should take care of cache syncs, so we can avoid
+	 * explicit ->prepare()/->finish() syncs. For other ->memory types
+	 * we always need ->prepare() or/and ->finish() cache sync.
+	 */
+	if (q->memory == VB2_MEMORY_DMABUF) {
+		vb->need_cache_sync_on_finish = 0;
+		vb->need_cache_sync_on_prepare = 0;
+		return;
+	}
+
+	/*
+	 * Cache sync/invalidation flags are set by default in order to
+	 * preserve existing behaviour for old apps/drivers.
+	 */
+	vb->need_cache_sync_on_prepare = 1;
+	vb->need_cache_sync_on_finish = 1;
+
+	if (!vb2_queue_allows_cache_hints(q))
+		return;
+
+	/*
+	 * ->finish() cache sync can be avoided when queue direction is
+	 * TO_DEVICE.
+	 */
+	if (q->dma_dir == DMA_TO_DEVICE)
+		vb->need_cache_sync_on_finish = 0;
+
+	if (b->flags & V4L2_BUF_FLAG_NO_CACHE_INVALIDATE)
+		vb->need_cache_sync_on_finish = 0;
+
+	if (b->flags & V4L2_BUF_FLAG_NO_CACHE_CLEAN)
+		vb->need_cache_sync_on_prepare = 0;
+}
+
 static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
 				    struct v4l2_buffer *b, bool is_prepare,
 				    struct media_request **p_req)
@@ -381,6 +429,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 	}
 
 	if (!vb->prepared) {
+		set_buffer_cache_hints(q, vb, b);
 		/* Copy relevant information provided by the userspace */
 		memset(vbuf->planes, 0,
 		       sizeof(vbuf->planes[0]) * vb->num_planes);
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 4a19170672ac..731fd9fbd506 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -632,6 +632,17 @@ struct vb2_queue {
 #endif
 };
 
+/**
+ * vb2_queue_allows_cache_hints() - Return true if the queue allows cache
+ * and memory consistency hints.
+ *
+ * @q:		pointer to &struct vb2_queue with videobuf2 queue
+ */
+static inline bool vb2_queue_allows_cache_hints(struct vb2_queue *q)
+{
+	return q->allow_cache_hints && q->memory == VB2_MEMORY_MMAP;
+}
+
 /**
  * vb2_plane_vaddr() - Return a kernel virtual address of a given plane.
  * @vb:		pointer to &struct vb2_buffer to which the plane in
-- 
2.25.0.265.gbab2e86ba0-goog

