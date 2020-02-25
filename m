Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713D9C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E60A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NrFkWA9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgBYTx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:53:26 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44219 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYTxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:53:25 -0500
Received: by mail-qt1-f195.google.com with SMTP id j23so497596qtr.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J3naM9gb9grCSaWWa+1M/iL95mfUymHnR7a3z5k6V4Q=;
        b=NrFkWA9rGIEJMWAg0A6hL55J4EEPLK8A2piMwRH3XBYsJ4Oh+ew87GSHLKENFWK93g
         DgOYBBd6XA78gFNhO1PyPeD4IbRhUbKB1mU3+zq4cqdmLTHvp77im926+EOJii1Shc7l
         K7laDUM7E5SF27us9tSPPSKaORprnM2bPq3nFYFQxj1tkCExz+Po8W453NNroEZUsfB7
         hgdSpkVWeylNW+sqclAWHcWyy8vDOAdlLcgQNLhQCQV5L9ECH0vvZBLRlJZLWbJaM8nj
         aUR3It7p2aDBeaI7sLK0SLUMtwayKS+6S+hvekwi38pTPrK/0dsfInDKSga8D2wiY/Ew
         oBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J3naM9gb9grCSaWWa+1M/iL95mfUymHnR7a3z5k6V4Q=;
        b=TpQL1lm5ih4+agGwdU1w4d/kvI4tsc4/riMWY5x8GM+uC6XSnBUP5t/FqZl+jHZ6zu
         UTL1tXEKXiPvQyJcKH6s2rK5aipn0m3xxszAm6HXyU26WPXEWd6TT179zgMAZN58ybZK
         wt7Xh7xNSAfUodEFpP4dBfhbIL2vufMH4n96sYVDA877ewFTjEjRTO+ZtYQ/uPzgtRkc
         LAKT1IUNEcye8Gp2OsfV4FqqijJFySj+MzbrXXs4sGSNGK/Kh1Rg2oQWD5BAVPbNmZ8q
         K2zoafK02U3C6AdtPFRzvAsqCxa+jTHMu7qhJQtPY8GyRTrSLKIfyJ1KjpXvzd5dqdGP
         E6uw==
X-Gm-Message-State: APjAAAWilwKFBnwI7W1dxQeIVE8QxXEs3XGr5w90GhH/GNVp4UzOkJIP
        KONjuy3c4i8bIjDVomLMZCTLwg==
X-Google-Smtp-Source: APXvYqzYUX8K2Ym17H9QdktALmz12JDdqhf3sSHdZqZh3SbaJthw84CNOXt2gx89+7gBMSuTcxESsA==
X-Received: by 2002:aed:3e6d:: with SMTP id m42mr303755qtf.187.1582660404577;
        Tue, 25 Feb 2020 11:53:24 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l6sm7981936qti.10.2020.02.25.11.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 11:53:23 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     darrick.wong@oracle.com
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] xfs: fix an undefined behaviour in _da3_path_shift
Date:   Tue, 25 Feb 2020 14:53:08 -0500
Message-Id: <1582660388-28735-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfs_da3_path_shift() could see state->path.blk[-1] because
state->path.active == 1 is a valid state when it tries to add an entry
to a single dir leaf block and then to shift forward to see if
there's a sibling block that would be a better place to put the new
entry.

 UBSAN: Undefined behaviour in fs/xfs/libxfs/xfs_da_btree.c:1989:14
 index -1 is out of range for type 'xfs_da_state_blk_t [5]'
 Call trace:
  dump_backtrace+0x0/0x2c8
  show_stack+0x20/0x2c
  dump_stack+0xe8/0x150
  __ubsan_handle_out_of_bounds+0xe4/0xfc
  xfs_da3_path_shift+0x860/0x86c [xfs]
  xfs_da3_node_lookup_int+0x7c8/0x934 [xfs]
  xfs_dir2_node_addname+0x2c8/0xcd0 [xfs]
  xfs_dir_createname+0x348/0x38c [xfs]
  xfs_create+0x6b0/0x8b4 [xfs]
  xfs_generic_create+0x12c/0x1f8 [xfs]
  xfs_vn_mknod+0x3c/0x4c [xfs]
  xfs_vn_create+0x34/0x44 [xfs]
  do_last+0xd4c/0x10c8
  path_openat+0xbc/0x2f4
  do_filp_open+0x74/0xf4
  do_sys_openat2+0x98/0x180
  __arm64_sys_openat+0xf8/0x170
  do_el0_svc+0x170/0x240
  el0_sync_handler+0x150/0x250
  el0_sync+0x164/0x180

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: update the commit log thanks to Darrick.
    simplify the code.

 fs/xfs/libxfs/xfs_da_btree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 875e04f82541..e864c3d47f60 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -1986,7 +1986,8 @@ static inline int xfs_dabuf_nfsb(struct xfs_mount *mp, int whichfork)
 	ASSERT(path != NULL);
 	ASSERT((path->active > 0) && (path->active < XFS_DA_NODE_MAXDEPTH));
 	level = (path->active-1) - 1;	/* skip bottom layer in path */
-	for (blk = &path->blk[level]; level >= 0; blk--, level--) {
+	for (; level >= 0; level--) {
+		blk = &path->blk[level];
 		xfs_da3_node_hdr_from_disk(dp->i_mount, &nodehdr,
 					   blk->bp->b_addr);
 
-- 
1.8.3.1

