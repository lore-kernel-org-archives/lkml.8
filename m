Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1B0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05428207D0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgF3Elc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgF3ElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:41:10 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5823C03E97B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:41:09 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq84y-002aB7-K2; Tue, 30 Jun 2020 04:41:08 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 4/7] [elf-fdpic] coredump: don't bother with cyclic list for per-thread objects
Date:   Tue, 30 Jun 2020 05:41:05 +0100
Message-Id: <20200630044108.615673-4-viro@ZenIV.linux.org.uk>
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

plain single-linked list is just fine here...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf_fdpic.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index a6ee92137529..bcbf756fba39 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1453,7 +1453,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 /* Here is the structure in which status of each thread is captured. */
 struct elf_thread_status
 {
-	struct list_head list;
+	struct elf_thread_status *next;
 	struct elf_prstatus_fdpic prstatus;	/* NT_PRSTATUS */
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
 	struct task_struct *thread;
@@ -1578,8 +1578,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	struct memelfnote *notes = NULL;
 	struct elf_prstatus_fdpic *prstatus = NULL;	/* NT_PRSTATUS */
 	struct elf_prpsinfo *psinfo = NULL;	/* NT_PRPSINFO */
- 	LIST_HEAD(thread_list);
- 	struct list_head *t;
+	struct elf_thread_status *thread_list = NULL;
 	elf_fpregset_t *fpu = NULL;
 	int thread_status_size = 0;
 	elf_addr_t *auxv;
@@ -1627,15 +1626,12 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 			goto end_coredump;
 
 		tmp->thread = ct->task;
-		list_add(&tmp->list, &thread_list);
+		tmp->next = thread_list;
+		thread_list = tmp;
 	}
 
-	list_for_each(t, &thread_list) {
-		struct elf_thread_status *tmp;
-		int sz;
-
-		tmp = list_entry(t, struct elf_thread_status, list);
-		sz = elf_dump_thread_status(cprm->siginfo->si_signo, tmp);
+	for (tmp = thread_list; tmp; tmp = tmp->next) {
+		int sz = elf_dump_thread_status(cprm->siginfo->si_signo, tmp);
 		thread_status_size += sz;
 	}
 
@@ -1760,10 +1756,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 			goto end_coredump;
 
 	/* write out the thread status notes section */
-	list_for_each(t, &thread_list) {
-		struct elf_thread_status *tmp =
-				list_entry(t, struct elf_thread_status, list);
-
+	for (tmp = thread_list; tmp; tmp = tmp->next) {
 		for (i = 0; i < tmp->num_notes; i++)
 			if (!writenote(&tmp->notes[i], cprm))
 				goto end_coredump;
@@ -1791,10 +1784,10 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	}
 
 end_coredump:
-	while (!list_empty(&thread_list)) {
-		struct list_head *tmp = thread_list.next;
-		list_del(tmp);
-		kfree(list_entry(tmp, struct elf_thread_status, list));
+	while (thread_list) {
+		tmp = thread_list;
+		thread_list = thread_list->next;
+		kfree(tmp);
 	}
 	kfree(phdr4note);
 	kfree(elf);
-- 
2.11.0

