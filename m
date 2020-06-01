Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4F6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB55206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a09D16ed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgFAIIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgFAIIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:08:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FABCC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 01:08:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so8232801qkn.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xo+bURQspdkz3spd+YvrJ3AePpwv+4Rws7nHo6tOrsk=;
        b=a09D16ed7wF4iKs+pfRyt2aLzVU8iQUs5/r3tC7L81+X75srG2/ZiydaWBgiSmAApS
         nCtivrrnY2V+pCVsPq+WffUnwoioTYb0bMBNTNCkOwNhYmzWNjQHoqeD9WYgTz1o3HCk
         sjDtLVluLp8ZyMaVtgJ1VuQpH4BS2eu4UUHNyqEaMOnMMwHIHGjjA21z1M4JDD+xhHUr
         5Vsd36XufhvZvyYMu3KVi0BbOjgRoe/oqlQGwzprA+tB+tK4AbFQPSrbuc523S367FZG
         9R9TY1GNF1NKm9PM1UzqW1yBnUwJmY1bkqDDD78m1JixwaW+eIC5ZdyjokA1wxj83z7I
         jmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xo+bURQspdkz3spd+YvrJ3AePpwv+4Rws7nHo6tOrsk=;
        b=Qcj70K1bTotXwx+/bp3yuZFzL2P+KBcQixMT7w6TS0kTgaPx0jHwrXK8LV9WaQakiR
         KysmXkCfqzq4ywIwJAdzcmSQfdlaAutPxThTCpcRG5K8G5faIdNKkg+FmAnuSInN9nEt
         Ury7JOAIsA/QnFQCMlye8FLOZWXKzAUxzl+fwpmo/gfU3jcS5lsWkPicQDCXz1/mILL4
         t632uVT8WEQFfZclKNM+tsgkpblbwU6Gl84ZHp+rKwB/a4hihm8CA8rRHryvPHTT4diy
         mi/CZ4r1Afk76M777MZuGuy94RCxH5QnZdwiBOMCLiWcUmac374OQGoeQFIMIDP8jWKx
         91SQ==
X-Gm-Message-State: AOAM531h/QTNJ8ZLnBxGE+h3A393OzmXb1AUfyIdW2MNBYZa/uLv9JPz
        0Atdpsj/Zgp3LEZFdBf4X2Uawd3O7sGgBve1nbYKkQ==
X-Google-Smtp-Source: ABdhPJwUBPUpCNJjsK6CkhcPkiVmvi4DBwCi4KfwXts+eqGcaujTN9x7EZu5sROrV6MiX3+wewnl6WpusWTqDFtOlks=
X-Received: by 2002:a05:620a:158d:: with SMTP id d13mr18767834qkk.327.1590998889902;
 Mon, 01 Jun 2020 01:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <e896db91e3303f64ac401021f848e536e9d42aaa.1590474856.git.greentime.hu@sifive.com>
 <CAJF2gTTdyXybMGPzqKi1Z_ueQkf5XxiZK2X1HrDnZkCaVU1DAg@mail.gmail.com>
In-Reply-To: <CAJF2gTTdyXybMGPzqKi1Z_ueQkf5XxiZK2X1HrDnZkCaVU1DAg@mail.gmail.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 1 Jun 2020 16:07:58 +0800
Message-ID: <CAHCEehKC4g-TS3n_fruWy2c4CG3dQeBU1oVVEAbFe+gBGOeUnA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 07/13] riscv: Add has_vector/riscv_vsize to save
 vector features.
To:     Guo Ren <guoren@kernel.org>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8831=E6=97=A5 =
=E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=888:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Reviewed-by: Guo Ren <guoren@kernel.org>
>
> On Tue, May 26, 2020 at 3:03 PM Greentime Hu <greentime.hu@sifive.com> wr=
ote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This patch is used to detect vector support status of CPU and use
> > riscv_vsize to save the size of all the vector registers. It assumes
> > all harts has the same capabilities in SMP system.
> >
> > [greentime.hu@sifive.com: add support for dynamic vlen]
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >  arch/riscv/kernel/cpufeature.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index c8527d770c98..5a68a926da68 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -16,6 +16,10 @@ unsigned long elf_hwcap __read_mostly;
> >  #ifdef CONFIG_FPU
> >  bool has_fpu __read_mostly;
> >  #endif
> > +#ifdef CONFIG_VECTOR
> > +bool has_vector __read_mostly;
> > +unsigned long riscv_vsize __read_mostly;
> > +#endif
> >
> >  void riscv_fill_hwcap(void)
> >  {
> > @@ -73,4 +77,11 @@ void riscv_fill_hwcap(void)
> >         if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
> >                 has_fpu =3D true;
> >  #endif
> > +
> > +#ifdef CONFIG_VECTOR
> > +       if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> > +               has_vector =3D true;
> > +               riscv_vsize =3D csr_read(CSR_VLENB) * 32;
> No magic number 32.
> eg:
> #define VECTOR_REGS_NUM 32
>

Hi Guo,

Thanks.
I'll replace it with a defined macro or adding comments since it is
used only once.
