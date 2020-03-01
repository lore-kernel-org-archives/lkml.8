Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAE4C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C4321775
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="YslySjgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCALHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 06:07:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55053 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCALHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 06:07:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id z12so8080084wmi.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 03:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yg9kvojyXnDbsovT1uTdB7qbadbXVtmLGtNtJuE+gZw=;
        b=YslySjgNaQMeMU0Ns8vkbpy0LRoRd/t9DsbdvEunT5LupIjiqFO6DnI/4Od3Tlve0O
         YMlpW8Zr5uThUXcai2dbpIZLLkAKI4MQdGMljvTqTYK62w2FjMOggSlkg+cSbgmczkGW
         hlV0ULlBATutiFuU97WMXnsjZVLii/BYXnbcePyROlxvEqQc7bOCQXVqEydNuwt+p2O9
         56JfCMum+PQuXMlMD3DBeBhT0srGe3K2SxqP0EVux6RHb6fpcKU73H6nD192HtE35bl8
         /TfLFMH0XHRcEaxHA3wi6mi3cor8w/lPT8TXInrtOWy3WSLb36OpNx9kIbhhFtMkeaJG
         DTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yg9kvojyXnDbsovT1uTdB7qbadbXVtmLGtNtJuE+gZw=;
        b=J6aR9rnQyy9q6t4009aeCKj4Xj7R5+eT6RiUz47+goTmsjbNRC6jr0q6dKSRx0bKZz
         5A8p6B1B6WDorqEtCNldMO4pg802DOmjzchZaGW/mUJjGsd29fV/J8Fq9xIsmua3aRdW
         fcC830exrU83szWduIqhbHNEsJomUG/QhWmTv0RRmQJDnds1AyQhZI88pL1BoMf8+u0z
         g4f3bMHUZpimwklbsRvfMT2iHG0FSTEjLu8AEjkqEVB/XnvG6Cd+JMSmDiG4B2ej8+i8
         /xk4pg45OdiOYWuvgvLmlBtqoOBwOG/2qPrhYJRfLJpn43IE2QIUvbipXjuwrrYgPym+
         94Rw==
X-Gm-Message-State: APjAAAUWfgq+EDLCn3n+v1Au4KFwJplCJvTStpHYPoiKQVTVpXpJm5zW
        s/U/nHTUf6MHzg05lblNYAM4LQ==
X-Google-Smtp-Source: APXvYqwQZJzOMZ4wRgt6rgzM+BOmcnSo2rAYLizkdgCozE5E38jCetXcG1Ra6BudFHTyH6tiO3U10Q==
X-Received: by 2002:a05:600c:4151:: with SMTP id h17mr15105633wmm.189.1583060863123;
        Sun, 01 Mar 2020 03:07:43 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id i7sm11563243wma.32.2020.03.01.03.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Mar 2020 03:07:42 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
Subject: [PATCH v2 2/3] virtio-net: Introduce RSS receive steering feature
Date:   Sun,  1 Mar 2020 13:07:32 +0200
Message-Id: <20200301110733.20197-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200301110733.20197-1-yuri.benditovich@daynix.com>
References: <20200301110733.20197-1-yuri.benditovich@daynix.com>
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
index 536152fad3c4..6b309fe23671 100644
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
+	/* maximum size of RSS key */
+	__u8 rss_max_key_size;
+	/* maximum number of indirection table entries */
+	__le16 rss_max_indirection_table_length;
+	/* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
+	__le32 supported_hash_types;
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
+	__le32 hash_types;
+	__le16 indirection_table_mask;
+	__le16 unclassified_queue;
+	__le16 indirection_table[1/* + indirection_table_mask */];
+	__le16 max_tx_vq;
+	__u8 hash_key_length;
+	__u8 hash_key_data[/* hash_key_length */];
+};
+
+ #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
+
 /*
  * Control network offloads
  *
-- 
2.17.1

