Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59F3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04742082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="R9auyalW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgAaSs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:48:56 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42329 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgAaSs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:48:56 -0500
Received: by mail-oi1-f194.google.com with SMTP id j132so8220174oih.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fLcaF8ntvZPal3qbid9CNAGwD4mOTDkCEUjIwpYd2Xo=;
        b=R9auyalWygTfn6g/yWz839IELezhpT2kdQxHXU5NMqxDhPcHX1skUIywXOCVN7LJEi
         Nwo39uLr8IVAmNBzLdBbbsFEOmaiZUHAtLkUQnL8uYUJZlbJrrtPMCbfy4ljGM6WaogP
         Fd6P327IMubILIRZ2ceVA8l2iyrqN99Ly0jqbTpcAK1NduJldMAau03igSZQWtdP+tfI
         i1ZnueCDHg+cviJ0msLi68C/lNxY3H5O3qOZp/9rRzgesDlsbVF5eIoWWmAI9VMltj8K
         vvrigOHxSQ+CPDx606QgEotW83bKPlilM3JggN4mZGrrRHHxnZsgyZr9xgfvs78JG568
         nH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fLcaF8ntvZPal3qbid9CNAGwD4mOTDkCEUjIwpYd2Xo=;
        b=bf6SEMbFA83gNzIV5QI1CfvYXCPPL3dxrIFwzTr6T7YG9tFjxR5WDoNzd0vHK3Sxx7
         tSW9pONBS97F9H+27XnO2AkeuU3ZrttJrnR6UfNndWQd4ULyXSeCL7GBDFBe1KY6RHIt
         QTtGmPw5maaWTlahIzDhUJ6FOqDr3+Y4WO3RbUde8J960ihsjY5Zf1j4Fdxk7m/L/mNq
         A6kM/1gtWnOwOkyEyy6g9qpfzXTQ2r+TfewwBCqT/A5dDNKqXZBTSMIV454hFNaD47Kr
         6fhzht4Jh3b99u3liNgm3js1NWwsJTXs0U84IqdzZbX719GRAqHATBd1sQftjGUlJmFU
         39Ew==
X-Gm-Message-State: APjAAAUN47A9V4dVTJ5aeMRG6+gqvAOXUgooxMi/0iPMfw4Ytv05u6Iv
        pWH2yHHyfnDTrlp0XxBNbXpKo7dT8VuKtPmlYeZ9Xu3L0gU=
X-Google-Smtp-Source: APXvYqw5oOxHa4qbJTSbp8mQDGvtgH12KQrwz6kSdFhnTsySKmDt9m5LmkM5cYmGLHx8m+w2jLsy1hdyyNytbajNiHA=
X-Received: by 2002:a54:4791:: with SMTP id o17mr6940609oic.70.1580496535560;
 Fri, 31 Jan 2020 10:48:55 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com> <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
 <20200131183658.GA71555@gmail.com>
In-Reply-To: <20200131183658.GA71555@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 31 Jan 2020 10:48:44 -0800
Message-ID: <CAPcyv4iYSptWo42p1Lnbr4NWRiWG2sat+f3t8Q0kPeiiXHx3fg@mail.gmail.com>
Subject: Re: EFI boot crash regression (was: Re: 5.6-### doesn't boot)
To:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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

On Fri, Jan 31, 2020 at 10:37 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> (Cc:ed Dan and Ard)
>
> * J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
>
> > Am Fr., 31. Jan. 2020 um 07:43 Uhr schrieb Ingo Molnar <mingo@kernel.or=
g>:
> > >
> > >
> > > * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >
> > > > On Thu, Jan 30, 2020 at 9:32 AM J=C3=B6rg Otte <jrg.otte@gmail.com>=
 wrote:
> > > > >
> > > > > my notebook doesn't boot with current kernel. Booting stops right=
 after
> > > > > displaying "loading initial ramdisk..". No further displays.
> > > > > Also nothing is wriiten to the logs.
> > > > >
> > > > > last known good kernel is : vmlinuz-5.5.0-00849-gb0be0eff1a5a
> > > > > first known bad kernel is : vmlinuz-5.5.0-01154-gc677124e631d
> > > >
> > > > It would be lovely if you can bisect a bit. But my merges in that
> > > > range are all from Ingo:
> > > >
> > > > Ingo Molnar (7):
> > > >     header cleanup
> > > >     objtool updates
> > > >     RCU updates
> > > >     EFI updates
> > > >     locking updates
> > > >     perf updates
> > > >     scheduler updates
> > >
> > > If I had to guess then perhaps the EFI changes look the most dangerou=
s
> > > ones from these trees - but in principle most of these trees could
> > > contain a boot crasher/hang bug.
> > >
> > > > but not having any messages at all makes it hard to guess where it
> > > > would be.
> > >
> > > To improve debug output:
> > >
> > > Removing any 'fbcon' options in /boot/grub/grub.cfg and adding this t=
o
> > > the boot options might improve the debug output:
> > >
> > >   earlyprintk=3Dvga initcall_debug ignore_loglevel debug panic_on_war=
n
> > >
> > > So for example if the relevant kernel boot entry in grub.cfg looks li=
ke
> > > this:
> > >
> > >   linux   /vmlinuz-5.3.0-26-generic root=3DUUID=3D1bcxabe3-0b62-4x04-=
b456-47cd90c0e6x4 ro  splash $vt_handoff
> > >
> > > Then editing it to the following could in principle produce (much) mo=
re
> > > verbose boot output:
> > >
> > >   linux   /vmlinuz-5.3.0-26-generic root=3DUUID=3D1bcxabe3-0b62-4x04-=
b456-47cd90c0e6x4 ro earlyprintk=3Dvga initcall_debug ignore_loglevel debug=
 panic_on_warn $vt_handoff
> > >
> > > If this produces more output than just "loading initial ramdisk..' th=
en a
> > > photo of the hung screen would be sufficient, no need to transcribe i=
t.
> > >
> > > > A few bisect runs would narrow it down a fair amount. Bisecting all=
 the
> > > > way would be even better, of course,
> > >
> > > Agreed!
> > >
> > > If compiling full kernels for bisections takes too long (for example
> > > because the .config is from a distro kernel) then running "make
> > > localmodconfig" to create a config tailored to the currently active
> > > modules will cut down significantly on build time.
> > >
> > > Also, a warning: if the normal boot log contains spurious warnings th=
en
> > > the new 'panic_on_warn' option will cause additional trouble on good
> > > kernels.
> >
> > It's bisected.
> > The first bad commit is :
> > 1db91035d01aa8bfa2350c00ccb63d629b4041ad
> > efi: Add tracking for dynamically allocated memmaps
>
> Thanks a ton, that's very useful!
>
> I've Cc:-ed the EFI gents who are developing this code, maybe they'll
> spot the bug.

I'll take a look. J=C3=B6rg, can you paste a full dmesg from a good boot?
