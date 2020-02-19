Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9B3C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCDC206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFjM/xGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBSSuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:50:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55922 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgBSSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:50:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so1814741wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YHDo6SDUmBGIxFcFU0zxdkAV/KCatUOT545wU/6CJe8=;
        b=kFjM/xGBPVT9Bvo5YAdNyJF/hCra0fKDPQKYo1VPlXU5spMr96xpLM3ste5KHplcom
         tsGQirjLmLTV22Xm+g2bBZP3Gp7ZLfumXC/+SNTsxKadBKg2l1WTHhhEEaSSk3/Pr+2N
         tyFIoycWoHDN7x/8I5NYkBjQtsH9iQ2vJJcmadT9TI7JTUKGg6qlJ/mX/AKEnvvs30eW
         5rsFEy7anYsOUUPf4OobfgV6pM4SfwMJlXxuNDHho/AoPbSshGMl6xFMDsHVwayezK2/
         lpxVjtnd6Cbta+q5rEv6xFYQJNAbJNEAiVVpDSafXsU3GF4GfrtyDacRKroFU5WbE/gI
         abYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YHDo6SDUmBGIxFcFU0zxdkAV/KCatUOT545wU/6CJe8=;
        b=BO27qRSVxCVl+S/GN1EkcQivnAiPD91oUA818trN7hYzotem8HyS0HmlyvdfxU494Y
         0to2eST6JoCl8sVwDPd7NdRLBJ2i1A2zWVnS46JGBwTQAzFfu2KRClRzDN1NOg5q+Sp1
         xnT/gtbksT5r5d8nIgKlSJjhUMyNOG193FZFvgu9PH2fD3HG9Lg3Y/7GgmOHvH0atL1l
         mD/BVS6hFET73n6Vzv5fs57HKLt21Y8FX9tAg78uJ4IOh5p5SHqY5BjrvnHVxO0ZyFBZ
         jMWe+Rrn4A6Vt3FoScGy8xWequJrAYOxs5emGGIAX2/MyPMj+p1f2wkCrghrOY5E8WAg
         DVCA==
X-Gm-Message-State: APjAAAXNN3xkPOxkzCDgRsGJ2sESsyYWUdmBgkCA49v5j3zpLJPta80g
        9CZIYWbZ1ydrbNxA4UVi+z3zYsM=
X-Google-Smtp-Source: APXvYqxPpk0DNTUoejDUEoqV5lH/v1/qKE86kFFEEIyMHAbMKZFZm5CgZA3BpkTUNeerW7XboAP7Og==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr10927400wmg.147.1582138214189;
        Wed, 19 Feb 2020 10:50:14 -0800 (PST)
Received: from avx2 ([46.53.251.159])
        by smtp.gmail.com with ESMTPSA id o15sm864695wra.83.2020.02.19.10.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 10:50:13 -0800 (PST)
Date:   Wed, 19 Feb 2020 21:50:12 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ELF: allocate less for static executable
Message-ID: <20200219185012.GB4871@avx2>
References: <20200219184847.GA4871@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219184847.GA4871@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PT_INTERP ELF header can be spared if executable is static.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -698,17 +698,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long reloc_func_desc __maybe_unused = 0;
 	int executable_stack = EXSTACK_DEFAULT;
 	struct elfhdr *elf_ex = (struct elfhdr *)bprm->buf;
-	struct elfhdr *interp_elf_ex;
+	struct elfhdr *interp_elf_ex = NULL;
 	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
 	struct mm_struct *mm;
 	struct pt_regs *regs;
 
-	interp_elf_ex = kmalloc(sizeof(*interp_elf_ex), GFP_KERNEL);
-	if (!interp_elf_ex) {
-		retval = -ENOMEM;
-		goto out_ret;
-	}
-
 	retval = -ENOEXEC;
 	/* First of all, some simple consistency checks */
 	if (memcmp(elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
@@ -768,6 +762,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		 */
 		would_dump(bprm, interpreter);
 
+		interp_elf_ex = kmalloc(sizeof(*interp_elf_ex), GFP_KERNEL);
+		if (!interp_elf_ex) {
+			retval = -ENOMEM;
+			goto out_free_ph;
+		}
+
 		/* Get the exec headers */
 		retval = elf_read(interpreter, interp_elf_ex,
 				  sizeof(*interp_elf_ex), 0);
@@ -1073,6 +1073,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		allow_write_access(interpreter);
 		fput(interpreter);
+
+		kfree(interp_elf_ex);
 	} else {
 		elf_entry = e_entry;
 		if (BAD_ADDR(elf_entry)) {
@@ -1151,12 +1153,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_thread(regs, elf_entry, bprm->p);
 	retval = 0;
 out:
-	kfree(interp_elf_ex);
-out_ret:
 	return retval;
 
 	/* error cleanup */
 out_free_dentry:
+	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
 	allow_write_access(interpreter);
 	if (interpreter)
