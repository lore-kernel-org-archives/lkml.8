Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4737C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB3E20C09
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgE2X1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgE2X1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:27:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586F8C08C5CB;
        Fri, 29 May 2020 16:27:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoPL-000Bhm-PJ; Fri, 29 May 2020 23:27:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/9] binfmt_flat: don't use __put_user()
Date:   Sat, 30 May 2020 00:27:19 +0100
Message-Id: <20200529232723.44942-4-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and check the return value

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_flat.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 831a2b25ba79..7b663ed5247b 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -138,35 +138,40 @@ static int create_flat_tables(struct linux_binprm *bprm, unsigned long arg_start
 	current->mm->start_stack = (unsigned long)sp & -FLAT_STACK_ALIGN;
 	sp = (unsigned long __user *)current->mm->start_stack;
 
-	__put_user(bprm->argc, sp++);
+	if (put_user(bprm->argc, sp++))
+		return -EFAULT;
 	if (IS_ENABLED(CONFIG_BINFMT_FLAT_ARGVP_ENVP_ON_STACK)) {
 		unsigned long argv, envp;
 		argv = (unsigned long)(sp + 2);
 		envp = (unsigned long)(sp + 2 + bprm->argc + 1);
-		__put_user(argv, sp++);
-		__put_user(envp, sp++);
+		if (put_user(argv, sp++) || put_user(envp, sp++))
+			return -EFAULT;
 	}
 
 	current->mm->arg_start = (unsigned long)p;
 	for (i = bprm->argc; i > 0; i--) {
-		__put_user((unsigned long)p, sp++);
+		if (put_user((unsigned long)p, sp++))
+			return -EFAULT;
 		len = strnlen_user(p, MAX_ARG_STRLEN);
 		if (!len || len > MAX_ARG_STRLEN)
 			return -EINVAL;
 		p += len;
 	}
-	__put_user(0, sp++);
+	if (put_user(0, sp++))
+		return -EFAULT;
 	current->mm->arg_end = (unsigned long)p;
 
 	current->mm->env_start = (unsigned long) p;
 	for (i = bprm->envc; i > 0; i--) {
-		__put_user((unsigned long)p, sp++);
+		if (put_user((unsigned long)p, sp++))
+			return -EFAULT;
 		len = strnlen_user(p, MAX_ARG_STRLEN);
 		if (!len || len > MAX_ARG_STRLEN)
 			return -EINVAL;
 		p += len;
 	}
-	__put_user(0, sp++);
+	if (put_user(0, sp++))
+		return -EFAULT;
 	current->mm->env_end = (unsigned long)p;
 
 	return 0;
@@ -998,7 +1003,8 @@ static int load_flat_binary(struct linux_binprm *bprm)
 			unsigned long __user *sp;
 			current->mm->start_stack -= sizeof(unsigned long);
 			sp = (unsigned long __user *)current->mm->start_stack;
-			__put_user(start_addr, sp);
+			if (put_user(start_addr, sp))
+				return -EFAULT;
 			start_addr = libinfo.lib_list[i].entry;
 		}
 	}
-- 
2.11.0

