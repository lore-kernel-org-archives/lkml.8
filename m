Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30873C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAAD22070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+WUAfrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgETRH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:07:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49821 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726860AbgETRHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589994442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9d7VWgOSe/qjvNlnDodBcvOOgqJg891hEBMUAOJFSc=;
        b=P+WUAfrw1q7no8m7wyX+5Bb9RHLExdbBDVgwvaxwiu6ShBCna9l+1hYO3VugHQb3O5WLGW
        PcHkzdY/t0E25TpJBO16v8BL7hLGIs4IzQipbv7qv9a0SgOnLyOzSbtjLGMOhJDCdnUDs1
        /5f61P8oKJl1gkmx/fJElNy4N23QAU0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-OwN6kv5AOi22hhCZLz8ATw-1; Wed, 20 May 2020 13:07:21 -0400
X-MC-Unique: OwN6kv5AOi22hhCZLz8ATw-1
Received: by mail-wr1-f70.google.com with SMTP id r7so1662000wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9d7VWgOSe/qjvNlnDodBcvOOgqJg891hEBMUAOJFSc=;
        b=Eabw2FuVJtaoiiPVC7WFczeL/UcTz0izPvQHva4w2+QWatSHNWPjlvixDB721zDSEU
         gRr/v6areD1sec7EJjm80o+dd5rteb+dpEexJjLD/ryBXIacHTOxoxu9rLGE7jP83mcy
         FH2VZEZGMgxpRK9Ts5PoMehlugHNoUiqxf/u+H5wjqSVEEFq9Uj+D+Js3pkCwn0WVzuT
         1GKHS/++VI9nXF8EqHTtJpsADYa9PDiXPrk7afNxJHLDZ89+cmG4D3K41iVpgJAGJY6A
         V/tEQtTKPKFmbyxtmi8tDgsVhbLEq0naL4kJX0ghg+xYJ34dtz333Vh2pHs0Ru6iwnuF
         Th8Q==
X-Gm-Message-State: AOAM530Wir3a4WoK/In398BJI+QdDxMLFArOKbr4RRGHBxF+oMKImDrf
        pn/b1z14ERCiz2Js/GctJLa+/g1aWsNIH61xxK16yEriwGoI+L3f8VzLyTcVogWTbeBWqelj8Cx
        z0Bp/DwDbYGAtVBu3hO8egu5a
X-Received: by 2002:a1c:7515:: with SMTP id o21mr5343857wmc.52.1589994440014;
        Wed, 20 May 2020 10:07:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP/KAxcq+j3CuGhNdzPkxWKaWxRgPtfGdNQFk2DNOJ7uQe76sv4GxyNOb9EzJKk680RI+xFA==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr5343843wmc.52.1589994439789;
        Wed, 20 May 2020 10:07:19 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id u74sm3768614wmu.13.2020.05.20.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:07:19 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [PATCH liburing v2 3/5] Add helpers to set and get eventfd notification status
Date:   Wed, 20 May 2020 19:07:12 +0200
Message-Id: <20200520170714.68156-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200520170714.68156-1-sgarzare@redhat.com>
References: <20200520170714.68156-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new IORING_CQ_EVENTFD_DISABLED flag. It can be
used to disable/enable notifications from the kernel when a
request is completed and queued to the CQ ring.

We also add two helpers function to check if the notifications are
enabled and to toggle them.

If the kernel doesn't provide CQ ring flags, the notifications are
always enabled if an eventfd is registered.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1 -> v2:
- renamed io_uring_cq_eventfd_toggle()
- return EOPNOTSUPP only if we need to change the flag
---
 src/include/liburing.h          | 33 +++++++++++++++++++++++++++++++++
 src/include/liburing/io_uring.h |  7 +++++++
 2 files changed, 40 insertions(+)

diff --git a/src/include/liburing.h b/src/include/liburing.h
index adc8db9..0192b47 100644
--- a/src/include/liburing.h
+++ b/src/include/liburing.h
@@ -9,7 +9,9 @@ extern "C" {
 #include <sys/socket.h>
 #include <sys/uio.h>
 #include <sys/stat.h>
+#include <errno.h>
 #include <signal.h>
+#include <stdbool.h>
 #include <inttypes.h>
 #include <time.h>
 #include "liburing/compat.h"
@@ -445,6 +447,37 @@ static inline unsigned io_uring_cq_ready(struct io_uring *ring)
 	return io_uring_smp_load_acquire(ring->cq.ktail) - *ring->cq.khead;
 }
 
+static inline bool io_uring_cq_eventfd_enabled(struct io_uring *ring)
+{
+	if (!ring->cq.kflags)
+		return true;
+
+	return !(*ring->cq.kflags & IORING_CQ_EVENTFD_DISABLED);
+}
+
+static inline int io_uring_cq_eventfd_toggle(struct io_uring *ring,
+					     bool enabled)
+{
+	uint32_t flags;
+
+	if (!!enabled == io_uring_cq_eventfd_enabled(ring))
+		return 0;
+
+	if (!ring->cq.kflags)
+		return -EOPNOTSUPP;
+
+	flags = *ring->cq.kflags;
+
+	if (enabled)
+		flags &= ~IORING_CQ_EVENTFD_DISABLED;
+	else
+		flags |= IORING_CQ_EVENTFD_DISABLED;
+
+	IO_URING_WRITE_ONCE(*ring->cq.kflags, flags);
+
+	return 0;
+}
+
 /*
  * Return an IO completion, waiting for 'wait_nr' completions if one isn't
  * readily available. Returns 0 with cqe_ptr filled in on success, -errno on
diff --git a/src/include/liburing/io_uring.h b/src/include/liburing/io_uring.h
index 9860a8a..92c2269 100644
--- a/src/include/liburing/io_uring.h
+++ b/src/include/liburing/io_uring.h
@@ -210,6 +210,13 @@ struct io_cqring_offsets {
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

