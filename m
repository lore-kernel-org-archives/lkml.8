Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76164C35DEE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4371820578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582810846;
	bh=t+1sB1qtdHtKLtSzjWPIS3NZOaUxJJMxbAXpedRVQIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G8tlYwDUgBvvLyKXiV6AImtP16wtQSpTCF4KuO5c//Ce9aLxsvOGl7cBnDYEsEnWD
	 tPllKLDfGbqK1Yr3KA502ylF7VdhMVzp7cKSm61x+thAOSAvLPy00jGf0GjcVyUnRE
	 E75iliY+QCwJkR/uZIfiJbfV4TYU0i/zjzDooaxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgB0Nkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:40:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbgB0Nkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:40:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0569246A1;
        Thu, 27 Feb 2020 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582810840;
        bh=t+1sB1qtdHtKLtSzjWPIS3NZOaUxJJMxbAXpedRVQIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NloBVxsxQ0R0zbY0KWF1OT/m37bhyXdhWTefD+6ks+iToBhC4ZNfac8+bi3B0v8g+
         YM+nwIz2ESj5dR1WsKfWaan1ii1oqnxZ0DYeypfGOfyFPVzRpqsm+JSQyLE/8PKeIz
         DF3Ef7u9F+QeP0of48f8w3w5Jft7Mk/JsJx+ieNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhihao Cheng <chengzhihao1@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Stable@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.4 007/113] ubifs: Fix deadlock in concurrent bulk-read and writepage
Date:   Thu, 27 Feb 2020 14:35:23 +0100
Message-Id: <20200227132212.943520725@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132211.791484803@linuxfoundation.org>
References: <20200227132211.791484803@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

commit f5de5b83303e61b1f3fb09bd77ce3ac2d7a475f2 upstream.

In ubifs, concurrent execution of writepage and bulk read on the same file
may cause ABBA deadlock, for example (Reproduce method see Link):

Process A(Bulk-read starts from page4)         Process B(write page4 back)
  vfs_read                                       wb_workfn or fsync
  ...                                            ...
  generic_file_buffered_read                     write_cache_pages
    ubifs_readpage                                 LOCK(page4)

      ubifs_bulk_read                              ubifs_writepage
        LOCK(ui->ui_mutex)                           ubifs_write_inode

	  ubifs_do_bulk_read                           LOCK(ui->ui_mutex)
	    find_or_create_page(alloc page4)                  ↑
	      LOCK(page4)                   <--     ABBA deadlock occurs!

In order to ensure the serialization execution of bulk read, we can't
remove the big lock 'ui->ui_mutex' in ubifs_bulk_read(). Instead, we
allow ubifs_do_bulk_read() to lock page failed by replacing
find_or_create_page(FGP_LOCK) with
pagecache_get_page(FGP_LOCK | FGP_NOWAIT).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: zhangyi (F) <yi.zhang@huawei.com>
Cc: <Stable@vger.kernel.org>
Fixes: 4793e7c5e1c ("UBIFS: add bulk-read facility")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206153
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 fs/ubifs/file.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -782,8 +782,9 @@ static int ubifs_do_bulk_read(struct ubi
 
 		if (page_offset > end_index)
 			break;
-		page = find_or_create_page(mapping, page_offset,
-					   GFP_NOFS | __GFP_COLD);
+		page = pagecache_get_page(mapping, page_offset,
+				 FGP_LOCK|FGP_ACCESSED|FGP_CREAT|FGP_NOWAIT,
+				 GFP_NOFS | __GFP_COLD);
 		if (!page)
 			break;
 		if (!PageUptodate(page))


