Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A47DC35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A1E206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273437;
	bh=7jOrCJo4W6QpDHFDtZvsrVqjHYJDbtJs8AOUjYqu4cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2VtrJU276Uvwlxgh2eFmUmEn1K0wGeVy2FVGKgjX5ikMtS4XPnleAsELqh4gWKqqp
	 EkNkcxNudpYvPOfhI7tk4TwdoZVnpgXokGGH1JHqAXplIIEkrIvWklV08cs053kvbS
	 sxM85S+wVEkuSDXgPnKVsopL4XdGelJ/UaphkFVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbgBUIXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388561AbgBUIXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:23:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 337C2206ED;
        Fri, 21 Feb 2020 08:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273431;
        bh=7jOrCJo4W6QpDHFDtZvsrVqjHYJDbtJs8AOUjYqu4cA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kx1iBRo5D7aNUdfy1886FetKm5wt9VKcIMlhBvBwjoZojAV8l4yC57loyWcLjsKm+
         MMES5YPGjw0lVqrkDDVxPdt6J8ilBFTbPad+UTJzvoRD0FO5rxhFNP6+xlcwtfUiJM
         8Ot/0U43kUIgdWlqgcIfeImEXY7+xwnHcfPo9RzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 132/191] f2fs: free sysfs kobject
Date:   Fri, 21 Feb 2020 08:41:45 +0100
Message-Id: <20200221072306.672796842@linuxfoundation.org>
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



