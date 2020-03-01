Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFFCC3F2D4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09535214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="Owzs1Pfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgCAOdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 09:33:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43300 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 09:33:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id e10so7765742wrr.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 06:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VaL51ACNGSwlIJlmeO4/TcbLfxPWGDpUsq2T8gnLheE=;
        b=Owzs1PfiGqFtEWA+qEbDVP3PvPExSDErmmM7JwxWDaeuh1BdGGEeKdr6+sgf2utAZ6
         ywQPsIfbBICiu7eSzxm8BUBr/SPFak+KuI0BfC1jHjJhRDMfLNDac8uWv0ghTbedREkA
         8NY9A5s1G1wLctfdH4jk2WgZlNyhIL/oXmEWM/Mamx9a4eG3FyQskvsVklQQKtrU5g7F
         qMHeuCPXm6H8tUAf+j1xomWq5L/CLZjmsKy2yDa/8RiyYczR0So15GaL8yqVTLvuSzne
         6HfQx7fPe6mkAMU4ilqxYDdCj+34H55Nj098IU231mpR272VZJ288jVI2ub1q/9qqHE0
         z/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VaL51ACNGSwlIJlmeO4/TcbLfxPWGDpUsq2T8gnLheE=;
        b=oFS5P8cuZzclpinIlrD0KZOuGhcBo8iXBtIO9nhrdSS8Ych7wRVlTh24IASdYwtmzT
         47CVx9dagD6TqU+tszBVws5/9xhMfukGik72p4/waM0SwqDUGPxa348OFDV92aruQLG6
         Iaz9y19y8sC6BCLoDlRGGMakKVuiZJK0ZfHoXkqoadLpVyyMopMxCUzjrtlx4E8E6jTg
         sbzM9inH9fZOmvIuXLrA78snWbCZyyaNIyX07WpuoFNT6P7ieGUk1cc622Otk1Kie2Ig
         9K5DSofxwVUoiDuOZGCA9jUaO9nV2inU/OLwf7hWF0kAdm7G/LuqwP+LwfqJLBQuOxHK
         Uvng==
X-Gm-Message-State: APjAAAUAv4ig8mpVf89yo9931Yt7qKjvLAqmPk0ElGKAN0wMqukI6OG+
        yJeLl5pkWjvwz0xnfIjGJG9lUA==
X-Google-Smtp-Source: APXvYqwoPfjEL3QODyOTiNJPvlw/dctQVRNXDuzknTtlGtpMlT9v9siA5S3NzYIpnnoRu0AZcfE5jQ==
X-Received: by 2002:adf:a4c4:: with SMTP id h4mr16495453wrb.112.1583073190013;
        Sun, 01 Mar 2020 06:33:10 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id l4sm23617241wrv.22.2020.03.01.06.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Mar 2020 06:33:09 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com, virtio-dev@lists.oasis-open.org
Subject: [PATCH v3 1/3] virtio-net: Introduce extended RSC feature
Date:   Sun,  1 Mar 2020 16:33:00 +0200
Message-Id: <20200301143302.8556-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200301143302.8556-1-yuri.benditovich@daynix.com>
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
is able to provide extended RSC information. When the feature
is negotiatede and 'gso_type' field in received packet is not
GSO_NONE, the device reports number of coalesced packets in
'csum_start' field and number of duplicated acks in 'csum_offset'
field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/uapi/linux/virtio_net.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index a3715a3224c1..19e76b3e3a64 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
 #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
 					 * with the same MAC.
 					 */
@@ -104,6 +105,7 @@ struct virtio_net_config {
 struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
 #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
+#define VIRTIO_NET_HDR_F_RSC_INFO	4	/* rsc info in csum_ fields */
 	__u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
@@ -113,8 +115,24 @@ struct virtio_net_hdr_v1 {
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
 	__virtio16 gso_size;	/* Bytes to append to hdr_len per frame */
-	__virtio16 csum_start;	/* Position to start checksumming from */
-	__virtio16 csum_offset;	/* Offset after that to place checksum */
+	union {
+		struct {
+			__virtio16 csum_start;
+			__virtio16 csum_offset;
+		};
+		struct {
+			/* Position to start checksumming from */
+			__virtio16 start;
+			/* Offset after that to place checksum */
+			__virtio16 offset;
+		} csum;
+		struct {
+			/* num of coalesced packets */
+			__le16 packets;
+			/* num of duplicated acks */
+			__le16 dup_acks;
+		} rsc;
+	};
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
 
-- 
2.17.1

