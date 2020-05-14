Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E975C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3366420722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iv9ZxZUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgENMUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbgENMUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:20:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F05C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ad5vSdqQZ/kzQWHmHR01DQ1eEfedj+lyeYgkr4MSeNg=; b=Iv9ZxZUsExMEF0iWGGt/WbLWFG
        Cz+adppmOOhk0nnsv5gXPVbMb0yF0uCNfKwrZz7pXdd0dquIKvR8b5VcZeszsD49FNnl+qcrSgIto
        szG2L6D80F/AsvGUVx9FAgd49p5XpjFfe4KyMj27zlaLSDQwwEpFBVzUrlYR00W9de/Yqj+sRb/9G
        Scc9E808F3/mPq7ft9cnEQ37m17SubzjpDoANR4QfQRpf5LIZEQ6rmRSIf+i37OsKPVkJf2xqlpzR
        9edbr56i29OUYCryJ9YKqsS9Al1UCHWm+4TpdNaRuwHnXAC7WdgQB434AjEwaFQu0j6Ks7P7btlOj
        oeBkDpRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZCqu-00038H-J0; Thu, 14 May 2020 12:20:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4215304DB2;
        Thu, 14 May 2020 14:20:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAD74213C8B5A; Thu, 14 May 2020 14:20:38 +0200 (CEST)
Date:   Thu, 14 May 2020 14:20:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514122038.GH3001@hirez.programming.kicks-ass.net>
References: <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513132440.GN2978@hirez.programming.kicks-ass.net>
 <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
 <20200514112142.GV2978@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514112142.GV2978@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:21:42PM +0200, Peter Zijlstra wrote:
> Given the patch below (on top of tglx's entry-v5-the-rest tag); I did
> find that I could actually build alternative.o for gcc-{8,9,10} and
> indeed clang-10. Any earlier gcc (I tried, 5,6,7) does not build:

Damn!, I forgot the patch from https://lkml.kernel.org/r/20200513111447.GE3001@hirez.programming.kicks-ass.net

With that included, on a GCC-10 KCSAN+UBSAN build, I now get this, and
that is very much not okay. This is the thing Will complained about as
well I think.

Hohumm :-(

---
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index d6d61c4455fa..ba89cabe5fcf 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -28,10 +28,6 @@ KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 
-# With some compiler versions the generated code results in boot hangs, caused
-# by several compilation units. To be safe, disable all instrumentation.
-KCSAN_SANITIZE := n
-
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 OBJECT_FILES_NON_STANDARD_paravirt_patch.o		:= y
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 77c83833d91e..06d8db612efc 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -990,7 +990,7 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 	return 0;
 }
 
-int noinstr poke_int3_handler(struct pt_regs *regs)
+int noinstr __no_kcsan __no_sanitize_address __no_sanitize_undefined poke_int3_handler(struct pt_regs *regs)
 {
 	struct bp_patching_desc *desc;
 	struct text_poke_loc *tp;
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 2cb42d8bdedc..c728ae9dcf96 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -15,6 +15,9 @@
 /* all clang versions usable with the kernel support KASAN ABI version 5 */
 #define KASAN_ABI_VERSION 5
 
+#define __no_sanitize_undefined \
+		__attribute__((no_sanitize("undefined")))
+
 #if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
 /* Emulate GCC's __SANITIZE_ADDRESS__ flag */
 #define __SANITIZE_ADDRESS__
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7dd4e0349ef3..8196a121a78e 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -138,6 +138,12 @@
 #define KASAN_ABI_VERSION 3
 #endif
 
+#if __has_attribute(__no_sanitize_undefined__)
+#define __no_sanitize_undefined __attribute__((no_sanitize_undefined))
+#else
+#define __no_sanitize_undefined
+#endif
+
 #if __has_attribute(__no_sanitize_address__)
 #define __no_sanitize_address __attribute__((no_sanitize_address))
 #else
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 3bb962959d8b..2ea532b19e75 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -241,12 +241,12 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * atomicity or dependency ordering guarantees. Note that this may result
  * in tears!
  */
-#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
+#define __READ_ONCE(x)	data_race((*(const volatile __unqual_scalar_typeof(x) *)&(x)))
 
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
 	typeof(x) *__xp = &(x);						\
-	__unqual_scalar_typeof(x) __x = data_race(__READ_ONCE(*__xp));	\
+	__unqual_scalar_typeof(x) __x = __READ_ONCE(*__xp);		\
 	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
 	smp_read_barrier_depends();					\
 	(typeof(x))__x;							\
@@ -260,14 +260,14 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #define __WRITE_ONCE(x, val)						\
 do {									\
-	*(volatile typeof(x) *)&(x) = (val);				\
+	data_race(*(volatile typeof(x) *)&(x) = (val));			\
 } while (0)
 
 #define __WRITE_ONCE_SCALAR(x, val)					\
 do {									\
 	typeof(x) *__xp = &(x);						\
 	kcsan_check_atomic_write(__xp, sizeof(*__xp));			\
-	data_race(({ __WRITE_ONCE(*__xp, val); 0; }));			\
+	__WRITE_ONCE(*__xp, val);					\
 } while (0)
 
 #define WRITE_ONCE(x, val)						\

---
0000 0000000000000000 <poke_int3_handler>:
0000    0:	41 55                	push   %r13
0002    2:	41 54                	push   %r12
0004    4:	55                   	push   %rbp
0005    5:	53                   	push   %rbx
0006    6:	48 83 ec 10          	sub    $0x10,%rsp
000a    a:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
0011   11:	00 00 
0013   13:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
0018   18:	31 c0                	xor    %eax,%eax
001a   1a:	f6 87 88 00 00 00 03 	testb  $0x3,0x88(%rdi)
0021   21:	74 21                	je     44 <poke_int3_handler+0x44>
0023   23:	31 c0                	xor    %eax,%eax
0025   25:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
002a   2a:	65 48 2b 0c 25 28 00 	sub    %gs:0x28,%rcx
0031   31:	00 00 
0033   33:	0f 85 79 01 00 00    	jne    1b2 <poke_int3_handler+0x1b2>
0039   39:	48 83 c4 10          	add    $0x10,%rsp
003d   3d:	5b                   	pop    %rbx
003e   3e:	5d                   	pop    %rbp
003f   3f:	41 5c                	pop    %r12
0041   41:	41 5d                	pop    %r13
0043   43:	c3                   	retq   
0044   44:	48 89 fb             	mov    %rdi,%rbx
0047   47:	e8 00 00 00 00       	callq  4c <poke_int3_handler+0x4c>
0048 			48: R_X86_64_PLT32	kcsan_disable_current-0x4
004c   4c:	4c 8b 2d 00 00 00 00 	mov    0x0(%rip),%r13        # 53 <poke_int3_handler+0x53>
004f 			4f: R_X86_64_PC32	.bss+0x101c
0053   53:	48 8d 6c 24 08       	lea    0x8(%rsp),%rbp
0058   58:	49 89 e4             	mov    %rsp,%r12
005b   5b:	48 89 e8             	mov    %rbp,%rax
005e   5e:	4c 29 e0             	sub    %r12,%rax
0061   61:	48 83 f8 08          	cmp    $0x8,%rax
0065   65:	0f 87 4c 01 00 00    	ja     1b7 <poke_int3_handler+0x1b7>
006b   6b:	4c 29 e5             	sub    %r12,%rbp
006e   6e:	4c 89 2c 24          	mov    %r13,(%rsp)
0072   72:	e8 00 00 00 00       	callq  77 <poke_int3_handler+0x77>
0073 			73: R_X86_64_PLT32	kcsan_enable_current_nowarn-0x4
0077   77:	48 83 fd 08          	cmp    $0x8,%rbp
007b   7b:	0f 87 53 01 00 00    	ja     1d4 <poke_int3_handler+0x1d4>
0081   81:	4c 8b 24 24          	mov    (%rsp),%r12
0085   85:	4d 85 e4             	test   %r12,%r12
0088   88:	74 99                	je     23 <poke_int3_handler+0x23>
008a   8a:	e8 00 00 00 00       	callq  8f <poke_int3_handler+0x8f>
008b 			8b: R_X86_64_PLT32	kcsan_disable_current-0x4
008f   8f:	4d 8d 6c 24 0c       	lea    0xc(%r12),%r13
0094   94:	41 8b 6c 24 0c       	mov    0xc(%r12),%ebp
0099   99:	e8 00 00 00 00       	callq  9e <poke_int3_handler+0x9e>
009a 			9a: R_X86_64_PLT32	kcsan_enable_current_nowarn-0x4
009e   9e:	85 ed                	test   %ebp,%ebp
00a0   a0:	74 81                	je     23 <poke_int3_handler+0x23>
00a2   a2:	8d 55 01             	lea    0x1(%rbp),%edx
00a5   a5:	89 e8                	mov    %ebp,%eax
00a7   a7:	f0 41 0f b1 55 00    	lock cmpxchg %edx,0x0(%r13)
00ad   ad:	89 c5                	mov    %eax,%ebp
00af   af:	75 ed                	jne    9e <poke_int3_handler+0x9e>
00b1   b1:	48 8b bb 80 00 00 00 	mov    0x80(%rbx),%rdi
00b8   b8:	49 63 44 24 08       	movslq 0x8(%r12),%rax
00bd   bd:	49 8b 0c 24          	mov    (%r12),%rcx
00c1   c1:	48 8d 57 ff          	lea    -0x1(%rdi),%rdx
00c5   c5:	83 f8 01             	cmp    $0x1,%eax
00c8   c8:	7f 1c                	jg     e6 <poke_int3_handler+0xe6>
00ca   ca:	48 63 31             	movslq (%rcx),%rsi
00cd   cd:	31 c0                	xor    %eax,%eax
00cf   cf:	48 81 c6 00 00 00 00 	add    $0x0,%rsi
00d2 			d2: R_X86_64_32S	_stext
00d6   d6:	48 39 f2             	cmp    %rsi,%rdx
00d9   d9:	74 3c                	je     117 <poke_int3_handler+0x117>
00db   db:	f0 41 ff 4c 24 0c    	lock decl 0xc(%r12)
00e1   e1:	e9 3f ff ff ff       	jmpq   25 <poke_int3_handler+0x25>
00e6   e6:	49 89 c9             	mov    %rcx,%r9
00e9   e9:	49 89 c0             	mov    %rax,%r8
00ec   ec:	49 d1 e8             	shr    %r8
00ef   ef:	4c 89 c1             	mov    %r8,%rcx
00f2   f2:	48 c1 e1 04          	shl    $0x4,%rcx
00f6   f6:	4c 01 c9             	add    %r9,%rcx
00f9   f9:	48 63 31             	movslq (%rcx),%rsi
00fc   fc:	48 81 c6 00 00 00 00 	add    $0x0,%rsi
00ff 			ff: R_X86_64_32S	_stext
0103  103:	48 39 f2             	cmp    %rsi,%rdx
0106  106:	0f 82 88 00 00 00    	jb     194 <poke_int3_handler+0x194>
010c  10c:	0f 87 93 00 00 00    	ja     1a5 <poke_int3_handler+0x1a5>
0112  112:	48 85 c9             	test   %rcx,%rcx
0115  115:	74 28                	je     13f <poke_int3_handler+0x13f>
0117  117:	0f b6 41 08          	movzbl 0x8(%rcx),%eax
011b  11b:	8d 70 34             	lea    0x34(%rax),%esi
011e  11e:	40 80 fe 1f          	cmp    $0x1f,%sil
0122  122:	76 02                	jbe    126 <poke_int3_handler+0x126>
0124  124:	0f 0b                	ud2    
0126  126:	40 0f b6 f6          	movzbl %sil,%esi
012a  12a:	48 0f be b6 00 00 00 	movsbq 0x0(%rsi),%rsi
0131  131:	00 
012e 			12e: R_X86_64_32S	.rodata
0132  132:	48 01 f2             	add    %rsi,%rdx
0135  135:	3c e8                	cmp    $0xe8,%al
0137  137:	74 29                	je     162 <poke_int3_handler+0x162>
0139  139:	77 08                	ja     143 <poke_int3_handler+0x143>
013b  13b:	3c cc                	cmp    $0xcc,%al
013d  13d:	75 e5                	jne    124 <poke_int3_handler+0x124>
013f  13f:	31 c0                	xor    %eax,%eax
0141  141:	eb 98                	jmp    db <poke_int3_handler+0xdb>
0143  143:	83 e0 fd             	and    $0xfffffffd,%eax
0146  146:	3c e9                	cmp    $0xe9,%al
0148  148:	75 da                	jne    124 <poke_int3_handler+0x124>
014a  14a:	48 63 41 04          	movslq 0x4(%rcx),%rax
014e  14e:	48 01 c2             	add    %rax,%rdx
0151  151:	b8 01 00 00 00       	mov    $0x1,%eax
0156  156:	48 89 93 80 00 00 00 	mov    %rdx,0x80(%rbx)
015d  15d:	e9 79 ff ff ff       	jmpq   db <poke_int3_handler+0xdb>
0162  162:	48 63 41 04          	movslq 0x4(%rcx),%rax
0166  166:	48 83 c7 04          	add    $0x4,%rdi
016a  16a:	48 01 c2             	add    %rax,%rdx
016d  16d:	48 8b 83 98 00 00 00 	mov    0x98(%rbx),%rax
0174  174:	48 8d 48 f8          	lea    -0x8(%rax),%rcx
0178  178:	48 89 8b 98 00 00 00 	mov    %rcx,0x98(%rbx)
017f  17f:	48 89 78 f8          	mov    %rdi,-0x8(%rax)
0183  183:	b8 01 00 00 00       	mov    $0x1,%eax
0188  188:	48 89 93 80 00 00 00 	mov    %rdx,0x80(%rbx)
018f  18f:	e9 47 ff ff ff       	jmpq   db <poke_int3_handler+0xdb>
0194  194:	4c 89 c0             	mov    %r8,%rax
0197  197:	48 85 c0             	test   %rax,%rax
019a  19a:	0f 85 49 ff ff ff    	jne    e9 <poke_int3_handler+0xe9>
01a0  1a0:	e9 36 ff ff ff       	jmpq   db <poke_int3_handler+0xdb>
01a5  1a5:	48 83 e8 01          	sub    $0x1,%rax
01a9  1a9:	4c 8d 49 10          	lea    0x10(%rcx),%r9
01ad  1ad:	48 d1 e8             	shr    %rax
01b0  1b0:	eb e5                	jmp    197 <poke_int3_handler+0x197>
01b2  1b2:	e8 00 00 00 00       	callq  1b7 <poke_int3_handler+0x1b7>
01b3 			1b3: R_X86_64_PLT32	__stack_chk_fail-0x4
01b7  1b7:	4c 01 e0             	add    %r12,%rax
01ba  1ba:	0f 82 ab fe ff ff    	jb     6b <poke_int3_handler+0x6b>
01c0  1c0:	4c 89 e6             	mov    %r12,%rsi
01c3  1c3:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
01c6 			1c6: R_X86_64_32S	.data+0x80
01ca  1ca:	e8 00 00 00 00       	callq  1cf <poke_int3_handler+0x1cf>
01cb 			1cb: R_X86_64_PLT32	__ubsan_handle_type_mismatch_v1-0x4
01cf  1cf:	e9 97 fe ff ff       	jmpq   6b <poke_int3_handler+0x6b>
01d4  1d4:	4c 01 e5             	add    %r12,%rbp
01d7  1d7:	0f 82 a4 fe ff ff    	jb     81 <poke_int3_handler+0x81>
01dd  1dd:	4c 89 e6             	mov    %r12,%rsi
01e0  1e0:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
01e3 			1e3: R_X86_64_32S	.data+0x60
01e7  1e7:	e8 00 00 00 00       	callq  1ec <poke_int3_handler+0x1ec>
01e8 			1e8: R_X86_64_PLT32	__ubsan_handle_type_mismatch_v1-0x4
01ec  1ec:	e9 90 fe ff ff       	jmpq   81 <poke_int3_handler+0x81>
