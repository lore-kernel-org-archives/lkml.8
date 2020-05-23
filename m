Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AC5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FC720787
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a87Bs6xG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgEWS6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgEWS6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED6C08C5C2
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q8so6763757pfu.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=a87Bs6xGjaGsCBlocxfqOxy2zUrVZ1peF9M9El8QQmFnxZ4ofnyrA5X/03ZjgM5oMk
         zf0D9gsPh6iz68c+lczEGQM3V/GADtGDtxRQ31jmSVBKL1jK04nvWfXWvIUImNfnH3kf
         iDDUDGAnkjQgjcXuQ6a4VuWuEC8bTOR7qieLkAE391AGwrp2msXuEG5eXaF9F0sTB4El
         xJRLA5INBmlDwvcdz5MRIV2c+bmSNsIetglQf8jjepx0Kkn5lCf+xSkGUABJGpgf9L5C
         7oa9Su9IFvIN+49vDAK5NqyrW+NLNVYtYBXw4n/n1hQuT6+hy/YomwcPhAuxTRqu1mZp
         QD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=McKoVh+N19/by+JX+tAFDeAdWMpkmvRdXmDrSN1l5r9HR7nM2gqEEuH+nsqsb2GdVD
         oUdOqfNkgOYYhLVA54iurzj+ZJggBqZIiXXq+GKV6I3LesHC/aMMYKC0XrK+j8Fk1Ouw
         GR3r21z20iat6qIzVaN5Ker/91eVMwarY2xUIDQz/qALhFlSMMC1+EFb2a6r3hBruxKX
         QX6BPvofGDNMZ+YUDmF4F05olSXdtql+9/z5ki5LBU/h/tZbY3FSmIw4uEOqQn9+/exD
         7Lx+Sl6XBfV3HRmNCNrd0II1wS11I/GNb+iwLdav4nuc+uChXnLIw3dBVZh2W3WtGrh4
         H6cQ==
X-Gm-Message-State: AOAM531J/hMY5y9y+rKWn8HxCZDFxTQwyoRF8bgGnUWw8IHjcQPya6ib
        4Gql/r85VulXM0OWEFy03CVlwg==
X-Google-Smtp-Source: ABdhPJxn7lC8B7nFRg/yRVy5DZn0o0nXIqRSMuIOyfCbYvam4NLOj1/fhahVe0+8oMsT4fckX4/7FQ==
X-Received: by 2002:a63:145f:: with SMTP id 31mr19792396pgu.383.1590260280791;
        Sat, 23 May 2020 11:58:00 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/12] block: read-ahead submission should imply no-wait as well
Date:   Sat, 23 May 2020 12:57:44 -0600
Message-Id: <20200523185755.8494-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As read-ahead is opportunistic, don't block for request allocation.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blk_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ccb895f911b1..c296463c15eb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -374,7 +374,8 @@ enum req_flag_bits {
 #define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
 #define REQ_FUA			(1ULL << __REQ_FUA)
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
-#define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
+#define REQ_RAHEAD		\
+	((1ULL << __REQ_RAHEAD) | (1ULL << __REQ_NOWAIT))
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
-- 
2.26.2

