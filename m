Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD34C33CAC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4134920732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qb+Op006"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBDC5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:57:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32941 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgBDC53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:57:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so8923143pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8h+I8oxNIcMrbLvsm+8Df46AS8oNWipq59orM6/5OoQ=;
        b=Qb+Op0063itwM7zF2RFmjrsNv3YJmj5LgRFLABUotYSOIhCarSuW8fKd+TFe9XAhyi
         y1ZRx1+0rv6FfLP0lVijNYckb3zEXXivjrOQaNC4SBXY5Dv0OvJxacxjg90Y2rMqYSk4
         JfoBGGHHMGDkDOmZFLdXGlhmgp73izBpnIVP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8h+I8oxNIcMrbLvsm+8Df46AS8oNWipq59orM6/5OoQ=;
        b=WabFhHKl+XwmZlheapy+hdgW41sLHffad6zKgCT2J+EsmCo8ViqHXq+nPBueCBWxp5
         G6ziwiuoimCcU3mBLfeFLPP4Zjco5q2MUVHKFRrlozmL3dYfo8VsKzecD6G1eTldioxk
         6M7q+LCsQixKC3qTZ4HTQo+KCB87+23TCe1Cf6TTz/0vdxhJ+G5Z1Zv0HzUn1MTysG2v
         lyNxM0E9ml63krM8xIQAS9SDUoTMbSC3evNowvMLd9NlaPT/L6WOslIcuC9uhHK5F/cs
         kNe2IwDnq/pXZNeHotpIF/K/mrrA1FJQSR7MmcgAH8wQPxote8m634zdz/u75YJN52cP
         kT+A==
X-Gm-Message-State: APjAAAW3uo03PEeQq2tdQb3b7KXOGLKVKLd99REC9yc2GlhCysJY0JJr
        tg7i6Pxu/4nevsamOtHLsYLGOQ==
X-Google-Smtp-Source: APXvYqxu/ATw/8OV8+fM2uhq19GOMnYoGMlei5elIfGBc5xRNveJHWeIEJNo6C01L8N+dDLi+C7fvw==
X-Received: by 2002:a63:f57:: with SMTP id 23mr18739474pgp.46.1580785048241;
        Mon, 03 Feb 2020 18:57:28 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e1sm22491971pfl.98.2020.02.03.18.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:57:27 -0800 (PST)
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
Subject: [RFC][PATCHv2 11/12] videobuf2: add begin/end cpu_access callbacks to dma-sg
Date:   Tue,  4 Feb 2020 11:56:40 +0900
Message-Id: <20200204025641.218376-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204025641.218376-1-senozhatsky@chromium.org>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide begin_cpu_access() and end_cpu_access() dma_buf_ops
callbacks for cache synchronisation on exported buffers.

V4L2_FLAG_MEMORY_NON_CONSISTENT has no effect on dma-sg buffers.
dma-sg allocates memory using the page allocator directly, so
there is no memory consistency guarantee.

Change-Id: Ia0d9d72a8c2a9fe3264ac148f59201573289ed2c
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/common/videobuf2/videobuf2-dma-sg.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 6db60e9d5183..bfc99a0cb7b9 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -470,6 +470,26 @@ static void vb2_dma_sg_dmabuf_ops_release(struct dma_buf *dbuf)
 	vb2_dma_sg_put(dbuf->priv);
 }
 
+static int vb2_dma_sg_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
+					enum dma_data_direction direction)
+{
+	struct vb2_dma_sg_buf *buf = dbuf->priv;
+	struct sg_table *sgt = buf->dma_sgt;
+
+	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	return 0;
+}
+
+static int vb2_dma_sg_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
+					enum dma_data_direction direction)
+{
+	struct vb2_dma_sg_buf *buf = dbuf->priv;
+	struct sg_table *sgt = buf->dma_sgt;
+
+	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	return 0;
+}
+
 static void *vb2_dma_sg_dmabuf_ops_vmap(struct dma_buf *dbuf)
 {
 	struct vb2_dma_sg_buf *buf = dbuf->priv;
@@ -488,6 +508,8 @@ static const struct dma_buf_ops vb2_dma_sg_dmabuf_ops = {
 	.detach = vb2_dma_sg_dmabuf_ops_detach,
 	.map_dma_buf = vb2_dma_sg_dmabuf_ops_map,
 	.unmap_dma_buf = vb2_dma_sg_dmabuf_ops_unmap,
+	.begin_cpu_access = vb2_dma_sg_dmabuf_ops_begin_cpu_access,
+	.end_cpu_access = vb2_dma_sg_dmabuf_ops_end_cpu_access,
 	.vmap = vb2_dma_sg_dmabuf_ops_vmap,
 	.mmap = vb2_dma_sg_dmabuf_ops_mmap,
 	.release = vb2_dma_sg_dmabuf_ops_release,
-- 
2.25.0.341.g760bfbb309-goog

