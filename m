Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7EEC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19628222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Z4CoA9hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBZR24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:28:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39858 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgBZR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:28:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1548929plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=TYxMlchDsWTzAQqGtuUFORye8gi+lk3xkZ5bdDiqvoM=;
        b=Z4CoA9hnh8L+jurDjpxZJ+BydF+KwYOVQwMeI1DYu2jiEeFQKzTv4rvpSxQOPsx3Hr
         hEgibzcYv/CTe8u3rlY8ggjlctUSPs2FAnPLGOcImY3cSv6QNY3/rY6wj3O7ZYb2ULMd
         WL9SwrA2LrIVm++UwaLrlDXT1utPVNHpUPgyd+xHu9mhJ4EPT30ufg0NtuY2JIZIw892
         BWLpr5FuVa9qYUhTML2MiRvz/Jdgsb6mS49BdPo6ZO7hlAS3d/NG/Z9Cbgmr5VjLgOze
         jajQnvkZzEhYpUGq5RUTYk0DUdThV7uP3Fr1kNUd1uuGhuaJbcmCFQZ36POgCJRF5F/f
         gwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=TYxMlchDsWTzAQqGtuUFORye8gi+lk3xkZ5bdDiqvoM=;
        b=mqWPqlfud52eMXYiYSRsqikJ9Nh2u9UuuJyM/ejDJQyvgZHkkRlJOY+99QMBivJZvv
         kr8WMwE3DWJU9YT1yTAwPHeWTZTBq2Wof050iLj+AqsAc4IrFVtWL7ZgtRnH4NATDE7o
         66mpS400PMKuu30qS70bbkMLOyiHvDsNyhqbqpLlymGWNIX+AJJjx8t/NRbnoMDA/HTF
         35oD/9UI8o8dxe9t0kpDKmBVJXaMzKm6xQ81iBeA9669X/vZY4NfWsAkBMu9eBbSGVUC
         0FcU+SLD/ErmSFx1P0iIYBf6yjKvkjwESZ8cfqxp9NAQ2zC3GCy0KLIQGnqOe9OghFKJ
         ENfw==
X-Gm-Message-State: APjAAAWesSoLYbG0e2GPx1up3KM0HScDeu4lMRojxKcOv26lfZbFFyQE
        qq/Rhq4ovk5y9LS7RebC6gG8Sw==
X-Google-Smtp-Source: APXvYqy4IP03MOqgmU0gWvjAi34jyQU5whp5hG0kZFD5aRFBjBsDJMvPb3MLrJvZi/aLd51jKCvEHg==
X-Received: by 2002:a17:90a:da03:: with SMTP id e3mr142130pjv.57.1582738133792;
        Wed, 26 Feb 2020 09:28:53 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:55da:f727:3bee:8a? ([2601:646:c200:1ef2:55da:f727:3bee:8a])
        by smtp.gmail.com with ESMTPSA id g24sm3775110pfk.92.2020.02.26.09.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 09:28:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 02/10] x86/mce: Disable tracing and kprobes on do_machine_check()
Date:   Wed, 26 Feb 2020 09:28:51 -0800
Message-Id: <C06C32B4-BD69-4287-BC67-C3E225061A46@amacapital.net>
References: <20200226160818.GY18400@hirez.programming.kicks-ass.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20200226160818.GY18400@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 26, 2020, at 8:08 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> =EF=BB=BFOn Wed, Feb 26, 2020 at 07:10:01AM -0800, Andy Lutomirski wrote:
>>> On Wed, Feb 26, 2020 at 5:28 AM Peter Zijlstra <peterz@infradead.org> wr=
ote:
>>>> On Tue, Feb 25, 2020 at 09:29:00PM -0800, Andy Lutomirski wrote:
>>>=20
>>>>>> +void notrace do_machine_check(struct pt_regs *regs, long error_code)=

>>>>>> {
>>>>>>   DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
>>>>>>   DECLARE_BITMAP(toclear, MAX_NR_BANKS);
>>>>>> @@ -1360,6 +1366,7 @@ void do_machine_check(struct pt_regs *re
>>>>>>   ist_exit(regs);
>>>>>> }
>>>>>> EXPORT_SYMBOL_GPL(do_machine_check);
>>>>>> +NOKPROBE_SYMBOL(do_machine_check);
>>>>>=20
>>>>> That won't protect all the function called by do_machine_check(), righ=
t?
>>>>> There are lots of them.
>>>>>=20
>>>>=20
>>>> It at least means we can survive to run actual C code in
>>>> do_machine_check(), which lets us try to mitigate this issue further.
>>>> PeterZ has patches for that, and maybe this series fixes it later on.
>>>> (I'm reading in order!)
>>>=20
>>> Yeah, I don't cover that either. Making the kernel completely kprobe
>>> safe is _lots_ more work I think.
>>>=20
>>> We really need some form of automation for this :/ The current situation=

>>> is completely nonsatisfactory.
>>=20
>> I've looked at too many patches lately and lost track a bit of which
>> is which.  Shouldn't a simple tracing_disable() or similar in
>> do_machine_check() be sufficient?
>=20
> It entirely depends on what the goal is :-/ On the one hand I see why
> people might want function tracing / kprobes enabled, OTOH it's all
> mighty frigging scary. Any tracing/probing/whatever on an MCE has the
> potential to make a bad situation worse -- not unlike the same on #DF.
>=20
> The same with that compiler instrumentation crap; allowing kprobes on
> *SAN code has the potential to inject probes in arbitrary random code.
> At the same time, if you're running a kernel with that on and injecting
> kprobes in it, you're welcome to own the remaining pieces.
>=20

Agreed.

> How far do we want to go? At some point I think we'll have to give
> people rope, show then the knot and leave them be.

If someone puts a kprobe on some TLB flush thing and an MCE does memory fail=
ure handling, it would be polite to avoid crashing.  OTOH the x86 memory fai=
lure story is *so* bad that I=E2=80=99m not sure how well we can ever really=
 expect this to work.

I think we should aim to get the entry part correct, and if the meat of the f=
unction explodes, so be it.

>=20
>> We'd maybe want automation to check
>> everything before it.  We still need to survive hitting a kprobe int3,
>> but that shouldn't have recursion issues.
>=20
> Right, so I think avoiding the obvious recursion issues is a more
> tractable problem and yes some 'safe' spot annotation should be enough
> to get automation working for that -- mostly.
