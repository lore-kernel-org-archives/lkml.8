Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55693C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB89206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgGJWNf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgGJWNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:13:35 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E6E2068F;
        Fri, 10 Jul 2020 22:13:33 +0000 (UTC)
Date:   Fri, 10 Jul 2020 18:13:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 09/17] x86/static_call: Add out-of-line static call
 implementation
Message-ID: <20200710181331.1ad69ef6@oasis.local.home>
In-Reply-To: <20200710134336.679277058@infradead.org>
References: <20200710133831.943894387@infradead.org>
        <20200710134336.679277058@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 15:38:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Add the x86 out-of-line static call implementation.  For each key, a
> permanent trampoline is created which is the destination for all static
> calls for the given key.  The trampoline has a direct jump which gets
> patched by static_call_update() when the destination function changes.

FYI, I get the following warnings after applying this patch.

/work/git/linux-test.git/arch/x86/kernel/static_call.c: In function ‘__static_call_transform’:
/work/git/linux-test.git/arch/x86/kernel/static_call.c:9:43: warning: passing argument 2 of ‘text_gen_insn’ makes pointer from integer without a cast [-Wint-conversion]
    9 |  const void *code = text_gen_insn(opcode, (long)insn, (long)func);
      |                                           ^~~~~~~~~~
      |                                           |
      |                                           long int
In file included from /work/git/linux-test.git/arch/x86/include/asm/static_call.h:5,
                 from /work/git/linux-test.git/include/linux/static_call.h:62,
                 from /work/git/linux-test.git/arch/x86/kernel/static_call.c:2:
/work/git/linux-test.git/arch/x86/include/asm/text-patching.h:95:44: note: expected ‘const void *’ but argument is of type ‘long int’
   95 | void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
      |                                ~~~~~~~~~~~~^~~~
/work/git/linux-test.git/arch/x86/kernel/static_call.c:9:55: warning: passing argument 3 of ‘text_gen_insn’ makes pointer from integer without a cast [-Wint-conversion]
    9 |  const void *code = text_gen_insn(opcode, (long)insn, (long)func);
      |                                                       ^~~~~~~~~~
      |                                                       |
      |                                                       long int
In file included from /work/git/linux-test.git/arch/x86/include/asm/static_call.h:5,
                 from /work/git/linux-test.git/include/linux/static_call.h:62,
                 from /work/git/linux-test.git/arch/x86/kernel/static_call.c:2:
/work/git/linux-test.git/arch/x86/include/asm/text-patching.h:95:62: note: expected ‘const void *’ but argument is of type ‘long int’
   95 | void *text_gen_insn(u8 opcode, const void *addr, const void *dest)


-- Steve

