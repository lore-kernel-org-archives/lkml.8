Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBC2C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA48208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8f1Lpzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgCEEBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:01:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40440 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCEEBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:01:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id 143so4445011ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 20:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9VU+lVbHX0qAw8bXtTYx7XdwXh/+wKdP6K88dg5a7UM=;
        b=m8f1LpzoYDlsqPhFGG0BvlCvNoSoVC6VdZ+wMBtBZ7sIxYiA3QyplOfaFWVZVdoTEi
         iS+0bM+SdOGRNLGNrc+89EpUjiv+4YEv7Ht47ocfGFo9s3WSwwWJ/n9OKEZb1TlYzKek
         ZQJxY4D8/lOfjukIL4HuQZTE1Kv+OQZr0tCcAU8ladJb2WVB0UbMCrruHms/41KyyQiR
         T6PZXM01KDvH9tLYxktX/Pi98Ajf8VKpAhqA6ucQ6ufxa9Y8svUOXon8/reAGeqxKsKl
         uH7LkhJ5KWmwxj02gYMqgweVS/f8j/IcgHs4lFAo6VA8PzsIr6AJ5CDe1ipv7ll2YzDB
         Otkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9VU+lVbHX0qAw8bXtTYx7XdwXh/+wKdP6K88dg5a7UM=;
        b=eG2vQsgte2R4/nL4InZ9wF7qHToOavaCYogVVdquj87Zi5KvXBln5KqHyjyQDVfbTb
         dnhaUtJfoN6I5l8D4r6IB4o6HRgqKboQU6m8BzuLDzgfex80BdsPgz7DiBnRVtHzk+8y
         RLLL5z1zHDtmZhGHQQsyGzMOVIqmfeX6RMRVpYgTV1kCnXLZieRO6lr7e6K4ZM4v29nc
         9FH0Zw0gpVJASKuEI7zE66ocvXbU4pujgPVszbUEIXuS08FDM7l9dUwlP0VJdp97t0Xv
         +l6cFr+h7CYshGhX3PRLok9c5raCc3mQ/9t02XELEXJcy8xwnp832eUWS6Y5YoYoXkPk
         Y8BQ==
X-Gm-Message-State: ANhLgQ3wD4WuctnOiSTg9/ntUnILReHLeoOIX/bjxkp90QhwgEgT0Dto
        Auj0oGv3DdwmqniADrUJ1YsdQbsJFKKRrof01dw=
X-Google-Smtp-Source: ADFU+vtfwukAWL2WWaPv7EjY+eaP00v7NFT4qzt/7yJWqeGIKgBCWO1yg82W0W0UQAr2SSakpTQnbbixPieeNawRqVM=
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr3907216ljl.83.1583380875979;
 Wed, 04 Mar 2020 20:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20200217083223.2011-5-zong.li@sifive.com> <mhng-6a94c49b-419b-4b5a-a11d-dda1fb0aa896@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-6a94c49b-419b-4b5a-a11d-dda1fb0aa896@palmerdabbelt-glaptop1>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 5 Mar 2020 12:01:04 +0800
Message-ID: <CA+ZOyai1rUVttopEOGMjug8fM6YkV3c+WTstxD6YojdwMCmHzw@mail.gmail.com>
Subject: Re: [PATCH 4/8] riscv: move exception table immediately after RO_DATA
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=885=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=888:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 17 Feb 2020 00:32:19 PST (-0800), zong.li@sifive.com wrote:
> > Move EXCEPTION_TABLE immediately after RO_DATA. Make it easy to set the
> > attribution of the sections which should be read-only at a time.
> > Move .sdata to indicate the start of data section with write permission=
.
> > This patch is prepared for STRICT_KERNEL_RWX support.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/kernel/vmlinux.lds.S | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinu=
x.lds.S
> > index 1e0193ded420..4ba8a5397e8b 100644
> > --- a/arch/riscv/kernel/vmlinux.lds.S
> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > @@ -9,6 +9,7 @@
> >  #include <asm/page.h>
> >  #include <asm/cache.h>
> >  #include <asm/thread_info.h>
> > +#include <asm/set_memory.h>
> >
> >  OUTPUT_ARCH(riscv)
> >  ENTRY(_start)
> > @@ -52,12 +53,15 @@ SECTIONS
> >       }
> >
> >       /* Start of data section */
> > -     _sdata =3D .;
> >       RO_DATA(L1_CACHE_BYTES)
> >       .srodata : {
> >               *(.srodata*)
> >       }
> >
> > +     EXCEPTION_TABLE(0x10)
> > +
> > +     _sdata =3D .;
> > +
> >       RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> >       .sdata : {
> >               __global_pointer$ =3D . + 0x800;
> > @@ -69,8 +73,6 @@ SECTIONS
> >
> >       BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> >
> > -     EXCEPTION_TABLE(0x10)
> > -
> >       .rel.dyn : {
> >               *(.rel.dyn*)
> >       }
>
> As far as I can tell this is OK: core_kernel_data() explicitly says that =
RODATA
> may or may not be between _sdata and _edata.  That said, I think we shoul=
d add
> __start_rodata and __end_rodata atomicly with this change (around RO_DATA=
 and
> .srodata).
>

OK, I'll move _sdata back. Actually, here I need a symbol to specify
the start address at writable data (RW_DATA), thus, I could remove the
executable permission of .data section (from this symbol), and make
.rodata, .srodata and __ex_table read-only at a time (from
__start_rodata to this symbol). So even if we use __end_rodata to wrap
.srodata together with .rodata, exception table still be excluded, and
we have no idea where is the .data section start address. Do you think
it would be OK if we use _data to specify the start address at
writable data? If it's OK, whether we still need to add __end_rodata
after .srodata?
