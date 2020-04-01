Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24856C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEF9206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WY+xMh9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbgDAQvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:51:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47097 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389175AbgDAQvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585759877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gdTaOIE7tD6LkJdCn+pe1n6Y0DWtGxJuzhgJo7to01o=;
        b=WY+xMh9S7UBK8/cAl4504vMs65r7EnokalaOmrDKG6mDABwJ+KouQB7nKD7TVbS94fVlPM
        8O4ZtUgtfZFqdQgdN1D/JsZtGtuWUvpuQTcT/5W+jI9KZwasWY+fymTg4U2iFRVx2Qpmqg
        edUP1LT1zTrvLQeuKh+q04hmtKVx0GE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-MRVWR-J1Ma-i_Wot-5dVbw-1; Wed, 01 Apr 2020 12:51:15 -0400
X-MC-Unique: MRVWR-J1Ma-i_Wot-5dVbw-1
Received: by mail-wm1-f72.google.com with SMTP id f9so205748wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=gdTaOIE7tD6LkJdCn+pe1n6Y0DWtGxJuzhgJo7to01o=;
        b=AMjzo8DDII5W6MnL7Wl6t8pVmHPB0NQ/ozoSPf6N8iLaSIRhyN7dgxlYnP9x7ru+SV
         d3mCZon8c8lq9f9RvTvnAnvHxiWvdMXkw14dlfXLZjhy6kcyTVKyulSGYb4Gps5ZKHxE
         E7UY3c4ucBtYZPytvBN8GcVJxoJt7S6jORbqCfv9XX92LQn7WZOsmT6wbBeUS8BsyD3t
         0SNjilFIX1s7qbMrD4qbPOH1O8YxBisbmN56gRfzPy/64k3Acts7sDiZTfYQU5E0dJBp
         05m5Sf3za3AmMMbyjAFrXn7QZBCe6Dk3o7I1NUxCOJPO2YfuiR8zUXS3mGkqOmdpCIqR
         JkHA==
X-Gm-Message-State: ANhLgQ0nTDTG4s//vmfvXld63aXjCc6U8OzqTnC2diaoCgwH3NXgPZkU
        RKDuX/UETaoLhd4fIVW12WtHoSsOC6rZw50i1x4D9KRB2JHhT8sc4fGjP6MB2T/nfER6CNFCBbk
        U/o0GrZwhT0uFePLKJsnF+IEt
X-Received: by 2002:a5d:400d:: with SMTP id n13mr26967270wrp.396.1585759873769;
        Wed, 01 Apr 2020 09:51:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvJ0pgx1SXPbI4O/8Day6ptgGE9mSEX0BpL2/jsBTqjtCm3uyzZttDISrsxNqevsV0Dl4mtNQ==
X-Received: by 2002:a5d:400d:: with SMTP id n13mr26967250wrp.396.1585759873521;
        Wed, 01 Apr 2020 09:51:13 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id z12sm3729253wrt.27.2020.04.01.09.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:51:12 -0700 (PDT)
Date:   Wed, 1 Apr 2020 12:51:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: [PATCH] virtio/test: fix up after IOTLB changes
Message-ID: <20200401165100.276039-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow building vringh without IOTLB (that's the case for userspace
builds, will be useful for CAIF/VOD down the road too).
Update for API tweaks.
Don't include vringh with kernel builds.

Cc: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/test.c   | 4 ++--
 drivers/vhost/vringh.c | 5 +++++
 include/linux/vringh.h | 2 ++
 tools/virtio/Makefile  | 3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 394e2e5c772d..9a3a09005e03 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -120,7 +120,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
 	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
 	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
 	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
-		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT);
+		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
 
 	f->private_data = n;
 
@@ -225,7 +225,7 @@ static long vhost_test_reset_owner(struct vhost_test *n)
 {
 	void *priv = NULL;
 	long err;
-	struct vhost_umem *umem;
+	struct vhost_iotlb *umem;
 
 	mutex_lock(&n->dev.mutex);
 	err = vhost_dev_check_owner(&n->dev);
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index ee0491f579ac..878e565dfffe 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -13,9 +13,11 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#ifdef VHOST_IOTLB
 #include <linux/bvec.h>
 #include <linux/highmem.h>
 #include <linux/vhost_iotlb.h>
+#endif
 #include <uapi/linux/virtio_config.h>
 
 static __printf(1,2) __cold void vringh_bad(const char *fmt, ...)
@@ -1059,6 +1061,8 @@ int vringh_need_notify_kern(struct vringh *vrh)
 }
 EXPORT_SYMBOL(vringh_need_notify_kern);
 
+#ifdef VHOST_IOTLB
+
 static int iotlb_translate(const struct vringh *vrh,
 			   u64 addr, u64 len, struct bio_vec iov[],
 			   int iov_size, u32 perm)
@@ -1416,5 +1420,6 @@ int vringh_need_notify_iotlb(struct vringh *vrh)
 }
 EXPORT_SYMBOL(vringh_need_notify_iotlb);
 
+#endif
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index bd0503ca6f8f..ebff121c0b02 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -14,8 +14,10 @@
 #include <linux/virtio_byteorder.h>
 #include <linux/uio.h>
 #include <linux/slab.h>
+#ifdef VHOST_IOTLB
 #include <linux/dma-direction.h>
 #include <linux/vhost_iotlb.h>
+#endif
 #include <asm/barrier.h>
 
 /* virtio_ring with information needed for host access. */
diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index f33f32f1d208..d3f152f4660b 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -22,7 +22,8 @@ OOT_CONFIGS=\
 	CONFIG_VHOST=m \
 	CONFIG_VHOST_NET=n \
 	CONFIG_VHOST_SCSI=n \
-	CONFIG_VHOST_VSOCK=n
+	CONFIG_VHOST_VSOCK=n \
+	CONFIG_VHOST_RING=n
 OOT_BUILD=KCFLAGS="-I "${OOT_VHOST} ${MAKE} -C ${OOT_KSRC} V=${V}
 oot-build:
 	echo "UNSUPPORTED! Don't use the resulting modules in production!"
-- 
MST

