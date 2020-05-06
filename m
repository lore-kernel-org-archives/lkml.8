Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B624EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9165F20735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUhoz511"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgEFSJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:09:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51408 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728807AbgEFSJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588788581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cfkNWRertwyLjVSAuKSWweztXJA9vzPIlATJUsVOScs=;
        b=KUhoz511tHe6JgzmdvaGByvYy/l3293QXLzKwXDxkmJSBAAm2+rKJpl8rnN6C9t3+k390L
        9Js9rj9pXAMvm+BXtHTi2ZT3T9zaNPuWehLZAAdm0OrSEYAu6CADtsuhlv2gnCLsc/cZ7+
        Z+8eVl3KYKfeng+WKTr/CinqaFpY0C4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-SDNQ3XJUPHCo2TmI_7by5w-1; Wed, 06 May 2020 14:09:37 -0400
X-MC-Unique: SDNQ3XJUPHCo2TmI_7by5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DD0E106BF9A;
        Wed,  6 May 2020 18:09:35 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2546C707AA;
        Wed,  6 May 2020 18:09:26 +0000 (UTC)
Date:   Wed, 6 May 2020 13:09:24 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200506180924.tdn3zc7a3yte7kvv@treble>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <20200506172455.ho5em2mtzn7qqfjl@treble>
 <20200506175852.GW3762@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200506175852.GW3762@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 07:58:52PM +0200, Peter Zijlstra wrote:
> On Wed, May 06, 2020 at 12:24:55PM -0500, Josh Poimboeuf wrote:
> > On Fri, May 01, 2020 at 10:29:03PM +0200, Peter Zijlstra wrote:
> > > +++ b/arch/x86/include/asm/static_call.h
> > > @@ -30,4 +30,14 @@
> > >  	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> > >  	    ".popsection					\n")
> > >  
> > > +#define ARCH_DEFINE_STATIC_CALL_RETTRAMP(name)				\
> > > +	asm(".pushsection .static_call.text, \"ax\"		\n"	\
> > > +	    ".align 4						\n"	\
> > > +	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
> > > +	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
> > > +	    "	ret; nop; nop; nop; nop;			\n"	\
> > > +	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
> > > +	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> > > +	    ".popsection					\n")
> > > +
> > 
> > The boilerplate in these two trampoline macros is identical except for
> > the actual instructions, maybe there could be a shared
> > __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insns) macro which does most of
> > the dirty work.
> 
> I'm afraid that'll just make it less readable :/

#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insns)			\
	asm(".pushsection .static_call.text, \"ax\"		\n"	\
	    ".align 4						\n"	\
	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
	    insns "						\n"	\
	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
	    ".popsection					\n")

#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "jmp.d32 " # func)

#define ARCH_DEFINE_STATIC_CALL_RETTRAMP(name, func)			\
	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; nop; nop; nop; nop")

I like it.  Makes it easy to see the differences between the tramps.

> > >  #endif /* _ASM_STATIC_CALL_H */
> > > --- a/arch/x86/kernel/static_call.c
> > > +++ b/arch/x86/kernel/static_call.c
> > > @@ -4,19 +4,41 @@
> > >  #include <linux/bug.h>
> > >  #include <asm/text-patching.h>
> > >  
> > > -static void __static_call_transform(void *insn, u8 opcode, void *func)
> > > +enum insn_type {
> > > +	call = 0, /* site call */
> > > +	nop = 1,  /* site cond-call */
> > > +	jmp = 2,  /* tramp / site tail-call */
> > > +	ret = 3,  /* tramp / site cond-tail-call */
> > > +};
> > 
> > The lowercase enums threw me for a loop, I thought they were variables a
> > few times.  Starting a new enum trend? :-)
> 
> I can UPPERCASE them I suppose, not sure where this came from.

Just thought UPPERCASE was the standard... lowercase looks confusingly
like variables when referenced.

-- 
Josh

