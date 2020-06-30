Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F8CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9167E207D0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgF3ElQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgF3ElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:41:10 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EF3C08C5DB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:41:10 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq84y-002aBJ-P2; Tue, 30 Jun 2020 04:41:08 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 6/7] [elf-fdpic] use elf_dump_thread_status() for the dumper thread as well
Date:   Tue, 30 Jun 2020 05:41:07 +0100
Message-Id: <20200630044108.615673-6-viro@ZenIV.linux.org.uk>
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

the only reason to have it open-coded for the first (dumper) thread is
that coredump has a couple of process-wide notes stuck right after the
first (NT_PRSTATUS) note of the first thread.  But we don't need to
make the data collection side irregular for the first thread to handle
that - it's only the logics ordering the calls of writenote() that
needs to take care of that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf_fdpic.c | 81 ++++++++++++++++++---------------------------------
 1 file changed, 28 insertions(+), 53 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index ba4f264dff3a..34c45410d587 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1482,7 +1482,8 @@ static struct elf_thread_status *elf_dump_thread_status(long signr, struct task_
 	t->num_notes++;
 	*sz += notesize(&t->notes[0]);
 
-	t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, NULL, &t->fpu);
+	t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, task_pt_regs(p),
+							   &t->fpu);
 	if (t->prstatus.pr_fpvalid) {
 		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu),
 			  &t->fpu);
@@ -1568,19 +1569,15 @@ static size_t elf_core_vma_data_size(unsigned long mm_flags)
  */
 static int elf_fdpic_core_dump(struct coredump_params *cprm)
 {
-#define	NUM_NOTES	6
 	int has_dumped = 0;
 	int segs;
 	int i;
 	struct vm_area_struct *vma;
 	struct elfhdr *elf = NULL;
 	loff_t offset = 0, dataoff;
-	int numnote;
-	struct memelfnote *notes = NULL;
-	struct elf_prstatus_fdpic *prstatus = NULL;	/* NT_PRSTATUS */
+	struct memelfnote psinfo_note, auxv_note;
 	struct elf_prpsinfo *psinfo = NULL;	/* NT_PRPSINFO */
 	struct elf_thread_status *thread_list = NULL;
-	elf_fpregset_t *fpu = NULL;
 	int thread_status_size = 0;
 	elf_addr_t *auxv;
 	struct elf_phdr *phdr4note = NULL;
@@ -1606,19 +1603,9 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	elf = kmalloc(sizeof(*elf), GFP_KERNEL);
 	if (!elf)
 		goto end_coredump;
-	prstatus = kzalloc(sizeof(*prstatus), GFP_KERNEL);
-	if (!prstatus)
-		goto end_coredump;
 	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
 	if (!psinfo)
 		goto end_coredump;
-	notes = kmalloc_array(NUM_NOTES, sizeof(struct memelfnote),
-			      GFP_KERNEL);
-	if (!notes)
-		goto end_coredump;
-	fpu = kmalloc(sizeof(*fpu), GFP_KERNEL);
-	if (!fpu)
-		goto end_coredump;
 
 	for (ct = current->mm->core_state->dumper.next;
 					ct; ct = ct->next) {
@@ -1632,8 +1619,12 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	}
 
 	/* now collect the dump for the current */
-	fill_prstatus(prstatus, current, cprm->siginfo->si_signo);
-	elf_core_copy_regs(&prstatus->pr_reg, cprm->regs);
+	tmp = elf_dump_thread_status(cprm->siginfo->si_signo,
+				     current, &thread_status_size);
+	if (!tmp)
+		goto end_coredump;
+	tmp->next = thread_list;
+	thread_list = tmp;
 
 	segs = current->mm->map_count;
 	segs += elf_core_extra_phdrs();
@@ -1655,46 +1646,28 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	 * with info from their /proc.
 	 */
 
-	fill_note(notes + 0, "CORE", NT_PRSTATUS, sizeof(*prstatus), prstatus);
 	fill_psinfo(psinfo, current->group_leader, current->mm);
-	fill_note(notes + 1, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
-
-	numnote = 2;
+	fill_note(&psinfo_note, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
+	thread_status_size += notesize(&psinfo_note);
 
 	auxv = (elf_addr_t *) current->mm->saved_auxv;
-
 	i = 0;
 	do
 		i += 2;
 	while (auxv[i - 2] != AT_NULL);
-	fill_note(&notes[numnote++], "CORE", NT_AUXV,
-		  i * sizeof(elf_addr_t), auxv);
+	fill_note(&auxv_note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
+	thread_status_size += notesize(&auxv_note);
 
-  	/* Try to dump the FPU. */
-	if ((prstatus->pr_fpvalid =
-	     elf_core_copy_task_fpregs(current, cprm->regs, fpu)))
-		fill_note(notes + numnote++,
-			  "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
-
-	offset += sizeof(*elf);				/* Elf header */
+	offset = sizeof(*elf);				/* Elf header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
 
 	/* Write notes phdr entry */
-	{
-		int sz = 0;
-
-		for (i = 0; i < numnote; i++)
-			sz += notesize(notes + i);
-
-		sz += thread_status_size;
-
-		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
-		if (!phdr4note)
-			goto end_coredump;
+	phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
+	if (!phdr4note)
+		goto end_coredump;
 
-		fill_elf_note_phdr(phdr4note, sz, offset);
-		offset += sz;
-	}
+	fill_elf_note_phdr(phdr4note, thread_status_size, offset);
+	offset += thread_status_size;
 
 	/* Page-align dumped data */
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
@@ -1747,12 +1720,18 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 		goto end_coredump;
 
  	/* write out the notes section */
-	for (i = 0; i < numnote; i++)
-		if (!writenote(notes + i, cprm))
+	if (!writenote(thread_list->notes, cprm))
+		goto end_coredump;
+	if (!writenote(&psinfo_note, cprm))
+		goto end_coredump;
+	if (!writenote(&auxv_note, cprm))
+		goto end_coredump;
+	for (i = 1; i < thread_list->num_notes; i++)
+		if (!writenote(thread_list->notes + i, cprm))
 			goto end_coredump;
 
 	/* write out the thread status notes section */
-	for (tmp = thread_list; tmp; tmp = tmp->next) {
+	for (tmp = thread_list->next; tmp; tmp = tmp->next) {
 		for (i = 0; i < tmp->num_notes; i++)
 			if (!writenote(&tmp->notes[i], cprm))
 				goto end_coredump;
@@ -1787,13 +1766,9 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	}
 	kfree(phdr4note);
 	kfree(elf);
-	kfree(prstatus);
 	kfree(psinfo);
-	kfree(notes);
-	kfree(fpu);
 	kfree(shdr4extnum);
 	return has_dumped;
-#undef NUM_NOTES
 }
 
 #endif		/* CONFIG_ELF_CORE */
-- 
2.11.0

