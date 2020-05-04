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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C9C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C222075A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTPPH0DQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgEDPcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgEDPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:32:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67573C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 08:32:10 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so612087pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 08:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6x/gkPpdUu5ZmCBu+qA+TYPM/TczyqfC7nUcr3D0L1k=;
        b=XTPPH0DQ0On3AJBqn12M+3nev/cwzx+gz00/YUky/lwUu6RbphgQjtpuZlqjH+XaM4
         bEuVcKAZ+5bOsrtkY77Qm+ZWBkSphxa2KPb152eY5jVMtuw1YKMSEamDWLtZ0IDLhufE
         /OxOfjLf7XzKtQLjPznBqcoGl3UONq7vS1j08DscuQ81NvDYIZTqEfUrcOU5C6O2mn7u
         OpKYoC1AH3D56+CBzrWckRFAyTN4JeAv4Ai98hs9+F1WJHmsh4O7oczY+T3GQJeJZk0F
         MuOsgUt2KOWnAUbAMxlsaFmUS/F2UmOsjYzyfnirTebXu9aFgen9wcwbzIl1JrrXQJoH
         KI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6x/gkPpdUu5ZmCBu+qA+TYPM/TczyqfC7nUcr3D0L1k=;
        b=s8abxsUO8a94CRltpKpEAp+5zuE1G2a08eS3AIfxybzcGW95i+vxEjfihvLgyjd0ux
         f2J96og2lA7SPcAFBzFL187q7bVCYH34bSu8IoZ51v2Ydthquis0EncU6+le3HdPNmA0
         Q1trsrr4Yy+5zR0NQlDyHAdvLZMxmUb2FcWzYjYD84OhWfBZSMyK89n8BsLrr/10V/SL
         qBm0jUIyF+k482IBmRc3BRMLa6F80+blXhYSyvJKaQBWUf2y5YzQxaFqHMXD3PJFqFiv
         2/4BzLu8DQUhb0xafcZDsuqIg3oQFj2gLbc8hG3YrmIcceMW0TMXtL9dZY3avQjy0I71
         SblQ==
X-Gm-Message-State: AGi0PubX2mNd5NLJRW21k+NmGVvtdt7f24pKa3LWUzotpqFGd5Shvoy0
        Rg3s5oMurTnFD2QWr37KCYc=
X-Google-Smtp-Source: APiQypLR7YUeSVYAK2wE39xo97f1yngB2mL78CcKaxaBSUitWDFxaVQ1+ct/1M+wrWIFt23hN6kjgA==
X-Received: by 2002:a63:a043:: with SMTP id u3mr16617563pgn.287.1588606329912;
        Mon, 04 May 2020 08:32:09 -0700 (PDT)
Received: from localhost.localdomain ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id l137sm9226518pfd.107.2020.05.04.08.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 08:32:09 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: jfs: fix a possible data race in metapage_writepage()
Date:   Mon,  4 May 2020 23:31:38 +0800
Message-Id: <20200504153138.13464-1-baijiaju1990@gmail.com>
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

To fix this data race, the spinlock mp->log->gclock is used in
metapage_writepage().

This data race is found by our concurrency fuzzer.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
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

