Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CA4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749D9207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doQaX3c/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgEVT02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 15:26:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29261 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730689AbgEVT02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 15:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590175587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hD46Afk+dhp/HiIe9hJCR9KCGG3Js+YzxCtVvkC5h1I=;
        b=doQaX3c/7hR15CntyW1Um9rBmdls4phxSf0O/3vH9niHSLDeE3gY93ipTXAz5hbcX7BQJ7
        1mY+1eFHwN5oBHlEqi1eLpiwGRMvngi9YCpJmkWWQPfaSKbJdDcldZKCVfn2g8ZyQo4u0t
        7ydqyvWGB6oFJLGS1k4rqQ0DOtcoV4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-tprr_IXaPzGsjNJBDUHoJw-1; Fri, 22 May 2020 15:26:23 -0400
X-MC-Unique: tprr_IXaPzGsjNJBDUHoJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0024D18FF660;
        Fri, 22 May 2020 19:26:21 +0000 (UTC)
Received: from treble (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B46146C77E;
        Fri, 22 May 2020 19:26:17 +0000 (UTC)
Date:   Fri, 22 May 2020 14:26:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V6 19/37] x86/irq: Convey vector as argument and not in
 ptregs
Message-ID: <20200522192615.5asnbnanfdiofaj6@treble>
References: <87sgfttobg.fsf@nanos.tec.linutronix.de>
 <f3be26a9-a0ed-fc6c-f25c-3fd41e718292@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3be26a9-a0ed-fc6c-f25c-3fd41e718292@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 02:48:53PM -0400, Boris Ostrovsky wrote:
> > Yes. They just make objtool very unhappy:
> >
> > arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0xfd0: special:
> > can't find orig instruction
> >
> > Peter suggested to use:
> >
> >       .pos = .
> >       .byte..
> >       jmp
> >       .nops (pos + 8) - .
> 
> 
> Unfortunately this (.nops directive) only works for newer assemblers
> (2.31, per
> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob_plain;f=gas/NEWS;h=9a3f352108e439754688e19e63a6235b38801182;hb=5eb617a71463fa6810cd14f57adfe7a1efc93a96)
> 
> 
> I have 2.27 and things don't go well.

A single nop should be fine, since gas will complain if it tries to move
the IP backwards.  (Also I'd vote for normal indentation instead of the
"assembler magic at 4 spaces" thing.)

.align 8
SYM_CODE_START(irq_entries_start)
	vector = FIRST_EXTERNAL_VECTOR
	.rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
		pos = .
		UNWIND_HINT_IRET_REGS
		.byte	0x6a, vector
		jmp	asm_common_interrupt
		nop
		.  = pos + 8
		vector = vector + 1
	.endr
SYM_CODE_END(irq_entries_start)

-- 
Josh

