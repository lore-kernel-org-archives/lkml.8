Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D43C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E2220753
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKAqgXTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgDFW0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:26:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20764 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbgDFW0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586212009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=EKAqgXTrXHwNbpuwSlnn546IaTnylXUaf2OZ8Z4EpgzKxG4uggne0SJTvydAJVqvfN5SwR
        g5aKhhby0rrz2mHa6mlLxJN+1qqJw0+HkymTprG4KItUlP1gEeRjGE+clGC2n3vd/Y5QwM
        t3G72ZVXULN7P+8j9r0bR7xiuJshwvY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-7PvFK9V4PCWq6denH9CBCA-1; Mon, 06 Apr 2020 18:26:47 -0400
X-MC-Unique: 7PvFK9V4PCWq6denH9CBCA-1
Received: by mail-wr1-f70.google.com with SMTP id y1so653672wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=JGx1OXtl1F6L9hJP40bheA049pgb+fpuUxcbTv35xPoVRT6kO6QrjJ68psp8D3bK2r
         i2gGnLDATWqbESUgZ5bvmRkp9ycCe9iL2ekNsaKwEP7Wc0Ar/QQ7QzTmxROLO/J3qIbl
         hUpefLjygFnlILrqLPCniAMfEe0zFh4UfI72t+EnFOEL486aECfQlXHF9xN9Kv1TtRsD
         C8IZUpq7xr8Iyi+OUbwdPHH8w+J246uS20UDtSVtoEJQuRieFjJSV+OVdTqy7vFtPX4L
         xYUNLQCfXkE88ulRZDGgW+lbqgw8AGoBqEeaSUvG9nuH1gGehDsG1aQOxnWKIJflMSMD
         BesQ==
X-Gm-Message-State: AGi0PuZf2W9y6fTgHv2RMoF7kiu/fzKLzpTo1xT/AOzgSkQkjlK3UL7u
        RgyxOcDRNhlLn2PEVm1lRK6LMAMT/kf34GmtHC4YFhmsLZb3L5w29oHsj26q/TMAqLQbOGfmgpe
        WP6NgD6p5W9cS9BHcQEaDQdGl
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr1419731wrs.13.1586212006474;
        Mon, 06 Apr 2020 15:26:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypIkxBLu25fw45zb5jREJzls/InwdOIvj/VbUKyPwLvD/Yfz07D3HJPIah6ye0egaH0TNBseBQ==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr1419719wrs.13.1586212006287;
        Mon, 06 Apr 2020 15:26:46 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id q14sm26442191wrx.57.2020.04.06.15.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:26:45 -0700 (PDT)
Date:   Mon, 6 Apr 2020 18:26:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 08/12] virtio_ring: switch to virtio_legacy_init/size
Message-ID: <20200406222507.281867-9-mst@redhat.com>
References: <20200406222507.281867-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406222507.281867-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used for legacy ring format, switch to APIs
that make this explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58b96baa8d48..2a2b12449bac 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -867,8 +867,10 @@ static struct virtqueue *vring_create_virtqueue_split(
 	}
 
 	/* TODO: allocate each queue chunk individually */
-	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
-		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+	for (; num && vring_legacy_size(num, vring_align) > PAGE_SIZE;
+	     num /= 2) {
+		queue = vring_alloc_queue(vdev,
+					  vring_legacy_size(num, vring_align),
 					  &dma_addr,
 					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 		if (queue)
@@ -882,14 +884,15 @@ static struct virtqueue *vring_create_virtqueue_split(
 
 	if (!queue) {
 		/* Try to get a single page. You are my only hope! */
-		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+		queue = vring_alloc_queue(vdev,
+					  vring_legacy_size(num, vring_align),
 					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
 	}
 	if (!queue)
 		return NULL;
 
-	queue_size_in_bytes = vring_size(num, vring_align);
-	vring_init(&vring, num, queue, vring_align);
+	queue_size_in_bytes = vring_legacy_size(num, vring_align);
+	vring_legacy_init(&vring, num, queue, vring_align);
 
 	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
 				   notify, callback, name);
@@ -2169,7 +2172,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return NULL;
 
-	vring_init(&vring, num, pages, vring_align);
+	vring_legacy_init(&vring, num, pages, vring_align);
 	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
 				     notify, callback, name);
 }
-- 
MST

