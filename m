Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2460C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12772071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Gm5iEQRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgDZVuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 17:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgDZVt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25BC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w2so12012590edx.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qimnPXc/z1dTWaJyW3qhOlSkB0/PAvYb4yEUYXtkvBs=;
        b=Gm5iEQRGXjL2eUupRJ1Bh30r73SUBX84ADcBLaYreiF3hSkQEWeKNIEUgAFgJLtLMv
         wPfZtMjOqDacKdHwqWjWK8uVQ188OIkqVCt146DjBGGH399nUPOYIlJkSW4dfDknFdUF
         7MZbSYWDEpgvMg69WJ+M7z5zshqFGp9auxPkebka7dLFCiHYBwsu5dsfZgALElUrvwf8
         DMOqEwdKpZ2bPipHuh1KAjPEo3Qe2sEvSDGUJU0QwVaiR6GH/gZlDzprRcFZ2Ke6EyZ9
         yUX9cBs8ilZZTyPKS+PUWadroC9CcJIR2cNNDoHBKSUR8zw2YRZtoZQ+7apQE5HafRd2
         Sbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qimnPXc/z1dTWaJyW3qhOlSkB0/PAvYb4yEUYXtkvBs=;
        b=t1vIvw5/UMw2afz+fWLSsvnJjA15OjHo2wypOCbrTHBE7x/Oi31gR+UORfmR+n5wFg
         Yg1W7x/cvvZAAtsrXv4iOGGJKvs2M8lUxIbLM4ddqWJ9XEPoHY3PyBvZBEsXONhgI5IW
         3Gl9q7cPBgEPOva6ocEo6R8YLcsAUoTUnfFyf1o6btg9rDFK1+bjhLV5l4v/TH9Lek04
         YVg3DA0XmDxk1Y3Y3Umoo0fpa3z+kh3egrBL2XtCJm0L9QRrbzC8otrTikMV5Xb/Khqo
         9aP8lG/UCzp0w8ZvCkp34zfhzjEzig10tNpoUK/GSGx4yDDYQIPpKp6ZfAFgmjNrWuys
         k7eA==
X-Gm-Message-State: AGi0PuawqIAT5fA3JAKZCmxfH/KP89dm/IlIow7RjGuTkO0gssuVVEg8
        ITz2lcusXj1D8QiHe7Fp10iedQ==
X-Google-Smtp-Source: APiQypIxdj3EgE49EVNEoQZtKa8LHmNouU6TNbFXBP16dEsDxvsw1UYgQ/dUsGDgJvJe0Ig5v2bGJQ==
X-Received: by 2002:a50:c3c2:: with SMTP id i2mr15735367edf.93.1587937794634;
        Sun, 26 Apr 2020 14:49:54 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:54 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: [RFC PATCH 8/9] orangefs: use set/clear_fs_page_private
Date:   Sun, 26 Apr 2020 23:49:24 +0200
Message-Id: <20200426214925.10970-9-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
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
 fs/orangefs/inode.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 12ae630fbed7..893099d36e20 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -64,9 +64,7 @@ static int orangefs_writepage_locked(struct page *page,
 	}
 	if (wr) {
 		kfree(wr);
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		clear_fs_page_private(page);
 	}
 	return ret;
 }
@@ -409,9 +407,7 @@ static int orangefs_write_begin(struct file *file,
 	wr->len = len;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)wr);
-	get_page(page);
+	set_fs_page_private(page, wr);
 okay:
 	return 0;
 }
@@ -460,17 +456,13 @@ static void orangefs_invalidatepage(struct page *page,
 
 	if (offset == 0 && length == PAGE_SIZE) {
 		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		clear_fs_page_private(page);
 		return;
 	/* write range entirely within invalidate range (or equal) */
 	} else if (page_offset(page) + offset <= wr->pos &&
 	    wr->pos + wr->len <= page_offset(page) + offset + length) {
 		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		clear_fs_page_private(page);
 		/* XXX is this right? only caller in fs */
 		cancel_dirty_page(page);
 		return;
@@ -537,9 +529,7 @@ static void orangefs_freepage(struct page *page)
 {
 	if (PagePrivate(page)) {
 		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		clear_fs_page_private(page);
 	}
 }
 
@@ -740,9 +730,7 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 	wr->len = PAGE_SIZE;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)wr);
-	get_page(page);
+	set_fs_page_private(page, wr);
 okay:
 
 	file_update_time(vmf->vma->vm_file);
-- 
2.17.1

