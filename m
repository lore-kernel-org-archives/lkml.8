Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EADDC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB73222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="zeGutF9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgB2RNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 12:13:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33998 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgB2RNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 12:13:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id i10so10606351wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 09:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XFcDlTrKIHj2foS9qGqB/jgRVxoWhysNTBBaTEafaDQ=;
        b=zeGutF9tzPl0q7tv0RmDUy0O/CtHNm/XDcg82ysRNGPKvpSSBi8dPNoE7egnm5PHXT
         tU5nwxXPi5k+XOdzGci2EUZEPrIVrdKWFnbZ5f33Y4/I2d97bJROJx+f/iZd7l8zesn1
         oRQ20/1zHkitB6W6h/QqQRKEtBilIU+LO3DRuCQ9QQUd4Ml/vb5TQk3cg9pDmxyUmpW+
         wjS/KhgbRbZad0wAjhl5h5eWHGFQffwc6jPewA3ZsurKfQ/PbzQVr9jbg4HLmHvoC9k6
         N50rThX5j6dJ/q6OZ4gGvy9+ymgqupgVo2yZCBtLQrUMaeuVFqDoDJUFNNJ4QJEYiHg4
         jXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XFcDlTrKIHj2foS9qGqB/jgRVxoWhysNTBBaTEafaDQ=;
        b=BVn4rk4KRXrw31r/4JhnuhUYkoIZrizzCrYLzq/0dROP33XqGuPkeVoHfdJOJxLybZ
         F60ErA5WC3+6vTZMyTvhWr2fIYTpJCJoXfltQE03ucPHZQVnxR2CvT1agIGROub6d55H
         o5bHdtNGFWzT4f389H78VSPD4GMtdQPYYboH+3VQahNfLFI3SBrxskU956+cw9EP4pe0
         8M2OyY2yHOoRUrd9Dfj8yakEGwjr7WIrEpGmaphGpg1ckrk89mJZSRM95Jb7AKWqKush
         w+guI2sLzZiEyWp9StOW6boglMGlt5P7A7Uwg9SSqZQDo6QGTMNVdksPudhVchJkh0X0
         FQLA==
X-Gm-Message-State: APjAAAUPhZpnhAHIL036qeSjvNVNxbivs5aS7tImMkss6T+9buC1G/6M
        6TkaEdrXxgTs62wn/7t56c0hfg==
X-Google-Smtp-Source: APXvYqyfXOsAkfb+WZU94O3Uhfef8Bs7qDGwfrmczN9tcH4C4qyns8k0e3hADV1FZJVNG/VDNUQKOA==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr10573988wmf.100.1582996392052;
        Sat, 29 Feb 2020 09:13:12 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id r1sm17045046wrx.11.2020.02.29.09.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 09:13:11 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
Subject: [PATCH 3/3] virtio-net: Introduce hash report feature
Date:   Sat, 29 Feb 2020 19:13:01 +0200
Message-Id: <20200229171301.15234-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200229171301.15234-1-yuri.benditovich@daynix.com>
References: <20200229171301.15234-1-yuri.benditovich@daynix.com>
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
index 7a342657fb6c..6d7230469c57 100644
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
+	__virtio32 hash_value;
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
+	__virtio16 hash_report;
+	__virtio16 padding;
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
+	__virtio32 hash_types;
+	/* for compatibility with virtio_net_rss_config */
+	__virtio16 reserved[4];
+	__u8 hash_key_length;
+	__u8 hash_key_data[/*hash_key_length*/];
+};
+
+ #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2
+
 /*
  * Control network offloads
  *
-- 
2.17.1

