Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89697C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A122075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="xnIE4e4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgAMIRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:17:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40724 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgAMIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:17:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so7511006wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 00:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=0zANXS8TKEoJJ1M/Ul1KQmGBcWvlQfYmWq/kiBRyKvE=;
        b=xnIE4e4rPMU7OcSUOkAKlSrl9l0EdteOqeunkUgKv3arlLdDevR5M5UkbX+CciM44M
         mWZouqu8AcjErkPZBBVSPB2ulJ0+cd5V/Cuud7lgm6/FdhPntluM5DU/c/JTFyuYLAKW
         djGwT/u2QtBSq19YSbgEgsVJs08zFbxJAoxrDDPnYcfTuKFdXE1QPp1Hv7dtZbp/qsVB
         9kL9iu9sjaz0qgZE/AETM+jugg22uE6vU59YWmjzcvPZrR4z0pkpd7GZAdWHofocrrrZ
         /c/7XPoOUhDE8q2coVq/408tcWpqI+4/vP9URmPtAePlqwjxht3/dMQbTfAOTMuKd+8k
         4lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0zANXS8TKEoJJ1M/Ul1KQmGBcWvlQfYmWq/kiBRyKvE=;
        b=lt+5ciBS119ZR1X7PNdbyktm9Iq/w9hbFedyNQ/BGw0D26LSfu7BjCpyKUhfAqoKh5
         DJZVoUrs+SK3UbqfqVLAoYo73VxrGa+RoX+spm46MLJsSdMVj9eDu6ox3QlZdB7FgZAm
         3oi0Dxfif0ul3yJK/GUJ88D0WOGi6N6zCyG7lg9EEpBdzVL1qS9LKcdsycL2PP4RGDX4
         z+nGOTwmbJyY4LKxBwTxSig64jtkXKqUA8/YxY8Ei2rIdp4UTI9Q8dMcuHfr1oQLSWrx
         +jylfrNvJnuDc+Dqfl9sRSNYfkqy2XLus3LF5dNjb9VhiXPRri4UeErcvmyCfDDrBxiA
         kKuA==
X-Gm-Message-State: APjAAAWHBYDYl6Ego0lifExGZQK1bBrh6vAdKgfh1kH5pfkcOJRDSWry
        JBCqrbJiQzSca46kjt389avypg==
X-Google-Smtp-Source: APXvYqzANWNHrC26zw2epeZgu5xcQ1xAM/Ml24jTOdkZMXBwIIusDkz1CKMmA1wx3gHpSAxsNFQepQ==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr17827382wru.6.1578903463793;
        Mon, 13 Jan 2020 00:17:43 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id v14sm13949234wrm.28.2020.01.13.00.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 00:17:43 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
Subject: [PATCH v2] virtio-net: Introduce extended RSC feature
Date:   Mon, 13 Jan 2020 10:17:36 +0200
Message-Id: <20200113081736.2340-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
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
 include/uapi/linux/virtio_net.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index a3715a3224c1..2bdd26f8a4ed 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,7 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
-
+#define VIRTIO_NET_F_RSC_EXT	  61	/* Provides extended RSC info */
 #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
 					 * with the same MAC.
 					 */
@@ -104,6 +104,7 @@ struct virtio_net_config {
 struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
 #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
+#define VIRTIO_NET_HDR_F_RSC_INFO	4	/* rsc_ext data in csum_ fields */
 	__u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
@@ -118,6 +119,13 @@ struct virtio_net_hdr_v1 {
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
 
+/*
+ * if VIRTIO_NET_F_RSC_EXT feature has been negotiated and
+ * VIRTIO_NET_HDR_F_RSC_INFO is set in RX packet
+ */
+#define virtio_net_rsc_ext_num_packets	csum_start
+#define virtio_net_rsc_ext_num_dupacks	csum_offset
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
-- 
2.17.1

