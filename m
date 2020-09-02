Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2BAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7309120639
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599063429;
	bh=zeOoW6dBDPMUDQNPabBvfdWG+dRh4/f7I9v8bSFs3WU=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=jLMg7lkhHKKvX8ttqgrGQIeKQsT9HBBvlka02M7OnrLm9DmnYe3wMPcGTYNls2f5a
	 YgE8/ve9TKPBSTjmywuavcBBEKBWO/A00Xv+4vZlpUbr8mNemllfi0S2nDhQUycwZc
	 NPGI4ovfAmRhKeu50DqKVdw117vFj+LFEhjwOIK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgIBQRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgIBQK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:10:56 -0400
Received: from mail.kernel.org (ip5f5ad5c3.dynamic.kabel-deutschland.de [95.90.213.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECCF621556;
        Wed,  2 Sep 2020 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599063046;
        bh=zeOoW6dBDPMUDQNPabBvfdWG+dRh4/f7I9v8bSFs3WU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUdyaiYuY4fZeMpztbPCKFVt02npNMo5lxJyYxiEKUaImzANWtGLusfTdrnT4hEI7
         No5KX2tAIiSX13BpwOpL4RafsKwyMsqn2lJBcOemc7RnQjAjHWiqaloew7JP8kepMV
         iw7tXQglb/M6ZOc0gKp2B2rT6X3PC/bSr5V6eWIc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kDVLQ-000tAN-2d; Wed, 02 Sep 2020 18:10:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/38] media: videobuf-dma-sg: number of pages should be unsigned long
Date:   Wed,  2 Sep 2020 18:10:19 +0200
Message-Id: <a57a3584ccc16f33b2e6e8a850b7cb7cf029dfb6.1599062230.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599062230.git.mchehab+huawei@kernel.org>
References: <cover.1599062230.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by smatch:

	drivers/media/v4l2-core/videobuf-dma-sg.c:245 videobuf_dma_init_kernel() warn: should 'nr_pages << 12' be a 64 bit type?

The printk should not be using %d for the number of pages.

After looking better, the real problem here is that the
number of pages should be long int.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/v4l2-core/videobuf-dma-sg.c | 22 ++++++++++++----------
 include/media/videobuf-dma-sg.h           |  2 +-
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/media/v4l2-core/videobuf-dma-sg.c b/drivers/media/v4l2-core/videobuf-dma-sg.c
index 46ff19df9f53..8dd0562de287 100644
--- a/drivers/media/v4l2-core/videobuf-dma-sg.c
+++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
@@ -180,7 +180,7 @@ static int videobuf_dma_init_user_locked(struct videobuf_dmabuf *dma,
 	if (rw == READ)
 		flags |= FOLL_WRITE;
 
-	dprintk(1, "init user [0x%lx+0x%lx => %d pages]\n",
+	dprintk(1, "init user [0x%lx+0x%lx => %lu pages]\n",
 		data, size, dma->nr_pages);
 
 	err = pin_user_pages(data & PAGE_MASK, dma->nr_pages,
@@ -188,7 +188,7 @@ static int videobuf_dma_init_user_locked(struct videobuf_dmabuf *dma,
 
 	if (err != dma->nr_pages) {
 		dma->nr_pages = (err >= 0) ? err : 0;
-		dprintk(1, "pin_user_pages: err=%d [%d]\n", err,
+		dprintk(1, "pin_user_pages: err=%d [%lu]\n", err,
 			dma->nr_pages);
 		return err < 0 ? err : -EINVAL;
 	}
@@ -208,11 +208,11 @@ static int videobuf_dma_init_user(struct videobuf_dmabuf *dma, int direction,
 }
 
 static int videobuf_dma_init_kernel(struct videobuf_dmabuf *dma, int direction,
-			     int nr_pages)
+				    unsigned long nr_pages)
 {
 	int i;
 
-	dprintk(1, "init kernel [%d pages]\n", nr_pages);
+	dprintk(1, "init kernel [%lu pages]\n", nr_pages);
 
 	dma->direction = direction;
 	dma->vaddr_pages = kcalloc(nr_pages, sizeof(*dma->vaddr_pages),
@@ -238,11 +238,11 @@ static int videobuf_dma_init_kernel(struct videobuf_dmabuf *dma, int direction,
 	dma->vaddr = vmap(dma->vaddr_pages, nr_pages, VM_MAP | VM_IOREMAP,
 			  PAGE_KERNEL);
 	if (NULL == dma->vaddr) {
-		dprintk(1, "vmalloc_32(%d pages) failed\n", nr_pages);
+		dprintk(1, "vmalloc_32(%lu pages) failed\n", nr_pages);
 		goto out_free_pages;
 	}
 
-	dprintk(1, "vmalloc is at addr %p, size=%d\n",
+	dprintk(1, "vmalloc is at addr %p, size=%lu\n",
 		dma->vaddr, nr_pages << PAGE_SHIFT);
 
 	memset(dma->vaddr, 0, nr_pages << PAGE_SHIFT);
@@ -267,9 +267,9 @@ static int videobuf_dma_init_kernel(struct videobuf_dmabuf *dma, int direction,
 }
 
 static int videobuf_dma_init_overlay(struct videobuf_dmabuf *dma, int direction,
-			      dma_addr_t addr, int nr_pages)
+			      dma_addr_t addr, unsigned long nr_pages)
 {
-	dprintk(1, "init overlay [%d pages @ bus 0x%lx]\n",
+	dprintk(1, "init overlay [%lu pages @ bus 0x%lx]\n",
 		nr_pages, (unsigned long)addr);
 	dma->direction = direction;
 
@@ -500,9 +500,11 @@ static int __videobuf_iolock(struct videobuf_queue *q,
 			     struct videobuf_buffer *vb,
 			     struct v4l2_framebuffer *fbuf)
 {
-	int err, pages;
-	dma_addr_t bus;
 	struct videobuf_dma_sg_memory *mem = vb->priv;
+	unsigned long pages;
+	dma_addr_t bus;
+	int err;
+
 	BUG_ON(!mem);
 
 	MAGIC_CHECK(mem->magic, MAGIC_SG_MEM);
diff --git a/include/media/videobuf-dma-sg.h b/include/media/videobuf-dma-sg.h
index 34450f7ad510..930ff8d454fc 100644
--- a/include/media/videobuf-dma-sg.h
+++ b/include/media/videobuf-dma-sg.h
@@ -60,7 +60,7 @@ struct videobuf_dmabuf {
 	/* common */
 	struct scatterlist  *sglist;
 	int                 sglen;
-	int                 nr_pages;
+	unsigned long       nr_pages;
 	int                 direction;
 };
 
-- 
2.26.2

