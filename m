Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F98C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503D32068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyUFAiLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgGMD52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgGMD51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:57:27 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BE0C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 20:57:27 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id k18so11003604qke.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 20:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OS6lj7NOuRAN0ATW8vraVLjweCwqIGD2clKFwyyRfmk=;
        b=RyUFAiLoLz9jmksQ2ngCPPEL3c7YGMgAy1g0UxGB+6aT5rhTvwO4oknu28Vr7oxpYX
         R2Ihgkxufu13Oj23JrgqGsDB/FRhGOSBbjW3riqx4ai8dQOSd9dTtybnW+J9bLtql+m0
         64vIK5/0oOFxzK1x6Kvy6j9MkWu6pFeTE9InA4a7TShX14YIxSOkSMLtpvJoemvLoh5I
         pAEFwItdxtR5UzofOyElQWvbriHWS4Llx6PSNqIOTBCwuZ1TkMAbGnuy0cN+CVxdYRbV
         wNUxHqnFdWddGt9CuBFYviys4ndO3Pg+8D8nwrPMa0ureshRA8mcy/w9GtslTj6CKnc0
         WJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OS6lj7NOuRAN0ATW8vraVLjweCwqIGD2clKFwyyRfmk=;
        b=dzqNK9KsHJoehe678dR7NRILJPwHhwVKU6vj/a03hiA81IOIOwB5c5S+WdSLejYbl0
         J69AWO1lHMTpfOYRyrxQYvUH+R1XpnofI0ftK/dXtqxM/9ZajtuHIMu6pBAS2M0yvK3B
         lWO1q3Ca/McxXpMTI3dAiDuAqZTlFUyNdwEVJOlwf09orauUU8xkXtPWCKSqii6ExfnM
         GPCEU/oPsulaZ59TjJK1iTzyRiiYJuOnCFYjWix1uui8sN/tgDyqpfQ57MAZE5Td2k8p
         5DWn2Advahwb74FUkj1mIKm0nV5TsY3KeixYTQA6CYhpSTp98X6K3xkF0iC850LztJSi
         oKrw==
X-Gm-Message-State: AOAM533Z8Qjhh60Rk5hg8Qp8Yr0hSi34JLoDT5vDBRFifr3B9aOBS5aP
        CwArXbi+qNMa/PBF4qdtxO8=
X-Google-Smtp-Source: ABdhPJx+ZZMl2fYBRmzXDOdel3MM2nFcDo3HRtB5KXhhkOTxMljIysTpn708+sZnx66BpLeqZPab6Q==
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr69626943qkg.132.1594612646351;
        Sun, 12 Jul 2020 20:57:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z60sm17212288qtc.30.2020.07.12.20.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 20:57:25 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 12 Jul 2020 23:57:23 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Jian Cai <caij2003@gmail.com>, jiancai@google.com,
        ndesaulniers@google.com, manojgupta@google.com,
        sedat.dilek@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86/entry: add compatibility with IAS
Message-ID: <20200713035723.GA874450@rani.riverdale.lan>
References: <20200713012428.1039487-1-caij2003@gmail.com>
 <20200713025429.GA704795@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713025429.GA704795@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 10:54:29PM -0400, Arvind Sankar wrote:
> On Sun, Jul 12, 2020 at 06:24:22PM -0700, Jian Cai wrote:
> > Clang's integrated assembler does not allow symbols with non-absolute
> > values to be reassigned. This patch allows the affected code to be
> > compatible with IAS.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1043
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: Jian Cai <caij2003@gmail.com>
> > ---
> >  arch/x86/include/asm/idtentry.h | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> > index f3d70830bf2a..77beed2cd6d9 100644
> > --- a/arch/x86/include/asm/idtentry.h
> > +++ b/arch/x86/include/asm/idtentry.h
> > @@ -468,34 +468,32 @@ __visible noinstr void func(struct pt_regs *regs,			\
> >   */
> >  	.align 8
> >  SYM_CODE_START(irq_entries_start)
> > -    vector=FIRST_EXTERNAL_VECTOR
> > -    pos = .
> > +    i = 1
> > +    pos1 = .
> >      .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
> >  	UNWIND_HINT_IRET_REGS
> > -	.byte	0x6a, vector
> > +	.byte	0x6a, FIRST_EXTERNAL_VECTOR + i - 1
> >  	jmp	asm_common_interrupt
> >  	nop
> >  	/* Ensure that the above is 8 bytes max */
> > -	. = pos + 8
> > -    pos=pos+8
> > -    vector=vector+1
> > +	. = pos1 + 8 * i
> > +	i = i + 1
> >      .endr
> >  SYM_CODE_END(irq_entries_start)
> 
> I think it would be a little cleaner to initialize i to 0, and drop pos.
> i.e. couldn't we do
> 	i = 0
> 	...
> 	.byte	0x6a, FIRST_EXTERNAL_VECTOR + i
> 	...
> 	i = i + 1
> 	. = irq_entries_start + 8 * i
> 

Or maybe just:

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index eeac6dc2adaa..c774039d130b 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -469,15 +469,14 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	.align 8
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
-    pos = .
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+    0:
 	UNWIND_HINT_IRET_REGS
 	.byte	0x6a, vector
 	jmp	asm_common_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
-	. = pos + 8
-    pos=pos+8
+	. = 0b + 8
     vector=vector+1
     .endr
 SYM_CODE_END(irq_entries_start)
@@ -486,15 +485,14 @@ SYM_CODE_END(irq_entries_start)
 	.align 8
 SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
-    pos = .
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
+    0:
 	UNWIND_HINT_IRET_REGS
 	.byte	0x6a, vector
 	jmp	asm_spurious_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
-	. = pos + 8
-    pos=pos+8
+	. = 0b + 8
     vector=vector+1
     .endr
 SYM_CODE_END(spurious_entries_start)
