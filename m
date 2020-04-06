Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD839C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931912076E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZaTGOTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgDFVet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:34:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31005 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgDFVeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=GZaTGOTtrejNvlzfRcYIyML1jJLyDiMQ6gTzjHMbvUb6aiQ2T5eOzylhNipiTqUPwxQdm+
        1GeKv/E3YUopRtsB6kE3FpVXejSQKTbClsePysCyItd8HJ1ra+1t7GvG97ycLkaf1qs7r9
        m4mjhvmnKkiIvrQ7Jf5PJkHiX380ZFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-_VrVvl_oMSyRmoPDkecC0g-1; Mon, 06 Apr 2020 17:34:45 -0400
X-MC-Unique: _VrVvl_oMSyRmoPDkecC0g-1
Received: by mail-wm1-f72.google.com with SMTP id p18so174190wmk.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=o9KUCKusWwDEPuVS1cAD8QklaQx2gJGFTvxzaDtdPzXGZX+P2gdFDYArhhXXBtVCc8
         p5Ei43tKj05cA5B1nXPYg7lf5DTiPSP8g+6wvi7zvPgZ8M5rNc5gazhovJqJ6RHKGl5C
         hcPwHdbmtA0axiQ5di4SoaHZm4Sdq3K8ye+5VcQ6/OZudzQVqT6upaABIPI1grXlt4/y
         04Mkt7zzBwquKkkLHL6F+qK+QC+T0LZfQwQk9CeYldb2ohMmiGceAh94KrG0blbig35U
         +JINDJo1FWbqogcoIgMGNfYSW3/oBfxxj1haG2OWRHGN02AKOVCCi929ZhPn6GbAuiIR
         KqFA==
X-Gm-Message-State: AGi0PuYfHmJHa7gj16DLyhJdHvwujc0Gb3b97BX3EXmcjfj00S8RUxo9
        jmoEEMAXlfN7FsU7yoxFQV0sNUiu5wzAenOkE/E7aV96U+NdyBC0a6Q4h3Ax75vjHEkNDT1nFp2
        WZJY9tw7Q2eyrRsT0NZmwJFF2
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr1429058wrw.25.1586208883781;
        Mon, 06 Apr 2020 14:34:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypLw9se6vWJefI4H5bbFId9Y8QOH6OesSwNWQIfj42clOY+n7XvT5IlX8YIGGdhCgHehhTgWYQ==
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr1429045wrw.25.1586208883613;
        Mon, 06 Apr 2020 14:34:43 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id f16sm992522wmc.37.2020.04.06.14.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:43 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:41 -0400
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
Message-ID: <20200406213441.NT3uwBqQUtxIq9JeLuXQzBEnI6IgdMoR0Y4ETRYyqqk@z>

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

