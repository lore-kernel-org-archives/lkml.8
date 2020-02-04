Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3DFC33CAC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4FE20CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WBTkzktP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgBDC46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:56:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38912 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgBDC44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:56:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so6647579plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Dke3it4jAnnj8WZ58EOkoMCd5ygI2w9KJwtDCLTtPs=;
        b=WBTkzktPfQdyYJ/1Dp7tR7niJ57O1QuyCseggC0VAGq6KLGfx8m5m0cbGFUWSOl9oS
         1b2VUGd1r6Vfy3ZaYWNwj7GS3vAKBbrDy6MCWr5GteDpDpOYRuYabQKVfXh9M2wJfAgV
         1ENDVx0kml5b/I1+xEeFL9HJ8vL0yLWw/1UC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Dke3it4jAnnj8WZ58EOkoMCd5ygI2w9KJwtDCLTtPs=;
        b=XIdXUaWkmoEcaWyrzmt2X/8ZV4jppesHuofoT4VCxlyeKxf/hndHZ+s71e4aPbc7ic
         rxRDbEho238zAbWDrbn65P8aezkhqqZZ+p7d5LHSlBP5Q65J5pyZORHJRkPoRDmNNTSf
         mSQ4TCT2Dn5G2JTAAKH1RB7sDpZlgZHKS7aZ6rEV8Lkr3xOBag/En9hoO1yjyFyhNgXh
         z4cmFL45GxyKtPxcbOwbAWV17U4bzBN0FjtGkUpp04jhc0a97zpZhyevjs0Yw3fXcVD8
         7jyG7ledU5H+zXNLOtGFKOJQhmp26nStaJFQCrM3j3NRYTdpYwLPo4M/wVfklANF2nQV
         LxEA==
X-Gm-Message-State: APjAAAUbdPVPOcErn11G0P7H4jd0s+0kUXSg8KjZQbLm1/acV1kW1tUh
        q79q8pcK55vaefI3N1OOnrzt1g==
X-Google-Smtp-Source: APXvYqwFXZwVlWO8JJd9nP2tmu7pAXbLJCOTiydwVfbrp3yoOhZx3asfPWnN3Ku98Czzg/Yns7mIXg==
X-Received: by 2002:a17:90a:fb41:: with SMTP id iq1mr3133875pjb.89.1580785016239;
        Mon, 03 Feb 2020 18:56:56 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e1sm22491971pfl.98.2020.02.03.18.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:56:55 -0800 (PST)
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
Subject: [RFC][PATCHv2 02/12] videobuf2: handle V4L2 buffer cache flags
Date:   Tue,  4 Feb 2020 11:56:31 +0900
Message-Id: <20200204025641.218376-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204025641.218376-1-senozhatsky@chromium.org>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set video buffer cache management flags corresponding to V4L2 cache
flags.

Both ->prepare() and ->finish() cache management hints should be
passed during this stage (buffer preparation), because there is no
other way for user-space to skip ->finish() cache flush.

There are two possible alternative approaches:
- The first one is to move cache sync from ->finish() to dqbuf().
  But this breaks some drivers, that need to fix-up buffers before
  dequeueing them.

- The second one is to move ->finish() call from ->done() to dqbuf.

Change-Id: I3bef1d1fb93a5fba290ce760eaeecdc8e7d6885a
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/common/videobuf2/videobuf2-v4l2.c   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index eb5d5db96552..2da06a2ad6c4 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -337,6 +337,41 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
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
+	if (!q->allow_cache_hints)
+		return;
+
+	vb->need_cache_sync_on_prepare = 1;
+	/*
+	 * ->finish() cache sync can be avoided when queue direction is
+	 * TO_DEVICE.
+	 */
+	if (q->dma_dir != DMA_TO_DEVICE)
+		vb->need_cache_sync_on_finish = 1;
+	else
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
@@ -381,6 +416,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 	}
 
 	if (!vb->prepared) {
+		set_buffer_cache_hints(q, vb, b);
 		/* Copy relevant information provided by the userspace */
 		memset(vbuf->planes, 0,
 		       sizeof(vbuf->planes[0]) * vb->num_planes);
-- 
2.25.0.341.g760bfbb309-goog

