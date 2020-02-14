Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4C2C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B045B246E4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697337;
	bh=n11QlKoKBxyutbZj/PQ2zDMnJllH2zULDMkm5Sg16Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bpil82bJ32FCx0HtaAB6o/REKviEOZMwjtRe5KBNxyQcReclQzeccjh1r8LmoqgU+
	 ox0exaFlGYSt6I68vzgFkx34NzLI4W55QDhFVKspGYYSxj/y6o2AVBUMQzTTqZJbSe
	 Lr1DWARdanKr899dt9zfzh6r0FKBaT3TDoQGfIeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405033AbgBNQWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:22:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405301AbgBNQVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:21:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A425A24743;
        Fri, 14 Feb 2020 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697262;
        bh=n11QlKoKBxyutbZj/PQ2zDMnJllH2zULDMkm5Sg16Fs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNLJtpUDGaG1xodSG3F7E4MvDjS8Jymk4DXLtdM5nsUYJvfAbuFcw/mLPYlVA6EtF
         VnBEl1XRusT1bgx1iPlIxZHSKtAlljc1acazoMxS3UNYZRhh7F53iGkB0duicQh0Jl
         qisZk4+jmxvZvGCrAaKYkGjA8w4+wBmWpmzcJ2NI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Feilong Lin <linfeilong@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, reiserfs-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 177/186] reiserfs: prevent NULL pointer dereference in reiserfs_insert_item()
Date:   Fri, 14 Feb 2020 11:17:06 -0500
Message-Id: <20200214161715.18113-177-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
@@ -2250,7 +2250,8 @@ int reiserfs_insert_item(struct reiserfs_transaction_handle *th,
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

