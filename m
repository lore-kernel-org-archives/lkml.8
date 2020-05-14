Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1880C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84748206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgENR3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgENR3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:29:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B15C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 10:29:20 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZHer-0004SD-Fe; Thu, 14 May 2020 19:28:33 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CC7171004CE; Thu, 14 May 2020 19:28:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes\, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V4 part 4 15/24] x86/db: Split out dr6/7 handling
In-Reply-To: <552488029.20647.1589423096441.JavaMail.zimbra@efficios.com>
References: <20200505134926.578885807@linutronix.de> <20200505135314.808628211@linutronix.de> <552488029.20647.1589423096441.JavaMail.zimbra@efficios.com>
Date:   Thu, 14 May 2020 19:28:32 +0200
Message-ID: <871rnmzarj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> ----- On May 5, 2020, at 9:49 AM, Thomas Gleixner tglx@linutronix.de wrote:
>> +
>> +static __always_inline void debug_exit(unsigned long dr7)
>> +{
>> +	set_debugreg(dr7, 7);
>> +}
>
> Out of curiosity, what prevents the compiler from moving instructions
> outside of the code regions surrounded by entry/exit ? This is an always
> inline, which invokes set_debugreg which is inline for CONFIG_PARAVIRT_XXL=n,
> which in turn uses an asm() (not volatile), without any memory
> clobber.
>
> Also, considering that "inline" is not sufficient to ensure the compiler
> does not emit a traceable function, I suspect you'll also want to mark
> "native_get_debugreg" and "native_set_debugreg" always inline as well.

It can move it into a function and call that. Fine. If that function
stays in the noinstr section then it should not emit a trace stub and if
it moves it out of the section or reuses another instance in text then
objtool will complain.

Checking for trace stubs and other instrumentation nonsense is on the
objtool wishlist anyway.

But yes, marking these __always_inline prevents that. Those escaped my
chase. But I would have found them once I go and fix that paravirt muck.

Thanks,

        tglx


