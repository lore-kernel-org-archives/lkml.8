Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8F4C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C13020736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOoSQgCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgDXJbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbgDXJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:31:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D404C09B045;
        Fri, 24 Apr 2020 02:31:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r4so4373932pgg.4;
        Fri, 24 Apr 2020 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCJfyab6Lo+SPYpGKD5yA65RisCBDWHIbluNYYAXFSY=;
        b=KOoSQgCgjSfL6JMrj9wJl3MF6nl9GRtsWNYFxIhC7E7QBdVjjjW47D7zv6ayp/dunQ
         2c3Q/5Ro4+h0M7dKvnaW8VeLd+12xe5RChvC/injaidyGLxaiYnXbQbaR/egNTpPMpxP
         hX/fPvHIK8KwPxN3Zf5tOqZK8WrhYfophs0vWTsxPwNJH7CsnNMHRo4JSmz5/uoRydof
         PYl9tFCm1WiF7zefu/X30kf7vM4R8SB++bBA9hhfBQ9+RAJ5nzC6YTL9l21PFTNA6Mis
         k2rLo1nPToZVo1KHJum7JM/gVIf89ZiTMTMHbTGIG0JfXfVie62ARFpOtmgoxS9W2RRZ
         V1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCJfyab6Lo+SPYpGKD5yA65RisCBDWHIbluNYYAXFSY=;
        b=IoQke+8KwkgX2QKEg3NWjcvdVLw8ZFAe+mj2p1V3jcdgHUUq6KVnbdVaAxWFT3+geb
         uVDVxnmTVae07jQgU+1ZyiKys57ya7dl2LcsiLM2UBnZ/a041zq7s8st6PU+osMOmJ2e
         XRJltdz7RgDxtV4w9CBsZVyYXqwtdq2nsjYHvX5NfzRLnNL8iLRNzX77lCEZ4ynHzaKK
         zeD+D19V5qQAOmqbiNIFoPkwrFRmbEEc4WWFRMCSZg5EGSwwluVcHEPfVWydMa+lEbXT
         QZZNSXtIwCv9/VNuJS9ilhCEvlu47KRHf6jOGFrTQmoG7T4RHP1WvJdc3dSDkGW1OU2H
         3csw==
X-Gm-Message-State: AGi0PuYb5/9/l8EIffSSbUnQCASsGZcn7oOYfA3dwW8Ihg+n+Pg2BRTc
        XtfpbzxyHiV9gm8f7S6S8tw=
X-Google-Smtp-Source: APiQypLXTk5Gj+sQxqdtDHpEza1UKhleKdeeAE6zusP+0PyDfWuSWQE6i83UH4667OZKkUYjv/Hn8g==
X-Received: by 2002:a63:c149:: with SMTP id p9mr8089925pgi.389.1587720668136;
        Fri, 24 Apr 2020 02:31:08 -0700 (PDT)
Received: from localhost.localdomain (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id 185sm5541315pfv.9.2020.04.24.02.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 02:31:07 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 07/13] videobuf2: factor out planes prepare/finish functions
Date:   Fri, 24 Apr 2020 18:29:14 +0900
Message-Id: <20200424092920.4801-8-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424092920.4801-1-sergey.senozhatsky@gmail.com>
References: <20200424092920.4801-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Senozhatsky <senozhatsky@chromium.org>

Factor out the code, no functional changes.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/common/videobuf2/videobuf2-core.c   | 52 +++++++++++--------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index d16f47022552..0be31a11c913 100644
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
@@ -960,7 +986,6 @@ void vb2_buffer_done(struct vb2_buffer *vb, enum vb2_buffer_state state)
 {
 	struct vb2_queue *q = vb->vb2_queue;
 	unsigned long flags;
-	unsigned int plane;
 
 	if (WARN_ON(vb->state != VB2_BUF_STATE_ACTIVE))
 		return;
@@ -980,12 +1005,8 @@ void vb2_buffer_done(struct vb2_buffer *vb, enum vb2_buffer_state state)
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
@@ -1310,7 +1331,6 @@ static int __buf_prepare(struct vb2_buffer *vb)
 {
 	struct vb2_queue *q = vb->vb2_queue;
 	enum vb2_buffer_state orig_state = vb->state;
-	unsigned int plane;
 	int ret;
 
 	if (q->error) {
@@ -1354,11 +1374,7 @@ static int __buf_prepare(struct vb2_buffer *vb)
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
 
@@ -1978,14 +1994,8 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
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
2.26.2

