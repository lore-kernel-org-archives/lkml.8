Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40EDC33CAC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D0520732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="muHmPuyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBDC4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:56:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40704 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgBDC4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:56:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so8661959pfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lhU4J28AzAlrdMUPALtytVfuN5Yhod7wdbGSvYMz3F8=;
        b=muHmPuyoCTTbGsxdFeW4XnvKzj5kxEDC1dK1cy56ahD5bPl9L5v9UYWOTrPmxKWB3I
         1Lk/FXpJ/3WXExHGrbVLXmCif8cxKj3WShbNj332c01j6jMtfin4+WtIl+M5B/2XRBbP
         iBVPpf9rHg3n6feFJx6toqhUAsSuLJjVJEh5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhU4J28AzAlrdMUPALtytVfuN5Yhod7wdbGSvYMz3F8=;
        b=M5Xd21OmCREex2rq/3IUREL5KIui7Ym3A8Myuyc2zKCfgjHW4GzK89xixgmX7qo8Cl
         Ud96SCFS4vWnQpvenSquRMvwcV97cyB+Y1tny1FLungIgTC5zZZ+8U3EXnwvVnKqK+Uh
         TOOfIhd/l3Ai+CatRxvrNZkCqBbvAmtTxxup4BB19rIc92BmK+UOVuvZ/srtWDTjQMfu
         ewKphV8iQYp5rNwTAp3uyXOoA1dd7WKoAuH60pCuTJnXfR04Pb7P7t2lbyfxexIJOlO8
         7gIx/vKLCOBMEuerw5ERSk/VJmlS0OHVDk0RFSaOoNVmhTm58YV+xu1+DvQ1CO00yekP
         Cy8Q==
X-Gm-Message-State: APjAAAXnCukasVlvNWDmyZsGdtXZvUumSka97+FrI9G4TPeUUIBG6fXP
        sdqmsPDEN7dAttbg4JiNh7PjHg==
X-Google-Smtp-Source: APXvYqz4oR3U12LaNHp02A8K3pwme+uNUkv5IJt9AOpO4nZhEp79Ndgx7m4e6B5jGvq+Oz1zanI3/A==
X-Received: by 2002:a63:610a:: with SMTP id v10mr16629313pgb.211.1580785012160;
        Mon, 03 Feb 2020 18:56:52 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e1sm22491971pfl.98.2020.02.03.18.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:56:51 -0800 (PST)
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
Subject: [RFC][PATCHv2 01/12] videobuf2: add cache management members
Date:   Tue,  4 Feb 2020 11:56:30 +0900
Message-Id: <20200204025641.218376-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204025641.218376-1-senozhatsky@chromium.org>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend vb2_buffer and vb2_queue structs with cache management
members.

V4L2 UAPI already contains two buffer flags which user-space,
supposedly, can use to control buffer cache sync:

- V4L2_BUF_FLAG_NO_CACHE_INVALIDATE
- V4L2_BUF_FLAG_NO_CACHE_CLEAN

None of these, however, do anything at the moment. This patch
set is intended to change it.

Since user-space cache management hints are supposed to be
implemented on a per-buffer basis we need to extend vb2_buffer
struct with two new memebers ->need_cache_sync_on_prepare and
->need_cache_sync_on_finish, which will store corresponding
user-space hints.

In order to preserve the existing behaviour, user-space cache
managements flags will be handled only by those drivers that
permit user-space cache hints. That's the purpose of vb2_queue
->allow_cache_hints member. Driver must set ->allow_cache_hints
during queue initialisation to enable cache management hints
mechanism.

Only drivers that set ->allow_cache_hints during queue initialisation
will handle user-space cache management hints. Otherwise hints
will be ignored.

Change-Id: I52beec2a0d021b7a3715b4f6ae4bfd9dc5e94f0d
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/media/videobuf2-core.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index a2b2208b02da..026004180440 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -263,6 +263,10 @@ struct vb2_buffer {
 	 *			after the 'buf_finish' op is called.
 	 * copied_timestamp:	the timestamp of this capture buffer was copied
 	 *			from an output buffer.
+	 * need_cache_sync_on_prepare: do not sync/invalidate cache from
+	 * 			buffer's ->prepare() callback.
+	 * need_cache_sync_on_finish: do not sync/invalidate cache from buffer's
+	 * 			->finish() callback.
 	 * queued_entry:	entry on the queued buffers list, which holds
 	 *			all buffers queued from userspace
 	 * done_entry:		entry on the list that stores all buffers ready
@@ -273,6 +277,8 @@ struct vb2_buffer {
 	unsigned int		synced:1;
 	unsigned int		prepared:1;
 	unsigned int		copied_timestamp:1;
+	unsigned int		need_cache_sync_on_prepare:1;
+	unsigned int		need_cache_sync_on_finish:1;
 
 	struct vb2_plane	planes[VB2_MAX_PLANES];
 	struct list_head	queued_entry;
@@ -491,6 +497,9 @@ struct vb2_buf_ops {
  * @uses_requests: requests are used for this queue. Set to 1 the first time
  *		a request is queued. Set to 0 when the queue is canceled.
  *		If this is 1, then you cannot queue buffers directly.
+ * @allow_cache_hints: when set user-space can pass cache management hints in
+ * 		order to skip cache flush/invalidation on ->prepare() or/and
+ * 		->finish().
  * @lock:	pointer to a mutex that protects the &struct vb2_queue. The
  *		driver can set this to a mutex to let the v4l2 core serialize
  *		the queuing ioctls. If the driver wants to handle locking
@@ -564,6 +573,7 @@ struct vb2_queue {
 	unsigned			requires_requests:1;
 	unsigned			uses_qbuf:1;
 	unsigned			uses_requests:1;
+	unsigned			allow_cache_hints:1;
 
 	struct mutex			*lock;
 	void				*owner;
-- 
2.25.0.341.g760bfbb309-goog

