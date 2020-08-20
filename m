Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55647C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251AC20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925917;
	bh=nJMVz16Z//JCjia4/16HUl7e5sIkoC/e/9LkHub4gic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gnrOATMGJ61GGftvkQUU2dRFFKh0GFucNbQlR64U78sr2v6qXfc4Tdn/gk9jk7sNV
	 u0ohj3s9/soYB3AQBMyqKOikMPifLutrcljfLda+2XnQNjXvKInxnHCZhCGuMixKef
	 BQEhqVyhA91/0/eJR9aCbo/Hv570r1MX/SPBKtjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgHTJ4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730230AbgHTJz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:55:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D8FD2078D;
        Thu, 20 Aug 2020 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917356;
        bh=nJMVz16Z//JCjia4/16HUl7e5sIkoC/e/9LkHub4gic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKUahjyCM1bXgTWzuXKTuXhns3AiHZPD9XlQRPemFO9xQexHSN4UbHOigEsQ2LGwF
         eQ28hUNob3m+QZjqnH3Clnh3vTSYr8h7dsfZvCjv4KsszpnxWV5ocIan1ydOBKnpg5
         CUus+U9Ol2YCFdjtK0xfF27dk9QcAkY81hZxRe/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 81/92] fs/ufs: avoid potential u32 multiplication overflow
Date:   Thu, 20 Aug 2020 11:22:06 +0200
Message-Id: <20200820091541.867416468@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 88b2e9b06381551b707d980627ad0591191f7a2d ]

The 64 bit ino is being compared to the product of two u32 values,
however, the multiplication is being performed using a 32 bit multiply so
there is a potential of an overflow.  To be fully safe, cast uspi->s_ncg
to a u64 to ensure a 64 bit multiplication occurs to avoid any chance of
overflow.

Fixes: f3e2a520f5fb ("ufs: NFS support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Evgeniy Dushistov <dushistov@mail.ru>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Link: http://lkml.kernel.org/r/20200715170355.1081713-1-colin.king@canonical.com
Addresses-Coverity: ("Unintentional integer overflow")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ufs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index a4e07e910f1b4..6e59e45d7bfbd 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -100,7 +100,7 @@ static struct inode *ufs_nfs_get_inode(struct super_block *sb, u64 ino, u32 gene
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	struct inode *inode;
 
-	if (ino < UFS_ROOTINO || ino > uspi->s_ncg * uspi->s_ipg)
+	if (ino < UFS_ROOTINO || ino > (u64)uspi->s_ncg * uspi->s_ipg)
 		return ERR_PTR(-ESTALE);
 
 	inode = ufs_iget(sb, ino);
-- 
2.25.1



