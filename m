Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955DCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD04206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFVbbcMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgHET2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:28:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34843 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728607AbgHERLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z+ItaiktMWQThwK9MNBEGmvl3xKPTH4X3U+c0Slx6t4=;
        b=bFVbbcMyiR47CdBlw8JX7LALxpSMiOqWJKOC+oV771BVWtum0zCn7xvcK82E98ECPA4LUW
        bnPikVqKpvWc5i02dudJn5sGFC6AUCguSGqS0yO6ye+YpcP9Xx5U2ULRcZDibSK6RWisLv
        qVhxraibeWL/Q6t3ta+vzfuFI51ckOQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-QRDlC3cuPbKC6shZqIivNQ-1; Wed, 05 Aug 2020 09:44:17 -0400
X-MC-Unique: QRDlC3cuPbKC6shZqIivNQ-1
Received: by mail-wm1-f71.google.com with SMTP id i15so2471740wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z+ItaiktMWQThwK9MNBEGmvl3xKPTH4X3U+c0Slx6t4=;
        b=gk/u02svT0cAK31V174eLkqdzz3vzCoGlmaHn+JJNG+bmyoIQtZAwMyZgKNHyKW3bh
         mo/XWevDbW5EE4dGaNLcdTEFJdZ9hy3To+rZZepxto1U5Z7r5n9VCQ8u74omxzoift+Y
         ZFzbiZGVMn1dIyPA4E3rILOXYgMP/He6U3n1LfN4ZhsfTqlplMNt430D86+ThUa4/rTK
         UVSkmhewWmRmFaomEN/F6Wz0V2lUgHJsqBPK0UylseTzM1zAsNF51Tmoolb1YRScsmZc
         3yoxceJNORl+mHnd8RME/OMb6THI8KS81uspmoN1/uxkzQlIcCrCId+XWdu16dzsS7gt
         BPjg==
X-Gm-Message-State: AOAM5331U8nU8jDRIHkdwGFNHGl83jGQh/kj2eQD/Q/WkiSjSXlkYoRn
        uS78PtISqf0Cae8lXUDnIaPXb5zmoyaevfaSQ6KpLGmj+xVmkO7PKVdXKGJM2pyV1Hpxayq+QOE
        8f4zPObCpAmwOe/f3mbAN59+g
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr3074174wrx.357.1596635055367;
        Wed, 05 Aug 2020 06:44:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvA+Frs/2FvOknz7TvvmpwiVR+bgI+oEORnEClWTDh1sDHeItL0iJ+Rvz1Zn02P4rB2YHxLQ==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr3074160wrx.357.1596635055122;
        Wed, 05 Aug 2020 06:44:15 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id k1sm2780743wrw.91.2020.08.05.06.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:14 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 21/38] virtio_vdpa: legacy features handling
Message-ID: <20200805134226.1106164-22-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
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

