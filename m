Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478B0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1367D2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b/wvZMnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgENLf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgENLfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:35:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA161C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=//65VJ/88ZdeuVpaCtLLqy3KqxmQj36kHuEM9c2d5q4=; b=b/wvZMnCK0wmNs19rTKEMsyKHH
        qJ2LJbJhhu2n3WkBF2y0PEulCGBwDVvG88LR+TXjC6MXaJEC4ewmEmDgRpAgYLvlvqBuJNVtUvIGo
        liQ8bLRl0fQ/k0589sYkN4W5Sp8qZa40nyJAnqfu7ahyZoYKWHeBTTCfr9l+eGmojNXpNVs0xp9Ow
        /bb/6B/ISoKlnez9H0Xg0sbauGmIfO6XXf69FBvYXsk3KMLd+WcavbjdqzmpQOKREhtGSaqp80UnC
        Hc6JuVAvoqMwWOWuWCLAsSteTTwJti35mprYPJw5MNeU4CDuxvvVWzwUWcT8xJlOwHl5DAktop70F
        iSDsrtzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZC9V-00046O-8J; Thu, 14 May 2020 11:35:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 258C6300455;
        Thu, 14 May 2020 13:35:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CC77213C8B5C; Thu, 14 May 2020 13:35:47 +0200 (CEST)
Date:   Thu, 14 May 2020 13:35:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514113547.GG3001@hirez.programming.kicks-ass.net>
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
> So I have some good and some maybe not so good news.
> 
> Given the patch below (on top of tglx's entry-v5-the-rest tag); I did
> find that I could actually build alternative.o for gcc-{8,9,10} and
> indeed clang-10. 


And, for completeness, here's the vomit from gcc-10 without the patch
for a KASAN+UBSAN build:


0000 0000000000000000 <poke_int3_handler>:
0000    0:	41 57                	push   %r15
0002    2:	41 56                	push   %r14
0004    4:	41 55                	push   %r13
0006    6:	41 54                	push   %r12
0008    8:	55                   	push   %rbp
0009    9:	53                   	push   %rbx
000a    a:	48 89 fb             	mov    %rdi,%rbx
000d    d:	48 81 c7 88 00 00 00 	add    $0x88,%rdi
0014   14:	48 83 ec 10          	sub    $0x10,%rsp
0018   18:	e8 00 00 00 00       	callq  1d <poke_int3_handler+0x1d>
0019 			19: R_X86_64_PLT32	__asan_load8_noabort-0x4
001d   1d:	f6 83 88 00 00 00 03 	testb  $0x3,0x88(%rbx)
0024   24:	0f 85 99 00 00 00    	jne    c3 <poke_int3_handler+0xc3>
002a   2a:	48 8b 2d 00 00 00 00 	mov    0x0(%rip),%rbp        # 31 <poke_int3_handler+0x31>
002d 			2d: R_X86_64_PC32	.bss+0x105c
0031   31:	48 85 ed             	test   %rbp,%rbp
0034   34:	0f 84 89 00 00 00    	je     c3 <poke_int3_handler+0xc3>
003a   3a:	4c 8d 65 0c          	lea    0xc(%rbp),%r12
003e   3e:	4c 89 e7             	mov    %r12,%rdi
0041   41:	e8 00 00 00 00       	callq  46 <poke_int3_handler+0x46>
0042 			42: R_X86_64_PLT32	__asan_load4_noabort-0x4
0046   46:	8b 45 0c             	mov    0xc(%rbp),%eax
0049   49:	85 c0                	test   %eax,%eax
004b   4b:	74 76                	je     c3 <poke_int3_handler+0xc3>
004d   4d:	8d 50 01             	lea    0x1(%rax),%edx
0050   50:	f0 41 0f b1 14 24    	lock cmpxchg %edx,(%r12)
0056   56:	75 f1                	jne    49 <poke_int3_handler+0x49>
0058   58:	48 8d bb 80 00 00 00 	lea    0x80(%rbx),%rdi
005f   5f:	e8 00 00 00 00       	callq  64 <poke_int3_handler+0x64>
0060 			60: R_X86_64_PLT32	__asan_load8_noabort-0x4
0064   64:	48 8b 83 80 00 00 00 	mov    0x80(%rbx),%rax
006b   6b:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
006f   6f:	48 89 04 24          	mov    %rax,(%rsp)
0073   73:	4c 8d 60 ff          	lea    -0x1(%rax),%r12
0077   77:	e8 00 00 00 00       	callq  7c <poke_int3_handler+0x7c>
0078 			78: R_X86_64_PLT32	__asan_load4_noabort-0x4
007c   7c:	4c 63 7d 08          	movslq 0x8(%rbp),%r15
0080   80:	48 89 ef             	mov    %rbp,%rdi
0083   83:	e8 00 00 00 00       	callq  88 <poke_int3_handler+0x88>
0084 			84: R_X86_64_PLT32	__asan_load8_noabort-0x4
0088   88:	4c 8b 6d 00          	mov    0x0(%rbp),%r13
008c   8c:	41 83 ff 01          	cmp    $0x1,%r15d
0090   90:	7f 36                	jg     c8 <poke_int3_handler+0xc8>
0092   92:	4c 89 ef             	mov    %r13,%rdi
0095   95:	e8 00 00 00 00       	callq  9a <poke_int3_handler+0x9a>
0096 			96: R_X86_64_PLT32	__asan_load4_noabort-0x4
009a   9a:	49 63 55 00          	movslq 0x0(%r13),%rdx
009e   9e:	45 31 c0             	xor    %r8d,%r8d
00a1   a1:	48 81 c2 00 00 00 00 	add    $0x0,%rdx
00a4 			a4: R_X86_64_32S	_stext
00a8   a8:	49 39 d4             	cmp    %rdx,%r12
00ab   ab:	74 5d                	je     10a <poke_int3_handler+0x10a>
00ad   ad:	f0 ff 4d 0c          	lock decl 0xc(%rbp)
00b1   b1:	48 83 c4 10          	add    $0x10,%rsp
00b5   b5:	44 89 c0             	mov    %r8d,%eax
00b8   b8:	5b                   	pop    %rbx
00b9   b9:	5d                   	pop    %rbp
00ba   ba:	41 5c                	pop    %r12
00bc   bc:	41 5d                	pop    %r13
00be   be:	41 5e                	pop    %r14
00c0   c0:	41 5f                	pop    %r15
00c2   c2:	c3                   	retq   
00c3   c3:	45 31 c0             	xor    %r8d,%r8d
00c6   c6:	eb e9                	jmp    b1 <poke_int3_handler+0xb1>
00c8   c8:	4c 89 6c 24 08       	mov    %r13,0x8(%rsp)
00cd   cd:	4d 89 fe             	mov    %r15,%r14
00d0   d0:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
00d5   d5:	49 d1 ee             	shr    %r14
00d8   d8:	4c 89 f0             	mov    %r14,%rax
00db   db:	48 c1 e0 04          	shl    $0x4,%rax
00df   df:	4c 8d 2c 06          	lea    (%rsi,%rax,1),%r13
00e3   e3:	4c 89 ef             	mov    %r13,%rdi
00e6   e6:	e8 00 00 00 00       	callq  eb <poke_int3_handler+0xeb>
00e7 			e7: R_X86_64_PLT32	__asan_load4_noabort-0x4
00eb   eb:	49 63 4d 00          	movslq 0x0(%r13),%rcx
00ef   ef:	48 81 c1 00 00 00 00 	add    $0x0,%rcx
00f2 			f2: R_X86_64_32S	_stext
00f6   f6:	49 39 cc             	cmp    %rcx,%r12
00f9   f9:	0f 82 fd 00 00 00    	jb     1fc <poke_int3_handler+0x1fc>
00ff   ff:	0f 87 d9 00 00 00    	ja     1de <poke_int3_handler+0x1de>
0105  105:	4d 85 ed             	test   %r13,%r13
0108  108:	74 7b                	je     185 <poke_int3_handler+0x185>
010a  10a:	49 8d 7d 08          	lea    0x8(%r13),%rdi
010e  10e:	e8 00 00 00 00       	callq  113 <poke_int3_handler+0x113>
010f 			10f: R_X86_64_PLT32	__asan_load1_noabort-0x4
0113  113:	45 0f b6 75 08       	movzbl 0x8(%r13),%r14d
0118  118:	45 8d 7e 34          	lea    0x34(%r14),%r15d
011c  11c:	41 80 ff 1f          	cmp    $0x1f,%r15b
0120  120:	76 0e                	jbe    130 <poke_int3_handler+0x130>
0122  122:	0f 0b                	ud2    
0124  124:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
0127 			127: R_X86_64_32S	.data+0xc0
012b  12b:	e8 00 00 00 00       	callq  130 <poke_int3_handler+0x130>
012c 			12c: R_X86_64_PLT32	__ubsan_handle_builtin_unreachable-0x4
0130  130:	45 0f b6 ff          	movzbl %r15b,%r15d
0134  134:	49 8d bf 00 00 00 00 	lea    0x0(%r15),%rdi
0137 			137: R_X86_64_32S	.rodata+0x620
013b  13b:	e8 00 00 00 00       	callq  140 <poke_int3_handler+0x140>
013c 			13c: R_X86_64_PLT32	__asan_load1_noabort-0x4
0140  140:	49 0f be 97 00 00 00 	movsbq 0x0(%r15),%rdx
0147  147:	00 
0144 			144: R_X86_64_32S	.rodata+0x620
0148  148:	49 01 d4             	add    %rdx,%r12
014b  14b:	41 80 fe e8          	cmp    $0xe8,%r14b
014f  14f:	74 3c                	je     18d <poke_int3_handler+0x18d>
0151  151:	76 2c                	jbe    17f <poke_int3_handler+0x17f>
0153  153:	41 83 e6 fd          	and    $0xfffffffd,%r14d
0157  157:	41 80 fe e9          	cmp    $0xe9,%r14b
015b  15b:	75 c5                	jne    122 <poke_int3_handler+0x122>
015d  15d:	49 8d 7d 04          	lea    0x4(%r13),%rdi
0161  161:	e8 00 00 00 00       	callq  166 <poke_int3_handler+0x166>
0162 			162: R_X86_64_PLT32	__asan_load4_noabort-0x4
0166  166:	49 63 45 04          	movslq 0x4(%r13),%rax
016a  16a:	41 b8 01 00 00 00    	mov    $0x1,%r8d
0170  170:	49 01 c4             	add    %rax,%r12
0173  173:	4c 89 a3 80 00 00 00 	mov    %r12,0x80(%rbx)
017a  17a:	e9 2e ff ff ff       	jmpq   ad <poke_int3_handler+0xad>
017f  17f:	41 80 fe cc          	cmp    $0xcc,%r14b
0183  183:	75 9d                	jne    122 <poke_int3_handler+0x122>
0185  185:	45 31 c0             	xor    %r8d,%r8d
0188  188:	e9 20 ff ff ff       	jmpq   ad <poke_int3_handler+0xad>
018d  18d:	49 8d 7d 04          	lea    0x4(%r13),%rdi
0191  191:	e8 00 00 00 00       	callq  196 <poke_int3_handler+0x196>
0192 			192: R_X86_64_PLT32	__asan_load4_noabort-0x4
0196  196:	49 63 45 04          	movslq 0x4(%r13),%rax
019a  19a:	48 8d bb 98 00 00 00 	lea    0x98(%rbx),%rdi
01a1  1a1:	49 01 c4             	add    %rax,%r12
01a4  1a4:	e8 00 00 00 00       	callq  1a9 <poke_int3_handler+0x1a9>
01a5 			1a5: R_X86_64_PLT32	__asan_load8_noabort-0x4
01a9  1a9:	4c 8b b3 98 00 00 00 	mov    0x98(%rbx),%r14
01b0  1b0:	49 8d 7e f8          	lea    -0x8(%r14),%rdi
01b4  1b4:	48 89 bb 98 00 00 00 	mov    %rdi,0x98(%rbx)
01bb  1bb:	e8 00 00 00 00       	callq  1c0 <poke_int3_handler+0x1c0>
01bc 			1bc: R_X86_64_PLT32	__asan_store8_noabort-0x4
01c0  1c0:	4c 8b 2c 24          	mov    (%rsp),%r13
01c4  1c4:	41 b8 01 00 00 00    	mov    $0x1,%r8d
01ca  1ca:	49 83 c5 04          	add    $0x4,%r13
01ce  1ce:	4d 89 6e f8          	mov    %r13,-0x8(%r14)
01d2  1d2:	4c 89 a3 80 00 00 00 	mov    %r12,0x80(%rbx)
01d9  1d9:	e9 cf fe ff ff       	jmpq   ad <poke_int3_handler+0xad>
01de  1de:	49 8d 45 10          	lea    0x10(%r13),%rax
01e2  1e2:	4d 8d 77 ff          	lea    -0x1(%r15),%r14
01e6  1e6:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
01eb  1eb:	49 d1 ee             	shr    %r14
01ee  1ee:	4d 89 f7             	mov    %r14,%r15
01f1  1f1:	4d 85 ff             	test   %r15,%r15
01f4  1f4:	0f 85 d3 fe ff ff    	jne    cd <poke_int3_handler+0xcd>
01fa  1fa:	eb 89                	jmp    185 <poke_int3_handler+0x185>
01fc  1fc:	4d 89 f7             	mov    %r14,%r15
01ff  1ff:	eb f0                	jmp    1f1 <poke_int3_handler+0x1f1>
