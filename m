Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7907C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B117122C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+0UwmvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgHCVA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:00:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36789 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729184AbgHCVAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z+ItaiktMWQThwK9MNBEGmvl3xKPTH4X3U+c0Slx6t4=;
        b=G+0UwmvJaOAQJw8bKwpJLIiSX8lr5Ldh7RxKsrbD8eYLppg0u6r1HyiyM5We48OP5us+6N
        1ZOQYGv7VMnbgrThGaBe1EmMA+7M7jCPsjmz02vbWqdTnPLz+h1SiahncphwK1pwZCFVHD
        iPHcvLSNe58OWSQX9Wa2fqIo85FKrdE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-ZvyMqbxWPFipUUfGA4plkA-1; Mon, 03 Aug 2020 17:00:20 -0400
X-MC-Unique: ZvyMqbxWPFipUUfGA4plkA-1
Received: by mail-qv1-f71.google.com with SMTP id y30so457979qvy.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z+ItaiktMWQThwK9MNBEGmvl3xKPTH4X3U+c0Slx6t4=;
        b=AlcTLpZKyBxRvIx/Iapdan4sLQNa6kOoNz/r+4PAl/JFAQKqfxXSkpXUiUnfwUfwIH
         4mhPBTS7QJb2asBhh951Mux0cKbyX30E1R0H9TmqipwEajaSjRtqRFXBTvmFbCDyOuwh
         6ovKlflt69p1kDjlDnrBiHj5SKy9VxTTYhIA+OjDbLDUYaQQjvSh+oByYeT8kUDAiRvR
         GP3t9d/iik7yj4QNp1Sh1c4V9wPsU52JiMr3uiHBDGdYRZoNp7X5sk0ePEy8rmvEHzbi
         sA9HXRvJ4vo9z/4YbUNtJFBy0mti1042H19WTSify4KFcMAKoLSQ8+lnl7UdjlwEDy9S
         SIsA==
X-Gm-Message-State: AOAM532jLfRtsBJUHq6+yU+6+lvG1W6KcQ6R/PL7wDfYKdIob9n4ayGn
        42/m2t52+rtoP27ti0BaHFujJfQ4cEzLoAa9KgeU10biTyMy/yQH1TcptKQQBDgG5tFWOULK49v
        elJsCmitK9wgtLIM3KdgqqSDV
X-Received: by 2002:ac8:67c9:: with SMTP id r9mr18651351qtp.301.1596488419951;
        Mon, 03 Aug 2020 14:00:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzloXbOQAlj4ro+4XgmgIovn+tYHtggGdaX11HDzJFycK9jYjTdhtwEjKQPzQhIBulzPwzfyg==
X-Received: by 2002:ac8:67c9:: with SMTP id r9mr18651337qtp.301.1596488419750;
        Mon, 03 Aug 2020 14:00:19 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id i19sm19928319qkk.68.2020.08.03.14.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:00:19 -0700 (PDT)
Date:   Mon, 3 Aug 2020 17:00:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 21/24] virtio_vdpa: legacy features handling
Message-ID: <20200803205814.540410-22-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We normally expect vdpa to use the modern interface.
However for consistency, let's use same APIs as vhost
for legacy guests.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_vdpa.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index c30eb55030be..4a9ddb44b2a7 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -57,9 +57,8 @@ static void virtio_vdpa_get(struct virtio_device *vdev, unsigned offset,
 			    void *buf, unsigned len)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-	const struct vdpa_config_ops *ops = vdpa->config;
 
-	ops->get_config(vdpa, offset, buf, len);
+	vdpa_get_config(vdpa, offset, buf, len);
 }
 
 static void virtio_vdpa_set(struct virtio_device *vdev, unsigned offset,
@@ -101,9 +100,8 @@ static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
 static void virtio_vdpa_reset(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-	const struct vdpa_config_ops *ops = vdpa->config;
 
-	return ops->set_status(vdpa, 0);
+	vdpa_reset(vdpa);
 }
 
 static bool virtio_vdpa_notify(struct virtqueue *vq)
@@ -294,12 +292,11 @@ static u64 virtio_vdpa_get_features(struct virtio_device *vdev)
 static int virtio_vdpa_finalize_features(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-	const struct vdpa_config_ops *ops = vdpa->config;
 
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
-	return ops->set_features(vdpa, vdev->features);
+	return vdpa_set_features(vdpa, vdev->features);
 }
 
 static const char *virtio_vdpa_bus_name(struct virtio_device *vdev)
-- 
MST

