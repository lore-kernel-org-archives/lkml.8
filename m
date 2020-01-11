Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B473C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039222072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736479;
	bh=CW+8YHjb911IXQD++FpPnPErWmULIcsG8GPVMa5/gdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R3orZLKVreYj3LQOjavLYZ5ecpXCN9bjBubkxZ18sAwgV6b7/hVVVirmerVDQH5+O
	 j8SqJxoPH63a6c33I7uNa2G5YkZSt373/RBLmKHe1VSrcQyq8p2f34H36yKruAryyt
	 UIZCbE2NnjpYLHjRuagfSkgjbdtaGQBz+qwNwgkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgAKJyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbgAKJyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:54:36 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 032512072E;
        Sat, 11 Jan 2020 09:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736475;
        bh=CW+8YHjb911IXQD++FpPnPErWmULIcsG8GPVMa5/gdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5sstdRlfieUO8ZDKO2qRW7vYOAk6Xtu/wDMZFAwJms5iCvhYvZAlAmRIP5qbTn6L
         vSh7e5uiNATKVf/3ZLh/Tp2mlCy7UkyHFN0+g1JZEH5g6tYjrMmm9Vw41NtEUcEcFy
         /0MnyIxpLWX4vJ9njkYKSsedYm6I2OAYfAXhYGDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c732f8644185de340492@syzkaller.appspotmail.com,
        Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 12/59] xfs: fix mount failure crash on invalid iclog memory access
Date:   Sat, 11 Jan 2020 10:49:21 +0100
Message-Id: <20200111094840.323120975@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094835.417654274@linuxfoundation.org>
References: <20200111094835.417654274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit 798a9cada4694ca8d970259f216cec47e675bfd5 ]

syzbot (via KASAN) reports a use-after-free in the error path of
xlog_alloc_log(). Specifically, the iclog freeing loop doesn't
handle the case of a fully initialized ->l_iclog linked list.
Instead, it assumes that the list is partially constructed and NULL
terminated.

This bug manifested because there was no possible error scenario
after iclog list setup when the original code was added.  Subsequent
code and associated error conditions were added some time later,
while the original error handling code was never updated. Fix up the
error loop to terminate either on a NULL iclog or reaching the end
of the list.

Reported-by: syzbot+c732f8644185de340492@syzkaller.appspotmail.com
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 73b725f965eb..065aa4752607 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1503,6 +1503,8 @@ xlog_alloc_log(
 		if (iclog->ic_bp)
 			xfs_buf_free(iclog->ic_bp);
 		kmem_free(iclog);
+		if (prev_iclog == log->l_iclog)
+			break;
 	}
 	spinlock_destroy(&log->l_icloglock);
 	xfs_buf_free(log->l_xbuf);
-- 
2.20.1



