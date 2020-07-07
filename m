Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E10C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1123420675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffwwwsSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgGGRtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgGGRsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB69C08C5E1;
        Tue,  7 Jul 2020 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fw2+4gebTcJUXyNcS2c+cOqcMRuf3D2bJUNwgAt6wzg=; b=ffwwwsSzRkfiu1zSF/dykwvPc6
        8DlX3s1/JsA5j+3ZxaN35I3y8UKbSNZta7qy8O6/AntqKCbHZIkytU4xodFLn8rJqYTu3mjCszaaX
        //pvzQoXhFoyBDgozgYfCfERfE5V2s9+8M6jxIl3s6kgpfocqAPUaJdD0fMQ+rZ+KS0WL0pDDhvmS
        X9V0jFPiI9sLSbhBnyol3t8nh7VsUpyBbZOchGcqWp+sWoOADUX9KGSa0US5n3MUiHiQOqZs0M7CF
        WF9x1+06iPAv8evXC6xKzWPanD+2FxIggtGftp3sijUSmihNue7qJi9e/uvm4YhtaqVIMhTfByosQ
        Tq+rfLtw==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhN-0003Gz-4o; Tue, 07 Jul 2020 17:48:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 01/23] cachefiles: switch to kernel_write
Date:   Tue,  7 Jul 2020 19:47:39 +0200
Message-Id: <20200707174801.4162712-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__kernel_write doesn't take a sb_writers references, which we need here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 fs/cachefiles/rdwr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index e7726f5f1241c2..3080cda9e82457 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -937,7 +937,7 @@ int cachefiles_write_page(struct fscache_storage *op, struct page *page)
 	}
 
 	data = kmap(page);
-	ret = __kernel_write(file, data, len, &pos);
+	ret = kernel_write(file, data, len, &pos);
 	kunmap(page);
 	fput(file);
 	if (ret != len)
-- 
2.26.2

