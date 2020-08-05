Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0BDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B5C9206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlV5//eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgHET3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:29:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58146 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728508AbgHERL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=atxIzRxbT9FOuFO2CvHZA+vE3tCMe4mwfA9uGPPCf/o=;
        b=QlV5//egNjqtTFYg2w8PuGMZhp8PmKeuIGAigotEg9qFjWKXsg2oNW/qX+nUZHtO0OeGy+
        pfeAqW0lA/i7ayhBu/WBuyJFgR8GzP14TJ1vFZXkX+l4tzQs4hvdZkeEcQNG5uQ3ZtpM/p
        5zNVXaqmm2tSiTEbiH92QdQXSeIqVGg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-a_j_3ljVMmiBjFtudKSGGA-1; Wed, 05 Aug 2020 09:45:01 -0400
X-MC-Unique: a_j_3ljVMmiBjFtudKSGGA-1
Received: by mail-wm1-f71.google.com with SMTP id a5so2741587wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=atxIzRxbT9FOuFO2CvHZA+vE3tCMe4mwfA9uGPPCf/o=;
        b=OirF39JF6jY/74aa6JMgLoeCMgBFmlv3jEFIg4A8D4tXDSAzaKfCeM6rPUS2cAcBrF
         N+4mrAiAoeUH+D4DOx79j4K9jCq18RcrNVCwwKAOv6YGAEs4A5f5tzXjELVrAcie48Yc
         LK2P/Tbq91/kJ8Uoutklh/4EmqiWrz52FfvtE2/d/e7xREg7G7x/aTByf+jrX9ZNDK3S
         c6BQul9XWO9UcHin42RN3y/J0rrzMvm8KFwAQxWQg5UML43YiM6VfMcFkYc+Whs+e0Fo
         zMp3Kl2gOSXAa6sheuWsTu5f7oBq5USUQaD6J/ZI1FoA6jGRjBaOWEF6jzhZXjYa9frc
         OmBg==
X-Gm-Message-State: AOAM530lW0U2Gc4ylxgSmxmhhpN41iTjsAEFDoe2lC4AJE1tClqwmS/G
        4A6T+EKYDndrI3ALNjfNf2YJS1EBX/jnYi29wnBx7HMYspDSkccniFwJPXXfTiPa4dDn4MGVg7m
        TOG4o+lsop1x3i1RfFS2LJQv1
X-Received: by 2002:a1c:2095:: with SMTP id g143mr3259120wmg.113.1596635100200;
        Wed, 05 Aug 2020 06:45:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi486zYfcrRq7SJ5KWTOvEIp6eSofJ8hVOMn9kJixY7f4ly7cOd7mIjGAtKnLyQE6YgYvPbA==
X-Received: by 2002:a1c:2095:: with SMTP id g143mr3259106wmg.113.1596635100023;
        Wed, 05 Aug 2020 06:45:00 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id v15sm2904117wrm.23.2020.08.05.06.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:59 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 37/38] virtio_config: drop LE option from config space
Message-ID: <20200805134226.1106164-38-mst@redhat.com>
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

All drivers now use virtio_cread/write_le for LE config
space fields. Drop LE option from virtio_cread/write, only leaving
the option to access transitional fields.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index cc7a2b1fd7b2..ecb166c824bb 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -293,19 +293,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 		__u8: (x), \
 		__virtio16: virtio16_to_cpu((vdev), (x)), \
 		__virtio32: virtio32_to_cpu((vdev), (x)), \
-		__virtio64: virtio64_to_cpu((vdev), (x)), \
-		/*
-		 * Why define a default? checker can distinguish between
-		 * e.g. __u16, __le16 and __virtio16, but GCC can't so
-		 * attempts to define variants for both look like a duplicate
-		 * variant to it.
-		 */ \
-		default: _Generic((x), \
-				 __u8: (x), \
-				 __le16: virtio16_to_cpu((vdev), (__force __virtio16)(x)), \
-				 __le32: virtio32_to_cpu((vdev), (__force __virtio32)(x)), \
-				 __le64: virtio64_to_cpu((vdev), (__force __virtio64)(x)) \
-				 ) \
+		__virtio64: virtio64_to_cpu((vdev), (x)) \
 		)
 
 #define cpu_to_virtio(vdev, x, m) \
@@ -313,19 +301,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 		__u8: (x), \
 		__virtio16: cpu_to_virtio16((vdev), (x)), \
 		__virtio32: cpu_to_virtio32((vdev), (x)), \
-		__virtio64: cpu_to_virtio64((vdev), (x)), \
-		/*
-		 * Why define a default? checker can distinguish between
-		 * e.g. __u16, __le16 and __virtio16, but GCC can't so
-		 * attempts to define variants for both look like a duplicate
-		 * variant to it.
-		 */ \
-		default: _Generic((m), \
-				 __u8: (x), \
-				 __le16: (__force __le16)cpu_to_virtio16((vdev), (x)), \
-				 __le32: (__force __le32)cpu_to_virtio32((vdev), (x)), \
-				 __le64: (__force __le64)cpu_to_virtio64((vdev), (x)) \
-				 ) \
+		__virtio64: cpu_to_virtio64((vdev), (x)) \
 		)
 
 #define __virtio_native_type(structname, member) \
-- 
MST

