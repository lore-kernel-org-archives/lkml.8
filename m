Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4A0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A80F22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUP5jcwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgHCU7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:59:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38693 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729079AbgHCU7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fjTvqLs5kODLJE0NPlW/uTfO7Hwyt71PbjjTwHT15mk=;
        b=EUP5jcwzeNlCfx/SN9HZyLZp6/ncDm2cxTYCQ8HHOXzj7snEGr3MlVD2QYOCfECBRxQj60
        uwcsToO3sGuCKZhBYK0h33YBH4SQGpFuzFLIo2sRZzKmbNy6ApUtg5LE5sG8Z3UFhbhfSe
        EhbRotTSQLJHbPCC4E8rifJp1iQd3NM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-A1C85rK9PtGsesJT1xGNDw-1; Mon, 03 Aug 2020 16:59:41 -0400
X-MC-Unique: A1C85rK9PtGsesJT1xGNDw-1
Received: by mail-qk1-f200.google.com with SMTP id h185so26975050qke.21
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fjTvqLs5kODLJE0NPlW/uTfO7Hwyt71PbjjTwHT15mk=;
        b=gaxwkfYLE1BIIWkHQRjPMd3wUeQFCUJTPKKZrngjs4lTp3Myq5eVEEzw4qRAKldxP8
         N1yuQf7UdQFUEPKfKTnQQCCAr/Gj8flQSFXrj8AcQbIf9b6SnQ1irRrRFgC/21GwZwvP
         1tJ1HA7cj4fwEzDaVem+fvn5+IKkqqTLAVskbSayHCpSh7UPdEyPIA3qzTMRVEWo/6YZ
         IzImXlUr8PlydHmemq4TM+uOWO/pgmxiFJxhPOQmY2hiftafp37iAfpP9PoecpfTXnGC
         98ly6X1GDzjduDiZDwR9+VZBiE47I8rHdbQfz18h48m1RwjdYZ6Ug5Xi2rP/wUTaV6y5
         h5Xw==
X-Gm-Message-State: AOAM530b9CH8dHcKaX2nFm853E5CL4hz0h0B9k1glSlQQzloWR3HRmsI
        kZng5c1BZqKbSofPRkOK/JsADf8xAexeRBvCGY48W4Ps3iCQnmZ9q9t48URgq9QWqe6DNTvuYaX
        D167I4zsgnLatN7bb3VKvPOGS
X-Received: by 2002:a0c:9b96:: with SMTP id o22mr9972780qve.213.1596488381232;
        Mon, 03 Aug 2020 13:59:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEguqZOe3xZZy/pY+5yOtpUFeU9lmaquTNGOLViCY4ibIUj0Gv+q+QgMy1YzWYJl71ATFrZg==
X-Received: by 2002:a0c:9b96:: with SMTP id o22mr9972745qve.213.1596488380695;
        Mon, 03 Aug 2020 13:59:40 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id l31sm24419314qtc.33.2020.08.03.13.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:40 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 14/24] virtio_net: correct tags for config space fields
Message-ID: <20200803205814.540410-15-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_net.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 19d23e5baa4e..27d996f29dd1 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -87,19 +87,19 @@ struct virtio_net_config {
 	/* The config defining mac address (if VIRTIO_NET_F_MAC) */
 	__u8 mac[ETH_ALEN];
 	/* See VIRTIO_NET_F_STATUS and VIRTIO_NET_S_* above */
-	__u16 status;
+	__virtio16 status;
 	/* Maximum number of each of transmit and receive queues;
 	 * see VIRTIO_NET_F_MQ and VIRTIO_NET_CTRL_MQ.
 	 * Legal values are between 1 and 0x8000
 	 */
-	__u16 max_virtqueue_pairs;
+	__virtio16 max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
-	__u16 mtu;
+	__virtio16 mtu;
 	/*
 	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
 	 * Any other value stands for unknown.
 	 */
-	__u32 speed;
+	__virtio32 speed;
 	/*
 	 * 0x00 - half duplex
 	 * 0x01 - full duplex
-- 
MST

