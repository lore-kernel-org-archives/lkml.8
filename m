Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC8BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F0B2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948484;
	bh=Sc3xsrDQ7Hm+hoonV8rReQsxTqyTTdnoEeJMQvSQLhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k1JJQxj6nTBPriiotj6I+EHMzC9E7OFVp7Wa8HKX3i2imNVc0h0lr8jdoVg4tYbQI
	 MuJTLd8Z8yuFLZ0nuyVi+lByEl6ROqAzp1eJul9YqZcNtuzOn/ujK4QNQbFlAgsc3/
	 mOrwkrkFxfiKLPBe1IJLjVVLBsoXyEeDflEgqZSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389373AbgFWVlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387548AbgFWUGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:06:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8043720E65;
        Tue, 23 Jun 2020 20:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942773;
        bh=Sc3xsrDQ7Hm+hoonV8rReQsxTqyTTdnoEeJMQvSQLhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5eYZ7E5TBKQg6jeeXrzy573qXKUCCAm7Z9LJNtYmlTTvn6yjVBQYi4KRVUW42YzY
         zZ6A5W7yJqNE/AYqItiGjv/6Fox8d9px87SR7aJiyIeKb+GDVTlZvhdU3jn3WPpzXK
         dlHAPx7EqVqeMQy3wcHFqhlbtm+ZzOj8MAqwmPiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 129/477] fuse: BUG_ON correction in fuse_dev_splice_write()
Date:   Tue, 23 Jun 2020 21:52:06 +0200
Message-Id: <20200623195413.705890948@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 0e9fb6f17ad5b386b75451328975a07d7d953c6d ]

commit 963545357202 ("fuse: reduce allocation size for splice_write")
changed size of bufs array, so BUG_ON which checks the index of the array
shold also be fixed.

[SzM: turn BUG_ON into WARN_ON]

Fixes: 963545357202 ("fuse: reduce allocation size for splice_write")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 97eec7522bf20..5c155437a455d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1977,8 +1977,9 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 		struct pipe_buffer *ibuf;
 		struct pipe_buffer *obuf;
 
-		BUG_ON(nbuf >= pipe->ring_size);
-		BUG_ON(tail == head);
+		if (WARN_ON(nbuf >= count || tail == head))
+			goto out_free;
+
 		ibuf = &pipe->bufs[tail & mask];
 		obuf = &bufs[nbuf];
 
-- 
2.25.1



