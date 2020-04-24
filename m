Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFD0C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1DEA20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkScItcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgDXJbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbgDXJbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:31:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8E6C09B045;
        Fri, 24 Apr 2020 02:31:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h12so2549029pjz.1;
        Fri, 24 Apr 2020 02:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTwvpWckzKCbbPdLWK9YgE3TO5c8WM7mL5Hmnl5TrQk=;
        b=tkScItcpVTDbU9EfQBJaZSOGlVq5800YrbhrwJcICRbKL2zFihATbNG4v85Y4muI9D
         9vbxdAJdYN14wckkmncrIu1U+OHAmOhqiRvoqIf40z6tTm5ZNF061DpE9+XhB6Q5LYX3
         fcuMoaPinAb5nyMsSp01F2MQvHLHoLNCVlsZTCZmny6teErJujOgQwmrqUa71bG61L6f
         eiTWlqp2AgP8tmXUQqTWsK+A5ZylpBtGhBfhpCGEF3s3d32xL4WoD+qtXjyI1D5nMb7Q
         7NKWc63nV4QSneOqNQik6Tvl63TAD3hLmSmGI5TnI0wpwL4POjWNsq3TH8CtspmqqHsQ
         0g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTwvpWckzKCbbPdLWK9YgE3TO5c8WM7mL5Hmnl5TrQk=;
        b=PDE3j/KNsbLlt9AnVmHPejLQTZ1yFaymkrYiOneiG2bMGZzbIJ7lH4yxIkn9/yQKIo
         wSKwAMCvg3H+y6bGZ6L+q3VQIEbV5YPZiMozM2wvQsftbfMibYrR224zOPiBTOKzFF7c
         tIiIIoVBWjxHZmbhyedQ6fa7/XEh2A3yCMU9C1ZwVH+bcSUPjzWnVMHKmFJ8zsqJmcKX
         bleJlR7hcf3eeXKanAms8XTYYQyM0Vry2wzkAJ58ap2ttWJrLSm48D8yDWXzmJ4r14Id
         YLGsVOkVVR8LY6NWyYuXSy3IXpYlBP8JhbijZEZaNKIcZu1QS36Eo5dywD4MGJxDYO2R
         zTRg==
X-Gm-Message-State: AGi0PuYjZ1XhuwbhjOFR+wXM876P+qyXHXla/wh6mhwlUQudAunfNqlp
        pDHDIQFyHpiXyW+mfOpHnlM=
X-Google-Smtp-Source: APiQypIuQd/lmMRL07Xtm534jd3jbgvw2i/UAlIYjki7EoKijQVGMzRrg44qkKaUY8Hwdn6afBfg0g==
X-Received: by 2002:a17:90a:930c:: with SMTP id p12mr5257632pjo.64.1587720672604;
        Fri, 24 Apr 2020 02:31:12 -0700 (PDT)
Received: from localhost.localdomain (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id 185sm5541315pfv.9.2020.04.24.02.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 02:31:12 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 08/13] videobuf2: do not sync caches when we are allowed not to
Date:   Fri, 24 Apr 2020 18:29:15 +0900
Message-Id: <20200424092920.4801-9-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424092920.4801-1-sergey.senozhatsky@gmail.com>
References: <20200424092920.4801-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Senozhatsky <senozhatsky@chromium.org>

Skip ->prepare() or/and ->finish() cache synchronisation if
user-space requested us to do so (or when queue dma direction
permits us to skip cache syncs).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 0be31a11c913..5409e15b6af4 100644
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
2.26.2

