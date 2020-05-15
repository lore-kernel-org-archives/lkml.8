Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821C2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FC92076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcD2vNS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgEOQiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:38:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57613 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbgEOQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589560692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZmrRZSpZSImU0ZWw6sQoh3piuQw6gdHG9URSW684/o=;
        b=GcD2vNS8e3Lv9h8JGJhsQsUusMpyqIrAZknTxnOwRVzcQhA04/1BnY92z/Te+dIqU7hfPP
        u3KL9X8IUuXG5bwMzIl05ZIybo6oSa2J/gZ6QsUaDVcpNu4wjGbxcg+0UyRGaUTwHycxL/
        bWZIY0hXSd/nj8zX6+QP6BGdaR8OCF4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-lpChFlDgMfyiKNAMYmouIA-1; Fri, 15 May 2020 12:38:11 -0400
X-MC-Unique: lpChFlDgMfyiKNAMYmouIA-1
Received: by mail-wr1-f70.google.com with SMTP id 37so1451867wrc.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZmrRZSpZSImU0ZWw6sQoh3piuQw6gdHG9URSW684/o=;
        b=rWYxmUS4BOcB3LRXrSSxRZiFaRJcdWmAAreyFLKDqjy+rXNl+k32MCUIG9Y3zRyGdZ
         h1YbpQI805uy4PXWln4eXhetezu6hzNy07HRjImtOqQ1tm4tbGIgPwtS2ezIkdEDwuT2
         GLUUoT0NyEZSU57mFqBUmZDovyZUg7wRJ1z8WlX3Yx09VKYNbw4W4Kb8poLP+ntW5iLM
         /wgNRAW1U5TrYoPupWaDyORalBrdoa+atKq8UkXnCh27QULSubzonFG6RetPGS46PUh4
         lik5x+v/eIT2tlpw6ryxEiGbLWFkErZxkgkZXKDtjJubnQb+K0mHl2YrGy+IwPiTVpYG
         MIyA==
X-Gm-Message-State: AOAM530rTJC018GIACeUfnPN0AHK5PVnQx1N2/q6bDvRl1YqvIYkT/ls
        D9ZH2hhsHppQSjkQVEwLrgq+bDDgZ8c2noibuxaoMACQcSZOPvJg5UaP2pU1HuLDiKXgCTOklWF
        PDO86aPq901FlKRnFqlnl3JdQ
X-Received: by 2002:adf:ed82:: with SMTP id c2mr5379927wro.255.1589560690177;
        Fri, 15 May 2020 09:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHkK+pYRdkGRoBHu7DvxKUQxjk5W5DN2qukBf2VTAqpWYC92WZ6RC31kIRR64YG+MD9jnxcw==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr5379900wro.255.1589560689927;
        Fri, 15 May 2020 09:38:09 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id b145sm4680274wme.41.2020.05.15.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:38:09 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] io_uring: add IORING_CQ_EVENTFD_DISABLED to the CQ ring flags
Date:   Fri, 15 May 2020 18:38:05 +0200
Message-Id: <20200515163805.235098-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200515163805.235098-1-sgarzare@redhat.com>
References: <20200515163805.235098-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new flag should be set/clear from the application to
disable/enable eventfd notifications when a request is completed
and queued to the CQ ring.

Before this patch, notifications were always sent if an eventfd is
registered, so IORING_CQ_EVENTFD_DISABLED is not set during the
initialization.

It will be up to the application to set the flag after initialization
if no notifications are required at the beginning.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1 -> v2:
 - changed the flag name and behaviour from IORING_CQ_NEED_EVENT to
   IORING_CQ_EVENTFD_DISABLED [Jens]
---
 fs/io_uring.c                 | 2 ++
 include/uapi/linux/io_uring.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6e8158269f3c..a9b194e9b5bd 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1152,6 +1152,8 @@ static inline bool io_should_trigger_evfd(struct io_ring_ctx *ctx)
 {
 	if (!ctx->cq_ev_fd)
 		return false;
+	if (READ_ONCE(ctx->rings->cq_flags) & IORING_CQ_EVENTFD_DISABLED)
+		return false;
 	if (!ctx->eventfd_async)
 		return true;
 	return io_wq_current_is_worker();
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 602bb0ece607..8c5775df08b8 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -209,6 +209,13 @@ struct io_cqring_offsets {
 	__u64 resv2;
 };
 
+/*
+ * cq_ring->flags
+ */
+
+/* disable eventfd notifications */
+#define IORING_CQ_EVENTFD_DISABLED	(1U << 0)
+
 /*
  * io_uring_enter(2) flags
  */
-- 
2.25.4

