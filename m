Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8E3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D9C206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpf5fKUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgETRHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:07:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34983 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726560AbgETRHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589994440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05KQX8lVPlCt8vmRWHdvXIWoBaoV9a3Uogcp9WxiQ8g=;
        b=dpf5fKUsxaKIDTiQMZYZpXZqpnsXuKEYMVeKYO4eyI5dPwxI0ve2ZPaOhor7oWAytRDk6b
        rWBwFO0z5c+1vtawytRylBrVjsqbaNoH85pGWU6MSWhC+dWlucolq2dpQOk1Q9tjjLWiSH
        TphmDVS61eU4m6SPbXgjt0Fw1VkCH4k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-Ym2gmKKSM9ycGxwYlqcrFQ-1; Wed, 20 May 2020 13:07:19 -0400
X-MC-Unique: Ym2gmKKSM9ycGxwYlqcrFQ-1
Received: by mail-wm1-f69.google.com with SMTP id g10so1521562wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05KQX8lVPlCt8vmRWHdvXIWoBaoV9a3Uogcp9WxiQ8g=;
        b=evmwEQkHiHbqTeCqmbTbPmhRBWO/FaZcwM3AwrMJHkvjfsH4f6dBBlXJYP9wVuqQ+9
         Q89Sl782Qwi+waSQIqhjjw0o9rsB8Q6MEQdQC6HrykrRpraj8KrdxRuifYdC8vRxpb7v
         RgwvRkN0iGXIm+5PLhVexU266wFNomBCWd9utUnujZSJMktHeRdBDJBo4n2eJ/wjnun3
         zRMU0gJEe3sGiEpL8klcX7jg2VleXzmzmm3r829C92psax2+PLaKQiAlv7pQ7Q6jhwY6
         5A7qCk+drAzHfPdnfVO2Fv0jn78wvyC/Ztegz/5JaHgkGmUTWHq53WZGaQBSX1EoTDpw
         03EQ==
X-Gm-Message-State: AOAM533BkWXu8ae12F+ACzyL2KvkkolX6Yl+N+ZUjkqDv4rWwD3f53CH
        zSCJ2O7t7tL118ziTUEecsKJ9S2Rh60jAjqtbomb/k+mIuODJnuMC+vb5aQlGVe1AYQXGVs3I2G
        bazPnDcGXYSMf2iDDXeG8g8nU
X-Received: by 2002:adf:a15c:: with SMTP id r28mr256970wrr.337.1589994437574;
        Wed, 20 May 2020 10:07:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+adX5YucyY7E4vzhaND3YOzLEGdbHzr9/aBODa2oQodWTjohpKwnZCVuELuNx5MWcx6XbzQ==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr256959wrr.337.1589994437393;
        Wed, 20 May 2020 10:07:17 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id u74sm3768614wmu.13.2020.05.20.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:07:16 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [PATCH liburing v2 1/5] Add CQ ring 'flags' field
Date:   Wed, 20 May 2020 19:07:10 +0200
Message-Id: <20200520170714.68156-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200520170714.68156-1-sgarzare@redhat.com>
References: <20200520170714.68156-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

io_uring provides the new CQ ring 'flags' field if 'cq_off.flags'
is not zero. In this case we set the 'cq->kflags' pointer, otherwise
it will be NULL.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 src/include/liburing.h          | 1 +
 src/include/liburing/io_uring.h | 4 +++-
 src/setup.c                     | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/include/liburing.h b/src/include/liburing.h
index 4311325..adc8db9 100644
--- a/src/include/liburing.h
+++ b/src/include/liburing.h
@@ -41,6 +41,7 @@ struct io_uring_cq {
 	unsigned *ktail;
 	unsigned *kring_mask;
 	unsigned *kring_entries;
+	unsigned *kflags;
 	unsigned *koverflow;
 	struct io_uring_cqe *cqes;
 
diff --git a/src/include/liburing/io_uring.h b/src/include/liburing/io_uring.h
index a279151..9860a8a 100644
--- a/src/include/liburing/io_uring.h
+++ b/src/include/liburing/io_uring.h
@@ -205,7 +205,9 @@ struct io_cqring_offsets {
 	__u32 ring_entries;
 	__u32 overflow;
 	__u32 cqes;
-	__u64 resv[2];
+	__u32 flags;
+	__u32 resv1;
+	__u64 resv2;
 };
 
 /*
diff --git a/src/setup.c b/src/setup.c
index f783b6a..860c112 100644
--- a/src/setup.c
+++ b/src/setup.c
@@ -76,6 +76,8 @@ err:
 	cq->kring_entries = cq->ring_ptr + p->cq_off.ring_entries;
 	cq->koverflow = cq->ring_ptr + p->cq_off.overflow;
 	cq->cqes = cq->ring_ptr + p->cq_off.cqes;
+	if (p->cq_off.flags)
+		cq->kflags = cq->ring_ptr + p->cq_off.flags;
 	return 0;
 }
 
-- 
2.25.4

