Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B993DC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF0520768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgF3ElL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgF3ElJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:41:09 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A7DC03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:41:09 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq84y-002aAv-CO; Tue, 30 Jun 2020 04:41:08 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 2/7] take fdpic-related parts of elf_prstatus out
Date:   Tue, 30 Jun 2020 05:41:03 +0100
Message-Id: <20200630044108.615673-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200630044108.615673-1-viro@ZenIV.linux.org.uk>
References: <20200630043641.GD2786714@ZenIV.linux.org.uk>
 <20200630044108.615673-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

The only architecture where we might end up using both is arm,
and there we definitely don't want fdpic-related fields in
elf_prstatus - coredump layout of ELF binaries should not
depend upon having the kernel built with the support of ELF_FDPIC
ones.  Just move the fdpic-modified variant into binfmt_elf_fdpic.c
(and call it elf_prstatus_fdpic there)

[name stolen from nico]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf_fdpic.c          | 32 +++++++++++++++++++++++++++++---
 include/linux/elfcore-compat.h |  4 ----
 include/linux/elfcore.h        | 10 ----------
 3 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 0f45521b237c..6e13d8bea32d 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1189,6 +1189,32 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
  */
 #ifdef CONFIG_ELF_CORE
 
+struct elf_prstatus_fdpic
+{
+	struct elf_siginfo pr_info;	/* Info associated with signal */
+	short	pr_cursig;		/* Current signal */
+	unsigned long pr_sigpend;	/* Set of pending signals */
+	unsigned long pr_sighold;	/* Set of held signals */
+	pid_t	pr_pid;
+	pid_t	pr_ppid;
+	pid_t	pr_pgrp;
+	pid_t	pr_sid;
+	struct __kernel_old_timeval pr_utime;	/* User time */
+	struct __kernel_old_timeval pr_stime;	/* System time */
+	struct __kernel_old_timeval pr_cutime;	/* Cumulative user time */
+	struct __kernel_old_timeval pr_cstime;	/* Cumulative system time */
+	elf_gregset_t pr_reg;	/* GP registers */
+	/* When using FDPIC, the loadmap addresses need to be communicated
+	 * to GDB in order for GDB to do the necessary relocations.  The
+	 * fields (below) used to communicate this information are placed
+	 * immediately after ``pr_reg'', so that the loadmap addresses may
+	 * be viewed as part of the register set if so desired.
+	 */
+	unsigned long pr_exec_fdpic_loadmap;
+	unsigned long pr_interp_fdpic_loadmap;
+	int pr_fpvalid;		/* True if math co-processor being used.  */
+};
+
 /*
  * Decide whether a segment is worth dumping; default is yes to be
  * sure (missing info is worse than too much; etc).
@@ -1345,7 +1371,7 @@ static inline void fill_note(struct memelfnote *note, const char *name, int type
  * fill up all the fields in prstatus from the given task struct, except
  * registers which need to be filled up separately.
  */
-static void fill_prstatus(struct elf_prstatus *prstatus,
+static void fill_prstatus(struct elf_prstatus_fdpic *prstatus,
 			  struct task_struct *p, long signr)
 {
 	prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
@@ -1428,7 +1454,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 struct elf_thread_status
 {
 	struct list_head list;
-	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
+	struct elf_prstatus_fdpic prstatus;	/* NT_PRSTATUS */
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
 	struct task_struct *thread;
 #ifdef ELF_CORE_COPY_XFPREGS
@@ -1562,7 +1588,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	loff_t offset = 0, dataoff;
 	int numnote;
 	struct memelfnote *notes = NULL;
-	struct elf_prstatus *prstatus = NULL;	/* NT_PRSTATUS */
+	struct elf_prstatus_fdpic *prstatus = NULL;	/* NT_PRSTATUS */
 	struct elf_prpsinfo *psinfo = NULL;	/* NT_PRPSINFO */
  	LIST_HEAD(thread_list);
  	struct list_head *t;
diff --git a/include/linux/elfcore-compat.h b/include/linux/elfcore-compat.h
index 7a37f4ce9fd2..10485f0c9740 100644
--- a/include/linux/elfcore-compat.h
+++ b/include/linux/elfcore-compat.h
@@ -32,10 +32,6 @@ struct compat_elf_prstatus
 	struct old_timeval32		pr_cutime;
 	struct old_timeval32		pr_cstime;
 	compat_elf_gregset_t		pr_reg;
-#ifdef CONFIG_BINFMT_ELF_FDPIC
-	compat_ulong_t			pr_exec_fdpic_loadmap;
-	compat_ulong_t			pr_interp_fdpic_loadmap;
-#endif
 	compat_int_t			pr_fpvalid;
 };
 
diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 96ab215dad2d..adb8ee89f3fd 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -44,16 +44,6 @@ struct elf_prstatus
 	struct __kernel_old_timeval pr_cutime;	/* Cumulative user time */
 	struct __kernel_old_timeval pr_cstime;	/* Cumulative system time */
 	elf_gregset_t pr_reg;	/* GP registers */
-#ifdef CONFIG_BINFMT_ELF_FDPIC
-	/* When using FDPIC, the loadmap addresses need to be communicated
-	 * to GDB in order for GDB to do the necessary relocations.  The
-	 * fields (below) used to communicate this information are placed
-	 * immediately after ``pr_reg'', so that the loadmap addresses may
-	 * be viewed as part of the register set if so desired.
-	 */
-	unsigned long pr_exec_fdpic_loadmap;
-	unsigned long pr_interp_fdpic_loadmap;
-#endif
 	int pr_fpvalid;		/* True if math co-processor being used.  */
 };
 
-- 
2.11.0

