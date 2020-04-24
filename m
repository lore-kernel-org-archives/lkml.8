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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B97C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD8520767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHtX2Wtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgDXJbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbgDXJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:31:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25B3C09B045;
        Fri, 24 Apr 2020 02:31:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w3so3543540plz.5;
        Fri, 24 Apr 2020 02:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THhKNtjH/uEj0jg+pesiBCJg+1ebmbvJUD6/foS9B1Q=;
        b=CHtX2WtnxNzO5uPFdApzvX/OoTxAoC69nGtsgdoImceGkYQD7NbFKuYA4qP9+1MJdl
         LjBRNEJf2z4kqzPrmTCQVhDbYC2wW4auT2BNUrZjUAxnH/ipmKYxTKCZD5OyDLjqG50i
         GuCH+nINsRgloq6SarEYFB7S3yXi2RJ0pgmNGSvLYIjhmaxoo6DsYlwdp/X7U7E87K0Q
         rdS2B7SeQGS6YqNUK8rIHLiUiz1Th3624BMOcZXmT/E46UYmRf9miVgoM7sAfHsZDFgk
         /DET/s363DrnEv7+QogISyK6+1f9Nlzx1tUHPiKvG6ZSSZgCE3nwYDFhaX99dojPolPP
         7ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THhKNtjH/uEj0jg+pesiBCJg+1ebmbvJUD6/foS9B1Q=;
        b=FI0BfwhpvLoCj54KONUYa4jPYD5WbAGBj5J9CXkr76RkRYRvzouQa6OLYVqxwxGobu
         mSiVZAWvyJ2rKLp5Eu0k/9hxWafyS11DUQyh5ySC00zhQPYuVISxZWv8PDdsIAxI8KpV
         VMcE2E+7IAwA+/tcjtQLkryRXN/KYsHTyxTC2dFl0SvUVq1XLnyyn+x1IajI6zp5qdHp
         ZsINjCB4BDtsEYg9Upd7HUjT9WzJsIIrBDen/74RRPib7Qb0Q5dPB/4seHJ0Qc4DLpF8
         cu3AE2enhPSWXJ1PSM29SW2iugG69bDqgjphgTwwVWKbqXQPVxygWPrzOgQeAXLFsz9G
         8+Xg==
X-Gm-Message-State: AGi0PubNIqaF+Vt/QfP5iFe/iS3KH3iAOzgQtRnLLDYJO7U6oIQMANHx
        /oGwtYy0UsLdMLHGQKAKyE8=
X-Google-Smtp-Source: APiQypKd9OHBDoHGBTRLyj3+BsnI6AnjtLIwL2qeULNLoU5v1bAXJV0jKf71cTgLrMkzA7LH7e3pTw==
X-Received: by 2002:a17:90a:ad02:: with SMTP id r2mr5294423pjq.63.1587720677333;
        Fri, 24 Apr 2020 02:31:17 -0700 (PDT)
Received: from localhost.localdomain (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id 185sm5541315pfv.9.2020.04.24.02.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 02:31:16 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 09/13] videobuf2: check ->synced flag in prepare() and finish()
Date:   Fri, 24 Apr 2020 18:29:16 +0900
Message-Id: <20200424092920.4801-10-sergey.senozhatsky@gmail.com>
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

This simplifies the code a tiny bit and let's us to avoid
unneeded ->prepare()/->finish() calls.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 5409e15b6af4..5a69005b7d59 100644
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
@@ -2000,8 +2006,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 				call_void_vb_qop(vb, buf_request_complete, vb);
 		}
 
-		if (vb->synced)
-			__vb2_buf_mem_finish(vb);
+		__vb2_buf_mem_finish(vb);
 
 		if (vb->prepared) {
 			call_void_vb_qop(vb, buf_finish, vb);
-- 
2.26.2

