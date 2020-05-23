Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C3C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE51420870
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aKd+2/L3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbgEWS6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgEWS6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E08C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k7so6441424pjs.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=aKd+2/L3zhcWktix7GTJLEddQj7iHGpD8+Gbc5lZhZOPOtmfTJSybdWwo7P0uIA+5v
         nw2OIz8yCOB1kQ+IBoWa2qYrd11KuhOSiTCgjz8Jjm4+Tbl8Cf41Vg52NSUaa9pR0Tks
         pkC3Lt4M+d5mqE795NFN0OzGrct0KwdthHdOM6Z+6CVlf/5eQQtIf3ehLbgkfuqZc8TW
         LGTqI4HsD0RR6mx2SM2tRYFi+hbvTahsWpdHb5Bev/u13hAyTFgVlHtEXxkQ5BzcNmAl
         BuEeOlr0w8tDobCzI8GcOwgNnklK24cTNiXcD+JIsmWtWOcPcpqxO21EEftbMqyXTPz1
         WWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=Jz0p5BV7EMNu0XNklUVO2PYQZWKMbjjEOd1ZR3k0pyCDjydQbP1x/MkxADUcQM8TPu
         +6aM8e9zG5WcfdmoPjlW1ml6TLdzseG48d7IRzBYKW5sOhQ99MxXHOr/L+kd/v7ISV4Z
         AcAVZc7FGt0/B5DkVEqFidXbP6Sj9tXrb6/Zu4QHJiMhv3Kqr8P5GV6XIb9asOHztTk9
         4G7CF4gws4brw5wYpBhRpl2+QhMfC1L4U2bSbhXkkEyFskQ34uiW9GOO1pgUPZWObTiC
         fjNeB+xwsLBaLi6WRi9uh+tgc4w0zZ3laCJHBpItAL/e2yILQBNpgodXfzdceXLpqiCa
         V8Jw==
X-Gm-Message-State: AOAM532TjDGkf3fCzrcBY+clQvMgRZLSD9ZzdTiIev3MrrdMuMsZkNYV
        I0F1NHeVVTPnzX0//pJ8OlDw/A==
X-Google-Smtp-Source: ABdhPJzz+UanoYeeFHEpf7tdaIQvpR4HprzsHsuIgK/sPHYRYz8bhbR5K4GsEWQ0YkbTx9slFOzW/g==
X-Received: by 2002:a17:90a:930c:: with SMTP id p12mr12921445pjo.64.1590260290884;
        Sat, 23 May 2020 11:58:10 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/12] xfs: flag files as supporting buffered async reads
Date:   Sat, 23 May 2020 12:57:52 -0600
Message-Id: <20200523185755.8494-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
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

