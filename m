Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692A3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A892075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlJXAd6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgE1It1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:49:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36633 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727799AbgE1It1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590655765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2pnC083V0pnYzb6yk8o50sOtDplBpj/ICt68p1h9nVg=;
        b=TlJXAd6dGROvQoandy9Y6V6YUe8yLFmOUbL5jZZUH7yeNBfdo8M9i1bsAL/Vjh26tGCwDt
        968h7j+15qntyKMWLh12kcAEFC6lmbzZgZNFQbDRZaJ94R2X68nUDpk02ldliEkFtn8D24
        gCBh3MWXgjm6Wi7xMySGPvNyG2Izkqg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-mPxtGOyNMWOW3vkd4grCRA-1; Thu, 28 May 2020 04:49:24 -0400
X-MC-Unique: mPxtGOyNMWOW3vkd4grCRA-1
Received: by mail-pl1-f197.google.com with SMTP id s9so20067650plq.18
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2pnC083V0pnYzb6yk8o50sOtDplBpj/ICt68p1h9nVg=;
        b=kmmRegpv2WF0vNiD0kuIrXUrB2P3vbtjLg+0rKxw2KOzfpWNKimDzDtZEZJfwa3iwm
         O9Ub87BldsrZ6O5TOb7AJlYHzP6Xw9nUEIUheL3KGE9HtcPBkySr0waNTWD6XUbsrpWc
         WekV7P2XXvuVxROYq9Dc0n0V9zj15nwom+GiZJpF1+uRBWIhhHYo0hD49ral1FSIPz1z
         pwg5EjokvvzA/ES2luPJdRvdE6q2Mk3nzJZYQ5YHW2FjVSuFHoQd0VmRHrbq5sdZn2jB
         mbtK2t4YuLl+KcBHA+U9PNBHaBBoifXPjb22h0c9tEaxchAcDxQbH+q6bqxkcDyQOLnj
         Omsw==
X-Gm-Message-State: AOAM532ggWDKaLMUavGuw3aYLwuTrQye7lbIW7/lV7vU4eJfo7Xk5ETB
        lfRK8fkPS34lrqob43sBZHk6q0n0gkd/NhJ1+eUMVQ/gaRYdTozBOMqvTntlf/iMpcX/7Tdym90
        lEYqlWv+oMsfconakBFKiB4vy
X-Received: by 2002:a17:902:a502:: with SMTP id s2mr2517701plq.267.1590655762864;
        Thu, 28 May 2020 01:49:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlfbw5cs5+wHYj6N0Z8vXHmqrSjF0itXJonVuBbXoOBY00ULWOzWT03Au0097wsdr6IHNWBA==
X-Received: by 2002:a17:902:a502:: with SMTP id s2mr2517681plq.267.1590655762531;
        Thu, 28 May 2020 01:49:22 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q9sm4099712pff.62.2020.05.28.01.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 01:49:22 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Gao Xiang <hsiangkao@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] erofs: suppress false positive last_block warning
Date:   Thu, 28 May 2020 04:48:44 -0400
Message-Id: <20200528084844.23359-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Andrew mentioned, some rare specific gcc versions could report
last_block uninitialized warning. Actually last_block doesn't need
to be uninitialized first from its implementation due to bio == NULL
condition. After a bio is allocated, last_block will be assigned
then.

The detailed analysis is in this thread [1]. So let's silence those
confusing gccs simply.

[1] https://lore.kernel.org/r/20200421072839.GA13867@hsiangkao-HP-ZHAN-66-Pro-G1

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fc3a8d8064f8..2812645b361e 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -265,7 +265,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
  */
 static int erofs_raw_access_readpage(struct file *file, struct page *page)
 {
-	erofs_off_t last_block;
+	erofs_off_t uninitialized_var(last_block);
 	struct bio *bio;
 
 	trace_erofs_readpage(page, true);
@@ -285,7 +285,7 @@ static int erofs_raw_access_readpages(struct file *filp,
 				      struct list_head *pages,
 				      unsigned int nr_pages)
 {
-	erofs_off_t last_block;
+	erofs_off_t uninitialized_var(last_block);
 	struct bio *bio = NULL;
 	gfp_t gfp = readahead_gfp_mask(mapping);
 	struct page *page = list_last_entry(pages, struct page, lru);
-- 
2.18.1

