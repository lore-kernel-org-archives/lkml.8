Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D73DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3DD20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgF3ElM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgF3ElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:41:10 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4619C03E97A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:41:09 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq84y-002aB1-HN; Tue, 30 Jun 2020 04:41:08 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 3/7] kill elf_fpxregs_t
Date:   Tue, 30 Jun 2020 05:41:04 +0100
Message-Id: <20200630044108.615673-3-viro@ZenIV.linux.org.uk>
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

all uses are conditional upon ELF_CORE_COPY_XFPREGS, which has not
been defined on any architecture since 2010

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/include/asm/elf.h    |  2 --
 arch/powerpc/include/asm/elf.h |  2 --
 arch/x86/include/asm/elf.h     |  2 --
 fs/binfmt_elf.c                | 30 ------------------------------
 fs/binfmt_elf_fdpic.c          | 28 ----------------------------
 include/linux/elfcore.h        |  7 -------
 6 files changed, 71 deletions(-)

diff --git a/arch/ia64/include/asm/elf.h b/arch/ia64/include/asm/elf.h
index c70bb9c11f52..6629301a2620 100644
--- a/arch/ia64/include/asm/elf.h
+++ b/arch/ia64/include/asm/elf.h
@@ -179,8 +179,6 @@ extern void ia64_init_addr_space (void);
 #define ELF_AR_SSD_OFFSET  (56 * sizeof(elf_greg_t))
 #define ELF_AR_END_OFFSET  (57 * sizeof(elf_greg_t))
 
-typedef unsigned long elf_fpxregset_t;
-
 typedef unsigned long elf_greg_t;
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 57c229a86f08..53ed2ca40151 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -53,8 +53,6 @@ static inline void ppc_elf_core_copy_regs(elf_gregset_t elf_regs,
 }
 #define ELF_CORE_COPY_REGS(gregs, regs) ppc_elf_core_copy_regs(gregs, regs);
 
-typedef elf_vrregset_t elf_fpxregset_t;
-
 /* ELF_HWCAP yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  This could be done in userspace,
    but it's not easy, and we've already done it here.  */
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 452beed7892b..b9a5d488f1a5 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -21,8 +21,6 @@ typedef struct user_i387_struct elf_fpregset_t;
 
 #ifdef __i386__
 
-typedef struct user_fxsr_struct elf_fpxregset_t;
-
 #define R_386_NONE	0
 #define R_386_32	1
 #define R_386_PC32	2
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 80743b8957c9..6a171a28bdf7 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2038,9 +2038,6 @@ struct elf_thread_status
 	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
 	struct task_struct *thread;
-#ifdef ELF_CORE_COPY_XFPREGS
-	elf_fpxregset_t xfpu;		/* ELF_CORE_XFPREG_TYPE */
-#endif
 	struct memelfnote notes[3];
 	int num_notes;
 };
@@ -2071,15 +2068,6 @@ static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 		t->num_notes++;
 		sz += notesize(&t->notes[1]);
 	}
-
-#ifdef ELF_CORE_COPY_XFPREGS
-	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
-		fill_note(&t->notes[2], "LINUX", ELF_CORE_XFPREG_TYPE,
-			  sizeof(t->xfpu), &t->xfpu);
-		t->num_notes++;
-		sz += notesize(&t->notes[2]);
-	}
-#endif	
 	return sz;
 }
 
@@ -2090,9 +2078,6 @@ struct elf_note_info {
 	struct elf_prpsinfo *psinfo;	/* NT_PRPSINFO */
 	struct list_head thread_list;
 	elf_fpregset_t *fpu;
-#ifdef ELF_CORE_COPY_XFPREGS
-	elf_fpxregset_t *xfpu;
-#endif
 	user_siginfo_t csigdata;
 	int thread_status_size;
 	int numnote;
@@ -2116,11 +2101,6 @@ static int elf_note_info_init(struct elf_note_info *info)
 	info->fpu = kmalloc(sizeof(*info->fpu), GFP_KERNEL);
 	if (!info->fpu)
 		return 0;
-#ifdef ELF_CORE_COPY_XFPREGS
-	info->xfpu = kmalloc(sizeof(*info->xfpu), GFP_KERNEL);
-	if (!info->xfpu)
-		return 0;
-#endif
 	return 1;
 }
 
@@ -2184,13 +2164,6 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	if (info->prstatus->pr_fpvalid)
 		fill_note(info->notes + info->numnote++,
 			  "CORE", NT_PRFPREG, sizeof(*info->fpu), info->fpu);
-#ifdef ELF_CORE_COPY_XFPREGS
-	if (elf_core_copy_task_xfpregs(current, info->xfpu))
-		fill_note(info->notes + info->numnote++,
-			  "LINUX", ELF_CORE_XFPREG_TYPE,
-			  sizeof(*info->xfpu), info->xfpu);
-#endif
-
 	return 1;
 }
 
@@ -2243,9 +2216,6 @@ static void free_note_info(struct elf_note_info *info)
 	kfree(info->psinfo);
 	kfree(info->notes);
 	kfree(info->fpu);
-#ifdef ELF_CORE_COPY_XFPREGS
-	kfree(info->xfpu);
-#endif
 }
 
 #endif
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 6e13d8bea32d..a6ee92137529 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1457,9 +1457,6 @@ struct elf_thread_status
 	struct elf_prstatus_fdpic prstatus;	/* NT_PRSTATUS */
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
 	struct task_struct *thread;
-#ifdef ELF_CORE_COPY_XFPREGS
-	elf_fpxregset_t xfpu;		/* ELF_CORE_XFPREG_TYPE */
-#endif
 	struct memelfnote notes[3];
 	int num_notes;
 };
@@ -1491,15 +1488,6 @@ static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 		t->num_notes++;
 		sz += notesize(&t->notes[1]);
 	}
-
-#ifdef ELF_CORE_COPY_XFPREGS
-	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
-		fill_note(&t->notes[2], "LINUX", ELF_CORE_XFPREG_TYPE,
-			  sizeof(t->xfpu), &t->xfpu);
-		t->num_notes++;
-		sz += notesize(&t->notes[2]);
-	}
-#endif
 	return sz;
 }
 
@@ -1593,9 +1581,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
  	LIST_HEAD(thread_list);
  	struct list_head *t;
 	elf_fpregset_t *fpu = NULL;
-#ifdef ELF_CORE_COPY_XFPREGS
-	elf_fpxregset_t *xfpu = NULL;
-#endif
 	int thread_status_size = 0;
 	elf_addr_t *auxv;
 	struct elf_phdr *phdr4note = NULL;
@@ -1634,11 +1619,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	fpu = kmalloc(sizeof(*fpu), GFP_KERNEL);
 	if (!fpu)
 		goto end_coredump;
-#ifdef ELF_CORE_COPY_XFPREGS
-	xfpu = kmalloc(sizeof(*xfpu), GFP_KERNEL);
-	if (!xfpu)
-		goto end_coredump;
-#endif
 
 	for (ct = current->mm->core_state->dumper.next;
 					ct; ct = ct->next) {
@@ -1703,11 +1683,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	     elf_core_copy_task_fpregs(current, cprm->regs, fpu)))
 		fill_note(notes + numnote++,
 			  "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
-#ifdef ELF_CORE_COPY_XFPREGS
-	if (elf_core_copy_task_xfpregs(current, xfpu))
-		fill_note(notes + numnote++,
-			  "LINUX", ELF_CORE_XFPREG_TYPE, sizeof(*xfpu), xfpu);
-#endif
 
 	offset += sizeof(*elf);				/* Elf header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
@@ -1828,9 +1803,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	kfree(notes);
 	kfree(fpu);
 	kfree(shdr4extnum);
-#ifdef ELF_CORE_COPY_XFPREGS
-	kfree(xfpu);
-#endif
 	return has_dumped;
 #undef NUM_NOTES
 }
diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index adb8ee89f3fd..46c3d691f677 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -104,13 +104,6 @@ static inline int elf_core_copy_task_fpregs(struct task_struct *t, struct pt_reg
 #endif
 }
 
-#ifdef ELF_CORE_COPY_XFPREGS
-static inline int elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregset_t *xfpu)
-{
-	return ELF_CORE_COPY_XFPREGS(t, xfpu);
-}
-#endif
-
 /*
  * These functions parameterize elf_core_dump in fs/binfmt_elf.c to write out
  * extra segments containing the gate DSO contents.  Dumping its
-- 
2.11.0

