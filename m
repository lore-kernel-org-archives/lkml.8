Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FB7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E6022C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxpH72H+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgHCU6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:58:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57777 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727003AbgHCU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UIoKJgwiwHBXzqx7bTTScO5nMJSnsWEl2/CTLb7XXEY=;
        b=WxpH72H+L3sEB6TtSnxqb7vFux0fo9ihkEyrlYNMLIus6La1k0/czg57pjXkaE2a/PNyTE
        Y4+zBHEM3zX//ej1mB9TpKGWFTRhcpCzmzKt1kdoCoqkUmkM+FXgElXjTAMFSXYOhhsd2P
        YOTTqGQkZZhnvxYPJwgrPt4OVVDLGnM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-ViDliDEdPWKtPrFnDDPxvg-1; Mon, 03 Aug 2020 16:58:46 -0400
X-MC-Unique: ViDliDEdPWKtPrFnDDPxvg-1
Received: by mail-qk1-f199.google.com with SMTP id v22so11063675qkg.15
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UIoKJgwiwHBXzqx7bTTScO5nMJSnsWEl2/CTLb7XXEY=;
        b=HcySLiY6456TzByVpLX5c+BNm085YLhgOVlmtcY3bYfBKwSMu7oSYLzm3/DrPTUsCt
         HJzg9J2j1v94cpL6TP9zy3J542kpjxVzbBTgZP7s8QPC4xb0426nmF/4qRoEPZu31iBM
         srEC/IQf+R99Buvsa48P/dKDUmPjvJObtfCEDGTJ/QVVnzI1+aNtxIgYnnsrKbgUCgfD
         hXjiKHPOF+j7HQ7HMzl4a8Bysu/RIU0IqtGNOdX3t1an/cIptM73M5P0Wk1gE7EkwrwY
         mh9qEsTySf5TnxnZE1hVsqxyI9fu4wmKvKdIbu5y9jK2sS8g3XYcsqvETAWUX+A848nI
         tq/g==
X-Gm-Message-State: AOAM533b6VJGALIxs+/ZhSZlnKPq8/h4g2xroSlsIchLbH3t3xaT2UGA
        EMhnl0rQVFDBMryQyt55iRcXo7sb7JZ+q8Z8FkbJehuRfLyprwEFLC95wxAEoteKM8qD3EMlnk+
        4hpeAP77L9Wx+5dATtDB8KVKR
X-Received: by 2002:a05:620a:13cf:: with SMTP id g15mr16786168qkl.48.1596488325832;
        Mon, 03 Aug 2020 13:58:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/usVrinipJ2UNkJyBG8SnnEAzcc9qw/4hOyTpADhTf+Pw3MhloA9MKuwjt0FKT+pTufaqUQ==
X-Received: by 2002:a05:620a:13cf:: with SMTP id g15mr16786157qkl.48.1596488325620;
        Mon, 03 Aug 2020 13:58:45 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id i19sm19925205qkk.68.2020.08.03.13.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:58:45 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:58:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 02/24] virtio_ring: sparse warning fixup
Message-ID: <20200803205814.540410-3-mst@redhat.com>
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

virtio_store_mb was built with split ring in mind so it accepts
__virtio16 arguments. Packed ring uses __le16 values, so sparse
complains.  It's just a store with some barriers so let's convert it to
a macro, we don't loose too much type safety by doing that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 3dc70adfe5f5..b485b13fa50b 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -46,16 +46,15 @@ static inline void virtio_wmb(bool weak_barriers)
 		dma_wmb();
 }
 
-static inline void virtio_store_mb(bool weak_barriers,
-				   __virtio16 *p, __virtio16 v)
-{
-	if (weak_barriers) {
-		virt_store_mb(*p, v);
-	} else {
-		WRITE_ONCE(*p, v);
-		mb();
-	}
-}
+#define virtio_store_mb(weak_barriers, p, v) \
+do { \
+	if (weak_barriers) { \
+		virt_store_mb(*p, v); \
+	} else { \
+		WRITE_ONCE(*p, v); \
+		mb(); \
+	} \
+} while (0) \
 
 struct virtio_device;
 struct virtqueue;
-- 
MST

