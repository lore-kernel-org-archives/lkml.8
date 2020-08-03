Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE3EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1CBB22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGOF8Y+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgHCU75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:59:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26647 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729079AbgHCU75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eADcXnv6Prf/ROnr8oMM90J2NN3UdejeU8L0/V+Jmmg=;
        b=iGOF8Y+8yuH1U4i1mXOA9BunywvSyIPMYWh4/a3/qpPNWh/OC27M/qdAzzSimxrctcp2lH
        rfp0Cczz7Mo1eBPfP8cFfW4jyHpjK4p+jOUqZSm8UNlL/6RY0cY8fxd2uDNRf2AXtXR65C
        nV7ktmHgFZ6/9KI9EibDOdsOUQq4Xdo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-uSMih7oIOnCbwutNRQt3mg-1; Mon, 03 Aug 2020 16:58:50 -0400
X-MC-Unique: uSMih7oIOnCbwutNRQt3mg-1
Received: by mail-qt1-f200.google.com with SMTP id d2so24284111qtn.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eADcXnv6Prf/ROnr8oMM90J2NN3UdejeU8L0/V+Jmmg=;
        b=ccfe/TxLtsFS0NNr2A6+Zi9NUurKgRMKgyM9Ub7ZmBOzJEmUvxD4nHK/MgIYs5+d23
         +ALnf1vCFB3p2fYCqqjKloGBBV00JO6H6fYoeK17xxYROJ6WhqhzumBAMePpv4+tRfSX
         SRLVvDDwtSgmLQOxhK2h+ztMWxu7pqcbXeASxwlqz/RO5qhqBuFz6/wvaIIki7YbnMNs
         pzDL0cMk8tmjbinlWVqCKQsts/qr+h219YJL74zNlCzgZL/ESlcIEQ81zUuqwxolOFc8
         pXs5nySxzmJUETOM6zy1CchAvV1Ot7nVKbueEnxQRDUizzPwF0NQb45c0Ou8GqXAF4A5
         +87Q==
X-Gm-Message-State: AOAM531wop70IHUty+RUJZ1zto8Kpo0RVnNZWsI+th4yBjS91U5E+9j3
        dXLBF/hRS4HiNTNLOdPKJhBtp9XctI3KMwWrEha14pv71Id2S51V8IPSuWDgNi4vwR16hr5J4GZ
        hj5XHQQa3zAIJRae3olWrZx6O
X-Received: by 2002:a37:a851:: with SMTP id r78mr9665289qke.419.1596488329762;
        Mon, 03 Aug 2020 13:58:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8heGLu96UxNsBF036shtdOW0/9vkprVq03ErbRtZKSjOp34w1z+ivlgALOlXR/mUDEBkUDg==
X-Received: by 2002:a37:a851:: with SMTP id r78mr9665273qke.419.1596488329535;
        Mon, 03 Aug 2020 13:58:49 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id e4sm23451075qts.57.2020.08.03.13.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:58:49 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:58:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
Message-ID: <20200803205814.540410-4-mst@redhat.com>
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

Currently all config space fields are of the type __uXX.
This confuses people and some drivers (notably vdpa)
access them using CPU endian-ness - which only
works well for legacy or LE platforms.

Update virtio_cread/virtio_cwrite macros to allow __virtioXX
and __leXX field types. Follow-up patches will convert
config space to use these types.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 50 +++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 3b4eae5ac5e3..64da491936f7 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -6,6 +6,7 @@
 #include <linux/bug.h>
 #include <linux/virtio.h>
 #include <linux/virtio_byteorder.h>
+#include <linux/compiler_types.h>
 #include <uapi/linux/virtio_config.h>
 
 struct irq_affinity;
@@ -287,12 +288,57 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
 }
 
+/*
+ * Only the checker differentiates between __virtioXX and __uXX types. But we
+ * try to share as much code as we can with the regular GCC build.
+ */
+#if !defined(CONFIG_CC_IS_GCC) && !defined(__CHECKER__)
+
+/* Not a checker - we can keep things simple */
+#define __virtio_native_typeof(x) typeof(x)
+
+#else
+
+/*
+ * We build this out of a couple of helper macros in a vain attempt to
+ * help you keep your lunch down while reading it.
+ */
+#define __virtio_pick_value(x, type, then, otherwise)			\
+	__builtin_choose_expr(__same_type(x, type), then, otherwise)
+
+#define __virtio_pick_type(x, type, then, otherwise)			\
+	__virtio_pick_value(x, type, (then)0, otherwise)
+
+#define __virtio_pick_endian(x, x16, x32, x64, otherwise)			\
+	__virtio_pick_type(x, x16, __u16,					\
+		__virtio_pick_type(x, x32, __u32,				\
+			__virtio_pick_type(x, x64, __u64,			\
+				otherwise)))
+
+#define __virtio_native_typeof(x) typeof(					\
+	__virtio_pick_type(x, __u8, __u8,					\
+		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
+			__virtio_pick_endian(x, __le16, __le32, __le64,		\
+				__virtio_pick_endian(x, __u16, __u32, __u64,	\
+					/* No other type allowed */		\
+					(void)0)))))
+
+#endif
+
+#define __virtio_native_type(structname, member) \
+	__virtio_native_typeof(((structname*)0)->member)
+
+#define __virtio_typecheck(structname, member, val) \
+		/* Must match the member's type, and be integer */ \
+		typecheck(__virtio_native_type(structname, member), (val))
+
+
 /* Config space accessors. */
 #define virtio_cread(vdev, structname, member, ptr)			\
 	do {								\
 		might_sleep();						\
 		/* Must match the member's type, and be integer */	\
-		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
+		if (!__virtio_typecheck(structname, member, *(ptr)))	\
 			(*ptr) = 1;					\
 									\
 		switch (sizeof(*ptr)) {					\
@@ -322,7 +368,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 	do {								\
 		might_sleep();						\
 		/* Must match the member's type, and be integer */	\
-		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
+		if (!__virtio_typecheck(structname, member, *(ptr)))	\
 			BUG_ON((*ptr) == 1);				\
 									\
 		switch (sizeof(*ptr)) {					\
-- 
MST

