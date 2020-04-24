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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E362C55194
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1EF2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFkGkznq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgDXJbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbgDXJba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:31:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42511C09B045;
        Fri, 24 Apr 2020 02:31:30 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id o10so4375637pgb.6;
        Fri, 24 Apr 2020 02:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKtrJsIKIcsIj8dnmTqgxVou7+4jAhZAHReCNI0jtao=;
        b=SFkGkznqV1H1/UpaNUH8mKQuDrsQo/npf8DckslCy1QCaEV0kqH92LyVP+K1inquE4
         H6NxgIaHlXj2KeAFmsbekH7Mgb7vxRC3jNCDsS2S2Gxj0qD+Uvzlnwns921f/ObsSt4P
         9MGsa8MwHAyYBKEJrha+kZApYkhzLeSj6gOIN8lDQynJyt0JYDP+OnnlQ+TO5KxROYNC
         QvMoPwEkJ5r46nP1nElwu/o565NcHyl23gy94BSVo3jT0c68/v+sVGo81RCmRqVudcYH
         CmY3l5KYqp6B0UGR2OGqx9ZsrTHcOcKVRz9rFN3OhuHIWGL/DFkZPB6d+FDYIvDPoeQs
         HE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKtrJsIKIcsIj8dnmTqgxVou7+4jAhZAHReCNI0jtao=;
        b=KRa0Z1D5DptlG5snJRCYcoIlcYYFoyk1haZxW2juL4UvYc7hkrmte6O7GJC9zqGNdZ
         6lG8PeM/Iz830OxtI+ls/j1so3jwG8tRqH4VMs1/9QlTLnqBmkDeAayO8HCBZWmPwI1W
         11WdBTqkiDHYJuFMW6cgXDGGoZTiTFtb0euZuqnLP06+VRbhuNOjcnJqHcB5mK7bx7ic
         6QNTbkQBYP7q0zpYC9gU6OXHr40Hk3Kzs5j7je9N7vZCY2OwnrrEF6Y5dQiXReRHKwxj
         qwLKpCtclvhhT3F9ECmnGLRJEaX1PTK/3YijhmsKRNXY5EGJjZ/gNaR6jwG3r3eJci2p
         HgwA==
X-Gm-Message-State: AGi0PuYwsZQZKI5ooXLHf8DrXd6M5eWaTBT+TE82phnsrjsgf9yUayk8
        xjCyy3Dmt6e4UWnvj6Op4BQ=
X-Google-Smtp-Source: APiQypLbJvcncmRPQILZGS9hggGkztQpLq5XxJGNQqomKanvk4oYLWy6JiUfB935YNBgFj3GZvzBUw==
X-Received: by 2002:a62:1549:: with SMTP id 70mr8126648pfv.43.1587720689741;
        Fri, 24 Apr 2020 02:31:29 -0700 (PDT)
Received: from localhost.localdomain (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id 185sm5541315pfv.9.2020.04.24.02.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 02:31:29 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 12/13] videobuf2: don't test db_attach in dma-contig prepare and finish
Date:   Fri, 24 Apr 2020 18:29:19 +0900
Message-Id: <20200424092920.4801-13-sergey.senozhatsky@gmail.com>
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

We moved cache management decision making to the upper layer and
rely on buffer's need_cache_sync flags and videobuf2 core. If the
upper layer (core) has decided to invoke ->prepare() or ->finish()
then we must sync.

For DMABUF ->need_cache_sync_on_prepare and ->need_cache_sync_on_flush
are always false so videobuf core does not call ->prepare() and
->finish() on such buffers.

Additionally, scratch the DMABUF comment.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-dma-contig.c | 6 ++----
 drivers/media/common/videobuf2/videobuf2-dma-sg.c     | 8 --------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 6787e2cb905e..5a3e1c3b556f 100644
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
index 595137e358e7..0a40e00f0d7e 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -204,10 +204,6 @@ static void vb2_dma_sg_prepare(void *buf_priv)
 	struct vb2_dma_sg_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	/* DMABUF exporter will flush the cache for us */
-	if (buf->db_attach)
-		return;
-
 	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
 			       buf->dma_dir);
 }
@@ -217,10 +213,6 @@ static void vb2_dma_sg_finish(void *buf_priv)
 	struct vb2_dma_sg_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	/* DMABUF exporter will flush the cache for us */
-	if (buf->db_attach)
-		return;
-
 	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
 }
 
-- 
2.26.2

