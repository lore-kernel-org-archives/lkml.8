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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F3BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD262073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GITI6WzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgEDPeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEDPeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:34:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39766C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 08:34:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id q124so8599020pgq.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MttICuxXavbYMq8WIjicbuvf1Y6ye3X+bWJxx0AAnXc=;
        b=GITI6WzHQ8sPVvnvNjM/77u08qgAq7eXKr1ZaNlw2etpk+K0D2RIl+nt2Lm77+qcp+
         WT2VCckI36iyFh/n8nGxdzrNp1gUGTzjtjJT4tY6Ko36IvJZsAkM/5vnNjvSbVf9LaY7
         DUccfi+2/Zf2VjUl8GIMQCaAHtBb1N/u3mL7rD9CgeB9QA7rKNYFhrNzmttYAW1tGQ2c
         wr9SK36Ap5IDTURoTjocTnJfqz4YlSt8L62ieB+NXzXqGVuPAPdHkPtqcJoJUaiTR5oE
         +o2yVX7s5M4PUNdc5bqReRhkodBRSfxoVorAVIJUmNEMq75zMns/Panug5Tr+3cxf+Ya
         FjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MttICuxXavbYMq8WIjicbuvf1Y6ye3X+bWJxx0AAnXc=;
        b=cA2LxR7FCwC3biK7DhkowLM78SE0Kb85yQZZQggTwvgCKms0B8Exl8dR3ZeMlahp6z
         a2xxwu6mXAxvIO3WTGF53iuUqDZ6OHJfbU/LHv8aGKN1CzXPYm8LR2r8Exdpn2y6mOdl
         ryIGwmMPdrsHtYsMK7KtPZeu5eBwe6YOZCBY465DVpTiF9LDoQLv7EzWa3r6ZOsyaozk
         qlY0IqtWdI7RRcXtHlDQQ+oDElwWbxeFU9uKGwfV/9lAwDGfrvNOxCXXvJxGRpXocK7j
         lC3KZB3OfOv0ghdpwrmQkkUebp1rigFdcqRMM8qqhK/yiH6RNhcEOZ1sDnMEOCtKxkpS
         UthQ==
X-Gm-Message-State: AGi0PuaNrLGwv3eKUnyebS8avrMHG+Bv1rkB4Xp1wrAR6/b5F66YNuJg
        mjVZwm4sYnqnJbP2bg2JhBc=
X-Google-Smtp-Source: APiQypLtehcfIcerd1n0dU1u3gBN3WpIFPxv0tu5ClUiy1B3odbFiv7d19IM0wiaN9hOXAODfk/zBA==
X-Received: by 2002:a65:6713:: with SMTP id u19mr1438519pgf.143.1588606476815;
        Mon, 04 May 2020 08:34:36 -0700 (PDT)
Received: from localhost.localdomain ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id c4sm7178830pga.73.2020.05.04.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 08:34:36 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: jfs: fix a possible data race in txBegin()
Date:   Mon,  4 May 2020 23:34:11 +0800
Message-Id: <20200504153411.13679-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions txBegin() and txLazyCommit() can be concurrently executed
in the following call contexts:

Thread1:
  jfs_write_inode()
    jfs_commit_inode()
      txBegin()

Thread2:
  jfs_lazycommit()
    txLazyCommit()

In txBegin():
  tblk->next = tblk->last = tblk->xflag = tblk->flag = tblk->lsn = 0;

In txLazyCommit():
  spin_lock_irq(&log->gclock);
  ...
  tblk->flag |= tblkGC_COMMITTED;
  ...
  spin_unlock_irq(&log->gclock);

Thus, a data race can occur for tblk->flag.

To fix this data race, the spinlock log->gclock is used in 
txBegin().

This data race is found by our concurrency fuzzer.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/jfs/jfs_txnmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index c8ce7f1bc594..a1f124aad2e0 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -415,7 +415,9 @@ tid_t txBegin(struct super_block *sb, int flag)
 	 *
 	 * memset(tblk, 0, sizeof(struct tblock));
 	 */
+	spin_lock_irq(&log->gclock);
 	tblk->next = tblk->last = tblk->xflag = tblk->flag = tblk->lsn = 0;
+	spin_unlock_irq(&log->gclock);
 
 	tblk->sb = sb;
 	++log->logtid;
-- 
2.17.1

