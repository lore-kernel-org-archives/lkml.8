Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B88CC35249
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 22:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1439F2063A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 22:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qG0FOnbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgBAWgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 17:36:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36527 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgBAWgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 17:36:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so12747582wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 14:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AMOyLmKTPUkVM7s8/ZU8R055mCEqsvD4J4hy4uh7/s=;
        b=qG0FOnbQrdWCuWBOHD0nCh3Afys+v0czoppQHcFOaB2mPa24GEsOkGlxw26p9JaJl6
         vdaEQIrOOIZGlcQ5M5lJ16nvTe+KHIxGKa/6YvMcvnhrpBB0/pGXLZwe9bmI+u1WmtDI
         /e0h8KWwRrfPDxqpWcisYaY2YKL3XFyURABeHkZknyM1pBLJg2zx/7aJCvw1B2OpWbVj
         dxuVPWIHsHsQKZ0qhb/rPYI4eAvzaC7GGg+FNTQjgnMoqIn52PDjzk1Dtxz7cpYULVIT
         dW37ge0NVSOJuWYSuOP6jnvTa4vK+hhCBWtzdqxot2b0t7K725GQr+Pg1y51Iih0Oa0K
         JCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AMOyLmKTPUkVM7s8/ZU8R055mCEqsvD4J4hy4uh7/s=;
        b=RY5Nyg24dtI5nK76Aqq08HgneHM4MhVxZvd/GB9vI4WBNXu+Oa7qUwRF00l9/hB/Hk
         BcGXsoHcyiLdyCCmYhdLPLAS2/+2A2o69r+VC/ZO5TxFC06pTUaEPBF5HkRg1jnU5+fm
         h4w19csnHx1oIPirvcky8zb4C2PanysVL4rJI3evRdpEoLQ+mJyzsUbHj2Ducz/A/gTh
         Ha29pYByoId6jCIBE2QKU/hXfBemdPFzQUkdOEAieMKHwigTtBbl07zWzineRqak9kTq
         t6j7GNmQ6TDLp2Occ9eZfH9PQUieXzCn+anrYdKvivIZ4nzGE6bMNjSm3J4TkHueCTE1
         jC7A==
X-Gm-Message-State: APjAAAUsmK8ezs2OxMXMijd7e5BRIwfzOhSWOipd87XM3bIPIzgpDJJz
        2tCmgs0nphdjNgaUzPKNfVPqPwx8gP+UI2K6zIJD8g==
X-Google-Smtp-Source: APXvYqz1ySFbhi3UolsuLzff1BGpmy3jbwgADnyh8YTBy7zWJKbBa7usS6eZV4GGAHl9sJYGbQa26258puKXsRULmcs=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr21290326wmk.68.1580596582689;
 Sat, 01 Feb 2020 14:36:22 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com> <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com> <CAKv+Gu-oPrM7oh-oTbpQsUmXcYvp9KxjXFb3DUGk__qu59rdBQ@mail.gmail.com>
 <CAPcyv4j7oraMPOhSePaXhULaNJNTFTx+TcJ-y2bqQmvNsTQDmg@mail.gmail.com>
 <CAKv+Gu-bAbc7a1-H5gadQ=YkfKpQUt__3J5cctDNLz1g8gH92A@mail.gmail.com> <CAPcyv4gPrJe2DSPyPJjJQLakEVs3w6x-jDVbX7iydw3D9C4iRQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gPrJe2DSPyPJjJQLakEVs3w6x-jDVbX7iydw3D9C4iRQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 1 Feb 2020 23:36:11 +0100
Message-ID: <CAKv+Gu8xcww0n9Apnb+ASeyb4pNVuMjJeopO-hC6NDAGQzVg3w@mail.gmail.com>
Subject: Re: EFI boot crash regression (was: Re: 5.6-### doesn't boot)
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Feb 2020 at 23:31, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sat, Feb 1, 2020 at 1:49 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Sat, 1 Feb 2020 at 22:44, Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, Jan 31, 2020 at 10:45 AM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > earlycon=efifb may help to get better diagnostics, but you will need to use a camera to capture the output
> > >
> > > https://photos.app.goo.gl/uA3Wkaxc8x6A4gK47
> >
> > Yeah, so it definitely has to do with the n_removal > 0 path.
> >
> > Did you try the change I suggested to Joerg?
>
> Nice, it worked.
>
> Tested-by: Dan Williams <dan.j.williams@intel.com>

Thanks for confirming. I'll spin a proper patch.
