Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CBBC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE49C2074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="e8AX+oNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgCYTfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:35:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34647 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbgCYTfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:35:32 -0400
Received: from [IPv6:2601:646:8600:3281:c898:2a71:8b3c:1618] ([IPv6:2601:646:8600:3281:c898:2a71:8b3c:1618])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 02PJYkiZ3555937
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 25 Mar 2020 12:34:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 02PJYkiZ3555937
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020032201; t=1585164890;
        bh=p0YpVfwC+aoOZ4NgH84gzFe9XflqvVIEwlLHk9I94xA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=e8AX+oNZ3XoGngvL1o9eHvVCjpXknqO1c5smzu6gqK+9OZm9gKkng3M7x6ndALLgW
         y8RECtMR8Jg3FI1QsnLC+eGpt8yoSPqTJ+DKnJj9VhtXkGRvpR8CAxIyPvkPvjXFKm
         LrNsjOTu0OVkCl1lHUu3h6t840jrpGXNcx/LMG3pT1QPRCrUdG9w7fwSNR5De/Feqx
         4D65DGdOjZUxOKNWsCm+vJakJul8P5LEyFBzgNK77GYt/ad5VWpDDD+ziIFlzYwYsy
         0/gjVTeIB+JcQmgvjmQ6HexUR1rEj3rlXj0FHGmcth1fGLC6i9cKlcYGLtkWGX5PtN
         diHHRYlzCLJzw==
Date:   Wed, 25 Mar 2020 12:34:38 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wim-2aaFi_GNs5KmX4ykkgQjnRo5D4B9ZK+1Oz=kpp_2A@mail.gmail.com>
References: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com> <86D80EA7-9087-4042-8119-12DD5FCEAA87@amacapital.net> <CAHk-=wim-2aaFi_GNs5KmX4ykkgQjnRo5D4B9ZK+1Oz=kpp_2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Peter Zijlstra <peterz@infradead.org>,
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
From:   hpa@zytor.com
Message-ID: <59FDEFC1-9353-453F-84E5-F94995157B27@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 24, 2020 9:33:21 AM PDT, Linus Torvalds <torvalds@linux-foundation=
=2Eorg> wrote:
>On Tue, Mar 24, 2020 at 9:22 AM Andy Lutomirski <luto@amacapital=2Enet>
>wrote:
>>
>> I haven=E2=80=99t checked if static calls currently support return valu=
es,
>but
>> the conditional case only makes sense for functions that return void=2E
>>
>> Aside from that, it might be nice for passing NULL in to warn or bug
>> when the NULL pointer is stored instead of silently NOPping out the
>> call in cases where having a real implementation isn=E2=80=99t optional=
=2E
>
>Both good points=2E I take back my question=2E
>
>And it aside from warning about passing in NULL then it doesn't work,
>I wonder if we could warn - at build time - when then using the COND
>version with a function that doesn't return void?
>
>Of course, one alternative is to just say "instead of using NOP, use
>'xorl %eax,%eax'", and then we'd have the rule that a NULL conditional
>function returns zero (or NULL)=2E
>
>I _think_ a "xorl %eax,%eax ; retq" is just three bytes and would fit
>in the tailcall slot too=2E
>
>                Linus

"movl $0,%eax" is five bytes, the same length as a call=2E Doesn't work fo=
r a tailcall, still, although if the sequence:

    jmp tailcall
    retq

=2E=2E=2E can be generated at the tailcall site then the jmp can get patch=
ed out=2E

This would be equivalent to disabling tailcalls except that the stack fram=
e is normally not unwound until between the call and the ret, so just disab=
ling tailcalls from the compiler pov doesn't work=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
