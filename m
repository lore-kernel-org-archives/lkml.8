Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF20C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631D924685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lw0yY2Qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgBZLQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:16:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34334 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgBZLQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:16:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id j7so1180666plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JCmxjKYr6h+HQkJ8I2sAt9HA3Gj5LCEzRtahfHgdo0A=;
        b=lw0yY2Qor//ZEUu1GpyfA2emUMnuSoecVy9q8cJzKNy2GUuZwK16AIKpL4A5Czlo90
         KeHG1xGlmhagCJhp6nThjt3QE0uu83oA5EekEoMuVn+WeSzaM64/yGzyiw5/oVt0UVhC
         2f4qYBy8qEx4Cw7EN8DVkuIpdeoeJl5mmmcm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JCmxjKYr6h+HQkJ8I2sAt9HA3Gj5LCEzRtahfHgdo0A=;
        b=Fc9iFRab2hhMCRbOBzx4sbL1EFbDbWx1LLSdL0Bdgk9PK/1gL/KprouxOc4qtOWe0w
         bNvPlfDVHALGrXgArLwZTZgFLeGfs/1GpM5T1kYqLSrkq4RUyBc/U21okPA65eQGFP6k
         jREG3dFs1uV+B1H1DvQrxY6ep10UwyNdhYEdBRSA4TXBezvkmqqtJwQfYnPnmvF4Twpi
         AfQEm8jrsM6kboYdRfIWxyJyBQJ+TJaKqnOfN/mfaYv1kzzpHgNs6Ix1wxOigI+sTXLk
         dNGaiSAFf6Bx4UTwZ4TKEK0GXGEAzCa5M6jazBA2F2JHshjAoZXf4q0R+h29xcN2xriM
         gdgw==
X-Gm-Message-State: APjAAAU51KeHr2W/zZYBLki7bkkqL29gH0jKAL6eaG1/6lYvMsvY2uvW
        ZokNoJyQwPR6dn1HKpxLCbp8+Q==
X-Google-Smtp-Source: APXvYqxtS5WDiX+fS/IvZhS9qTmEMxpoSGMWZO9YA9VURvHi53gevzaMm9d7V9HHbkgzuOKa50WCUw==
X-Received: by 2002:a17:90a:178f:: with SMTP id q15mr4767582pja.132.1582715779415;
        Wed, 26 Feb 2020 03:16:19 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id o22sm2429993pgj.58.2020.02.26.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:16:18 -0800 (PST)
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
Subject: [PATCHv3 09/11] videobuf2: add begin/end cpu_access callbacks to dma-contig
Date:   Wed, 26 Feb 2020 20:15:27 +0900
Message-Id: <20200226111529.180197-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200226111529.180197-1-senozhatsky@chromium.org>
References: <20200226111529.180197-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide begin_cpu_access() and end_cpu_access() callbacks for
cache synchronisation on exported buffers.

The patch also adds a new helper function - vb2_dc_buffer_consistent(),
which returns true is if the buffer is consistent (DMA_ATTR_NON_CONSISTENT
bit cleared), so then we don't need to sync anything.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../common/videobuf2/videobuf2-dma-contig.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index d0c9dffe49e5..a387260fb321 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -42,6 +42,11 @@ struct vb2_dc_buf {
 	struct dma_buf_attachment	*db_attach;
 };
 
+static inline bool vb2_dc_buffer_consistent(unsigned long attr)
+{
+	return !(attr & DMA_ATTR_NON_CONSISTENT);
+}
+
 /*********************************************/
 /*        scatterlist table functions        */
 /*********************************************/
@@ -335,6 +340,32 @@ static void vb2_dc_dmabuf_ops_release(struct dma_buf *dbuf)
 	vb2_dc_put(dbuf->priv);
 }
 
+static int vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
+					      enum dma_data_direction direction)
+{
+	struct vb2_dc_buf *buf = dbuf->priv;
+	struct sg_table *sgt = buf->dma_sgt;
+
+	if (vb2_dc_buffer_consistent(buf->attrs))
+		return 0;
+
+	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	return 0;
+}
+
+static int vb2_dc_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
+					    enum dma_data_direction direction)
+{
+	struct vb2_dc_buf *buf = dbuf->priv;
+	struct sg_table *sgt = buf->dma_sgt;
+
+	if (vb2_dc_buffer_consistent(buf->attrs))
+		return 0;
+
+	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	return 0;
+}
+
 static void *vb2_dc_dmabuf_ops_vmap(struct dma_buf *dbuf)
 {
 	struct vb2_dc_buf *buf = dbuf->priv;
@@ -353,6 +384,8 @@ static const struct dma_buf_ops vb2_dc_dmabuf_ops = {
 	.detach = vb2_dc_dmabuf_ops_detach,
 	.map_dma_buf = vb2_dc_dmabuf_ops_map,
 	.unmap_dma_buf = vb2_dc_dmabuf_ops_unmap,
+	.begin_cpu_access = vb2_dc_dmabuf_ops_begin_cpu_access,
+	.end_cpu_access = vb2_dc_dmabuf_ops_end_cpu_access,
 	.vmap = vb2_dc_dmabuf_ops_vmap,
 	.mmap = vb2_dc_dmabuf_ops_mmap,
 	.release = vb2_dc_dmabuf_ops_release,
-- 
2.25.0.265.gbab2e86ba0-goog

