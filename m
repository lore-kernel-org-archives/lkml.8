Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440CFC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1380220732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586951546;
	bh=S8e/GIX3a0av0GNvocPZ8HDY4CwjlUxg8Z81u6oyVek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lIbjWyosjNpIb0N9Ia6Jx/ci/O9zQ64yOt+AhsflrE99Zw+LOZDcsbug80RoaOUAs
	 bspqsCOd1r94QccWcavXJ0WIKewd0DzIyA9vPCvMgjAUoNQ63lytVKRNwQBp1J3skJ
	 Yb+BAgJ+CQbEJ1ju5xPsO7vrBjs8X/miYWu4MiCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897758AbgDOLwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409072AbgDOLoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:44:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF8721569;
        Wed, 15 Apr 2020 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951060;
        bh=S8e/GIX3a0av0GNvocPZ8HDY4CwjlUxg8Z81u6oyVek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEv+3XyX5r5hHn0DCFqh0g311mq3jrH64MCInWPkgBxS1AWADCvIh1ktP6L49QcQA
         W+CiRg+fvOFDIDxSk/43y/VYKtRmdBHWy+/D8xxfDoW1p+1djYlt94IEHb+ZtW/s9P
         TifP08EejsnmSz/OOAXHff5dd7S5YbxnTQxKBkM8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.5 093/106] f2fs: skip GC when section is full
Date:   Wed, 15 Apr 2020 07:42:13 -0400
Message-Id: <20200415114226.13103-93-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 2bac07635ddf9ed59268e61e415d8de9c5eaded7 ]

This fixes skipping GC when segment is full in large section.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 47d4c343cec6d..66131e27910cc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1018,8 +1018,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		 * race condition along with SSR block allocation.
 		 */
 		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
-				get_valid_blocks(sbi, segno, false) ==
-							sbi->blocks_per_seg)
+				get_valid_blocks(sbi, segno, true) ==
+							BLKS_PER_SEC(sbi))
 			return submitted;
 
 		if (check_valid_map(sbi, segno, off) == 0)
-- 
2.20.1

