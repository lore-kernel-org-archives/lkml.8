Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87957C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E70A206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974948;
	bh=IiwTl1Btd+XDJ0J7xpyly+d18it5VD3jAe9Iu+uzDv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=reyv5isGwvuqpy2k44reKtM+YxER3R2z31pdR5xluFCuEDJnwi6M0/iXLlGE/lZGt
	 K5QArPeaDAFfM5ERVYvGdFcklo7qO/egXJhdO257n5FgkSPwuz16xIINO7UHSINeOx
	 2gIfEP8ZGJWNCZMH+qQKHqJC83wpmHYBEGiNbUUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgIAPm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731481AbgIAPjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:39:53 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05413205F4;
        Tue,  1 Sep 2020 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974792;
        bh=IiwTl1Btd+XDJ0J7xpyly+d18it5VD3jAe9Iu+uzDv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMV+jahDEchKvvh9EpzG+k4jvC0fI3PK+Gs+5KfNzgQ2LjG0xBtm945AAGzRG2mm6
         YQO20aFM1w2rnC59J81B4mibbxwEwGo9Fyj42CsI/SI1CxUjxBOqM5f9b8z4sOe7Aa
         Ryuu/gHcFpqRFZwdzjSnkZyo4lDa5aM6YnrtIf90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yufen Yu <yuyufen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 093/255] blkcg: fix memleak for iolatency
Date:   Tue,  1 Sep 2020 17:09:09 +0200
Message-Id: <20200901151005.181284538@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit 27029b4b18aa5d3b060f0bf2c26dae254132cfce ]

Normally, blkcg_iolatency_exit() will free related memory in iolatency
when cleanup queue. But if blk_throtl_init() return error and queue init
fail, blkcg_iolatency_exit() will not do that for us. Then it cause
memory leak.

Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0ecc897b225c9..6e8f5e60b0982 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1056,13 +1056,15 @@ int blkcg_init_queue(struct request_queue *q)
 	if (preloaded)
 		radix_tree_preload_end();
 
-	ret = blk_iolatency_init(q);
+	ret = blk_throtl_init(q);
 	if (ret)
 		goto err_destroy_all;
 
-	ret = blk_throtl_init(q);
-	if (ret)
+	ret = blk_iolatency_init(q);
+	if (ret) {
+		blk_throtl_exit(q);
 		goto err_destroy_all;
+	}
 	return 0;
 
 err_destroy_all:
-- 
2.25.1



