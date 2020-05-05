Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32E9C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7A924971
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Lp4rHoS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgEEU1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:27:49 -0400
Received: from mail.efficios.com ([167.114.26.124]:49728 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbgEEU1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:27:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C60762A228A;
        Tue,  5 May 2020 16:27:44 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4EYqnJQ3nAPy; Tue,  5 May 2020 16:27:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 508502A2289;
        Tue,  5 May 2020 16:27:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 508502A2289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588710464;
        bh=GrEmWaFbMd1zFTo9Cuyp79HV+BYqRIRTCdvEBTTf208=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Lp4rHoS48kj8kZbeFHUHJBl80koszFDldwF0bz+C5sOrRkWG5tI0InMDDHd6YbqZN
         +7gZEeRoz3HXDyRf+xZedU44s8slQZluNIcJCvV53YlTX/fNniT6soWk32/RRjNmRK
         6+zuHPP/9O+8ujpiyryj9GNIoW8YHhvSv5WnRVdQ4UMZoN+czKCZswfoLWgsfT+QM1
         SvKMmWFRZ1KnFtss9Mkv+kx5SskHPnm8vkhGNJ2NXctPkp/waG/D8bAx86QicIrmvJ
         +kuixQJ1j+7laaMv6pHo/6inHLzyKn+twGlTUvnNU5ZK7ldaXPEPSCB7aIfFz8bXAq
         FTHEEiT3azbUg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cCHThXy3vm1O; Tue,  5 May 2020 16:27:44 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3CBD72A213F;
        Tue,  5 May 2020 16:27:44 -0400 (EDT)
Date:   Tue, 5 May 2020 16:27:44 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     ndesaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bristot <bristot@redhat.com>, jbaron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <470458191.1021.1588710464160.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAKwvOdnLze0e3Vwmb1Xdqwcwe9h6gnAwGnt3ksiNX7ENb_3Y9w@mail.gmail.com>
References: <20200501202849.647891881@infradead.org> <20200504201445.GQ3762@hirez.programming.kicks-ass.net> <20200505093625.GE5298@hirez.programming.kicks-ass.net> <CAKwvOd=cP8UCX0+5pZ3AqzvOM8LKzLJJ_heDhrghqJdOnHoGMg@mail.gmail.com> <CAKwvOdkL+2Gvn2mkZ8cdHN=1F5cHQHii57ocD0RFeLJxEt=TUQ@mail.gmail.com> <CAHk-=wiUd=fcpegFLK4VK9iFfrO5BmpGKDszGpuyJkDdz4JaoQ@mail.gmail.com> <656098739.766.1588705237442.JavaMail.zimbra@efficios.com> <CAKwvOdnLze0e3Vwmb1Xdqwcwe9h6gnAwGnt3ksiNX7ENb_3Y9w@mail.gmail.com>
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3928)
Thread-Topic: static_call: Add static_cond_call()
Thread-Index: LKX/yK89nuESaon3x7N5kSfc1EEjRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 3:57 PM, ndesaulniers ndesaulniers@google.com wrote:

> On Tue, May 5, 2020 at 12:00 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On May 5, 2020, at 2:48 PM, Linus Torvalds torvalds@linux-foundation.org
>> wrote:
>> [...]
>> >
>> > Your initial reaction that "you can't compile away the read and the
>> > test of NULL" was correct, I think.
>>
>> I suspect this pattern of "if (func != NULL) func(...)" could be semantically
>> changed to just invoking an empty function which effectively does nothing.
>> This would remove the need to do a pointer check in the first place. But maybe
>> I'm missing something subtle about why it has not been done in this context.
> 
> Good idea, this eliminates the check: https://godbolt.org/z/Xugo9w
> but you still have an indirect tail call (I think a direct tail call
> is the desired solution?)

Actually, if the goal is to do code patching of the call, I wonder
what makes it OK to "guess" all the call patterns generated by the compiler ?
AFAIU this is not an ABI in any way. For instance, a new compiler version could
choose to add some no-op instructions within this pattern just because it feels
like it.

For static jumps, we worked with the compiler people to add "asm goto ()" so
we could express a jump in assembly which would branch outside of the asm.
Emitting the jump in assembly allows us to control the exact code pattern,
which can then be patched, and the asm goto operands allow the compiler to
be in control of all the allowed branch targets.

I'm again possibly missing something, but it looks like this proposal of static_call()
(especially the static_cond_call part) is trying to just assume the common call
patterns generated by the compilers, and patch those. What is the expected behavior
if a compiler ends up generating unknown code patterns in future versions ?

I would think a more robust approach would be to, again, work with the compiler people
and introduce something like:

asm call ("asm goes here" : : : funcA, funcB, funcC )

which would allow patching the call emitted _in assembly_ between the various
available targets. Bonus points if the compiler can let the asm know whether
it's a standard call or tail-call.

Then once we have that, we can start doing fun stuff like adding a conditional
within the assembly, but I don't see why the conditional should be the same
variable as the actual function pointer: each can be changed independently as
long as the function pointer always points to a "valid" function (not NULL).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
