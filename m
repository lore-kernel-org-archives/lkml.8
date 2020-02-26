Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF22C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7969B206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="vWy/JeKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBZRJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:09:40 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35735 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBZRJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:09:40 -0500
Received: by mail-pj1-f68.google.com with SMTP id q39so1519765pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=UBPrvXy09WZpAcWcslRLri/oOngl129nsy3OuzEGs0Y=;
        b=vWy/JeKOLLoMqtMRIE2O/CazBBrBpE5ZnXSzbU/4I0TCllMI+v/wBiYRlYlSUYnut6
         YihqkXFpovtq6VZn1vFOaj/vJEwlYciM1OZda8xrDduqp6kYYBxB5kK/57XMljMOnGni
         2XLmJRqKnjgxTWVwCsKtOGDNjGC2j3giEweMzlyYbJIwINX+fx+LU1iRrSJ2LCrNFhTl
         NQUPZKGdDyhzGr3Uz6oM29HE2oXzvEku6jm6qZWXVPQVDBQ4wBNYfRZ+dkTLO3LfEKqH
         P++cQnX43RoIpgDSIgHw8NPeF3B65vk+UX0fmvt4WkAILHbVYUlCBEKSb0M3dJnOdGj0
         FaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=UBPrvXy09WZpAcWcslRLri/oOngl129nsy3OuzEGs0Y=;
        b=UIfhFAeKcIaMC1iE2q6+M1D/1PQ3eZpGWHN0DHTOPHe9oC+TC2chUsjms9tY1QtQrM
         8vgirY2KuZLeH1peEpmb+2J0TrN1XdYOrdCTeRav7cw0SjqhnbVPJg0kaaoefuT1seca
         O4O8ex5S40nFRAW8jNNbIABz/ZGaJDaYFd87/CamOgYbUBZpzhQDC0A1F7gnsmn/JjHR
         EO5wVURFzpt8eP9UkT9LN/dv7t9rLGwTXYZnjGo1BmhKu9bOcycQz6jpRQ3TFJhnhHID
         5XadytGI9WeMLtAvmU0AR87ytlw01Ho4B+U3vEmYMx8Dp/6/nOrVUkvzH7vYC9c9QVwu
         FXgQ==
X-Gm-Message-State: APjAAAVaIm+95T13zRhnSyVs8qzpw17MXcJcqIAe2Zlw83VlBj+Ot2Yg
        EPmx5GWcnXvzbh1yMg1Vbgfdsg==
X-Google-Smtp-Source: APXvYqyZAt4EjomFpdp1M+Bd2OltQIChR7V906DwB+JfQn5Mios7GDDSx0n3x1ULmfkIUDtshEnwqg==
X-Received: by 2002:a17:90a:f0d1:: with SMTP id fa17mr79752pjb.90.1582736978968;
        Wed, 26 Feb 2020 09:09:38 -0800 (PST)
Received: from ?IPv6:2600:1010:b069:8a27:ddd9:92ea:d62b:8a52? ([2600:1010:b069:8a27:ddd9:92ea:d62b:8a52])
        by smtp.gmail.com with ESMTPSA id gx18sm3529920pjb.8.2020.02.26.09.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 09:09:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 13/16] x86/entry: Move irqflags and context tracking to C for simple idtentries
Date:   Wed, 26 Feb 2020 09:09:34 -0800
Message-Id: <2A899107-5AB8-4907-8AF2-31154A2E0A98@amacapital.net>
References: <20200226170534.GA6075@lenoir>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20200226170534.GA6075@lenoir>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 26, 2020, at 9:05 AM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Wed, Feb 26, 2020 at 09:05:38AM +0100, Peter Zijlstra wrote:
>>> On Tue, Feb 25, 2020 at 11:33:34PM +0100, Thomas Gleixner wrote:
>>>=20
>>> --- a/arch/x86/include/asm/idtentry.h
>>> +++ b/arch/x86/include/asm/idtentry.h
>>> @@ -7,14 +7,31 @@
>>>=20
>>> #ifndef __ASSEMBLY__
>>>=20
>>> +#ifdef CONFIG_CONTEXT_TRACKING
>>> +static __always_inline void enter_from_user_context(void)
>>> +{
>>> +    CT_WARN_ON(ct_state() !=3D CONTEXT_USER);
>>> +    user_exit_irqoff();
>>> +}
>>> +#else
>>> +static __always_inline void enter_from_user_context(void) { }
>>> +#endif
>>> +
>>> /**
>>>  * idtentry_enter - Handle state tracking on idtentry
>>>  * @regs:    Pointer to pt_regs of interrupted context
>>>  *
>>> - * Place holder for now.
>>> + * Invokes:
>>> + *  - The hardirq tracer to keep the state consistent as low level ASM
>>> + *    entry disabled interrupts.
>>> + *
>>> + *  - Context tracking if the exception hit user mode
>>>  */
>>> static __always_inline void idtentry_enter(struct pt_regs *regs)
>>> {
>>> +    trace_hardirqs_off();
>>> +    if (user_mode(regs))
>>> +        enter_from_user_context();
>>> }
>>=20
>> So:
>>=20
>>    asm_exc_int3
>>      exc_int3
>>        idtentry_enter()
>>          enter_from_user_context
>>            if (context_tracking_enabled())
>>=20
>>        poke_int3_handler();
>>=20
>> Is, AFAICT, completely buggered.
>>=20
>> You can't have a static_branch before the poke_int3_handler that deals
>> with text_poke.
>=20
> #BP is treated like an NMI in your patchset IIRC?
> In that case and since that implies we can't schedule, we can remove
> the call to context tracking there once we have nmi_enter()/nmi_exit()
> called unconditionally.

int3 from user mode can send signals. This has better be able to schedule by=
 the time it hits prepare_exit_to_usermode.=
