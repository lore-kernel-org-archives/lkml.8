Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A782BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B9322D37
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDNOHfik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgHERZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:25:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35886 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728753AbgHERPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HkyF/Dj2YbQk925n8jpSxZl3WTla4XTyR2sv7xNltEE=;
        b=WDNOHfikAl5BcY8I7Fa0zvLo4cI83xHhH4z9mmlIm5TvJRkah/h50NzM3bwf/ojj8MaOKE
        6i8bKpk7grMlASfkmWxmCzfA5SJ2MSaCNcw8YjgeOoRD7y22QT7ka8x2rOnJ5dr3ywQByE
        0pL5V3pEaQ3+3tizPJoP8Tf4cIwMVTM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-GKLgb3AFMGuXh9t_-__wsg-1; Wed, 05 Aug 2020 09:43:25 -0400
X-MC-Unique: GKLgb3AFMGuXh9t_-__wsg-1
Received: by mail-wm1-f71.google.com with SMTP id u144so2739706wmu.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HkyF/Dj2YbQk925n8jpSxZl3WTla4XTyR2sv7xNltEE=;
        b=DK2ZgY80a/LKLYCwGlfoX9jX1j3PMtSTq1jZcFqyka3LKVQg7gzTNDModDwNaxF4Ni
         601LMQ7bI3vAP5ELNWlrsw4oxApRfZy5NguJEMPspGNOyLugraO8b3OUcNfbQDH26/w9
         tANcmhILUFT2qEj/6GJ9GdBy4e1dq57giLljnMa5iUAKR1CPA438CsEIl2avi0Zcu+al
         VerbgBlWPpSRqIyWGEV3YhtCdzRv2fCKuJ05USiyQt+xtNdzR1neAr5CiF76V+BkCFmE
         uXuqz7DuLNEmrtE8O3gZVP25A2e8tplQcG2pVCOTln3aJhhHwTmYt5F/9JsIjgNR/zrz
         3pqg==
X-Gm-Message-State: AOAM530j6VdQr/+v2vThcToq1mS1S0hx2DCGvDoQBL7HbK8zMta3bFrg
        ECIfmOZEUPjfzX4F8xajdkyA636ObTDiyR9Q4d1dV0xftf5m8gc442G6HFRcPymYeWIqx5Ugwjc
        x8hx5b0gklpwAUmG63EfkxiUn
X-Received: by 2002:a7b:c084:: with SMTP id r4mr3293484wmh.23.1596635002272;
        Wed, 05 Aug 2020 06:43:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj0YQv1KBlUtTVuToDSecN05nzWcafaofE4HtyHWiYNZN2DH6Gv3yeUfPj+zB811yd1PZOAA==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr3293465wmh.23.1596635002027;
        Wed, 05 Aug 2020 06:43:22 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id 111sm2849048wrc.53.2020.08.05.06.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:21 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 02/38] virtio_ring: sparse warning fixup
Message-ID: <20200805134226.1106164-3-mst@redhat.com>
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

virtio_store_mb was built with split ring in mind so it accepts
__virtio16 arguments. Packed ring uses __le16 values, so sparse
complains.  It's just a store with some barriers so let's convert it to
a macro, we don't loose too much type safety by doing that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
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

