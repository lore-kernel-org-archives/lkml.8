Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D498C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F4F206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xIRFpphT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgENLY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgENLY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:24:27 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7104CC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=p1K8U6shp5UmBYCP6t2ymmjUygTLxAmDYC66KGaw0Mw=; b=xIRFpphTFZqW81LserbT3tPZ+Q
        022eQ7Km1NJ3NdkIo7UWwe5+tBj67wdxDE/0NooPBO7cko5VxEIpgMHpr1aEsfdrnqL53C4BP6Dy4
        resVadXN1WDJlJ5NMvEvwWKvh++ym6GV95hWDdKj+7EhD1a5F0MP0JfLFZyhhHbEXPktChFBkXDWH
        EOaw5XZMrwlbvBbxZYLFktccQkv5Z7r1H5p28fsY+J9dAE/94QDC+CafU5AStaUxni9MbkklvTXKG
        WZNbMrb6JV0PcCTL0DMvLMYv9YxUTKIIccMe3KkZUAtQo//POGYnacURLoqlMJV3XLrYrj+yF8ieP
        Zf+d53hA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZByC-0005Bi-5K; Thu, 14 May 2020 11:24:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C97CE301A66;
        Thu, 14 May 2020 13:24:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0F1D213C8B5C; Thu, 14 May 2020 13:24:05 +0200 (CEST)
Date:   Thu, 14 May 2020 13:24:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514112405.GF3001@hirez.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200514112142.GV2978@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:21:42PM +0200, Peter Zijlstra wrote:
> On Wed, May 13, 2020 at 03:58:30PM +0200, Marco Elver wrote:
> > On Wed, 13 May 2020 at 15:24, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, May 13, 2020 at 03:15:55PM +0200, Marco Elver wrote:
> > > > So far so good, except: both __no_sanitize_or_inline and
> > > > __no_kcsan_or_inline *do* avoid KCSAN instrumenting plain accesses, it
> > > > just doesn't avoid explicit kcsan_check calls, like those in
> > > > READ/WRITE_ONCE if KCSAN is enabled for the compilation unit. That's
> > > > just because macros won't be redefined just for __no_sanitize
> > > > functions. Similarly, READ_ONCE_NOCHECK does work as expected, and its
> > > > access is unchecked.
> > > >
> > > > This will have the expected result:
> > > > __no_sanitize_or_inline void foo(void) { x++; } // no data races reported
> > > >
> > > > This will not work as expected:
> > > > __no_sanitize_or_inline void foo(void) { READ_ONCE(x); }  // data
> > > > races are reported
> > > >
> > > > All this could be fixed if GCC devs would finally take my patch to
> > > > make -fsanitize=thread distinguish volatile [1], but then we have to
> > > > wait ~years for the new compilers to reach us. So please don't hold
> > > > your breath for this one any time soon.
> > > > [1] https://gcc.gnu.org/pipermail/gcc-patches/2020-April/544452.html
> > >
> > > Right, but that does not address the much larger issue of the attribute
> > > vs inline tranwreck :/
> > 
> > Could you check if Clang is equally broken for you? I think GCC and
> > Clang have differing behaviour on this. No idea what it takes to fix
> > GCC though.
> 
> So I have some good and some maybe not so good news.
> 
> Given the patch below (on top of tglx's entry-v5-the-rest tag); I did
> find that I could actually build alternative.o for gcc-{8,9,10} and
> indeed clang-10. Any earlier gcc (I tried, 5,6,7) does not build:
> 
> ../arch/x86/include/asm/ptrace.h:126:28: error: inlining failed in call to always_inline ‘user_mode’: function attribute mismatch
> 
> I dumped the poke_int3_handler output using objdump, find the attached
> files.
> 
> It looks like clang-10 doesn't want to turn UBSAN off :/ The GCC files
> look OK, no funny calls in those.
> 
> (the config has KASAN/UBSAN on, it looks like KCSAN and KASAN are
> mutually exclusive)

I just swapped them and rebuild with gcc-10 and that still looks ok.


0000 0000000000000000 <poke_int3_handler>:
0000    0:	f6 87 88 00 00 00 03 	testb  $0x3,0x88(%rdi)
0007    7:	75 4d                	jne    56 <poke_int3_handler+0x56>
0009    9:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 10 <poke_int3_handler+0x10>
000c 			c: R_X86_64_PC32	.bss+0x101c
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
00a2 			a2: R_X86_64_32S	.rodata
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
