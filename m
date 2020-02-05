Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4887C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95BF217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yhe8w0Wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgBEJmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:42:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35223 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:41:59 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so1597145edv.2;
        Wed, 05 Feb 2020 01:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xyH/6xAva+KFzsDU4kRRSVPMZlagXAYWpnfMiSTYxro=;
        b=Yhe8w0Watz8h/Ktj3n0eudAKT3QTNqepRLvSDHoDy2cneZ9OiHnokr20GSFClaw//G
         fAscjiiXb2BJdQzt+keYZxIW6N1nJgOsvMS+NMWwVSkD/smUKBW2ofUGkZGsVufBoBrJ
         wjRq0bGrMsYtry7DvqOXm2JE8d3YuLkScFjxjA5qOaxphunxEOry4t11FQ4eiz/OcIpm
         CUzJrNiugt0rwn2v1js+O1EncWz3yXN24rAFkUsGX4NxMi6vRNeiahHOSE5aAL4ZdJOo
         /qD/36/6bgX0a1EwSf43Z+orvP7qI9AGfl4VxXqtmdPqHJqPd93EQPt9st6wbxRImhn6
         UTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xyH/6xAva+KFzsDU4kRRSVPMZlagXAYWpnfMiSTYxro=;
        b=esN1PGPRTDV8LiGAlrdwngUYtxX8j75WHqtkNPxNL7xEaSOBv2/Sso/t3MIAqfEHfd
         xuAkotapyx/DLv5CrlkjbRFT72gttV+VBi24Vt0uAA3uN5Q3HMW2bbMcSgoUKhU5ONFA
         WVbS7PWL3FaO4oh0Be4aHyhiG/uLCGhDKI83tpHRtnsNyJiz6Vm2O87kyCN458drJFx/
         XxdumiS18zlmFC/D+WgA84itOnaErQv/TmsXZpgic6QD5EizeMfgbQVVrF9EFwQufOw5
         dOP39A1oRV+Ml1fFAQFRLJ3cPCN+0S7ytj2Sz/AfpIHZuOto3zcW5whfCSdy9jt+eBfV
         2CkQ==
X-Gm-Message-State: APjAAAVapLLBQTRoSAWkaV3qN2rYiHyjls1b8Uh3yDxvXc+Cvf/qJQD+
        8zX/lIDQKysy1SOyYF6wLwXYTkY3a0g2uDxjnvY=
X-Google-Smtp-Source: APXvYqxQlrWAviHpx/RxvSc+x27TSYutaYAi1f+x+iFBmAxTIBgD7uXWaTzjGyGXWLrmJO1DvOz8vfV7FXFYJxtR1Vo=
X-Received: by 2002:a17:906:70f:: with SMTP id y15mr30316411ejb.44.1580895717251;
 Wed, 05 Feb 2020 01:41:57 -0800 (PST)
MIME-Version: 1.0
References: <CADxRZqyB_g3S0OHkNcyDiS8PX-vGwrtH+3Cp-YNJ7SGj3x6bDg@mail.gmail.com>
 <CAD=FV=UYbMMr+obKqCvKpfpsJ-T5n6p9cZZsjFwF4kfTKM0Jqw@mail.gmail.com>
In-Reply-To: <CAD=FV=UYbMMr+obKqCvKpfpsJ-T5n6p9cZZsjFwF4kfTKM0Jqw@mail.gmail.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 5 Feb 2020 12:41:46 +0300
Message-ID: <CADxRZqwxjqo7h_L0v+9n9nuSqrgCMj5uqKf4kZjekEz8=EMgmQ@mail.gmail.com>
Subject: Re: [sparc64] unable to build kernel after bbfceba15f8 / "kdb: Get
 rid of confusing diag msg from "rd" if current task has no regs"
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 1:13 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Feb 4, 2020 at 1:14 PM Anatoly Pugachev <matorola@gmail.com> wrot=
e:
> >
> > Hello!
> >
> > After (bisected) bbfceba15f8d1260c328a254efc2b3f2deae4904 got
> > mainline, i'm unable to build kernel with the following messages:
> >
> > ~/linux-2.6$ make -j olddefconfig; make kernel/debug/kdb/
> > scripts/kconfig/conf  --olddefconfig Kconfig
> > #
> > # No change to .config
> > #
> >   CALL    scripts/atomic/check-atomics.sh
> >   CALL    scripts/checksyscalls.sh
> > <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp=
]
> >   CC      kernel/debug/kdb/kdb_main.o
> > kernel/debug/kdb/kdb_main.c: In function =E2=80=98kdb_rd=E2=80=99:
> > kernel/debug/kdb/kdb_main.c:1857:11: error: =E2=80=98dbg_reg_def=E2=80=
=99 undeclared
> > (first use in this function); did you mean =E2=80=98dbg_reg_def_t=E2=80=
=99?
> >  1857 |   rsize =3D dbg_reg_def[i].size * 2;
> >       |           ^~~~~~~~~~~
> >       |           dbg_reg_def_t
> > kernel/debug/kdb/kdb_main.c:1857:11: note: each undeclared identifier
> > is reported only once for each function it appears in
> > kernel/debug/kdb/kdb_main.c:1868:12: error: implicit declaration of
> > function =E2=80=98dbg_get_reg=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
> >  1868 |    rname =3D dbg_get_reg(i, &reg8, kdb_current_regs);
> >       |            ^~~~~~~~~~~
> > kernel/debug/kdb/kdb_main.c:1868:10: warning: assignment to =E2=80=98ch=
ar *=E2=80=99
> > from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
> > [-Wint-conversion]
> >  1868 |    rname =3D dbg_get_reg(i, &reg8, kdb_current_regs);
> >       |          ^
> > kernel/debug/kdb/kdb_main.c:1874:10: warning: assignment to =E2=80=98ch=
ar *=E2=80=99
> > from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
> > [-Wint-conversion]
> >  1874 |    rname =3D dbg_get_reg(i, &reg16, kdb_current_regs);
> >       |          ^
> > kernel/debug/kdb/kdb_main.c:1880:10: warning: assignment to =E2=80=98ch=
ar *=E2=80=99
> > from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
> > [-Wint-conversion]
> >  1880 |    rname =3D dbg_get_reg(i, &reg32, kdb_current_regs);
> >       |          ^
> > kernel/debug/kdb/kdb_main.c:1886:10: warning: assignment to =E2=80=98ch=
ar *=E2=80=99
> > from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
> > [-Wint-conversion]
> >  1886 |    rname =3D dbg_get_reg(i, &reg64, kdb_current_regs);
> >       |          ^
> > cc1: some warnings being treated as errors
> > make[3]: *** [scripts/Makefile.build:266: kernel/debug/kdb/kdb_main.o] =
Error 1
> > make[2]: *** [scripts/Makefile.build:503: kernel/debug/kdb] Error 2
> > make[1]: *** [scripts/Makefile.build:503: kernel/debug] Error 2
> > make: *** [Makefile:1681: kernel] Error 2
> >
> >
> > reversing bbfceba15f8d with current git master branch - makes kernel
> > compilable again.
> >
> > kernel config attached
>
> Argh.  Sorry about this.  :(  I'm not setup with a sparc compiler, but
> I've simulated your results on arm64 by just commenting out the
> definition of "DBG_MAX_REG_NUM" in "arch/arm64/include/asm/kgdb.h".
> Hopefully:
>
> https://lore.kernel.org/r/20200204141219.1.Ief3f3a7edbbd76165901b14813e90=
381c290786d@changeid
>
> ...will fix you?

Fixes issue for me. Thank you.
