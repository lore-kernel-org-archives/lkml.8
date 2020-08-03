Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41013C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4622222C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkXZxYgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgHCVAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:00:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59420 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729227AbgHCVAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ODrF61uLCJ0gIB7JT0cfv8eeFBRRS/LYcIT029nxjh4=;
        b=EkXZxYgGjnGC/VUwGKSR02Qt6TPtOmIT/KPHEK2vuMLqAwLuzNpT2sQ0DRF4i7MtGotsAc
        Eew5jQHBsT7Loa1ozao3gYNZlui0gvVsOXAkSMnMYqBLOOZkRtAixE5z//0i8M5hAxlRB9
        xPcE6V8akjnuZNXa3zpbRj8d3XnviCI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-xLJND2Y9MWuFRvnQaV_raA-1; Mon, 03 Aug 2020 17:00:33 -0400
X-MC-Unique: xLJND2Y9MWuFRvnQaV_raA-1
Received: by mail-qt1-f200.google.com with SMTP id k35so22327927qtk.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODrF61uLCJ0gIB7JT0cfv8eeFBRRS/LYcIT029nxjh4=;
        b=JvBTyzwauBiX1efZ5CCsA/inwtGLxv1HYmgw7SwN3A3o++08Z1soxsdB+FGx8kGDkA
         IPVJA9V/eqqdpDChnVIVwL/gtepaNkkwlJlPdh4lldXw80Xk+jLwI7XZjTmSItAUeZlQ
         22Z0y8tN93Mv+64JygFLhBy807xzPK1LlJxMl9kIPmmSnYB3+fsvs6WCNR2nEAabMPZI
         kOoGw+TtrMqHQp6XOEWTsISqK0Vp6VxDcZ92KehPoZzwwNKeKr2u6mQOkYLUZvrA65W+
         l8anJbkwYns93o+pNQIum/LAL9dnZRB8WX8MI0dZkL1ZoV59Hb169EMWf5Zr+9M3QNuG
         L05A==
X-Gm-Message-State: AOAM533vlaF2oWqstlGqlKKoA0cj2t3yK7+hQ0m5ONNkqkjoeKcR/Q94
        t68NjR7A/NvstmBUF1tgo8KukpFbFNkTDuP7N9qR4ln1jIc5PGVfljfqlmBXiOgWBLcFowvudWt
        gJTOqb6TcW4wThv2jDVBca4KI
X-Received: by 2002:a0c:b5d8:: with SMTP id o24mr18759015qvf.214.1596488432569;
        Mon, 03 Aug 2020 14:00:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLRWdf8ygGa/NpADkbJ17E7df0IfOnu3DKcU/hniVMLmpo6IhteUtIrQUdJ2HEhZNy2nSgbw==
X-Received: by 2002:a0c:b5d8:: with SMTP id o24mr18758984qvf.214.1596488432309;
        Mon, 03 Aug 2020 14:00:32 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id k24sm23288433qtb.26.2020.08.03.14.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:00:31 -0700 (PDT)
Date:   Mon, 3 Aug 2020 17:00:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 24/24] virtio_config: rewrite using _Generic
Message-ID: <20200803205814.540410-25-mst@redhat.com>
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

Min compiler version has been raised, so that's ok now.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 163 ++++++++++++++++------------------
 1 file changed, 77 insertions(+), 86 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 5c3b02245ecd..21c7098595ad 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -288,112 +288,103 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
 }
 
-/*
- * Only the checker differentiates between __virtioXX and __uXX types. But we
- * try to share as much code as we can with the regular GCC build.
- */
-#if !defined(CONFIG_CC_IS_GCC) && !defined(__CHECKER__)
+#define virtio_to_cpu(vdev, x) \
+	_Generic((x), \
+		__u8: (x), \
+		__virtio16: virtio16_to_cpu((vdev), (x)), \
+		__virtio32: virtio32_to_cpu((vdev), (x)), \
+		__virtio64: virtio64_to_cpu((vdev), (x)), \
+		/*
+		 * Why define a default? checker can distinguish between
+		 * e.g. __u16, __le16 and __virtio16, but GCC can't so
+		 * attempts to define variants for both look like a duplicate
+		 * variant to it.
+		 */ \
+		default: _Generic((x), \
+				 __u8: (x), \
+				 __le16: virtio16_to_cpu((vdev), (__force __virtio16)(x)), \
+				 __le32: virtio32_to_cpu((vdev), (__force __virtio32)(x)), \
+				 __le64: virtio64_to_cpu((vdev), (__force __virtio64)(x)), \
+				 default: _Generic((x), \
+						  __u8: (x), \
+						  __u16: virtio16_to_cpu((vdev), (__force __virtio16)(x)), \
+						  __u32: virtio32_to_cpu((vdev), (__force __virtio32)(x)), \
+						  __u64: virtio64_to_cpu((vdev), (__force __virtio64)(x)) \
+						  ) \
+				 ) \
+		)
 
-/* Not a checker - we can keep things simple */
-#define __virtio_native_typeof(x) typeof(x)
-
-#else
-
-/*
- * We build this out of a couple of helper macros in a vain attempt to
- * help you keep your lunch down while reading it.
- */
-#define __virtio_pick_value(x, type, then, otherwise)			\
-	__builtin_choose_expr(__same_type(x, type), then, otherwise)
-
-#define __virtio_pick_type(x, type, then, otherwise)			\
-	__virtio_pick_value(x, type, (then)0, otherwise)
-
-#define __virtio_pick_endian(x, x16, x32, x64, otherwise)			\
-	__virtio_pick_type(x, x16, __u16,					\
-		__virtio_pick_type(x, x32, __u32,				\
-			__virtio_pick_type(x, x64, __u64,			\
-				otherwise)))
-
-#define __virtio_native_typeof(x) typeof(					\
-	__virtio_pick_type(x, __u8, __u8,					\
-		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
-			__virtio_pick_endian(x, __le16, __le32, __le64,		\
-				/* No other type allowed */			\
-				(void)0))))
-
-#endif
+#define cpu_to_virtio(vdev, x, m) \
+	_Generic((m), \
+		__u8: (x), \
+		__virtio16: cpu_to_virtio16((vdev), (x)), \
+		__virtio32: cpu_to_virtio32((vdev), (x)), \
+		__virtio64: cpu_to_virtio64((vdev), (x)), \
+		/*
+		 * Why define a default? checker can distinguish between
+		 * e.g. __u16, __le16 and __virtio16, but GCC can't so
+		 * attempts to define variants for both look like a duplicate
+		 * variant to it.
+		 */ \
+		default: _Generic((m), \
+				 __u8: (x), \
+				 __le16: (__force __le16)cpu_to_virtio16((vdev), (x)), \
+				 __le32: (__force __le32)cpu_to_virtio32((vdev), (x)), \
+				 __le64: (__force __le64)cpu_to_virtio64((vdev), (x)), \
+				 default: _Generic((m), \
+						  __u8: (x), \
+						  __u16: (__force __u16)cpu_to_virtio16((vdev), (x)), \
+						  __u32: (__force __u32)cpu_to_virtio32((vdev), (x)), \
+						  __u64: (__force __u64)cpu_to_virtio64((vdev), (x)) \
+						  ) \
+				 ) \
+		)
 
 #define __virtio_native_type(structname, member) \
-	__virtio_native_typeof(((structname*)0)->member)
-
-#define __virtio_typecheck(structname, member, val) \
-		/* Must match the member's type, and be integer */ \
-		typecheck(__virtio_native_type(structname, member), (val))
-
+	typeof(virtio_to_cpu(NULL, ((structname*)0)->member))
 
 /* Config space accessors. */
 #define virtio_cread(vdev, structname, member, ptr)			\
 	do {								\
-		might_sleep();						\
-		/* Must match the member's type, and be integer */	\
-		if (!__virtio_typecheck(structname, member, *(ptr)))	\
-			(*ptr) = 1;					\
+		typeof(((structname*)0)->member) virtio_cread_v;	\
 									\
-		switch (sizeof(*ptr)) {					\
+		might_sleep();						\
+		/* Sanity check: must match the member's type */	\
+		/*typecheck(typeof(virtio_to_cpu((vdev), virtio_cread_v)), *(ptr)); */\
+									\
+		switch (sizeof(virtio_cread_v)) {			\
 		case 1:							\
-			*(ptr) = virtio_cread8(vdev,			\
-					       offsetof(structname, member)); \
-			break;						\
 		case 2:							\
-			*(ptr) = virtio_cread16(vdev,			\
-						offsetof(structname, member)); \
-			break;						\
 		case 4:							\
-			*(ptr) = virtio_cread32(vdev,			\
-						offsetof(structname, member)); \
-			break;						\
-		case 8:							\
-			*(ptr) = virtio_cread64(vdev,			\
-						offsetof(structname, member)); \
+			vdev->config->get((vdev), 			\
+					  offsetof(structname, member), \
+					  &virtio_cread_v,		\
+					  sizeof(virtio_cread_v));	\
 			break;						\
 		default:						\
-			BUG();						\
+			__virtio_cread_many((vdev), 			\
+					  offsetof(structname, member), \
+					  &virtio_cread_v,		\
+					  1,				\
+					  sizeof(virtio_cread_v));	\
+			break;						\
 		}							\
+		*(ptr) = virtio_to_cpu(vdev, virtio_cread_v);		\
 	} while(0)
 
 /* Config space accessors. */
 #define virtio_cwrite(vdev, structname, member, ptr)			\
 	do {								\
-		might_sleep();						\
-		/* Must match the member's type, and be integer */	\
-		if (!__virtio_typecheck(structname, member, *(ptr)))	\
-			BUG_ON((*ptr) == 1);				\
+		typeof(((structname*)0)->member) virtio_cwrite_v =	\
+			cpu_to_virtio(vdev, *(ptr), ((structname*)0)->member); \
 									\
-		switch (sizeof(*ptr)) {					\
-		case 1:							\
-			virtio_cwrite8(vdev,				\
-				       offsetof(structname, member),	\
-				       *(ptr));				\
-			break;						\
-		case 2:							\
-			virtio_cwrite16(vdev,				\
-					offsetof(structname, member),	\
-					*(ptr));			\
-			break;						\
-		case 4:							\
-			virtio_cwrite32(vdev,				\
-					offsetof(structname, member),	\
-					*(ptr));			\
-			break;						\
-		case 8:							\
-			virtio_cwrite64(vdev,				\
-					offsetof(structname, member),	\
-					*(ptr));			\
-			break;						\
-		default:						\
-			BUG();						\
-		}							\
+		might_sleep();						\
+		/* Sanity check: must match the member's type */	\
+		typecheck(typeof(virtio_to_cpu((vdev), virtio_cwrite_v)), *(ptr)); \
+									\
+		vdev->config->set((vdev), offsetof(structname, member),	\
+				  &virtio_cwrite_v,			\
+				  sizeof(virtio_cwrite_v));		\
 	} while(0)
 
 /* Read @count fields, @bytes each. */
-- 
MST

