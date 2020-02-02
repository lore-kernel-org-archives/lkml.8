Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D5FC35240
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 09:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5CD2067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 09:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKbbrJgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgBBJc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 04:32:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53630 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBBJc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 04:32:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so12648675wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 01:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qMT94qpo08FV4JrVN2N33KTdwZL0E+uToQonSqkknrY=;
        b=TKbbrJghnHSsK9G5qTvMvN+qZV8beOC1UJdIaBCa7to8QUHx7gvvfk8hOk3TdWIFmM
         URHiS8zNLACQ2fBJP+Xkg1uWeBqKGsyfgBIQroREpmvXGdohLnhUt86QU1mED8qG6JGj
         VfHx7TIXWELCSqJrp2lkS2dKlxd2l/9L5SYIr+kPVupL82XI2yNzuyw9lXeSjFF55Cxq
         xB8xtTdiJxRZK6he6rtheSBdk40B8yT4wM1TPbmUhurVs73HeWn8R5+sinI8S3YYR+E2
         9PUrchJYp6hsm0PPNJbbYA6zp176RWPJHBPB6HPwKpoFZ81cMctfWcmOzJp0zvIOMHUC
         YvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qMT94qpo08FV4JrVN2N33KTdwZL0E+uToQonSqkknrY=;
        b=VIWuLZcsp7zfwsUr5nTfnZbcK4qrckCK5VT+rtM/X6Wp2s66fPARvdxzu/VSQFc4nc
         EXpORM4z05JuR9O6GWUPFCNcqk2qrSvroNp7cbP4WwFakUbUpQDGQuvVFDtsv3kDQ3Bt
         zgFDJtGlsDegT7LhVfxP8b4pGZSMQa4cMEurUzumFphn1JbaoH3ZIkTA0dSkZ9JN7l9b
         5Y4qJqPPG7qhMOaAHLupS8KmzMYFo88b5GHtp2wdccePED/9ujbwodOTdMv3pkuSstDz
         ZqJpElMsDILTMgsDo5+AUJyC5HGPbqzoWYEizrhWDxF52Fl4UhLPktNnQJmyAnmFWL1f
         Pjpw==
X-Gm-Message-State: APjAAAXuK43lWiBdxk+0eUjcW4Od8uZJYZjddAjsBoymnSWqPsSf3Jlm
        ELUIgvpdlIrgfX4DE3nEhoDg8xiuKvlCTQMfQB7eHw==
X-Google-Smtp-Source: APXvYqyZH3VKlE/1dNe3lKk3WSMDzRxZuqLWT11AUrlEQA5plypiZHhkffqpUiFx1DKvwIJr+T2v0jUve4FVsyAMBAk=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr22350008wmf.40.1580635942488;
 Sun, 02 Feb 2020 01:32:22 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com> <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com> <CAPcyv4iYSptWo42p1Lnbr4NWRiWG2sat+f3t8Q0kPeiiXHx3fg@mail.gmail.com>
 <CADDKRnBeB5T7ZW2LxJQMR=AjD-OyOGBs4gqH0O9_frJ5zR5E7Q@mail.gmail.com>
 <CAKv+Gu9C2gR629xegjVfVkrPhAuG5brONzbL9iDgPSPW0Ffbbw@mail.gmail.com> <20200202092255.GA72728@gmail.com>
In-Reply-To: <20200202092255.GA72728@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 2 Feb 2020 10:32:11 +0100
Message-ID: <CAKv+Gu-QfKgXStODzbpwSFTHsgiSzFVKdbYiuhVPQF+XtV2MEA@mail.gmail.com>
Subject: Re: EFI boot crash regression (was: Re: 5.6-### doesn't boot)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2020 at 10:22, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > Hello J=C3=B6rg,
> >
> > Could you please try whether the change below fixes the issue?
> >
> > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> > index 59f7f6d60cf6..ae923ee8e2b4 100644
> > --- a/arch/x86/platform/efi/efi.c
> > +++ b/arch/x86/platform/efi/efi.c
> > @@ -308,7 +308,7 @@ static void __init efi_clean_memmap(void)
> >                         .phys_map =3D efi.memmap.phys_map,
> >                         .desc_version =3D efi.memmap.desc_version,
> >                         .desc_size =3D efi.memmap.desc_size,
> > -                       .size =3D data.desc_size * (efi.memmap.nr_map -=
 n_removal),
> > +                       .size =3D efi.memmap.desc_size * (efi.memmap.nr=
_map - n_removal),
> >                         .flags =3D 0,
>
> Oh, I actually noticed this one, but convinced myself that it's correct,
> because GCC didn't warn about uninitialized data.
>
> But maybe in this weird case data.desc_size as used within its own
> initializer is zero?
>

Something like that, yes. Note that size and desc_size appear in
opposite order in the struct definition, and this may also affect how
the compiler handles this.
