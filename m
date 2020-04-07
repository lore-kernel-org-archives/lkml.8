Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4352EC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128E12054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDGBeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:34:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43702 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:34:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLd82-0003J4-7V; Mon, 06 Apr 2020 19:34:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLd81-0002Tn-B4; Mon, 06 Apr 2020 19:34:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
        <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
        <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
        <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
        <87lfnda3w3.fsf@x220.int.ebiederm.org>
        <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
        <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 06 Apr 2020 20:31:25 -0500
In-Reply-To: <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 06 Apr 2020 20:29:50 -0500")
Message-ID: <87o8s43wuq.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jLd81-0002Tn-B4;;;mid=<87o8s43wuq.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19skiKFAzO68dt2CUixJOa4ehdieyfTS30=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 1/3] binfmt: Move install_exec_creds after setup_new_exec to match binfmt_elf
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In 2016 Linus moved install_exec_creds immediately after
setup_new_exec, in binfmt_elf as a cleanup and as part of closing a
potential information leak.

Perform the same cleanup for the other binary formats.

Different binary formats doing the same things the same way makes exec
easier to reason about and easier to maintain.

Putting install_exec_creds immediate after setup_new_exec makes many
simplifications possible in the code.

Ref: 9f834ec18def ("binfmt_elf: switch to new creds when switching to new mm")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/ia32/ia32_aout.c | 3 +--
 fs/binfmt_aout.c          | 2 +-
 fs/binfmt_elf_fdpic.c     | 2 +-
 fs/binfmt_flat.c          | 3 +--
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index 9bb71abd66bd..37b36a8ce5fa 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -140,6 +140,7 @@ static int load_aout_binary(struct linux_binprm *bprm)
 	set_personality_ia32(false);
 
 	setup_new_exec(bprm);
+	install_exec_creds(bprm);
 
 	regs->cs = __USER32_CS;
 	regs->r8 = regs->r9 = regs->r10 = regs->r11 = regs->r12 =
@@ -156,8 +157,6 @@ static int load_aout_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		return retval;
 
-	install_exec_creds(bprm);
-
 	if (N_MAGIC(ex) == OMAGIC) {
 		unsigned long text_addr, map_size;
 
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index 8e8346a81723..ace587b66904 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -162,6 +162,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
 	set_personality(PER_LINUX);
 #endif
 	setup_new_exec(bprm);
+	install_exec_creds(bprm);
 
 	current->mm->end_code = ex.a_text +
 		(current->mm->start_code = N_TXTADDR(ex));
@@ -174,7 +175,6 @@ static int load_aout_binary(struct linux_binprm * bprm)
 	if (retval < 0)
 		return retval;
 
-	install_exec_creds(bprm);
 
 	if (N_MAGIC(ex) == OMAGIC) {
 		unsigned long text_addr, map_size;
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 240f66663543..6c94c6d53d97 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -353,6 +353,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 		current->personality |= READ_IMPLIES_EXEC;
 
 	setup_new_exec(bprm);
+	install_exec_creds(bprm);
 
 	set_binfmt(&elf_fdpic_format);
 
@@ -434,7 +435,6 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	current->mm->start_stack = current->mm->start_brk + stack_size;
 #endif
 
-	install_exec_creds(bprm);
 	if (create_elf_fdpic_tables(bprm, current->mm,
 				    &exec_params, &interp_params) < 0)
 		goto error;
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 831a2b25ba79..1a1d1fcb893f 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -541,6 +541,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 		/* OK, This is the point of no return */
 		set_personality(PER_LINUX_32BIT);
 		setup_new_exec(bprm);
+		install_exec_creds(bprm);
 	}
 
 	/*
@@ -963,8 +964,6 @@ static int load_flat_binary(struct linux_binprm *bprm)
 		}
 	}
 
-	install_exec_creds(bprm);
-
 	set_binfmt(&flat_format);
 
 #ifdef CONFIG_MMU
-- 
2.25.0

