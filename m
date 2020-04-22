Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1871EC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2FD02082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtXksU7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgDVO7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:59:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59956 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDVO7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587567544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FBH552ipbDuDcBz+NzQuT3xldOG131csNhHDA4JojNg=;
        b=EtXksU7jkZxGajBdLquto4y/UzJByftUVjpixEZ5Nx96ThksFiREIBYajSw4w3nQ0YwnY4
        jfShsIlSjomUUgBWCUWN9amPcD8ebSx0wXK/ksMfqXebwH0YOKYsrT3wigg1IVzO8LYNlY
        idMcOCrLCWoKb9mjhkExKkNTLIc1zr0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-fszikrBwMUa-5JT-NneBtA-1; Wed, 22 Apr 2020 10:58:57 -0400
X-MC-Unique: fszikrBwMUa-5JT-NneBtA-1
Received: by mail-wm1-f69.google.com with SMTP id h22so935259wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FBH552ipbDuDcBz+NzQuT3xldOG131csNhHDA4JojNg=;
        b=AMr2lv8iwa9oiQ0og5i9h0vcC1AZNsKGP4S9+HsrHGcViwcet8dirCvwYJx/AM5ZhX
         8n58ghd1bdu6Azf0ymDAu84vdzsXG++95SMmsdVVz7ETOmiW+t6uzYkk4hOfGlazETQr
         r7bMVQ/cDdvxW0aOwcB2vjG1C4cIVRjloMKabyZfP9JxlPOLmMnNHyM+EQ9tdon8K5S4
         ISCXNBEv3Yny8ljUlipVhfVZb7MgCo3kOP9uWM+bxRrWvlBwR7dR1xOojEt8LYi+YaxO
         eR9cuXirbdy2QnE2mfcKvXio9VhLOy2kNpnLQp4u7kkDDb8igtjOt5hufgkFeFrDVauQ
         NyfQ==
X-Gm-Message-State: AGi0Pua7/RPVa3vUKw280AyenUgm2hdyo+04hYLfbif4XungfaJT3jGZ
        g3BLZ/VVz+jGRymy90ORnBA+XKMjoNwz9Ud5IbLxF7QdamUcSOJeFagJQZXNArHW98QjcPIXHZs
        Nxq7GM7Zj4vmb9po1kuuS6UE8
X-Received: by 2002:a7b:c759:: with SMTP id w25mr12028206wmk.68.1587567536055;
        Wed, 22 Apr 2020 07:58:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypLEDPGbJlcp27JEzrmkhkGVGhmFCX09zIMAUDQzDbGsjJetkC8OmekGJ4WtGHKHUc8vRzjP6w==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr12028178wmk.68.1587567535740;
        Wed, 22 Apr 2020 07:58:55 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id h1sm8504291wme.42.2020.04.22.07.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 07:58:55 -0700 (PDT)
Date:   Wed, 22 Apr 2020 10:58:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v4] virtio: force spec specified alignment on types
Message-ID: <20200422145510.442277-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ring element addresses are passed between components with different
alignments assumptions. Thus, if guest/userspace selects a pointer and
host then gets and dereferences it, we might need to decrease the
compiler-selected alignment to prevent compiler on the host from
assuming pointer is aligned.

This actually triggers on ARM with -mabi=apcs-gnu - which is a
deprecated configuration, but it seems safer to handle this
generally.

Note that userspace that allocates the memory is actually OK and does
not need to be fixed, but userspace that gets it from guest or another
process does need to be fixed. The later doesn't generally talk to the
kernel so while it might be buggy it's not talking to the kernel in the
buggy way - it's just using the header in the buggy way - so fixing
header and asking userspace to recompile is the best we can do.

I verified that the produced kernel binary on x86 is exactly identical
before and after the change.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes since v3:
	use __attribute__((aligned(X))) instead of __aligned,
	to avoid dependency on that macro

 drivers/vhost/vhost.c            |  8 +++---
 drivers/vhost/vhost.h            |  6 ++---
 drivers/vhost/vringh.c           |  6 ++---
 include/linux/vringh.h           |  6 ++---
 include/uapi/linux/virtio_ring.h | 46 ++++++++++++++++++++++++--------
 5 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d450e16c5c25..bc77b0f465fd 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1244,9 +1244,9 @@ static int vhost_iotlb_miss(struct vhost_virtqueue *vq, u64 iova, int access)
 }
 
 static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
-			 struct vring_desc __user *desc,
-			 struct vring_avail __user *avail,
-			 struct vring_used __user *used)
+			 vring_desc_t __user *desc,
+			 vring_avail_t __user *avail,
+			 vring_used_t __user *used)
 
 {
 	return access_ok(desc, vhost_get_desc_size(vq, num)) &&
@@ -2301,7 +2301,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 			    struct vring_used_elem *heads,
 			    unsigned count)
 {
-	struct vring_used_elem __user *used;
+	vring_used_elem_t __user *used;
 	u16 old, new;
 	int start;
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index f8403bd46b85..60cab4c78229 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -67,9 +67,9 @@ struct vhost_virtqueue {
 	/* The actual ring of buffers. */
 	struct mutex mutex;
 	unsigned int num;
-	struct vring_desc __user *desc;
-	struct vring_avail __user *avail;
-	struct vring_used __user *used;
+	vring_desc_t __user *desc;
+	vring_avail_t __user *avail;
+	vring_used_t __user *used;
 	const struct vhost_iotlb_map *meta_iotlb[VHOST_NUM_ADDRS];
 	struct file *kick;
 	struct eventfd_ctx *call_ctx;
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index ba8e0d6cfd97..e059a9a47cdf 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -620,9 +620,9 @@ static inline int xfer_to_user(const struct vringh *vrh,
  */
 int vringh_init_user(struct vringh *vrh, u64 features,
 		     unsigned int num, bool weak_barriers,
-		     struct vring_desc __user *desc,
-		     struct vring_avail __user *avail,
-		     struct vring_used __user *used)
+		     vring_desc_t __user *desc,
+		     vring_avail_t __user *avail,
+		     vring_used_t __user *used)
 {
 	/* Sane power of 2 please! */
 	if (!num || num > 0xffff || (num & (num - 1))) {
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 9e2763d7c159..59bd50f99291 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -105,9 +105,9 @@ struct vringh_kiov {
 /* Helpers for userspace vrings. */
 int vringh_init_user(struct vringh *vrh, u64 features,
 		     unsigned int num, bool weak_barriers,
-		     struct vring_desc __user *desc,
-		     struct vring_avail __user *avail,
-		     struct vring_used __user *used);
+		     vring_desc_t __user *desc,
+		     vring_avail_t __user *avail,
+		     vring_used_t __user *used);
 
 static inline void vringh_iov_init(struct vringh_iov *iov,
 				   struct iovec *iovec, unsigned num)
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 9223c3a5c46a..476d3e5c0fe7 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -86,6 +86,13 @@
  * at the end of the used ring. Guest should ignore the used->flags field. */
 #define VIRTIO_RING_F_EVENT_IDX		29
 
+/* Alignment requirements for vring elements.
+ * When using pre-virtio 1.0 layout, these fall out naturally.
+ */
+#define VRING_AVAIL_ALIGN_SIZE 2
+#define VRING_USED_ALIGN_SIZE 4
+#define VRING_DESC_ALIGN_SIZE 16
+
 /* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
 struct vring_desc {
 	/* Address (guest-physical). */
@@ -112,29 +119,46 @@ struct vring_used_elem {
 	__virtio32 len;
 };
 
+typedef struct vring_used_elem __attribute__((aligned(VRING_USED_ALIGN_SIZE)))
+	vring_used_elem_t;
+
 struct vring_used {
 	__virtio16 flags;
 	__virtio16 idx;
-	struct vring_used_elem ring[];
+	vring_used_elem_t ring[];
 };
 
+/*
+ * The ring element addresses are passed between components with different
+ * alignments assumptions. Thus, we might need to decrease the compiler-selected
+ * alignment, and so must use a typedef to make sure the aligned attribute
+ * actually takes hold:
+ *
+ * https://gcc.gnu.org/onlinedocs//gcc/Common-Type-Attributes.html#Common-Type-Attributes
+ *
+ * When used on a struct, or struct member, the aligned attribute can only
+ * increase the alignment; in order to decrease it, the packed attribute must
+ * be specified as well. When used as part of a typedef, the aligned attribute
+ * can both increase and decrease alignment, and specifying the packed
+ * attribute generates a warning.
+ */
+typedef struct vring_desc __attribute__((aligned(VRING_DESC_ALIGN_SIZE)))
+	vring_desc_t;
+typedef struct vring_avail __attribute__((aligned(VRING_AVAIL_ALIGN_SIZE)))
+	vring_avail_t;
+typedef struct vring_used __attribute__((aligned(VRING_USED_ALIGN_SIZE)))
+	vring_used_t;
+
 struct vring {
 	unsigned int num;
 
-	struct vring_desc *desc;
+	vring_desc_t *desc;
 
-	struct vring_avail *avail;
+	vring_avail_t *avail;
 
-	struct vring_used *used;
+	vring_used_t *used;
 };
 
-/* Alignment requirements for vring elements.
- * When using pre-virtio 1.0 layout, these fall out naturally.
- */
-#define VRING_AVAIL_ALIGN_SIZE 2
-#define VRING_USED_ALIGN_SIZE 4
-#define VRING_DESC_ALIGN_SIZE 16
-
 #ifndef VIRTIO_RING_NO_LEGACY
 
 /* The standard layout for the ring is a continuous chunk of memory which looks
-- 
MST

