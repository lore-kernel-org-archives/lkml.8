Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2852C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E13624694
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696991;
	bh=7jOrCJo4W6QpDHFDtZvsrVqjHYJDbtJs8AOUjYqu4cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jcHk1hiMeNsPQjgUYU/yfmeog0TyOSEf03DTfZqbQzzz+fFEBt3YrgQWq8g53rhK7
	 mUgMaUT56GFeGiEfFHOXUfw8YChSF1cDZ/ZsvBNubU6/IrN2JkCCIulI2Q3RBDTzqu
	 O2RHgLkIDnWYpMTm4MMFHszoT8lvTw9thsFulbx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392607AbgBNQQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:16:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392459AbgBNQPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:15:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E5AD246ED;
        Fri, 14 Feb 2020 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696934;
        bh=7jOrCJo4W6QpDHFDtZvsrVqjHYJDbtJs8AOUjYqu4cA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2EZVZQDrG3x4LA7/n3P3L5Lvh3jDKfS11bxQYCkjsNYdOud3GS8TjvivGsPCZTQfU
         CoFdSKx+QyCObP8pXkvu/DxyIKS4ZwZxpI3P5exO9iy2RZvN3/il0Ktk1Jl5I65yfK
         OXE+AG680JMIjoJu6G3YN06wW21Ebdtl+5uwHcZ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 179/252] f2fs: free sysfs kobject
Date:   Fri, 14 Feb 2020 11:10:34 -0500
Message-Id: <20200214161147.15842-179-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 820d366736c949ffe698d3b3fe1266a91da1766d ]

Detected kmemleak.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 98887187af4cd..b405548202d3b 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -711,4 +711,5 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 	kobject_del(&sbi->s_kobj);
+	kobject_put(&sbi->s_kobj);
 }
-- 
2.20.1

