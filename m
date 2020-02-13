Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C7C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B7B218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609579;
	bh=mI7qczRJxzPh+VQeXpN6CYxInWBEWQHtsA/oCIycgYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0PaKROpbgOqSZe7+5rZMWYQh22cV3nBP0o3w2lWwC9VAPVsEhcADQi2sa+sq35glZ
	 tQGzORoTudDDiipf8EYbRIXnyynGv4x93MhUED9USsVhElL5/KMJY/HjIblYzkz+D9
	 xbpKFFwFDQRVBy0uRwwpHzgFINiO/YsfIBbaaDzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbgBMP7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:59:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbgBMPYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:52 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8622424693;
        Thu, 13 Feb 2020 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607491;
        bh=mI7qczRJxzPh+VQeXpN6CYxInWBEWQHtsA/oCIycgYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOIcjIMTs0b6xDSQQlJoHZvwEdt5vmGQnaorErW95FkZGJoiw6wM6x1oipRHq3JOM
         3HepU9Zu04AHr9wqHD5oVI80lRTtfB81yH80a8qu8n71+LYGBE5yQE5t19uhlJGzSx
         Qb0m1Tlrl6+GSNwi1k7Gg4lASjVc7ga8EvtMgEyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhihao Cheng <chengzhihao1@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Stable@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 041/173] ubifs: Fix deadlock in concurrent bulk-read and writepage
Date:   Thu, 13 Feb 2020 07:19:04 -0800
Message-Id: <20200213151944.307212834@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
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
 fs/ubifs/file.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -797,7 +797,9 @@ static int ubifs_do_bulk_read(struct ubi
 
 		if (page_offset > end_index)
 			break;
-		page = find_or_create_page(mapping, page_offset, ra_gfp_mask);
+		page = pagecache_get_page(mapping, page_offset,
+				 FGP_LOCK|FGP_ACCESSED|FGP_CREAT|FGP_NOWAIT,
+				 ra_gfp_mask);
 		if (!page)
 			break;
 		if (!PageUptodate(page))


