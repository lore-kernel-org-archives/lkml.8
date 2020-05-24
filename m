Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EAAC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B721F207C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rMshiG8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbgEXTW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388153AbgEXTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB0AC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y198so7950275pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8utbws1RCqk2LlI7/gkB8i1cj/u48CIh6THWzODOXyg=;
        b=rMshiG8EIIFNL1uMBODlvvuf94bqJViNg5UM86151u5U7d6woOiNbIvEQgdvWkip2Z
         4g9+5vHQOuzDMROosjj+bj6Blg/CLhLK5vEV3DBUFxBJkdjuCBSJsZRKwURHWVWuMvkG
         8jOvtNQ6v64rSK/PJ1hg5+MO4hooCsE1eQwTAJTNiMD2VkHEx49zfrV59k1lyHvzxKNm
         tkmEJZl8YFSE/WZHCITDnBiis68jg0iqL//e/vmY2lJYseDiXfhsax3yzBXAV7qmApls
         ZMNQZ+Ki+d8QjYjq28AecXUf5Zy5QTI48QVIQDsbVIfZPAMh4PfdChp/zHXp9Qzbt71H
         d/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8utbws1RCqk2LlI7/gkB8i1cj/u48CIh6THWzODOXyg=;
        b=XWOHG2+q34VBER9o3/GIHRwKvEEw7/42ybX9oX+6w1ujWGaqzgekoPZrDZIJK2nYzy
         7BlHCyxf5X7S3ZPNQjUvH5VcCrD0afDJ3w6pOHz90Graww4899wex1fwUiWqNe63vpYD
         BLen7N7GfYhQGfVjAZ4l2eZph3z+CsXtlErJRDqJ0E+LdsRHz0/FjKtunaevjsiKIEWa
         i07dIVE9VIpdwesx1taE6xuPkLPBsXkC5goDr+Hnxo0eivvDAgMMTjBK6RtAux7I3clm
         TzSETSYeK6bHyq6UEXnDYPDlHm70JyXG+viwqlaiH1BKBfX4p0IL9ETrUqM8d4ZG/zNp
         lqBg==
X-Gm-Message-State: AOAM532Aq7C1hy3ccoMduIcVZPsNw95O/X2/Qlrd0m6mPYwe5JMyNmxp
        ftCfb1Ert0ulUWkbfCf2mUMB2g==
X-Google-Smtp-Source: ABdhPJyYufZlJWGWTLeLNJcHAXoCD/f3jIKpvGkaNmPBexGhsJfRzmJtp4GI8lKYiNDw6AyYjV81Lg==
X-Received: by 2002:a63:1312:: with SMTP id i18mr6502381pgl.142.1590348140858;
        Sun, 24 May 2020 12:22:20 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/12] fs: add FMODE_BUF_RASYNC
Date:   Sun, 24 May 2020 13:22:00 -0600
Message-Id: <20200524192206.4093-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If set, this indicates that the file system supports IOCB_WAITQ for
buffered reads.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5a5434ff7543..f7b1eb765c6e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File does not contribute to nr_files count */
 #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
 
+/* File supports async buffered reads */
+#define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
-- 
2.26.2

