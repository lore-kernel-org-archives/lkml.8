Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B174AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E89C2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdPLzp6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgFJLiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:38:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60316 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728610AbgFJLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591788971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWXM+ipVrzQXYONFpt3zkOQmQtQZ231iT3DOSd7IMMo=;
        b=XdPLzp6Yi30BzsB+GUxZyVsgKdzHqXb1MdeYINNj12as2B9d0qsMYNIAErN1wiaMr74/at
        XYjbnatuZLzicIlRy+0uefzMklC1aFn3DLlgxbEc3fsolEFPScLG/3uaBKFMaJ5yX9ilJM
        xmn+p8bapgeJNxm+y/FC2LUJioLI7S0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-i-pdOom-N8665eI7jjEAkA-1; Wed, 10 Jun 2020 07:36:09 -0400
X-MC-Unique: i-pdOom-N8665eI7jjEAkA-1
Received: by mail-wm1-f71.google.com with SMTP id b65so400815wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWXM+ipVrzQXYONFpt3zkOQmQtQZ231iT3DOSd7IMMo=;
        b=n7xuZCPCow6KB+0UwnMAeWUIF/1i4kAMgBDMTDuJIwc7WbgDzZcwMO0xzGRcuPBLlu
         VwmcMvnsCgFi8qlUfArTH9DdOuNdvQjSbHdZaPlh9bpAshDXe9+Nc5mGYLM/PR4mt7Sv
         ugsJGUbvgUIdF3MHP6ChLyRokj0d7AaGul6LCUz73psaOUvKulh6xRqJqCifstWw0LQt
         nqX2GB30P6EE2xSlwWPbeNa6cdhSNhhv94WvGV8MuKtzuXx6G98v2Q4RqmSFaX7XIhPf
         FnF1GrwSDVo8oOVh65N9nCjjcUeZ5AMuxwF0+/tUZnAqHtq+wNccQWc9jgvqxwve9uI1
         9uEQ==
X-Gm-Message-State: AOAM530wgMoSBmm9lVDrpY/X/IYYwk7pdA509/+0ZJ7Fr1BqrbsuYArb
        n+6bttZcCKBbyrfyrVZWGrhzBi/CKXswjCoZwAk529KdTt880/ArEyWvHujlTAkQwRcHSC3Y444
        LXPc0KePKQDhhjrZo0Q4GfrK2
X-Received: by 2002:adf:ea11:: with SMTP id q17mr3146827wrm.75.1591788968133;
        Wed, 10 Jun 2020 04:36:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+0YhjkTKfGeypFjYmQw4xelfruV1Ntm2M/rNlskwCxXmVD04EuumSwnMG+QPQp8710QWBNA==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr3146806wrm.75.1591788967929;
        Wed, 10 Jun 2020 04:36:07 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id a16sm7674114wrx.8.2020.06.10.04.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 04:36:07 -0700 (PDT)
Date:   Wed, 10 Jun 2020 07:36:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v7 04/14] vhost/net: pass net specific struct pointer
Message-ID: <20200610113515.1497099-5-mst@redhat.com>
References: <20200610113515.1497099-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610113515.1497099-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for further cleanup, pass net specific pointer
to ubuf callbacks so we can move net specific fields
out to net structures.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index bf5e1d81ae25..ff594eec8ae3 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -94,7 +94,7 @@ struct vhost_net_ubuf_ref {
 	 */
 	atomic_t refcount;
 	wait_queue_head_t wait;
-	struct vhost_virtqueue *vq;
+	struct vhost_net_virtqueue *nvq;
 };
 
 #define VHOST_NET_BATCH 64
@@ -231,7 +231,7 @@ static void vhost_net_enable_zcopy(int vq)
 }
 
 static struct vhost_net_ubuf_ref *
-vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
+vhost_net_ubuf_alloc(struct vhost_net_virtqueue *nvq, bool zcopy)
 {
 	struct vhost_net_ubuf_ref *ubufs;
 	/* No zero copy backend? Nothing to count. */
@@ -242,7 +242,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
 		return ERR_PTR(-ENOMEM);
 	atomic_set(&ubufs->refcount, 1);
 	init_waitqueue_head(&ubufs->wait);
-	ubufs->vq = vq;
+	ubufs->nvq = nvq;
 	return ubufs;
 }
 
@@ -384,13 +384,13 @@ static void vhost_zerocopy_signal_used(struct vhost_net *net,
 static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
 {
 	struct vhost_net_ubuf_ref *ubufs = ubuf->ctx;
-	struct vhost_virtqueue *vq = ubufs->vq;
+	struct vhost_net_virtqueue *nvq = ubufs->nvq;
 	int cnt;
 
 	rcu_read_lock_bh();
 
 	/* set len to mark this desc buffers done DMA */
-	vq->heads[ubuf->desc].len = success ?
+	nvq->vq.heads[ubuf->desc].in_len = success ?
 		VHOST_DMA_DONE_LEN : VHOST_DMA_FAILED_LEN;
 	cnt = vhost_net_ubuf_put(ubufs);
 
@@ -402,7 +402,7 @@ static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
 	 * less than 10% of times).
 	 */
 	if (cnt <= 1 || !(cnt % 16))
-		vhost_poll_queue(&vq->poll);
+		vhost_poll_queue(&nvq->vq.poll);
 
 	rcu_read_unlock_bh();
 }
@@ -1525,7 +1525,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	/* start polling new socket */
 	oldsock = vhost_vq_get_backend(vq);
 	if (sock != oldsock) {
-		ubufs = vhost_net_ubuf_alloc(vq,
+		ubufs = vhost_net_ubuf_alloc(nvq,
 					     sock && vhost_sock_zcopy(sock));
 		if (IS_ERR(ubufs)) {
 			r = PTR_ERR(ubufs);
-- 
MST

