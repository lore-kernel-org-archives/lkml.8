Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95391C2D0E9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D30820737
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eh5rYByT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgCYWHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 18:07:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgCYWHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 18:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K0sBmojZZht6xbtIswAkYm6tFpzmARW6EsJj1qoUG50=; b=eh5rYByT6xaiNk20IX6jVmULt3
        8yrQuKJoqy7sLASc/MkbyPKRyQpYIOZyXxJY2kXZ7fhp43sKvP6fRvAa4rp4dQRRCRz0R3HOg2BDC
        cV+vBoQHfsu7I1AS/+iBQT3jioYNpKuCv1B6F8GNovGSaIGm7CEF/WvY2pDw380Upb24h/HVS4A8W
        3T0Uzt6kaOpwnJM8EjE6IfaT285xaf3Z2VP8HIx7G7jkwvmAYXcdn8NiRnAhzkYbyi425pDdM2C7B
        b7JWbK5Io7LNI1ZxbeTRZzjOcAe8lX4vRv1zNfE36zVoOWUh7xUaHdVe52Ksgk0yQLClcBnEsqHdF
        ilZWds3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHEAx-0002g0-24; Wed, 25 Mar 2020 22:07:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BDD6983531; Wed, 25 Mar 2020 23:07:00 +0100 (CET)
Date:   Wed, 25 Mar 2020 23:07:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Anvin <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
Message-ID: <20200325220700.GZ2452@worktop.programming.kicks-ass.net>
References: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
 <86D80EA7-9087-4042-8119-12DD5FCEAA87@amacapital.net>
 <CAHk-=wim-2aaFi_GNs5KmX4ykkgQjnRo5D4B9ZK+1Oz=kpp_2A@mail.gmail.com>
 <59FDEFC1-9353-453F-84E5-F94995157B27@zytor.com>
 <CAHk-=wgBpTqWD=cm2xDsRSCb8keL6_9VKBSE7TUrToErtO6sdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgBpTqWD=cm2xDsRSCb8keL6_9VKBSE7TUrToErtO6sdQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 01:52:00PM -0700, Linus Torvalds wrote:
> On Wed, Mar 25, 2020 at 12:35 PM <hpa@zytor.com> wrote:
> >
> > "movl $0,%eax" is five bytes, the same length as a call. Doesn't work for a tailcall, still, although if the sequence:
> >
> >     jmp tailcall
> >     retq
> >
> > ... can be generated at the tailcall site then the jmp can get patched out.
> 
> No, the problem is literally that the whole approach depends on the
> compiler just generating normal code for the static calls.
> 
> And the tailcall is the only interesting case. The normal call thing
> can be trivially just a single instruction (a mov like you say, but
> also easily just a xor padded with prefixes).

So I got the text poking bit written, and that turned out to be the
simple part :/ Find below.

Then we can do:

#define static_void_call(name)
	if (STATIC_CALL_NAME(name).func) \
		((typeof(STATIC_CALL_TRAMP(name))*)STATIC_CALL_NAME(name).func)

Which works, as evidenced by if being the current static_cond_call(),
but it is non-optimal code-gen for the case where func will never be
NULL, and also there is no way to write a !void version of the same.

The best I can come up with is something like:

#define static_call(name, args...) ({ \
	typeof(STATIC_CALL_TRAMP(name)(args)) __ret = (typeof(STATIC_CALL_TRAMP(name)(args)))0; \
	if (STATIC_CALL_NAME(name).func) \
		__ret = ((typeof(STATIC_CALL_TRAMP(name))*)STATIC_CALL_NAME(name).func)(args); \
	__ret; })

Which has a different (and IMO less natural) syntax.

That then brings us to the HAVE_STATIC_CALL variant; there we need to
somehow make the void vs !void thing persistent, and there I ran out of
ideas.

Initially I figured we could do something like:

#define annotate_void_call() ({ \
	asm volatile("%c0:\n\t" \
		     ".pushsection .discard.void_call\n\t" \
		     ".long %c0b - .\n\t" \
		     ".popsection\n\t" : : "i" (__COUNTER__)); \
})

#define static_void_call(name) \
	annotate_void_call(); \
	STATIC_CALL_TRAMP(name)

But that doesn't actually work for something like:

	static_void_call(foo)(static_call(bar)());

Where the argument setup of the call, include another static call.
Arguably this is quite insane, and we could just say:
"don't-do-that-then", but it does show how fragile this is.

Anyway, let me ponder this a little more... brain is starting to give
out anyway. More tomorrow.


---
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 346c98d5261e..240996338f66 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -947,6 +947,7 @@ struct text_poke_loc {
 	s32 rel32;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
+	u8 multi;
 };

 struct bp_patching_desc {
@@ -1103,8 +1104,8 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		.refs = ATOMIC_INIT(1),
 	};
 	unsigned char int3 = INT3_INSN_OPCODE;
+	int do_sync, do_multi = 0;
 	unsigned int i;
-	int do_sync;

 	lockdep_assert_held(&text_mutex);

@@ -1119,11 +1120,24 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	/*
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
-	for (i = 0; i < nr_entries; i++)
+	for (i = 0; i < nr_entries; i++) {
 		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
+		do_multi |= tp[i].multi;
+	}

 	text_poke_sync();

+	if (do_multi) {
+		/*
+		 * In case the 'old' text consisted of multiple instructions
+		 * we need to wait for an rcu_tasks quiescence period to ensure
+		 * all potentially preempted tasks have normally scheduled.
+		 * This ensures no tasks still have their instruction pointer
+		 * pointed at what will become the middle of an instruction.
+		 */
+		synchronize_rcu_tasks();
+	}
+
 	/*
 	 * Second step: update all but the first byte of the patched range.
 	 */
@@ -1176,10 +1190,28 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 {
 	struct insn insn;

+	/*
+	 * Determine if the 'old' text at @addr consists of multiple
+	 * instructions. Make an exception for INT3 and RET, since
+	 * they don't (necessarily) continue to execute the following
+	 * instructions.
+	 */
+	kernel_insn_init(&insn, addr, MAX_INSN_SIZE);
+	insn_get_length(&insn);
+	tp.multi = (insn.legnth < len) &&
+		   (insn.opcode.bytes[0] != RET_INSN_OPCODE ||
+		    insn.opcode.bytes[0] != INT3_INSN_OPCODE);
+
+	/*
+	 * Copy the 'new' text into the text_poke vector.
+	 */
 	memcpy((void *)tp->text, opcode, len);
 	if (!emulate)
 		emulate = opcode;

+	/*
+	 * Decode the instruction poke_int3_handler() needs to emulate.
+	 */
 	kernel_insn_init(&insn, emulate, MAX_INSN_SIZE);
 	insn_get_length(&insn);

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 1e82e2486e76..2055e2d3674d 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -9,8 +9,13 @@ enum insn_type {
 	nop = 1,  /* site cond-call */
 	jmp = 2,  /* tramp / site tail-call */
 	ret = 3,  /* tramp / site cond-tail-call */
+	null = 4,
+	null_ret = 5,
 };

+static const u8 null_insn[5] =     { 0xb8, 0x00, 0x00, 0x00, 0x00 }; /* movl $0, %eax */
+static const u8 null_ret_insn[5] = { 0x31, 0xc0, 0xc3, 0x90, 0x90 }; /* xorl %eax, %eax; ret; nop; nop; */
+
 static void __ref __static_call_transform(void *insn, enum insn_type type, void *func)
 {
 	int size = CALL_INSN_SIZE;
@@ -34,6 +39,14 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void
 		size = RET_INSN_SIZE;
 		break;

+	case null:
+		code = null_insi;
+		break;
+
+	case null_ret:
+		code = null_ret_insn;
+		break;
+
 	default: /* GCC is a moron -- it figures @code can be uninitialized below */
 		BUG();
 	}

