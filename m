Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D527C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346A124656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0a9vOzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBSR4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:56:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54240 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSR4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:56:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so1661288wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RnmIkUaXzV1O+1VS/NyDxwCOq2I1yESOXBaHwQRGaf0=;
        b=G0a9vOzj/q7uDeIqggCjkaY5G0W5f/ja02TiSC66hscZOYLFvDhK3JRR2tAEVdaSKc
         ehrXQMN+fczRLpaCaQBJgW9+IHXpd4HvUhoEo27xkVy33Z3X+gzuxYnZKixfyVnToTGD
         yS+knnLIdpwQJ72FxmyyRrg4/8mYoROAm82Cb4k1JmiqbyjfxCQWA96gcl3H4jU2INrv
         l/YpJ2u0XZpqmo8jGUBOtJaIZvebTNZhzfoGcLseEAFQAGgyw013bVvkXU/EzlKNjcTi
         7iL7RaAvVQ0QR2cm/0GMqi/s+8CylnEQTkg4ydOZRYbfo/iRp+5yJ8Rlj9Uvy5QveANO
         qcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RnmIkUaXzV1O+1VS/NyDxwCOq2I1yESOXBaHwQRGaf0=;
        b=hSy+hZgzepmgareXI2lY7MbHHSBhlR2HNqg8fgu5RSLJgUrf2yACW6Vi/G+vqOtFud
         crhiaI+8Q6mJATB5MBqzl9FLn5/BrDe7HcarqZqa2SHzkt6t5yGepO5/P6Rlq6K+WwQV
         tNTpfoypi94PsxsyHxaIZqRdQxqhhG3W29TOBHB1FPbzTaGUlu+p3sDndwQR8AE5kJ/m
         Xwj/LrYZ85IfO3Mc/9KcSepvLX7C3/7rRrSESqapvnkCH6crrKNhnsoUWeG/uq06NnZq
         fqciRFPjkgSM/6ADe83TkaAtHdQ6KdJQ9nFmf2uCc39rjk+yQfUu/gmSlbSrQPN/3p+Q
         0/+g==
X-Gm-Message-State: APjAAAUNHKfZne4bF+AcqH9cO0ewoYDAvLQkcgvH16WSDaCt7y1MYcKJ
        D/HTa37udXLRzQEIoRmyP1LmdBJidAId/4fCup4VKQ==
X-Google-Smtp-Source: APXvYqyumjWbeIRbAAQ3QUDMQpO38pyn00miVAyE08VUKdejWzZ9hUptAO3teis8IB/n5DFxkzZoLzcGAQL54YQ0tPQ=
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr11236052wmj.175.1582135009360;
 Wed, 19 Feb 2020 09:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20200218094815.233387-1-glider@google.com> <202002190916.EFA74B50C@keescook>
In-Reply-To: <202002190916.EFA74B50C@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 19 Feb 2020 18:56:38 +0100
Message-ID: <CAG_fn=X-BeOooHDCKczm+KzWDBp_TY5e2VTnUxiqbHpipoF-sg@mail.gmail.com>
Subject: Re: [PATCH] lib/test_stackinit: move a local outside the switch statement
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 6:36 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Feb 18, 2020 at 10:48:15AM +0100, glider@google.com wrote:
> > Right now CONFIG_INIT_STACK_ALL is unable to initialize locals declared
> > in switch statements, see http://llvm.org/PR44916.
> > Move the variable declaration outside the switch in lib/test_stackinit.=
c
> > to prevent potential test failures until this is sorted out.
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> Er, no. This test is specifically to catch that case. (i.e. the proposed
> GCC version of this feature misses this case too.) We absolutely want
> this test to continue to fail until it's fixed:
>
> [   65.546670] test_stackinit: switch_1_none FAIL (uninit bytes: 8)
> [   65.547478] test_stackinit: switch_2_none FAIL (uninit bytes: 8)
>
> What would be nice is if Clang could at least _warn_ about these
> conditions. GCC does this in the same situation:
>
> fs/fcntl.c: In function =E2=80=98send_sigio_to_task=E2=80=99:
> fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitch-un=
reachable]
>    siginfo_t si;
>              ^~

Is this really a bug from the C Standard point of view?
Initializing the switch-local variable or executing other code after
the switch would indeed be a problem, but isn't it correct to declare
an uninitialized local as long as it's initialized in the branches
that use it?

> I have a patch to fix all the switch statement variables, though:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=
=3Dkspp/gcc-plugin/stackinit&id=3D35ed32e16e13a86370e4b70991db8d5f771ba898

Am I understanding right that these warnings only show up in the
instrumented build?
According to the GCC manual:

   -Wswitch-unreachable does not warn if the statement between the
controlling expression and the first case label is just a declaration

> -Kees
>
> > ---
> >  lib/test_stackinit.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
> > index 2d7d257a430e..41e2a6e0cdaa 100644
> > --- a/lib/test_stackinit.c
> > +++ b/lib/test_stackinit.c
> > @@ -282,9 +282,9 @@ DEFINE_TEST(user, struct test_user, STRUCT, none);
> >   */
> >  static int noinline __leaf_switch_none(int path, bool fill)
> >  {
> > -     switch (path) {
> > -             uint64_t var;
> > +     uint64_t var;
> >
> > +     switch (path) {
> >       case 1:
> >               target_start =3D &var;
> >               target_size =3D sizeof(var);
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
>
> --
> Kees Cook



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
