Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983FFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758B6206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJhJV/pY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgFBNIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:08:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39991 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728133AbgFBNGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591103171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LMo2drqoQTmF0s7z53vtXvrX6v2dv44a7nAUfjbkZzI=;
        b=MJhJV/pY/dJhw05zgn/ytpVYZuqbJqeGnOAWBWLMDJ54HTSIMO9H5EDLtJE+s8w6mIYYgG
        HPgfd8OBeI0ie3CTpmZhEWnsmHa/ZVtRg/+7W6AxeEt187eJNlp1pUqT2nKqtLgYNNzsa2
        2neHmpElHuqh8J25UdWNqFLXrXsR6Ug=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-iyaz0AFqPamxR-cCweSKTw-1; Tue, 02 Jun 2020 09:06:09 -0400
X-MC-Unique: iyaz0AFqPamxR-cCweSKTw-1
Received: by mail-wm1-f72.google.com with SMTP id u15so821239wmm.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LMo2drqoQTmF0s7z53vtXvrX6v2dv44a7nAUfjbkZzI=;
        b=ATTTm9qvat9CbAKAigOGiNve5v8UQNlT5Qgk7BF3zxS9eahVdWjgTZZHwqcjyivV/i
         IJYOMWFoUkYPRGPPc81izAE/JqKX4gZTYS9sEmtWYE9W7SnH5Fd/rZBSSLqXc3zwPSOk
         4m/+u19KKEE+OPxNBzRtHbKBk9opuLUQjbf6FMfWpH8//IufeKnjGkLcofGLsirehGbT
         qxF/UhCVKhLzJ7byeuzu/JSac99REaA344vTUXX2QvOumxpp/h0yTr8Mg7I5UIRl+tLN
         mClmdkWOZPTnivqWfrhsKnp2NNz4XZnLZWkAi88qyINGmGF2XOgK/sZSFh1kkw7iawbE
         YLRA==
X-Gm-Message-State: AOAM533YvDvjgQpaZwPGUBTj6tt29l6mJzqn/C4DFtAHZcJsdGQyY1Xi
        rOaUJ2q3SFjjiCyt/Y/j2SrulIo8rJFuAB14Qvw9KDRBFYf5+JAt+U476bvWStkhNtwAHdTI0Tv
        q5t9HbfCpP2tU7IilN2iL8RnX
X-Received: by 2002:adf:f988:: with SMTP id f8mr28409412wrr.81.1591103168347;
        Tue, 02 Jun 2020 06:06:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG9bw3Ul7VoJ7lrSM6JnY068u1IXNEEmqvhm6cdNr9QfAcz0IRu5Ie8ZlB9aURJhAs2bO3EA==
X-Received: by 2002:adf:f988:: with SMTP id f8mr28409395wrr.81.1591103168152;
        Tue, 02 Jun 2020 06:06:08 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id t129sm3890953wmf.41.2020.06.02.06.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 06:06:07 -0700 (PDT)
Date:   Tue, 2 Jun 2020 09:06:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH RFC 05/13] vhost/net: pass net specific struct pointer
Message-ID: <20200602130543.578420-6-mst@redhat.com>
References: <20200602130543.578420-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602130543.578420-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
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
index 2927f02cc7e1..749a9cf51a59 100644
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

