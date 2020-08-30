Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA98AC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 01:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D23220776
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 01:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="snIHPNIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgH3BbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 21:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgH3BbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 21:31:22 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D370C061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 18:31:22 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e7so2419672qtj.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 18:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oTXPJKxAg5XxTQVL81YppTbJbKKdp2qoMjgryaZThzc=;
        b=snIHPNItiSzMiNbfMvHkwKcuLJe8cG++Oz2ae8qgnrH1ekSHdofCVjHTa1VxsLoeYQ
         kY0fJQw17HrhhvbknPyQU/+X2QJodjqBIL7rjSl0u+38tvX6s4n2Wla57G/6YcU1Q4YG
         yY4w0S5FAIv+SbABcIvu/T4WSScBA/64RzO6UC6leqD4skku42yNm9Tf5qF4sXguMP9D
         dJtoK1aXxn5zgfJIREsXq9lAZ7QcP/JT+MFLzFUBdHDorjQyScUo8DvQuM/mAj2K6Sel
         s4KotxmA3eplfUQ2FecY/AX3Pma+7DhPYL2MATUNCQDeCb4Ax5fxktpf6dLOQiHay9Yp
         NJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oTXPJKxAg5XxTQVL81YppTbJbKKdp2qoMjgryaZThzc=;
        b=Qqb+qcdQv4MNhKxb6vynIDqV3K+GRACn/fC1AAhg6I/2jYSTMNNvOnqmEbmV+dzcur
         TeckAXGQIoZ4beV6whzc7E1x09IU4F5hslx7LvmRM6GP/kKi31wwzyKSQmarhjw6LB1O
         GJKIQb6pxlYBs4djo6e2mU/Ln8MgbK/ip1oeK8BObq4KPBj4MzxkruNZ22UCAvuB5FSz
         CbKhp5tltBk+3Vrzr1+cWGQwza23F66HnFXYOqku/zrqAiDSqqTSmEJ48RWbVvVLWslA
         gW3o33CMsl5ooef7AzdF1V9hAcW3OQ67d02uTlj650p4oCvAm48g8RrUpwujr2mPN+D5
         neRQ==
X-Gm-Message-State: AOAM531esQA77/w/Hasb4d8ie9ScCyHg/lijCAZ9yHuzSaE2sZ3vFTtU
        +boicG+v3ffXCz0O7TXd7po0Ww==
X-Google-Smtp-Source: ABdhPJzwUsBp/+777eFsa+X2LXOqWrmMmxFxP7fZxqjoql/YJZT6UN4uCbSqzHfAc+XBjx1QqoB52g==
X-Received: by 2002:ac8:2baa:: with SMTP id m39mr7636519qtm.204.1598751080998;
        Sat, 29 Aug 2020 18:31:20 -0700 (PDT)
Received: from localhost.localdomain.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e21sm4017553qkl.88.2020.08.29.18.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 18:31:20 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     darrick.wong@oracle.com
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] iomap: fix WARN_ON_ONCE() from unprivileged users
Date:   Sat, 29 Aug 2020 21:30:57 -0400
Message-Id: <20200830013057.14664-1-cai@lca.pw>
X-Mailer: git-send-email 2.18.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is trivial to trigger a WARN_ON_ONCE(1) in iomap_dio_actor() by
unprivileged users which would taint the kernel, or worse - panic if
panic_on_warn or panic_on_taint is set. Hence, just convert it to
pr_warn_ratelimited() to let users know their workloads are racing.
Thanks Dave Chinner for the initial analysis of the racing reproducers.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 fs/iomap/direct-io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..6a6b4bc13269 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -389,7 +389,14 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 	case IOMAP_INLINE:
 		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
 	default:
-		WARN_ON_ONCE(1);
+		/*
+		 * DIO is not serialised against mmap() access at all, and so
+		 * if the page_mkwrite occurs between the writeback and the
+		 * iomap_apply() call in the DIO path, then it will see the
+		 * DELALLOC block that the page-mkwrite allocated.
+		 */
+		pr_warn_ratelimited("page_mkwrite() is racing with DIO read (iomap->type = %u).\n",
+				    iomap->type);
 		return -EIO;
 	}
 }
-- 
2.18.4

