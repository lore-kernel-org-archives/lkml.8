Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24085C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9012468D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n6EsLSjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgBZLQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:16:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38274 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgBZLQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:16:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id d6so1155198pgn.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3A85FNkQVK15E41Jw/YnZSYCbOfj7OMPE9KsvpyVprI=;
        b=n6EsLSjVofOAsY+qTD5ur3tvt3prP4xIE81hW3UMhCK6Hk6vLYUPfTjkViyHlLSx0e
         PKq9SBkZBIKgkKw3b6iA0jU98G93dGz/e0kV3RB+SOZ9jHG0bHjc/CED2Z1L7O8Inq/Z
         a6GKZuegrK/74Y/D7g2+3chSko2GVSugqRbc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3A85FNkQVK15E41Jw/YnZSYCbOfj7OMPE9KsvpyVprI=;
        b=Y84a+Rs5QWvq1GPrwNW/gTtNC8UrxNiVIF2dzJZWzgszIHz1Hs/SGuULLLOGHLfRry
         0iQphwUEyIKVd7RmI9EhQCgK9vTaMJI/wAdVzCbx56anYkBE0GkrYryMEhUe6Cj7sjJX
         FZUA0T9u48hpKxRzBAcK5ygInlJ/yWZQOuXlMYB2NIs6rUJRReAHGDb6GKApjgIn3ECU
         r5RIkwPIjEei88iRg9uEsNEEHsRLSzfOBHHOk1dp4RhfzbOx0cfL0xRaNG0HLfAIczxY
         lZM2PeRrzn0mWLP5QSDBmGC7yQu9QSmoRJ2T9Q2bUgiJ2K/yqPY2oWB3CZJsTO7ANCUg
         hMNg==
X-Gm-Message-State: APjAAAXHYaB0pSTWYmHOWgowWME7d+JhzTgNBJAfg1jRD2U8o5Y6jHu3
        cUvMnUGLi4pphh2m2u5Oy1XJ+g==
X-Google-Smtp-Source: APXvYqx53QRjLLJVxV+EPa6syDS3795FvGUqOREY3XhchQlBTgMZD1MOJX/1R5o9fROynap/WI3GVA==
X-Received: by 2002:aa7:85d8:: with SMTP id z24mr4029724pfn.202.1582715771062;
        Wed, 26 Feb 2020 03:16:11 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id o22sm2429993pgj.58.2020.02.26.03.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:16:10 -0800 (PST)
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
Subject: [PATCHv3 07/11] videobuf2: do not sync caches when we are allowed not to
Date:   Wed, 26 Feb 2020 20:15:25 +0900
Message-Id: <20200226111529.180197-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200226111529.180197-1-senozhatsky@chromium.org>
References: <20200226111529.180197-1-senozhatsky@chromium.org>
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

