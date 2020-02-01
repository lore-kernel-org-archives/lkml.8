Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0B4C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E17E206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsQGX7rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgBAQCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 11:02:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45476 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgBAQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 11:02:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id a6so12237611wrx.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 08:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6b8uYS9CPKlmsBZbhWxjtDWAXh2DqCCCp+Wh+L8Ijbk=;
        b=CsQGX7rMhVh12Gl77KSY8X/7gmg2wME4lroqnigdQ55GpqHR8l9CaUNynpCjDffw32
         pfqU4dB3DqcEvz1RnIiEPJ1+9SzLfOj/1CCqpM0HclSf3ZcQUQmTrh1NgSA/u0Bzp8Su
         PNwQIsmfaWuPz6uDy1S86LHJ/tgWEo3vkgxfvA6Bq8BZmHW7kJgOJLLGP3dUyfB8zmLq
         fpZEMZpzSD/ENvuDHvKjmxNGa1f//NhoT5aY7Z8YGoHQ9Igm79FXJzUzOGuix5BYxY40
         ATNLVW02pOBgCqi+ru3KGjAF2E+sEea7H0V/DwtMkea/rp7eoFOspCWqN7FcRFxOZckV
         oYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6b8uYS9CPKlmsBZbhWxjtDWAXh2DqCCCp+Wh+L8Ijbk=;
        b=DYyrzf8vvB399iP0hC6JLP/Ie458hAmo3fO4+Ii7wX6EHLWRBmgcuCZAFbYXOwsg2R
         91XqBs6LMmJjbC2AiwF7PvIBSb1VmJddiMQLnB2IdnmyoCYhI/wyywdWm8Ki6HGCuo3M
         Hw5gGLeAVRUA6E31u531ZYjsXmm1/OArRIAswBTC6067BVLVrzdpEJVqCg897lmspPkV
         bUwIk5HqVrCbAQLEJJUiwU1ldBUk9worBUStPPGHQ1VV1QaoDUAQ6Fw5j8+wHxPoP61e
         RKb4yQA3fC7KEB5Mlv+xhGaM13Kxl+MNBShXCzATYx6ZiFBmeQM5OleJbK5KEdD0ivi2
         UBJQ==
X-Gm-Message-State: APjAAAVtq7r2wsyQfnRxXqGt0a7Pu9Y8u66ZmNJDwWHMcZgB0+OKugm2
        5iPAC7GvqlUNrAfT9ipX62mNzivw5r/z8CIfOcx7jA==
X-Google-Smtp-Source: APXvYqyb4pQo5elQ8alBFAmzuf/eiz512QF0iHzXLHzrGQWHa7IkE1eVkEGzpCtX6bhNNv0l+o74pn37qOXwfmhVhVA=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr4997240wrw.126.1580572950760;
 Sat, 01 Feb 2020 08:02:30 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com> <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com> <CAPcyv4iYSptWo42p1Lnbr4NWRiWG2sat+f3t8Q0kPeiiXHx3fg@mail.gmail.com>
 <CADDKRnBeB5T7ZW2LxJQMR=AjD-OyOGBs4gqH0O9_frJ5zR5E7Q@mail.gmail.com>
In-Reply-To: <CADDKRnBeB5T7ZW2LxJQMR=AjD-OyOGBs4gqH0O9_frJ5zR5E7Q@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 1 Feb 2020 17:02:19 +0100
Message-ID: <CAKv+Gu9C2gR629xegjVfVkrPhAuG5brONzbL9iDgPSPW0Ffbbw@mail.gmail.com>
Subject: Re: EFI boot crash regression (was: Re: 5.6-### doesn't boot)
To:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Feb 2020 at 16:35, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
>
> Am Fr., 31. Jan. 2020 um 19:48 Uhr schrieb Dan Williams
> <dan.j.williams@intel.com>:
> >
> > On Fri, Jan 31, 2020 at 10:37 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > (Cc:ed Dan and Ard)
> > >
> > > * J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
> > >
> > > > Am Fr., 31. Jan. 2020 um 07:43 Uhr schrieb Ingo Molnar <mingo@kerne=
l.org>:
> > > > >
> > > > >
> > > > > * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > > >
> > > > > > On Thu, Jan 30, 2020 at 9:32 AM J=C3=B6rg Otte <jrg.otte@gmail.=
com> wrote:
> > > > > > >
> > > > > > > my notebook doesn't boot with current kernel. Booting stops r=
ight after
> > > > > > > displaying "loading initial ramdisk..". No further displays.
> > > > > > > Also nothing is wriiten to the logs.
> > > > > > >
> > > > > > > last known good kernel is : vmlinuz-5.5.0-00849-gb0be0eff1a5a
> > > > > > > first known bad kernel is : vmlinuz-5.5.0-01154-gc677124e631d
> > > > > >
> > > > > > It would be lovely if you can bisect a bit. But my merges in th=
at
> > > > > > range are all from Ingo:
> > > > > >
> > > > > > Ingo Molnar (7):
> > > > > >     header cleanup
> > > > > >     objtool updates
> > > > > >     RCU updates
> > > > > >     EFI updates
> > > > > >     locking updates
> > > > > >     perf updates
> > > > > >     scheduler updates
> > > > >
> > > > > If I had to guess then perhaps the EFI changes look the most dang=
erous
> > > > > ones from these trees - but in principle most of these trees coul=
d
> > > > > contain a boot crasher/hang bug.
> > > > >
> > > > > > but not having any messages at all makes it hard to guess where=
 it
> > > > > > would be.
> > > > >
> > > > > To improve debug output:
> > > > >
> > > > > Removing any 'fbcon' options in /boot/grub/grub.cfg and adding th=
is to
> > > > > the boot options might improve the debug output:
> > > > >
> > > > >   earlyprintk=3Dvga initcall_debug ignore_loglevel debug panic_on=
_warn
> > > > >
> > > > > So for example if the relevant kernel boot entry in grub.cfg look=
s like
> > > > > this:
> > > > >
> > > > >   linux   /vmlinuz-5.3.0-26-generic root=3DUUID=3D1bcxabe3-0b62-4=
x04-b456-47cd90c0e6x4 ro  splash $vt_handoff
> > > > >
> > > > > Then editing it to the following could in principle produce (much=
) more
> > > > > verbose boot output:
> > > > >
> > > > >   linux   /vmlinuz-5.3.0-26-generic root=3DUUID=3D1bcxabe3-0b62-4=
x04-b456-47cd90c0e6x4 ro earlyprintk=3Dvga initcall_debug ignore_loglevel d=
ebug panic_on_warn $vt_handoff
> > > > >
> > > > > If this produces more output than just "loading initial ramdisk..=
' then a
> > > > > photo of the hung screen would be sufficient, no need to transcri=
be it.
> > > > >
> > > > > > A few bisect runs would narrow it down a fair amount. Bisecting=
 all the
> > > > > > way would be even better, of course,
> > > > >
> > > > > Agreed!
> > > > >
> > > > > If compiling full kernels for bisections takes too long (for exam=
ple
> > > > > because the .config is from a distro kernel) then running "make
> > > > > localmodconfig" to create a config tailored to the currently acti=
ve
> > > > > modules will cut down significantly on build time.
> > > > >
> > > > > Also, a warning: if the normal boot log contains spurious warning=
s then
> > > > > the new 'panic_on_warn' option will cause additional trouble on g=
ood
> > > > > kernels.
> > > >
> > > > It's bisected.
> > > > The first bad commit is :
> > > > 1db91035d01aa8bfa2350c00ccb63d629b4041ad
> > > > efi: Add tracking for dynamically allocated memmaps
> > >
> > > Thanks a ton, that's very useful!
> > >
> > > I've Cc:-ed the EFI gents who are developing this code, maybe they'll
> > > spot the bug.
> >
> > I'll take a look. J=C3=B6rg, can you paste a full dmesg from a good boo=
t?
>
> Here it is.
>

Hello J=C3=B6rg,

Could you please try whether the change below fixes the issue?

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 59f7f6d60cf6..ae923ee8e2b4 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -308,7 +308,7 @@ static void __init efi_clean_memmap(void)
                        .phys_map =3D efi.memmap.phys_map,
                        .desc_version =3D efi.memmap.desc_version,
                        .desc_size =3D efi.memmap.desc_size,
-                       .size =3D data.desc_size * (efi.memmap.nr_map -
n_removal),
+                       .size =3D efi.memmap.desc_size *
(efi.memmap.nr_map - n_removal),
                        .flags =3D 0,
                };
