Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5C9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21683208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590650981;
	bh=NxAPpuPUvQbtYvzRMv4bFytGS+epUVxEhgqtN+MBmQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lkLVxaR50erioKFxIEZBGaWm7EYNq8jtjwYIXw05bdju+UDWJd2DPi+xP3EuO7hTA
	 4ne2weRTUhWsldNuetcvCcdgHmDaYkPmRfet0zf7zMyHLsqwExSkQMIsxJ5sN4QPPX
	 jNieKFRbpF6YaVyRWBsDSnS49j4JMKWZ/Gyz7QJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgE1H3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1H3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:29:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21629C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:29:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so12128538wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z1BIypwucnF6SYIYPyt+bNQhd9CG3FtBE0j28qwSLds=;
        b=HlKzEqPKSyQ36IoLtsBS3L1lrAjREAPo60S8AJE32IKIKIcLXeyLYL4fyl10oDNvUn
         hVve9qZjlLGjlQKxKeVgTZXdZONw8HT9BJ1T7OTn2kOW5WbsH5ZY5aqtY5oR++XEGMnk
         T1wMVzb4JKuUV+9OSKB6ljibguqaAAJHVVELhLrdOU3KfN445VLv78RAsUhJNnKKIWzN
         GgoQglslVhkj2cG0QhV8VNGfm5XGWvOs8NoYbex4JrIX6BWQlAlUwcYLd2kFAopqBMyG
         oy1lXplZ383RNkNPa5OEJcAMUo0NcMRfxMR3LtnOL4tTyHAB//HwXUPhYJEF4rhz17vu
         7CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=z1BIypwucnF6SYIYPyt+bNQhd9CG3FtBE0j28qwSLds=;
        b=CPAUU+4v9IOyVFMft4brGwejQpEY4GlT14s6LZxyudbc4NqD0g85zd9sqLB41h8las
         KDa66UJJc+slIeqgvyCNFPxCWIoJQZF3eabzXAoP52BgX+y3HQIrknZs/jmqqzz4fc4A
         eZBEGt/mE9uVz6nrO0mBtltReaLcUDNQ9xUhxZNPiid7vJ/BHG8NCKB+8s3fVxnQx+aH
         uJMBXErcdAbn12wtw4H3l27uwPfG1fkezLUnur7hjUWaF5q1HLJB/wrRXNPyarknAUck
         jp3GV6rQGH3d9f29KH/L1YWh02LdpeFJ7HMDN262yFpzWfR+B5Ibl/nByLuQRsSC2L7Z
         M1lA==
X-Gm-Message-State: AOAM532V1m+giYS5oBJw+3ItC8ylwyv1CdVzlJfL8I92t3nCGr0C2Pfn
        X+lsRQ+eOuuqdwuEFbfUpcei0MU1
X-Google-Smtp-Source: ABdhPJxPsDGrXLe+GFLmMifb3xxJZ1RhZGVbWCC7Ah+rlq+VWqlxjIB4iUFu2rvmBZrSrEctKYVd2g==
X-Received: by 2002:adf:bb4f:: with SMTP id x15mr2082679wrg.332.1590650977349;
        Thu, 28 May 2020 00:29:37 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b8sm5053110wrm.35.2020.05.28.00.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 00:29:36 -0700 (PDT)
Date:   Thu, 28 May 2020 09:29:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] fs/coredump/elf: Clean up fill_thread_core_info()
Message-ID: <20200528072934.GA3663052@gmail.com>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
 <20200528070255.GA790247@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528070255.GA790247@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > 	xstate note on boxes with xsaves support can leak uninitialized data
> > into coredumps
> > 
> > The following changes since commit 4e89b7210403fa4a8acafe7c602b6212b7af6c3b:
> > 
> >   fix multiplication overflow in copy_fdtable() (2020-05-19 18:29:36 -0400)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
> > 
> > for you to fetch changes up to 9e4636545933131de15e1ecd06733538ae939b2f:
> > 
> >   copy_xstate_to_kernel(): don't leave parts of destination uninitialized (2020-05-27 17:06:31 -0400)
> > 
> > ----------------------------------------------------------------
> > Al Viro (1):
> >       copy_xstate_to_kernel(): don't leave parts of destination uninitialized
> > 
> >  arch/x86/kernel/fpu/xstate.c | 86 ++++++++++++++++++++++++--------------------
> >  1 file changed, 48 insertions(+), 38 deletions(-)
> 
> Looks good to me.
> 
> I'm wondering, shouldn't we also zero-initialize the dump data to 
> begin with? See the patch below (untested).
> 
> Thanks,
> 
> 	Ingo
> 
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 13f25e241ac4..25d489bc9453 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1733,7 +1733,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
>  		    (!regset->active || regset->active(t->task, regset) > 0)) {
>  			int ret;
>  			size_t size = regset_size(t->task, regset);
> -			void *data = kmalloc(size, GFP_KERNEL);
> +			void *data = kzalloc(size, GFP_KERNEL);
>  			if (unlikely(!data))
>  				return 0;
>  			ret = regset->get(t->task, regset,

The clean-up patch below on top of the zeroing patch above makes 
fill_thread_core_info() readable for me:

 - Use a proper iterator pattern and merge the special case '0' into 
   the 1..n-1 iterator.

 - Clean up the flow of logic in the iterator to more standard 
   patterns, to see the progress of work versus a mix of uncommon 
   failure causes with the typical branch.

 - Add a WARN_ON_ONCE() for a silent assumption about NT_PRSTATUS 
   semantics.

 - Get rid of a copious amount of col80 line breaks created by 
   copy & paste of overly verbose repetitive patterns.

 - Clean up small details like 10 year old "fill the reset" typos in 
   comments, unbalanced curly braces, etc.

Now that the compiler can see what we are doing the code likely got a 
tiny bit faster as well, because the code shrunk a bit if we discount 
the extra WARN_ON_ONCE():

  # fs/binfmt_elf.o:

   text	   data	    bss	    dec	    hex	filename
  14410	    108	      0	  14518	   38b6	binfmt_elf.o.before
  14381	    108	      0	  14489	   3899	binfmt_elf.o.after

(Assuming it's not due to a bug - this is untested.)

Thanks,

	Ingo

Signed-off-by-if-you-first-test-it: Ingo Molnar <mingo@kernel.org>

---
 fs/binfmt_elf.c | 61 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 25d489bc9453..3f9f299169fd 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1703,56 +1703,61 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 				 long signr, size_t *total)
 {
 	unsigned int i;
-	unsigned int regset0_size = regset_size(t->task, &view->regsets[0]);
+	const struct user_regset *regset = &view->regsets[0];
+	struct memelfnote *note = &t->notes[0];
+	unsigned int size = regset_size(t->task, regset);
+	int ret;
 
 	/*
 	 * NT_PRSTATUS is the one special case, because the regset data
 	 * goes into the pr_reg field inside the note contents, rather
-	 * than being the whole note contents.  We fill the reset in here.
+	 * than being the whole note contents.  We fill the regset in here.
 	 * We assume that regset 0 is NT_PRSTATUS.
 	 */
 	fill_prstatus(&t->prstatus, t->task, signr);
-	(void) view->regsets[0].get(t->task, &view->regsets[0], 0, regset0_size,
-				    &t->prstatus.pr_reg, NULL);
+	ret = regset->get(t->task, regset, 0, size, &t->prstatus.pr_reg, NULL);
+	/* NT_PRSTATUS is not supposed to fail: */
+	WARN_ON_ONCE(ret);
 
-	fill_note(&t->notes[0], "CORE", NT_PRSTATUS,
-		  PRSTATUS_SIZE(t->prstatus, regset0_size), &t->prstatus);
-	*total += notesize(&t->notes[0]);
+	fill_note(note, "CORE", NT_PRSTATUS, PRSTATUS_SIZE(t->prstatus, size), &t->prstatus);
+	*total += notesize(note);
 
 	do_thread_regset_writeback(t->task, &view->regsets[0]);
 
 	/*
-	 * Each other regset might generate a note too.  For each regset
-	 * that has no core_note_type or is inactive, we leave t->notes[i]
+	 * Subsequent regsets might generate a note too.  For each regset
+	 * that has no ->core_note_type or is inactive, we leave t->notes[i]
 	 * all zero and we'll know to skip writing it later.
 	 */
 	for (i = 1; i < view->n; ++i) {
-		const struct user_regset *regset = &view->regsets[i];
+		regset++;
+		note++;
+
 		do_thread_regset_writeback(t->task, regset);
+
 		if (regset->core_note_type && regset->get &&
 		    (!regset->active || regset->active(t->task, regset) > 0)) {
-			int ret;
-			size_t size = regset_size(t->task, regset);
-			void *data = kzalloc(size, GFP_KERNEL);
+			void *data;
+
+			size = regset_size(t->task, regset);
+
+			data = kzalloc(size, GFP_KERNEL);
 			if (unlikely(!data))
 				return 0;
-			ret = regset->get(t->task, regset,
-					  0, size, data, NULL);
-			if (unlikely(ret))
+
+			ret = regset->get(t->task, regset, 0, size, data, NULL);
+			if (unlikely(ret)) {
 				kfree(data);
-			else {
-				if (regset->core_note_type != NT_PRFPREG)
-					fill_note(&t->notes[i], "LINUX",
-						  regset->core_note_type,
-						  size, data);
-				else {
-					SET_PR_FPVALID(&t->prstatus,
-							1, regset0_size);
-					fill_note(&t->notes[i], "CORE",
-						  NT_PRFPREG, size, data);
-				}
-				*total += notesize(&t->notes[i]);
+				continue;
+			}
+
+			if (regset->core_note_type != NT_PRFPREG) {
+				fill_note(note, "LINUX", regset->core_note_type, size, data);
+			} else {
+				SET_PR_FPVALID(&t->prstatus, 1, regset0_size);
+				fill_note(note, "CORE", NT_PRFPREG, size, data);
 			}
+			*total += notesize(note);
 		}
 	}
 
