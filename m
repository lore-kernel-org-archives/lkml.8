Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCECC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C57D206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594281592;
	bh=n8KuoxvesWiAIY+opfod/4XWjPg+flAzBwzo6WbZ1nU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bl+NGUER9DFmr5sz6RIoya+igbkt17vYIAy8h+pZKvjRAJiiZujFnMp3B23psvuCZ
	 UoPJWvBV7ydsLyyJn1lrTHkH5rA9kHixgXSPV5NqxPLlm1/Kh1+tDps2CG/T8BMwKY
	 srpWVkmlpLmQZiVybeaesVyibsX0Qv37XJHNLUL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgGIH7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgGIH7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:59:50 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE07C2073A;
        Thu,  9 Jul 2020 07:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594281590;
        bh=n8KuoxvesWiAIY+opfod/4XWjPg+flAzBwzo6WbZ1nU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZtCT+Ofj8X751NtW4t93j95+HisHO+Zg6Cayf2kjUr3HAhz7wQB5t2WMZkwMra5mX
         hOgOPsCmW1ujWjt8/3MKy7jH/DdJ6ZraVCcoovUUOJKhzwSnCmyGXZxlItqdRbnrDw
         +k+UuTbdwNDMJy+TQRgWE/r2k4cA5YSmy9Cfd3WQ=
Received: by mail-lj1-f176.google.com with SMTP id e4so1339982ljn.4;
        Thu, 09 Jul 2020 00:59:49 -0700 (PDT)
X-Gm-Message-State: AOAM532yX1AP50yZLGWv0OeyQff+KQY4i0JgVN88GHwcVpMrI3b8rrtR
        +x5oLrcAEhvt05zAUDcBcIHVwG0R/QqhRZqCJ28=
X-Google-Smtp-Source: ABdhPJyYE8JVjLzbw3nJJvf2cbSZOzBgUbCeBR8sdnHEUjqpORlM6Sa6qf1SVXghITca69v+n3jBtWTcX/1A1ezqC1A=
X-Received: by 2002:a2e:959a:: with SMTP id w26mr4755601ljh.79.1594281588092;
 Thu, 09 Jul 2020 00:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <1594269511-13340-1-git-send-email-guoren@kernel.org> <5c7e9eb0-d811-2e08-87c4-12de9b869b79@ghiti.fr>
In-Reply-To: <5c7e9eb0-d811-2e08-87c4-12de9b869b79@ghiti.fr>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 9 Jul 2020 15:59:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQnE-J25Jr=qmTqoTopOY9+kHh5ULkUOWvN5SmkZPOOAg@mail.gmail.com>
Message-ID: <CAJF2gTQnE-J25Jr=qmTqoTopOY9+kHh5ULkUOWvN5SmkZPOOAg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Enable ELF-ASLR for riscv
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Greentime Hu <green.hu@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 1:32 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Guo,
>
> Le 7/9/20 =C3=A0 12:38 AM, guoren@kernel.org a =C3=A9crit :
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Let riscv enable randomizes the stack, heap and binary images of
> > ELF binaries. Seems it's ok at all after qemu & chip test and
> > there is no founded side effect.
> >
> > So just simply select ARCH_HAS_ELF_RANDOMIZE :)
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Zong Li <zong.li@sifive.com>
> > Cc: Greentime Hu <green.hu@gmail.com>
> > ---
> >   arch/riscv/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 91bfc6c..eed6647 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -20,6 +20,7 @@ config RISCV
> >       select ARCH_HAS_GIGANTIC_PAGE
> >       select ARCH_HAS_MMIOWB
> >       select ARCH_HAS_PTE_SPECIAL
> > +     select ARCH_HAS_ELF_RANDOMIZE
> >       select ARCH_HAS_SET_DIRECT_MAP
> >       select ARCH_HAS_SET_MEMORY
> >       select ARCH_HAS_STRICT_KERNEL_RWX if MMU
> >
>
> Actually it is already the case: ARCH_HAS_ELF_RANDOMIZE is already
> selected by ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.
Oops :P, Thx for correcting, abandon the patch.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
