Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3935DC3F2D4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1079321775
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="ki7EpdQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgCALHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 06:07:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34856 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgCALHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 06:07:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id m3so7962100wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 03:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DRoldaKOeRvm8VvruGfzEVHUrHVPsd9EQl8oVSRV6s0=;
        b=ki7EpdQ+bpZC5vWe/ixTGYq1ZwLdZZTTRq11EG3uzol+y7Vpxvfk5jtR30mtsMQ35H
         eJ0FzIPRTnihsWRTso8+j6VplVazERpGTVDcZ8PIXtViCOH9pdwvM1KbInriAZ/xF140
         hzzDQhFq3tfetuuq6e1tzEjLJM4C29RFjgksTPG/06m5+d0fhtT2A5j9milcky1ie3oG
         JRp2SRKfWzxCnCGDuXG1cC95f9/zV0lTWGI5x6fm9Jg0l81hNEljQmDsVSBwrfqhcPrV
         hVBuV6uXrZ3tcvRoPlKYJ+5VizFl9lAUwn+6YKtEyK5becF5sYFSbtqiP/X4aXHurnib
         gJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DRoldaKOeRvm8VvruGfzEVHUrHVPsd9EQl8oVSRV6s0=;
        b=ONOFR8fD/mIE5D/NXYJlzC2oV7OoMf7zlptJvvVaQq4Lhu+ifnoqkt+/Rhb3yvs8A7
         7+AeRjfJPHEIWz40yFcSqBVrVggzp10q7rkIGcWaRfcYnc3LxeKS69yHXElce5p9riDf
         nUc38pj/skuhMzN9kyGtcmw3DUGQgGbKdNyQnU3KaH/wEUG3ZRnW6nScr+viz0FYYvgR
         ZkJZqu3q6Hj7UKsO9HG29Rw+wgvpMjvWUuztlGe9yUW5R9JkyAA3OY8C90rpnu6JAHL0
         zjQJo7UNSfDKs02KHaFc0WvGc72QXZDcY5nwcaG9tN1lEcGrL8hZNs2CAzmPkfcMRCXH
         DXng==
X-Gm-Message-State: APjAAAU5c9kBlWVYQh5N4sbnVZLHG06CxRiqWIg/KsScvFsG/zKwsRPq
        iz+3omTHtP8wsKZuN44q8X/w9w==
X-Google-Smtp-Source: APXvYqxx9FgFQEZMeZWv/oL4XT1ygpaw2QNMK5f4zqBh9MmXWs6hitayUH0Eh9boLLGnSEGiVDMUrg==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr14972813wmg.66.1583060861841;
        Sun, 01 Mar 2020 03:07:41 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id i7sm11563243wma.32.2020.03.01.03.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Mar 2020 03:07:41 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
Subject: [PATCH v2 1/3] virtio-net: Introduce extended RSC feature
Date:   Sun,  1 Mar 2020 13:07:31 +0200
Message-Id: <20200301110733.20197-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200301110733.20197-1-yuri.benditovich@daynix.com>
References: <20200301110733.20197-1-yuri.benditovich@daynix.com>
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
index a3715a3224c1..536152fad3c4 100644
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
+		__le16 rsc_ext_num_packets; /* num of coalesced packets */
+	};
+	union {
+		__virtio16 csum_offset;	/* Offset after that to place checksum */
+		__le16 rsc_ext_num_dupacks; /* num of duplicated acks */
+	};
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
 
-- 
2.17.1

