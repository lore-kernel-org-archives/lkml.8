Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E9CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0BF2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEDTrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgEDTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:47:20 -0400
X-Greylist: delayed 526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 May 2020 12:47:19 PDT
Received: from ndesaulniers1.mtv.corp.google.com (unknown [IPv6:2620:15c:211:202:7116:4d00:ce84:d6b7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC46CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:47:19 -0700 (PDT)
Received: from ndesaulniers1.mtv.corp.google.com (localhost [127.0.0.1])
        by ndesaulniers1.mtv.corp.google.com (8.15.2/8.15.2/Debian-17) with ESMTP id 044JbVdu227376;
        Mon, 4 May 2020 12:37:31 -0700
Received: (from ndesaulniers@localhost)
        by ndesaulniers1.mtv.corp.google.com (8.15.2/8.15.2/Submit) id 044JbU18227374;
        Mon, 4 May 2020 12:37:30 -0700
Date:   Mon, 4 May 2020 12:37:29 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     clang-built-linux@googlegroups.com, andriy.shevchenko@intel.com,
        bp@alien8.de, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org, ilie.halip@gmail.com, natechancellor@gmail.com
Subject: Re: [PATCH v6 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200504193524.GA221287@google.com>
Reply-To: 20200310221747.2848474-1-jesse.brandeburg@intel.com
References: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 03:17:46PM -0700, Jesse Brandeburg wrote:
> Fix many sparse warnings when building with C=1. These are useless
> noise from the bitops.h file and getting rid of them helps devs
> make more use of the tools and possibly find real bugs.
> 
> When the kernel is compiled with C=1, there are lots of messages like:
>   arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
> 
> CONST_MASK() is using a signed integer "1" to create the mask which is
> later cast to (u8), in order to yield an 8-bit value for the assembly
> instructions to use. Simplify the expressions used to clearly indicate
> they are working on 8-bit values only, which still keeps sparse happy
> without an accidental promotion to a 32 bit integer.
> 
> The warning was occurring because certain bitmasks that end with a bit
> set next to a natural boundary like 7, 15, 23, 31, end up with a mask
> like 0x7f, which then results in sign extension due to the integer
> type promotion rules[1]. It was really only "clear_bit" that was
> having problems, and it was only on some bit checks that resulted in a
> mask like 0xffffff7f being generated after the inversion.
> 
> Verified with a test module (see next patch) and assembly inspection
> that the patch doesn't introduce any change in generated code.
> 
> [1] https://stackoverflow.com/questions/46073295/implicit-type-promotion-rules
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> v6: reworded commit message, enhanced explanation
> v5: changed code to use simple AND and XOR, updated commit message
> v4: reverse argument order as suggested by David Laight, added reviewed-by
> v3: Clean up the header file changes as per peterz.
> v2: use correct CC: list
> ---
>  arch/x86/include/asm/bitops.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 062cdecb2f24..53f246e9df5a 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
>  	if (__builtin_constant_p(nr)) {
>  		asm volatile(LOCK_PREFIX "orb %1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" ((u8)CONST_MASK(nr))
> +			: "iq" (CONST_MASK(nr) & 0xff)

Sorry for the very late report.  It turns out that if your config
tickles __builtin_constant_p just right, this now produces invalid
assembly:

$ cat foo.c
long a(long b, long c) {
  asm("orb\t%1, %0" : "+q"(c): "r"(b));
  return c;
}
$ gcc foo.c
foo.c: Assembler messages:
foo.c:2: Error: `%rax' not allowed with `orb'

The "q" constraint only has meanting on -m32 otherwise is treated as
"r".

Since we have the mask (& 0xff), can we drop the `b` suffix from the
instruction? Or is a revert more appropriate? Or maybe another way to
skin this cat?

Link: https://github.com/ClangBuiltLinux/linux/issues/961
This is blowing up our KernelCI reports.

>  			: "memory");
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> @@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
>  	if (__builtin_constant_p(nr)) {
>  		asm volatile(LOCK_PREFIX "andb %1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" ((u8)~CONST_MASK(nr)));
> +			: "iq" (CONST_MASK(nr) ^ 0xff));
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
>  			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> 
> base-commit: 8b614cb8f1dcac8ca77cf4dd85f46ef3055f8238
> -- 
> 2.24.1
> 
