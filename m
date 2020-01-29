Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD00C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B6E20702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgA2SeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:34:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:49390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgA2SeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:34:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9A407AC77;
        Wed, 29 Jan 2020 18:34:15 +0000 (UTC)
Date:   Wed, 29 Jan 2020 19:34:04 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200129183404.GB30979@zn.tnic>
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic>
 <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 09:40:58AM -0800, Linus Torvalds wrote:
> On Wed, Jan 29, 2020 at 9:07 AM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > This returns "3" ... not what we want. But swapping the ERMS/FSRM order
> > gets the correct version.
> 
> That actually makes sense, and is what I suspected (after I wrote the
> patch) what would happen. It would just be good to have it explicitly
> documented at the macro.

Like this?

---
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 13adca37c99a..d94bad03bcb4 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -164,6 +164,11 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_REPLACEMENT(newinstr, feature, 1)			\
 	".popsection\n"
 
+/*
+ * The patching happens in the natural order of first newinstr1 and then
+ * newinstr2, iff the respective feature bits are set. See apply_alternatives()
+ * for details.
+ */
 #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
 	OLDINSTR_2(oldinstr, 1, 2)					\
 	".pushsection .altinstructions,\"a\"\n"				\

> That would be bad indeed, but I don't think it should matter
> particularly for this case - it would have been bad before too.
> 
> I suspect there is some other issue going on, like the NOP padding
> logic being confused.

Or the cmp $0x20 test missing in the default case, see below.

> In particular, look here, this is the alt_instruction entries:
> 
>    altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f,142b-141b
>    altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f,142b-141b
> 
> where the arguments are "orig alt feature orig_len alt_len pad_len" in
> that order.
> 
> Notice how "pad_len" in both cases is the padding from the _original_
> instruction (142b-141b).

<snip this which I'll take a look later so that we can sort out the
issue at hand first>

> So I'm just hand-waving. Maybe there was some simpler explanation
> (like me just picking the wrong instructions when I did the rough
> conversion and simply breaking things with some stupid bug).

Looks like it. So I did this:

---
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 7ff00ea64e4f..a670d01570df 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -39,23 +39,19 @@ SYM_FUNC_START(__memmove)
 	cmp %rdi, %r8
 	jg 2f
 
-	/* FSRM implies ERMS => no length checks, do the copy directly */
-.Lmemmove_begin_forward:
-	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
-	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
-
 	/*
-	 * movsq instruction have many startup latency
-	 * so we handle small size by general register.
-	 */
-	cmp  $680, %rdx
-	jb	3f
-	/*
-	 * movsq instruction is only good for aligned case.
+	 * Three rep-string alternatives:
+	 *  - go to "movsq" for large regions where source and dest are
+	 *    mutually aligned (same in low 8 bits). "label 4"
+	 *  - plain rep-movsb for FSRM
+	 *  - rep-movs for > 32 byte for ERMS.
 	 */
+.Lmemmove_begin_forward:
+	ALTERNATIVE_2 \
+		"cmp $0x20, %rdx; jb 1f; cmp $680, %rdx ; jb 3f ; cmpb %dil, %sil; je 4f", \
+		"cmp $0x20, %rdx; jb 1f; movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS, \
+		"movq %rdx, %rcx ; rep movsb; retq", X86_FEATURE_FSRM
 
-	cmpb %dil, %sil
-	je 4f
 3:
 	sub $0x20, %rdx
 	/*

---

Notice how the *first* option of the alternative, which is the default
one, has that gotten that additional "cmp $0x20, %rdx; jb 1f" test which
sends us down to the less than 32 bytes copy length.

Your original version didn't have it and here's what I saw:

So I stopped the guest just before that code and the call trace looked
like this:

#0  memmove () at arch/x86/lib/memmove_64.S:43
#1  0xffffffff824448c2 in memblock_insert_region (type=0xffffffff824a8298 <memblock+56>, idx=<optimized out>, base=0, 
    size=4096, nid=2, flags=MEMBLOCK_NONE) at mm/memblock.c:553
#2  0xffffffff824454f0 in memblock_add_range (type=0xffffffff824a8298 <memblock+56>, base=0, size=<optimized out>, 
    nid=73400320, flags=<optimized out>) at mm/memblock.c:641
#3  0xffffffff82445627 in memblock_reserve (base=0, size=4096) at mm/memblock.c:830
#4  0xffffffff823ff399 in setup_arch (cmdline_p=0xffffffff82003f28) at arch/x86/kernel/setup.c:798
#5  0xffffffff823f9ae1 in start_kernel () at init/main.c:598
#6  0xffffffff810000d4 in secondary_startup_64 () at arch/x86/kernel/head_64.S:242
#7  0x0000000000000000 in ?? ()

and count in rdx was:

rdx            0x18     24

Without that "cmp $0x20" test above, we do the "cmp $680, %rdx; jb 3f;" test
and we run into the following asm at label 3:

3:
        sub $0x20, %rdx
        /*
         * We gobble 32 bytes forward in each loop.
         */

<--- right here %rdx is:

rdx            0xfffffffffffffff8       -8

and yeeehaaw, we're in the weeds and then end up triplefaulting at some
unmapped source address in %rsi or so.

So now I'm going to play all three variants with pen and paper to make
sure we're still sane.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
