Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713C9C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466C124685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SUEP5H4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgBZLQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:16:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34330 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgBZLQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:16:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so1180583plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1tFCzw75kCxqGljRqUUqQ24ppDX2CtviVmHlh9ZwXI=;
        b=SUEP5H4If0hedHG+d1NujE25rC/qeuZmRHTrnVGnP0EIN3aaxg3mNjZGx2NZLg0L6w
         BOjyNWvn6w5PLu3+1thwu2S39c0ZMJOEpiV0jIh63SUKGnK9wzObCjQpy3nyaVXE/y7/
         lSqKT+KAtiRGykb+8CKaOgFHqGlbBk78g480U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1tFCzw75kCxqGljRqUUqQ24ppDX2CtviVmHlh9ZwXI=;
        b=dBAbv8ISgS3rMMimFARV+UqCBetmMvYZcMeNwO6GpurbHrKaCU9xsIYe+EBxJSrrtF
         ZNFhB04o1sqYpvrZjPUlXh0t8CgRyZYq7x1WbOnTw0kvkEMOmlFE8/b8BuXLHp1cSg0g
         +XEyt3ovawfRcJWMOzA76UEc+gvc0UwmU7nV31vDIcAhnYqVE9FEMoq3NzQDa5xjqFed
         11XPQYr37DainIsEZfD70sr1vOH0QhU5JlgRc4RhLwETu8E5bZnDmS7jT5LWc7y5wgar
         VUijo5J5tVQfdpcWQSok9RAWul66CEycTBOMvtF+07GNPU5NSvmJVkCH/XTyeDbPxGQk
         Dg4w==
X-Gm-Message-State: APjAAAVEnKhd9j5+Jg+aYRZ6PjKPHqs5RCXgUYPzMfioP7o5uw7ilGPN
        achNQSTDlQiwxotV2S6yT389uw==
X-Google-Smtp-Source: APXvYqzyt+rpfyMZ4RL10CxYR7SLP1N/LsYvlz4aIcvuEf9JypIqMqdBTCcFIPRxhcL3Oo1KRvY9oQ==
X-Received: by 2002:a17:90b:94c:: with SMTP id dw12mr4482184pjb.13.1582715775331;
        Wed, 26 Feb 2020 03:16:15 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id o22sm2429993pgj.58.2020.02.26.03.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:16:14 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 08/11] videobuf2: check ->synced flag in prepare() and finish()
Date:   Wed, 26 Feb 2020 20:15:26 +0900
Message-Id: <20200226111529.180197-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200226111529.180197-1-senozhatsky@chromium.org>
References: <20200226111529.180197-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the code a tiny bit and let's us to avoid
unneeded ->prepare()/->finish() calls.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 988e8796de4f..7f637e3a50ab 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -304,6 +304,9 @@ static void __vb2_buf_mem_prepare(struct vb2_buffer *vb)
 {
 	unsigned int plane;
 
+	if (vb->synced)
+		return;
+
 	if (vb->need_cache_sync_on_prepare) {
 		for (plane = 0; plane < vb->num_planes; ++plane)
 			call_void_memop(vb, prepare,
@@ -320,6 +323,9 @@ static void __vb2_buf_mem_finish(struct vb2_buffer *vb)
 {
 	unsigned int plane;
 
+	if (!vb->synced)
+		return;
+
 	if (vb->need_cache_sync_on_finish) {
 		for (plane = 0; plane < vb->num_planes; ++plane)
 			call_void_memop(vb, finish,
@@ -1991,8 +1997,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 				call_void_vb_qop(vb, buf_request_complete, vb);
 		}
 
-		if (vb->synced)
-			__vb2_buf_mem_finish(vb);
+		__vb2_buf_mem_finish(vb);
 
 		if (vb->prepared) {
 			call_void_vb_qop(vb, buf_finish, vb);
-- 
2.25.0.265.gbab2e86ba0-goog

