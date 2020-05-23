Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CFAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAEA20735
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dlRhMk44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgEWS6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgEWS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFB1C05BD43
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b12so5743908plz.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvoN8a3WZmoogVlnFEo2G3/jPQNtfJ5pQXb6VgaLeNI=;
        b=dlRhMk444r2/QEHuAZ++S1wyLJ84KnLxTEI64EuE4dN1pFxVgN8A9K0quOu7H4b4Kq
         sjwJUAUsTLCVCGcV3VQIysTW9HiVCJ7sH5euxBGtqJm15I6wEKH3mue/IQD6jbfOMSi7
         Ee6mlXKJeIhli6gCf6YjVyTShL+/w3Hnk2eTqSuVF+zoDvF1MfrGYqyMRFeDjw07L0cs
         Mpg8k135t1sCC7y9Xv6B4U4O7cl9wdgoiTFK8GtgUeb7Kc22w5q0VzvT/2c8RzsYEwH1
         Cn02kuIXs3ldFHF8OFsS7U3UbM4AjfKkDhyZ7OjtrO7ogq6UpJoIBqUQAGUK22qWlIRj
         o4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvoN8a3WZmoogVlnFEo2G3/jPQNtfJ5pQXb6VgaLeNI=;
        b=Z+V+vK07nXlLAZHSdpKduVyJ1BcnP6JrhhxIgs7KBYmfOK+9Qd+K6q5OpxjUjPoqvP
         upoUYTHntLIEI7lKZ9L+BnZZJXlLLBl92cwc4gxXad8owYICIuwU7oVyoEldGeSXBMUv
         Afj4AnVjGw5/E/9A4aFNwPUr6HT06lHcvFpoJKK9jws1YLDowKgcmNIrPR80mF+FyJHB
         wukr8DS4/fsHVqvpF87VYV3y9UWHa8XVKHRRf1GsNya7tMELUwEnKjwfTSPvEYszjJy9
         Z9kE+qLPCnt7BzTSwp+myW7LVf2hR0JRMPJYHh5CF11JR5vu019twIsynsXo7/RUAuAJ
         LbNA==
X-Gm-Message-State: AOAM533Wi0GIaSFDPO4fhSqVV8mJOvPDKAuHGkhr9btqqu5XrqfJC6gL
        JiBdWjM1G2fRBDbFlh/zZQkw5rgn4B7aPQ==
X-Google-Smtp-Source: ABdhPJx4dsrrORWefyOaJaBwml4HUm2oobE0QtXJHHyZSr21A+y8BNmhuTv3ioELhwbbDTv2OiGRNA==
X-Received: by 2002:a17:902:db82:: with SMTP id m2mr21720441pld.14.1590260282249;
        Sat, 23 May 2020 11:58:02 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/12] mm: allow read-ahead with IOCB_NOWAIT set
Date:   Sat, 23 May 2020 12:57:45 -0600
Message-Id: <20200523185755.8494-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read-ahead shouldn't block, so allow it to be done even if
IOCB_NOWAIT is set in the kiocb.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 23a051a7ef0f..80747f1377d5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2031,8 +2031,6 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		page = find_get_page(mapping, index);
 		if (!page) {
-			if (iocb->ki_flags & IOCB_NOWAIT)
-				goto would_block;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
-- 
2.26.2

