Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67695C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42525206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGVF2RwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgHEROP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:14:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37551 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728448AbgHERKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fjTvqLs5kODLJE0NPlW/uTfO7Hwyt71PbjjTwHT15mk=;
        b=EGVF2RwGNQi/LR/xQ8eK05ZMEOFYuvXI4ZsB6PhVOLbrHt+V/S6qbTFAf8P8l/dviCoeRY
        DZTE2zA4gr+caehcU6v7BagM29COlvltzvJi5QgFA2GLjL0JZzTEsPZFHpneIHyRpafIcM
        Qr4ntLzqAAqJntmyVT8HY3Rk1/k84lo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-1K0-KLjmMTiHb9ay3ksVmQ-1; Wed, 05 Aug 2020 09:43:57 -0400
X-MC-Unique: 1K0-KLjmMTiHb9ay3ksVmQ-1
Received: by mail-wr1-f69.google.com with SMTP id w7so11246106wre.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fjTvqLs5kODLJE0NPlW/uTfO7Hwyt71PbjjTwHT15mk=;
        b=claxx+lxsj5m6ffz+iKwBTPbk5WGhB6Vht/QNEXXEwgaupL6c1IqF4c9yz6DZ3VHsy
         ROAnxXHWw7QIdHvWAztxyHUmt7H6vRBZVgGl9DO7jBqJGMzhhkULGqvVEmgIFMnTAUuG
         JOVcK2P2sv7ujAt7BB6UMhhbtBeqZyc61UgZRji/q2O67mAkS95dcGomth6hDD7fPI9f
         3Kil/hVWs/cZeGn5GmW5tsZ17byvFTW7VGJB1av6zYeW1W+KxtWapn3WBHMSunotSvjd
         z75W7vKEWPc92NMHp66D2rNQPduZ2Qnw0eLoMhwVtUjHKTcq3+/lj7glZnUq3v5y5Hu9
         ygbA==
X-Gm-Message-State: AOAM531qdWcURZGyKMZUnlwqLk/fbXva0UV5DmfgCHC8pBwC+2YEMTEN
        nYyAX2w8r3uuzG59rtTmuEtNLTnnRshlV3WKgbhPG7h5JXHwmaUBg4n9xjhLGptIxLBeVvedKFl
        AS7/EDaJI1GBti5n+9KwVRQbm
X-Received: by 2002:a5d:6748:: with SMTP id l8mr3043785wrw.358.1596635036454;
        Wed, 05 Aug 2020 06:43:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxID3Okk6UkDH7ORpBlS1Sx9zjE5MzCmMtq8kERdyW86XULNXmYx6/P0/ZTdrOJ29PfTdjexQ==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr3043772wrw.358.1596635036229;
        Wed, 05 Aug 2020 06:43:56 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id g14sm2898470wmk.37.2020.08.05.06.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:55 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 14/38] virtio_net: correct tags for config space fields
Message-ID: <20200805134226.1106164-15-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
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

