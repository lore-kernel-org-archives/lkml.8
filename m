Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1884FC33CAC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE90521582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j3Fq0i83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgBDC5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:57:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46376 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgBDC5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:57:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id k29so8651425pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NyRU2xy1z/nYwBRLVUPtO+ZHRnpI9P9k60fSC2X+DE=;
        b=j3Fq0i83ztEE46oH9dTHoPUFBJ9tpWElVSi0sKJRUZcsRbsxCRK+bWgt1i6ZdvjhO8
         ZV7hTIydDJatMj68kNoBQQ/DWG5kqPpCeiEGZheluT9CfCXmnX4rmfk92P97gjhc1IzM
         EFAdrs3PsNDg1PIBW0b1qc0dRsThBCU7KFkmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NyRU2xy1z/nYwBRLVUPtO+ZHRnpI9P9k60fSC2X+DE=;
        b=W5e2Wa2ehmf+kBXahKAxLzSgGO42aWXd0aSt2PPVMfeAGcxk87InIAbHGx+RdJKkJa
         acAokHSXc2ynnWP9h4j2wmCK6SE9FCFLQ4hPS8L/dQUVINWFSezKj/PU8Jm1tT3kGrVl
         1WLEOtv+FwdywCDS9bcZbsF8PnSbvpy0hreu+/YqBkUxA1uTaMegvDI+QX0J08M9rwDe
         TKXYsiouJFvm7B49nRSAdFsqpltVp9iWzLmadfwbxNf7Xh70FCotCr/kNui+zTj2Yw+8
         nCWZ5L2QtVT+sTyqf4eRnCiR+RZ7dHmlppUCIem9kUUo+Wh6Wq6wwZLGKn8eV7Dz2pkr
         64VQ==
X-Gm-Message-State: APjAAAVC32yxvltwPWtlzpGrPKaxaDmAnpiMhc12l3UNYZMT7rvLqZuf
        /HSQZtl/6o8WBwagqCSKo0y1XA==
X-Google-Smtp-Source: APXvYqwFBek9VnVsgN4EGGqi1nNxFt8Z4wI/xHpJb1NQ4wxHusH5uLLX8YW9xr/VCW1sE1Muy5gUqg==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr25299793pgk.99.1580785034064;
        Mon, 03 Feb 2020 18:57:14 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e1sm22491971pfl.98.2020.02.03.18.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 18:57:13 -0800 (PST)
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
Subject: [RFC][PATCHv2 07/12] videobuf2: do not sync caches when we are allowed not to
Date:   Tue,  4 Feb 2020 11:56:36 +0900
Message-Id: <20200204025641.218376-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204025641.218376-1-senozhatsky@chromium.org>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip ->prepare() or/and ->finish() cache synchronisation if
user-space requested us to do so (or when queue dma direction
permits us to skip cache syncs).

Change-Id: I37c89d666542ed8d536eac329953d921bb1c94b6
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 46be9c790ff6..c3637ca0c65b 100644
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
2.25.0.341.g760bfbb309-goog

