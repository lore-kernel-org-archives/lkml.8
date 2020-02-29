Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE2EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5322467B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="h6R8hIBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgB2RNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 12:13:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42014 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgB2RNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 12:13:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id p18so7174558wre.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 09:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+fIQn9uyVer5wlDY9m6nXs8oyQIBHwFNHtVk99ISOtM=;
        b=h6R8hIBCaYjYWedumK3a7C0mS4sgxjN2FwmK9KSRKyMHBFgf/jBkRcjXXQ8zXSP/+9
         ofHQgj6esfKap7q0AmD4xfkRcENq1whofrteocJCm90kwTYLiPBRb036b1YVk5oXjIzI
         JbKre0+Z7TlgcR4cLtdp5NhnqHttcx7TtMF6QNy2Q1GqVHtPAPrM+jyHliqf0yctitw4
         r63DhCRx2hGfB15XPPZKpoRpYQQHewIysOC/UyuVqVhozHiAYlmkrp0FwGpV02cNCMpG
         wNeYr0jTkzU6Yfs+bbkDTMasTGyvosWr1rvRP9cmsnWMwvq/f5Ui08R0OU+NVTOf4jVH
         WL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+fIQn9uyVer5wlDY9m6nXs8oyQIBHwFNHtVk99ISOtM=;
        b=XET0aNJGQJ2wE3q32ozGai2B5qcKj/1QhQdVzMptY618bn14+qyOib03skJFt98GlP
         Sjk/bFeXQiRp+1U9DqsYsopFkdXdceFhHMsVzfkOVbOmAw5Ro5IhCQlctRcedt0W8XHU
         GZw5NYzLPJDT6fXIvX6EkoA1nECETtFPObUgwi0ty4qY6QCndZ/LcqH2j5TbrXlAA8jC
         N/GA5cSoeDMMH9OAuErxbM0UliRdCybUaCkbk0/Nggd6G2s/p/YdmbQ0492Je1WYQC5k
         ExaY0M9+GXCwJLNndEaD7gUP0n0UN+mARH2cRi5tROwIkklyG5CU/HA05/HQH90scfSr
         1jxQ==
X-Gm-Message-State: APjAAAXS8djioYIz04RuM6Po0TNPwE9d732/e/VzyByASO6NQMX3uSTe
        z7ZCRJgCepj/7/R12zQh9y+6Ig==
X-Google-Smtp-Source: APXvYqzx8LxbQy09KKedElts1XVbFSl87BqgZV5YuuRgldvKx6wEGnoQqQ2d0nMlOLSibe72ECHNPA==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr11109419wrm.89.1582996390949;
        Sat, 29 Feb 2020 09:13:10 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id r1sm17045046wrx.11.2020.02.29.09.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 09:13:10 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
Subject: [PATCH 2/3] virtio-net: Introduce RSS receive steering feature
Date:   Sat, 29 Feb 2020 19:13:00 +0200
Message-Id: <20200229171301.15234-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200229171301.15234-1-yuri.benditovich@daynix.com>
References: <20200229171301.15234-1-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RSS (Receive-side scaling) defines hash calculation
rules and decision on receive virtqueue according to
the calculated hash, provided mask to apply and
provided indirection table containing indices of
receive virqueues. The driver sends the control
command to enable multiqueue and provide parameters
for receive steering.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 6e26a2cc6ad0..7a342657fb6c 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
 #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
 					 * with the same MAC.
@@ -70,6 +71,17 @@
 #define VIRTIO_NET_S_LINK_UP	1	/* Link is up */
 #define VIRTIO_NET_S_ANNOUNCE	2	/* Announcement is needed */
 
+/* supported/enabled hash types */
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
+#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
+
 struct virtio_net_config {
 	/* The config defining mac address (if VIRTIO_NET_F_MAC) */
 	__u8 mac[ETH_ALEN];
@@ -93,6 +105,12 @@ struct virtio_net_config {
 	 * Any other value stands for unknown.
 	 */
 	__u8 duplex;
+	/* maximal size of RSS key */
+	__u8 rss_max_key_size;
+	/* maximal number of indirection table entries */
+	__u16 rss_max_indirection_table_length;
+	/* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
+	__u32 supported_hash_types;
 } __attribute__((packed));
 
 /*
@@ -236,7 +254,9 @@ struct virtio_net_ctrl_mac {
 
 /*
  * Control Receive Flow Steering
- *
+ */
+#define VIRTIO_NET_CTRL_MQ   4
+/*
  * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
  * enables Receive Flow Steering, specifying the number of the transmit and
  * receive queues that will be used. After the command is consumed and acked by
@@ -249,11 +269,29 @@ struct virtio_net_ctrl_mq {
 	__virtio16 virtqueue_pairs;
 };
 
-#define VIRTIO_NET_CTRL_MQ   4
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
 
+/*
+ * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
+ * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
+ * the receive steering to use a hash calculated for incoming packet
+ * to decide on receive virtqueue to place the packet. The command
+ * also provides parameters to calculate a hash and receive virtqueue.
+ */
+struct virtio_net_rss_config {
+	__virtio32 hash_types;
+	__virtio16 indirection_table_mask;
+	__virtio16 unclassified_queue;
+	__virtio16 indirection_table[1/* + indirection_table_mask*/];
+	__virtio16 max_tx_vq;
+	__u8 hash_key_length;
+	__u8 hash_key_data[/*hash_key_length*/];
+};
+
+ #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
+
 /*
  * Control network offloads
  *
-- 
2.17.1

