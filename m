Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B86C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD78206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ehAXoCH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgIGRba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbgIGRa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:30:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC95C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ebztmCAaJDkbqUgTdXd517fKojr+eIxp4DEC6Ocq3KI=; b=ehAXoCH66gRnQPt/6cE90qa8wF
        EKuMY4StMXeOXCocskteScZHQ+z8Bu6zHygwXhghg4sySf0i9N2nXNctG7lLwYIIAa4C21GA6N7aS
        C0a5GGUr7ZoCp6QTSpjGZfR2LfhgWJwGiIyPNqQKRWRDigmGHa771NXkVeVQAD0yNR8zv700P5pPN
        W5gb0TZddayLLJsui0FKRxM1Pk0eqtk+Em9zQos62dhAv8uymXnXG3HeNMzimjyuJjyBZCrLcLWF4
        X1P6Pkrxl9wH5+QzPq7s3IpeSgGFfdwh7spn28fbF+Wo8yTwXldjxx3E+sfXAtJhq2EUuQiexmjl5
        18tot7cg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFKyi-0000Mr-40; Mon, 07 Sep 2020 17:30:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A8F9301179;
        Mon,  7 Sep 2020 19:30:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F243B2BAA5EAC; Mon,  7 Sep 2020 19:30:47 +0200 (CEST)
Date:   Mon, 7 Sep 2020 19:30:47 +0200
From:   peterz@infradead.org
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 6/8] x86/tsc: Use seqcount_latch_t
Message-ID: <20200907173047.GO1362448@hirez.programming.kicks-ass.net>
References: <20200827114044.11173-1-a.darwish@linutronix.de>
 <20200827114044.11173-7-a.darwish@linutronix.de>
 <20200904074142.GL2674@hirez.programming.kicks-ass.net>
 <20200904080312.GZ35926@hirez.programming.kicks-ass.net>
 <20200907162913.GA178765@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907162913.GA178765@lx-t490>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 06:29:13PM +0200, Ahmed S. Darwish wrote:

> I've been unsuccessful in reproducing this huge, 200+ bytes, difference.
> Can I please get the defconfig and GCC version?

I think I lost the config and it's either gcc-9.3 or gcc-10, I can't
remember.

I just tried with:

  make defconfig
  ./scripts/config --enable PREEMPT --enable DEBUG_ATOMIC_SLEEP
  make oldconfig

And that reproduces things a little, but nowhere near as horrible as I
reported. Clearly I had something mad enabled by accident.

> Here are the two competing implementations:
> 
> noinline void cyc2ns_read_begin_v1(struct cyc2ns_data *data)
> {
> 	seqcount_latch_t *seqcount;
> 	int seq, idx;
> 
> 	preempt_disable_notrace();
> 
> 	seqcount = &this_cpu_ptr(&cyc2ns)->seq;
> 	do {
> 		seq = raw_read_seqcount_latch(seqcount);
> 		idx = seq & 1;
> 
> 		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
> 		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
> 		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
> 
> 	} while (read_seqcount_latch_retry(seqcount, seq));
> }
> 
> noinline void cyc2ns_read_begin_v2(struct cyc2ns_data *data)
> {
> 	int seq, idx;
> 
> 	preempt_disable_notrace();
> 
> 	do {
> 		seq = this_cpu_read(cyc2ns.seq.seqcount.sequence);
> 		idx = seq & 1;
> 
> 		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
> 		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
> 		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
> 
> 	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.seqcount.sequence)));
> }

Don't look at this function in isolation, look at native_sched_clock()
where it's used as a whole.

What happened (afaict) is that the change caused it to use more
registers and ended up spiling crap on the stack.

GCC-9.3 gives me:

(this_cpu variant)


0000 0000000000000c00 <native_sched_clock>:
0000  c00:	e9 65 00 00 00       	jmpq   c6a <native_sched_clock+0x6a>
0005  c05:	0f 31                	rdtsc  
0007  c07:	48 c1 e2 20          	shl    $0x20,%rdx
000b  c0b:	48 09 c2             	or     %rax,%rdx
000e  c0e:	65 ff 05 00 00 00 00 	incl   %gs:0x0(%rip)        # c15 <native_sched_clock+0x15>
0011 			c11: R_X86_64_PC32	__preempt_count-0x4
0015  c15:	65 44 8b 05 00 00 00 	mov    %gs:0x0(%rip),%r8d        # c1d <native_sched_clock+0x1d>
001c  c1c:	00 
0019 			c19: R_X86_64_PC32	.data..percpu..shared_aligned+0x1c
001d  c1d:	44 89 c0             	mov    %r8d,%eax
0020  c20:	83 e0 01             	and    $0x1,%eax
0023  c23:	48 c1 e0 04          	shl    $0x4,%rax
0027  c27:	48 8d 88 00 00 00 00 	lea    0x0(%rax),%rcx
002a 			c2a: R_X86_64_32S	.data..percpu..shared_aligned
002e  c2e:	65 48 8b 79 08       	mov    %gs:0x8(%rcx),%rdi
0033  c33:	65 8b b0 00 00 00 00 	mov    %gs:0x0(%rax),%esi
0036 			c36: R_X86_64_32S	.data..percpu..shared_aligned
003a  c3a:	65 8b 49 04          	mov    %gs:0x4(%rcx),%ecx
003e  c3e:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # c45 <native_sched_clock+0x45>
0041 			c41: R_X86_64_PC32	.data..percpu..shared_aligned+0x1c
0045  c45:	41 39 c0             	cmp    %eax,%r8d
0048  c48:	75 cb                	jne    c15 <native_sched_clock+0x15>
004a  c4a:	89 f0                	mov    %esi,%eax
004c  c4c:	48 f7 e2             	mul    %rdx
004f  c4f:	48 0f ad d0          	shrd   %cl,%rdx,%rax
0053  c53:	48 d3 ea             	shr    %cl,%rdx
0056  c56:	f6 c1 40             	test   $0x40,%cl
0059  c59:	48 0f 45 c2          	cmovne %rdx,%rax
005d  c5d:	48 01 f8             	add    %rdi,%rax
0060  c60:	65 ff 0d 00 00 00 00 	decl   %gs:0x0(%rip)        # c67 <native_sched_clock+0x67>
0063 			c63: R_X86_64_PC32	__preempt_count-0x4
0067  c67:	74 1a                	je     c83 <native_sched_clock+0x83>
0069  c69:	c3                   	retq   
006a  c6a:	48 69 05 00 00 00 00 	imul   $0xf4240,0x0(%rip),%rax        # c75 <native_sched_clock+0x75>
0071  c71:	40 42 0f 00 
006d 			c6d: R_X86_64_PC32	jiffies_64-0x8
0075  c75:	48 ba 00 b8 64 d9 05 	movabs $0xfff0be05d964b800,%rdx
007c  c7c:	be f0 ff 
007f  c7f:	48 01 d0             	add    %rdx,%rax
0082  c82:	c3                   	retq   
0083  c83:	55                   	push   %rbp
0084  c84:	48 89 e5             	mov    %rsp,%rbp
0087  c87:	e8 00 00 00 00       	callq  c8c <native_sched_clock+0x8c>
0088 			c88: R_X86_64_PLT32	preempt_schedule_notrace_thunk-0x4
008c  c8c:	5d                   	pop    %rbp
008d  c8d:	c3                   	retq   



(seqcount_latch variant)


0000 0000000000000c20 <native_sched_clock>:
0000  c20:	e9 89 00 00 00       	jmpq   cae <native_sched_clock+0x8e>
0005  c25:	55                   	push   %rbp
0006  c26:	48 89 e5             	mov    %rsp,%rbp
0009  c29:	41 54                	push   %r12
000b  c2b:	53                   	push   %rbx
000c  c2c:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
0010  c30:	0f 31                	rdtsc  
0012  c32:	48 c1 e2 20          	shl    $0x20,%rdx
0016  c36:	48 89 d3             	mov    %rdx,%rbx
0019  c39:	48 09 c3             	or     %rax,%rbx
001c  c3c:	65 ff 05 00 00 00 00 	incl   %gs:0x0(%rip)        # c43 <native_sched_clock+0x23>
001f 			c3f: R_X86_64_PC32	__preempt_count-0x4
0023  c43:	e8 00 00 00 00       	callq  c48 <native_sched_clock+0x28>
0024 			c44: R_X86_64_PLT32	debug_smp_processor_id-0x4
0028  c48:	49 c7 c4 00 00 00 00 	mov    $0x0,%r12
002b 			c4b: R_X86_64_32S	.data..percpu..shared_aligned+0x20
002f  c4f:	89 c0                	mov    %eax,%eax
0031  c51:	4c 03 24 c5 00 00 00 	add    0x0(,%rax,8),%r12
0038  c58:	00 
0035 			c55: R_X86_64_32S	__per_cpu_offset
0039  c59:	4c 89 e0             	mov    %r12,%rax
003c  c5c:	8b 30                	mov    (%rax),%esi
003e  c5e:	89 f1                	mov    %esi,%ecx
0040  c60:	83 e1 01             	and    $0x1,%ecx
0043  c63:	48 c1 e1 04          	shl    $0x4,%rcx
0047  c67:	48 8d b9 00 00 00 00 	lea    0x0(%rcx),%rdi
004a 			c6a: R_X86_64_32S	.data..percpu..shared_aligned
004e  c6e:	65 4c 8b 47 08       	mov    %gs:0x8(%rdi),%r8
0053  c73:	65 44 8b 89 00 00 00 	mov    %gs:0x0(%rcx),%r9d
005a  c7a:	00 
0057 			c77: R_X86_64_32S	.data..percpu..shared_aligned
005b  c7b:	65 8b 4f 04          	mov    %gs:0x4(%rdi),%ecx
005f  c7f:	8b 10                	mov    (%rax),%edx
0061  c81:	39 d6                	cmp    %edx,%esi
0063  c83:	75 d7                	jne    c5c <native_sched_clock+0x3c>
0065  c85:	44 89 c8             	mov    %r9d,%eax
0068  c88:	48 f7 e3             	mul    %rbx
006b  c8b:	48 0f ad d0          	shrd   %cl,%rdx,%rax
006f  c8f:	48 d3 ea             	shr    %cl,%rdx
0072  c92:	f6 c1 40             	test   $0x40,%cl
0075  c95:	48 0f 45 c2          	cmovne %rdx,%rax
0079  c99:	4c 01 c0             	add    %r8,%rax
007c  c9c:	65 ff 0d 00 00 00 00 	decl   %gs:0x0(%rip)        # ca3 <native_sched_clock+0x83>
007f 			c9f: R_X86_64_PC32	__preempt_count-0x4
0083  ca3:	74 22                	je     cc7 <native_sched_clock+0xa7>
0085  ca5:	48 8d 65 f0          	lea    -0x10(%rbp),%rsp
0089  ca9:	5b                   	pop    %rbx
008a  caa:	41 5c                	pop    %r12
008c  cac:	5d                   	pop    %rbp
008d  cad:	c3                   	retq   
008e  cae:	48 69 05 00 00 00 00 	imul   $0xf4240,0x0(%rip),%rax        # cb9 <native_sched_clock+0x99>
0095  cb5:	40 42 0f 00 
0091 			cb1: R_X86_64_PC32	jiffies_64-0x8
0099  cb9:	49 b8 00 b8 64 d9 05 	movabs $0xfff0be05d964b800,%r8
00a0  cc0:	be f0 ff 
00a3  cc3:	4c 01 c0             	add    %r8,%rax
00a6  cc6:	c3                   	retq   
00a7  cc7:	e8 00 00 00 00       	callq  ccc <native_sched_clock+0xac>
00a8 			cc8: R_X86_64_PLT32	preempt_schedule_notrace_thunk-0x4
00ac  ccc:	eb d7                	jmp    ca5 <native_sched_clock+0x85>


And you see it starting to spill stuff.

When we disable DEBUG_ATOMIC_SLEEP it becomes much saner again:


0000 0000000000000b40 <native_sched_clock>:
0000  b40:	e9 6b 00 00 00       	jmpq   bb0 <native_sched_clock+0x70>
0005  b45:	0f 31                	rdtsc  
0007  b47:	48 c1 e2 20          	shl    $0x20,%rdx
000b  b4b:	48 09 c2             	or     %rax,%rdx
000e  b4e:	65 ff 05 00 00 00 00 	incl   %gs:0x0(%rip)        # b55 <native_sched_clock+0x15>
0011 			b51: R_X86_64_PC32	__preempt_count-0x4
0015  b55:	49 c7 c0 00 00 00 00 	mov    $0x0,%r8
0018 			b58: R_X86_64_32S	.data..percpu..shared_aligned+0x20
001c  b5c:	65 4c 03 05 00 00 00 	add    %gs:0x0(%rip),%r8        # b64 <native_sched_clock+0x24>
0023  b63:	00 
0020 			b60: R_X86_64_PC32	this_cpu_off-0x4
0024  b64:	41 8b 30             	mov    (%r8),%esi
0027  b67:	89 f1                	mov    %esi,%ecx
0029  b69:	83 e1 01             	and    $0x1,%ecx
002c  b6c:	48 c1 e1 04          	shl    $0x4,%rcx
0030  b70:	48 8d b9 00 00 00 00 	lea    0x0(%rcx),%rdi
0033 			b73: R_X86_64_32S	.data..percpu..shared_aligned
0037  b77:	65 4c 8b 57 08       	mov    %gs:0x8(%rdi),%r10
003c  b7c:	65 44 8b 89 00 00 00 	mov    %gs:0x0(%rcx),%r9d
0043  b83:	00 
0040 			b80: R_X86_64_32S	.data..percpu..shared_aligned
0044  b84:	65 8b 4f 04          	mov    %gs:0x4(%rdi),%ecx
0048  b88:	41 8b 38             	mov    (%r8),%edi
004b  b8b:	39 fe                	cmp    %edi,%esi
004d  b8d:	75 d5                	jne    b64 <native_sched_clock+0x24>
004f  b8f:	44 89 c8             	mov    %r9d,%eax
0052  b92:	48 f7 e2             	mul    %rdx
0055  b95:	48 0f ad d0          	shrd   %cl,%rdx,%rax
0059  b99:	48 d3 ea             	shr    %cl,%rdx
005c  b9c:	f6 c1 40             	test   $0x40,%cl
005f  b9f:	48 0f 45 c2          	cmovne %rdx,%rax
0063  ba3:	4c 01 d0             	add    %r10,%rax
0066  ba6:	65 ff 0d 00 00 00 00 	decl   %gs:0x0(%rip)        # bad <native_sched_clock+0x6d>
0069 			ba9: R_X86_64_PC32	__preempt_count-0x4
006d  bad:	74 1a                	je     bc9 <native_sched_clock+0x89>
006f  baf:	c3                   	retq   
0070  bb0:	48 69 05 00 00 00 00 	imul   $0xf4240,0x0(%rip),%rax        # bbb <native_sched_clock+0x7b>
0077  bb7:	40 42 0f 00 
0073 			bb3: R_X86_64_PC32	jiffies_64-0x8
007b  bbb:	49 ba 00 b8 64 d9 05 	movabs $0xfff0be05d964b800,%r10
0082  bc2:	be f0 ff 
0085  bc5:	4c 01 d0             	add    %r10,%rax
0088  bc8:	c3                   	retq   
0089  bc9:	55                   	push   %rbp
008a  bca:	48 89 e5             	mov    %rsp,%rbp
008d  bcd:	e8 00 00 00 00       	callq  bd2 <native_sched_clock+0x92>
008e 			bce: R_X86_64_PLT32	preempt_schedule_notrace_thunk-0x4
0092  bd2:	5d                   	pop    %rbp
0093  bd3:	c3                   	retq   

But that's still slightly larger.



Anyway, I frobbed the patch to use the this_cpu variant, and I've queued
the lot.
