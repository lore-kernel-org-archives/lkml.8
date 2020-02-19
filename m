Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682FDC169F9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D10206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OliBopuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBSSsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:48:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36381 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgBSSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:48:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so1834053wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aBP9GarAr9I5rYAlakrVecb9AIC/Z+TGiX5YvJQH0hU=;
        b=OliBopuwSvhuOZh0nEdK9xyBWoU/j5yDcUmAzQBsi8Ub3X00dVoi3vJBJ+xKY5TRIh
         bk3V5tSd4KdkD8R3z0iondFacZ6DfUuzRvxIiTS9Eu8GobLBAW2pTYYezXcDnMgq1Wv9
         Q2u6M2bOyss2RiNMtudN40SkDmN5QDx5EQjCaxjfGDd6MQImfSDzq67aAEy1KN9who5n
         JS7Q9F8D8qlAJUkw68ke+kzmLUI0ybWCdTWhaoIoRtuOfI3LA2VHQo7e9pbOH8FIJrg+
         7H9s2Nz3I4Ulos7on0gsv8fiRsS1C4DbfALV3eMdmvNCgNEJqFc7oKKAm94jHCFJYRJP
         ASfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aBP9GarAr9I5rYAlakrVecb9AIC/Z+TGiX5YvJQH0hU=;
        b=WJotmrVckMAArFdAMsC66u9Z0+QyhiTJkMZCZvnboMzJb5q7p6nx/pgzVyperxpeRB
         AWYG0hoLcEiCKcfqric9DEpNvqSKEe8F9AlXBLJ3So+IJQ3e9gdlzTdYuCdyl2fD6f3L
         z3xpUSJ2lrIjm0+FqrkY51J0ngLixOCse4pdL+k7pLgqk4QBYQS4nuTy/SWh8pSFYJvh
         7HFOo5fexwZ3DVilNcAElVqMLzjO5trAbuoB7IOO/tb4VoEUYPQUXIouD8nG3RIeopUO
         brkQJIRmfwAHdmpnHxudodRr7yp1bze22AAdcJN/VfoztJ+97++J/rQyC1+Xi2i/fB7U
         bLVw==
X-Gm-Message-State: APjAAAUjqKJYLF49szvmPejUpUXraQ4ab69NzauvENrVsPjvJLShqLQS
        kGUfYieouPpGdOcpknXS20c7I5Y=
X-Google-Smtp-Source: APXvYqwTgz4CO58kQtxBbLcX1RE3YBaC3gpbdmIfN1gFVpvReBZs7IvEk27+3Jai1rVBvchDHl7SVQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr11952008wmb.155.1582138130175;
        Wed, 19 Feb 2020 10:48:50 -0800 (PST)
Received: from avx2 ([46.53.251.159])
        by smtp.gmail.com with ESMTPSA id f11sm909262wml.3.2020.02.19.10.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 10:48:49 -0800 (PST)
Date:   Wed, 19 Feb 2020 21:48:47 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ELF: delete "loc" variable
Message-ID: <20200219184847.GA4871@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"loc" variable became just a wrapper for PT_INTERP ELF header after
main ELF header was moved to "bprm->buf". Delete it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -698,15 +698,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long reloc_func_desc __maybe_unused = 0;
 	int executable_stack = EXSTACK_DEFAULT;
 	struct elfhdr *elf_ex = (struct elfhdr *)bprm->buf;
-	struct {
-		struct elfhdr interp_elf_ex;
-	} *loc;
+	struct elfhdr *interp_elf_ex;
 	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
 	struct mm_struct *mm;
 	struct pt_regs *regs;
 
-	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
-	if (!loc) {
+	interp_elf_ex = kmalloc(sizeof(*interp_elf_ex), GFP_KERNEL);
+	if (!interp_elf_ex) {
 		retval = -ENOMEM;
 		goto out_ret;
 	}
@@ -771,8 +769,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		would_dump(bprm, interpreter);
 
 		/* Get the exec headers */
-		retval = elf_read(interpreter, &loc->interp_elf_ex,
-				  sizeof(loc->interp_elf_ex), 0);
+		retval = elf_read(interpreter, interp_elf_ex,
+				  sizeof(*interp_elf_ex), 0);
 		if (retval < 0)
 			goto out_free_dentry;
 
@@ -806,25 +804,25 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (interpreter) {
 		retval = -ELIBBAD;
 		/* Not an ELF interpreter */
-		if (memcmp(loc->interp_elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
+		if (memcmp(interp_elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
 			goto out_free_dentry;
 		/* Verify the interpreter has a valid arch */
-		if (!elf_check_arch(&loc->interp_elf_ex) ||
-		    elf_check_fdpic(&loc->interp_elf_ex))
+		if (!elf_check_arch(interp_elf_ex) ||
+		    elf_check_fdpic(interp_elf_ex))
 			goto out_free_dentry;
 
 		/* Load the interpreter program headers */
-		interp_elf_phdata = load_elf_phdrs(&loc->interp_elf_ex,
+		interp_elf_phdata = load_elf_phdrs(interp_elf_ex,
 						   interpreter);
 		if (!interp_elf_phdata)
 			goto out_free_dentry;
 
 		/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
 		elf_ppnt = interp_elf_phdata;
-		for (i = 0; i < loc->interp_elf_ex.e_phnum; i++, elf_ppnt++)
+		for (i = 0; i < interp_elf_ex->e_phnum; i++, elf_ppnt++)
 			switch (elf_ppnt->p_type) {
 			case PT_LOPROC ... PT_HIPROC:
-				retval = arch_elf_pt_proc(&loc->interp_elf_ex,
+				retval = arch_elf_pt_proc(interp_elf_ex,
 							  elf_ppnt, interpreter,
 							  true, &arch_state);
 				if (retval)
@@ -839,7 +837,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	 * the exec syscall.
 	 */
 	retval = arch_check_elf(elf_ex,
-				!!interpreter, &loc->interp_elf_ex,
+				!!interpreter, interp_elf_ex,
 				&arch_state);
 	if (retval)
 		goto out_free_dentry;
@@ -1055,7 +1053,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	}
 
 	if (interpreter) {
-		elf_entry = load_elf_interp(&loc->interp_elf_ex,
+		elf_entry = load_elf_interp(interp_elf_ex,
 					    interpreter,
 					    load_bias, interp_elf_phdata);
 		if (!IS_ERR((void *)elf_entry)) {
@@ -1064,7 +1062,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * adjustment
 			 */
 			interp_load_addr = elf_entry;
-			elf_entry += loc->interp_elf_ex.e_entry;
+			elf_entry += interp_elf_ex->e_entry;
 		}
 		if (BAD_ADDR(elf_entry)) {
 			retval = IS_ERR((void *)elf_entry) ?
@@ -1153,7 +1151,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_thread(regs, elf_entry, bprm->p);
 	retval = 0;
 out:
-	kfree(loc);
+	kfree(interp_elf_ex);
 out_ret:
 	return retval;
 
