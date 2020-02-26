Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1550C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CA524688
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TpHVYoel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgBZLQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:16:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42318 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgBZLQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:16:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so1292346pfz.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaNPcBjkoKZw1bZcJWbUbEpJEQzWw7qCsLqY7OuM15k=;
        b=TpHVYoelr2i7JTAn1zYgosT0gH2KCmVfBT2mcDRYFYxvwsUI34gyZWfPfrn9IuVVjG
         wqI599qBr/LlzAbOKH7aTgWWkqmpgCCiD07a/Q8O41vl61QBBKU0HFaGKiQPlLtbjCWX
         5CyL6JfDgjKo/0vlbyNIXGTSj7hV8NmDaV2hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaNPcBjkoKZw1bZcJWbUbEpJEQzWw7qCsLqY7OuM15k=;
        b=A6QVdqpYQEiXbbgXEdv/5H8i83eYxUoU8alLEXHfEs1XeYdW1nzyyA8TzQMZEAyT/C
         ++uIRBow6pZ97mvLNVNHu4lKb+N4t2W7wIMzoxBTQcsdsYB7WukMjU699NFDST7YXAgU
         S8xHUS1MNaqKg7iakUNtrJdFvf8zVLDhQeHQSxjMBFCJkphVamxE3rgmF8rKpXb47iPz
         j/8lzN/vO3Q4DGF/kUqHvnDri2N8M2Cmz3c//tk5HG7SU0N/eftPegA/gfIufx/iOYKX
         /72JsN5VQ/IO+2zTuckZ6Tv5yciWxY7eMKMyWIzb/6xgCulmSfRgyuqfZVu3eJgY9oPE
         hUGw==
X-Gm-Message-State: APjAAAUtiB7aqKNsLFjtM8VffGdUvX2KkUU80fjn1e/AcRCfuwoVSQin
        IUura+6b5lGrz2Y2WMJDIrt1vw==
X-Google-Smtp-Source: APXvYqwLk21jax9uCKTboCDZ+LjJJHjnos3aVaS6S8vk1tenX3zUCVD/KCSsuaijssiAixcnDfa63Q==
X-Received: by 2002:aa7:96ea:: with SMTP id i10mr3722985pfq.58.1582715766793;
        Wed, 26 Feb 2020 03:16:06 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id o22sm2429993pgj.58.2020.02.26.03.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:16:05 -0800 (PST)
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
Subject: [PATCHv3 06/11] videobuf2: factor out planes prepare/finish functions
Date:   Wed, 26 Feb 2020 20:15:24 +0900
Message-Id: <20200226111529.180197-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200226111529.180197-1-senozhatsky@chromium.org>
References: <20200226111529.180197-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code, no functional changes.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/common/videobuf2/videobuf2-core.c   | 52 +++++++++++--------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 3ca0545db7ee..c2a1eadb26cf 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -296,6 +296,32 @@ static void __vb2_buf_dmabuf_put(struct vb2_buffer *vb)
 		__vb2_plane_dmabuf_put(vb, &vb->planes[plane]);
 }
 
+/*
+ * __vb2_buf_mem_prepare() - call ->prepare() on buffer's private memory
+ * to sync caches
+ */
+static void __vb2_buf_mem_prepare(struct vb2_buffer *vb)
+{
+	unsigned int plane;
+
+	for (plane = 0; plane < vb->num_planes; ++plane)
+		call_void_memop(vb, prepare, vb->planes[plane].mem_priv);
+	vb->synced = 1;
+}
+
+/*
+ * __vb2_buf_mem_finish() - call ->finish on buffer's private memory
+ * to sync caches
+ */
+static void __vb2_buf_mem_finish(struct vb2_buffer *vb)
+{
+	unsigned int plane;
+
+	for (plane = 0; plane < vb->num_planes; ++plane)
+		call_void_memop(vb, finish, vb->planes[plane].mem_priv);
+	vb->synced = 0;
+}
+
 /*
  * __setup_offsets() - setup unique offsets ("cookies") for every plane in
  * the buffer.
@@ -951,7 +977,6 @@ void vb2_buffer_done(struct vb2_buffer *vb, enum vb2_buffer_state state)
 {
 	struct vb2_queue *q = vb->vb2_queue;
 	unsigned long flags;
-	unsigned int plane;
 
 	if (WARN_ON(vb->state != VB2_BUF_STATE_ACTIVE))
 		return;
@@ -971,12 +996,8 @@ void vb2_buffer_done(struct vb2_buffer *vb, enum vb2_buffer_state state)
 	dprintk(4, "done processing on buffer %d, state: %d\n",
 			vb->index, state);
 
-	if (state != VB2_BUF_STATE_QUEUED) {
-		/* sync buffers */
-		for (plane = 0; plane < vb->num_planes; ++plane)
-			call_void_memop(vb, finish, vb->planes[plane].mem_priv);
-		vb->synced = 0;
-	}
+	if (state != VB2_BUF_STATE_QUEUED)
+		__vb2_buf_mem_finish(vb);
 
 	spin_lock_irqsave(&q->done_lock, flags);
 	if (state == VB2_BUF_STATE_QUEUED) {
@@ -1301,7 +1322,6 @@ static int __buf_prepare(struct vb2_buffer *vb)
 {
 	struct vb2_queue *q = vb->vb2_queue;
 	enum vb2_buffer_state orig_state = vb->state;
-	unsigned int plane;
 	int ret;
 
 	if (q->error) {
@@ -1345,11 +1365,7 @@ static int __buf_prepare(struct vb2_buffer *vb)
 		return ret;
 	}
 
-	/* sync buffers */
-	for (plane = 0; plane < vb->num_planes; ++plane)
-		call_void_memop(vb, prepare, vb->planes[plane].mem_priv);
-
-	vb->synced = 1;
+	__vb2_buf_mem_prepare(vb);
 	vb->prepared = 1;
 	vb->state = orig_state;
 
@@ -1969,14 +1985,8 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 				call_void_vb_qop(vb, buf_request_complete, vb);
 		}
 
-		if (vb->synced) {
-			unsigned int plane;
-
-			for (plane = 0; plane < vb->num_planes; ++plane)
-				call_void_memop(vb, finish,
-						vb->planes[plane].mem_priv);
-			vb->synced = 0;
-		}
+		if (vb->synced)
+			__vb2_buf_mem_finish(vb);
 
 		if (vb->prepared) {
 			call_void_vb_qop(vb, buf_finish, vb);
-- 
2.25.0.265.gbab2e86ba0-goog

