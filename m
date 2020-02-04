Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D604FC33CAC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2892087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hAKlVKM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBDC5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:57:03 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36819 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgBDC5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:57:00 -0500
Received: by mail-pj1-f65.google.com with SMTP id gv17so700027pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Icxfnp9HKjOCxxd8LHDLtBzlH++tvRBMGK02TWhaPYI=;
        b=hAKlVKM+cc2osv8Wzq1OdoAIc0gwS/b7aByJyCTRrUEWILDvQchLX65IYYHuMNs4E8
         CDdgtxQC2e//gNJXvwuLkaf1Jc6tsm0AM6UNh8PI1AR7GVWNABSDRdQOvy4qpiV35OHK
         TF/pS1ub1obJ8GAdEHFN4DuUFdUjCgTQrZDuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Icxfnp9HKjOCxxd8LHDLtBzlH++tvRBMGK02TWhaPYI=;
        b=L30QoG2g7bee9oeSOxA6P4cGodK00y9C7KaZy0ncswDJoVGIe4i6K4f5zIuaDj30Q/
         G0+/NREypAH4JEEKK6c0V8zObcE+iwhrmD0/kgSCIkRQkuTNW5le6K6A1quxCxAuxhtt
         +9SyHm0bSqsfeeqUDRzD2eLRIGSHAdNMigepLedRa65d8svCSFS9+9nKaKY2yx90iIRQ
         Z37iHYdYx+mEvU92YE8KCHnQ5lD4PJEstLFllI09tfpPbXAEv0xfydhqkNWzLNKgL3xV
         BK0HkSD1ud3/moKxk3ADNw6zZs3aB+++XAwFZ9/6WLJnleDExDpCNTxdOqA4jzL1+V7v
         /phA==
X-Gm-Message-State: APjAAAVvLTuyXrR1LQKPwdS38q769AQlTjkrtHGN6aGH9qWFLA57BLIy
        w4nFmD1wylauF8j+6SQcWvX7fQ==
X-Google-Smtp-Source: APXvYqxBCz/RGzHXqMGg+UqQdt1FKzjwr4xjT+V51b+Hm23Ljn0PARusbNY2zOgAv7oXSEfUA81/Qw==
X-Received: by 2002:a17:902:8f8a:: with SMTP id z10mr27668871plo.169.1580785019903;
        Mon, 03 Feb 2020 18:56:59 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e1sm22491971pfl.98.2020.02.03.18.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:56:59 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCHv2 03/12] videobuf2: add V4L2_FLAG_MEMORY_NON_CONSISTENT flag
Date:   Tue,  4 Feb 2020 11:56:32 +0900
Message-Id: <20200204025641.218376-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204025641.218376-1-senozhatsky@chromium.org>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By setting or clearing V4L2_FLAG_MEMORY_NON_CONSISTENT flag
user-space should be able to set or clear queue's NON_CONSISTENT
->dma_attrs. Queue's ->dma_attrs are passed to the underlying
allocator in __vb2_buf_mem_alloc(), so thus user-space is able
to request vb2 buffer's memory to be either consistent (coherent)
or non-consistent.

Change-Id: Ib333081c482e23c9a89386078293e19c3fd59076
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/media/uapi/v4l/buffer.rst | 27 +++++++++++++++++++++++++
 include/uapi/linux/videodev2.h          |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/media/uapi/v4l/buffer.rst b/Documentation/media/uapi/v4l/buffer.rst
index 9149b57728e5..af007daf0591 100644
--- a/Documentation/media/uapi/v4l/buffer.rst
+++ b/Documentation/media/uapi/v4l/buffer.rst
@@ -705,6 +705,33 @@ Buffer Flags
 
 .. c:type:: v4l2_memory
 
+Memory Consistency Flags
+========================
+
+.. tabularcolumns:: |p{7.0cm}|p{2.2cm}|p{8.3cm}|
+
+.. cssclass:: longtable
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       3 1 4
+
+    * .. _`V4L2_FLAG_MEMORY_NON_CONSISTENT`:
+
+      - ``V4L2_FLAG_MEMORY_NON_CONSISTENT``
+      - 0x00000001
+      - vb2 buffer is allocated either in consistent (it will be automatically
+	coherent between CPU and bus) or non-consistent memory. The latter
+	can provide performance gains, for instance CPU cache sync/flush
+	operations can be avoided if the buffer is accesed by the corresponding
+	device only and CPU does not read/write to/from that buffer. However,
+	this requires extra care from the driver -- it must guarantee memory
+	consistency by issuing cache flush/sync when consistency is needed.
+	If this flag is set V4L2 will attempt to allocate vb2 buffer in
+	non-consistent memory. This flag is ignored if queue does not report
+        :ret:`V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS` capability.
+
 enum v4l2_memory
 ================
 
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5f9357dcb060..72efc1c544cd 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -189,6 +189,8 @@ enum v4l2_memory {
 	V4L2_MEMORY_DMABUF           = 4,
 };
 
+#define V4L2_FLAG_MEMORY_NON_CONSISTENT		(1 << 0)
+
 /* see also http://vektor.theorem.ca/graphics/ycbcr/ */
 enum v4l2_colorspace {
 	/*
-- 
2.25.0.341.g760bfbb309-goog

