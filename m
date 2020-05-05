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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D8FC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401AC20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG31h2lH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgEENyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728180AbgEENyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:54:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496A0C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:54:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so382893pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Jsy+vFKG2w3TRg1if2OaNR87RH1NyplF73zGSyvE/Rs=;
        b=TG31h2lHvlOV32idvIopV8FeDNBzrpP6uSBMRXYGBhlacTbKQbgLAB7yW1s+OghDa7
         p80TzukpfZQ19ZLwiJ1jn/Cc2p9RKJaSQ3GZW2ASGloYUa97EdTDal19QwGCIxBpE3/v
         IO3Tj3rhSHZhNqexHH0yuCvznft9zvVxjahrk6LxQP40yD3aUb8+Q6lrtsuHRVA4WpEQ
         muyOvYHbwJ79uQ+jg29fNECEFPVytJ7vHf8kSB7CuV88f1wTVmu52Wy7WBmzVi3RS2Pf
         na4soy+wKmWzasJfamrOzFvXquCB06vSUxanrnN8dPRrjsSZMa3lLJeC43Y6aPx8TlEO
         4rGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jsy+vFKG2w3TRg1if2OaNR87RH1NyplF73zGSyvE/Rs=;
        b=RpLzfrMBUZfJL2R0aHFLigU1g3HGavyh0XfdicmKmaFzG/na8DXFyGp448wN7hcCxQ
         cOkvucMFrl8m2/t8kbYG1XwoCa0YP1rNdABHfne4uTG7uUSYjg78+PrtRu8wJZDaX6yb
         aCPNDfNMQH3DY1baBTe/afs6VE+KFIiasSh+QSbr2U0hyTfjN8i3zsjVniBgW/ZeKw0k
         UNVn2tN4P0NlHG12TGBSLuLw7W5AVMSCdNhtmeXs3/VVEPkcsub7cj7+YBKI2Urn+bDz
         AUwFU+7douv5OIASNYsEhPPZqmI7EHAaCRVrgcKmLMbwuAMlPhLGeHEFRWimrAHW+rgn
         QW9A==
X-Gm-Message-State: AGi0PubJY6ba30Pu/fBhn2xgQpXiizKnbcJhvRcXOnlYpofcVgWF+CpH
        wbrHqlOWGndlVP6gNwVEW1Y=
X-Google-Smtp-Source: APiQypLIecyv9059S8Yp0y1IaUmW33KUj4UfKa5RG+HrzaPRGW5IduBDk4rIUOfkF4z5zf1tD2P0cQ==
X-Received: by 2002:a17:90a:f302:: with SMTP id ca2mr895545pjb.223.1588686882864;
        Tue, 05 May 2020 06:54:42 -0700 (PDT)
Received: from localhost.localdomain ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id m63sm2221920pfb.101.2020.05.05.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 06:54:42 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     shaggy@kernel.org, Markus.Elfring@web.de
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] fs: jfs: fix a possible data race in txBegin()
Date:   Tue,  5 May 2020 21:54:11 +0800
Message-Id: <20200505135411.28893-1-baijiaju1990@gmail.com>
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

