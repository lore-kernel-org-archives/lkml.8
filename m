Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC55C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D271206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDZmjQfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgFHMzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:55:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50963 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729268AbgFHMxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWXM+ipVrzQXYONFpt3zkOQmQtQZ231iT3DOSd7IMMo=;
        b=LDZmjQfxgrERNODrKN5vco4R+VcPjQkq+hkLns3T4piqfjDZ3mqXf/TqSSU3hXqFrTuEdm
        jMECf3RGgTiA9BlDnVnC69D4L5x1iZvbiiv236ZbHbHs44zsXIleWiNxlRI3MbQS3ml7vl
        HCwipz8rKAWmxx9eboixGDx6yGZ/lzg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-jrL9QHdFOE6niMHwUxm_5Q-1; Mon, 08 Jun 2020 08:53:01 -0400
X-MC-Unique: jrL9QHdFOE6niMHwUxm_5Q-1
Received: by mail-wr1-f72.google.com with SMTP id h6so7166640wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWXM+ipVrzQXYONFpt3zkOQmQtQZ231iT3DOSd7IMMo=;
        b=PBpjRGLz70TDZ5Zb+654J3UZw6+qjuFnGYdeAMiKsCwqE7Zz8OyWjdYWpCfeQMVPP9
         jx/kf+PFlAZMw/EDXaqQWTCctuQyHReIu8S/wfPSXDIcCZTsRyB85Nya30BrAqjz995r
         NGFmMN4EDXKJgFo67zggihIX2IhGKnr1p3UtRiKoI8IYbsGo4xSlaXgi3HvdJ5fJZYFC
         5VrHTNQJxwoiXGbsLRYILyDrGJSgMwkz/nEnlZPiVlPxeNdA3OE23iYUhquuxQxFhP8U
         1ZXd9mVobxxZuL2TtTHZDjh7pgiMgTj3irdnGk9iVORvWtzffl8QCruujv/uTJnp14nJ
         vTAg==
X-Gm-Message-State: AOAM5306ivwB+VcoFfd7746MAexQvOLFJW08RDH3KsrIFbReEuq91MdW
        TgK+0Nwa09fcHiGrDaLbQxHLv4MJiTRUNm+/6Md/vnRsRusuCc+5GNUP7oiFEnQ3Poc7GucXp5d
        WWIsKnZYRQTruXi+UnN2XFTPt
X-Received: by 2002:a1c:2002:: with SMTP id g2mr15880273wmg.132.1591620780152;
        Mon, 08 Jun 2020 05:53:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5q+0SXDT6Wdos2frrb3vvZ3yL2SrO2xQj04+9m7aTyGYJfEoe809o7V4AZJBXuQ14Gp89bw==
X-Received: by 2002:a1c:2002:: with SMTP id g2mr15880253wmg.132.1591620779909;
        Mon, 08 Jun 2020 05:52:59 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id q11sm23292226wrv.67.2020.06.08.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:52:59 -0700 (PDT)
Date:   Mon, 8 Jun 2020 08:52:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v6 03/11] vhost/net: pass net specific struct pointer
Message-ID: <20200608125238.728563-4-mst@redhat.com>
References: <20200608125238.728563-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608125238.728563-1-mst@redhat.com>
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

