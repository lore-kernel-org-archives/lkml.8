Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DA9C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8118B222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703132;
	bh=C/86LdAUnf6DSfPmYMylVq8bsdHu+MbWX9X+ufmRigQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AcQcQ3T/AbLGj9DgRZYTFZdi2604hPKAraoib0ZS92E/19Y5T7XY9xHulx13RZmuz
	 ORY8EITsceI5cvZVQk7kFCiwjPtUkaYGOyX3MGpt4+pnh1L2iDQ6CfsxDPIDfGjnQW
	 sTgV0H0xY1xBEinBIpcL0D5+QXwLqPPEZHM8WbQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbgBNR6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:58:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388048AbgBNP45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A1ED2067D;
        Fri, 14 Feb 2020 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695817;
        bh=C/86LdAUnf6DSfPmYMylVq8bsdHu+MbWX9X+ufmRigQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gN2QL8mZFmg1j9O+aQ6naJYONGWRdlAaY03DxWu65qHo4eEOmLRnD+7bmfME/6ApR
         GCCN5FXQrPg2TuOAm12qTNprHmwjjwpZNaS52fLXWzoKTzQVzEjIugGJqZYLcthUbk
         2iInh6RQwkkyp3PJClmCSPm4cqdZAYZ0Xa04ZNRY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.5 374/542] f2fs: free sysfs kobject
Date:   Fri, 14 Feb 2020 10:46:06 -0500
Message-Id: <20200214154854.6746-374-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
index 70945ceb9c0ca..5963316f391a5 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -786,4 +786,5 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 	kobject_del(&sbi->s_kobj);
+	kobject_put(&sbi->s_kobj);
 }
-- 
2.20.1

