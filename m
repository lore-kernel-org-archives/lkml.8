Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B002C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90B820768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgF3ElN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgF3ElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:41:10 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C8AC03E97E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:41:09 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq84y-002aBD-Mr; Tue, 30 Jun 2020 04:41:08 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 5/7] [elf-fdpic] move allocation of elf_thread_status into elf_dump_thread_status()
Date:   Tue, 30 Jun 2020 05:41:06 +0100
Message-Id: <20200630044108.615673-5-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf_fdpic.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index bcbf756fba39..ba4f264dff3a 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1466,12 +1466,13 @@ struct elf_thread_status
  * we need to keep a linked list of every thread's pr_status and then create
  * a single section for them in the final core file.
  */
-static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
+static struct elf_thread_status *elf_dump_thread_status(long signr, struct task_struct *p, int *sz)
 {
-	struct task_struct *p = t->thread;
-	int sz = 0;
+	struct elf_thread_status *t;
 
-	t->num_notes = 0;
+	t = kzalloc(sizeof(struct elf_thread_status), GFP_KERNEL);
+	if (!t)
+		return t;
 
 	fill_prstatus(&t->prstatus, p, signr);
 	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
@@ -1479,16 +1480,16 @@ static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
 		  &t->prstatus);
 	t->num_notes++;
-	sz += notesize(&t->notes[0]);
+	*sz += notesize(&t->notes[0]);
 
 	t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, NULL, &t->fpu);
 	if (t->prstatus.pr_fpvalid) {
 		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu),
 			  &t->fpu);
 		t->num_notes++;
-		sz += notesize(&t->notes[1]);
+		*sz += notesize(&t->notes[1]);
 	}
-	return sz;
+	return t;
 }
 
 static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
@@ -1621,20 +1622,15 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 
 	for (ct = current->mm->core_state->dumper.next;
 					ct; ct = ct->next) {
-		tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+		tmp = elf_dump_thread_status(cprm->siginfo->si_signo,
+					     ct->task, &thread_status_size);
 		if (!tmp)
 			goto end_coredump;
 
-		tmp->thread = ct->task;
 		tmp->next = thread_list;
 		thread_list = tmp;
 	}
 
-	for (tmp = thread_list; tmp; tmp = tmp->next) {
-		int sz = elf_dump_thread_status(cprm->siginfo->si_signo, tmp);
-		thread_status_size += sz;
-	}
-
 	/* now collect the dump for the current */
 	fill_prstatus(prstatus, current, cprm->siginfo->si_signo);
 	elf_core_copy_regs(&prstatus->pr_reg, cprm->regs);
-- 
2.11.0

