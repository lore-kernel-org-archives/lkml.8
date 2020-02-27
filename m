Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3307C52D34
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AB420801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811857;
	bh=ktw/8vWmhlyri67P+/GtRvdmnVuBAzKZu4c6pyxsfdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rhL4VIDYzTzaHihfFAr29262eHf4Uqb+U6AHxPqU525EpUJTzcdsnIbyi5rPg6Wwh
	 21eVt5ZctooP1xcmjS+rQDG+oMBNTlRIIIbvkKyk0MqZDYicB5KzZLDrhJjCyBRRV0
	 MFIi/3fCf7X4BB7+tJ8xJNBgpV/Y4z7m3HwBqzKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbgB0N5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:57:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732284AbgB0N5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:57:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8821C2084E;
        Thu, 27 Feb 2020 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811850;
        bh=ktw/8vWmhlyri67P+/GtRvdmnVuBAzKZu4c6pyxsfdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cI4tmnM0JpLyjqKK9IhtY6AeUrcGICnHa2oOnoUvlAaD5tfSP2hgqv3++UZgfRX05
         K0fQcUhkwNQAPqnLbsCNqAw7eIyQDPS5UETMGclG12c94PZYTEw2lI19ntgE6ABJZg
         IwJArZ/ovMVzC3yAu1JGpsoOBr8SpUtjlrqkvheE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 126/237] f2fs: fix memleak of kobject
Date:   Thu, 27 Feb 2020 14:35:40 +0100
Message-Id: <20200227132306.038266556@linuxfoundation.org>
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

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit fe396ad8e7526f059f7b8c7290d33a1b84adacab ]

If kobject_init_and_add() failed, caller needs to invoke kobject_put()
to release kobject explicitly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 79e45e760c20b..a55919eec0351 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -507,10 +507,12 @@ int __init f2fs_init_sysfs(void)
 
 	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
 				   NULL, "features");
-	if (ret)
+	if (ret) {
+		kobject_put(&f2fs_feat);
 		kset_unregister(&f2fs_kset);
-	else
+	} else {
 		f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
+	}
 	return ret;
 }
 
@@ -531,8 +533,11 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 	init_completion(&sbi->s_kobj_unregister);
 	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_sb_ktype, NULL,
 				"%s", sb->s_id);
-	if (err)
+	if (err) {
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
 		return err;
+	}
 
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
-- 
2.20.1



