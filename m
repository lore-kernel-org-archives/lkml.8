Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A019DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D3E20872
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVWt4/gF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgFBNGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:06:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50179 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727993AbgFBNGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591103167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3IWgXNVKogl+PigLuUvA2+zzqi/klGlvqGa6EgR6oPQ=;
        b=EVWt4/gFjHA6v8tMhMNYG9iuBpY3SS82N65gpwR9EVfEhFFZSVUelGEyBAbaUa1lT6ssBm
        AIx9OS1t/7WeYeCGu84rqkydv8g+SqX8DXA7qzEZN4mlhWMouooDfm8XAsrf/CCwMxK+fq
        1xCVlXCAZmieZ+9mkPT0gP8bkbU8VmE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-kenx9ne8Oum-eMf6kStKSg-1; Tue, 02 Jun 2020 09:06:05 -0400
X-MC-Unique: kenx9ne8Oum-eMf6kStKSg-1
Received: by mail-wr1-f71.google.com with SMTP id o1so1361097wrm.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3IWgXNVKogl+PigLuUvA2+zzqi/klGlvqGa6EgR6oPQ=;
        b=Vb6ykRX+88tSlDAs1PWGPaaqxg6ZEK1jQ0qupsHaHPBlqJVQUXI1k/npJYT0xiBiCb
         qd/WOAr938HIhUXqtMsOCQQedoTi+ORGQ3xD3VRt1lSEgtdD4StWVW0hNNRLHctRoh/w
         o8+oNppcbweBVxzMedwuwlPdWH2Tsx3C48MIaSjZmZiweyaLCXQEw9NYJPPWppBZD+MI
         eIOXr1vtQ8zsaBzz5BdOAPlrWipG1F3U8MxxeIOc3feNiNr9L8RloJXI3DCW8jCjHBfS
         Bf/bafG+9GoAj1QZVBvw48uWFCZ8YKT9gehIwTsqxXzr4oZGG1A34YBy28Wj4XzvkZ2Z
         dUvA==
X-Gm-Message-State: AOAM531yJ3O/VbYssNOf+lb63frNBddDA+YqmBxdy9kv6E7ZrTK6pMsL
        c54Bj4HyA+AM53W6udCFjNdLwfIV1SbJjkY6R8UxEveQO5t/5sgGRrqidGHTkyZWpKkGprKG+s4
        iiteXoopZ7gjFeDcmMWfC+M7k
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr26457241wrs.202.1591103163732;
        Tue, 02 Jun 2020 06:06:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbDJW9yzQN1NiCWnH3a4CKeN9AHsOoJMM0ESrlqkyLlEv5xh7pLBJWYQkMdgeqlIVO4xG2Fw==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr26457209wrs.202.1591103163391;
        Tue, 02 Jun 2020 06:06:03 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id a3sm3462243wmb.7.2020.06.02.06.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 06:06:02 -0700 (PDT)
Date:   Tue, 2 Jun 2020 09:06:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH RFC 03/13] vhost: batching fetches
Message-ID: <20200602130543.578420-4-mst@redhat.com>
References: <20200602130543.578420-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200602130543.578420-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch applied, new and old code perform identically.

Lots of extra optimizations are now possible, e.g.
we can fetch multiple heads with copy_from/to_user now.
We can get rid of maintaining the log array.  Etc etc.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Link: https://lore.kernel.org/r/20200401183118.8334-4-eperezma@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/test.c  |  2 +-
 drivers/vhost/vhost.c | 47 ++++++++++++++++++++++++++++++++++++++-----
 drivers/vhost/vhost.h |  5 ++++-
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 9a3a09005e03..02806d6f84ef 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -119,7 +119,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
 	dev = &n->dev;
 	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
 	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
-	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
+	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
 		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
 
 	f->private_data = n;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8f9a07282625..aca2a5b0d078 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -299,6 +299,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 {
 	vq->num = 1;
 	vq->ndescs = 0;
+	vq->first_desc = 0;
 	vq->desc = NULL;
 	vq->avail = NULL;
 	vq->used = NULL;
@@ -367,6 +368,11 @@ static int vhost_worker(void *data)
 	return 0;
 }
 
+static int vhost_vq_num_batch_descs(struct vhost_virtqueue *vq)
+{
+	return vq->max_descs - UIO_MAXIOV;
+}
+
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
 {
 	kfree(vq->descs);
@@ -389,6 +395,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
 	for (i = 0; i < dev->nvqs; ++i) {
 		vq = dev->vqs[i];
 		vq->max_descs = dev->iov_limit;
+		if (vhost_vq_num_batch_descs(vq) < 0) {
+			return -EINVAL;
+		}
 		vq->descs = kmalloc_array(vq->max_descs,
 					  sizeof(*vq->descs),
 					  GFP_KERNEL);
@@ -1570,6 +1579,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 		vq->last_avail_idx = s.num;
 		/* Forget the cached index value. */
 		vq->avail_idx = vq->last_avail_idx;
+		vq->ndescs = vq->first_desc = 0;
 		break;
 	case VHOST_GET_VRING_BASE:
 		s.index = idx;
@@ -2136,7 +2146,7 @@ static int fetch_indirect_descs(struct vhost_virtqueue *vq,
 	return 0;
 }
 
-static int fetch_descs(struct vhost_virtqueue *vq)
+static int fetch_buf(struct vhost_virtqueue *vq)
 {
 	unsigned int i, head, found = 0;
 	struct vhost_desc *last;
@@ -2149,7 +2159,11 @@ static int fetch_descs(struct vhost_virtqueue *vq)
 	/* Check it isn't doing very strange things with descriptor numbers. */
 	last_avail_idx = vq->last_avail_idx;
 
-	if (vq->avail_idx == vq->last_avail_idx) {
+	if (unlikely(vq->avail_idx == vq->last_avail_idx)) {
+		/* If we already have work to do, don't bother re-checking. */
+		if (likely(vq->ndescs))
+			return vq->num;
+
 		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
 			vq_err(vq, "Failed to access avail idx at %p\n",
 				&vq->avail->idx);
@@ -2240,6 +2254,24 @@ static int fetch_descs(struct vhost_virtqueue *vq)
 	return 0;
 }
 
+static int fetch_descs(struct vhost_virtqueue *vq)
+{
+	int ret = 0;
+
+	if (unlikely(vq->first_desc >= vq->ndescs)) {
+		vq->first_desc = 0;
+		vq->ndescs = 0;
+	}
+
+	if (vq->ndescs)
+		return 0;
+
+	while (!ret && vq->ndescs <= vhost_vq_num_batch_descs(vq))
+		ret = fetch_buf(vq);
+
+	return vq->ndescs ? 0 : ret;
+}
+
 /* This looks in the virtqueue and for the first available buffer, and converts
  * it to an iovec for convenient access.  Since descriptors consist of some
  * number of output then some number of input descriptors, it's actually two
@@ -2265,7 +2297,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	if (unlikely(log))
 		*log_num = 0;
 
-	for (i = 0; i < vq->ndescs; ++i) {
+	for (i = vq->first_desc; i < vq->ndescs; ++i) {
 		unsigned iov_count = *in_num + *out_num;
 		struct vhost_desc *desc = &vq->descs[i];
 		int access;
@@ -2311,14 +2343,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 		}
 
 		ret = desc->id;
+
+		if (!(desc->flags & VRING_DESC_F_NEXT))
+			break;
 	}
 
-	vq->ndescs = 0;
+	vq->first_desc = i + 1;
 
 	return ret;
 
 err:
-	vhost_discard_vq_desc(vq, 1);
+	for (i = vq->first_desc; i < vq->ndescs; ++i)
+		if (!(vq->descs[i].flags & VRING_DESC_F_NEXT))
+			vhost_discard_vq_desc(vq, 1);
 	vq->ndescs = 0;
 
 	return ret;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 76356edee8e5..a67bda9792ec 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -81,6 +81,7 @@ struct vhost_virtqueue {
 
 	struct vhost_desc *descs;
 	int ndescs;
+	int first_desc;
 	int max_descs;
 
 	struct file *kick;
@@ -229,7 +230,7 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
 			  struct vhost_iotlb_map *map);
 
 #define vq_err(vq, fmt, ...) do {                                  \
-		pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
+		pr_err(pr_fmt(fmt), ##__VA_ARGS__);       \
 		if ((vq)->error_ctx)                               \
 				eventfd_signal((vq)->error_ctx, 1);\
 	} while (0)
@@ -255,6 +256,8 @@ static inline void vhost_vq_set_backend(struct vhost_virtqueue *vq,
 					void *private_data)
 {
 	vq->private_data = private_data;
+	vq->ndescs = 0;
+	vq->first_desc = 0;
 }
 
 /**
-- 
MST

