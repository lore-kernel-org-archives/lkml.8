Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8600EC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584E520707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi6HIJLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgAaKfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:35:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34341 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgAaKfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:35:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so4542657lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 02:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MveRBQOXdKomNGy3ncxwiwtQtXmKGPvJ1vI1xTLFd/g=;
        b=Mi6HIJLRLnx7dMMFFFRrhwNk4vdai62+Qrzt8T6nRXdn8ZD8QN+w7l813tQQelDTpT
         P1n0vCEhBH2CrfJvjr0yHnc7MkSlI3jqChh6HyzzGyRUlENCJ+vne900zzSjuRktK+2d
         lIr5og+aA8wH9GBS6D9B0Do2OCnXzwFHw36CIaNLowePiJzOO2BmR2WwKenMP9D10VG+
         7wyGWG5QJ7YNO/X741laQ783D8KbGgI+G/0RNYzu5QVxjY+NC5NQYM162QRc5rG5ZB6p
         F/SCfOGC9Ihb96yg8j0Tj024lHvZGRVsjgQankZ1BXU7L5EdHvPrq9Tw+wPeEvsc9D5k
         7G1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MveRBQOXdKomNGy3ncxwiwtQtXmKGPvJ1vI1xTLFd/g=;
        b=fttSYbdbV8p2M/Z5tpq4/8/me/kPzmh+nh3Blnifz9WRgwgAawqaYMGW3N2ELZ1aQa
         +pXy5EIcfVNGdqnEKLatLYRW2ZpnPUHb9bON75hnsGg7RwIxHk50WNHYRaTFxlDyRdqC
         Q0CPA9PlS6qIaJ0QmpYJAfU3yQPii8PVzWV7SNKgx9xyQkrOpsvNfp6whxTIBUp7t+pl
         ceOvaI/qnVmVXJmFHAzXny9v8WyPTKAXm9mUzRrOzTSJgw8lyevBwdQ0hPFZwymPeLV8
         b0DhX6UmdxAsowOmKhbuYxuHTnok3JI+MzYzLHgNU0B2w1XKZXE/ngfseaS3okSzrLpw
         FrJw==
X-Gm-Message-State: APjAAAXhz7jQdKVoNtlU3tWV6QlINuS714ULME/1LNMP0goCkZQztfdV
        Wx81YyYErMqGELnehqbQarNhjUw73D/UKvHvb3BkZPk=
X-Google-Smtp-Source: APXvYqwyZc4JHXXG+PX4270X2BWzlEFuOY3mtysPMsXb8LDPT4TBR+v2qlHd5dd5zS3Swsk+9OzS2vygzLeAc25+z+c=
X-Received: by 2002:ac2:53b9:: with SMTP id j25mr4988251lfh.140.1580466915838;
 Fri, 31 Jan 2020 02:35:15 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com> <20200131064327.GB130017@gmail.com>
In-Reply-To: <20200131064327.GB130017@gmail.com>
From:   =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date:   Fri, 31 Jan 2020 11:35:04 +0100
Message-ID: <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
Subject: Re: 5.6-### doesn't boot
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr., 31. Jan. 2020 um 07:43 Uhr schrieb Ingo Molnar <mingo@kernel.org>:
>
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Thu, Jan 30, 2020 at 9:32 AM J=C3=B6rg Otte <jrg.otte@gmail.com> wro=
te:
> > >
> > > my notebook doesn't boot with current kernel. Booting stops right aft=
er
> > > displaying "loading initial ramdisk..". No further displays.
> > > Also nothing is wriiten to the logs.
> > >
> > > last known good kernel is : vmlinuz-5.5.0-00849-gb0be0eff1a5a
> > > first known bad kernel is : vmlinuz-5.5.0-01154-gc677124e631d
> >
> > It would be lovely if you can bisect a bit. But my merges in that
> > range are all from Ingo:
> >
> > Ingo Molnar (7):
> >     header cleanup
> >     objtool updates
> >     RCU updates
> >     EFI updates
> >     locking updates
> >     perf updates
> >     scheduler updates
>
> If I had to guess then perhaps the EFI changes look the most dangerous
> ones from these trees - but in principle most of these trees could
> contain a boot crasher/hang bug.
>
> > but not having any messages at all makes it hard to guess where it
> > would be.
>
> To improve debug output:
>
> Removing any 'fbcon' options in /boot/grub/grub.cfg and adding this to
> the boot options might improve the debug output:
>
>   earlyprintk=3Dvga initcall_debug ignore_loglevel debug panic_on_warn
>
> So for example if the relevant kernel boot entry in grub.cfg looks like
> this:
>
>   linux   /vmlinuz-5.3.0-26-generic root=3DUUID=3D1bcxabe3-0b62-4x04-b456=
-47cd90c0e6x4 ro  splash $vt_handoff
>
> Then editing it to the following could in principle produce (much) more
> verbose boot output:
>
>   linux   /vmlinuz-5.3.0-26-generic root=3DUUID=3D1bcxabe3-0b62-4x04-b456=
-47cd90c0e6x4 ro earlyprintk=3Dvga initcall_debug ignore_loglevel debug pan=
ic_on_warn $vt_handoff
>
> If this produces more output than just "loading initial ramdisk..' then a
> photo of the hung screen would be sufficient, no need to transcribe it.
>
> > A few bisect runs would narrow it down a fair amount. Bisecting all the
> > way would be even better, of course,
>
> Agreed!
>
> If compiling full kernels for bisections takes too long (for example
> because the .config is from a distro kernel) then running "make
> localmodconfig" to create a config tailored to the currently active
> modules will cut down significantly on build time.
>
> Also, a warning: if the normal boot log contains spurious warnings then
> the new 'panic_on_warn' option will cause additional trouble on good
> kernels.

It's bisected.
The first bad commit is :
1db91035d01aa8bfa2350c00ccb63d629b4041ad
efi: Add tracking for dynamically allocated memmaps

Unfortunately I can not revert because of compile errors!

In file included from /media/jojo/deftoshiba/kernel/linux/init/main.c:48:
/media/jojo/deftoshiba/kernel/linux/include/linux/efi.h:975:1: error:
version control conflict marker in file
<<<<<<< HEAD
^~~~~~~
/media/jojo/deftoshiba/kernel/linux/include/linux/efi.h:980:1: error:
version control conflict marker in file
=3D=3D=3D=3D=3D=3D=3D
^~~~~~~
/media/jojo/deftoshiba/kernel/linux/include/linux/efi.h:982:1: error:
version control conflict marker in file
>>>>>>> parent of 1db91035d01a... efi: Add tracking for dynamically allocat=
ed memmaps


....
