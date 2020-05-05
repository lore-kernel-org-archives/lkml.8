Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDCDC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24EAF206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9RO3pgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgEENxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728965AbgEENxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:53:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DD0C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:53:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so920730pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QJU1rgdyR3dsjV2URMfZxPtiLnMEVx7zziz4YW88wtc=;
        b=I9RO3pgjGmr1FZpr0FwTzwdMQZjnnQ/wVjovFIecF1T58ixbSFm2fJTWOqsJQ+QiHg
         OyJFLLZyE5MrODJ7pAmAy3cKW7fO7d9SZOH8/p55bXqM1ySA0LLe6GZ4LP9nHsoIhRBI
         5TqYq3nNSBYoL+U8t/9YNBd2CVnf/oW0AKwN9Aj+dI0UVFEMsiM5iLDXSMIyiSyA0h7+
         C6kWDkjUSP+ebxyGtTmhkRcALPduflyZwo1on3TtMGHfANUKwPXUSFUZt8NoZWV5s45v
         aSCOBUSupfNy1R/dN+O+5R0A4/Uc0YEUHBDJDnAcYaXZGx9D7Qt2Q1Z90tIDjrRTWhAH
         tFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QJU1rgdyR3dsjV2URMfZxPtiLnMEVx7zziz4YW88wtc=;
        b=rz5VPNGgYxw4HxpF3uKYCjW874TjPD4P1HjaasZrbKofmvmjL8m45e2yOS2OwTDrsy
         fP+LkeRJyetPZm2H1njGbgF2PoGd2IRjY4TBgam8zplgsNpNyCbxf4fRt8/XO0Pw0m5Z
         zz8FnJDJku8dRYsFzCXcBOcKFuMHcP16TIoP0xvWtdDjwI2DMtwX99pDqV/QHGUnNCyY
         MrN8VJqjj9kikZhnqJ94SX77P2HgBhIVwT4kChhMiVWxa351A1R7d2aXVJ9ci8HvE4Iu
         PP1m6wK5bAdz9BWOfQGjRKeN23wd10TzktzPSOMPtKUp2c1ZoqdkTVvF+JtRqFZORR+X
         w/tw==
X-Gm-Message-State: AGi0PuYTEbgdQCzM9fERGh/Hc8/4Gtk0/jaQnyS8lTnF7z/jcxoYFpLw
        benOgGySwtufDYuApdplVxlLq4ZvTNHYUQ==
X-Google-Smtp-Source: APiQypJTpVbLFJfbC4pTfe+3bRqpJK6v1l7Gl1XmYpllcrZp8mtXHfu530JzQx2s1IZ5/Qt1u+NwBQ==
X-Received: by 2002:a62:e51a:: with SMTP id n26mr3180048pff.301.1588686829155;
        Tue, 05 May 2020 06:53:49 -0700 (PDT)
Received: from localhost.localdomain ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id i15sm2061013pfo.195.2020.05.05.06.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 06:53:48 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     shaggy@kernel.org, Markus.Elfring@web.de
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] fs: jfs: fix a possible data race in metapage_writepage()
Date:   Tue,  5 May 2020 21:53:13 +0800
Message-Id: <20200505135313.28793-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions metapage_writepage() and lmPostGC() can be concurrently 
executed in the following call contexts:

Thread1:
  metapage_writepage()

Thread2:
  lbmIODone()
    lmPostGC()

In metapage_writepage():
  if (mp->log && !(mp->log->cflag & logGC_PAGEOUT))

In lmPostGC():
  spin_lock_irqsave(&log->gclock, flags);
  ...
  log->cflag &= ~logGC_PAGEOUT
  ...
  spin_unlock_irqrestore(&log->gclock, flags);

The memory addresses of mp->log->cflag and log->cflag can be identical,
and thus a data race can occur.

This data race is found by our concurrency fuzzer.

Thus use the spin lock "mp->log->gclock" for the assignment of 
the data structure member "log->cflag" to a local variable 
in this function implementation.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Change the description.
  Thank Markus Elfring for good advice.

---
 fs/jfs/jfs_metapage.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index a2f5338a5ea1..026c11b2572d 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -351,6 +351,7 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 	unsigned long bio_offset = 0;
 	int offset;
 	int bad_blocks = 0;
+	uint cflag;
 
 	page_start = (sector_t)page->index <<
 		     (PAGE_SHIFT - inode->i_blkbits);
@@ -370,8 +371,14 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 			 * Make sure this page isn't blocked indefinitely.
 			 * If the journal isn't undergoing I/O, push it
 			 */
-			if (mp->log && !(mp->log->cflag & logGC_PAGEOUT))
-				jfs_flush_journal(mp->log, 0);
+
+			if (mp->log) {
+				spin_lock_irq(&mp->log->gclock);
+				cflag = mp->log->cflag;
+				spin_unlock_irq(&mp->log->gclock);
+				if (!(cflag & logGC_PAGEOUT))
+					jfs_flush_journal(mp->log, 0);
+			}
 			continue;
 		}
 
-- 
2.17.1

