Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F484C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718CF2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIz+FC14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgHERQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:16:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39449 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728590AbgHERLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BcmxULBo78pH6q1E4zPETJD9ZEtc8ZzF1e95CUApETA=;
        b=aIz+FC144gjjvm09abnuMHlg2Fm0Ya3xjQw6RwTXUT3cH80O7pNOa+wBSex61AvT4AByet
        1PrKKjePHwiFSaXFYRUsBiATCjvI99sDlBDxBrjSe7S13DuJRGHlffQK+HnSwjvB0wR1Gi
        kcK8LfP/ZmrkLfMTKMOgppnoKEkZTBE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-SzMq4FHTOmKsfBUCcWgbWg-1; Wed, 05 Aug 2020 09:44:25 -0400
X-MC-Unique: SzMq4FHTOmKsfBUCcWgbWg-1
Received: by mail-wr1-f72.google.com with SMTP id m7so13585716wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BcmxULBo78pH6q1E4zPETJD9ZEtc8ZzF1e95CUApETA=;
        b=JqI1xbpoZPYoP0MYsTTHfAXaUbSkBIglQXiIDIZGCIVGSDoAednKeqGaYeE5cVPxOY
         EiF2cRK8lfSDcsCJKN+39e6h0+gUctfw1z5LZjmKp5LRjsaR01FInZJtRrwNX7mJGeYl
         IC18wNqFKbAl53fYTyIhCjSi04I5VIMa/G4VXMTmcJq7S9KB7KL4Kdf5wNKb+ro8LFGN
         TOrghByTL77Aa2CnaEkjezZh3c+VFRfK/+MYsn690VT+fhOz2D09PHd/vX2q7pphS2Vv
         R5aHfjQe+OTw2fAcACebjLp8rfJBHji2dLrc7ocBQ7lf1dzH+BNc5S0V4stNU0zqjdgr
         qAsQ==
X-Gm-Message-State: AOAM531eR0hWjFhO6JX+Z28yACnzVJKMvu+lM/uP/YNtYqCUGXvSKVKp
        9p9p0wmmyL77k6Oedtqil9HTqAjawCoeCoyDewT/r16vG9DqhHANLM0HlTbKRrKyx8nzPwKefa5
        UlckdjlhXqk5anpwzHL6r1EIC
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr2838550wrn.253.1596635063549;
        Wed, 05 Aug 2020 06:44:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSybiU/FyPdajMdrsmZfmBUP0E8TCoz99TsqC+I00TKFZQMsUz0UIrkpU8WBC2m1fP5bkNnQ==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr2838533wrn.253.1596635063264;
        Wed, 05 Aug 2020 06:44:23 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id u6sm2662067wrn.95.2020.08.05.06.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:22 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 24/38] virtio_config: rewrite using _Generic
Message-ID: <20200805134226.1106164-25-mst@redhat.com>
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

Min compiler version has been raised, so that's ok now.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 163 ++++++++++++++++------------------
 1 file changed, 77 insertions(+), 86 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 5c3b02245ecd..7fa000f02721 100644
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
+		typecheck(typeof(virtio_to_cpu((vdev), virtio_cread_v)), *(ptr)); \
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

