Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826F0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6453D207D0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgF3ElS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgF3ElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:41:10 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17420C08C5DC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:41:10 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq84y-002aBP-RA; Tue, 30 Jun 2020 04:41:08 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 7/7] [elf-fdpic] switch coredump to regsets
Date:   Tue, 30 Jun 2020 05:41:08 +0100
Message-Id: <20200630044108.615673-7-viro@ZenIV.linux.org.uk>
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

similar to how elf coredump is working on architectures that
have regsets, and all architectures with elf-fdpic support *do*
have that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/binfmt_elf_fdpic.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 34c45410d587..1af03c8d3c09 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -35,6 +35,7 @@
 #include <linux/elfcore.h>
 #include <linux/coredump.h>
 #include <linux/dax.h>
+#include <linux/regset.h>
 
 #include <linux/uaccess.h>
 #include <asm/param.h>
@@ -1456,8 +1457,7 @@ struct elf_thread_status
 	struct elf_thread_status *next;
 	struct elf_prstatus_fdpic prstatus;	/* NT_PRSTATUS */
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
-	struct task_struct *thread;
-	struct memelfnote notes[3];
+	struct memelfnote notes[2];
 	int num_notes;
 };
 
@@ -1468,22 +1468,35 @@ struct elf_thread_status
  */
 static struct elf_thread_status *elf_dump_thread_status(long signr, struct task_struct *p, int *sz)
 {
+	const struct user_regset_view *view = task_user_regset_view(p);
 	struct elf_thread_status *t;
+	int i, ret;
 
 	t = kzalloc(sizeof(struct elf_thread_status), GFP_KERNEL);
 	if (!t)
 		return t;
 
 	fill_prstatus(&t->prstatus, p, signr);
-	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
+	regset_get(p, &view->regsets[0],
+		   sizeof(t->prstatus.pr_reg), &t->prstatus.pr_reg);
 
 	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
 		  &t->prstatus);
 	t->num_notes++;
 	*sz += notesize(&t->notes[0]);
 
-	t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, task_pt_regs(p),
-							   &t->fpu);
+	for (i = 1; i < view->n; ++i) {
+		const struct user_regset *regset = &view->regsets[i];
+		if (regset->core_note_type != NT_PRFPREG)
+			continue;
+		if (regset->active && regset->active(p, regset) <= 0)
+			continue;
+		ret = regset_get(p, regset, sizeof(t->fpu), &t->fpu);
+		if (ret >= 0)
+			t->prstatus.pr_fpvalid = 1;
+		break;
+	}
+
 	if (t->prstatus.pr_fpvalid) {
 		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu),
 			  &t->fpu);
-- 
2.11.0

