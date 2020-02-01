Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FABAC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6161F206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kJk5wVLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgBAQXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 11:23:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38131 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgBAQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 11:23:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id l9so6676776oii.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p/vKMWZy6f6185CSCxovAEoUY0CXrWTx67dIKvXxj5M=;
        b=kJk5wVLqj38qEfmGBf/Vwv67i6Ko7Hoca+5QX6XXkE1vxbUAr2DrYXhWc8MnpDQe8C
         +65SEweP7HpRC1gM4PGr3ZjcsHoIHOfpc+GskHIwHBzoJ/PyTObJfsz65ToJ2lTHUhPI
         P8jidiASVCEYHMGpiI6Qb1+fIunPMUb/AvZNT0SJpajASdD2kokaAafZs3ywy0kkCZrP
         cNc1WT3MaGdt/KfvwjJYC+U4B8LIVMBCI28kV9CPENkYOFPBtwl0ADsPSESqSEphrGzl
         m8jypgAqHPuUoYsOjt/DRoav7Rb2ravWmdtSH+RVy+4MeWy+F3ZR6hbV1Se9wnYCB5X+
         ttvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p/vKMWZy6f6185CSCxovAEoUY0CXrWTx67dIKvXxj5M=;
        b=fi7af921u0ynuZNqKLHwJdcTKI2W2J89ptis4PVpZ2KF9uWm95TXMvfP5aLRvxokdm
         8QpAof1OJXh8CTEIVOnmzVdaaoMRqAYj1HZ7TvzJSXGhv+I5RXXsljkCBnsQFNx7Ryja
         I/Sn187IatrHJKF/cfJMNTzNlftj7rRmaZk3Y4l6maXYvCNM/NCKL2dA3ht6bGwj9kjX
         7zRz3qNfRFVEv7hJmN4WsZFwj/bldidXfylYe71Dg3I/JrrbYtdT3w0Kh7/YByMEll+0
         lB1LNLsoOsGkQN5X1RSbaofAuu6a4fkG+QtpESg0ep/soeX39QRlvw4MfyNwS4jJ64sO
         UeYA==
X-Gm-Message-State: APjAAAWQjJPOok2ipEldZ9w63GjmtJ0sqTwZJrPXpWewAJDLr4Xw/7B/
        m7PbrfvEyKSi7heB23Jin9X+kFBh9ixD2mIG3DZN8UTH3tw=
X-Google-Smtp-Source: APXvYqyabzBNs1wd9EXweoC8oZ1LcUMTFu0ICF6WHFQiMA5/sLpP2eTst3r95hX+WxvlCm7LZQqsf5oiFnVAxzopSFo=
X-Received: by 2002:aca:aa0e:: with SMTP id t14mr9964950oie.149.1580574233222;
 Sat, 01 Feb 2020 08:23:53 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com> <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com> <20200201094545.GC71555@gmail.com>
In-Reply-To: <20200201094545.GC71555@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 1 Feb 2020 08:23:42 -0800
Message-ID: <CAPcyv4iH6BA4Oo7ZedWMG_28cp1KauQET58qOpR7012aaHWzbQ@mail.gmail.com>
Subject: Re: [TEST PATCH RFC] Revert the EFI leak fixes for now (was: Re: EFI
 boot crash regression (was: Re: 5.6-### doesn't boot))
To:     Ingo Molnar <mingo@kernel.org>
Cc:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
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

On Sat, Feb 1, 2020 at 1:45 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
>
> J=C3=B6rg Otte wrote:
>
> > It's bisected.
> > The first bad commit is :
> > 1db91035d01aa8bfa2350c00ccb63d629b4041ad
> > efi: Add tracking for dynamically allocated memmaps
>
> > Unfortunately I can not revert because of compile errors!
> >
> > In file included from /media/jojo/deftoshiba/kernel/linux/init/main.c:4=
8:
> > /media/jojo/deftoshiba/kernel/linux/include/linux/efi.h:975:1: error:
> > version control conflict marker in file
> > <<<<<<< HEAD
>
> So 1db91035d0 doesn't revert cleanly, because 484a418d0754 depends on it,
> plus there a third commit (f0ef6523475f) that has a semantic dependency
> on 1db91035d01a.
>
> But you can revert them all, if done in reverse chronological order:
>
>   git revert f0ef6523475f # ("efi: Fix efi_memmap_alloc() leaks")
>   git revert 484a418d0754 # ("efi: Fix handling of multiple efi_fake_mem=
=3D entries")
>   git revert 1db91035d01a # ("efi: Add tracking for dynamically allocated=
 memmaps")
>
> You can paste those three lines into a shell as-is, or you can apply the
> patch below which is a combination of these three reverts.
>
> J=C3=B6rg, can you confirm that doing these reverts fixes booting on your
> system? If it does then a full dmesg from that kernel would be useful.
>
> FWIW I reviewed the bisected commit and didn't find the bug but I also
> couldn't convince myself it's a 1:1 identity transformation and cleanup
> of the existing logic.
>
> The size arithmethics transformation looks correct at first sight, but
> the data->flags handling in particular looks rather interwoven.

Agreed, but the only flags change that I couldn't convince myself was
correct is this:

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 59f7f6d60cf6..314b36ac2a08 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -309,7 +309,7 @@ static void __init efi_clean_memmap(void)
                        .desc_version =3D efi.memmap.desc_version,
                        .desc_size =3D efi.memmap.desc_size,
                        .size =3D data.desc_size * (efi.memmap.nr_map -
n_removal),
-                       .flags =3D 0,
+                       .flags =3D efi.memmap.flags & EFI_MEMMAP_LATE,
                };

                pr_warn("Removing %d invalid memory map entries.\n", n_remo=
val);

...but efi_clean_memmap() should "early".
