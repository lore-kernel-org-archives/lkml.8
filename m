Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C95C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF0F20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGJXIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgGJXI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:08:29 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C8020767;
        Fri, 10 Jul 2020 23:08:27 +0000 (UTC)
Date:   Fri, 10 Jul 2020 19:08:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 13/17] static_call: Add static_call_cond()
Message-ID: <20200710190825.02c75c04@oasis.local.home>
In-Reply-To: <20200710134336.918547865@infradead.org>
References: <20200710133831.943894387@infradead.org>
        <20200710134336.918547865@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 15:38:44 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> +static void __static_call_transform(void *insn, enum insn_type type, void *func)
>  {
> -	const void *code = text_gen_insn(opcode, insn, func);
> +	int size = CALL_INSN_SIZE;
> +	const void *code;
>  
> -	if (WARN_ONCE(*(u8 *)insn != opcode,
> -		      "unexpected static call insn opcode 0x%x at %pS\n",
> -		      opcode, insn))

I would still feel better if we did some sort of sanity check before
just writing to the text. Confirm this is a jmp, call, ret or nop?

-- Steve


> -		return;
> +	switch (type) {
> +	case CALL:
> +		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
> +		break;
> +
> +	case NOP:
> +		code = ideal_nops[NOP_ATOMIC5];
> +		break;
> +
> +	case JMP:
> +		code = text_gen_insn(JMP32_INSN_OPCODE, insn, func);
> +		break;
> +
> +	case RET:
> +		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
> +		size = RET_INSN_SIZE;
> +		break;
> +	}
>  
> -	if (memcmp(insn, code, CALL_INSN_SIZE) == 0)
> +	if (memcmp(insn, code, size) == 0)
>  		return;
>  
> -	text_poke_bp(insn, code, CALL_INSN_SIZE, NULL);
> +	text_poke_bp(insn, code, size, NULL);
>  }
>  
