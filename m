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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B39C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA59206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBavfMWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgEEOvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729183AbgEEOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:51:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262CBC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:51:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so912381pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gqMtkzsSoPZBMMdRPapCy9u7s4SBqp2jU6yXsz651xs=;
        b=sBavfMWdGoIANOSSLVXfXxC83qThaa0PpqS7Gu0n+50OKtn9f0tzizOmIqG2aTxtZ2
         xp3HubkEHyBYGfLwk9sdggL6flPiZUZvKKQwy8GsCM8yTZ7LaNtDSwpxZpNzwSNfv6u0
         H1Pio9FUQcYG/lkYk30Ywst5VEoF6G/Zt5DsgQxlGCZJevYunPeUUrixpsa1Sf8j6TQB
         H2ruHWKzH0i8PhmCWp67lXb1UO+erKSBQAj5FlgOew7zF2kHf5BvBQzv0TmlWGewcqFq
         Js+WWOGfBGVCGQTcfvhaZoqleU+outnnSDhigFJ1WXwhQCEvUdpPv4rpIH/3QZzcOH2G
         IcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gqMtkzsSoPZBMMdRPapCy9u7s4SBqp2jU6yXsz651xs=;
        b=LPHN+9ldeoTlk+Mcw7H0VbbBVHGhQ0Mpec+/HWRTZ4IS+ZeM7kq459B7rwvLMPq3fC
         ODC6yGoHMFV2ugiN7yrQ+S996SaxCvApZRpN2stWU6CYVsTO1c/OE5em3vNFxx1pZmMW
         Zmsh+j/axTedaJAZZTmyc/e1Z5/iHtjx0UhpA+ZPReXILky+YXhgNMFFC5lKYqHJ4+TZ
         21TswNNV1y8ddp3ZTPXWWz9/NI2PPCBTO52j6+6p7cxlgLC0FbY1lMZzVamyA1jpCrSV
         26AwEOSwM+OFCU5KxLxaMrDLEKHoMYbOxjyzwbgxcMAj0NCs52ER9noieHIzULZfV6zq
         3ZLw==
X-Gm-Message-State: AGi0PuYGM1brGjGkMNo40FVXH1/UuL58FvQ4P0cQNlW3obulVfmmghs4
        fpCvjyP0BFieqLR9NLbXxaI=
X-Google-Smtp-Source: APiQypLFBmQScYPm9uhGYX3oNnygObD/e41/YA0FYVhWFChPNj/bANXZeqfILu/X9kZs1suM8o1NIQ==
X-Received: by 2002:a17:90b:93:: with SMTP id bb19mr3545245pjb.134.1588690259719;
        Tue, 05 May 2020 07:50:59 -0700 (PDT)
Received: from localhost.localdomain ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id l16sm1727711pgh.35.2020.05.05.07.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 07:50:58 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     shaggy@kernel.org, Markus.Elfring@web.de
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] fs: jfs: fix a possible data race in txBegin()
Date:   Tue,  5 May 2020 22:50:13 +0800
Message-Id: <20200505145013.8040-1-baijiaju1990@gmail.com>
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

A data race can occur for the data structure member "flag". 
This data race was found by our concurrency fuzzer.

Thus use the spin lock "gclock" for the resetting of five 
data structure members in this function implementation.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Change the description.
  Thank Markus Elfring for good advice.

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

