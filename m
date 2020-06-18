Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2133BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A9920890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BY559/uG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgFRT34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFRT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:29:56 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D170C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:29:55 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so3157192pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=mePZovKoQTiN9PrgeG8ZWbJqW0Zcln0rv9jAvoODERc=;
        b=BY559/uGnF2lLa/7W/7srf6ObzPJ05qqiYv2qDWkvPUpo6VMDXQX0mqmagLV8sQDVS
         p9Er8/sqg1ggPTLRKxpK7FPjYvCXRnQ6iim0s08BBLe53VZEL9yGHqHHYdAv9vhnUcqp
         ao6Fb8bNdsC0D82yu8+WBI7QKcNjfPDoSDV6y1uJNlKfRGHZCjXc7KhurU5KTyhNysD8
         +ZP6KZyOxuKSvXzqPHCZYTcdQgXB1jN7d1n/qITpbSdswu6zS3xV55x98KDIfJn7ywaW
         yAZWunb/FgIWBIE9jurpRolCI4jlLiEGiHvvP7wGOc1aNPjUde3OzmdYwQsqGTMSwtBj
         scUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=mePZovKoQTiN9PrgeG8ZWbJqW0Zcln0rv9jAvoODERc=;
        b=WlM+hENCw0bhYrQMHuEToyZRgVTrPGt84iqUHKAWKvuI2OuFB0skb8oLtHM/Chp9bz
         5oOGSGgSyBrTcnEOgo8O3O2s/MkDuS6ojLFsYXq5ylwqXVLsHTaGUvjeaiFes12cPaXz
         y/9XcX+p9h9GQspDcf5RW24djyPDzh5k1r5/aQniFFRnu7rCeiyVI9iYSf585QcUvVMS
         QXd+/0Tnw5adN8fs9s1evFF+hFk40fIjT4J5FGPjD/AacWVm1viNjky2XMxwq7dwBe2g
         n0xv41NHK97bn/uWb627bRnPxBeD3Brp139wrFd8cjFRaChM2QYJCzMziNO62f9mxBJ6
         vmpA==
X-Gm-Message-State: AOAM530lacI1MuwuGlZjfGu1HrAB6NIjVLxBg9rzvD+TGGKABvZWlLjU
        eQsqQYVpbMhDz/zTgbyUa0QqEA==
X-Google-Smtp-Source: ABdhPJzj6XSKvSQ3DWJpWlR57QGKogn4qqqHwZWcDFlh8K1QsMkQSMcoEEfOr+DOZivWWawBE3CjIg==
X-Received: by 2002:a17:90a:e02:: with SMTP id v2mr5789458pje.90.1592508594944;
        Thu, 18 Jun 2020 12:29:54 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:ed67:ccfd:60c9:4739? ([2601:646:c200:1ef2:ed67:ccfd:60c9:4739])
        by smtp.gmail.com with ESMTPSA id h4sm3052197pjq.55.2020.06.18.12.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 12:29:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/7] x86/entry: Fix #UD vs WARN more
Date:   Thu, 18 Jun 2020 12:29:50 -0700
Message-Id: <257B4193-08FB-4B3E-85E9-6C512B52C2C2@amacapital.net>
References: <20200618190207.GO576905@hirez.programming.kicks-ass.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>, jthierry@redhat.com,
        Miroslav Benes <mbenes@suse.cz>
In-Reply-To: <20200618190207.GO576905@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 18, 2020, at 12:02 PM, Peter Zijlstra <peterz@infradead.org> wrote:=

>=20
> =EF=BB=BFOn Thu, Jun 18, 2020 at 11:36:53AM -0700, Andy Lutomirski wrote:
>=20
>> I wasn't imagining going far down the rabbit hole at all -- I think
>> that, at most, we should cover the path for when the fault wasn't a
>> BUG/WARN in the first place.  I admit that, for #UD in particular,
>> this isn't a big deal, but if it were a different vector, this could
>> matter.
>=20
> Right, so there's 3 cases for ud2:
>=20
> - WARN;  ud2,  bug_entry, recovers
> - BUG;   ud2,  bug_entry, dies
> - UBSAN; ud2, !bug_entry, dies

4. The #UD matches an extable entry. I don=E2=80=99t know whether this ever h=
appens for real.

The failure is still a bit farfetched: we=E2=80=99d need an extable to hit i=
n an inconsistent state where we blow up due to a lack of entry handling.

>=20
> Nothing else should be generating ud2 instructions, any other #UD goes
> into handle_invalid_op() -> do_error_trap() -> ... -> die().
>=20
> [ while there, we should probably restructure do_trap() to have
>  cond_local_irq_enable() _after_ do_trap_no_signal(). ]
>=20
> We could probably change is_valid_bugaddr() to not use
> probe_kernel_address(), because if it couldn't read the instruction,
> we'd not be getting #UD in the first place.
>=20
> If we've gotten rid of probe_kernel_address() we can noinstr/inline that
> and then we can only call into report_bug() IFF ud2.
>=20
> Does that make things 'better' ? This can only go realy bad if there's a
> 1 byte instruction that triggers #UD, but I think that was ruled out.
>=20
>=20
> ---
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c26751e303f1..275a621f1aff 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -91,10 +91,7 @@ int is_valid_bugaddr(unsigned long addr)
>    if (addr < TASK_SIZE_MAX)
>        return 0;
>=20
> -    if (probe_kernel_address((unsigned short *)addr, ud))
> -        return 0;
> -
> -    return ud =3D=3D INSN_UD0 || ud =3D=3D INSN_UD2;
> +    return *(unsigned short *)addr =3D=3D INSN_UD2;
> }

I=E2=80=99m okay with this, at least until we get PKRS or kernel XO memory. B=
ut probe_kernel_addr() would be wrong then, too.  We need probe_kernel_text(=
).

But I think you might need some IRQ fiddling. With your patch, a WARN with I=
RQs on will execute the printk code with IRQs off without lockstep handling,=
 and an appropriately configured debugging kernel may get a recursive splat.=
  Or if irq tracing somehow notices that IRQs got turned off, the warning re=
covery might return back to an IF=3D1 context with IRQs traced as off.

So maybe also do an untraced cond_local_irq_enable()?  After all, if we=E2=80=
=99re trying to report a bug from IRQs on, it should be okay to have IRQs on=
 while reporting it. It might even work better than having IRQs off.

>=20
> static nokprobe_inline int
> @@ -220,15 +217,17 @@ static noinstr bool handle_bug(struct pt_regs *regs)=

> {
>    bool handled =3D false;
>=20
> -    /*
> -     * All lies, just get the WARN/BUG out.
> -     */
> -    instrumentation_begin();
> -    if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN) {
> -        regs->ip +=3D LEN_UD2;
> -        handled =3D true;
> +    if (is_valid_bugaddr(regs->ip)) {
> +        /*
> +         * All lies, just get the WARN/BUG out.
> +         */
> +        instrumentation_begin();
> +        if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN) {
> +            regs->ip +=3D LEN_UD2;
> +            handled =3D true;
> +        }
> +        instrumentation_end();
>    }
> -    instrumentation_end();
>=20
>    return handled;
> }
