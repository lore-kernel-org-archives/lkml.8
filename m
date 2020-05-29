Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8ECC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D81F206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgE2X1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgE2X1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:27:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C7CC08C5CA;
        Fri, 29 May 2020 16:27:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoPL-000Bhg-Ko; Fri, 29 May 2020 23:27:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/9] binfmt_elf_fdpic: don't use __... uaccess primitives
Date:   Sat, 30 May 2020 00:27:18 +0100
Message-Id: <20200529232723.44942-3-viro@ZenIV.linux.org.uk>
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
 fs/binfmt_elf_fdpic.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 240f66663543..ab6fb117b33c 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -537,7 +537,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 		platform_len = strlen(k_platform) + 1;
 		sp -= platform_len;
 		u_platform = (char __user *) sp;
-		if (__copy_to_user(u_platform, k_platform, platform_len) != 0)
+		if (copy_to_user(u_platform, k_platform, platform_len) != 0)
 			return -EFAULT;
 	}
 
@@ -552,7 +552,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 		platform_len = strlen(k_base_platform) + 1;
 		sp -= platform_len;
 		u_base_platform = (char __user *) sp;
-		if (__copy_to_user(u_base_platform, k_base_platform, platform_len) != 0)
+		if (copy_to_user(u_base_platform, k_base_platform, platform_len) != 0)
 			return -EFAULT;
 	}
 
@@ -604,11 +604,13 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	/* put the ELF interpreter info on the stack */
 #define NEW_AUX_ENT(id, val)						\
 	do {								\
-		struct { unsigned long _id, _val; } __user *ent;	\
+		struct { unsigned long _id, _val; } __user *ent, v;	\
 									\
 		ent = (void __user *) csp;				\
-		__put_user((id), &ent[nr]._id);				\
-		__put_user((val), &ent[nr]._val);			\
+		v._id = (id);						\
+		v._val = (val);						\
+		if (copy_to_user(ent + nr, &v))				\
+			return -EFAULT;					\
 		nr++;							\
 	} while (0)
 
@@ -675,7 +677,8 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 
 	/* stack argc */
 	csp -= sizeof(unsigned long);
-	__put_user(bprm->argc, (unsigned long __user *) csp);
+	if (put_user(bprm->argc, (unsigned long __user *) csp))
+		return -EFAULT;
 
 	BUG_ON(csp != sp);
 
@@ -689,25 +692,29 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 
 	p = (char __user *) current->mm->arg_start;
 	for (loop = bprm->argc; loop > 0; loop--) {
-		__put_user((elf_caddr_t) p, argv++);
+		if (put_user((elf_caddr_t) p, argv++))
+			return -EFAULT;
 		len = strnlen_user(p, MAX_ARG_STRLEN);
 		if (!len || len > MAX_ARG_STRLEN)
 			return -EINVAL;
 		p += len;
 	}
-	__put_user(NULL, argv);
+	if (put_user(NULL, argv))
+		return -EFAULT;
 	current->mm->arg_end = (unsigned long) p;
 
 	/* fill in the envv[] array */
 	current->mm->env_start = (unsigned long) p;
 	for (loop = bprm->envc; loop > 0; loop--) {
-		__put_user((elf_caddr_t)(unsigned long) p, envp++);
+		if (put_user((elf_caddr_t)(unsigned long) p, envp++))
+			return -EFAULT;
 		len = strnlen_user(p, MAX_ARG_STRLEN);
 		if (!len || len > MAX_ARG_STRLEN)
 			return -EINVAL;
 		p += len;
 	}
-	__put_user(NULL, envp);
+	if (put_user(NULL, envp))
+		return -EFAULT;
 	current->mm->env_end = (unsigned long) p;
 
 	mm->start_stack = (unsigned long) sp;
@@ -849,8 +856,8 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 
 				tmp = phdr->p_memsz / sizeof(Elf32_Dyn);
 				dyn = (Elf32_Dyn __user *)params->dynamic_addr;
-				__get_user(d_tag, &dyn[tmp - 1].d_tag);
-				if (d_tag != 0)
+				if (get_user(d_tag, &dyn[tmp - 1].d_tag) ||
+				    d_tag != 0)
 					goto dynamic_error;
 				break;
 			}
-- 
2.11.0

