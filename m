Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4066FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1502E22D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPtCCwa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgHERNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:13:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32213 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728565AbgHERKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kSRe7wmYN+c40TNuZd0aK8LNMOsV+g9hMYDNFujk/tc=;
        b=IPtCCwa6LmFTew0cHgVuDnGZh+pjcuxTDimYCLo1WgZwiMHYzCqCajXh1izsbyS6E3vndP
        D8aF5NA6TfDyEHXN2yyxULA3yaxUoRYTS7g9fqiUdz+PC1/i+0R4Bfoh9CYp5bENuCTXDN
        6i8PR71f52VhYTeXn5ZamBRMzYbuPNw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-UnXyzEaAM5OJi1x8uyekmA-1; Wed, 05 Aug 2020 09:44:22 -0400
X-MC-Unique: UnXyzEaAM5OJi1x8uyekmA-1
Received: by mail-wr1-f69.google.com with SMTP id 89so13594838wrr.15
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kSRe7wmYN+c40TNuZd0aK8LNMOsV+g9hMYDNFujk/tc=;
        b=GNEOzxpCIZdbqLRNUZF/t+3fWTTD01SCav/UyrJ00vi3LRtxOrLAduPRNzDiJt2GRT
         vjnOu6zoitVL+LJI8+gmGMrgJtlzZPtDulKBBxP2T2SB+mmXtAuclB8rTWPuCJEfeinA
         X+T4S201cxUGxpTPsm/qL+8/DBYpFyb8Ks7TRhKJSUeBmEbXxRxk89PqIqb2uTnCTSm2
         mjOaxZCYq9eIx1Rx8Rj3NH9KJDeyxSLX6NAQm1Nj2JVX9n7OBvlwOCtgr/3RJUN7dX2F
         AAUlSpq60HcDrdJ0oZYmq/ThgsMSAPU1hAZSuHNYr8Vq8mKAdIMqJVfpmRlQdivKBNWY
         /VUQ==
X-Gm-Message-State: AOAM530HD3VEKoejkw+z8ICNb5cK8hj6jRdVjtbxFhdnTp9qncAlhhr+
        qdIxEngt9VLhaoc82++wrTCFMurStYFswK8XHAinD5OLJm1srRgrmtWQk7DQnQUHHzpTYFtEWlh
        AQT4fsxXIJFHVEBTEjK+R9xad
X-Received: by 2002:a1c:38c5:: with SMTP id f188mr3184181wma.7.1596635060870;
        Wed, 05 Aug 2020 06:44:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtu4fGrz2OcjqJ60Gx1dujnfxQ+ydCwiHL+CZ6x4QY+RWP5ctttNcCg2cu41yMIpSX3GIA4Q==
X-Received: by 2002:a1c:38c5:: with SMTP id f188mr3184169wma.7.1596635060701;
        Wed, 05 Aug 2020 06:44:20 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id f131sm2902892wme.40.2020.08.05.06.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:20 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 23/38] virtio_config: cread/write cleanup
Message-ID: <20200805134226.1106164-24-mst@redhat.com>
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

Use vars of the correct type instead of casting.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index c68f58f3bf34..5c3b02245ecd 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -444,53 +444,60 @@ static inline void virtio_cwrite8(struct virtio_device *vdev,
 static inline u16 virtio_cread16(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u16 ret;
+	__virtio16 ret;
 
 	might_sleep();
 	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return virtio16_to_cpu(vdev, (__force __virtio16)ret);
+	return virtio16_to_cpu(vdev, ret);
 }
 
 static inline void virtio_cwrite16(struct virtio_device *vdev,
 				   unsigned int offset, u16 val)
 {
+	__virtio16 v;
+
 	might_sleep();
-	val = (__force u16)cpu_to_virtio16(vdev, val);
-	vdev->config->set(vdev, offset, &val, sizeof(val));
+	v = cpu_to_virtio16(vdev, val);
+	vdev->config->set(vdev, offset, &v, sizeof(v));
 }
 
 static inline u32 virtio_cread32(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u32 ret;
+	__virtio32 ret;
 
 	might_sleep();
 	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return virtio32_to_cpu(vdev, (__force __virtio32)ret);
+	return virtio32_to_cpu(vdev, ret);
 }
 
 static inline void virtio_cwrite32(struct virtio_device *vdev,
 				   unsigned int offset, u32 val)
 {
+	__virtio32 v;
+
 	might_sleep();
-	val = (__force u32)cpu_to_virtio32(vdev, val);
-	vdev->config->set(vdev, offset, &val, sizeof(val));
+	v = cpu_to_virtio32(vdev, val);
+	vdev->config->set(vdev, offset, &v, sizeof(v));
 }
 
 static inline u64 virtio_cread64(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u64 ret;
+	__virtio64 ret;
+
 	__virtio_cread_many(vdev, offset, &ret, 1, sizeof(ret));
-	return virtio64_to_cpu(vdev, (__force __virtio64)ret);
+	return virtio64_to_cpu(vdev, ret);
 }
 
 static inline void virtio_cwrite64(struct virtio_device *vdev,
 				   unsigned int offset, u64 val)
 {
+	__virtio64 v;
+
 	might_sleep();
-	val = (__force u64)cpu_to_virtio64(vdev, val);
-	vdev->config->set(vdev, offset, &val, sizeof(val));
+	v = cpu_to_virtio64(vdev, val);
+	vdev->config->set(vdev, offset, &v, sizeof(v));
 }
 
 /* Conditional config space accessors. */
-- 
MST

