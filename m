Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013C9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03832086A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="ZiTLYdSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCBLwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:52:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37311 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgCBLwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:52:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so12205569wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EvmdA4mUcVx5I2epCncii5r58YmYQVi/Ahr0EYjLfTw=;
        b=ZiTLYdSGUGDUhV7Kg2tg3E7IueFE6S6MqL/ekEAoYVVmCWp3OIxEOtN/OBklg30TOZ
         7eC/5FPSU76mBq/rqC/GYa4FRnEx2tb6bB6xAJU/TOhvRhWXKYhKLhxkb02xU/fTyM+S
         1vP9qZiUKY4o6tik38tzETLv01yZNOda4ZF4Nt1PS2JBwsBNs+svPk1OY6vt77Az3VJc
         W3QRP9LFDwjsCSbW4ZQinIHuYPm1nPqpILWohZm/ffAaMEFwDiFibKsXZICSMxkKRJjM
         trLzMJhIewa0YSTS6B/iV80VKU6YsbkQjA71xNh60WI9Q5zQ0VUq11vA2SmprN5qDxeZ
         IE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EvmdA4mUcVx5I2epCncii5r58YmYQVi/Ahr0EYjLfTw=;
        b=XImUTa8ZUPisil1rcO0UJDA6Rl2Hr3HQKkbOV2P2jJMb/U4C+rRe5B3CGDF6ejzFoH
         KkymKSsyHM5f9w97lbjKWWa9vmlPOwXfzxHJaM33TCbK1DWwwv5jA6TvS6K+1h9cXIy7
         d3UDcKxxz+pPDTany2OCVjRYwQFkSq9/x9fIEeDhtWeY4t0QgrAfqS8+OD1gNVHbdRRX
         vlvGwhQN7fIpk3a6ILokcizuUF4SWjTsjYC2HZVO4+hcEcb9RH0hvWJYR5O1l15rnbMA
         aFX3m1WIWZM81DxnG8BdfNZJUymh6hzegtFFotQB3mlCLk5wBJUMrf3BPaCGTHWBRlku
         q2Kw==
X-Gm-Message-State: APjAAAVAfvooV/AtJE/61z7e4eNNQm8tttu5pWxUc264yj4MMsxGGXdS
        XuC+XuEloNKupLSZa/PgKhf6fg==
X-Google-Smtp-Source: APXvYqwUiXK+alLIfLSbJannCMgduxIG9HH8CrR3edHz9Id9bStIHJJrh+VQup7W/1SBp2xvP+zrrQ==
X-Received: by 2002:adf:f342:: with SMTP id e2mr21663558wrp.15.1583149918550;
        Mon, 02 Mar 2020 03:51:58 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id f17sm16840364wrj.28.2020.03.02.03.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 03:51:58 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com, virtio-dev@lists.oasis-open.org
Subject: [PATCH v4 1/3] virtio-net: Introduce extended RSC feature
Date:   Mon,  2 Mar 2020 13:50:01 +0200
Message-Id: <20200302115003.14877-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302115003.14877-1-yuri.benditovich@daynix.com>
References: <20200302115003.14877-1-yuri.benditovich@daynix.com>
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
 include/uapi/linux/virtio_net.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index a3715a3224c1..6466c5979a93 100644
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
@@ -113,8 +115,26 @@ struct virtio_net_hdr_v1 {
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
+		/* Checksum calculation */
+		struct {
+			/* Position to start checksumming from */
+			__virtio16 start;
+			/* Offset after that to place checksum */
+			__virtio16 offset;
+		} csum;
+		/* Receive Segment Coalescing */
+		struct {
+			/* Number of coalesced segments */
+			__le16 segments;
+			/* Number of duplicated acks */
+			__le16 dup_acks;
+		} rsc;
+	};
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
 
-- 
2.17.1

