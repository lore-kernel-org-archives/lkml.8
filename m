Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC240C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A082E20735
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SDURcEf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbgEWS6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgEWS6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955BDC08C5C1
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so6573749pgb.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=SDURcEf2V5NO/4iU1aE24OeWSLHMCXpJdAgFrdnJEd7bIgxaZY8OsCWvWhzpOJOtb7
         RA+oFu3X71L4OYZdo4lWYTXGqp8MWSeWkbW1ZPXTUNI/+Qc/A6l9IJVklr6G4fHvvyM2
         eSkYQ36gSdm3LbIvrCiTfPKjmIT0uHzq657/N5EqmkFU1X3ShnSc8TgsHYOsTlmDtjbs
         fhQgttgwQveWyVOwYI4QoW4GE276osyEbPco1QcSxndNWxRvqeb591UYbiXTc10MOx29
         fpGpdY3/b413xwsNy5DGpoifG0/dhZFZd2GrucUQb1vlwz2jFn1Z/Q8UTQqIGSSktfdg
         vdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=iNW/xVXRkYRD2m+BZpdlppNFbp9TdEOiaX19s0uOFKEHO0tf9e+MYNmBqc9XOo9L7h
         Z6AKD24lijAV75QpKSbfPv9+9t2T1zCqkX0lZR+Y52cJfVkSxOLKk1Tds1qQTIibmxXJ
         BiXqkr/dwfodecaN1OCGDm8K3J5a4qREVgkrG5Ys/0NoQ394cVUcjE23HUpcJBiQviZ5
         IXHAJ77wuIDGc7tQTbMpVx56D4pqei2hv0QDK/pQHifGM7FC5N4xEZx5pDcNChUm1itG
         65UHQC7acTifsr0tV7asWAD5glSU71sdkdLv8cXjPesg82DtmTuZt5AxXBkqb5GJVoqS
         wTng==
X-Gm-Message-State: AOAM531BNf8PKsYPm0LlCXhC+MwcqQZcWEEOXYlBxJEmJ40rsRSaB15E
        8JTtBXBhQOj2PYm8LwGidiQMRPVR55BveA==
X-Google-Smtp-Source: ABdhPJyltVIJNk8C4W/9AMto9tWC1IL7mnDA5eVGXtM6JkHvLgYtWln7h/t01grs2y91cUsPUSnHHA==
X-Received: by 2002:a63:a36e:: with SMTP id v46mr19101914pgn.378.1590260292180;
        Sat, 23 May 2020 11:58:12 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/12] btrfs: flag files as supporting buffered async reads
Date:   Sat, 23 May 2020 12:57:53 -0600
Message-Id: <20200523185755.8494-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btrfs uses generic_file_read_iter(), which already supports this.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 719e68ab552c..c933b6a1b4a8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3480,7 +3480,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return generic_file_open(inode, filp);
 }
 
-- 
2.26.2

