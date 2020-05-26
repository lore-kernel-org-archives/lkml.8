Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E31C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8993E2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yFrvO5Xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390408AbgEZTv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389346AbgEZTvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:51:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB2FC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:51:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so10551343pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=yFrvO5Xl3qNEXOkExAlKW5HCKxIsDSMlTDL6yu/qdDNmAN9gaTkhr8Ji+yI9XJMB6r
         Yyj0QZ3VaFi/iX801MVu58AB5V7toUQ/3YSKHrzjYv7i2pgw3diwzJ9VU9sKkiQ+CqO5
         +3TnFQnSzV+5hEs5v5Y4SsfGIfcKj9q7W3SSj/g2m24bxPjK6B7OSCJCgOwvDr/T+fH0
         FXKEQYV/edda3rOI2u6He8F3YutgqUpDtRr1cjsP0bBekPjb/tjeT+Zdyk9nrP1RvMHF
         IL3sBKXh1sO3XzmReF4iBAlL3BzPeFNzf+QnoSzUJnqeO7X206hePi35FPbwAjeQ87ro
         IySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=dss8ekl07z4UO94771MxSI22qPaoumKZyZZsFbO5n4GBrODCxB6ZnrwFr9tYJ7iJnD
         QsX2oWwsBXJ6Fn6FrdsHrgSiXlOA2y0cVwFSI+n9DLltbccXSESxI+a2OD4WKAWJzYN+
         KvWQBlFLkOfdTkeQLQOOeFSL2KnV1kzHGRV6cYH1RxWgV7Nmq8UQhEJeLU9tBG9b2PQN
         nmDkS5k28LoLfsXc6QMpFgPyEOQSpWnacdran5JrnKw73J9CRCmSsW3zBzz01jeVC4qq
         2KsTfkXXlxaIj2mhDMHd+b0DjufsqWW1mdw2/28s1+BMDlozxzBJAw0ppVOwADB2HphR
         /efQ==
X-Gm-Message-State: AOAM53385JCtJntdACJ2z3sz22A+HNIeNSngUp7qi9VdRmDuyGXhwt8H
        Iwvh60PTDhF0u8l7DHZ0YIriMw==
X-Google-Smtp-Source: ABdhPJywnc6qZ+WtihMTbkb+pFwn9JjcTK1HqNCVBDIVrphWDInm6gN1LVPRjjrnGs3CvW4hueDaXA==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr417227pfu.75.1590522699174;
        Tue, 26 May 2020 12:51:39 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:94bb:59d2:caf6:70e1])
        by smtp.gmail.com with ESMTPSA id c184sm313943pfc.57.2020.05.26.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:51:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/12] xfs: flag files as supporting buffered async reads
Date:   Tue, 26 May 2020 13:51:20 -0600
Message-Id: <20200526195123.29053-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526195123.29053-1-axboe@kernel.dk>
References: <20200526195123.29053-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XFS uses generic_file_read_iter(), which already supports this.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4b8bdecc3863..97f44fbf17f2 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1080,7 +1080,7 @@ xfs_file_open(
 		return -EFBIG;
 	if (XFS_FORCED_SHUTDOWN(XFS_M(inode->i_sb)))
 		return -EIO;
-	file->f_mode |= FMODE_NOWAIT;
+	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return 0;
 }
 
-- 
2.26.2

