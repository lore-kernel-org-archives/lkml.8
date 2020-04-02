Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C73FC2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557FC20784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjBk9VpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbgDBMza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:55:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42716 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388461AbgDBMz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585832127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=b1Y+MoZfKqZ6pUzsjF5bfD9YIuZIACPBLdpnZnNR+yE=;
        b=UjBk9VpIrWFBuhAzMwI673lkrRCYgtn5SlDnQJp+wCglwO9suwJlozNBBrGMAv9g/9dIvH
        cEi8lyX5L85Xa/ZI8GrDXBvgy2FaDMnKkNlai1JJfx+azc09o8sP5gIWBcsJ2DwtgGVTrI
        VauQLfopXmBBgF3m43ok6K3clUoo8bM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-Ea3Roas9PSu-y7t6w-2_-Q-1; Thu, 02 Apr 2020 08:55:26 -0400
X-MC-Unique: Ea3Roas9PSu-y7t6w-2_-Q-1
Received: by mail-qk1-f199.google.com with SMTP id w21so1421899qkj.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 05:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=b1Y+MoZfKqZ6pUzsjF5bfD9YIuZIACPBLdpnZnNR+yE=;
        b=bi2WTsfWW6dgf8dVCwcEDv0ILYyVjbBmBOdgMgfMjenNlyUhMQDDdmQdI+xUnsGJYB
         yR0tWtL3FvdFDZJgwdw9yJrLkiv4IZUJTH7cYFNiUKtQbtYqDthXPRZMUoPZjwhJGfX9
         nRoEOO/o0Wn+QA0j4vh+PvQK/YdSzuKiO5EHr72vy5nENMecmTXYOhZlwXKhflGDJVZF
         M3gg/RUzJH2Ys4Rve133MpElB4ZL1xQRc4PJVdTU8YaTmPxOMbPWPQ8IvRCswGe5P6qz
         wS9hsoNapyRz50g80glqVDWQxdYIAtGLcEZ2+wqmo8H7sIyiFKZ4N0LH2McIxNnRrMe8
         IqMQ==
X-Gm-Message-State: AGi0PuYUivW6D5gDDN3WkntYWqUCduiXnZ36nThPnV+JNVDGFiAzQZfl
        xcCX4GBqfmXzEBgyV6vKGstXKsreK6xEXD3Up9JeLtrASzO4+MzcX0hJhoWQJgg4jvqKKjDHIY4
        +hBal4WN+wG5VKeSWYAVV6Ko8
X-Received: by 2002:ac8:2a68:: with SMTP id l37mr2685100qtl.77.1585832125792;
        Thu, 02 Apr 2020 05:55:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypIXMZqUA9fKM7j4ZEayWbkOS+B21xqe6c1yw8l/odLb8QfoZiOhyPhHGMworIpfrO+SJx15Qg==
X-Received: by 2002:ac8:2a68:: with SMTP id l37mr2685076qtl.77.1585832125540;
        Thu, 02 Apr 2020 05:55:25 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id x37sm3672315qtc.90.2020.04.02.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:55:24 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:55:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: [PATCH v2] virtio/test: fix up after IOTLB changes
Message-ID: <20200402125406.9275-1-mst@redhat.com>
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
Don't include vringh with userspace builds.

Cc: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1:
	use IS_REACHEABLE to fix error reported by build bot

 drivers/vhost/test.c              | 4 ++--
 drivers/vhost/vringh.c            | 5 +++++
 include/linux/vringh.h            | 6 ++++++
 tools/virtio/Makefile             | 5 +++--
 tools/virtio/generated/autoconf.h | 0
 5 files changed, 16 insertions(+), 4 deletions(-)
 create mode 100644 tools/virtio/generated/autoconf.h

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
index ee0491f579ac..ba8e0d6cfd97 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -13,9 +13,11 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#if IS_REACHABLE(CONFIG_VHOST_IOTLB)
 #include <linux/bvec.h>
 #include <linux/highmem.h>
 #include <linux/vhost_iotlb.h>
+#endif
 #include <uapi/linux/virtio_config.h>
 
 static __printf(1,2) __cold void vringh_bad(const char *fmt, ...)
@@ -1059,6 +1061,8 @@ int vringh_need_notify_kern(struct vringh *vrh)
 }
 EXPORT_SYMBOL(vringh_need_notify_kern);
 
+#if IS_REACHABLE(CONFIG_VHOST_IOTLB)
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
index bd0503ca6f8f..9e2763d7c159 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -14,8 +14,10 @@
 #include <linux/virtio_byteorder.h>
 #include <linux/uio.h>
 #include <linux/slab.h>
+#if IS_REACHABLE(CONFIG_VHOST_IOTLB)
 #include <linux/dma-direction.h>
 #include <linux/vhost_iotlb.h>
+#endif
 #include <asm/barrier.h>
 
 /* virtio_ring with information needed for host access. */
@@ -254,6 +256,8 @@ static inline __virtio64 cpu_to_vringh64(const struct vringh *vrh, u64 val)
 	return __cpu_to_virtio64(vringh_is_little_endian(vrh), val);
 }
 
+#if IS_REACHABLE(CONFIG_VHOST_IOTLB)
+
 void vringh_set_iotlb(struct vringh *vrh, struct vhost_iotlb *iotlb);
 
 int vringh_init_iotlb(struct vringh *vrh, u64 features,
@@ -284,4 +288,6 @@ void vringh_notify_disable_iotlb(struct vringh *vrh);
 
 int vringh_need_notify_iotlb(struct vringh *vrh);
 
+#endif /* CONFIG_VHOST_IOTLB */
+
 #endif /* _LINUX_VRINGH_H */
diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index f33f32f1d208..b587b9a7a124 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -4,7 +4,7 @@ test: virtio_test vringh_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
-CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE
+CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
 	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
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
diff --git a/tools/virtio/generated/autoconf.h b/tools/virtio/generated/autoconf.h
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
MST

