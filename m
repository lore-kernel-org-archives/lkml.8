Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5A0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FDC207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fm/AP6vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgENLWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:22:07 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A743C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ftsVDocK0rc+NTyQA8hwSXAcjJrHOYtEYId0ITmf2Sg=; b=fm/AP6vdxmTmwFlfkbK2di5QNz
        edP8ZPsgAt1Wh6/bYdctFgvaXutQzVjSJMXbxXjqJsouetuRu+6NiajLrw5iYVDfT/NnwmWWmMi9m
        nJRc7QBWXREYZnyxpOvgUUDpdSeGIugnB21/kiE0WpeuJbLZ4G9LNSRTDs2V2X6MQPVIJ32wvOux2
        Rb6Ip0p0Uji/HgETrhhCcGxRdOcMN+xg7XrpOlivZLASaoybPuuY4aFV7wNFTov/bV6sIstJVZqpf
        JqtbSIC2dM86dYzLX9gdIsDw3zyBqvMLSjphwTprk0cfqsQi1RDxy6v52cXzSHiw6iwxG+cGzPChl
        +FH2YPoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZBvt-00057u-Dv; Thu, 14 May 2020 11:21:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF40E3060F3;
        Thu, 14 May 2020 13:21:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8E9E2B892DDA; Thu, 14 May 2020 13:21:42 +0200 (CEST)
Date:   Thu, 14 May 2020 13:21:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514112142.GV2978@hirez.programming.kicks-ass.net>
References: <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513132440.GN2978@hirez.programming.kicks-ass.net>
 <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 13, 2020 at 03:58:30PM +0200, Marco Elver wrote:
> On Wed, 13 May 2020 at 15:24, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, May 13, 2020 at 03:15:55PM +0200, Marco Elver wrote:
> > > So far so good, except: both __no_sanitize_or_inline and
> > > __no_kcsan_or_inline *do* avoid KCSAN instrumenting plain accesses, it
> > > just doesn't avoid explicit kcsan_check calls, like those in
> > > READ/WRITE_ONCE if KCSAN is enabled for the compilation unit. That's
> > > just because macros won't be redefined just for __no_sanitize
> > > functions. Similarly, READ_ONCE_NOCHECK does work as expected, and its
> > > access is unchecked.
> > >
> > > This will have the expected result:
> > > __no_sanitize_or_inline void foo(void) { x++; } // no data races reported
> > >
> > > This will not work as expected:
> > > __no_sanitize_or_inline void foo(void) { READ_ONCE(x); }  // data
> > > races are reported
> > >
> > > All this could be fixed if GCC devs would finally take my patch to
> > > make -fsanitize=thread distinguish volatile [1], but then we have to
> > > wait ~years for the new compilers to reach us. So please don't hold
> > > your breath for this one any time soon.
> > > [1] https://gcc.gnu.org/pipermail/gcc-patches/2020-April/544452.html
> >
> > Right, but that does not address the much larger issue of the attribute
> > vs inline tranwreck :/
> 
> Could you check if Clang is equally broken for you? I think GCC and
> Clang have differing behaviour on this. No idea what it takes to fix
> GCC though.

So I have some good and some maybe not so good news.

Given the patch below (on top of tglx's entry-v5-the-rest tag); I did
find that I could actually build alternative.o for gcc-{8,9,10} and
indeed clang-10. Any earlier gcc (I tried, 5,6,7) does not build:

../arch/x86/include/asm/ptrace.h:126:28: error: inlining failed in call to always_inline ‘user_mode’: function attribute mismatch

I dumped the poke_int3_handler output using objdump, find the attached
files.

It looks like clang-10 doesn't want to turn UBSAN off :/ The GCC files
look OK, no funny calls in those.

(the config has KASAN/UBSAN on, it looks like KCSAN and KASAN are
mutually exclusive)

---

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
index 2cb42d8bdedc..5e83aada6553 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -15,6 +15,13 @@
 /* all clang versions usable with the kernel support KASAN ABI version 5 */
 #define KASAN_ABI_VERSION 5
 
+#if __has_feature(undefined_sanitizer)
+#define __no_sanitize_undefined \
+               __attribute__((no_sanitize("undefined")))
+#else
+#define __no_sanitize_undefined
+#endif
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




--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="poke_int3_handler-gcc8.asm"

0000 0000000000000000 <poke_int3_handler>:
0000    0:	f6 87 88 00 00 00 03 	testb  $0x3,0x88(%rdi)
0007    7:	75 5d                	jne    66 <poke_int3_handler+0x66>
0009    9:	48 8b 35 00 00 00 00 	mov    0x0(%rip),%rsi        # 10 <poke_int3_handler+0x10>
000c 			c: R_X86_64_PC32	.bss+0x105c
0010   10:	48 85 f6             	test   %rsi,%rsi
0013   13:	74 51                	je     66 <poke_int3_handler+0x66>
0015   15:	8b 46 0c             	mov    0xc(%rsi),%eax
0018   18:	48 8d 56 0c          	lea    0xc(%rsi),%rdx
001c   1c:	85 c0                	test   %eax,%eax
001e   1e:	74 46                	je     66 <poke_int3_handler+0x66>
0020   20:	8d 48 01             	lea    0x1(%rax),%ecx
0023   23:	f0 0f b1 4e 0c       	lock cmpxchg %ecx,0xc(%rsi)
0028   28:	75 2d                	jne    57 <poke_int3_handler+0x57>
002a   2a:	48 8b 97 80 00 00 00 	mov    0x80(%rdi),%rdx
0031   31:	48 63 46 08          	movslq 0x8(%rsi),%rax
0035   35:	48 8b 0e             	mov    (%rsi),%rcx
0038   38:	4c 8d 42 ff          	lea    -0x1(%rdx),%r8
003c   3c:	83 f8 01             	cmp    $0x1,%eax
003f   3f:	7f 28                	jg     69 <poke_int3_handler+0x69>
0041   41:	4c 63 09             	movslq (%rcx),%r9
0044   44:	31 c0                	xor    %eax,%eax
0046   46:	49 81 c1 00 00 00 00 	add    $0x0,%r9
0049 			49: R_X86_64_32S	_stext
004d   4d:	4d 39 c8             	cmp    %r9,%r8
0050   50:	74 48                	je     9a <poke_int3_handler+0x9a>
0052   52:	f0 ff 4e 0c          	lock decl 0xc(%rsi)
0056   56:	c3                   	retq   
0057   57:	85 c0                	test   %eax,%eax
0059   59:	74 0b                	je     66 <poke_int3_handler+0x66>
005b   5b:	8d 48 01             	lea    0x1(%rax),%ecx
005e   5e:	f0 0f b1 0a          	lock cmpxchg %ecx,(%rdx)
0062   62:	74 c6                	je     2a <poke_int3_handler+0x2a>
0064   64:	eb f1                	jmp    57 <poke_int3_handler+0x57>
0066   66:	31 c0                	xor    %eax,%eax
0068   68:	c3                   	retq   
0069   69:	49 89 cb             	mov    %rcx,%r11
006c   6c:	49 89 c2             	mov    %rax,%r10
006f   6f:	49 d1 ea             	shr    %r10
0072   72:	4c 89 d1             	mov    %r10,%rcx
0075   75:	48 c1 e1 04          	shl    $0x4,%rcx
0079   79:	4c 01 d9             	add    %r11,%rcx
007c   7c:	4c 63 09             	movslq (%rcx),%r9
007f   7f:	49 81 c1 00 00 00 00 	add    $0x0,%r9
0082 			82: R_X86_64_32S	_stext
0086   86:	4d 39 c8             	cmp    %r9,%r8
0089   89:	0f 82 95 00 00 00    	jb     124 <poke_int3_handler+0x124>
008f   8f:	0f 87 84 00 00 00    	ja     119 <poke_int3_handler+0x119>
0095   95:	48 85 c9             	test   %rcx,%rcx
0098   98:	74 29                	je     c3 <poke_int3_handler+0xc3>
009a   9a:	0f b6 41 08          	movzbl 0x8(%rcx),%eax
009e   9e:	44 8d 48 34          	lea    0x34(%rax),%r9d
00a2   a2:	41 80 f9 1f          	cmp    $0x1f,%r9b
00a6   a6:	76 02                	jbe    aa <poke_int3_handler+0xaa>
00a8   a8:	0f 0b                	ud2    
00aa   aa:	45 0f b6 c9          	movzbl %r9b,%r9d
00ae   ae:	4d 0f be 89 00 00 00 	movsbq 0x0(%r9),%r9
00b5   b5:	00 
00b2 			b2: R_X86_64_32S	.rodata+0x620
00b6   b6:	4d 01 c8             	add    %r9,%r8
00b9   b9:	3c e8                	cmp    $0xe8,%al
00bb   bb:	74 2a                	je     e7 <poke_int3_handler+0xe7>
00bd   bd:	77 08                	ja     c7 <poke_int3_handler+0xc7>
00bf   bf:	3c cc                	cmp    $0xcc,%al
00c1   c1:	75 e5                	jne    a8 <poke_int3_handler+0xa8>
00c3   c3:	31 c0                	xor    %eax,%eax
00c5   c5:	eb 8b                	jmp    52 <poke_int3_handler+0x52>
00c7   c7:	3c e9                	cmp    $0xe9,%al
00c9   c9:	74 04                	je     cf <poke_int3_handler+0xcf>
00cb   cb:	3c eb                	cmp    $0xeb,%al
00cd   cd:	75 d9                	jne    a8 <poke_int3_handler+0xa8>
00cf   cf:	4c 63 49 04          	movslq 0x4(%rcx),%r9
00d3   d3:	b8 01 00 00 00       	mov    $0x1,%eax
00d8   d8:	4d 01 c8             	add    %r9,%r8
00db   db:	4c 89 87 80 00 00 00 	mov    %r8,0x80(%rdi)
00e2   e2:	e9 6b ff ff ff       	jmpq   52 <poke_int3_handler+0x52>
00e7   e7:	4c 63 49 04          	movslq 0x4(%rcx),%r9
00eb   eb:	48 8b 87 98 00 00 00 	mov    0x98(%rdi),%rax
00f2   f2:	48 83 c2 04          	add    $0x4,%rdx
00f6   f6:	48 8d 48 f8          	lea    -0x8(%rax),%rcx
00fa   fa:	4d 01 c8             	add    %r9,%r8
00fd   fd:	48 89 8f 98 00 00 00 	mov    %rcx,0x98(%rdi)
0104  104:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
0108  108:	b8 01 00 00 00       	mov    $0x1,%eax
010d  10d:	4c 89 87 80 00 00 00 	mov    %r8,0x80(%rdi)
0114  114:	e9 39 ff ff ff       	jmpq   52 <poke_int3_handler+0x52>
0119  119:	4c 8d 50 ff          	lea    -0x1(%rax),%r10
011d  11d:	4c 8d 59 10          	lea    0x10(%rcx),%r11
0121  121:	49 d1 ea             	shr    %r10
0124  124:	4c 89 d0             	mov    %r10,%rax
0127  127:	4d 85 d2             	test   %r10,%r10
012a  12a:	0f 85 3c ff ff ff    	jne    6c <poke_int3_handler+0x6c>
0130  130:	e9 1d ff ff ff       	jmpq   52 <poke_int3_handler+0x52>

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="poke_int3_handler-gcc9.asm"

0000 0000000000000000 <poke_int3_handler>:
0000    0:	f6 87 88 00 00 00 03 	testb  $0x3,0x88(%rdi)
0007    7:	75 4d                	jne    56 <poke_int3_handler+0x56>
0009    9:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 10 <poke_int3_handler+0x10>
000c 			c: R_X86_64_PC32	.bss+0x105c
0010   10:	48 85 d2             	test   %rdx,%rdx
0013   13:	74 41                	je     56 <poke_int3_handler+0x56>
0015   15:	8b 42 0c             	mov    0xc(%rdx),%eax
0018   18:	48 8d 4a 0c          	lea    0xc(%rdx),%rcx
001c   1c:	85 c0                	test   %eax,%eax
001e   1e:	74 36                	je     56 <poke_int3_handler+0x56>
0020   20:	8d 70 01             	lea    0x1(%rax),%esi
0023   23:	f0 0f b1 31          	lock cmpxchg %esi,(%rcx)
0027   27:	75 f3                	jne    1c <poke_int3_handler+0x1c>
0029   29:	4c 8b 8f 80 00 00 00 	mov    0x80(%rdi),%r9
0030   30:	48 63 42 08          	movslq 0x8(%rdx),%rax
0034   34:	48 8b 32             	mov    (%rdx),%rsi
0037   37:	49 8d 49 ff          	lea    -0x1(%r9),%rcx
003b   3b:	83 f8 01             	cmp    $0x1,%eax
003e   3e:	7f 19                	jg     59 <poke_int3_handler+0x59>
0040   40:	4c 63 06             	movslq (%rsi),%r8
0043   43:	31 c0                	xor    %eax,%eax
0045   45:	49 81 c0 00 00 00 00 	add    $0x0,%r8
0048 			48: R_X86_64_32S	_stext
004c   4c:	4c 39 c1             	cmp    %r8,%rcx
004f   4f:	74 39                	je     8a <poke_int3_handler+0x8a>
0051   51:	f0 ff 4a 0c          	lock decl 0xc(%rdx)
0055   55:	c3                   	retq   
0056   56:	31 c0                	xor    %eax,%eax
0058   58:	c3                   	retq   
0059   59:	49 89 f3             	mov    %rsi,%r11
005c   5c:	49 89 c2             	mov    %rax,%r10
005f   5f:	49 d1 ea             	shr    %r10
0062   62:	4c 89 d6             	mov    %r10,%rsi
0065   65:	48 c1 e6 04          	shl    $0x4,%rsi
0069   69:	4c 01 de             	add    %r11,%rsi
006c   6c:	4c 63 06             	movslq (%rsi),%r8
006f   6f:	49 81 c0 00 00 00 00 	add    $0x0,%r8
0072 			72: R_X86_64_32S	_stext
0076   76:	4c 39 c1             	cmp    %r8,%rcx
0079   79:	0f 82 a2 00 00 00    	jb     121 <poke_int3_handler+0x121>
007f   7f:	0f 87 83 00 00 00    	ja     108 <poke_int3_handler+0x108>
0085   85:	48 85 f6             	test   %rsi,%rsi
0088   88:	74 45                	je     cf <poke_int3_handler+0xcf>
008a   8a:	0f b6 46 08          	movzbl 0x8(%rsi),%eax
008e   8e:	44 8d 40 34          	lea    0x34(%rax),%r8d
0092   92:	41 80 f8 1f          	cmp    $0x1f,%r8b
0096   96:	76 02                	jbe    9a <poke_int3_handler+0x9a>
0098   98:	0f 0b                	ud2    
009a   9a:	45 0f b6 c0          	movzbl %r8b,%r8d
009e   9e:	4d 0f be 80 00 00 00 	movsbq 0x0(%r8),%r8
00a5   a5:	00 
00a2 			a2: R_X86_64_32S	.rodata+0x620
00a6   a6:	4c 01 c1             	add    %r8,%rcx
00a9   a9:	3c e8                	cmp    $0xe8,%al
00ab   ab:	74 29                	je     d6 <poke_int3_handler+0xd6>
00ad   ad:	76 1c                	jbe    cb <poke_int3_handler+0xcb>
00af   af:	83 e0 fd             	and    $0xfffffffd,%eax
00b2   b2:	3c e9                	cmp    $0xe9,%al
00b4   b4:	75 e2                	jne    98 <poke_int3_handler+0x98>
00b6   b6:	48 63 46 04          	movslq 0x4(%rsi),%rax
00ba   ba:	48 01 c1             	add    %rax,%rcx
00bd   bd:	b8 01 00 00 00       	mov    $0x1,%eax
00c2   c2:	48 89 8f 80 00 00 00 	mov    %rcx,0x80(%rdi)
00c9   c9:	eb 86                	jmp    51 <poke_int3_handler+0x51>
00cb   cb:	3c cc                	cmp    $0xcc,%al
00cd   cd:	75 c9                	jne    98 <poke_int3_handler+0x98>
00cf   cf:	31 c0                	xor    %eax,%eax
00d1   d1:	e9 7b ff ff ff       	jmpq   51 <poke_int3_handler+0x51>
00d6   d6:	48 63 46 04          	movslq 0x4(%rsi),%rax
00da   da:	49 83 c1 04          	add    $0x4,%r9
00de   de:	48 01 c1             	add    %rax,%rcx
00e1   e1:	48 8b 87 98 00 00 00 	mov    0x98(%rdi),%rax
00e8   e8:	48 8d 70 f8          	lea    -0x8(%rax),%rsi
00ec   ec:	48 89 b7 98 00 00 00 	mov    %rsi,0x98(%rdi)
00f3   f3:	4c 89 48 f8          	mov    %r9,-0x8(%rax)
00f7   f7:	b8 01 00 00 00       	mov    $0x1,%eax
00fc   fc:	48 89 8f 80 00 00 00 	mov    %rcx,0x80(%rdi)
0103  103:	e9 49 ff ff ff       	jmpq   51 <poke_int3_handler+0x51>
0108  108:	48 83 e8 01          	sub    $0x1,%rax
010c  10c:	4c 8d 5e 10          	lea    0x10(%rsi),%r11
0110  110:	48 d1 e8             	shr    %rax
0113  113:	48 85 c0             	test   %rax,%rax
0116  116:	0f 85 40 ff ff ff    	jne    5c <poke_int3_handler+0x5c>
011c  11c:	e9 30 ff ff ff       	jmpq   51 <poke_int3_handler+0x51>
0121  121:	4c 89 d0             	mov    %r10,%rax
0124  124:	eb ed                	jmp    113 <poke_int3_handler+0x113>

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="poke_int3_handler-gcc10.asm"

0000 0000000000000000 <poke_int3_handler>:
0000    0:	f6 87 88 00 00 00 03 	testb  $0x3,0x88(%rdi)
0007    7:	75 4d                	jne    56 <poke_int3_handler+0x56>
0009    9:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 10 <poke_int3_handler+0x10>
000c 			c: R_X86_64_PC32	.bss+0x105c
0010   10:	48 85 d2             	test   %rdx,%rdx
0013   13:	74 41                	je     56 <poke_int3_handler+0x56>
0015   15:	8b 42 0c             	mov    0xc(%rdx),%eax
0018   18:	48 8d 4a 0c          	lea    0xc(%rdx),%rcx
001c   1c:	85 c0                	test   %eax,%eax
001e   1e:	74 36                	je     56 <poke_int3_handler+0x56>
0020   20:	8d 70 01             	lea    0x1(%rax),%esi
0023   23:	f0 0f b1 31          	lock cmpxchg %esi,(%rcx)
0027   27:	75 f3                	jne    1c <poke_int3_handler+0x1c>
0029   29:	4c 8b 8f 80 00 00 00 	mov    0x80(%rdi),%r9
0030   30:	48 63 42 08          	movslq 0x8(%rdx),%rax
0034   34:	48 8b 32             	mov    (%rdx),%rsi
0037   37:	49 8d 49 ff          	lea    -0x1(%r9),%rcx
003b   3b:	83 f8 01             	cmp    $0x1,%eax
003e   3e:	7f 19                	jg     59 <poke_int3_handler+0x59>
0040   40:	4c 63 06             	movslq (%rsi),%r8
0043   43:	31 c0                	xor    %eax,%eax
0045   45:	49 81 c0 00 00 00 00 	add    $0x0,%r8
0048 			48: R_X86_64_32S	_stext
004c   4c:	4c 39 c1             	cmp    %r8,%rcx
004f   4f:	74 39                	je     8a <poke_int3_handler+0x8a>
0051   51:	f0 ff 4a 0c          	lock decl 0xc(%rdx)
0055   55:	c3                   	retq   
0056   56:	31 c0                	xor    %eax,%eax
0058   58:	c3                   	retq   
0059   59:	49 89 f3             	mov    %rsi,%r11
005c   5c:	49 89 c2             	mov    %rax,%r10
005f   5f:	49 d1 ea             	shr    %r10
0062   62:	4c 89 d6             	mov    %r10,%rsi
0065   65:	48 c1 e6 04          	shl    $0x4,%rsi
0069   69:	4c 01 de             	add    %r11,%rsi
006c   6c:	4c 63 06             	movslq (%rsi),%r8
006f   6f:	49 81 c0 00 00 00 00 	add    $0x0,%r8
0072 			72: R_X86_64_32S	_stext
0076   76:	4c 39 c1             	cmp    %r8,%rcx
0079   79:	0f 82 a2 00 00 00    	jb     121 <poke_int3_handler+0x121>
007f   7f:	0f 87 83 00 00 00    	ja     108 <poke_int3_handler+0x108>
0085   85:	48 85 f6             	test   %rsi,%rsi
0088   88:	74 45                	je     cf <poke_int3_handler+0xcf>
008a   8a:	0f b6 46 08          	movzbl 0x8(%rsi),%eax
008e   8e:	44 8d 40 34          	lea    0x34(%rax),%r8d
0092   92:	41 80 f8 1f          	cmp    $0x1f,%r8b
0096   96:	76 02                	jbe    9a <poke_int3_handler+0x9a>
0098   98:	0f 0b                	ud2    
009a   9a:	45 0f b6 c0          	movzbl %r8b,%r8d
009e   9e:	4d 0f be 80 00 00 00 	movsbq 0x0(%r8),%r8
00a5   a5:	00 
00a2 			a2: R_X86_64_32S	.rodata+0x620
00a6   a6:	4c 01 c1             	add    %r8,%rcx
00a9   a9:	3c e8                	cmp    $0xe8,%al
00ab   ab:	74 29                	je     d6 <poke_int3_handler+0xd6>
00ad   ad:	76 1c                	jbe    cb <poke_int3_handler+0xcb>
00af   af:	83 e0 fd             	and    $0xfffffffd,%eax
00b2   b2:	3c e9                	cmp    $0xe9,%al
00b4   b4:	75 e2                	jne    98 <poke_int3_handler+0x98>
00b6   b6:	48 63 46 04          	movslq 0x4(%rsi),%rax
00ba   ba:	48 01 c1             	add    %rax,%rcx
00bd   bd:	b8 01 00 00 00       	mov    $0x1,%eax
00c2   c2:	48 89 8f 80 00 00 00 	mov    %rcx,0x80(%rdi)
00c9   c9:	eb 86                	jmp    51 <poke_int3_handler+0x51>
00cb   cb:	3c cc                	cmp    $0xcc,%al
00cd   cd:	75 c9                	jne    98 <poke_int3_handler+0x98>
00cf   cf:	31 c0                	xor    %eax,%eax
00d1   d1:	e9 7b ff ff ff       	jmpq   51 <poke_int3_handler+0x51>
00d6   d6:	48 63 46 04          	movslq 0x4(%rsi),%rax
00da   da:	49 83 c1 04          	add    $0x4,%r9
00de   de:	48 01 c1             	add    %rax,%rcx
00e1   e1:	48 8b 87 98 00 00 00 	mov    0x98(%rdi),%rax
00e8   e8:	48 8d 70 f8          	lea    -0x8(%rax),%rsi
00ec   ec:	48 89 b7 98 00 00 00 	mov    %rsi,0x98(%rdi)
00f3   f3:	4c 89 48 f8          	mov    %r9,-0x8(%rax)
00f7   f7:	b8 01 00 00 00       	mov    $0x1,%eax
00fc   fc:	48 89 8f 80 00 00 00 	mov    %rcx,0x80(%rdi)
0103  103:	e9 49 ff ff ff       	jmpq   51 <poke_int3_handler+0x51>
0108  108:	48 83 e8 01          	sub    $0x1,%rax
010c  10c:	4c 8d 5e 10          	lea    0x10(%rsi),%r11
0110  110:	48 d1 e8             	shr    %rax
0113  113:	48 85 c0             	test   %rax,%rax
0116  116:	0f 85 40 ff ff ff    	jne    5c <poke_int3_handler+0x5c>
011c  11c:	e9 30 ff ff ff       	jmpq   51 <poke_int3_handler+0x51>
0121  121:	4c 89 d0             	mov    %r10,%rax
0124  124:	eb ed                	jmp    113 <poke_int3_handler+0x113>

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="poke_int3_handler-clang10.asm"

0000 0000000000000000 <poke_int3_handler>:
0000    0:	55                   	push   %rbp
0001    1:	48 89 e5             	mov    %rsp,%rbp
0004    4:	41 57                	push   %r15
0006    6:	41 56                	push   %r14
0008    8:	41 55                	push   %r13
000a    a:	41 54                	push   %r12
000c    c:	53                   	push   %rbx
000d    d:	45 31 ff             	xor    %r15d,%r15d
0010   10:	f6 87 88 00 00 00 03 	testb  $0x3,0x88(%rdi)
0017   17:	0f 85 3a 01 00 00    	jne    157 <poke_int3_handler+0x157>
001d   1d:	4c 8b 2d 00 00 00 00 	mov    0x0(%rip),%r13        # 24 <poke_int3_handler+0x24>
0020 			20: R_X86_64_PC32	.bss+0x4
0024   24:	4d 85 ed             	test   %r13,%r13
0027   27:	0f 84 2a 01 00 00    	je     157 <poke_int3_handler+0x157>
002d   2d:	45 8b 65 0c          	mov    0xc(%r13),%r12d
0031   31:	45 85 e4             	test   %r12d,%r12d
0034   34:	0f 84 1d 01 00 00    	je     157 <poke_int3_handler+0x157>
003a   3a:	49 89 fe             	mov    %rdi,%r14
003d   3d:	0f 1f 00             	nopl   (%rax)
0040   40:	41 8d 4c 24 01       	lea    0x1(%r12),%ecx
0045   45:	31 db                	xor    %ebx,%ebx
0047   47:	44 89 e0             	mov    %r12d,%eax
004a   4a:	f0 41 0f b1 4d 0c    	lock cmpxchg %ecx,0xc(%r13)
0050   50:	0f 94 c3             	sete   %bl
0053   53:	41 89 c4             	mov    %eax,%r12d
0056   56:	80 fb 01             	cmp    $0x1,%bl
0059   59:	77 0e                	ja     69 <poke_int3_handler+0x69>
005b   5b:	84 db                	test   %bl,%bl
005d   5d:	75 2c                	jne    8b <poke_int3_handler+0x8b>
005f   5f:	45 85 e4             	test   %r12d,%r12d
0062   62:	75 dc                	jne    40 <poke_int3_handler+0x40>
0064   64:	e9 ee 00 00 00       	jmpq   157 <poke_int3_handler+0x157>
0069   69:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
006c 			6c: R_X86_64_32S	.data+0x160
0070   70:	48 89 de             	mov    %rbx,%rsi
0073   73:	e8 00 00 00 00       	callq  78 <poke_int3_handler+0x78>
0074 			74: R_X86_64_PLT32	__ubsan_handle_load_invalid_value-0x4
0078   78:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
007b 			7b: R_X86_64_32S	.data+0x180
007f   7f:	48 89 de             	mov    %rbx,%rsi
0082   82:	e8 00 00 00 00       	callq  87 <poke_int3_handler+0x87>
0083 			83: R_X86_64_PLT32	__ubsan_handle_load_invalid_value-0x4
0087   87:	84 db                	test   %bl,%bl
0089   89:	74 d4                	je     5f <poke_int3_handler+0x5f>
008b   8b:	49 8b 86 80 00 00 00 	mov    0x80(%r14),%rax
0092   92:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
0096   96:	41 83 7d 08 02       	cmpl   $0x2,0x8(%r13)
009b   9b:	0f 8d c4 00 00 00    	jge    165 <poke_int3_handler+0x165>
00a1   a1:	49 8b 4d 00          	mov    0x0(%r13),%rcx
00a5   a5:	48 63 11             	movslq (%rcx),%rdx
00a8   a8:	48 8d 92 00 00 00 00 	lea    0x0(%rdx),%rdx
00ab 			ab: R_X86_64_32S	_stext
00af   af:	45 31 ff             	xor    %r15d,%r15d
00b2   b2:	48 39 c2             	cmp    %rax,%rdx
00b5   b5:	0f 85 97 00 00 00    	jne    152 <poke_int3_handler+0x152>
00bb   bb:	8a 59 08             	mov    0x8(%rcx),%bl
00be   be:	31 d2                	xor    %edx,%edx
00c0   c0:	80 fb e8             	cmp    $0xe8,%bl
00c3   c3:	7f 0c                	jg     d1 <poke_int3_handler+0xd1>
00c5   c5:	80 fb cc             	cmp    $0xcc,%bl
00c8   c8:	74 1f                	je     e9 <poke_int3_handler+0xe9>
00ca   ca:	80 fb e8             	cmp    $0xe8,%bl
00cd   cd:	74 13                	je     e2 <poke_int3_handler+0xe2>
00cf   cf:	eb 1d                	jmp    ee <poke_int3_handler+0xee>
00d1   d1:	80 fb e9             	cmp    $0xe9,%bl
00d4   d4:	74 0c                	je     e2 <poke_int3_handler+0xe2>
00d6   d6:	80 fb eb             	cmp    $0xeb,%bl
00d9   d9:	75 13                	jne    ee <poke_int3_handler+0xee>
00db   db:	ba 02 00 00 00       	mov    $0x2,%edx
00e0   e0:	eb 0c                	jmp    ee <poke_int3_handler+0xee>
00e2   e2:	ba 05 00 00 00       	mov    $0x5,%edx
00e7   e7:	eb 05                	jmp    ee <poke_int3_handler+0xee>
00e9   e9:	ba 01 00 00 00       	mov    $0x1,%edx
00ee   ee:	48 01 d0             	add    %rdx,%rax
00f1   f1:	8a 51 08             	mov    0x8(%rcx),%dl
00f4   f4:	80 fa e8             	cmp    $0xe8,%dl
00f7   f7:	7f 3b                	jg     134 <poke_int3_handler+0x134>
00f9   f9:	45 31 ff             	xor    %r15d,%r15d
00fc   fc:	80 fa cc             	cmp    $0xcc,%dl
00ff   ff:	74 51                	je     152 <poke_int3_handler+0x152>
0101  101:	80 fa e8             	cmp    $0xe8,%dl
0104  104:	0f 85 b1 00 00 00    	jne    1bb <poke_int3_handler+0x1bb>
010a  10a:	48 63 49 04          	movslq 0x4(%rcx),%rcx
010e  10e:	48 01 c1             	add    %rax,%rcx
0111  111:	49 8b 86 80 00 00 00 	mov    0x80(%r14),%rax
0118  118:	49 8b 96 98 00 00 00 	mov    0x98(%r14),%rdx
011f  11f:	48 83 c0 04          	add    $0x4,%rax
0123  123:	48 8d 72 f8          	lea    -0x8(%rdx),%rsi
0127  127:	49 89 b6 98 00 00 00 	mov    %rsi,0x98(%r14)
012e  12e:	48 89 42 f8          	mov    %rax,-0x8(%rdx)
0132  132:	eb 11                	jmp    145 <poke_int3_handler+0x145>
0134  134:	80 fa e9             	cmp    $0xe9,%dl
0137  137:	74 05                	je     13e <poke_int3_handler+0x13e>
0139  139:	80 fa eb             	cmp    $0xeb,%dl
013c  13c:	75 7d                	jne    1bb <poke_int3_handler+0x1bb>
013e  13e:	48 63 49 04          	movslq 0x4(%rcx),%rcx
0142  142:	48 01 c1             	add    %rax,%rcx
0145  145:	49 89 8e 80 00 00 00 	mov    %rcx,0x80(%r14)
014c  14c:	41 bf 01 00 00 00    	mov    $0x1,%r15d
0152  152:	f0 41 ff 4d 0c       	lock decl 0xc(%r13)
0157  157:	44 89 f8             	mov    %r15d,%eax
015a  15a:	5b                   	pop    %rbx
015b  15b:	41 5c                	pop    %r12
015d  15d:	41 5d                	pop    %r13
015f  15f:	41 5e                	pop    %r14
0161  161:	41 5f                	pop    %r15
0163  163:	5d                   	pop    %rbp
0164  164:	c3                   	retq   
0165  165:	49 63 55 08          	movslq 0x8(%r13),%rdx
0169  169:	45 31 ff             	xor    %r15d,%r15d
016c  16c:	48 85 d2             	test   %rdx,%rdx
016f  16f:	74 e1                	je     152 <poke_int3_handler+0x152>
0171  171:	49 8b 4d 00          	mov    0x0(%r13),%rcx
0175  175:	eb 05                	jmp    17c <poke_int3_handler+0x17c>
0177  177:	48 d1 ea             	shr    %rdx
017a  17a:	74 d6                	je     152 <poke_int3_handler+0x152>
017c  17c:	48 89 d6             	mov    %rdx,%rsi
017f  17f:	48 83 e6 fe          	and    $0xfffffffffffffffe,%rsi
0183  183:	48 63 3c f1          	movslq (%rcx,%rsi,8),%rdi
0187  187:	48 8d bf 00 00 00 00 	lea    0x0(%rdi),%rdi
018a 			18a: R_X86_64_32S	_stext
018e  18e:	48 39 c7             	cmp    %rax,%rdi
0191  191:	77 e4                	ja     177 <poke_int3_handler+0x177>
0193  193:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
0197  197:	48 63 31             	movslq (%rcx),%rsi
019a  19a:	48 8d b6 00 00 00 00 	lea    0x0(%rsi),%rsi
019d 			19d: R_X86_64_32S	_stext
01a1  1a1:	48 39 c6             	cmp    %rax,%rsi
01a4  1a4:	73 0a                	jae    1b0 <poke_int3_handler+0x1b0>
01a6  1a6:	48 83 c1 10          	add    $0x10,%rcx
01aa  1aa:	48 83 c2 ff          	add    $0xffffffffffffffff,%rdx
01ae  1ae:	eb c7                	jmp    177 <poke_int3_handler+0x177>
01b0  1b0:	48 85 c9             	test   %rcx,%rcx
01b3  1b3:	0f 85 02 ff ff ff    	jne    bb <poke_int3_handler+0xbb>
01b9  1b9:	eb 97                	jmp    152 <poke_int3_handler+0x152>
01bb  1bb:	0f 0b                	ud2    
01bd  1bd:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
01c0 			1c0: R_X86_64_32S	.data+0xc0
01c4  1c4:	e8 00 00 00 00       	callq  1c9 <int3_selftest>
01c5 			1c5: R_X86_64_PLT32	__ubsan_handle_builtin_unreachable-0x4

--xHFwDpU9dbj6ez1V--
