Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB97C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C658246B9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SVTwb9xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgCBENK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:13:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42345 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCBENJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:13:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id 15so4888650pfo.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 20:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1tFCzw75kCxqGljRqUUqQ24ppDX2CtviVmHlh9ZwXI=;
        b=SVTwb9xCDylxA8meFAf4DNHy1L02yYnt+Xnqp7zusYHBzO777tMWuyug3GcSsAPwDz
         Afs+J9ArrufHaKwPHWwVG6Orv3Pcf8BzOc7FTjbdW7LOw4N79tS+Up+hBW+/3WzsjDn3
         D4Cg4w9UK83GxIvJmjR3tAKaoyO8fbMFtX5D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1tFCzw75kCxqGljRqUUqQ24ppDX2CtviVmHlh9ZwXI=;
        b=CoZkcmrOxOFBTOeuYqBKLNlp6pLe1CWnxKddtPk7QZBO6EE3/cix1aeZHTxQjQysps
         fP9t1LOMeS0ZwD7U86VnhMD1Lel7dtlOIig/AMY0AMfx4a+Uo9hp3COFBWvKlQQoMyFU
         KtLteuei+Ici9uWZa+dyXR3/WEGR8NOXSqjeFJo8GYatMwOpIBnv8BU8HNNrJlJdK3zU
         kzobAGghPpg8SF05tCmwwAXIqz9wKd/+wQT5ZyqknfUcRR73uNV0VPqOch5hA2/a1om7
         U8wzKptwg6tBsLF+7KZIusytoqO/x+D/+83ElxcCj60udsK4k1y30Njz1aBk+8B1kQzs
         jd9w==
X-Gm-Message-State: APjAAAVnXAd+uVMcn6LxvmBDFUK8chBk3tS+fnnRv/fHMdDa/y1b6jcj
        oISnCYNqQKuiAYBby/BtlmsdiwqoV3o=
X-Google-Smtp-Source: APXvYqybi5EYjqyckazY+Gfhnp9nuxz2JxRXBkIO1IkSF+K1quDA1KeL8eaBFfOWeBHOItlSEUgZgA==
X-Received: by 2002:a62:768d:: with SMTP id r135mr15601049pfc.108.1583122388345;
        Sun, 01 Mar 2020 20:13:08 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id d82sm1698114pfd.187.2020.03.01.20.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 20:13:07 -0800 (PST)
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
Subject: [PATCHv4 08/11] videobuf2: check ->synced flag in prepare() and finish()
Date:   Mon,  2 Mar 2020 13:12:10 +0900
Message-Id: <20200302041213.27662-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200302041213.27662-1-senozhatsky@chromium.org>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
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

