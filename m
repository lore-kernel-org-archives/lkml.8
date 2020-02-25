Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E07C4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DC020732
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBECvMi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgBYWqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:46:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45752 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBYWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:46:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id r77so259329pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MIqEZR3STz4QmJr+fA8HRU8cSaP8JPrg45nVIamGD0w=;
        b=gBECvMi7LHmxCEXE4SlEiKIpMkovh72MZMxjWYJzsDNBuxk7ho0+Wof+H2bOJqtXS7
         rUCWlKnKNGbWHQza9F05epdVS1Rdwh0pk03rGO+AJnno5ul+MTbPjK9L+oJb3OhW6hfC
         84Lupv2kd2qDNzvwLPNxAltuBFabP1Dktlyf8Cgp9b8OnFlgn3uPyYI8815zJIuhdhAz
         n8MhfVeFTXr9HScaQx/56l2tsfGKRjNlQ/js/vH0krXT3/p1QMpJaV8NLDlyeFfbv8Yf
         Ey9hZCmxEHjGglNbV/XRFfwQVHA2+v1ZxJquLPR/9y5GIpo63W3mYrPKl1WfLs8DGrum
         +8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MIqEZR3STz4QmJr+fA8HRU8cSaP8JPrg45nVIamGD0w=;
        b=QufA0eGrgpLlruNRZUowOmPtopg4VFk0cdpQF8B2T4T4SJQbP7lvfjYou5RfhNtEqr
         g63QHHzIFCk6GzN1DJqSt+C7fu8uen4T136UzIeFfadDpobchRB1W41cslqj6ZJurcnD
         If80gG3k/XH4IC9tnnS9Gmvs+W8cvT5xjNKmjk5GSw246gi3xFNQdH0SPH/TJZEkH0uB
         uVUI6v87/HnFOe0GbNwvM2saYmc4wQtie15RyC+ik2kqOgYGOA7t/6+ftUwMs2gW1r0+
         skwftYHB/EBrNdmtAbq05qDXyuHaUt/Wb6qOj/2BymzzjY/hHccQ969QYj91mj28pZaQ
         JO/A==
X-Gm-Message-State: APjAAAVtIuyQGU7xSJmvOSfzKezj2zJuOpDkCOe6ES+z4tzy3tPJDoxJ
        oerfm3aztoKrsSZPSR1KT8l8ldOUKVfWJu25wb12QQ==
X-Google-Smtp-Source: APXvYqwHTLpFzklEVgvmhFd6xmy3Duncd4nkGPcODLzjvt//m/hCcXy9QQ9L0gxJZfEvCTquEvEHvkK9xDmmkXahrxg=
X-Received: by 2002:a62:1615:: with SMTP id 21mr1010975pfw.84.1582670794833;
 Tue, 25 Feb 2020 14:46:34 -0800 (PST)
MIME-Version: 1.0
References: <8bb16ac4b15a7e28a8e819ef9aae20bfc3f75fbc.1582266841.git.stefan@agner.ch>
 <CAKwvOdmV80xgvBnhB6ZpqYaqkxKi-_p+StnMojwNnf3kdxTT1A@mail.gmail.com>
 <CAKv+Gu881ZSwvuACmsbBnpfdeJpNYsEQxLSoepJBbZ=O6D6Rcg@mail.gmail.com> <CAKwvOd=9WaeVjvgkkLf5scFaNTpx28d4FAse62vv4X_mEwqRJA@mail.gmail.com>
In-Reply-To: <CAKwvOd=9WaeVjvgkkLf5scFaNTpx28d4FAse62vv4X_mEwqRJA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Feb 2020 14:46:22 -0800
Message-ID: <CAKwvOdk-R7gYXr6PScgZcvHbCBF3TX+utMix44kZCo=qe1vZ2Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: use assembly mnemonics for VFP register access
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jian Cai <jiancai@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Manoj Gupta <manojgupta@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Smith <Peter.Smith@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:27 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Feb 25, 2020 at 11:33 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 25 Feb 2020 at 20:10, Nick Desaulniers <ndesaulniers@google.com=
> wrote:
> > > Ah, this is only when streaming to assembly. Looks like they have the
> > > same encoding, and produce the same disassembly. (Godbolt emits
> > > assembly by default, and has the option to compile, then disassemble)=
.
> > > If I take my case from godbolt above:
> > >
> > > =E2=9E=9C  /tmp arm-linux-gnueabihf-gcc -O2 -c x.c
> > > =E2=9E=9C  /tmp llvm-objdump -dr x.o
> > >
> > > x.o: file format elf32-arm-little
> > >
> > >
> > > Disassembly of section .text:
> > >
> > > 00000000 bar:
> > >        0: f1 ee 10 0a                  vmrs r0, fpscr
> > >        4: 70 47                        bx lr
> > >        6: 00 bf                        nop
> > >
> > > 00000008 baz:
> > >        8: f1 ee 10 0a                  vmrs r0, fpscr
> > >        c: 70 47                        bx lr
> > >        e: 00 bf                        nop
> > >
> > > So indeed a similar encoding exists for the two different assembler
> > > instructions.
> >
> > Does that hold for ARM (A32) instructions as well?
>
> TIL -mthumb is the default for arm-linux-gnueabihf-gcc -O2.
>
> =E2=9E=9C  /tmp arm-linux-gnueabihf-gcc -O2 -c x.c -marm
> =E2=9E=9C  /tmp llvm-objdump -dr x.o
>
> x.o: file format elf32-arm-little
>
>
> Disassembly of section .text:
>
> 00000000 bar:
>        0: 10 0a f1 ee                  vmrs r0, fpscr
>        4: 1e ff 2f e1                  bx lr
>
> 00000008 baz:
>        8: 10 0a f1 ee                  vmrs r0, fpscr
>        c: 1e ff 2f e1                  bx lr
>
> ^ Just to show the matching encoding.

Further, Peter just sent me this response off thread, which I thought
I'd share. Thanks Peter.  Bookmarked.
```
FWIW the Arm ARM reference manual
https://static.docs.arm.com/ddi0487/ea/DDI0487E_a_armv8_arm.pdf has a
table that maps the pre-UAL syntax to the UAL syntax.

K6.1.2 Pre-UAL instruction syntax for the A32 floating-point instructions
This has an entry mapping pre-UAL (FMRX) to UAL (VMSR)

So they are the same instruction with the modern name being VMSR. If
it is possible to use the new name it will probably confuse fewer
people, but other than that it won't do any harm.
```
--=20
Thanks,
~Nick Desaulniers
