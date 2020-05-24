Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8172C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C5220787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AYei7bDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbgEXTWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388216AbgEXTWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14008C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a5so7666023pjh.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=AYei7bDKo4OkFtepp3xg4zfIw0hnd0Ebv9o/8vOyKbFHZ8InT64M5SLPyKbX5X3sUK
         Fkh7pM1hAJFMjnux/MH3PsrYNU/IaoreI0I/UUZHTe9NxJWQKmxRBMtdWR0udtiIbeCb
         FbxxIyYfHNT7MeXwmxuPM/7LHoWK8VkstsOX8wEOu3N5XhIfsuTIrmRWTVi0+n8wkRb7
         DNDwTBRW8SzP5mVNKj3+C6xyivFrnnJeUTG5ro7J3AmMh1Q5eZRP+8NIJUqmNnigS3cu
         DHQtC5SBLkYMeJN9r23BQVb8ndCYHRhxM7a0nMmr6b8oFKNZjU2N+KNcXWF6qvyESK5u
         YF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=uChFXw82is+7QkNcQCm/YXB64uQFi5DUXmrq5zXcOzwrEgGN0A1zRkr2HVUHFFb5LD
         Zj77aX8XqA1mIUvfUBAGCSYF0j7YzNQ4OnF2VlDeSFdmM1+Zvwu+q8xkqW5yrdX2M1mf
         TLegvyvqx0eHZ27X2+l1aTF7wC0nAVpq7WyEuthbobSRgcYhkjxuLWdVWHB63+hZsMLE
         L512cOJu/LMU6fmZ1Lsl/X/Y5NUVWeht2muk9y/0jwsD4+gnsA+guZDkVqr58Nm1ERhu
         me1D0hZLq2M15HCuBtw8jWIyE//S1TDo0rPT16nj5s1CoXTSg4BPQFSKDOH63VS7uw0l
         BQoA==
X-Gm-Message-State: AOAM530MCEL+U8Qk4YgQBpIRBig1YrhABZkrrklZT2ueWI/OFSSdEoEf
        2crBqfau3rRWHs7tNTaFo3v2rA==
X-Google-Smtp-Source: ABdhPJz6bGpR32ObwKt+551KDTdoAZNVR9ZlVB3PlXK2+knHsCmS9S73FZQgm9i0pCo/tlaxVlOxZQ==
X-Received: by 2002:a17:90a:2e8a:: with SMTP id r10mr6482101pjd.33.1590348144618;
        Sun, 24 May 2020 12:22:24 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/12] xfs: flag files as supporting buffered async reads
Date:   Sun, 24 May 2020 13:22:03 -0600
Message-Id: <20200524192206.4093-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
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

