Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9E2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866392076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVS0BvkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgEOQiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:38:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbgEOQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589560693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gZ5R0zPx7v8Q5QUl+dC4PL1yY2tt7RqoIbj3l8sE74=;
        b=OVS0BvkZTZX8VAP7WKqCcEsyKi8CcjKryS5eG11F3TGafFb9uKe2aMPgGIG8oXR9on4pYd
        F6vY+6xDzKHREcgmkNHw1icJMNAA5cDoJSa4QYAIyfmZZwe+hxk/sJNk44/C3OrI5KqQ3x
        96eTsP9kzdm3ZVG8jc4sdA/CwDNtLmc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-DoEot4NXOA-wB8tVlTv9RQ-1; Fri, 15 May 2020 12:38:10 -0400
X-MC-Unique: DoEot4NXOA-wB8tVlTv9RQ-1
Received: by mail-wr1-f72.google.com with SMTP id y7so1433449wrd.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gZ5R0zPx7v8Q5QUl+dC4PL1yY2tt7RqoIbj3l8sE74=;
        b=FRqcRauuMIzBe02CCUzBO4fXakSxISCs2o8/1zLYwZZoVWUqs0a3YenCg6961PplIC
         s1IFnG5P1GnylDMibquHgQl5dFz2oFAICNXnWFRDEzUQ5MzsejlMkeTs8WK3enWqdsXP
         KMdpx2C84D6lrODqkzP8sYztZBS5eVAK1yS9KJcaC5++591CXN8WJMKFq+yjo/2fy/kr
         mQEZucx/c/V42XRkZEAJiv0r2A1Q4c4pbiEnVA/HgTdaFrc7MrF86c0JaT0YATItmclx
         wpzjzRuzojgdPGmifVDkg0pTGg6Pix8YrXizRiDDiw1lS4dnf1+J1kl5A+Y0aY6RxN+m
         U03g==
X-Gm-Message-State: AOAM532PVUttSoOr6M88+orJ/XycogvuAN9S2H3lUyIIpuOJiMndEBmr
        8isZjhUopKm99qkDcvFY5uH8huhSzcA3WzW8WlMtSAXbzcsYrNl+nED02P4sMHa6EEaYYmFm7fr
        uufr4LmLHZl/bWgO+BYP9BI0u
X-Received: by 2002:adf:dc0f:: with SMTP id t15mr5068326wri.165.1589560688995;
        Fri, 15 May 2020 09:38:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF+hp4GbO5uog6iIPuueL5jjs4PZEKrB1UaoTN20cj9bx0TDVFE81Yzd2+7qty/BxbZXjrMA==
X-Received: by 2002:adf:dc0f:: with SMTP id t15mr5068296wri.165.1589560688701;
        Fri, 15 May 2020 09:38:08 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id b145sm4680274wme.41.2020.05.15.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:38:08 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] io_uring: add 'cq_flags' field for the CQ ring
Date:   Fri, 15 May 2020 18:38:04 +0200
Message-Id: <20200515163805.235098-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200515163805.235098-1-sgarzare@redhat.com>
References: <20200515163805.235098-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new 'cq_flags' field that should be written by
the application and read by the kernel.

This new field is available to the userspace application through
'cq_off.flags'.
We are using 4-bytes previously reserved and set to zero. This means
that if the application finds this field to zero, then the new
functionality is not supported.

In the next patch we will introduce the first flag available.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 fs/io_uring.c                 | 10 +++++++++-
 include/uapi/linux/io_uring.h |  4 +++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 979d9f977409..6e8158269f3c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -142,7 +142,7 @@ struct io_rings {
 	 */
 	u32			sq_dropped;
 	/*
-	 * Runtime flags
+	 * Runtime SQ flags
 	 *
 	 * Written by the kernel, shouldn't be modified by the
 	 * application.
@@ -151,6 +151,13 @@ struct io_rings {
 	 * for IORING_SQ_NEED_WAKEUP after updating the sq tail.
 	 */
 	u32			sq_flags;
+	/*
+	 * Runtime CQ flags
+	 *
+	 * Written by the application, shouldn't be modified by the
+	 * kernel.
+	 */
+	u32                     cq_flags;
 	/*
 	 * Number of completion events lost because the queue was full;
 	 * this should be avoided by the application by making sure
@@ -7834,6 +7841,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p,
 	p->cq_off.ring_entries = offsetof(struct io_rings, cq_ring_entries);
 	p->cq_off.overflow = offsetof(struct io_rings, cq_overflow);
 	p->cq_off.cqes = offsetof(struct io_rings, cqes);
+	p->cq_off.flags = offsetof(struct io_rings, cq_flags);
 
 	p->features = IORING_FEAT_SINGLE_MMAP | IORING_FEAT_NODROP |
 			IORING_FEAT_SUBMIT_STABLE | IORING_FEAT_RW_CUR_POS |
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index e48d746b8e2a..602bb0ece607 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -204,7 +204,9 @@ struct io_cqring_offsets {
 	__u32 ring_entries;
 	__u32 overflow;
 	__u32 cqes;
-	__u64 resv[2];
+	__u32 flags;
+	__u32 resv1;
+	__u64 resv2;
 };
 
 /*
-- 
2.25.4

