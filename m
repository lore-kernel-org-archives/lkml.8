Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1854C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C12207CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W8mh/20v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbgEYLBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYLBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:01:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9524DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1/gKDhFHDjNpN7tWsOSQPyntqkEKGrHzc3PdYJ2+BaM=; b=W8mh/20vV+FLKHWSqS3FsjXVKI
        KEwWc0i5a6hlLeyou8Kvo71Arc40SckwQYpEkA+1Er50p0FAGObICceW25q/ZDxRZ2mVKNxDeNb2m
        Emw16Lly1GiJBFkyvV+vKz6Mew+auK3ZtZisMOIfZjDX9qwLZZZZGiwYKPZJbrw4ko4OcMAMnMx0e
        rEiAxa+N4VgFTWjh329k1J5Xd07td+wWWcPAnXukd5yzhONgh08HZYzpareEEDsVoCU0kG6mtIPD5
        UsXf54pzTI8j5SORPZJxH9GyHs114e32yw8DX6mLj86g0tg4SL6hR1RrE6xR758/CXS3CSzSu0r18
        hc6AaeMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdAqt-0007bQ-U6; Mon, 25 May 2020 11:01:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E240F300B38;
        Mon, 25 May 2020 13:01:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBC3C286BFC18; Mon, 25 May 2020 13:01:01 +0200 (CEST)
Date:   Mon, 25 May 2020 13:01:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [RFC][PATCH 0/4] x86/entry: disallow #DB more
Message-ID: <20200525110101.GG325303@hirez.programming.kicks-ass.net>
References: <20200522204738.645043059@infradead.org>
 <CALCETrV7GYg5V5dgM9BToc6RAqpcjRdoZoeXbnrTKTqjBfft6g@mail.gmail.com>
 <20200523125940.GA2483@worktop.programming.kicks-ass.net>
 <20200523213235.GB4496@worktop.programming.kicks-ass.net>
 <cd2f91e4-aa90-eb98-7f8c-218e8521ac85@rasmusvillemoes.dk>
 <20200525104038.GC317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525104038.GC317569@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 12:40:38PM +0200, Peter Zijlstra wrote:
> On Mon, May 25, 2020 at 12:02:48PM +0200, Rasmus Villemoes wrote:
> 
> > Naive question: did you check disassembly to see whether gcc threw your
> > native_get_debugreg() away, given that the asm isn't volatile and the
> > result is not used for anything? Testing here only shows a "mov
> > %r9,%db7", but the read did seem to get thrown away.
> 
> Argh.. no I did not. Writing it all in asm gets me:
> 
> [    1.627405] XXX: 3900 8304 22632
> 
> which is a lot worse...

+	u64 empty = 0, read = 0, write = 0, cpu = 0, cpu1 = 0;
+	unsigned long dr7;
+
+	for (i=0; i<100; i++) {
+		u64 s;
+
+		s = rdtsc();
+		asm volatile ("lfence; lfence;");
+		empty += rdtsc() - s;
+
+		s = rdtsc();
+		asm volatile ("lfence; mov %%db7, %0; lfence;" : "=r" (dr7));
+		read += rdtsc() - s;
+
+		s = rdtsc();
+		asm volatile ("lfence; mov %0, %%db7; lfence;" :: "r" (dr7));
+		write += rdtsc() - s;
+
+		s = rdtsc();
+		asm volatile ("lfence; mov %0, %%db7; lfence;" :: "r" (dr7));
+		write += rdtsc() - s;
+
+		clflush(this_cpu_ptr(&cpu_dr7));
+
+		s = rdtsc();
+		asm volatile ("lfence;");
+		dr7 = this_cpu_read(cpu_dr7);
+		asm volatile ("lfence;");
+		cpu += rdtsc() - s;
+
+		s = rdtsc();
+		asm volatile ("lfence;");
+		dr7 = this_cpu_read(cpu_dr7);
+		asm volatile ("lfence;");
+		cpu1 += rdtsc() - s;
+	}
+
+	printk("XXX: %ld %ld %ld %ld %ld\n", empty, read, write, cpu, cpu1);

[    1.628252] XXX: 3820 8224 45516 35560 4800

Which still seems to suggest using DR7 directly is probably a good
thing. It's slower than a L1 hit, but massively faster than a full miss.

---

11f:   0f 31                   rdtsc
121:   48 89 d1                mov    %rdx,%rcx
124:   48 89 c6                mov    %rax,%rsi
127:   0f ae e8                lfence
12a:   0f ae e8                lfence
12d:   0f 31                   rdtsc
12f:   48 c1 e2 20             shl    $0x20,%rdx
133:   48 c1 e1 20             shl    $0x20,%rcx
137:   48 09 c2                or     %rax,%rdx
13a:   48 09 f1                or     %rsi,%rcx
13d:   48 29 ca                sub    %rcx,%rdx
140:   48 01 d3                add    %rdx,%rbx
143:   0f 31                   rdtsc
145:   48 89 d1                mov    %rdx,%rcx
148:   48 89 c6                mov    %rax,%rsi
14b:   0f ae e8                lfence
14e:   41 0f 21 fb             mov    %db7,%r11
152:   0f ae e8                lfence
155:   0f 31                   rdtsc
157:   48 c1 e2 20             shl    $0x20,%rdx
15b:   48 c1 e1 20             shl    $0x20,%rcx
15f:   48 09 c2                or     %rax,%rdx
162:   48 09 f1                or     %rsi,%rcx
165:   48 29 ca                sub    %rcx,%rdx
168:   48 01 d5                add    %rdx,%rbp
16b:   0f 31                   rdtsc
16d:   48 89 d6                mov    %rdx,%rsi
170:   49 89 c1                mov    %rax,%r9
173:   0f ae e8                lfence
176:   41 0f 23 fb             mov    %r11,%db7
17a:   0f ae e8                lfence
17d:   0f 31                   rdtsc
17f:   48 89 d7                mov    %rdx,%rdi
182:   49 89 c2                mov    %rax,%r10
185:   0f 31                   rdtsc
187:   48 89 d1                mov    %rdx,%rcx
18a:   49 89 c0                mov    %rax,%r8
18d:   0f ae e8                lfence
190:   41 0f 23 fb             mov    %r11,%db7
194:   0f ae e8                lfence
197:   0f 31                   rdtsc
199:   48 c1 e2 20             shl    $0x20,%rdx
19d:   48 c1 e6 20             shl    $0x20,%rsi
1a1:   48 09 c2                or     %rax,%rdx
1a4:   48 89 f8                mov    %rdi,%rax
1a7:   48 c1 e1 20             shl    $0x20,%rcx
1ab:   48 c1 e0 20             shl    $0x20,%rax
1af:   49 09 f1                or     %rsi,%r9
1b2:   49 09 c8                or     %rcx,%r8
1b5:   49 09 c2                or     %rax,%r10
1b8:   4a 8d 04 12             lea    (%rdx,%r10,1),%rax
1bc:   48 c7 c2 00 00 00 00    mov    $0x0,%rdx
			1bf: R_X86_64_32S       cpu_dr7
1c3:   4c 29 c8                sub    %r9,%rax
1c6:   4c 29 c0                sub    %r8,%rax
1c9:   49 01 c4                add    %rax,%r12
1cc:   48 89 14 24             mov    %rdx,(%rsp)
1d0:   48 89 54 24 08          mov    %rdx,0x8(%rsp)
1d5:   e8 00 00 00 00          callq  1da <sched_init+0xe1>
			1d6: R_X86_64_PLT32     debug_smp_processor_id-0x4
1da:   48 c7 c1 00 00 00 00    mov    $0x0,%rcx
			1dd: R_X86_64_32S       __per_cpu_offset
1e1:   48 8b 14 24             mov    (%rsp),%rdx
1e5:   89 c0                   mov    %eax,%eax
1e7:   48 03 14 c1             add    (%rcx,%rax,8),%rdx
1eb:   0f ae 3a                clflush (%rdx)
1ee:   0f 31                   rdtsc
1f0:   48 89 d1                mov    %rdx,%rcx
1f3:   48 89 c6                mov    %rax,%rsi
1f6:   0f ae e8                lfence
1f9:   65 48 8b 05 00 00 00    mov    %gs:0x0(%rip),%rax        # 201 <sched_init+0x108>
200:   00
			1fd: R_X86_64_PC32      cpu_dr7-0x4
201:   0f ae e8                lfence
204:   0f 31                   rdtsc
206:   48 c1 e2 20             shl    $0x20,%rdx
20a:   48 c1 e1 20             shl    $0x20,%rcx
20e:   48 09 c2                or     %rax,%rdx
211:   48 09 f1                or     %rsi,%rcx
214:   48 29 ca                sub    %rcx,%rdx
217:   49 01 d5                add    %rdx,%r13
21a:   0f 31                   rdtsc
21c:   48 89 d1                mov    %rdx,%rcx
21f:   48 89 c6                mov    %rax,%rsi
222:   0f ae e8                lfence
225:   65 48 8b 05 00 00 00    mov    %gs:0x0(%rip),%rax        # 22d <sched_init+0x134>
22c:   00
			229: R_X86_64_PC32      cpu_dr7-0x4
22d:   0f ae e8                lfence
230:   0f 31                   rdtsc
232:   48 c1 e2 20             shl    $0x20,%rdx
236:   48 c1 e1 20             shl    $0x20,%rcx
23a:   48 09 c2                or     %rax,%rdx
23d:   48 09 f1                or     %rsi,%rcx
240:   48 29 ca                sub    %rcx,%rdx
243:   49 01 d6                add    %rdx,%r14
246:   41 ff cf                dec    %r15d
249:   0f 85 d0 fe ff ff       jne    11f <sched_init+0x26>


