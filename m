Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F42C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C11C206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgE2X1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgE2X1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:27:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059D5C08C5C9;
        Fri, 29 May 2020 16:27:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoPL-000Bha-HJ; Fri, 29 May 2020 23:27:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] binfmt_elf: don't bother with __{put,copy_to}_user()
Date:   Sat, 30 May 2020 00:27:17 +0100
Message-Id: <20200529232723.44942-2-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13f25e241ac4..782d218c3bb9 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -202,7 +202,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 		size_t len = strlen(k_platform) + 1;
 
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
-		if (__copy_to_user(u_platform, k_platform, len))
+		if (copy_to_user(u_platform, k_platform, len))
 			return -EFAULT;
 	}
 
@@ -215,7 +215,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 		size_t len = strlen(k_base_platform) + 1;
 
 		u_base_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
-		if (__copy_to_user(u_base_platform, k_base_platform, len))
+		if (copy_to_user(u_base_platform, k_base_platform, len))
 			return -EFAULT;
 	}
 
@@ -225,7 +225,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	get_random_bytes(k_rand_bytes, sizeof(k_rand_bytes));
 	u_rand_bytes = (elf_addr_t __user *)
 		       STACK_ALLOC(p, sizeof(k_rand_bytes));
-	if (__copy_to_user(u_rand_bytes, k_rand_bytes, sizeof(k_rand_bytes)))
+	if (copy_to_user(u_rand_bytes, k_rand_bytes, sizeof(k_rand_bytes)))
 		return -EFAULT;
 
 	/* Create the ELF interpreter info */
@@ -308,14 +308,14 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 		return -EFAULT;
 
 	/* Now, let's put argc (and argv, envp if appropriate) on the stack */
-	if (__put_user(argc, sp++))
+	if (put_user(argc, sp++))
 		return -EFAULT;
 
 	/* Populate list of argv pointers back to argv strings. */
 	p = mm->arg_end = mm->arg_start;
 	while (argc-- > 0) {
 		size_t len;
-		if (__put_user((elf_addr_t)p, sp++))
+		if (put_user((elf_addr_t)p, sp++))
 			return -EFAULT;
 		len = strnlen_user((void __user *)p, MAX_ARG_STRLEN);
 		if (!len || len > MAX_ARG_STRLEN)
@@ -330,14 +330,14 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	mm->env_end = mm->env_start = p;
 	while (envc-- > 0) {
 		size_t len;
-		if (__put_user((elf_addr_t)p, sp++))
+		if (put_user((elf_addr_t)p, sp++))
 			return -EFAULT;
 		len = strnlen_user((void __user *)p, MAX_ARG_STRLEN);
 		if (!len || len > MAX_ARG_STRLEN)
 			return -EINVAL;
 		p += len;
 	}
-	if (__put_user(0, sp++))
+	if (put_user(0, sp++))
 		return -EFAULT;
 	mm->env_end = p;
 
-- 
2.11.0

