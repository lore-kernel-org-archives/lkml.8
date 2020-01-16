Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA2C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2026E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195257;
	bh=Dchs2EqVYdJsdEgoX97yXl188+xMjt+VAEmu8C8Vbm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tak76GMy9FnRpQS8BLZ0yDDOsPUqEYP/KZSHcHEEgcvhVFU3hLnsmVMLh/y9VhdSJ
	 dqae/pNE1ND3xwVEgbFw5BHvcy+P2pcDv0YY8Bevm314VHlno6bQr+0qjtiLtsbeVY
	 w408/iJKYkZ7m37gcn9pFIKgs7h5HQb6VzSHBY5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391301AbgAPRRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391184AbgAPRRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:17:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE98D2051A;
        Thu, 16 Jan 2020 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195063;
        bh=Dchs2EqVYdJsdEgoX97yXl188+xMjt+VAEmu8C8Vbm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zdmmxYmW4Mv2h8dym+izOPWPoeBi9h3CX9RM+bhtY51yasRZ7bblpa5zhix1Y7t6C
         f5Sqa3M7ZaptBtp2ZPbN9+3UeyWBb3zVFa70YPMcGqPmEasmVyaBHuNhOK4GhxPovF
         t2O/wj/CC5NuJ+5ed8gZoXrC8W10+yi73fA6SMBk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 018/371] exportfs: fix 'passing zero to ERR_PTR()' warning
Date:   Thu, 16 Jan 2020 12:11:26 -0500
Message-Id: <20200116171719.16965-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116171719.16965-1-sashal@kernel.org>
References: <20200116171719.16965-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 909e22e05353a783c526829427e9a8de122fba9c ]

Fix a static code checker warning:
  fs/exportfs/expfs.c:171 reconnect_one() warn: passing zero to 'ERR_PTR'

The error path for lookup_one_len_unlocked failure
should set err to PTR_ERR.

Fixes: bbf7a8a3562f ("exportfs: move most of reconnect_path to helper function")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exportfs/expfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index a561ae17cf43..c08960040dd0 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -147,6 +147,7 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
 	tmp = lookup_one_len_unlocked(nbuf, parent, strlen(nbuf));
 	if (IS_ERR(tmp)) {
 		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
+		err = PTR_ERR(tmp);
 		goto out_err;
 	}
 	if (tmp != dentry) {
-- 
2.20.1

