Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E0DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8713222C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaNCLoo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgHCVAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:00:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20588 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729171AbgHCVAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=THaB8S+209mrmnxdJZIOkJCpQ5DDeAQcpm4IqDkBrvY=;
        b=VaNCLoo1Btp6/Go5q3/Ez7pu5F/Z+A7bo42howe+0XLEiRzIq9s1JZoVnZNYakcqfR8Vs9
        so79hdh29LpXDPel+b0cfqDHvL15Ex6guKiDU+jXGbAtaTpdajRCpYDSBqrl5p72HaDSr8
        O+ER5/39Rv2f92Gz6R8krPDMjw839oE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-FkES2kB0OriNAiFlGLX31Q-1; Mon, 03 Aug 2020 17:00:02 -0400
X-MC-Unique: FkES2kB0OriNAiFlGLX31Q-1
Received: by mail-qt1-f197.google.com with SMTP id r9so27755739qtp.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=THaB8S+209mrmnxdJZIOkJCpQ5DDeAQcpm4IqDkBrvY=;
        b=X9BD82ozwIzBZZvwOMRuxnN5TrdvHXksVeCDYNg/wYLpoLNIyHdggaO6nVSI0fqzl1
         W2r36ML239oIzWvrOwU+s8M4MsIOxjgoVWG/GlpJhFnaQaFLApYQmkJjMiBvGonNxzV2
         CK2MFwYbAsCs0iy1W5ByoixjoBqigL5nLaYMLaE7mAhWayv69uI/YhWsB8x/TYqY1CVC
         PUxDKbHlUFwEFF9wfPf6ANQK/HynFqhBOZnlGu5EO8PRyhl25tg4356gYjtE6AMkLglv
         EZwY9qeog92IY0xBEYXU/H3eYt6cqnr1hjO5R0wjeUVOU/DaNxlAxM1fjhPZ5r5pS6jg
         9Kcg==
X-Gm-Message-State: AOAM531fUAliWP6n3rmFd3AVEOZpIPSAzlGLWT+9LLOTGUzURG5H4sCx
        N4lHqTyXN0/w9ahwHxRR1XTx6DhxBSR8at9YAPmsXj9+/jqrka6Q3PRnJ1WXZShAwijBNWRU6Ur
        iy/Rcuqs7LdIMuPQ4NHNpQqzl
X-Received: by 2002:ac8:520f:: with SMTP id r15mr19359541qtn.116.1596488401509;
        Mon, 03 Aug 2020 14:00:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpoSbBmND+77f/SL3KacqAGZQ60M66o69zSkBXnG4eygyZXA8NQ5Vn+5rYip5o5+5O6T9cDg==
X-Received: by 2002:ac8:520f:: with SMTP id r15mr19359526qtn.116.1596488401300;
        Mon, 03 Aug 2020 14:00:01 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id w44sm23888660qtj.86.2020.08.03.13.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:00:00 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 17/24] virtio_config: disallow native type fields
Message-ID: <20200803205814.540410-18-mst@redhat.com>
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

Transitional devices should all use __virtioXX types.
Modern ones should use __leXX.
_uXX type would be a bug.
Let's prevent that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 64da491936f7..c68f58f3bf34 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -319,9 +319,8 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 	__virtio_pick_type(x, __u8, __u8,					\
 		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
 			__virtio_pick_endian(x, __le16, __le32, __le64,		\
-				__virtio_pick_endian(x, __u16, __u32, __u64,	\
-					/* No other type allowed */		\
-					(void)0)))))
+				/* No other type allowed */			\
+				(void)0))))
 
 #endif
 
-- 
MST

