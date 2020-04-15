Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F2BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A4E2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAq7bZEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbgDOCfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgDOCez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:34:55 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77904C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 19:34:54 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k21so1945830otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 19:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7NCTHkFb8srify26v+d/R/erV2NDO4/9sUz1z6PAqU=;
        b=gAq7bZEIZ/9CjRjLVjZoGerHRKHZ5lZD0UEPr3W5K6dHWKgFI0RUI2EGS0/qA0kTUw
         lsxmNRQE35tSfFFbaJYBC/+Mf78NKu499iUJXp8nmBgTmwNkIKhJwSTsy7olXWffEkyH
         p3EnyCncUWbwSj0vLUjKrSMah4fbzpL2nGSLqXvcZ2Ytfs7lOQuKHf1axLukTwlTMnFX
         RAulLoEZoX8m19MLkVtCurokhxsqI7ujG0mNlTuRgsDJhBnTno7tQvWBZXOTKngydWPd
         1ppY11u+tUfIosA4oVkDF5jq3dSqKxoC2vbxF9iyMg1VrTpeLo4mZfwdx1mGjr4Get5v
         P7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7NCTHkFb8srify26v+d/R/erV2NDO4/9sUz1z6PAqU=;
        b=MqbiKAkCpQHcgLijCArQlFoy3KmMAsRlzLZi6mevCN19KUSrEmgvWRsHJNvl+pA8wN
         J+g3CbS0gOEoKE6RGywTVICisA765d2hOYNxyCWdkifzTSaD1yks2KUi0EMEXjvlDNN3
         2wOXjerboypWnvtUjKtkaze9fLHd6HZgQyMxcBzSowtOpXwyrkDpKUh/AiBGXb2kR3m9
         QRfM5PstKzHhyQFaL+85xKkZBfRABHtJpVdM/ceQbkUN8sTXCxxWM0wh9UTPx+IWfugK
         nZTRKKxyMrUQTafaL7kQbVwBwoWG9dnabdLeoMxd2gufR7LqqJ/m1/5D4SNPf0/cdETZ
         lYBA==
X-Gm-Message-State: AGi0PuaVKZ/wJOokpJnaRt8Ubsf51uUm3qn1aIr0IXmNxzIR76sMQNhM
        K3SSfjPTNjEWAvN2EZGi8c7ZskNq0/Lb3rhthGI=
X-Google-Smtp-Source: APiQypJXSb94OJlaJ/kPpGtEtQyGeMuhJGrfLugpQAzrMNJoVNcMo2W2aS8RScemfMl7aWlnWzMfDFAcbAv28eMCOAM=
X-Received: by 2002:a9d:de2:: with SMTP id 89mr1153142ots.95.1586918093505;
 Tue, 14 Apr 2020 19:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200225073731.465270-1-avagin@gmail.com> <20200225073731.465270-4-avagin@gmail.com>
 <20200414172014.GA6705@C02TD0UTHF1T.local>
In-Reply-To: <20200414172014.GA6705@C02TD0UTHF1T.local>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 14 Apr 2020 19:34:41 -0700
Message-ID: <CANaxB-yBeSmYdZL6gbe-agDAaEVcYHrxUCojQ4xaWpsWinQsyA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm64/vdso: Add time napespace page
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 10:20 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Feb 24, 2020 at 11:37:28PM -0800, Andrei Vagin wrote:
> > Allocate the time namespace page among VVAR pages.  Provide
> > __arch_get_timens_vdso_data() helper for VDSO code to get the
> > code-relative position of VVARs on that special page.
> >
> > If a task belongs to a time namespace then the VVAR page which contains
> > the system wide VDSO data is replaced with a namespace specific page
> > which has the same layout as the VVAR page. That page has vdso_data->seq
> > set to 1 to enforce the slow path and vdso_data->clock_mode set to
> > VCLOCK_TIMENS to enforce the time namespace handling path.
> >
> > The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> > update of the VDSO data is in progress, is not really affecting regular
> > tasks which are not part of a time namespace as the task is spin waiting
> > for the update to finish and vdso_data->seq to become even again.
> >
> > If a time namespace task hits that code path, it invokes the corresponding
> > time getter function which retrieves the real VVAR page, reads host time
> > and then adds the offset for the requested clock which is stored in the
> > special VVAR page.
> >
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > ---
> >  arch/arm64/include/asm/vdso.h                 |  6 ++++++
> >  .../include/asm/vdso/compat_gettimeofday.h    | 11 ++++++++++
> >  arch/arm64/include/asm/vdso/gettimeofday.h    |  8 ++++++++
> >  arch/arm64/kernel/vdso.c                      | 20 ++++++++++++++++---
> >  arch/arm64/kernel/vdso/vdso.lds.S             |  5 ++++-
> >  arch/arm64/kernel/vdso32/vdso.lds.S           |  5 ++++-
> >  include/vdso/datapage.h                       |  1 +
> >  7 files changed, 51 insertions(+), 5 deletions(-)
>
> > +#ifdef CONFIG_TIME_NS
> > +static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
> > +{
> > +     const struct vdso_data *ret;
> > +
> > +     asm volatile("mov %0, %1" : "=r"(ret) : "r"(_timens_data));
> > +
> > +     return ret;
> > +}
> > +#endif
>
> What is this inline assembly for? The commit message doesn't mention it,
> there's no explanation here, and the native version doesn't do likewise
> so it seems rather surprising.

__arch_get_vdso_data is  right before this function and there is a
comment which explains this:
https://github.com/torvalds/linux/blob/master/arch/arm64/include/asm/vdso/compat_gettimeofday.h#L137

"""
/*
* This simply puts &_vdso_data into ret. The reason why we don't use
* `ret = _vdso_data` is that the compiler tends to optimize this in a
* very suboptimal way: instead of keeping &_vdso_data in a register,
* it goes through a relocation almost every time _vdso_data must be
* accessed (even in subfunctions). This is both time and space
* consuming: each relocation uses a word in the code section, and it
* has to be loaded at runtime.
*
* This trick hides the assignment from the compiler. Since it cannot
* track where the pointer comes from, it will only use one relocation
* where __arch_get_vdso_data() is called, and then keep the result in
* a register.
*/
"""

I decided to not duplicate the comment because these two functions are
very similar and close to each other.

Thanks,
Andrei
