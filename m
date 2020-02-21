Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46E6C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A164F2467D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273459;
	bh=LbvWt1qaaoHgw126FlvXqbzf1tcad1g/Bm2OGES6oUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h9C6Y/ekSJ0hf+JayFpLnd8kfL/NoqbGUgVKkksujK/CvfLIAFpCNReTp4FPUzYpW
	 0CJWwNVk4vIj/WAkWqhyf77F8zvDyM8040v2mhkvXvobNcAYAJoogBEfRJ3pMXIO/h
	 bpqI3Ka7fYueo3m42YUYXtd4A/ie8/lGSQwdMj+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbgBUIYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388619AbgBUIYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:24:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 206CE24697;
        Fri, 21 Feb 2020 08:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273455;
        bh=LbvWt1qaaoHgw126FlvXqbzf1tcad1g/Bm2OGES6oUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1tSOerqogqXtbQADK3FPGOMrPnhHLcZkmvNZrmfz1tztX1TcuhcFiU44777cKekrz
         2EcUvqU6zHRpWpYBCoVJZnejYTkkAXAlP3We8RI+W8dlyYINtAPJtZVtT0GkstXgg3
         rEQnn6+G97MjenflpgXMeWyEhkRF2GuFvpnfxiIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunfeng Ye <yeyunfeng@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Feilong Lin <linfeilong@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 178/191] reiserfs: prevent NULL pointer dereference in reiserfs_insert_item()
Date:   Fri, 21 Feb 2020 08:42:31 +0100
Message-Id: <20200221072312.206296832@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

[ Upstream commit aacee5446a2a1aa35d0a49dab289552578657fb4 ]

The variable inode may be NULL in reiserfs_insert_item(), but there is
no check before accessing the member of inode.

Fix this by adding NULL pointer check before calling reiserfs_debug().

Link: http://lkml.kernel.org/r/79c5135d-ff25-1cc9-4e99-9f572b88cc00@huawei.com
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: zhengbin <zhengbin13@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/reiserfs/stree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 0037aea97d39a..2946713cb00d6 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -2250,7 +2250,8 @@ error_out:
 	/* also releases the path */
 	unfix_nodes(&s_ins_balance);
 #ifdef REISERQUOTA_DEBUG
-	reiserfs_debug(th->t_super, REISERFS_DEBUG_CODE,
+	if (inode)
+		reiserfs_debug(th->t_super, REISERFS_DEBUG_CODE,
 		       "reiserquota insert_item(): freeing %u id=%u type=%c",
 		       quota_bytes, inode->i_uid, head2type(ih));
 #endif
-- 
2.20.1



