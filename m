Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F22C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47D2205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Q5YZfBJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgENBIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:08:32 -0400
Received: from mail.efficios.com ([167.114.26.124]:57702 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgENBIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:08:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 45DB92A0C6E;
        Wed, 13 May 2020 21:08:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mEMohs7_FPtL; Wed, 13 May 2020 21:08:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 070712A0AFD;
        Wed, 13 May 2020 21:08:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 070712A0AFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589418511;
        bh=FhTyE8LWuX6WlUGlMBeaYWjm/Q1NP7kLXF6iw65/YUE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Q5YZfBJ+RY1XLpTQiFg3WBXlkuI7kqbsXv4KEXiwRysh+65CoVBhmLwBaQLSDM9Y+
         Ds+MwRXP+kijGe6izH0ccRPLFSydqb7gp2PKcT4b0tU8e78Ru3jAKpZ35BhvoJ+d7u
         LzbbLoHmHRaBQ14Pp/OxN2HX29dHQuC2R9+xWKvsHMKT7/8ufZFOzgscOrHGpaooGQ
         I0oNuxlCBWtL3YYpZS2U4wFWZlbQwGN3hGuIQbYCBBGpA571l9yVzap3IrsWL/rEWh
         wTb4aSdxhQ9x8g+YS/Yp6LOKAB53k5x+skpMmN+ckPU5WuDAOlF2M1WX7/FRHJ8jSy
         OWTWFj5D3yYKw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LYmx08q-egiW; Wed, 13 May 2020 21:08:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E89922A0DC8;
        Wed, 13 May 2020 21:08:30 -0400 (EDT)
Date:   Wed, 13 May 2020 21:08:30 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Message-ID: <1632906547.20622.1589418510940.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200505134904.457578656@linutronix.de>
References: <20200505134354.774943181@linutronix.de> <20200505134904.457578656@linutronix.de>
Subject: Re: [patch V4 part 3 12/29] x86/entry/common: Provide
 idtentry_enter/exit()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/entry/common: Provide idtentry_enter/exit()
Thread-Index: ahehOQ76BIksR60DdD3qyNZdEVq5mQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 9:44 AM, Thomas Gleixner tglx@linutronix.de wrote:
[...]
> + * Invokes:
> + *  - lockdep irqflag state tracking as low level ASM entry disabled
> + *    interrupts.
> + *
> + *  - Context tracking if the exception hit user mode.
> + *
> + *  - RCU notification if the exception hit kernel mode

Nit: missing "." at end of line.

> + *
> + *  - The hardirq tracer to keep the state consistent as low level ASM
> + *    entry disabled interrupts.

> +			 * This needs to be done very carefully.
> +			 * idtentry_enter() invoked rcu_irq_enter(). This
> +			 * needs to undone before scheduling.

Nit: "to undone" -> "to be undone".

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
