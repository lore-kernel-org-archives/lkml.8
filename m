Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF8FC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B633C20936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoLwGvcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgEFRZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:25:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28459 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728959AbgEFRZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588785905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SO6y7mt7Z35PU5VAZKKcaxZqnz8+Wti5AAzz+fPL7EM=;
        b=QoLwGvcv4+1iW+50Sr7hUq185jBKrRKd+4nmh0CGlWumyqw6BedC4Qy8mdCNCjroPLcUht
        fsRkoOxTSpXKiH9TJP/4ZjYlxh67QYphIDYvVr/87+C33VDtZBqm+fBaODNB4I0zjf15w6
        NadGOfBZGOcJ6GM/9RS90LgJahzqutk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-uQ_uea3CNvmjGjMlKn4wMA-1; Wed, 06 May 2020 13:25:03 -0400
X-MC-Unique: uQ_uea3CNvmjGjMlKn4wMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 321A2461;
        Wed,  6 May 2020 17:25:01 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D33F8605F7;
        Wed,  6 May 2020 17:24:56 +0000 (UTC)
Date:   Wed, 6 May 2020 12:24:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200506172455.ho5em2mtzn7qqfjl@treble>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501202944.593400184@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:29:03PM +0200, Peter Zijlstra wrote:
> +++ b/arch/x86/include/asm/static_call.h
> @@ -30,4 +30,14 @@
>  	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
>  	    ".popsection					\n")
>  
> +#define ARCH_DEFINE_STATIC_CALL_RETTRAMP(name)				\
> +	asm(".pushsection .static_call.text, \"ax\"		\n"	\
> +	    ".align 4						\n"	\
> +	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
> +	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
> +	    "	ret; nop; nop; nop; nop;			\n"	\
> +	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
> +	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> +	    ".popsection					\n")
> +

The boilerplate in these two trampoline macros is identical except for
the actual instructions, maybe there could be a shared
__ARCH_DEFINE_STATIC_CALL_TRAMP(name, insns) macro which does most of
the dirty work.

>  #endif /* _ASM_STATIC_CALL_H */
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -4,19 +4,41 @@
>  #include <linux/bug.h>
>  #include <asm/text-patching.h>
>  
> -static void __static_call_transform(void *insn, u8 opcode, void *func)
> +enum insn_type {
> +	call = 0, /* site call */
> +	nop = 1,  /* site cond-call */
> +	jmp = 2,  /* tramp / site tail-call */
> +	ret = 3,  /* tramp / site cond-tail-call */
> +};

The lowercase enums threw me for a loop, I thought they were variables a
few times.  Starting a new enum trend? :-)

>  void arch_static_call_transform(void *site, void *tramp, void *func)
> @@ -24,10 +46,10 @@ void arch_static_call_transform(void *si
>  	mutex_lock(&text_mutex);
>  
>  	if (tramp)
> -		__static_call_transform(tramp, JMP32_INSN_OPCODE, func);
> +		__static_call_transform(tramp, jmp + !func, func);
>  
>  	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
> -		__static_call_transform(site, CALL_INSN_OPCODE, func);
> +		__static_call_transform(site, !func, func);

Clever enum math, but probably more robust to be ignorant of the values:

	if (tramp)
		__static_call_transform(tramp, func ? jmp : ret, func);

  	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
		__static_call_transform(site, func ? call : nop, func);


> +++ b/include/linux/static_call.h
> @@ -16,7 +16,9 @@
>   *
>   *   DECLARE_STATIC_CALL(name, func);
>   *   DEFINE_STATIC_CALL(name, func);
> + *   DEFINE_STATIC_COND_CALL(name, typename);
>   *   static_call(name)(args...);
> + *   static_cond_call(name)(args...)
>   *   static_call_update(name, func);

Missing semicolon, also an updated description/example would be useful.

On that note, what do you think about tweaking the naming from

  DEFINE_STATIC_COND_CALL(name, typename);
  static_cond_call(name)(args...);

to

  DEFINE_STATIC_CALL_NO_FUNC(name, typename);
  static_call_if_func(name)(args...);

?

Seems clearer to me.  They're still STATIC_CALLs, so it seems logical to
keep those two words together.  And NO_FUNC clarifies the initialized
value.

Similarly RETTRAMP could be ARCH_DEFINE_STATIC_CALL_NO_FUNC.

-- 
Josh

