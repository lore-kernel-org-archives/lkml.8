Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF4CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848062078D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TbEJ3ffF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFSG0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgFSG0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 02:26:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D3C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 23:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=U+XtLWpHPp9STA62dagelcykteGUqdAd/GAg50BIhdU=; b=TbEJ3ffF0kJIocQBwOa24HmyE4
        oMV5vl7GwSYxs+Fb/R4EXWkrdh/ZouwrOTUyBd7BevL5i3XsqShCdxXQn5+u23f0l7kOHs8eYSkOd
        AEpR32vxNzUHuwuXlQwOO8xz3F0Ub8zThpMSALDhlDBoc4Z44eBXOrsAzBTt2edwyza3PFJ9UpO9b
        WIKCUE07lCKZk1hB+Yyrof3oTUn7S/kSJWzKxwj/HGoY8GlurNvoLPxMoht/jz6tDI8alGI6aaVW/
        JLJX3GA4vaeHoCRShYqHcx8xyXiVf4ZKbnQVwinNK2NMJbOqxH7TbNk6Cc+Mprm0OgVG7DTJtuAo5
        fv0EUKqw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmATu-0002k2-Au; Fri, 19 Jun 2020 06:26:30 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ntfs: delete extraneous semicolons
Message-ID: <b7762026-6390-128d-a253-9b66f8f43708@infradead.org>
Date:   Thu, 18 Jun 2020 23:26:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Coccinelle scripts report:

fs/ntfs/lcnalloc.c:902:2-3: Unneeded semicolon
fs/ntfs/super.c:1615:2-3: Unneeded semicolon
fs/ntfs/super.c:1684:2-3: Unneeded semicolon

so remove the extraneous semicolons.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
---
 fs/ntfs/lcnalloc.c |    2 +-
 fs/ntfs/super.c    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200617.orig/fs/ntfs/lcnalloc.c
+++ linux-next-20200617/fs/ntfs/lcnalloc.c
@@ -899,7 +899,7 @@ s64 __ntfs_cluster_free(ntfs_inode *ni,
 		}
 		/* We have freed @to_free real clusters. */
 		real_freed = to_free;
-	};
+	}
 	/* Go to the next run and adjust the number of clusters left to free. */
 	++rl;
 	if (count >= 0)
--- linux-next-20200617.orig/fs/ntfs/super.c
+++ linux-next-20200617/fs/ntfs/super.c
@@ -1612,7 +1612,7 @@ read_partial_attrdef_page:
 		memcpy((u8*)vol->attrdef + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
@@ -1681,7 +1681,7 @@ read_partial_upcase_page:
 		memcpy((char*)vol->upcase + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)


