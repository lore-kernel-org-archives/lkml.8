Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EFEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDC22078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqvofOOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHMPRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHMPR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:17:28 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843B0C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:17:28 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so7633789ioe.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8dwh/4Imadgq0WaTB7ZBKce7byYk6xPwsVeBX51jP78=;
        b=jqvofOOFIBHscf26Kjlsq+4v6k54fQOuKNgWlZZJhAZTNnt4pvPpg/V1xtRkcaSlHW
         /lLq0wEjdjX3eZokELjQTtmtnYhJYVOfeNRgZe6r5n+dbo2d8zuUfQkV5DQt60RBjwIL
         bw/OwwcPW7szDwqq8kiolUsVivGhHKViDO4jppPxkg+v4GPjH8Mr90Zs9sFcDyGRoHpR
         B9pBAGZEZH6opRMgc+syrxd5p1kHeYBkOqJsUdL9eTYz2yHjgCUwB9B3P2qabgs1jxga
         1bQ27RsrKacmQvgbfPKJaZyAktx7/fNTE+OWxMVYXbEAnvBhsofxMGqXuuyxEr6v1XjP
         fb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8dwh/4Imadgq0WaTB7ZBKce7byYk6xPwsVeBX51jP78=;
        b=cIpGiBKaP1gfSe6ZGR2oX0tNYngqnMfKrSwyq55wtUMzYbORkucsFwj6jycfE03bOk
         cPUaC6VhF2t6RBzYP0hWwpw0bvsVdkTCUttEx5vKHPmFHrT04Wb+cqv09lIUHNkmd/v5
         unmAf4N+3ulbZZrUpcmiv7mwC5Zqwii812h6wPA3qLfQiiymKW/hz3PMG2g0+HKPVQf6
         PajhP3b5XzfHgLgmSoMNx/R1hoNrVTQzDv1vOsbbjeZ8d08VUKmdNSBlPIJMqJGBOhzK
         tXGUGv/JWi/FuSf85kWlQoI9jG9Jrsf/WyyKHTiFzFQTwvOMo1R1m6AtRSzMIYXSuYTy
         Jo1g==
X-Gm-Message-State: AOAM530okoCJ487jby9ccbXX1Yi89sCm2+oBmSGk1cLrvc4tg+WrEKnS
        VSaYGIPn2AA8k3hKG3lQTSpUiDOwsDSfBkfGS+qFTLh/qCI=
X-Google-Smtp-Source: ABdhPJyKxltUt/uWNUcs/yFkvT1aYydqmCYr5+vYcd3Tm7xrcDR14K291BPvYsWKtr6dPLwlzMCADPcdaDCZ0BbrKJg=
X-Received: by 2002:a05:6638:d46:: with SMTP id d6mr5479078jak.124.1597331846952;
 Thu, 13 Aug 2020 08:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <1596767378-27241-1-git-send-email-zhaoqianligood@gmail.com> <87h7t6lt76.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87h7t6lt76.fsf@nanos.tec.linutronix.de>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Thu, 13 Aug 2020 23:17:16 +0800
Message-ID: <CAPx_LQEPRk1UnOkfPaU_Lfp-nQFe9bybeLFJ3X4wybGMzkhtmQ@mail.gmail.com>
Subject: Re: [PATCH] timer: mask unnecessary set of flags in do_init_timer
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2020=E5=B9=B48=E6=9C=8813=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Qianli Zhao <zhaoqianligood@gmail.com> writes:
>
> Please start the first word after the colon with an upper case letter.
>
> > do_init_timer can specify flags of timer_list,
>
> Please write do_init_timer() so it's entirely clear that this is about a
> function.
>
> > but this function does not expect to specify the CPU or idx.
>
> or idx does not mean anything unless someone looks at the
> code. Changelogs want to explain things so they can be understood
> without staring at the code.

will update changelog

> > If user invoking do_init_timer and specify CPU,
> > The result may not what we expected.
>
> Right. And which caller exactly hands in crappy flags?

This change is more of a sanity check to avoid these wrong use

> > E.g:
> > do_init_timer invoked in core2,and specify flags 0x1
> > final result flags is 0x3.If the specified CPU number
> > exceeds the actual number,more serious problems will happen
>
> More serious problems is not a really helpful technical explanation and
> 0x3 does not make sense for a changelog reader either because it again
> requires to look up the code.
>
> >       timer->entry.pprev =3D NULL;
> >       timer->function =3D func;
> > -     timer->flags =3D flags | raw_smp_processor_id();
> > +     timer->flags =3D (flags & ~TIMER_BASEMASK & ~TIMER_ARRAYMASK) |
> > raw_smp_processor_id();
>
> If the caller hands in invalid flags then silently fixing them up is
> fundamentally wrong. So this wants to be:
>
>    if (WARN_ON(flags & ~TIMER_INIT_FLAGS))
>         flags &=3D TIMER_INIT_FLAGS;
>
> and TIMER_INIT_FLAGS wants to be exactly the set of flags which are
> valid for being handed in by a caller, i.e.:
>
>       TIMER_DEFFERABLE, TIMER_PINNED, TIMER_IRQSAFE

This change is very good=EF=BC=8Cthanks for teaching

> Guess what happens when the caller hands in TIMER_MIGRATING?

If TIMER_MIGRATING is set in timer_setup, lock_timer_base will fall
into a dead loop

> If we do sanity checking then we do it correct and not just silently
> papering over the particular problem which you ran into.

Thanks for teaching.

I have updated patchset,please review.

> Thanks,
>
>         tglx
