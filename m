Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E022065F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="FUcPhaAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgE2Rho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Rhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:37:40 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331CCC08C5D1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:28:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so1613109pjd.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=cJfSRrco1qM2YXrH/DOel6eFytXDvyntky1ivJBXA2s=;
        b=FUcPhaASBKsv07EL+A0n46iZVTYwgOoJKc6tUqYO+SGfn2KCRIqzZ7UoZ0UN0w6YcG
         8mKgqSsAKSkNNPJomeokRa4O+O9kdc5lFT/SNfe0HJqkizwdh7ZNk5DqFSRI64df+CZj
         LNIiVw8cmbXRVLDy1d8aeHqLeOmt8yjQlbg+UCtFrK81UW7CwKl4tq1PN3OFv3jN0x3S
         ppnx1F5TAT60GCXZX6CJA0Vumqk6inj49KZbXncWaIaDym32BuXuBLuYZqBNfcLlPQiI
         eCqhpsAO7mthFwM31OpugwKO0WHd9k7q4rNbt1A8WTaN1dcpovyS2bVapRfsjKDS1js5
         zG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cJfSRrco1qM2YXrH/DOel6eFytXDvyntky1ivJBXA2s=;
        b=Xu2OUseFLa273MIRKq9iTf9I8a+8jT48OXYplxbgbKA1kc88cbpQ+dbMfjMOLAAJKb
         wdJLDmPZ+SZ3/vQ1WNkLt4HELF/iTtVtRePQt+ji0LAtD2/22h41xdI8njq1IW+7pDFz
         YjdLGwK3WaIip7ZRGshjHk5n1VcnnT2AjioM1D5v+mXniS3JjtgYXKvtu6l7YH+4XB4n
         9EQdTtXCwlMHc7Sad7aLmmpX5MjJrvgivQhTA6oVzVI2vj5BUdUz/S4NwLSeG1EBlruI
         YZB+3MIaHUhNRw1DEkR0D5LMZb1BidJtphcxTpI+0+WsKaV2TWNls6bYbwQ4MN3dus38
         cnPw==
X-Gm-Message-State: AOAM532P9rwwVzjb3Q02LowRmElHiqZms3Gf692fkix7thRswTCHpczf
        c4sPLnYKJnIuwzprYkMj70Rbcg==
X-Google-Smtp-Source: ABdhPJx5OBH+PjgSMcKmkauk+xVTBh76bT3bcmamqtNOqKDFatNbm5efaTa3W/6/tP2SttaSx5IqqQ==
X-Received: by 2002:a17:902:8c8a:: with SMTP id t10mr9864120plo.125.1590773316678;
        Fri, 29 May 2020 10:28:36 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:2dc1:c1e9:9ff7:54d4? ([2601:646:c200:1ef2:2dc1:c1e9:9ff7:54d4])
        by smtp.gmail.com with ESMTPSA id b4sm398931pfg.75.2020.05.29.10.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 10:28:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/6] x86/entry: Introduce local_db_{save,restore}()
Date:   Fri, 29 May 2020 10:28:33 -0700
Message-Id: <AC94E789-9EC7-4156-955C-841FF7114176@amacapital.net>
References: <20200528213352.GC4496@worktop.programming.kicks-ass.net>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, daniel.thompson@linaro.org
In-Reply-To: <20200528213352.GC4496@worktop.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 28, 2020, at 2:34 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> =EF=BB=BFOn Thu, May 28, 2020 at 11:15:50PM +0200, Peter Zijlstra wrote:
>>> On Thu, May 28, 2020 at 09:52:30PM +0100, Andrew Cooper wrote:
>>> On 28/05/2020 21:19, Peter Zijlstra wrote:
>>>> --- a/arch/x86/include/asm/debugreg.h
>>>> +++ b/arch/x86/include/asm/debugreg.h
>>>> @@ -113,6 +113,31 @@ static inline void debug_stack_usage_inc
>>>> static inline void debug_stack_usage_dec(void) { }
>>>> #endif /* X86_64 */
>>>>=20
>>>> +static __always_inline void local_db_save(unsigned long *dr7)
>>>> +{
>>>> +    get_debugreg(*dr7, 7);
>>>> +    if (*dr7)
>>>> +        set_debugreg(0, 7);
>>>=20
>>> %dr7 has an architecturally stuck bit in it.
>>>=20
>>> You want *dr7 !=3D 0x400 to avoid writing 0 unconditionally.
>>=20
>> Do we have to have that bit set when writing it? Otherwise I might
>> actually prefer masking it out.
>=20
> I'm an idiot, we write a plain 9..
>=20
>>> Also, API wise, wouldn't it be nicer to write "dr7 =3D local_db_save()"
>>> rather than having a void function returning a single long via pointer?
>>=20
>> Probably.. I started with local_irq_save() and .. well, n/m. I'll change
>> it ;-)
>=20
> How's this?
>=20
> ---
> --- a/arch/x86/include/asm/debugreg.h
> +++ b/arch/x86/include/asm/debugreg.h
> @@ -113,6 +113,36 @@ static inline void debug_stack_usage_inc
> static inline void debug_stack_usage_dec(void) { }
> #endif /* X86_64 */
>=20
> +static __always_inline unsigned long local_db_save(void)
> +{
> +    unsigned long dr7;
> +
> +    get_debugreg(&dr7, 7);
> +    dr7 ^=3D 0x400;

Why xor?  This seems extra confusing.

> +    if (dr7)
> +        set_debugreg(0, 7);
> +    /*
> +     * Ensure the compiler doesn't lower the above statements into
> +     * the critical section; disabling breakpoints late would not
> +     * be good.
> +     */
> +    barrier();
> +
> +    return dr7;
> +}
> +
> +static __always_inline void local_db_restore(unsigned long dr7)
> +{
> +    /*
> +     * Ensure the compiler doesn't raise this statement into
> +     * the critical section; enabling breakpoints early would
> +     * not be good.
> +     */
> +    barrier();
> +    if (dr7)
> +        set_debugreg(dr7, 7);
> +}
> +
> #ifdef CONFIG_CPU_SUP_AMD
> extern void set_dr_addr_mask(unsigned long mask, int dr);
> #else
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -727,15 +727,7 @@ static __always_inline void debug_enter(
>     * Entry text is excluded for HW_BP_X and cpu_entry_area, which
>     * includes the entry stack is excluded for everything.
>     */
> -    get_debugreg(*dr7, 7);
> -    set_debugreg(0, 7);
> -
> -    /*
> -     * Ensure the compiler doesn't lower the above statements into
> -     * the critical section; disabling breakpoints late would not
> -     * be good.
> -     */
> -    barrier();
> +    *dr7 =3D local_db_save();
>=20
>    /*
>     * The Intel SDM says:
> @@ -756,13 +748,7 @@ static __always_inline void debug_enter(
>=20
> static __always_inline void debug_exit(unsigned long dr7)
> {
> -    /*
> -     * Ensure the compiler doesn't raise this statement into
> -     * the critical section; enabling breakpoints early would
> -     * not be good.
> -     */
> -    barrier();
> -    set_debugreg(dr7, 7);
> +    local_db_restore(dr7);
> }
>=20
> /*
>=20
