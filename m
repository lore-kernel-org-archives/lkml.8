Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CD4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9987208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590651661;
	bh=gigszKobwrNhsiWB5PLyDQskbvqangb4Noole5LX0bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qQEXoAeHFuLxGSO/nmg7sjnbr2c50UTHoVEwubYGitMU9rBjJwKVQyTztjra3un8p
	 5AXqdyiR1fJ6ubzhceV2l7snLIDznhRGHQtQ3VXYXumefpzBP4RKCq27vV9kM53M/5
	 6VzpDFWlP16WxfNRloBHKW0l/p6Icj4FXoMaQj4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgE1HlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgE1Hk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:40:59 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DFEC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:40:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d7so30983061eja.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ULlx35DLy/9Lgf3Ygxro/QpeK3ocmPohcjf/Jw3Jkz0=;
        b=kPpmeqjiwGl0WcbeNzCgm7/soh7WCtePSLidXkrMtY7AQPTMUh1cEHvzUbsotdqNGM
         CvE1Psccf34ZB0LC0IrOpaCCyY7WW0a2xV412UcpxKbF28aTiH0VZqk2yVRrIV7wmz01
         sjOQiXyrqLJJnPYlr5ZVSK6/oFOrTFMJR/jhhqE0aNwwDKbuel9e/QTI1k2MJ0FlQora
         aKkke+hWErRc62HtVlWwPQuWAzvhJZT0cIYB3BzyQn3t02mz/Ey5ZOtAC5wwWTTehS09
         w0EG5mOZiSngBGjGpXtx09b0cARrYCLksOShaQvM1KSgsGOTCc/JPxpngLEWP/2XREPB
         0c0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ULlx35DLy/9Lgf3Ygxro/QpeK3ocmPohcjf/Jw3Jkz0=;
        b=lT0eLpUgKK2hiYRbozDoKp7pUDmIwxQqnBDk1A6lI1P1S0NMZhm1XWS1krynziH7ex
         k57qiT6CvpGJE+xZrG0Wg/tUxDlCfIUDxzNwJk0EirFqXemBlJApFU3DNrjCl2XROtK5
         lBaNlzThFJBUjrffpXqb/q+cEtq4+FvP7FOLmZtpR2bvivUTAJzT6VWBTU8NVclvJDM6
         fQncDknNfIGmaa2MYGPKizadbS+nAwqEIrf9mK8wzC9KYIIiUqyzidcXJazO+PE061Ne
         qGOODxyIge7GNhAxicqrdsHDvxaWmfFqeS3uZj0/uOeGCtZs93I0FNcHUdEqHXwidbAW
         nBxQ==
X-Gm-Message-State: AOAM532963M75/n3e+s/ZrmM3WIkH+w5pi53dBsr2aTVbeT8+qcACMy1
        Ar4u5Dim59cRgxM8/6lm3XM=
X-Google-Smtp-Source: ABdhPJwFxcqCIUgmiJLnan7/NniUz2YbaDjGx1aKDkGW6D9tXkPMcQClGu9dZTtA0zpTvxzDKALjVg==
X-Received: by 2002:a17:906:470c:: with SMTP id y12mr1824564ejq.336.1590651657515;
        Thu, 28 May 2020 00:40:57 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id ch8sm4550002ejb.53.2020.05.28.00.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 00:40:56 -0700 (PDT)
Date:   Thu, 28 May 2020 09:40:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2] fs/coredump/elf: Clean up fill_thread_core_info()
Message-ID: <20200528074055.GA111020@gmail.com>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
 <20200528070255.GA790247@gmail.com>
 <20200528072934.GA3663052@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528072934.GA3663052@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 13f25e241ac4..25d489bc9453 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1733,7 +1733,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
> >  		    (!regset->active || regset->active(t->task, regset) > 0)) {
> >  			int ret;
> >  			size_t size = regset_size(t->task, regset);
> > -			void *data = kmalloc(size, GFP_KERNEL);
> > +			void *data = kzalloc(size, GFP_KERNEL);
> >  			if (unlikely(!data))
> >  				return 0;
> >  			ret = regset->get(t->task, regset,
> 
> The clean-up patch below on top of the zeroing patch above makes 
> fill_thread_core_info() readable for me:
> 
>  - Use a proper iterator pattern and merge the special case '0' into 
>    the 1..n-1 iterator.
> 
>  - Clean up the flow of logic in the iterator to more standard 
>    patterns, to see the progress of work versus a mix of uncommon 
>    failure causes with the typical branch.
> 
>  - Add a WARN_ON_ONCE() for a silent assumption about NT_PRSTATUS 
>    semantics.
> 
>  - Get rid of a copious amount of col80 line breaks created by 
>    copy & paste of overly verbose repetitive patterns.
> 
>  - Clean up small details like 10 year old "fill the reset" typos in 
>    comments, unbalanced curly braces, etc.
> 
> Now that the compiler can see what we are doing the code likely got a 
> tiny bit faster as well, because the code shrunk a bit if we discount 
> the extra WARN_ON_ONCE():
> 
>   # fs/binfmt_elf.o:
> 
>    text	   data	    bss	    dec	    hex	filename
>   14410	    108	      0	  14518	   38b6	binfmt_elf.o.before
>   14381	    108	      0	  14489	   3899	binfmt_elf.o.after
> 
> (Assuming it's not due to a bug - this is untested.)
> 
> Thanks,
> 
> 	Ingo
> 
> Signed-off-by-if-you-first-test-it: Ingo Molnar <mingo@kernel.org>

> +				SET_PR_FPVALID(&t->prstatus, 1, regset0_size);

Meh, I broke the x86-32 build with this, in part because on 64-bit 
SET_PR_FPVALID() silently ignores the third argument.

The patch below, folded into the cleanup patch, does the following:

 - fixes the bug I introduced.

 - makes SET_PR_FPVALID() use all three arguments on 64-bit systems 
   too, to keep dorks like me from breaking the code.

 - fixes a minor macro assumption in arch/x86/include/asm/compat.h

Still an overall win, if we compare it without the WARN_ON():

  # fs/binfmt_elf.o:

   text	   data	    bss	    dec	    hex	filename
  14410	    108	      0	  14518	   38b6	binfmt_elf.o.before
  14381	    108	      0	  14489	   3899	binfmt_elf.o.after

Thanks,

	Ingo

---
 arch/x86/include/asm/compat.h |  2 +-
 fs/binfmt_elf.c               | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 52e9f3480f69..2f5ff3c3416b 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -169,7 +169,7 @@ typedef struct user_regs_struct compat_elf_gregset_t;
 /* Full regset -- prstatus on x32, otherwise on ia32 */
 #define PRSTATUS_SIZE(S, R) (R != sizeof(S.pr_reg) ? 144 : 296)
 #define SET_PR_FPVALID(S, V, R) \
-  do { *(int *) (((void *) &((S)->pr_reg)) + R) = (V); } \
+  do { *(int *) (((void *) &((S)->pr_reg)) + (R)) = (V); } \
   while (0)
 
 #ifdef CONFIG_X86_X32_ABI
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 3f9f299169fd..bc347179df0f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1695,7 +1695,7 @@ static void do_thread_regset_writeback(struct task_struct *task,
 #endif
 
 #ifndef SET_PR_FPVALID
-#define SET_PR_FPVALID(S, V, R) ((S)->pr_fpvalid = (V))
+#define SET_PR_FPVALID(S, V, R) ((void)(R), (S)->pr_fpvalid = (V))
 #endif
 
 static int fill_thread_core_info(struct elf_thread_core_info *t,
@@ -1705,7 +1705,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	unsigned int i;
 	const struct user_regset *regset = &view->regsets[0];
 	struct memelfnote *note = &t->notes[0];
-	unsigned int size = regset_size(t->task, regset);
+	unsigned int size, size0 = regset_size(t->task, regset);
 	int ret;
 
 	/*
@@ -1715,11 +1715,11 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	 * We assume that regset 0 is NT_PRSTATUS.
 	 */
 	fill_prstatus(&t->prstatus, t->task, signr);
-	ret = regset->get(t->task, regset, 0, size, &t->prstatus.pr_reg, NULL);
+	ret = regset->get(t->task, regset, 0, size0, &t->prstatus.pr_reg, NULL);
 	/* NT_PRSTATUS is not supposed to fail: */
 	WARN_ON_ONCE(ret);
 
-	fill_note(note, "CORE", NT_PRSTATUS, PRSTATUS_SIZE(t->prstatus, size), &t->prstatus);
+	fill_note(note, "CORE", NT_PRSTATUS, PRSTATUS_SIZE(t->prstatus, size0), &t->prstatus);
 	*total += notesize(note);
 
 	do_thread_regset_writeback(t->task, &view->regsets[0]);
@@ -1754,7 +1754,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 			if (regset->core_note_type != NT_PRFPREG) {
 				fill_note(note, "LINUX", regset->core_note_type, size, data);
 			} else {
-				SET_PR_FPVALID(&t->prstatus, 1, regset0_size);
+				SET_PR_FPVALID(&t->prstatus, 1, size0);
 				fill_note(note, "CORE", NT_PRFPREG, size, data);
 			}
 			*total += notesize(note);
