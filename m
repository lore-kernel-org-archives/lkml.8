Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331CDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20C4214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858912;
	bh=5tqfyQQVd7lHz3TN0TiyuYVkJuUZgmznwCFWmtfB1sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GaLFOg520yhyScMJkV0LyIqAeSQM60Uo9rGDdBVeflrfDlio7tMGZEvFgbaFl+wia
	 SD+eabbQ6xs8x1fK+2kUY1X+c7hSJnk1Ort6xD74TmdzDulGiGOb13lmSyg6OyMGNj
	 HYdK3Xsg8GURHk4F876si4yNuezXVvNdzTNTXSzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbgAXJlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:41:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731809AbgAXJlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:41:49 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE811214DB;
        Fri, 24 Jan 2020 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858908;
        bh=5tqfyQQVd7lHz3TN0TiyuYVkJuUZgmznwCFWmtfB1sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsOnjl1lfMDH5n+w3xDv/3ZrYkIgxHCUF0kHmxP5tZXEOIENjQ0rCnKNZqzXik19w
         TUYmhecJH1jvrJk1vvHWZ5zCLl5fTWfC8dpIsZZ9/lGAoNr2P/xJWXpIJmmFuUdVp/
         5vdVWXcoI0ZjSEqeW7mAjOnOYnMKQFbTF+LLd19g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 088/102] SUNRPC: Fix another issue with MIC buffer space
Date:   Fri, 24 Jan 2020 10:31:29 +0100
Message-Id: <20200124092819.954760851@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit e8d70b321ecc9b23d09b8df63e38a2f73160c209 ]

xdr_shrink_pagelen() BUG's when @len is larger than buf->page_len.
This can happen when xdr_buf_read_mic() is given an xdr_buf with
a small page array (like, only a few bytes).

Instead, just cap the number of bytes that xdr_shrink_pagelen()
will move.

Fixes: 5f1bc39979d ("SUNRPC: Fix buffer handling of GSS MIC ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xdr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 14ba9e72a2049..f3104be8ff5dc 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -436,13 +436,12 @@ xdr_shrink_bufhead(struct xdr_buf *buf, size_t len)
 }
 
 /**
- * xdr_shrink_pagelen
+ * xdr_shrink_pagelen - shrinks buf->pages by up to @len bytes
  * @buf: xdr_buf
  * @len: bytes to remove from buf->pages
  *
- * Shrinks XDR buffer's page array buf->pages by
- * 'len' bytes. The extra data is not lost, but is instead
- * moved into the tail.
+ * The extra data is not lost, but is instead moved into buf->tail.
+ * Returns the actual number of bytes moved.
  */
 static unsigned int
 xdr_shrink_pagelen(struct xdr_buf *buf, size_t len)
@@ -455,8 +454,8 @@ xdr_shrink_pagelen(struct xdr_buf *buf, size_t len)
 
 	result = 0;
 	tail = buf->tail;
-	BUG_ON (len > pglen);
-
+	if (len > buf->page_len)
+		len = buf-> page_len;
 	tailbuf_len = buf->buflen - buf->head->iov_len - buf->page_len;
 
 	/* Shift the tail first */
-- 
2.20.1



