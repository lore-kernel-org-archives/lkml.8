Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBDFC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97F120731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="EKSoG5Ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgD3VxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgD3Vwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:46 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4575BC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:46 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so5831765edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0x0u2gx9fn/eR0FN5+bPGwv0n6eHZLnbohIE4ZZX1xA=;
        b=EKSoG5Ew33JLpPLoDYTtE+/Mgaiip4zvgBvwtrD+hzLSfo0W4PoRueJtf0vHDfylth
         bljRy4d4FM68XWGdNeOkwmfpot8DYA8ccYVAgwhAOhIi49XGb7to4+pAAZneDZCwf4G6
         IkFcj1IZ9Qq8NOMnothYcg8j2FPeyvEg43skasH+eZw77B+t7Qfs+j68ULZzmwKal/h3
         9saDCk1g1y7x4x+j5cKc0w4eHvhoxpHehsWHYcMrqIF522cmVjrQX9TO1JsfPCvOuR/I
         zHxuTKM5R0LSq/EtBs1ZI6S/nV/ouTfbgPwVZmpLRJi6srnLa57HKoMQe8NfaoufTaQa
         mUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0x0u2gx9fn/eR0FN5+bPGwv0n6eHZLnbohIE4ZZX1xA=;
        b=Jqg8Xs91dBKbb5BTKsSFxmNk5k1992an+RoHc52TeJH9f8/aI6IgkrYZPP0qeK1QEv
         Cm9ifkXH7kNcYNXNy0/4d+6PnVKPIYEld24IOh40+YJKkgA+EJMxEqjb3JR+ZJzGHY1C
         WXNyLcEXReB84eQUHF1zi/VD8AR9ELTtM98Jj1FeQvXvEpOKCW61uxfBabqSXd3ky1Jo
         GPYhzPLPvy64RJ0ooH4NspjAckpSMTL4s7tidBfK2mZo+PRfH8rxuw8ngOL5LN/V5hDT
         KZETLYX1eOELLSg/vQY6ALq5Bz64PGN5NEYZ9sQvnedArlTqHJsmAzEzm3eJNJE70SA0
         TxVA==
X-Gm-Message-State: AGi0PuaXQFDuNxHAj1CfdMAjH2BoUScs468VPc7WGtjBZJ8xse8V9UDy
        WqMW1N0tFU7bF4ngTQRBtgDsPw==
X-Google-Smtp-Source: APiQypKmEI+P+Q9Igmy/Z+wtCcfy41Y3uqyWZUCr4Xom2jUvuVGNOvsSANgZbWuTvpeKE8zdOXrN5A==
X-Received: by 2002:aa7:ce0f:: with SMTP id d15mr995432edv.327.1588283565020;
        Thu, 30 Apr 2020 14:52:45 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:44 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: [RFC PATCH V2 8/9] orangefs: use attach/clear_page_private
Date:   Thu, 30 Apr 2020 23:44:49 +0200
Message-Id: <20200430214450.10662-9-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in orangefs.

Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.
2. avoid potential use-after-free as suggested by Dave Chinner.

 fs/orangefs/inode.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 12ae630fbed7..139c450aca68 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -62,12 +62,7 @@ static int orangefs_writepage_locked(struct page *page,
 	} else {
 		ret = 0;
 	}
-	if (wr) {
-		kfree(wr);
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
-	}
+	kfree(clear_page_private(page));
 	return ret;
 }
 
@@ -409,9 +404,7 @@ static int orangefs_write_begin(struct file *file,
 	wr->len = len;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)wr);
-	get_page(page);
+	attach_page_private(page, wr);
 okay:
 	return 0;
 }
@@ -459,18 +452,12 @@ static void orangefs_invalidatepage(struct page *page,
 	wr = (struct orangefs_write_range *)page_private(page);
 
 	if (offset == 0 && length == PAGE_SIZE) {
-		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		kfree(clear_page_private(page));
 		return;
 	/* write range entirely within invalidate range (or equal) */
 	} else if (page_offset(page) + offset <= wr->pos &&
 	    wr->pos + wr->len <= page_offset(page) + offset + length) {
-		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		kfree(clear_page_private(page));
 		/* XXX is this right? only caller in fs */
 		cancel_dirty_page(page);
 		return;
@@ -535,12 +522,7 @@ static int orangefs_releasepage(struct page *page, gfp_t foo)
 
 static void orangefs_freepage(struct page *page)
 {
-	if (PagePrivate(page)) {
-		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
-	}
+	kfree(clear_page_private(page));
 }
 
 static int orangefs_launder_page(struct page *page)
@@ -740,9 +722,7 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 	wr->len = PAGE_SIZE;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)wr);
-	get_page(page);
+	attach_page_private(page, wr);
 okay:
 
 	file_update_time(vmf->vma->vm_file);
-- 
2.17.1

