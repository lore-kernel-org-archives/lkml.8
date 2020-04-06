Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6F7C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A890206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xfq+bq9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgDFVCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:02:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51182 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726587AbgDFVCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586206936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=Xfq+bq9xJxUJwhO5oqsnI7RdrgZhlAq+WBXBRSJPjAWoN7phofc4DhoZYvXd1J2P8j3p+r
        13n+WM19sSz+pC42pJ9Re48du4bc30nHqHZo/yU+ikZMZ3rWTJxxlADzi8VeQAveBEtzH1
        oX5otkDVNBAUSDwndDDwFapjR2+z4uw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-Lr5FV8IYPA2o6n-DHyMORw-1; Mon, 06 Apr 2020 17:02:13 -0400
X-MC-Unique: Lr5FV8IYPA2o6n-DHyMORw-1
Received: by mail-wr1-f72.google.com with SMTP id h14so525133wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=pmQOM9tXX7GMj0hjmeuE1DDemt/d4FZcLIfPmpaB5zIlVdvtcwFKxfwlPnpH2I0FI3
         lweLsGd5TH6sg2rpO22W7R9Q8R8sV7oVQWwPZo5WvAXj36gZQkzTsn4HA6SlEldjq5uQ
         MEK2AJ9IKHyagxai2UlDxT/uwOuq0IisiK21mOFJPDzSspkvVWUV2XzBB0fw3dWX+ANU
         NQselTOqqtQrs/IGB/XoSCqdHr57Wk9kMfQ1pgy/e3tVgLzJ6T0xTUtvHsYWoz6mtGd1
         GV2BYFR6iEGDf/TJ1IXhkEITwAD+xGVEVcV5cXdM+n+AGhQeLTTWPY9ebUfG2MojAHMY
         7Aag==
X-Gm-Message-State: AGi0PuYImQgish9/exLq9bwv8ELIvHroGj7LNVQDRZp619/5UU3yuYkh
        2f7b10jMttT0A2G3p/2y7IenVSoYNdxHyEMxDrKLr3DjP3bL9jngaLFleYMODs6/G03iPccI1NC
        WkbNH4V8NnrPLnzn0ZQW4cGZt
X-Received: by 2002:a1c:6842:: with SMTP id d63mr1293526wmc.181.1586206930251;
        Mon, 06 Apr 2020 14:02:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypK46UeT7hSc7/FRw/ZfK/Alzzl0DsY/mlvbwQnLFFlZtyfm+3qIkxx4f3atLLdur2aq7jJVnA==
X-Received: by 2002:a1c:6842:: with SMTP id d63mr1293511wmc.181.1586206930056;
        Mon, 06 Apr 2020 14:02:10 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id w15sm18070870wra.25.2020.04.06.14.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:02:09 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:02:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 08/12] virtio_ring: switch to virtio_legacy_init/size
Message-ID: <20200406210108.148131-9-mst@redhat.com>
References: <20200406210108.148131-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406210108.148131-1-mst@redhat.com>
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

