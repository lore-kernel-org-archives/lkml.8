Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ECCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B2D22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7L45UIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgHCVAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:00:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24595 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729227AbgHCVAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kSRe7wmYN+c40TNuZd0aK8LNMOsV+g9hMYDNFujk/tc=;
        b=Z7L45UImsANHOJ6XYIgHL0LwrWcFBZfa/LcS2iVKWo4s6TgYYz9f8reyfmXW5l8r0zbagl
        dGLrvHGF5us/LiMD6ei3XR3Q/SmQ/iG0AMHF+OoJHent0+TAdihghS7ptqff6ooIAZBaHl
        cI51b6vjZYJDICiqb8A1YgHAV53jJyc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-RJBMDpefNeus1vtcarwh6Q-1; Mon, 03 Aug 2020 17:00:29 -0400
X-MC-Unique: RJBMDpefNeus1vtcarwh6Q-1
Received: by mail-qv1-f69.google.com with SMTP id d9so17704416qvl.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kSRe7wmYN+c40TNuZd0aK8LNMOsV+g9hMYDNFujk/tc=;
        b=k8ZJotLGHFQtUFfZVQ0gt/VLVwBDI4PK7VtG//gldsWh77IvMsZfQYxE+H7XOPhYML
         nV9F9tJHgyc/BK9omMI5ZWKWBxjL8xPKnWYTuzetzW9/mWgt0DMP6qaOEWET6ZEgnc3h
         OZMsVzk+HbCscEQPU4DzRa6KVa4b47S1GWdSqwfsXtBbGpPJpjiCAqgt4eJgJCOw8S+i
         37N+nb1DcZoedPsZtfXQiHLZ1tDP3rbG99kbsl9FocwqkSuREQPw2HEV8DDSD1f9GyRJ
         JVh5CmZiXoTexsOGDKuKZ+zEphooEuQ/T1IPx7d52wQBpxsoZ1hKPqQ/C0LtgpwTJI5D
         00lQ==
X-Gm-Message-State: AOAM5318cXaGOrSTFK7Pby/bQ9p/tGp+ISkAf0A8M9tUtNsZ7IO/qO8l
        2ZoGOfny3EMjEgvGgBXzDRu4moeZUa1BZOqPYEsv4fHKh7vjVUF/gZuBlYveqSjTNw1jvFkVrDk
        OFxE7O/euS5V+E17WIpT8C2+2
X-Received: by 2002:aed:3203:: with SMTP id y3mr18662629qtd.376.1596488428499;
        Mon, 03 Aug 2020 14:00:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyytSR2o8DqbLBPnR7jLzUuJzz/9lygAGjqsOnx/cmHBbbEeMQdbF76xlz6+tLx56E25N+M/Q==
X-Received: by 2002:aed:3203:: with SMTP id y3mr18662607qtd.376.1596488428289;
        Mon, 03 Aug 2020 14:00:28 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id o37sm24591606qte.9.2020.08.03.14.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:00:27 -0700 (PDT)
Date:   Mon, 3 Aug 2020 17:00:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 23/24] virtio_config: cread/write cleanup
Message-ID: <20200803205814.540410-24-mst@redhat.com>
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

