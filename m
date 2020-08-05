Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE910C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8CA22E03
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEeWh0fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgHERNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:13:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48711 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728577AbgHERKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q673oTQd3PT4fLRkZYrRjwhnbIb/xH6G5eflz2tzEBg=;
        b=BEeWh0frB7E1CFXWD27OsezannhDIAOPGWqZRwOxrMK9H8F8hJ6IPLtPYVsz4ixJP6UkLA
        DTFEaSDdKYk/AhPXYvkIfZ/uOiJfDenIJpbicWEVIeCTLtoiTzLS5vfvO/2D1v1SSerDbD
        7DcnOhK+hLdNHuNlb296tJnI6TNq+Wo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-1yyAW8z7P9qBp-TRaVOQXA-1; Wed, 05 Aug 2020 09:43:26 -0400
X-MC-Unique: 1yyAW8z7P9qBp-TRaVOQXA-1
Received: by mail-wm1-f72.google.com with SMTP id h7so2185822wmm.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q673oTQd3PT4fLRkZYrRjwhnbIb/xH6G5eflz2tzEBg=;
        b=pPE2PZdCEB9NiuvGflnOLjXP3UhnJD6qFHdJpyvdpPjF2EX7BEnzjXG4XCFDc9CMTy
         UPwLXduUmnehQJI/AUjs9XKWZZnSbTZxILtkZ/Ip5IGmfHV7W+jt+LpYWL1plJCgfCJR
         fBnxdbPh+MmSQAXENK8kCsCOzH+ewCD9SrpxU1fkiqRgaMCNVWRqs+YXmOrB8riPVi0X
         mLEoKZYkHQM3i5hpLBbCQDw+8vzlitWlgxwOVWIe4Zf1WobV2xLFtyLkTW/PRcG6EE3m
         PwKbZbnyg9RBRp028a33/urcJ4HH6kWgnZluDFwS9H+dZQLPuuO3Afsy1bs5ppjzl61n
         0pGQ==
X-Gm-Message-State: AOAM5316uMTRa+SrbYi3FBZCfIg3zGpXT12nG9jc7gi4NTUPLkvtASy/
        K+LO/76FDTXHyHg7VhztX5C0KKpaPt5MBltEsS32EayZzkqgy7pergQlvY+4RLFIIVU2xU10w5o
        5X0Iyd6yvlTyrHIijdJjCIB+a
X-Received: by 2002:a1c:9909:: with SMTP id b9mr3361253wme.98.1596635005258;
        Wed, 05 Aug 2020 06:43:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykRKvY0muXBXF5mNi2kHQlY2jpa3SIjJW2hwVXBvs4z8lql0vr9k1JIRomDMqVCpsxqDQEXQ==
X-Received: by 2002:a1c:9909:: with SMTP id b9mr3361235wme.98.1596635005049;
        Wed, 05 Aug 2020 06:43:25 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id b8sm2838695wrv.4.2020.08.05.06.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:24 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 03/38] virtio: allow __virtioXX, __leXX in config space
Message-ID: <20200805134226.1106164-4-mst@redhat.com>
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

Currently all config space fields are of the type __uXX.
This confuses people and some drivers (notably vdpa)
access them using CPU endian-ness - which only
works well for legacy or LE platforms.

Update virtio_cread/virtio_cwrite macros to allow __virtioXX
and __leXX field types. Follow-up patches will convert
config space to use these types.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
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

