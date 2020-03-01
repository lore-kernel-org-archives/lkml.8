Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A4EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9CD222C2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="NR0iRoFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCALHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 06:07:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39527 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgCALHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 06:07:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so8856715wrn.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 03:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p/KmgnJg9kBEfvlzJJFSl6WfUIRmWHlWaOmzFYMMrw0=;
        b=NR0iRoFKv1Y0daC49tBZsWfbMDIN1XjcnZR8nA0VyEAKoGG8Zv6I6SVpsb5jyK7AdO
         3Fi/genDMftosGJnlvFCyxJaPM8w8QlZjV0WHy6wMiTnPAqwFzM62XZdis0CtSKmThfn
         0u/SvS7a55aezXHVJK0QUDAOaN9nQUd4kMl7bHnRt7jdaU5iAOY6wKqOZAxuBjuVTs9Y
         vrLu6bgyLBpZiHLz0c+zuGVWYa+jnZnx43U4dnlQUzCPHu0hhrf8C6HKxe2OfuV3bEks
         5NOpcHlb9Tlat4tsArmpvIKNoqB6220SJFmUaJSGdbro37/A+o3YwHLX9K6HwkQAVBit
         IuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p/KmgnJg9kBEfvlzJJFSl6WfUIRmWHlWaOmzFYMMrw0=;
        b=ALVd9k/TGTnY3SLcImI1+Wp+J1a5bHKOqnySecse5MmvIP0Yki22ZvHnIwPA0vq43n
         SgQr3s12yeK8WTCXm6fnc8yB6Wof6f2zInn5RjgcTvDg58VFCQW5wby35mnWaOqPjUDn
         WGw7YGy79VFVDF2KsYTDd+nWCGk5hKiQ37AvKM2Y0804F0BCSshP5MSQw9eFwxfnR4LY
         AeyfuLwppojjnfKstERoRJBG+f8kPc7roO9SqNyYXj4CQ3tIpncsW43TFlnbNb7u9r+G
         8A/ijlQ+ibCqgaJKFOCYEvbFcEKZFqJ9lgfOBVUF+gZ53rfpqRAQV9J3327/2nZc2EIG
         sjpg==
X-Gm-Message-State: APjAAAXyBN9R7N5zPIbVhAUbgLLf3vG/iHyVFoMhsljBlsxH8g+hY5if
        LpS1k0x7gZVDTtDppgI2SGGydQ==
X-Google-Smtp-Source: APXvYqxPL7x56TY1BrWRmoLhp0P70FyZV8p48kmLRnJLaOrD6PswXgPjUHoAnKbl/91J/HWSYDim1Q==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr9721951wrv.418.1583060864461;
        Sun, 01 Mar 2020 03:07:44 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id i7sm11563243wma.32.2020.03.01.03.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Mar 2020 03:07:43 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
Subject: [PATCH v2 3/3] virtio-net: Introduce hash report feature
Date:   Sun,  1 Mar 2020 13:07:33 +0200
Message-Id: <20200301110733.20197-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200301110733.20197-1-yuri.benditovich@daynix.com>
References: <20200301110733.20197-1-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature VIRTIO_NET_F_HASH_REPORT extends the
layout of the packet and requests the device to
calculate hash on incoming packets and report it
in the packet header.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/uapi/linux/virtio_net.h | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 6b309fe23671..c9ca62dd77a4 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
 #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
@@ -144,6 +145,23 @@ struct virtio_net_hdr_v1 {
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
 
+struct virtio_net_hdr_v1_hash {
+	struct virtio_net_hdr_v1 hdr;
+	__le32 hash_value;
+#define VIRTIO_NET_HASH_REPORT_NONE            0
+#define VIRTIO_NET_HASH_REPORT_IPv4            1
+#define VIRTIO_NET_HASH_REPORT_TCPv4           2
+#define VIRTIO_NET_HASH_REPORT_UDPv4           3
+#define VIRTIO_NET_HASH_REPORT_IPv6            4
+#define VIRTIO_NET_HASH_REPORT_TCPv6           5
+#define VIRTIO_NET_HASH_REPORT_UDPv6           6
+#define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
+#define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
+#define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
+	__le16 hash_report;
+	__le16 padding;
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
@@ -292,6 +310,24 @@ struct virtio_net_rss_config {
 
  #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
 
+/*
+ * The command VIRTIO_NET_CTRL_MQ_HASH_CONFIG requests the device
+ * to include in the virtio header of the packet the value of the
+ * calculated hash and the report type of hash. It also provides
+ * parameters for hash calculation. The command requires feature
+ * VIRTIO_NET_F_HASH_REPORT to be negotiated to extend the
+ * layout of virtio header as defined in virtio_net_hdr_v1_hash.
+ */
+struct virtio_net_hash_config {
+	__le32 hash_types;
+	/* for compatibility with virtio_net_rss_config */
+	__le16 reserved[4];
+	__u8 hash_key_length;
+	__u8 hash_key_data[/* hash_key_length */];
+};
+
+ #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2
+
 /*
  * Control network offloads
  *
-- 
2.17.1

