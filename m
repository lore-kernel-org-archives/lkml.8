Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A035C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390832067C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgA2TwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:52:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:29817 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgA2TwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:52:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 11:42:13 -0800
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; 
   d="scan'208";a="429781595"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 11:42:13 -0800
Date:   Wed, 29 Jan 2020 11:42:12 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200129194212.GA23479@agluck-desk2.amr.corp.intel.com>
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic>
 <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129183404.GB30979@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 07:34:04PM +0100, Borislav Petkov wrote:
> > So I'm just hand-waving. Maybe there was some simpler explanation
> > (like me just picking the wrong instructions when I did the rough
> > conversion and simply breaking things with some stupid bug).
> 
> Looks like it. So I did this:
> 

That looked plausible enough to risk on my remote machine. See below.

> diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
> index 7ff00ea64e4f..a670d01570df 100644
> --- a/arch/x86/lib/memmove_64.S
> +++ b/arch/x86/lib/memmove_64.S
> @@ -39,23 +39,19 @@ SYM_FUNC_START(__memmove)
>  	cmp %rdi, %r8
>  	jg 2f
>  
> -	/* FSRM implies ERMS => no length checks, do the copy directly */
> -.Lmemmove_begin_forward:
> -	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
> -	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
> -
>  	/*
> -	 * movsq instruction have many startup latency
> -	 * so we handle small size by general register.
> -	 */
> -	cmp  $680, %rdx
> -	jb	3f
> -	/*
> -	 * movsq instruction is only good for aligned case.
> +	 * Three rep-string alternatives:
> +	 *  - go to "movsq" for large regions where source and dest are
> +	 *    mutually aligned (same in low 8 bits). "label 4"
> +	 *  - plain rep-movsb for FSRM
> +	 *  - rep-movs for > 32 byte for ERMS.

Maybe list the code paths in the same order that they appear in the
code below? So ERMS, then FSRM.

>  	 */
> +.Lmemmove_begin_forward:
> +	ALTERNATIVE_2 \
> +		"cmp $0x20, %rdx; jb 1f; cmp $680, %rdx ; jb 3f ; cmpb %dil, %sil; je 4f", \
> +		"cmp $0x20, %rdx; jb 1f; movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS, \
> +		"movq %rdx, %rcx ; rep movsb; retq", X86_FEATURE_FSRM
>  
> -	cmpb %dil, %sil
> -	je 4f
>  3:
>  	sub $0x20, %rdx
>  	/*
> 
> ---
> 

So the kernel booted. I grabbed the address of memmove from
/proc/kallysyms and used:

   # objdump -d --start-address=0x{blah blah} /proc/kcore

and things look OK in there. It picked the FSRM option to simply
use "rep movsb". Seems to be padded with various NOPs after the
retq. Then the unpatched area starts with the "sub $0x20,%rdx".


ffffffff95946840:       48 89 f8                mov    %rdi,%rax
ffffffff95946843:       48 39 fe                cmp    %rdi,%rsi
ffffffff95946846:       7d 0f                   jge    0xffffffff95946857
ffffffff95946848:       49 89 f0                mov    %rsi,%r8
ffffffff9594684b:       49 01 d0                add    %rdx,%r8
ffffffff9594684e:       49 39 f8                cmp    %rdi,%r8
ffffffff95946851:       0f 8f a9 00 00 00       jg     0xffffffff95946900
ffffffff95946857:       48 89 d1                mov    %rdx,%rcx
ffffffff9594685a:       f3 a4                   rep movsb %ds:(%rsi),%es:(%rdi)
ffffffff9594685c:       c3                      retq
ffffffff9594685d:       0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
ffffffff95946864:       00
ffffffff95946865:       0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
ffffffff9594686c:       00
ffffffff9594686d:       66 90                   xchg   %ax,%ax
ffffffff9594686f:       48 83 ea 20             sub    $0x20,%rdx


So:

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony
