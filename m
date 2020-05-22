Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37050C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E902207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oluJiB9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgEVUXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731017AbgEVUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:23:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B77C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:23:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a5so5417807pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=oluJiB9kWUp1jQn6GyLmG8WAT4m3lKYyoaZWl/EYudmvX4dpan5EUM8v9K2zM1/sA7
         O3g1BfDhqlwNJGIPOYmdgugrSlOXilKAkvTeGRZUAyg+ubdWg9R3UvtbrB8ako657CER
         OJig952C9v1iZGI2ZOQhlCVH6ErL4Ubx1gxOzYooasGRhDU0/Dt65urTRTAMtn67pdgQ
         gEFv59qa47MpUvtQ+b2fWdA5BKzUAJwUSiYvK2yAGfBa9QmyVAXuxxZeZrInMJdae2Zk
         mY5mg1VVp8HXmhTWFTyUwV1HXJ8c3ncMAaK9kqA0E1p1Xbei/hD9gc3x5raO9d4lvh4l
         JTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=Td4zelZjIITNKcV90jUjuvMaiPPHuipzLFNzzcizRTeWjg5wHrnmqYlLuG3XBMbUoS
         f60U0gJCgmT52d0im8JIYUOpG/yuCvRBIN+cebdM83YJJU8vCTMY1JZ1/P/hJstmddwE
         LWcdjmwMetIC7C9coTH3jSvuSLPXTKtqlfyNR8h4OsSIrmIZp7DXTkiH76Tr4nrjav6X
         MKMf3OsmhOXIfGf+8SBxWcpFHzrex/qnnrdm/ci4UqeoANpgPFeAWFnx1dTtJqln0Aht
         ou9BRFPwaNERxrTW2d6ubPjFOe0/54emcVFMbAOVcEM4S9v6GjCeqlHiUQmBmjPSg1HN
         qR7Q==
X-Gm-Message-State: AOAM5320x/L/h9LZFnWDOmK0I2lqRywcdch9Q7pI7vSIUs78HYkTnnLy
        hCvdmUooM4NKblI0M7iJCmywUA==
X-Google-Smtp-Source: ABdhPJwRmiBEyWg7pdyhPoLxCIRWXwfGbwz6AlixTjtFq9I6DrZDtT63kPMRKd8YJFJc1xW8WultIQ==
X-Received: by 2002:a17:90a:d3ce:: with SMTP id d14mr6342767pjw.46.1590178999200;
        Fri, 22 May 2020 13:23:19 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id e19sm7295561pfn.17.2020.05.22.13.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 13:23:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/11] block: read-ahead submission should imply no-wait as well
Date:   Fri, 22 May 2020 14:23:01 -0600
Message-Id: <20200522202311.10959-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522202311.10959-1-axboe@kernel.dk>
References: <20200522202311.10959-1-axboe@kernel.dk>
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

