Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C799AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A167520709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrLU5H/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgEOKyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:54:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35846 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726263AbgEOKyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589540061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gZ5R0zPx7v8Q5QUl+dC4PL1yY2tt7RqoIbj3l8sE74=;
        b=YrLU5H/kXbxZCpwxOmce6wXJ/wyJ2mIyi2CFVxRJv2i6WLoOy32xFV8bXOSgJipAsG2Rx/
        VilN1rUxroombldSoU/4v/pTUEMao9eSbysA2fUBEshEmDQrGy7QRfu367YX0YGNUGP+k/
        uXy7ZTxQlWrbRlju9gHLifpfGX6dZM4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-52c0XxCNPlWod26DgbYGoQ-1; Fri, 15 May 2020 06:54:20 -0400
X-MC-Unique: 52c0XxCNPlWod26DgbYGoQ-1
Received: by mail-wm1-f69.google.com with SMTP id e15so5250420wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gZ5R0zPx7v8Q5QUl+dC4PL1yY2tt7RqoIbj3l8sE74=;
        b=BtQ3rekkojkSxjjHZhTxiazvcZ7vp8wsWkdKwwgwACHM6tcNNNuWlRU64NBNMN51hz
         EZ1ymtW9OdpvdL85/oyEAd4y5mi3l1YFCM1FKJdAV69RlL2pc6Xi5avdw6JDhEAw+mmf
         5kiLWbr34qW5TTpGWIbU+FsV+MniE15D6Q45wBOduVTJjCPNiUmmv1XtcSldZ6pyZ1ZC
         8ZtcI2NWXtPqfM7M6hPprigK4RAx9che3puCSrAJRjBnYMlnvQwcnso0exO86p9U7pfi
         NqHEPx/MCYD/PIlGVhbqOyI80xnlGCZV1ogfuAHBgW9PSwZi5IZ6V7k4dMgFGZskS3QE
         np/A==
X-Gm-Message-State: AOAM532WRyHi0cyLgcXSxqNYLH8SB9RrlTJktChpm7PLtb0D19tLWox6
        64QxQW5m2c/PidIoiBRZF56ODObPaWqkZy3g7sALUUWgVu4gd6aXkgscIQWr0IzFhf/IFLe/a32
        Gf1q8uOqyBgLCoMjlWCKJmooa
X-Received: by 2002:adf:a151:: with SMTP id r17mr3552499wrr.161.1589540058508;
        Fri, 15 May 2020 03:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyANinCJRe3qYf2rSPZc3k0J3adf1PvxM/KmGOwiUEErSAAvt9ePGHUThMA2CAAwwoOjOO2vQ==
X-Received: by 2002:adf:a151:: with SMTP id r17mr3552475wrr.161.1589540058226;
        Fri, 15 May 2020 03:54:18 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id u74sm3081713wmu.13.2020.05.15.03.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:54:17 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/2] io_uring: add 'cq_flags' field for the CQ ring
Date:   Fri, 15 May 2020 12:54:13 +0200
Message-Id: <20200515105414.68683-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200515105414.68683-1-sgarzare@redhat.com>
References: <20200515105414.68683-1-sgarzare@redhat.com>
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

