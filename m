Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAA8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750FA20842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViAD3CNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgHET2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:28:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57257 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728412AbgHERLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oi4CR23bemPbIyBSn03I/oQ2VbOHBaULBpoKArW5b+0=;
        b=ViAD3CNcWmAN+e7peJFWHsT+zKS3N43OEGellPj+jSCrWT8OSkzZADjHqSV4xTCdt4bZUK
        OIOka4YdA5UWwhRly6sHuSA6X4LOcWy4DELszkiUSXVCp0DibrQNkICDwHR2aOUetYgBaI
        z3iai655ST8C9C4pbkMrOHpU8fh07DM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-llVJfvwOO2eWaNG9W5d4-w-1; Wed, 05 Aug 2020 09:44:30 -0400
X-MC-Unique: llVJfvwOO2eWaNG9W5d4-w-1
Received: by mail-wm1-f71.google.com with SMTP id f74so2745943wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oi4CR23bemPbIyBSn03I/oQ2VbOHBaULBpoKArW5b+0=;
        b=Y2eARn+6kbtDlXRvhaOkKyEVGLnu46NN16BFCFOXw6M4LBWP9vXLKxcDmwl15FOkHQ
         AWLeziy1fyugjsgStUFYRmd3Yyx7oEvRo4cwUYPjHqs2TVrBdcQa/r3nebBcSV96ic1P
         hy8LwbO/gijGSDKLz7zZHD8JG4ovDRB1Mezltwew4ZfLbO6pP/Pat4+XFHXF0eYr+ICt
         KITFF5fp2SaVrzMcQFSTSAYHOtvTbgLd0soYxM/SgxOLU7SOesx+Cy+n37p1ffAtDYkx
         Ka0FYinR5ufcWuJ1rnFpGAL+edqIBA4cMx5gXyZ//ABP8wohT7B61jmu0ptLbZdEfjSA
         UT5A==
X-Gm-Message-State: AOAM532/pqmIcRO37b6fd9mzhFfCy/3ah4pIXa0yxWgQia2qvIIokvR9
        vVxq+mkU+tWhmNhM+iK8KI2miCiwCqmYJNjM2rh2LjVhjWnnKCbV2H6u67l9oLEeVRlRHCvvDEB
        mtwnojATlPhXvIm8xuKFiJcep
X-Received: by 2002:a7b:cc90:: with SMTP id p16mr3095000wma.79.1596635068411;
        Wed, 05 Aug 2020 06:44:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznD7SElHR1ba9YFcNoWzD+TthlJQKN9Qe3cw8IS76anMHj+jkdeXutWXn0hFJZpgmXPOns7Q==
X-Received: by 2002:a7b:cc90:: with SMTP id p16mr3094984wma.79.1596635068196;
        Wed, 05 Aug 2020 06:44:28 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id y203sm2960492wmc.29.2020.08.05.06.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:27 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 26/38] virtio_config: LE config space accessors
Message-ID: <20200805134226.1106164-27-mst@redhat.com>
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

To be used by modern code, as well as to handle LE only fields such as
balloon.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 65 +++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 441fd6dd42ab..5b5196fec899 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -375,6 +375,71 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 				  sizeof(virtio_cwrite_v));		\
 	} while(0)
 
+/*
+ * Nothing virtio-specific about these, but let's worry about generalizing
+ * these later.
+ */
+#define virtio_le_to_cpu(x) \
+	_Generic((x), \
+		__u8: (x), \
+		 __le16: le16_to_cpu(x), \
+		 __le32: le32_to_cpu(x), \
+		 __le64: le64_to_cpu(x) \
+		)
+
+#define virtio_cpu_to_le(x, m) \
+	_Generic((m), \
+		 __u8: (x), \
+		 __le16: cpu_to_le16(x), \
+		 __le32: cpu_to_le32(x), \
+		 __le64: cpu_to_le64(x) \
+		)
+
+/* LE (e.g. modern) Config space accessors. */
+#define virtio_cread_le(vdev, structname, member, ptr)			\
+	do {								\
+		typeof(((structname*)0)->member) virtio_cread_v;	\
+									\
+		might_sleep();						\
+		/* Sanity check: must match the member's type */	\
+		typecheck(typeof(virtio_le_to_cpu(virtio_cread_v)), *(ptr)); \
+									\
+		switch (sizeof(virtio_cread_v)) {			\
+		case 1:							\
+		case 2:							\
+		case 4:							\
+			vdev->config->get((vdev), 			\
+					  offsetof(structname, member), \
+					  &virtio_cread_v,		\
+					  sizeof(virtio_cread_v));	\
+			break;						\
+		default:						\
+			__virtio_cread_many((vdev), 			\
+					  offsetof(structname, member), \
+					  &virtio_cread_v,		\
+					  1,				\
+					  sizeof(virtio_cread_v));	\
+			break;						\
+		}							\
+		*(ptr) = virtio_le_to_cpu(virtio_cread_v);		\
+	} while(0)
+
+/* Config space accessors. */
+#define virtio_cwrite_le(vdev, structname, member, ptr)			\
+	do {								\
+		typeof(((structname*)0)->member) virtio_cwrite_v =	\
+			virtio_cpu_to_le(*(ptr), ((structname*)0)->member); \
+									\
+		might_sleep();						\
+		/* Sanity check: must match the member's type */	\
+		typecheck(typeof(virtio_le_to_cpu(virtio_cwrite_v)), *(ptr)); \
+									\
+		vdev->config->set((vdev), offsetof(structname, member),	\
+				  &virtio_cwrite_v,			\
+				  sizeof(virtio_cwrite_v));		\
+	} while(0)
+
+
 /* Read @count fields, @bytes each. */
 static inline void __virtio_cread_many(struct virtio_device *vdev,
 				       unsigned int offset,
-- 
MST

