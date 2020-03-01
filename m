Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5EEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90449214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="NiTiBAK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgCAOdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 09:33:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36419 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgCAOdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 09:33:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id g83so6006765wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 06:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6v9HE9PaNSFSyQOJMv/jnK9fSFyNaAnUECJQXmi/yS8=;
        b=NiTiBAK4qmJbQ49H0pGQ+YaewMiqj5ls5DHJG4eKlmGff7DWVsAavS8RcnQVEK1zOw
         HJs53nKQ9kfaFQtW9EoCeuvYuooilM/vb7ccZ/xcndOz2Owlfs4UbgmoVFlFMNl4nBBr
         wf8xDNzWIol4iMY22lIgOzqnPY5VjHK9unGsqPHHyQdLs92C8CiamIHvywLmGkeE9YO9
         QR5prY4+PUaF6qnsbdng856ea6LsC1AfXRZ6Ffqk182OusxeExqtNOdAUwYMAdQxPNTU
         Ax6Kg+GjV0n/IpgqZyqjn507ggjzqNzwIAowuXcCrJkgQOrZKaFzxwGHb4OJzWeEWUNY
         VPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6v9HE9PaNSFSyQOJMv/jnK9fSFyNaAnUECJQXmi/yS8=;
        b=WAzmE/pO2z9OByrxU86K+G1tGQ5p+ZGDKT5wzlPc3lYmh4jfwDKJuZjO6kwX+0WYC1
         e0gKn6Jxnkzjlp5E6gOGxEoWYNIuSm1fnxMWudNNe6yEWun5nI5QouAgxFol1SCR+jFc
         Z4PmtRxWfrAeI4Prd8P7zLmw+FxO6xBMeCPP3bShLs9AXg8z0d0T+IVVQi7xyMOqvHex
         DPAN/CpsciKOnzD9R/MPYp+7qEXyiDONnt+CN3LqdvWGiOwxO5pny3G+mdLHdnCeI10u
         Z4IwqSeMCDAWIgnj7WteQEpXRCObXjAkF5E4OFSvDCkhs1XXwVVdWSth0ySNzA3F49Qd
         GYMQ==
X-Gm-Message-State: APjAAAUp6o9VldPd4po/dSwyD9P3cFXERwT2P34qTZqQ6Vm6z/uPKPKp
        l+GaZ0MWV9EOLslHUYV/kJotcQ==
X-Google-Smtp-Source: APXvYqw3c1K/E9lEXPJfSvhr5xTxWnB+Cd8RzSbW3TNjHk8/J8zOGEc0yS2ip1ihIIRTYNOBGuDAHw==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr13975164wmg.147.1583073192506;
        Sun, 01 Mar 2020 06:33:12 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id l4sm23617241wrv.22.2020.03.01.06.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Mar 2020 06:33:12 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com, virtio-dev@lists.oasis-open.org
Subject: [PATCH v3 3/3] virtio-net: Introduce hash report feature
Date:   Sun,  1 Mar 2020 16:33:02 +0200
Message-Id: <20200301143302.8556-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200301143302.8556-1-yuri.benditovich@daynix.com>
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
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
index 188ad3eecdc8..4bd940501ba6 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
 #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
@@ -154,6 +155,23 @@ struct virtio_net_hdr_v1 {
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
@@ -302,6 +320,24 @@ struct virtio_net_rss_config {
 
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

