Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA92DC33CAC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA7220732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EmXtHEzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBDC5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:57:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35038 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgBDC5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:57:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so8911403pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/+Rlp1jPgPXZXDmW6x1Q8uODIAHg+YuyNKI1rs3+AQ=;
        b=EmXtHEzCTNUp3JHhN5KhU5HPB15eaWUPG0ltTwgDk3DdzSA1PfYHzVTn+DARhxhgo3
         nLvjBLEeGYMn+Hort7T3uc1tofVXrSkMNya6eRirfPIj/Xws052UlgRc+wOaGRCpqAJT
         9DM7TnFZsdY71blpcWhOSwZx/fpuJxEyQEWeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/+Rlp1jPgPXZXDmW6x1Q8uODIAHg+YuyNKI1rs3+AQ=;
        b=fQYf/4GYpgIgLjAHcq0CoAW3clrzWNiHcx1BISITc5bQFZNrhRGjfYAMyQCPY74vVp
         ACz2vI7SePYeobOeAxbLJv10iMz6AVTXOS/ekq0RpqMU5piST7l2nIR50rmNhAN9E5Ok
         oBvZhwX54LqPEM+R1wfnSN62m8fDge0Z+6ccsHCjjDb4xWHmtii30cl/4pd/xqMXqOMr
         m2ot+uIKE0tARMcyiaTWwLPuuFuUNCYq4UB6JbQQ1ep6IRqh8sjNxj1LJXjgTcahztLh
         KOd5UQpX+hx0T1a/wbCgSexIb1EEmVs5y/NrWIuLsZ+73zc73Ca3rdaG/+m2aHpoxdKh
         x7tg==
X-Gm-Message-State: APjAAAVsg3qWFCX3zlMiy5eyf3CGJ2FFLzVuw3/nIWDznmoPNts0PXSE
        sUXQK54l4cxzx+jfvpuXev/4/g==
X-Google-Smtp-Source: APXvYqzwUzAu92hNw9mJr15XxdwgDVAgES5XWUbnXAprF2iwJ17UqkCKPZnhqvly83TDtJ8RTtz32w==
X-Received: by 2002:a62:7a8a:: with SMTP id v132mr29363613pfc.111.1580785051956;
        Mon, 03 Feb 2020 18:57:31 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e1sm22491971pfl.98.2020.02.03.18.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:57:31 -0800 (PST)
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
Subject: [RFC][PATCHv2 12/12] videobuf2: don't test db_attach in dma-contig prepare and finish
Date:   Tue,  4 Feb 2020 11:56:41 +0900
Message-Id: <20200204025641.218376-13-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204025641.218376-1-senozhatsky@chromium.org>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We moved cache management decision making to the upper layer and
rely on buffer's need_cache_sync flags and videobuf2 core. If the
upper layer (core) has decided to invoke ->prepare() or ->finish()
then we must sync.

For DMABUF ->need_cache_sync_on_prepare and ->need_cache_sync_on_flush
are always false so videobuf core does not call ->prepare() and
->finish() on such buffers.

Additionally, scratch the DMABUF comment.

Change-Id: I8f6c0b246ccb63f775dcf7881dd5f848c38e7604
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-dma-contig.c | 6 ++----
 drivers/media/common/videobuf2/videobuf2-dma-sg.c     | 8 --------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index a387260fb321..6ea0961149d7 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -100,8 +100,7 @@ static void vb2_dc_prepare(void *buf_priv)
 	struct vb2_dc_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	/* DMABUF exporter will flush the cache for us */
-	if (!sgt || buf->db_attach)
+	if (!sgt)
 		return;
 
 	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
@@ -113,8 +112,7 @@ static void vb2_dc_finish(void *buf_priv)
 	struct vb2_dc_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	/* DMABUF exporter will flush the cache for us */
-	if (!sgt || buf->db_attach)
+	if (!sgt)
 		return;
 
 	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index bfc99a0cb7b9..1fd25eda0bf2 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -198,10 +198,6 @@ static void vb2_dma_sg_prepare(void *buf_priv)
 	struct vb2_dma_sg_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	/* DMABUF exporter will flush the cache for us */
-	if (buf->db_attach)
-		return;
-
 	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
 			       buf->dma_dir);
 }
@@ -211,10 +207,6 @@ static void vb2_dma_sg_finish(void *buf_priv)
 	struct vb2_dma_sg_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	/* DMABUF exporter will flush the cache for us */
-	if (buf->db_attach)
-		return;
-
 	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
 }
 
-- 
2.25.0.341.g760bfbb309-goog

