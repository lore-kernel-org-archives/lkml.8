Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EAAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE5724699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQoz4D3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgCBENE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:13:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40538 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCBEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:13:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id t24so4743399pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 20:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3A85FNkQVK15E41Jw/YnZSYCbOfj7OMPE9KsvpyVprI=;
        b=iQoz4D3GwiW8h0XeU8c1Et605eWVY/JK+54169MH68UJ0X99a18+0g9Tm8xc/DDmAp
         mj8ZAhEVfO7rt3RTDu/RzFnPjOY4zldofCKucp1E6RT9nL4gfhu0c5e3+dEF17zFAFSg
         Td/fdZ3uqYCSPBmyLKwkHZa3JvzRlak5lPFXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3A85FNkQVK15E41Jw/YnZSYCbOfj7OMPE9KsvpyVprI=;
        b=WS3KV1jluwztU6FavMQm82EpdXx360IfYX7IRgi7+ZNUEO7MKHJHJEj1satm+zfx5X
         s6LwBjSTyR1QHdRYgyIxKCbAwZ8XDdvPoag6tin2CRdxbJF0Waz8UZJR7FUsmRz1JI1C
         HzCC+o7RfnT1LETqMhsaT0gTEX0rEm27UH8Iqf8jSFif5srPGwsbwNmGG0TCSrh6eUei
         reHpyhz9X0kVSH9mg5DObfW8RUaIt3Pebviq5ZoiezORgzeGqO3wsoGIGWWLLx3OK3/v
         7XLF13xKRQBLgDhZ0VoSlkkVytkkbSviQNnSU8FW2KyMQXpy2efDnOvu1cd1DSKpQdlp
         QExw==
X-Gm-Message-State: APjAAAWIpnAb/C1qSXz2fD/9uza1Y5ZzBpiJ1YSDvFb0/K0pekFYgQoa
        y5EXDjavZ2u/myaXEyK9/pR/tg==
X-Google-Smtp-Source: APXvYqzfiVrxV9y838Pte2LCUED/pNzCk7VJWEWdqJQlV3pzdVO6cxXqP0Ax/IK/3vv50IjpTeBGBw==
X-Received: by 2002:aa7:8299:: with SMTP id s25mr15628477pfm.261.1583122381683;
        Sun, 01 Mar 2020 20:13:01 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id d82sm1698114pfd.187.2020.03.01.20.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 20:13:01 -0800 (PST)
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
Subject: [PATCHv4 07/11] videobuf2: do not sync caches when we are allowed not to
Date:   Mon,  2 Mar 2020 13:12:09 +0900
Message-Id: <20200302041213.27662-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200302041213.27662-1-senozhatsky@chromium.org>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip ->prepare() or/and ->finish() cache synchronisation if
user-space requested us to do so (or when queue dma direction
permits us to skip cache syncs).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index c2a1eadb26cf..988e8796de4f 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -304,8 +304,11 @@ static void __vb2_buf_mem_prepare(struct vb2_buffer *vb)
 {
 	unsigned int plane;
 
-	for (plane = 0; plane < vb->num_planes; ++plane)
-		call_void_memop(vb, prepare, vb->planes[plane].mem_priv);
+	if (vb->need_cache_sync_on_prepare) {
+		for (plane = 0; plane < vb->num_planes; ++plane)
+			call_void_memop(vb, prepare,
+					vb->planes[plane].mem_priv);
+	}
 	vb->synced = 1;
 }
 
@@ -317,8 +320,11 @@ static void __vb2_buf_mem_finish(struct vb2_buffer *vb)
 {
 	unsigned int plane;
 
-	for (plane = 0; plane < vb->num_planes; ++plane)
-		call_void_memop(vb, finish, vb->planes[plane].mem_priv);
+	if (vb->need_cache_sync_on_finish) {
+		for (plane = 0; plane < vb->num_planes; ++plane)
+			call_void_memop(vb, finish,
+					vb->planes[plane].mem_priv);
+	}
 	vb->synced = 0;
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog

