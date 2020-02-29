Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FCAC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910572467B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="o5pAelwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgB2RNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 12:13:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37578 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgB2RNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 12:13:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id a141so6722911wme.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BjGaacwNVrGoRZ2MPntB896YPWVR3A8tHODOQN+DEuM=;
        b=o5pAelwHUqvl9vs+9RFdUVSYc88c5p8kKvTZ8AJNts3rqPAeiHRbYe7NINpJwDI23r
         pdAiJ47REyDhXOp6dJrHGNrYizHRUvNEnV9Ishhvi9m5j2tyKRpJtTrCErqoNYLWyKzN
         K4tfX5uoFOIv/KhAHiZiV9NWuNRrMwOlQgkTzEZBZk7yZKi1O9Kwlj7/q+AlzoRgVQWC
         kRBzdk9r5COGvIWjP0uvzfXzBneoLBKQw6P9g3fVC4pSBKdWmDxJl3pbE3NHDBEx9+yG
         2XLCs00y9nzEDOA3YrGzIzhD4Cj99OWIX5UcOmqrcmNw+WZ/CPIJcHp1dDKCCMnCZIku
         Fr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BjGaacwNVrGoRZ2MPntB896YPWVR3A8tHODOQN+DEuM=;
        b=MdJd9EcJ5gIeeF7mVNnd4nUfzro/sX5DZmLxbkODYmVBWPf3dePxWOqfNSlWT90Oqi
         8L3VcDtztvVx2Etn43FpuoXnpuqRZYHuEU1eeX8fZ4RZ+zGadIlgU0dFPx5f/aJWBO88
         MFufS1KI0/e3xf7CB9BuOux5wvToBZmwQQU3KcvVnUlDjKd/sr7b99iR6Bs5nGfXeJAO
         QLrSChiuTTcfspT+y5FuM2YjStMHn/xZZK57QA9RWD27shjWNfuXPrYFNPhfoISFUigB
         7DNejKdac2U1/hYYh4ZnRp8bDH/C+eQoElB1b/9YS6hbcGRxS6It6YtS5xO3fTZJeR5m
         zzgQ==
X-Gm-Message-State: APjAAAU+a8YMfDaNoxw8ZZeR7BAEWf3fSj4LwGqQqqDDVkc8Gv5cVl6L
        amw0sCuKiLDKKMGDHLOUxweDfg==
X-Google-Smtp-Source: APXvYqwJ1ItXf1Quo7cWs8qfDaqKV9Wer87aIQjvdmFMRqn1FLTCzqLdtxdeudiYnhbxoudT+8L5MA==
X-Received: by 2002:a05:600c:2c44:: with SMTP id r4mr10324691wmg.140.1582996389857;
        Sat, 29 Feb 2020 09:13:09 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id r1sm17045046wrx.11.2020.02.29.09.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 09:13:09 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
Subject: [PATCH 1/3] virtio-net: Introduce extended RSC feature
Date:   Sat, 29 Feb 2020 19:12:59 +0200
Message-Id: <20200229171301.15234-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200229171301.15234-1-yuri.benditovich@daynix.com>
References: <20200229171301.15234-1-yuri.benditovich@daynix.com>
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
 include/uapi/linux/virtio_net.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index a3715a3224c1..6e26a2cc6ad0 100644
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
@@ -113,8 +115,14 @@ struct virtio_net_hdr_v1 {
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
 	__virtio16 gso_size;	/* Bytes to append to hdr_len per frame */
-	__virtio16 csum_start;	/* Position to start checksumming from */
-	__virtio16 csum_offset;	/* Offset after that to place checksum */
+	union {
+		__virtio16 csum_start;	/* Position to start checksumming from */
+		__virtio16 rsc_ext_num_packets; /* num of coalesced packets */
+	};
+	union {
+		__virtio16 csum_offset;	/* Offset after that to place checksum */
+		__virtio16 rsc_ext_num_dupacks; /* num of duplicated acks */
+	};
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
 
-- 
2.17.1

