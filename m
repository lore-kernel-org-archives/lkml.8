Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC597C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AC52086A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="PC6rsdhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgCBLwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:52:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47054 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgCBLwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:52:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id j7so12114880wrp.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 03:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KtdcpgsksXCx1N4N2bM6NED9m5ZpIIGrgkQBZ4ZE1c4=;
        b=PC6rsdhxq3sffskqU9+IRBQU1RA7FSmDXgH/2QnRv45n319Ca/KtUTWn5ppS0T246I
         QqQ+dP7j3czlTkfJqoKmyeos0Irmese2b/vIpuPlhcHb1vKG7Rz33tTWaRl5KHFS/qLP
         6k2EJg+PSRe8NzKrlkWnCbpK4KkxVbyTqYuyk7fo8+pYMKWFTQtuN93itdmXzBwa5XIJ
         yDIdwSk5MpFq4in6PhoAgWF61UtOWYooqAoNT0JvWL4JnZlkliPcHKa2yMyfnajsCnQh
         zfnjbIxdc39pJnzq4NbZAcGunvQuoaHw2pNwl42ZRtTcUCf30DAC+DDdDi8kHTnNhxYX
         rJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KtdcpgsksXCx1N4N2bM6NED9m5ZpIIGrgkQBZ4ZE1c4=;
        b=hDQP7j52G5vV1qt+n4XKxDVAbKIVxvTrXFaYN8KxxoQIRF5gvvxp0Dtk/MFsBwmJ2w
         277x33rugOEfDPoLTrkM4mf/tJqcP7/vyI6c/vk/JAnQpzkynUAwSIjZjw6mbzCi3QUt
         dvo4Er0o+aS1EnA0+AzVqk2lVgLg2HkF+MyvHpa7WHke0/0pf1JoCdXjUUpAAXrA9QrN
         CTLnh9FvORhnXvVP0jGbhbQTdHW31BglEVvjN/LaBzmfXubCDnBMA/BhLFGtzRgWd7EK
         BoEBJd+ZAPwncEuot3+gzkAc5CCKnFR383CvJRr7g9gssE6LzITtDVyYjjZt59Tvb9jx
         oTgw==
X-Gm-Message-State: ANhLgQ0kndQGMNPjBnVNsyB4PbdbgMQluOAtW2KjDKI5Mu+YxJEXksXz
        uJdcwCHvuSZlPAsQvxIkdMkiHA==
X-Google-Smtp-Source: ADFU+vviH3TtvCtMrP6GnmfbXEbPAx1pCmSaaO4NnEiLQuc6Ff3G1DK9vgRZlHvdcKicckontl9x7w==
X-Received: by 2002:adf:9302:: with SMTP id 2mr12574891wro.217.1583149921022;
        Mon, 02 Mar 2020 03:52:01 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id f17sm16840364wrj.28.2020.03.02.03.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 03:52:00 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com, virtio-dev@lists.oasis-open.org
Subject: [PATCH v4 3/3] virtio-net: Introduce hash report feature
Date:   Mon,  2 Mar 2020 13:50:03 +0200
Message-Id: <20200302115003.14877-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302115003.14877-1-yuri.benditovich@daynix.com>
References: <20200302115003.14877-1-yuri.benditovich@daynix.com>
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
index aec6fac3666a..19d23e5baa4e 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
 #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
@@ -156,6 +157,23 @@ struct virtio_net_hdr_v1 {
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
@@ -304,6 +322,24 @@ struct virtio_net_rss_config {
 
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

