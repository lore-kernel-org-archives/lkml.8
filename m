Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE51C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4591820784
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GulRuYGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440023AbgDPH6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:58:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57628 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440855AbgDPH5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587023837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gavfKGuNl7br7RXb7XSyuq0WG8m5khS0l1y8vD9u01c=;
        b=GulRuYGBPO3GKZZ3vVaKdwTf+2teZmKB10XlvZ3Au4qrdYVh4fIxL5I4bEfRKmeuXrlWpb
        5EfU89ehCuO1vBYefLmbIORDDG5w1ZSAFPkJoZIk2hB1Lx8D4JCo0hnBWxZBzTvqaeTQNi
        6aKwqtxN3BrV7/nbS3ooVBI+MYR1bqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-tkGFXRgxOSOh6b_CqJMs6A-1; Thu, 16 Apr 2020 03:57:13 -0400
X-MC-Unique: tkGFXRgxOSOh6b_CqJMs6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C72601005509;
        Thu, 16 Apr 2020 07:57:11 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-112-194.ams2.redhat.com [10.36.112.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67EA37E7C0;
        Thu, 16 Apr 2020 07:57:06 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/8] tools/virtio: Extract virtqueue initialization in vq_reset
Date:   Thu, 16 Apr 2020 09:56:41 +0200
Message-Id: <20200416075643.27330-7-eperezma@redhat.com>
In-Reply-To: <20200416075643.27330-1-eperezma@redhat.com>
References: <20200416075643.27330-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we can reset after that in the main loop.

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 tools/virtio/virtio_test.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index d9827b640c21..18d5347003eb 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -95,6 +95,19 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_i=
nfo *info)
 	assert(r >=3D 0);
 }
=20
+static void vq_reset(struct vq_info *info, int num, struct virtio_device=
 *vdev)
+{
+	if (info->vq)
+		vring_del_virtqueue(info->vq);
+
+	memset(info->ring, 0, vring_legacy_size(num, 4096));
+	vring_legacy_init(&info->vring, num, info->ring, 4096);
+	info->vq =3D __vring_new_virtqueue(info->idx, info->vring, vdev, true,
+					 false, vq_notify, vq_callback, "test");
+	assert(info->vq);
+	info->vq->priv =3D info;
+}
+
 static void vq_info_add(struct vdev_info *dev, int num)
 {
 	struct vq_info *info =3D &dev->vqs[dev->nvqs];
@@ -104,13 +117,7 @@ static void vq_info_add(struct vdev_info *dev, int n=
um)
 	info->call =3D eventfd(0, EFD_NONBLOCK);
 	r =3D posix_memalign(&info->ring, 4096, vring_legacy_size(num, 4096));
 	assert(r >=3D 0);
-	memset(info->ring, 0, vring_legacy_size(num, 4096));
-	vring_legacy_init(&info->vring, num, info->ring, 4096);
-	info->vq =3D
-		__vring_new_virtqueue(info->idx, info->vring, &dev->vdev, true,
-				      false, vq_notify, vq_callback, "test");
-	assert(info->vq);
-	info->vq->priv =3D info;
+	vq_reset(info, num, &dev->vdev);
 	vhost_vq_setup(dev, info);
 	dev->fds[info->idx].fd =3D info->call;
 	dev->fds[info->idx].events =3D POLLIN;
--=20
2.18.1

