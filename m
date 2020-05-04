Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4509C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9440C20705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnLqvQY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgEDOCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgEDOCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:02:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E97C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 07:02:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s8so8514433pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4eecyt+DUYccwhMTCjrta4aHo5IczYr3GF085KGw+5w=;
        b=AnLqvQY2GefSo4gIsF0Xry75jB/5c736xQEWdac1hcQEmpj9DFoeWNNdplAVlncZE3
         0H5wpYdNfEV/V5UbAE60/DVJ7kXrrZzW/lZd6JXEYKcRbyofTe06v6Ncm+dP8GiQNhtb
         exEBibD2NBwTkjLV8yFO2JBQm78vaclpB4ffxx+0MY0WyJIU+4gxoISYjatiVRcz9YAx
         1agGfHr895fCPWc9xKgTNfOKOCoWAEVXCnyZa1dbrJGw+WkBf4JnHOoUyrO/KieL7wdB
         BFml0TeWiv1RjOpr1cVUGjxSYvwlnbY/Y8p+MYuQko/Pi8kVN+NYpFkDYOYAreFaSSNb
         F1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4eecyt+DUYccwhMTCjrta4aHo5IczYr3GF085KGw+5w=;
        b=ulkUWNhHuZTGAaRh9aUysQOqHdQkSuJfAFjQB3MXp5FLNr96/N4VUtZylyBTWJYWjG
         HLzfTT5lZ7grYO+fUXWSmsZAQ3f23X5llKXJv+FcKu3YUOgDqdzWubOyKCkQ1ykVqwBr
         GM43EPDp/deoO74AOJcT4IuPmCYdyOfN+S15U01k6VJPMaGXk3QWQDZcOeJDtuWv1fcI
         1Nne3eEWgPzu2g4pm1xIjTxijVW4ITWhf3Cb6cBzJWz2w3rc5xMuBfm3iG9jYGyheOLf
         HpP8vFM5b/evFAuAtMm4L3IIK9IjHs0IlY0t55EO4/YdXaUXwIvor+jC/6zdG5wDTY52
         PEdg==
X-Gm-Message-State: AGi0PuY3iWcVYrbcdXTUzGrq01P9/O+BgCmVA0oyBS4Gc12B+Eky4g6l
        mQni/BblKorpnnjDi3FU+OM=
X-Google-Smtp-Source: APiQypKbM3702OfJgUcoxAgHiqkRsQwIWb5OqEGdYlzjY7ytYyaSftbTr9fqsoMiGVNzYjp2EgLvtw==
X-Received: by 2002:a62:2ad2:: with SMTP id q201mr17769556pfq.323.1588600964431;
        Mon, 04 May 2020 07:02:44 -0700 (PDT)
Received: from localhost.localdomain ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id mn1sm7113207pjb.24.2020.05.04.07.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:43 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: jfs: fix possible data races in txExit()
Date:   Mon,  4 May 2020 22:02:09 +0800
Message-Id: <20200504140209.18689-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions txEnd() and txExit() can be concurrently executed in the
following call contexts:

Thread1: 
  jfs_lazycommit()
    txLazyCommit()
      txEnd()
Thread2:
  exit_jfs_fs()
    txExit()

In txEnd():
  struct tblock *tblk = tid_to_tblock(tid);
  // #define tid_to_tblock(tid) (&TxBlock[tid])

In txExit():
  vfree(TxBlock);
  TxBlock = NULL;

Thus, data races can occur for the global variable TxBlock.
And these data races can cause use-after-free bugs and null-pointer
dereferences.

To fix these data races, txExit() is called after the filesystem stops 
the threads that run jfs_lazycommit().

These data races are found by our concurrency fuzzer.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/jfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index b2dc4d1f9dcc..8c80397df336 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -1027,13 +1027,13 @@ static void __exit exit_jfs_fs(void)
 
 	jfs_info("exit_jfs_fs called");
 
-	txExit();
 	metapage_exit();
 
 	kthread_stop(jfsIOthread);
 	for (i = 0; i < commit_threads; i++)
 		kthread_stop(jfsCommitThread[i]);
 	kthread_stop(jfsSyncThread);
+	txExit();
 #ifdef PROC_FS_JFS
 	jfs_proc_clean();
 #endif
-- 
2.17.1

