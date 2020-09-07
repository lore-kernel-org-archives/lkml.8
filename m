Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19025C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9892E20757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hjSqvsxT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l1QCcrlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgIGQ3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgIGQ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:28:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873E5C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:28:49 -0700 (PDT)
Date:   Mon, 7 Sep 2020 18:29:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599496127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3bmAbmLVMY/y/RdwYo9fB9Rf30FToictabiRw458dQ=;
        b=hjSqvsxTdzCKetdVFEOTAeupnenrRyt6LmI1mWmtgzulq4jMeTahceXU44+IHe/m0OU0EW
        lyI2opleqBsoP6ShJzGaqzqwZq4V6YtuyIQCci+uL9r+wwuSGeD88NneVNlwpIz39CHrDn
        V3tw3b6CGem2NZrGn1uX3R5U8hjuAChunyUPOuAr7erx0Gl8KHJWi/3mqrzGTvCV+S6diW
        T49Wbq46GPS/fut2fjAA8OAwz4iXtrvdk5YdKy8FgLNrq9MeCeeHq0UEHvR0P+ngfsQun2
        6p+lkoVs2YxCJxLppSCXFePX+ydwn201WdYpSZ+22FvTEYdVOMDC/wj8NgResQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599496127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3bmAbmLVMY/y/RdwYo9fB9Rf30FToictabiRw458dQ=;
        b=l1QCcrlNaB9AF5AOEJnnzCFCl47j+J9WTq0FakrBTZoc5ernHjzhXlk6fmVtQ9P/pfPWgx
        ldn9sFrxtYB4KJAw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 6/8] x86/tsc: Use seqcount_latch_t
Message-ID: <20200907162913.GA178765@lx-t490>
References: <20200827114044.11173-1-a.darwish@linutronix.de>
 <20200827114044.11173-7-a.darwish@linutronix.de>
 <20200904074142.GL2674@hirez.programming.kicks-ass.net>
 <20200904080312.GZ35926@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904080312.GZ35926@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 04, 2020 at 10:03:12AM +0200, peterz@infradead.org wrote:
> On Fri, Sep 04, 2020 at 09:41:42AM +0200, peterz@infradead.org wrote:
> > On Thu, Aug 27, 2020 at 01:40:42PM +0200, Ahmed S. Darwish wrote:
> >
> > >  __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
> > >  {
> > > +	seqcount_latch_t *seqcount;
> > >  	int seq, idx;
> > >
> > >  	preempt_disable_notrace();
> > >
> > > +	seqcount = &this_cpu_ptr(&cyc2ns)->seq;
> > >  	do {
> > > -		seq = this_cpu_read(cyc2ns.seq.sequence);
> > > +		seq = raw_read_seqcount_latch(seqcount);
> > >  		idx = seq & 1;
> > >
> > >  		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
> > >  		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
> > >  		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
> > >
> > > -	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
> > > +	} while (read_seqcount_latch_retry(seqcount, seq));
> > >  }
> >
> > So I worried about this change, it obviously generates worse code. But I
> > was not expecting this:
> >
> > Before:
> >
> > 196: 0000000000000110   189 FUNC    GLOBAL DEFAULT    1 native_sched_clock
> >
> > After:
> >
> > 195: 0000000000000110   399 FUNC    GLOBAL DEFAULT    1 native_sched_clock
> >
> > That's _210_ bytes extra!!
> >
> > If you look at the disassembly of the thing after it's a complete
> > trainwreck.
>
> The below delta fixes it again.
>
> ---
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -68,21 +68,19 @@ early_param("tsc_early_khz", tsc_early_k
>
>  __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
>  {
> -	seqcount_latch_t *seqcount;
>  	int seq, idx;
>
>  	preempt_disable_notrace();
>
> -	seqcount = &this_cpu_ptr(&cyc2ns)->seq;
>  	do {
> -		seq = raw_read_seqcount_latch(seqcount);
> +		seq = this_cpu_read(cyc2ns.seq.seqcount.sequence);
>  		idx = seq & 1;
>
>  		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
>  		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
>  		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
>
> -	} while (read_seqcount_latch_retry(seqcount, seq));
> +	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.seqcount.sequence)));
>  }
>
>  __always_inline void cyc2ns_read_end(void)

I've been unsuccessful in reproducing this huge, 200+ bytes, difference.
Can I please get the defconfig and GCC version?

Here are the two competing implementations:

noinline void cyc2ns_read_begin_v1(struct cyc2ns_data *data)
{
	seqcount_latch_t *seqcount;
	int seq, idx;

	preempt_disable_notrace();

	seqcount = &this_cpu_ptr(&cyc2ns)->seq;
	do {
		seq = raw_read_seqcount_latch(seqcount);
		idx = seq & 1;

		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);

	} while (read_seqcount_latch_retry(seqcount, seq));
}

noinline void cyc2ns_read_begin_v2(struct cyc2ns_data *data)
{
	int seq, idx;

	preempt_disable_notrace();

	do {
		seq = this_cpu_read(cyc2ns.seq.seqcount.sequence);
		idx = seq & 1;

		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);

	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.seqcount.sequence)));
}

And here are their resulting gcc-7/8/4.9 binary output (DEBUG_PREEMPT=y,
but setting DEBUG_KERNEL/DEBUG_PREEMPT=n also doesn't show any big _v1
vs. _v2 difference; similarly when using gcc-10):

gcc-7
=====

ffffffff81028890 <cyc2ns_read_begin_v1>:
ffffffff81028890:	65 ff 05 a9 e6 fe 7e 	incl   %gs:0x7efee6a9(%rip)        # 16f40 <__preempt_count>
			ffffffff81028893: R_X86_64_PC32	__preempt_count-0x4
ffffffff81028897:	48 c7 c6 40 a5 1f 00 	mov    $0x1fa540,%rsi
			ffffffff8102889a: R_X86_64_32S	.data..percpu+0x1fa540
ffffffff8102889e:	48 89 f2             	mov    %rsi,%rdx
ffffffff810288a1:	65 48 03 15 bf 8a fe 	add    %gs:0x7efe8abf(%rip),%rdx        # 11368 <this_cpu_off>
ffffffff810288a8:	7e
			ffffffff810288a5: R_X86_64_PC32	this_cpu_off-0x4
ffffffff810288a9:	8b 4a 20             	mov    0x20(%rdx),%ecx
ffffffff810288ac:	89 c8                	mov    %ecx,%eax
ffffffff810288ae:	83 e0 01             	and    $0x1,%eax
ffffffff810288b1:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff810288b5:	48 01 f0             	add    %rsi,%rax
ffffffff810288b8:	65 4c 8b 40 08       	mov    %gs:0x8(%rax),%r8
ffffffff810288bd:	4c 89 47 08          	mov    %r8,0x8(%rdi)
ffffffff810288c1:	65 44 8b 00          	mov    %gs:(%rax),%r8d
ffffffff810288c5:	44 89 07             	mov    %r8d,(%rdi)
ffffffff810288c8:	65 8b 40 04          	mov    %gs:0x4(%rax),%eax
ffffffff810288cc:	89 47 04             	mov    %eax,0x4(%rdi)
ffffffff810288cf:	8b 42 20             	mov    0x20(%rdx),%eax
ffffffff810288d2:	39 c8                	cmp    %ecx,%eax
ffffffff810288d4:	75 d3                	jne    ffffffff810288a9 <cyc2ns_read_begin_v1+0x19>
ffffffff810288d6:	f3 c3                	repz retq
ffffffff810288d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
ffffffff810288df:	00

ffffffff810288e0 <cyc2ns_read_begin_v2>:
ffffffff810288e0:	65 ff 05 59 e6 fe 7e 	incl   %gs:0x7efee659(%rip)        # 16f40 <__preempt_count>
			ffffffff810288e3: R_X86_64_PC32	__preempt_count-0x4
ffffffff810288e7:	48 c7 c1 40 a5 1f 00 	mov    $0x1fa540,%rcx
			ffffffff810288ea: R_X86_64_32S	.data..percpu+0x1fa540
ffffffff810288ee:	48 89 c8             	mov    %rcx,%rax
ffffffff810288f1:	65 48 03 05 6f 8a fe 	add    %gs:0x7efe8a6f(%rip),%rax        # 11368 <this_cpu_off>
ffffffff810288f8:	7e
			ffffffff810288f5: R_X86_64_PC32	this_cpu_off-0x4
ffffffff810288f9:	65 8b 15 60 1c 1d 7f 	mov    %gs:0x7f1d1c60(%rip),%edx        # 1fa560 <cyc2ns+0x20>
			ffffffff810288fc: R_X86_64_PC32	.data..percpu+0x1fa55c
ffffffff81028900:	89 d0                	mov    %edx,%eax
ffffffff81028902:	83 e0 01             	and    $0x1,%eax
ffffffff81028905:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff81028909:	48 01 c8             	add    %rcx,%rax
ffffffff8102890c:	65 48 8b 70 08       	mov    %gs:0x8(%rax),%rsi
ffffffff81028911:	48 89 77 08          	mov    %rsi,0x8(%rdi)
ffffffff81028915:	65 8b 30             	mov    %gs:(%rax),%esi
ffffffff81028918:	89 37                	mov    %esi,(%rdi)
ffffffff8102891a:	65 8b 40 04          	mov    %gs:0x4(%rax),%eax
ffffffff8102891e:	89 47 04             	mov    %eax,0x4(%rdi)
ffffffff81028921:	65 8b 05 38 1c 1d 7f 	mov    %gs:0x7f1d1c38(%rip),%eax        # 1fa560 <cyc2ns+0x20>
			ffffffff81028924: R_X86_64_PC32	.data..percpu+0x1fa55c
ffffffff81028928:	39 c2                	cmp    %eax,%edx
ffffffff8102892a:	75 cd                	jne    ffffffff810288f9 <cyc2ns_read_begin_v2+0x19>
ffffffff8102892c:	f3 c3                	repz retq
ffffffff8102892e:	66 90                	xchg   %ax,%ax

gcc-8
=====

ffffffff810281a0 <cyc2ns_read_begin_v1>:
ffffffff810281a0:	65 ff 05 99 ed fe 7e 	incl   %gs:0x7efeed99(%rip)        # 16f40 <__preempt_count>
			ffffffff810281a3: R_X86_64_PC32	__preempt_count-0x4
ffffffff810281a7:	49 c7 c0 40 a5 1f 00 	mov    $0x1fa540,%r8
			ffffffff810281aa: R_X86_64_32S	.data..percpu+0x1fa540
ffffffff810281ae:	4c 89 c1             	mov    %r8,%rcx
ffffffff810281b1:	65 48 03 0d af 91 fe 	add    %gs:0x7efe91af(%rip),%rcx        # 11368 <this_cpu_off>
ffffffff810281b8:	7e
			ffffffff810281b5: R_X86_64_PC32	this_cpu_off-0x4
ffffffff810281b9:	8b 51 20             	mov    0x20(%rcx),%edx
ffffffff810281bc:	89 d0                	mov    %edx,%eax
ffffffff810281be:	83 e0 01             	and    $0x1,%eax
ffffffff810281c1:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff810281c5:	4c 01 c0             	add    %r8,%rax
ffffffff810281c8:	65 48 8b 70 08       	mov    %gs:0x8(%rax),%rsi
ffffffff810281cd:	48 89 77 08          	mov    %rsi,0x8(%rdi)
ffffffff810281d1:	65 8b 30             	mov    %gs:(%rax),%esi
ffffffff810281d4:	89 37                	mov    %esi,(%rdi)
ffffffff810281d6:	65 8b 40 04          	mov    %gs:0x4(%rax),%eax
ffffffff810281da:	89 47 04             	mov    %eax,0x4(%rdi)
ffffffff810281dd:	8b 41 20             	mov    0x20(%rcx),%eax
ffffffff810281e0:	39 d0                	cmp    %edx,%eax
ffffffff810281e2:	75 d5                	jne    ffffffff810281b9 <cyc2ns_read_begin_v1+0x19>
ffffffff810281e4:	c3                   	retq
ffffffff810281e5:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
ffffffff810281ec:	00 00 00 00

ffffffff810281f0 <cyc2ns_read_begin_v2>:
ffffffff810281f0:	65 ff 05 49 ed fe 7e 	incl   %gs:0x7efeed49(%rip)        # 16f40 <__preempt_count>
			ffffffff810281f3: R_X86_64_PC32	__preempt_count-0x4
ffffffff810281f7:	48 c7 c1 40 a5 1f 00 	mov    $0x1fa540,%rcx
			ffffffff810281fa: R_X86_64_32S	.data..percpu+0x1fa540
ffffffff810281fe:	48 89 c8             	mov    %rcx,%rax
ffffffff81028201:	65 48 03 05 5f 91 fe 	add    %gs:0x7efe915f(%rip),%rax        # 11368 <this_cpu_off>
ffffffff81028208:	7e
			ffffffff81028205: R_X86_64_PC32	this_cpu_off-0x4
ffffffff81028209:	65 8b 15 50 23 1d 7f 	mov    %gs:0x7f1d2350(%rip),%edx        # 1fa560 <cyc2ns+0x20>
			ffffffff8102820c: R_X86_64_PC32	.data..percpu+0x1fa55c
ffffffff81028210:	89 d0                	mov    %edx,%eax
ffffffff81028212:	83 e0 01             	and    $0x1,%eax
ffffffff81028215:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff81028219:	48 01 c8             	add    %rcx,%rax
ffffffff8102821c:	65 48 8b 70 08       	mov    %gs:0x8(%rax),%rsi
ffffffff81028221:	48 89 77 08          	mov    %rsi,0x8(%rdi)
ffffffff81028225:	65 8b 30             	mov    %gs:(%rax),%esi
ffffffff81028228:	89 37                	mov    %esi,(%rdi)
ffffffff8102822a:	65 8b 40 04          	mov    %gs:0x4(%rax),%eax
ffffffff8102822e:	89 47 04             	mov    %eax,0x4(%rdi)
ffffffff81028231:	65 8b 05 28 23 1d 7f 	mov    %gs:0x7f1d2328(%rip),%eax        # 1fa560 <cyc2ns+0x20>
			ffffffff81028234: R_X86_64_PC32	.data..percpu+0x1fa55c
ffffffff81028238:	39 c2                	cmp    %eax,%edx
ffffffff8102823a:	75 cd                	jne    ffffffff81028209 <cyc2ns_read_begin_v2+0x19>
ffffffff8102823c:	c3                   	retq
ffffffff8102823d:	0f 1f 00             	nopl   (%rax)

gcc-4.9
=======

ffffffff810ab900 <cyc2ns_read_begin_v1>:
ffffffff810ab900:	55                   	push   %rbp
ffffffff810ab901:	48 89 fd             	mov    %rdi,%rbp
ffffffff810ab904:	53                   	push   %rbx
ffffffff810ab905:	65 ff 05 f4 b6 f6 7e 	incl   %gs:0x7ef6b6f4(%rip)        # 17000 <__preempt_count>
			ffffffff810ab908: R_X86_64_PC32	__preempt_count-0x4
ffffffff810ab90c:	e8 df da c9 00       	callq  ffffffff81d493f0 <debug_smp_processor_id>
			ffffffff810ab90d: R_X86_64_PC32	debug_smp_processor_id-0x4
ffffffff810ab911:	89 c0                	mov    %eax,%eax
ffffffff810ab913:	48 c7 c3 00 ab 02 00 	mov    $0x2ab00,%rbx
			ffffffff810ab916: R_X86_64_32S	.data..percpu+0x2ab00
ffffffff810ab91a:	48 03 1c c5 80 87 65 	add    -0x7d9a7880(,%rax,8),%rbx
ffffffff810ab921:	82
			ffffffff810ab91e: R_X86_64_32S	__per_cpu_offset
ffffffff810ab922:	8b 53 20             	mov    0x20(%rbx),%edx
ffffffff810ab925:	89 d0                	mov    %edx,%eax
ffffffff810ab927:	83 e0 01             	and    $0x1,%eax
ffffffff810ab92a:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff810ab92e:	65 48 8b 88 08 ab 02 	mov    %gs:0x2ab08(%rax),%rcx
ffffffff810ab935:	00
			ffffffff810ab932: R_X86_64_32S	.data..percpu+0x2ab08
ffffffff810ab936:	48 89 4d 08          	mov    %rcx,0x8(%rbp)
ffffffff810ab93a:	65 8b 88 00 ab 02 00 	mov    %gs:0x2ab00(%rax),%ecx
			ffffffff810ab93d: R_X86_64_32S	.data..percpu+0x2ab00
ffffffff810ab941:	89 4d 00             	mov    %ecx,0x0(%rbp)
ffffffff810ab944:	65 8b 80 04 ab 02 00 	mov    %gs:0x2ab04(%rax),%eax
			ffffffff810ab947: R_X86_64_32S	.data..percpu+0x2ab04
ffffffff810ab94b:	89 45 04             	mov    %eax,0x4(%rbp)
ffffffff810ab94e:	8b 43 20             	mov    0x20(%rbx),%eax
ffffffff810ab951:	39 c2                	cmp    %eax,%edx
ffffffff810ab953:	75 cd                	jne    ffffffff810ab922 <cyc2ns_read_begin_v1+0x22>
ffffffff810ab955:	5b                   	pop    %rbx
ffffffff810ab956:	5d                   	pop    %rbp
ffffffff810ab957:	c3                   	retq
ffffffff810ab958:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
ffffffff810ab95f:	00

ffffffff810ab960 <cyc2ns_read_begin_v2>:
ffffffff810ab960:	65 ff 05 99 b6 f6 7e 	incl   %gs:0x7ef6b699(%rip)        # 17000 <__preempt_count>
			ffffffff810ab963: R_X86_64_PC32	__preempt_count-0x4
ffffffff810ab967:	65 8b 15 b2 f1 f7 7e 	mov    %gs:0x7ef7f1b2(%rip),%edx        # 2ab20 <cyc2ns+0x20>
			ffffffff810ab96a: R_X86_64_PC32	.data..percpu+0x2ab1c
ffffffff810ab96e:	89 d0                	mov    %edx,%eax
ffffffff810ab970:	83 e0 01             	and    $0x1,%eax
ffffffff810ab973:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff810ab977:	65 48 8b 88 08 ab 02 	mov    %gs:0x2ab08(%rax),%rcx
ffffffff810ab97e:	00
			ffffffff810ab97b: R_X86_64_32S	.data..percpu+0x2ab08
ffffffff810ab97f:	48 89 4f 08          	mov    %rcx,0x8(%rdi)
ffffffff810ab983:	65 8b 88 00 ab 02 00 	mov    %gs:0x2ab00(%rax),%ecx
			ffffffff810ab986: R_X86_64_32S	.data..percpu+0x2ab00
ffffffff810ab98a:	89 0f                	mov    %ecx,(%rdi)
ffffffff810ab98c:	65 8b 80 04 ab 02 00 	mov    %gs:0x2ab04(%rax),%eax
			ffffffff810ab98f: R_X86_64_32S	.data..percpu+0x2ab04
ffffffff810ab993:	89 47 04             	mov    %eax,0x4(%rdi)
ffffffff810ab996:	65 8b 05 83 f1 f7 7e 	mov    %gs:0x7ef7f183(%rip),%eax        # 2ab20 <cyc2ns+0x20>
			ffffffff810ab999: R_X86_64_PC32	.data..percpu+0x2ab1c
ffffffff810ab99d:	39 c2                	cmp    %eax,%edx
ffffffff810ab99f:	75 c6                	jne    ffffffff810ab967 <cyc2ns_read_begin_v2+0x7>
ffffffff810ab9a1:	f3 c3                	repz retq
ffffffff810ab9a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 nopw %cs:0x0(%rax,%rax,1)
ffffffff810ab9aa:	84 00 00 00 00 00

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
