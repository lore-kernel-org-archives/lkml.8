Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04DEC2BB55
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9712020753
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/vFF5Vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgDFW0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:26:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34228 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbgDFW0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586212007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+P99eoGOE59dzJri6nDdYTRF/iHp1rUM821OiEBSWI=;
        b=U/vFF5VpXdmJuvhGVtoAcxNjDn8Yk87a3t6GmWVVKJW6gY9fo+Ei6MevQc/8I0qh4LitRW
        /zglA5B++K0mdu5RAIDy8DsuK6jbwy+qzP/Astl6XkayEHxVRHXn8SOwCTRO+UCtJwehfB
        YFxDE5HwoaAnl6IzJEPcXMQ2g8a+rGg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-u1YDe4V8MLim71KuFBZndg-1; Mon, 06 Apr 2020 18:26:43 -0400
X-MC-Unique: u1YDe4V8MLim71KuFBZndg-1
Received: by mail-wm1-f72.google.com with SMTP id r8so177513wmn.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+P99eoGOE59dzJri6nDdYTRF/iHp1rUM821OiEBSWI=;
        b=aJZ+LteSiuyOngeVZqfE9MaBpW0RPrtk2//nbKiGWPBsnyrO19j6ZURHq/zTfdJJ/z
         rW2JEHc70zMfAuYzQtNAa4KkgAMFm87Uf8l0qL5VYOnG/NNEwf7t3FB6P85z9X0u2/O/
         +OEqPul7JDCVEA/E7GcJXgd5uYowfqg2C9+hdYxHgLRFI9ET++i/NdO7W5OAJOJiV+At
         SpCFL/X3YBE9qUVsZM+W5rEBTMZ9lzFYYu2bExcQZs273FnPMjGxYEYBPrGFSWcKvKtC
         1Z93pUfWyTVTdEVmC7TBe0rjVirh1Kmr0qgFBPGdgHcfbE00lFFIyQeWdWSvYmBxeJXe
         uYZA==
X-Gm-Message-State: AGi0Pua9g5HopkpPoCt+wabVwYer0TaX6FalW/rC+EsEPLKtVrLIv9S4
        CvwERCoqOhgFN7WMD+YKPNth2uE+rUBV4oXNPoggrduDXp857fuCE72xnDltdE7yw5CG2LIuZCZ
        eKZqtGpWwVKa2UQz7T27YKLJX
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr1618543wml.55.1586212002446;
        Mon, 06 Apr 2020 15:26:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypJbM6FeH7VkbvEqYuHfim8CWxiQKaSSyipP1ZEG1ds7M2SyHjKH/nl5jukff0ySxHyaH4YMVA==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr1618523wml.55.1586212002230;
        Mon, 06 Apr 2020 15:26:42 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id h2sm1186449wmb.16.2020.04.06.15.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:26:41 -0700 (PDT)
Date:   Mon, 6 Apr 2020 18:26:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v6 06/12] vhost: force spec specified alignment on types
Message-ID: <20200406222507.281867-7-mst@redhat.com>
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

The ring element addresses are passed between components with different
alignments assumptions. Thus, if guest/userspace selects a pointer and
host then gets and dereferences it, we might need to decrease the
compiler-selected alignment to prevent compiler on the host from
assuming pointer is aligned.

This actually triggers on ARM with -mabi=apcs-gnu - which is a
deprecated configuration, but it seems safer to handle this
generally.

I verified that the produced binary is exactly identical on x86.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.h       |  6 +++---
 include/linux/virtio_ring.h | 24 +++++++++++++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

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
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 11680e74761a..c3f9ca054250 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -60,14 +60,32 @@ static inline void virtio_store_mb(bool weak_barriers,
 struct virtio_device;
 struct virtqueue;
 
+/*
+ * The ring element addresses are passed between components with different
+ * alignments assumptions. Thus, we might need to decrease the compiler-selected
+ * alignment, and so must use a typedef to make sure the __aligned attribute
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
+typedef struct vring_desc __aligned(VRING_DESC_ALIGN_SIZE) vring_desc_t;
+typedef struct vring_avail __aligned(VRING_AVAIL_ALIGN_SIZE) vring_avail_t;
+typedef struct vring_used __aligned(VRING_USED_ALIGN_SIZE) vring_used_t;
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
 
 /*
-- 
MST

