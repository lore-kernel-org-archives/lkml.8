Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CAEC433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D3221744
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858975;
	bh=FrKXr/6KwIFqjkGnn/7CduLurD7L57pnS1D+ZPzd4ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=meIinmaBXm6LbrIv00mqvnNsQ+m4R9Co87FYyz0CrHPqtmLLlEaaKDd4AHzlKScd3
	 IPl2JS4+vD9LxV3DPZZpszdk+1qd4ncv2yDvOthzItrA/6+l1QEZfRwK09hz+iKd6/
	 McrT4OD6/RDTOw8oAQ3LMXqq5ZVVtpuQNHU4LKtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgG0OJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729630AbgG0OJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:09:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BBF2073E;
        Mon, 27 Jul 2020 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858961;
        bh=FrKXr/6KwIFqjkGnn/7CduLurD7L57pnS1D+ZPzd4ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yPpSiZmGd1CmSkPJKMJibz0Gl3QImhCkZ89pheedzr9Y8k597ZeGIc0clF2KEUSh9
         wKCal+k//sPNAusjDjYV2SJEuYcadC8XMRhCZ1pd+/p6qNtTMcOc8CPZvpNkOp98lB
         MZB+4MmAYsXIHvzl+tyMLX/C1czzgZ4Kz/py6tM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolaus Rath <Nikolaus@rath.org>,
        Hugh Dickins <hughd@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 13/86] fuse: fix weird page warning
Date:   Mon, 27 Jul 2020 16:03:47 +0200
Message-Id: <20200727134915.001245278@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit a5005c3cda6eeb6b95645e6cc32f58dafeffc976 upstream.

When PageWaiters was added, updating this check was missed.

Reported-by: Nikolaus Rath <Nikolaus@rath.org>
Reported-by: Hugh Dickins <hughd@google.com>
Fixes: 62906027091f ("mm: add PageWaiters indicating tasks are waiting for a page bit")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d39143cfa094..01e6ea11822bf 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -838,7 +838,8 @@ static int fuse_check_page(struct page *page)
 	       1 << PG_uptodate |
 	       1 << PG_lru |
 	       1 << PG_active |
-	       1 << PG_reclaim))) {
+	       1 << PG_reclaim |
+	       1 << PG_waiters))) {
 		printk(KERN_WARNING "fuse: trying to steal weird page\n");
 		printk(KERN_WARNING "  page=%p index=%li flags=%08lx, count=%i, mapcount=%i, mapping=%p\n", page, page->index, page->flags, page_count(page), page_mapcount(page), page->mapping);
 		return 1;
-- 
2.25.1



