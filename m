Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC8B20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0yaHTcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGJKtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:49:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46414 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727863AbgGJKtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594378147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=UIoKJgwiwHBXzqx7bTTScO5nMJSnsWEl2/CTLb7XXEY=;
        b=c0yaHTcYMtIsTfjEMokuVAY5njscDvANLbK25B9byCkzYZ8GA8/33FICVxmMgYwd/hTXQm
        LLxgnKpgeYUevm9obiqlnmcFN+7MJXHg+t7XhJprAzQEvDYI6aQpwvqa1o9xFeYlBpcorg
        3bJTTo9KWSD1wbHu5OpGsDLXHFm50ZA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-AhwqG07ZPMOs1uCh8XsnSw-1; Fri, 10 Jul 2020 06:49:05 -0400
X-MC-Unique: AhwqG07ZPMOs1uCh8XsnSw-1
Received: by mail-wr1-f70.google.com with SMTP id g14so5649849wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 03:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UIoKJgwiwHBXzqx7bTTScO5nMJSnsWEl2/CTLb7XXEY=;
        b=Txwe0U+1h8Kt7r7goLf3X9CCjdYEHO+XZhBUPbRQyvQsTw6q6S/5bVx+C0O1Hk/vm1
         OLLb7IRIb/E5jY2aVsrzNBVNvMoVSZ8hCzF9B64AYr4otfiKlgmpO54f3OcyG7hOWDo7
         wBOwjHxgW080xjew27Y91vW26+f4YCj4nn61Gjl0fEP3jtk2kEa0lQpQbQTeScNcyAw5
         MCyuXMo3lIquSFjjYzIV+nfO+OSVlrgZeA5UaGwrZwoAq1s/xeh0LJ4pKnjkzEa9ffrl
         2585HEoVbNmj2R1ma4yo6lQ20gsbfjBqxNTFDj7nZhu1zlvtP3OJrKI+q0uEkZSvhk/e
         nt6g==
X-Gm-Message-State: AOAM533WX9Ov2XPAGaq//HhkuB2m5UJ1NyBv3AXeXLErReEqXQ3/0XsV
        zpXTpXfrYPXNFA/9L3HIQ0p2uKWmUxWufXhWyj1S5vJuqxZNV+EBUNdBrZyyQIyan5zHI/lyCC2
        zCWKXB2gByy4gUaNxzrFWE/GI
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr4450499wmj.5.1594378144464;
        Fri, 10 Jul 2020 03:49:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiVqSPwoFJmCuv4VkKtHKz+ZUBx2usJsVcKLHafPXfNp1z3D30HjV2wwFh+wFmgF6XIFZOHw==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr4450472wmj.5.1594378144099;
        Fri, 10 Jul 2020 03:49:04 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id d13sm9162933wrq.89.2020.07.10.03.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 03:49:03 -0700 (PDT)
Date:   Fri, 10 Jul 2020 06:49:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_ring: sparse warning fixup
Message-ID: <20200710104900.406084-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

