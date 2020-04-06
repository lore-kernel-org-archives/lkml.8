Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBB8C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8572493B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IC/xuyGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgDFQMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:12:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44772 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729421AbgDFQMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586189524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XbiY/JR8MT9j2mMaSuLVO6IuA/fdNeex6zTykRrl0fw=;
        b=IC/xuyGTyVeKCX58Vgq9lqrsoE/KlNRXlnSdMP9OCNeBwrLNe/L9EA4NwAzeTnlZh80Sag
        tHpYdPZym0VUxwH6MXFx3bv4b/Zgf7MuXjOSjsC8Ytn4/VdL7B3eFkjVuF51IZpoWM17m9
        muELaruI8n6Vq0UcL7mweFYFdGNr6bM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-09fp-kdEMISUR5W-3qQf8g-1; Mon, 06 Apr 2020 12:12:02 -0400
X-MC-Unique: 09fp-kdEMISUR5W-3qQf8g-1
Received: by mail-wr1-f72.google.com with SMTP id t25so37931wrb.16
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XbiY/JR8MT9j2mMaSuLVO6IuA/fdNeex6zTykRrl0fw=;
        b=esp64a/X2HEckgj5Cyh4Q8vx2PX8t0suISYLj+H/wLjQp8oMx45i/xmSjZie+U/AjW
         RuEVH+Pto0fjOX7nLRHZnEFHpC0XedTP7l5u2ePbHhk9r8swEEYeXGTQH0+sUHodQvAo
         JqPqEEgHKHVgeWFgMx17t0ZWufuY6UgS9sgUXS8uWrRsXv+9ISknMQlcRxK/Rwr1Zg5L
         AgeR2DmnQF7dMooj08HhP2PdMLhgjfMXBRzw70ySIL52x4mhQVZKksdNt13DDazePZQI
         tGKs3s+GbmxhoFcLkCfvws3biXLTUemSi2/tkpec7QjWwNrGnMR3LQqjLvOWupA0IKCQ
         GyCQ==
X-Gm-Message-State: AGi0PuY96+rtXipfozm9cdxxQSoer6A5DakqCis8ORTFXIIxpAiZ7s6v
        HMh9gH4SjR+Hbky8T3qXl4d6cUJSDyr8y0wzaET49fmYOX9hoYfC5UVAkaF4bdoQJX44aJWBPWI
        oCJRjPa8zDJ+qP9VQaDiiUVcP
X-Received: by 2002:a05:6000:10c8:: with SMTP id b8mr23428080wrx.138.1586189520714;
        Mon, 06 Apr 2020 09:12:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypK9E/zVoOtvHRhDKnJGgRYxI6xx0dA9XqHF79iYP2scWVdmchi1G81n7Ps6TU4rYWbySFSjWQ==
X-Received: by 2002:a05:6000:10c8:: with SMTP id b8mr23428046wrx.138.1586189520342;
        Mon, 06 Apr 2020 09:12:00 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id 91sm21618242wrf.79.2020.04.06.09.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:11:59 -0700 (PDT)
Date:   Mon, 6 Apr 2020 12:11:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 1/2] virtio: stop using legacy struct vring in kernel
Message-ID: <20200406161146.130741-2-mst@redhat.com>
References: <20200406161146.130741-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406161146.130741-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct vring (in the uapi directory) and supporting APIs are kept
around to solely avoid breaking old userspace builds.
It's not actually part of the UAPI - it was kept in the UAPI
header by mistake, and using it in kernel isn't necessary
and prevents us from making changes safely.
In particular, the APIs actually assume the legacy layout.

Add an internal kernel-only struct vring, add supporting legacy APIs and
switch everyone to use that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h             | 28 +++++++++++++++++++++++++
 include/uapi/linux/virtio_ring.h        | 26 ++++++++++++++---------
 tools/virtio/ringtest/virtio_ring_0_9.c |  6 +++---
 tools/virtio/vringh_test.c              | 20 +++++++++---------
 4 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 3dc70adfe5f5..b6a31b3cf87c 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -112,4 +112,32 @@ void vring_del_virtqueue(struct virtqueue *vq);
 void vring_transport_features(struct virtio_device *vdev);
 
 irqreturn_t vring_interrupt(int irq, void *_vq);
+
+struct vring {
+	unsigned int num;
+
+	struct vring_desc *desc;
+
+	struct vring_avail *avail;
+
+	struct vring_used *used;
+};
+
+static inline void vring_legacy_init(struct vring *vr, unsigned int num, void *p,
+				     unsigned long align)
+{
+	vr->num = num;
+	vr->desc = p;
+	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
+	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
+		+ align-1) & ~(align - 1));
+}
+
+static inline unsigned vring_legacy_size(unsigned int num, unsigned long align)
+{
+	return ((sizeof(struct vring_desc) * num + sizeof(__virtio16) * (3 + num)
+		 + align - 1) & ~(align - 1))
+		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
+}
+
 #endif /* _LINUX_VIRTIO_RING_H */
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 559f42e73315..59939ba30b06 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -118,16 +118,6 @@ struct vring_used {
 	struct vring_used_elem ring[];
 };
 
-struct vring {
-	unsigned int num;
-
-	struct vring_desc *desc;
-
-	struct vring_avail *avail;
-
-	struct vring_used *used;
-};
-
 /* Alignment requirements for vring elements.
  * When using pre-virtio 1.0 layout, these fall out naturally.
  */
@@ -164,6 +154,21 @@ struct vring {
 #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
 #define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
 
+#ifndef __KERNEL__
+/*
+ * The following definitions have been put in the UAPI header by mistake. We
+ * keep them around to avoid breaking old userspace builds.
+ */
+struct vring {
+	unsigned int num;
+
+	struct vring_desc *desc;
+
+	struct vring_avail *avail;
+
+	struct vring_used *used;
+};
+
 static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 			      unsigned long align)
 {
@@ -180,6 +185,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
 		 + align - 1) & ~(align - 1))
 		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
 }
+#endif
 
 /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
 /* Assuming a given event_idx value from the other side, if
diff --git a/tools/virtio/ringtest/virtio_ring_0_9.c b/tools/virtio/ringtest/virtio_ring_0_9.c
index 13a035a390e9..e2ab6ac53966 100644
--- a/tools/virtio/ringtest/virtio_ring_0_9.c
+++ b/tools/virtio/ringtest/virtio_ring_0_9.c
@@ -67,13 +67,13 @@ void alloc_ring(void)
 	int i;
 	void *p;
 
-	ret = posix_memalign(&p, 0x1000, vring_size(ring_size, 0x1000));
+	ret = posix_memalign(&p, 0x1000, vring_legacy_size(ring_size, 0x1000));
 	if (ret) {
 		perror("Unable to allocate ring buffer.\n");
 		exit(3);
 	}
-	memset(p, 0, vring_size(ring_size, 0x1000));
-	vring_init(&ring, ring_size, p, 0x1000);
+	memset(p, 0, vring_legacy_size(ring_size, 0x1000));
+	vring_legacy_init(&ring, ring_size, p, 0x1000);
 
 	guest.avail_idx = 0;
 	guest.kicked_avail_idx = -1;
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 293653463303..d26dc6530bd4 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -151,7 +151,7 @@ static int parallel_test(u64 features,
 		err(1, "Opening /tmp/vringh_test-file");
 
 	/* Extra room at the end for some data, and indirects */
-	mapsize = vring_size(RINGSIZE, ALIGN)
+	mapsize = vring_legacy_size(RINGSIZE, ALIGN)
 		+ RINGSIZE * 2 * sizeof(int)
 		+ RINGSIZE * 6 * sizeof(struct vring_desc);
 	mapsize = (mapsize + getpagesize() - 1) & ~(getpagesize() - 1);
@@ -185,7 +185,7 @@ static int parallel_test(u64 features,
 		close(to_guest[0]);
 		close(to_host[1]);
 
-		vring_init(&vrh.vring, RINGSIZE, host_map, ALIGN);
+		vring_legacy_init(&vrh.vring, RINGSIZE, host_map, ALIGN);
 		vringh_init_user(&vrh, features, RINGSIZE, true,
 				 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
 		CPU_SET(first_cpu, &cpu_set);
@@ -297,7 +297,7 @@ static int parallel_test(u64 features,
 		unsigned int finished = 0;
 
 		/* We pass sg[]s pointing into here, but we need RINGSIZE+1 */
-		data = guest_map + vring_size(RINGSIZE, ALIGN);
+		data = guest_map + vring_legacy_size(RINGSIZE, ALIGN);
 		indirects = (void *)data + (RINGSIZE + 1) * 2 * sizeof(int);
 
 		/* We are the guest. */
@@ -478,7 +478,7 @@ int main(int argc, char *argv[])
 	if (posix_memalign(&__user_addr_min, PAGE_SIZE, USER_MEM) != 0)
 		abort();
 	__user_addr_max = __user_addr_min + USER_MEM;
-	memset(__user_addr_min, 0, vring_size(RINGSIZE, ALIGN));
+	memset(__user_addr_min, 0, vring_legacy_size(RINGSIZE, ALIGN));
 
 	/* Set up guest side. */
 	vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true, false,
@@ -487,7 +487,7 @@ int main(int argc, char *argv[])
 				 "guest vq");
 
 	/* Set up host side. */
-	vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
+	vring_legacy_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
 	vringh_init_user(&vrh, vdev.features, RINGSIZE, true,
 			 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
 
@@ -506,7 +506,7 @@ int main(int argc, char *argv[])
 	sgs[1] = &guest_sg[1];
 
 	/* May allocate an indirect, so force it to allocate user addr */
-	__kmalloc_fake = __user_addr_min + vring_size(RINGSIZE, ALIGN);
+	__kmalloc_fake = __user_addr_min + vring_legacy_size(RINGSIZE, ALIGN);
 	err = virtqueue_add_sgs(vq, sgs, 1, 1, &err, GFP_KERNEL);
 	if (err)
 		errx(1, "virtqueue_add_sgs: %i", err);
@@ -556,7 +556,7 @@ int main(int argc, char *argv[])
 		errx(1, "vringh_complete_user: %i", err);
 
 	/* Guest should see used token now. */
-	__kfree_ignore_start = __user_addr_min + vring_size(RINGSIZE, ALIGN);
+	__kfree_ignore_start = __user_addr_min + vring_legacy_size(RINGSIZE, ALIGN);
 	__kfree_ignore_end = __kfree_ignore_start + 1;
 	ret = virtqueue_get_buf(vq, &i);
 	if (ret != &err)
@@ -575,7 +575,7 @@ int main(int argc, char *argv[])
 		((char *)__user_addr_max - USER_MEM/4)[i] = i;
 
 	/* This will allocate an indirect, so force it to allocate user addr */
-	__kmalloc_fake = __user_addr_min + vring_size(RINGSIZE, ALIGN);
+	__kmalloc_fake = __user_addr_min + vring_legacy_size(RINGSIZE, ALIGN);
 	err = virtqueue_add_outbuf(vq, guest_sg, RINGSIZE, &err, GFP_KERNEL);
 	if (err)
 		errx(1, "virtqueue_add_outbuf (large): %i", err);
@@ -660,7 +660,7 @@ int main(int argc, char *argv[])
 	if (__virtio_test_bit(&vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
 		char *data = __user_addr_max - USER_MEM/4;
 		struct vring_desc *d = __user_addr_max - USER_MEM/2;
-		struct vring vring;
+		struct vring_s vring;
 
 		/* Force creation of direct, which we modify. */
 		__virtio_clear_bit(&vdev, VIRTIO_RING_F_INDIRECT_DESC);
@@ -680,7 +680,7 @@ int main(int argc, char *argv[])
 		if (err)
 			errx(1, "virtqueue_add_outbuf (indirect): %i", err);
 
-		vring_init(&vring, RINGSIZE, __user_addr_min, ALIGN);
+		vring_legacy_init(&vring, RINGSIZE, __user_addr_min, ALIGN);
 
 		/* They're used in order, but double-check... */
 		assert(vring.desc[0].addr == (unsigned long)d);
-- 
MST

