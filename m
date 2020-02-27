Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A49FC52D2E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2DD20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811840;
	bh=fXnsoQjwnpZgRXM5im4681pzskBGblpLjTDxl2J7dKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TA3s/on/NeFlHNxtFJJ4glWKhjdryh5ghhVOnvR0q7j5WeEXp3WzCmiYLZBRmWaMF
	 TaBn1gfJbGZ0zgOTgOTzF3GLfmIPM/ytz8mp6s2BnwUWrsGtNY+OmtBPzEIGRlaU8k
	 I/O9v+6OIZ60yJtpN/ko+5x0ENbBUnxiVtxpN36Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbgB0N5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732072AbgB0N5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:57:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5615120578;
        Thu, 27 Feb 2020 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811829;
        bh=fXnsoQjwnpZgRXM5im4681pzskBGblpLjTDxl2J7dKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRKv4NJRmyxcm490qUIRffLYQ3LKGTXeOLIGoDDgjecIQjJKyVoTRxLk8W9wy8oLk
         pToZMf4FBxlbaCvNqrGoNW1moYUb591y/RLTvacFxWk2oMJOe9k6zOnsss1HzQPmPg
         oByUoK1qqPsZgqqRph8mXQ/jLA0hXpDdY99djuig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 079/237] reiserfs: Fix spurious unlock in reiserfs_fill_super() error handling
Date:   Thu, 27 Feb 2020 14:34:53 +0100
Message-Id: <20200227132302.923836145@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 4d5c1adaf893b8aa52525d2b81995e949bcb3239 ]

When we fail to allocate string for journal device name we jump to
'error' label which tries to unlock reiserfs write lock which is not
held. Jump to 'error_unlocked' instead.

Fixes: f32485be8397 ("reiserfs: delay reiserfs lock until journal initialization")
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/reiserfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 5208d85dd30c5..9caf3948417c0 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1954,7 +1954,7 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
 		if (!sbi->s_jdev) {
 			SWARN(silent, s, "", "Cannot allocate memory for "
 				"journal device name");
-			goto error;
+			goto error_unlocked;
 		}
 	}
 #ifdef CONFIG_QUOTA
-- 
2.20.1



