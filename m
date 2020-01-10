Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337DAC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EF7206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJ2dpBuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgAJIhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:37:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33751 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgAJIhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:37:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so962018wrq.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 00:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=om0mw7hfO7KryyMGfpDve61XxX/EYx11Q6dBG1khPIU=;
        b=bJ2dpBuSHYnknzc0T+JLyxjJmeadddN3AAE2kgXIM5C04D31O3nmLcv24vXeZUOYwC
         mfWitDMuvWQ5Fl4JSi2z2bVlk0jA/NjLVLFbFu84pOXLl750fZ22Ua9c7ThxvblGBmeK
         N0XJ2GtD9qgtr81xMkcWFPgJLpx7HhFObl0QC5sTOifqWW2DH8+YmQOYpzRaGUVXgk6w
         WlFIp4KgxWCAQtvvsUvubMiAKOc7TkbZS5ZoiMXnCNTQ1vDFvZ/D6wY9wABsbDYg2MAU
         OTg+ZxNvJM+bLO/OJ/quDVUcgI85Dl7n4seHoo1GqGhpgw7iOvvd+6gU90iioSU+gXLW
         PjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=om0mw7hfO7KryyMGfpDve61XxX/EYx11Q6dBG1khPIU=;
        b=QsQADyk/x6CaE/ZzwQZTcJ1gxkZrTop1qvIN9jrGdJ4NeqpsFwV9jhHTJTkJkltKoo
         LrTwJpEagLSUghBOvRsDdxisxJfSSP1ZtJwkn7FH0RN3Gf0yLMO2NtVYsveO0GJ+0+Ec
         eoiu0rQGr3hpa8h3jbZxbj0CriP1kVXJlbk6kZ+BlzTU5G+iYYLW5XHjTU2FrBjR5M9M
         Y+EVzayn1zQ7aRPRevha66/FOKxP3UhHkK1tnacGs6YEyBPWWeq4y70qj7OcjnRbqx2h
         ozVhHwYtfsof8CWwq9uQ6bYd9MO+AmDgiXtp3Idl3RKQ0UN8lLZvHaDFGDu3REdtCDGT
         t7eA==
X-Gm-Message-State: APjAAAWU0bzA6cdos1j7I0ORtWoAvRHYbKyncW+WBILFGJ4BmrmS0tUa
        DItppeVsZXTPQp2jCXBE3LhaSzed7Xl5zqwJTTgThg==
X-Google-Smtp-Source: APXvYqz0tkFtjoXlG3Im4ybeMMQZbxckh42jXI6PVjhAMgfqcZDIZZGifsW9JtttdEFJ0DyuMFDSZPNIKPpt5GYlkOM=
X-Received: by 2002:adf:ef03:: with SMTP id e3mr2216681wro.216.1578645438209;
 Fri, 10 Jan 2020 00:37:18 -0800 (PST)
MIME-Version: 1.0
References: <00000000000036decf0598c8762e@google.com> <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
 <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
 <f7758e0a-a157-56a2-287e-3d4452d72e00@schaufler-ca.com> <87a787ekd0.fsf@dja-thinkpad.axtens.net>
 <87h81zax74.fsf@dja-thinkpad.axtens.net> <CACT4Y+b+Vx1FeCmhMAYq-g3ObHdMPOsWxouyXXUr7S5OjNiVGQ@mail.gmail.com>
 <0b60c93e-a967-ecac-07e7-67aea1a0208e@I-love.SAKURA.ne.jp>
 <6d009462-74d9-96e9-ab3f-396842a58011@schaufler-ca.com> <CACT4Y+bURugCpLm5TG37-7voFEeEoXo_Gb=3sy75_RELZotXHw@mail.gmail.com>
 <CACT4Y+avizeUd=nY2w1B_LbEC1cP5prBfpnANYaxhgS_fcL6ag@mail.gmail.com>
 <CACT4Y+Z3GCncV3G1=36NmDRX_XOZsdoRJ3UshZoornbSRSN28w@mail.gmail.com>
 <CACT4Y+ZyVi=ow+VXA9PaWEVE8qKj8_AKzeFsNdsmiSR9iL3FOw@mail.gmail.com>
 <CACT4Y+axj5M4p=mZkFb1MyBw0MK1c6nWb-fKQcYSnYB8n1Cb8Q@mail.gmail.com>
 <CAG_fn=XddhnhqwFfzavcNJSYVprapH560okDL+mYmJ4OWGxWLA@mail.gmail.com>
 <CAKwvOdmYM+sfn3pNOxZm51K40MjyniEmBvwQJVxshq=FMaW_=Q@mail.gmail.com>
 <CACT4Y+apeR4GJdS3SwNZLAuGeojj0jKvc-s5jA=VBECnRFmunQ@mail.gmail.com> <CAKwvOdkh8CV0pgqqHXknv8+gE2ovoKEV_m+qiEmWutmLnra3=g@mail.gmail.com>
In-Reply-To: <CAKwvOdkh8CV0pgqqHXknv8+gE2ovoKEV_m+qiEmWutmLnra3=g@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 10 Jan 2020 09:37:06 +0100
Message-ID: <CAG_fn=UU0fuws59L8Bp8DEVhH+X6xRaanwuRrzy-HNdrVpqJmg@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_kill
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Axtens <dja@axtens.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 6:39 PM 'Nick Desaulniers' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Thu, Jan 9, 2020 at 9:23 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Jan 9, 2020 at 6:17 PM Nick Desaulniers <ndesaulniers@google.co=
m> wrote:
> > > I disabled loop unrolling and loop unswitching in LLVM when the loop
> > > contained asm goto in:
> > > https://github.com/llvm/llvm-project/commit/c4f245b40aad7e8627b37a8bf=
1bdcdbcd541e665
> > > I have a fix for loop unrolling in:
> > > https://reviews.llvm.org/D64101
> > > that I should dust off. I haven't looked into loop unswitching yet.
> >
> > c4f245b40aad7e8627b37a8bf1bdcdbcd541e665 is in the range between the
> > broken compiler and the newer compiler that seems to work, so I would
> > assume that that commit fixes this.
> > We will get the final stamp from syzbot hopefully by tomorrow.
>
> How often do you refresh the build of Clang in syzbot? Is it manual? I
> understand the tradeoffs of living on the tip of the spear, but
> c4f245b40aad7e8627b37a8bf1bdcdbcd541e665 is 6 months old.  So upstream
> LLVM could be regressing more often, and you wouldn't notice for 1/2 a
> year or more. :-/
KMSAN used to be the only user of Clang on syzbot, so I didn't bother too o=
ften.
Now that there are other users, we'll need a better strategy.
Clang revisions I've been picking previously came from Chromium's
Clang distributions. This is nice, because Chromium folks usually pick
a revision that has been extensively tested at Google already, plus
they make sure Chromium tests also pass.
They don't roll the compiler often, however (typically once a month or
two, but this time there were holidays, plus some nasty breakages).
> --
> Thanks,
> ~Nick Desaulniers
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/CAKwvOdkh8CV0pgqqHXknv8%2BgE2ovoKEV_m%2BqiEmWutmLnra3%3Dg%40mai=
l.gmail.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
