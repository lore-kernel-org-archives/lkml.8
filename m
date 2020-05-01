Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887E0C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CEC82166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339627;
	bh=9Q2IOMdHquNMhWFmuNNMTvTXMfG9dO1N8X6bkgWoKM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QY+hEZmtSEWBPQbEZe26qq1AILucB6QR9a1kBLrT/FlPLv5Gc2V+5kUssDyPT+y75
	 gNKb9K3ifGUqndxaGIyzwlZIswaqjjgp2jep2nS4pQC7Bu+PrhTc0lsHIxo2oNNl+z
	 wyJHCLZiPhzYPRhXbDD0Wz9fLejf+BM1DHjhJLII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgEAN1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbgEAN1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:27:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83412166E;
        Fri,  1 May 2020 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339623;
        bh=9Q2IOMdHquNMhWFmuNNMTvTXMfG9dO1N8X6bkgWoKM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRRGV7Aax0Ks2bmT587PqyKkiDi2QkZrP3Zjl4kLGZmO8yZuhiO2dXnyR8JoVOIBJ
         SU727Yg0nzzuVsfhldQ8QhXVQpLyMdejutXktSnHeZUl22gZspjxnK7FV8CJxTtIuj
         +9b5HhXuFQfXzEcxR1np8MRz8KduauNCFnidMk1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 64/70] ext4: convert BUG_ONs to WARN_ONs in mballoc.c
Date:   Fri,  1 May 2020 15:21:52 +0200
Message-Id: <20200501131532.152971895@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.302599262@linuxfoundation.org>
References: <20200501131513.302599262@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 907ea529fc4c3296701d2bfc8b831dd2a8121a34 ]

If the in-core buddy bitmap gets corrupted (or out of sync with the
block bitmap), issue a WARN_ON and try to recover.  In most cases this
involves skipping trying to allocate out of a particular block group.
We can end up declaring the file system corrupted, which is fair,
since the file system probably should be checked before we proceed any
further.

Link: https://lore.kernel.org/r/20200414035649.293164-1-tytso@mit.edu
Google-Bug-Id: 34811296
Google-Bug-Id: 34639169
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index fda49f4c5a8eb..04fab14e630c1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1944,7 +1944,8 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 	int free;
 
 	free = e4b->bd_info->bb_free;
-	BUG_ON(free <= 0);
+	if (WARN_ON(free <= 0))
+		return;
 
 	i = e4b->bd_info->bb_first_free;
 
@@ -1965,7 +1966,8 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 		}
 
 		mb_find_extent(e4b, i, ac->ac_g_ex.fe_len, &ex);
-		BUG_ON(ex.fe_len <= 0);
+		if (WARN_ON(ex.fe_len <= 0))
+			break;
 		if (free < ex.fe_len) {
 			ext4_grp_locked_error(sb, e4b->bd_group, 0, 0,
 					"%d free clusters as per "
-- 
2.20.1



