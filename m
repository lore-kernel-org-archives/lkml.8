Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210D0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE5520709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pjr5rGOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgEOKy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:54:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53448 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726297AbgEOKyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589540062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAOMWx6OVu3YpynCtja6bREESlXthahEC6nREl9YhPo=;
        b=Pjr5rGODlNgTplhd2E10At0TOOkQGHA14iWNQ3M1rqTRdqTryPLFUUcRtEAqcjcW4zMHyi
        x3ioOd7n0V7XJwTUNMF4VoxZ+DDCRAZIWOEcClpiG6v8ze04MKD83sAKxTp6uX26HAZjU6
        9QS1Rm6LyhAEQsgNX8qKbhDOBdm7MB4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-U8urMhy2O3aSYRBsc6fuVw-1; Fri, 15 May 2020 06:54:21 -0400
X-MC-Unique: U8urMhy2O3aSYRBsc6fuVw-1
Received: by mail-wr1-f71.google.com with SMTP id z16so993775wrq.21
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FAOMWx6OVu3YpynCtja6bREESlXthahEC6nREl9YhPo=;
        b=eqGLtBwAaPzJp/HjgSNCmQGTdbEJROzTc4hS2z9PJCczw5yKTXNGYQIXWkd1Db9wpc
         J6AyAvZ9G1SursaHBbkTwWpUV78MdqYA0lZPT6XaL0bgVuldcCrWtb4vE1rwgdYvWazx
         RF4O52O4dlwq0JR1trjjFxeu9UCt8zj5CTWTjawJxmQ1KXSuu0MVjcP1LPakblCVfP5N
         8SU7uCXp8Mnwy7ht8T0ArQKfXBcC669fDar1RWXY4DgYouXYIyfZGLKcvz38sLrj2xf4
         rVmYH0hNjZQLAPcCesqfV8Y1VNmSagLoJier9gUVlpy3tpD3yXFNiZ4dZA2GB81ZrjJ3
         Vnhw==
X-Gm-Message-State: AOAM5322yuYHrF22eI1VKA10pnYct2/vlRYxrLJm/vN5Dym6VbkbRn8S
        CAmxoh91sANYWGHMaE4Axl6EAGEiSAx7SnE/bM9/8Ip8YrHLfUEvn0odFzWZAU7Fd1amml6MD99
        tkRNAOQDSno+bYbsUZJquB8lW
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr3623537wrv.155.1589540059925;
        Fri, 15 May 2020 03:54:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4HCg1+ZO2PPPCFOjhk551z/9enVbNA+X4sgmGqe+RDc8hyFQZev92P69lM/DpFfkAbRAVQw==
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr3623519wrv.155.1589540059653;
        Fri, 15 May 2020 03:54:19 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id u74sm3081713wmu.13.2020.05.15.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:54:18 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/2] io_uring: add IORING_CQ_NEED_WAKEUP to the CQ ring flags
Date:   Fri, 15 May 2020 12:54:14 +0200
Message-Id: <20200515105414.68683-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200515105414.68683-1-sgarzare@redhat.com>
References: <20200515105414.68683-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new flag should be set/clear from the application to
enable/disable eventfd notifications when a request is completed
and queued to the CQ ring.

Before this patch, notifications were always sent if an eventfd is
registered, so to remain backwards compatible we enable them during
initialization.

It will be up to the application to disable them after initialization if
no notifications are required at the beginning.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 fs/io_uring.c                 | 7 +++++++
 include/uapi/linux/io_uring.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6e8158269f3c..7c9486ea5aa3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1152,6 +1152,8 @@ static inline bool io_should_trigger_evfd(struct io_ring_ctx *ctx)
 {
 	if (!ctx->cq_ev_fd)
 		return false;
+	if (!(READ_ONCE(ctx->rings->cq_flags) & IORING_CQ_NEED_WAKEUP))
+		return false;
 	if (!ctx->eventfd_async)
 		return true;
 	return io_wq_current_is_worker();
@@ -7684,6 +7686,11 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	rings->cq_ring_mask = p->cq_entries - 1;
 	rings->sq_ring_entries = p->sq_entries;
 	rings->cq_ring_entries = p->cq_entries;
+	/*
+	 * For backward compatibility we start with eventfd notification
+	 * enabled.
+	 */
+	rings->cq_flags |= IORING_CQ_NEED_WAKEUP;
 	ctx->sq_mask = rings->sq_ring_mask;
 	ctx->cq_mask = rings->cq_ring_mask;
 	ctx->sq_entries = rings->sq_ring_entries;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 602bb0ece607..1d20dc61779e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -209,6 +209,11 @@ struct io_cqring_offsets {
 	__u64 resv2;
 };
 
+/*
+ * cq_ring->flags
+ */
+#define IORING_CQ_NEED_WAKEUP	(1U << 0) /* needs wakeup through eventfd */
+
 /*
  * io_uring_enter(2) flags
  */
-- 
2.25.4

