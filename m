Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14FDC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD43D21927
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJQ2YtKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgDUIBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgDUIBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:01:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:01:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v8so1865421wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CpDSQMfROJPphSIgOn0f7VjYyFPcWHbMaGTnhGUNHHo=;
        b=eJQ2YtKT0bgi2rBjWYTHlaM//Ni77znlwaKBc0Gdb+mjw0sjvK8tOad+XCPCpnMdWw
         nreZtxVfyQGuqlaufeoeZZpM3+qL3pkhmGLeODel33MUmn27uZQAHNdwFXsU6XSNEa1h
         nh+hUFYRbfhuzZnizYxaQ0E1eGzIkiSlCGgR6DgTQKcgfz1om2/Kh4jPyoJxlthdvZcp
         Vl01fe8arYUEadb6Iu/geL/IzF6by4LmaXRc55APxXMxu81qSfNeDMSHL8SvmIcHUB/J
         LOR2hhVjjZXEv/rek8CTCLPkHM+uO2SflSi8sxWLcVUjkD+2s+p67U0fu7suP60Iz4mP
         /KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CpDSQMfROJPphSIgOn0f7VjYyFPcWHbMaGTnhGUNHHo=;
        b=Op64hFg/sajoqJ6YwidXLfwdKVQuwR1hQwVjW2eefAr5q1dly+luUdCHiPzrApOYK/
         5L//a3P26Sm0qfKOJuQL3mlTnmPsujixJDZ5jzSyUVx9rxoWe405PqQy+STmC3Nxrke+
         QZzyfJv9e9QQswo0W87eG6c39lc8wlpO0RIzje51Tn4UHKBPlWDTbYMZBUo1kOh8zzwj
         Qg6mWASOpyjc401edQUtrlgdl5ZT1d3fv/sqnoKxhSZ+zT/h4Kcb8rvmt8x0y/AkE4Ft
         Jr5SkzQvmLVMSMWNQrDEK8Y7DyUr7+Sotw9osRjicJcwupojG9jaP7ZJjYH8uZgbUsro
         xIAw==
X-Gm-Message-State: AGi0Pubcx2AvZUNFKnWTi7rlsk3bEufTm3fdTiZEFD+lngIfyVACXbzz
        /W0wexYHlaL+aHI6knIHHyZ87qasN52O5T7AwSZL4A==
X-Google-Smtp-Source: APiQypIYVUHrkJaLYPdVgqMO7O+zWCVwoNEcQ44UpZhREjgZok0Beqo8CyfbIW75waL4s/x7PdcMQCHVXD977Q2mlZE=
X-Received: by 2002:a1c:6787:: with SMTP id b129mr3690836wmc.165.1587456069926;
 Tue, 21 Apr 2020 01:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200419100848.63472-1-glider@google.com> <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
In-Reply-To: <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 Apr 2020 10:00:58 +0200
Message-ID: <CAG_fn=VSxh1yXa7yCGHwsxvGT3+DGmJkrqDrMcHGPHBCWRrBMA@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in fill_thread_core_info()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:33 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sun, 19 Apr 2020 12:08:48 +0200 glider@google.com wrote:
>
> > KMSAN reported uninitialized data being written to disk when dumping
> > core. As a result, several kilobytes of kmalloc memory may be written t=
o
> > the core file and then read by a non-privileged user.
> >
> > ...
> >
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1733,7 +1733,7 @@ static int fill_thread_core_info(struct elf_threa=
d_core_info *t,
> >                   (!regset->active || regset->active(t->task, regset) >=
 0)) {
> >                       int ret;
> >                       size_t size =3D regset_size(t->task, regset);
> > -                     void *data =3D kmalloc(size, GFP_KERNEL);
> > +                     void *data =3D kzalloc(size, GFP_KERNEL);
> >                       if (unlikely(!data))
> >                               return 0;
> >                       ret =3D regset->get(t->task, regset,
>
> This seems to be a quite easy way of exposing quite a large amount of
> kernel memory contents, so I think I'll add a cc:stable to this patch?

Correct. Sorry, I forgot about this.

The reporter is also happy with the Reported-by: tag, so you can
ignore the note.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
