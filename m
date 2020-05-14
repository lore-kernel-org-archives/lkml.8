Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E25C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8C9205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ZHpBqhG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgENPIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgENPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:08:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445C7C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:08:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q9so894062pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=4GWceYLJdSvfpD/nEJEfI5ey8cVcCIdOsUccPiJ0f+g=;
        b=ZHpBqhG0m51QPbBQAghcB7ijlWVcZJPoBgxlLqjhXfvHNcyjjE0ZeLxjz2LpkZaPSI
         wfl0maSFHqiH67JXXhCnUZ3tjLB4NubdlCMlUenRyVKFgeRck/51yRG2tu36+oxfV7nZ
         6vQ5koZy5BvJmCIkqeuI9PJ79ql2l83G9qOpwERUi8j/QTscWO6vRPsfQ6AfVP5LSEGW
         7lY/WVEBS7PNWMvC/HlBG0Pfzr7P6fH73Niyg3qT2NMaiJ1Z9JHiq2QPJrBSuiDO82jE
         88DIjStmeJnA9xXJC8lNUf7s0doE706rROSri9ZaB9hKL2Rf4PrNL++m1IANj0RrOHAm
         TLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=4GWceYLJdSvfpD/nEJEfI5ey8cVcCIdOsUccPiJ0f+g=;
        b=IDjRGIRP7bQppRwPblc+pbKRgIxpjf4kxWXcfKM6HGx+Ts5lA+BnTZ4dqkxNlQoCAG
         NuC659Nyl6PpOmarSuJLZ5OCfYt8VBddJF50QAeVFOF3pIZqLh3Mna7OhKzndInkKgIU
         /J6UYvTf0AMdKrdMcesy3y4pccnxghF+M6AbD5Gl5DIizwtyEatfUF+kb67WdTmL87s0
         DS9F0cWzPKXT8zSqB8vkTHtH4SRpgOPyWNGWHa9Rs8YKjqFjTYhkMOMd6QjtBnYa1a+n
         VJwtgcjBB/7zweRRRDkxyTGM+rNNozVZ8Cv+qe4T9pY32Jnyx7hMd0gazbTQVuyK7L1l
         tUoA==
X-Gm-Message-State: AOAM533xM1xCVTFRc8SoJK90LyytFyQTPQ9T8GU44awWd6QDZQTaqgFo
        N8GB20GLLHLs41ocXue8TS7R8A==
X-Google-Smtp-Source: ABdhPJy2kpemGwELXXHbWwBr3CJp48A4SCCSACjEtGu0Wf8H+JphPNS/CoKn97mBSVju6wmYc2gP4g==
X-Received: by 2002:a17:90a:f994:: with SMTP id cq20mr4309344pjb.52.1589468929278;
        Thu, 14 May 2020 08:08:49 -0700 (PDT)
Received: from ?IPv6:2600:1010:b044:c0a6:fc3e:abd:d4e0:e1e4? ([2600:1010:b044:c0a6:fc3e:abd:d4e0:e1e4])
        by smtp.gmail.com with ESMTPSA id p66sm2495160pfb.65.2020.05.14.08.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 08:08:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V4 part 4 02/24] x86/int3: Avoid atomic instrumentation
Date:   Thu, 14 May 2020 08:08:46 -0700
Message-Id: <B72D7A5A-B54A-4128-9EB3-BF85E74DA5B1@amacapital.net>
References: <878shuzhcx.fsf@nanos.tec.linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
In-Reply-To: <878shuzhcx.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 14, 2020, at 8:06 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFPeter Zijlstra <peterz@infradead.org> writes:
>>> On Thu, May 14, 2020 at 02:51:32PM +0200, Thomas Gleixner wrote:
>>> Peter Zijlstra <peterz@infradead.org> writes:
>>>> On Wed, May 13, 2020 at 09:57:52PM -0700, Andy Lutomirski wrote:
>>>>> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wr=
ote:
>>>>>>=20
>>>>>> From: Peter Zijlstra <peterz@infradead.org>
>>>>>>=20
>>>>>> Use arch_atomic_*() and READ_ONCE_NOCHECK() to ensure nothing untowar=
d
>>>>>> creeps in and ruins things.
>>>>>>=20
>>>>>> That is; this is the INT3 text poke handler, strictly limit the code
>>>>>> that runs in it, lest it inadvertenly hits yet another INT3.
>>>>>=20
>>>>>=20
>>>>> Acked-by: Andy Lutomirski <luto@kernel.org>
>>>>>=20
>>>>> Does objtool catch this error?
>>>>=20
>>>> It does not. I'll put it on the (endless) todo list..
>>>=20
>>> Well, at least it detects when that code calls out into something which
>>> is not in the non-instrumentable section.
>>=20
>> True, but the more specific problem is that noinstr code can use
>> jump_label/static_call just fine.
>>=20
>> So a more specific test is validating none of that happens in the INT3
>> handler before poke_int3_handler(). Which is what I think Andy was
>> after.
>=20
> Indeed. Forgot about that one.
>=20
> Hmm, alternatives and jumplabel patch locations in entry.text and
> noinstr.text can be valid at least during early boot where we know that
> we don't run those code pathes...

Alternatives should be valid regardless. Isn=E2=80=99t the world essentially=
 stopped while we apply them?

>=20
> Thanks,
>=20
>        tglx
