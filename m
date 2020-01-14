Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AAAC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F5C24676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JrWid8wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgANKPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:15:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35737 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbgANKPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:15:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so11578792qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 02:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vAww8IXRbacm5VnYWGSAdMWNYd81EOzINN0pZmP3twY=;
        b=JrWid8wp2iMoLpTtIpDrviIVbYP/QmY50Eke5TiVbMd0HmvZOBYbIZi6EZp7B8nG9P
         HM6tQsuJu/r74x791WYGXgnH8A/8LULqGHT/q3vXixEvxTcwn58RGc4IsoNmCnibqJ/l
         4mP5zCo1bSHoCOS8CAdch0US6ADtIJEy+T0e3dTfXldWJm2YcvqQ46WO2Twdt+yi+czZ
         t06Smo4K7LgA54/F0ASLVNMf+Rk/jaDZRRhKql8zNPRor1XNu/Rnp+sScichiq6n9SP6
         SmTkx5/YL8a59vhARMANx87W169EJ3ENa4wKJCxVZaO81EzSy3+O0nNvLZYI90X/FdgE
         YR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vAww8IXRbacm5VnYWGSAdMWNYd81EOzINN0pZmP3twY=;
        b=Y1GKJwUFQbW6y/tpg4eQxK3OsYSBUR+ymwaf8VAcQpXDnEk7/T+FY65iXRHgTEOgPB
         EJn0D25VmdrhQSWMhOsHogqkg7TFfBUg03uLhaI+f4Un65JLhhPVOXkC/WME0I0H9MUy
         MNgRInK2UvrZznCIXT6b7aBChC9a7QoF8btnvKhC5GDyOkYvAkqkQk09SKWwJ2zFVb+M
         AYZOUdcKsKnCQ4unxKGo3vSvxUzwCUPEeOIEASHZsMAjiqjpUeRUUwr+5HxipnxI9kXs
         Ye8YwiVTCXi3QeTjEWiou2GSe+/4L3B46WM9GGjJL2gjfpr80xxSUHinKcKLZcIc3Rqs
         ux2A==
X-Gm-Message-State: APjAAAVqmQ7r27Q90lNzm1Q6nBZ5G3vODWx9ykBUXfGD9rT9MOA5/nyK
        NU19KTLRXhSJHwyI8m+SpN5UBbMaawp5Di9f6F+omA==
X-Google-Smtp-Source: APXvYqxUfpkSmdp0pLEpSj6LsMYLo+Bw0o/5va7KDXqh6AZF9C8OLiMQTOK59YPqJAPuyS4wxU5gUfGXlGXKC8kpn/Q=
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr21161287qkk.8.1578996938005;
 Tue, 14 Jan 2020 02:15:38 -0800 (PST)
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
 <CACT4Y+apeR4GJdS3SwNZLAuGeojj0jKvc-s5jA=VBECnRFmunQ@mail.gmail.com>
 <CAKwvOdkh8CV0pgqqHXknv8+gE2ovoKEV_m+qiEmWutmLnra3=g@mail.gmail.com> <CAG_fn=UU0fuws59L8Bp8DEVhH+X6xRaanwuRrzy-HNdrVpqJmg@mail.gmail.com>
In-Reply-To: <CAG_fn=UU0fuws59L8Bp8DEVhH+X6xRaanwuRrzy-HNdrVpqJmg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Jan 2020 11:15:26 +0100
Message-ID: <CACT4Y+ZWvnEVEDQe6c-4WRhdKkS0W=DHcWXe0etONnjjysR2pA@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_kill
To:     Alexander Potapenko <glider@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

The clang instances are back to life (incl smack).

#syz invalid

On Fri, Jan 10, 2020 at 9:37 AM 'Alexander Potapenko' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Thu, Jan 9, 2020 at 6:39 PM 'Nick Desaulniers' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > On Thu, Jan 9, 2020 at 9:23 AM Dmitry Vyukov <dvyukov@google.com> wrote=
:
> > >
> > > On Thu, Jan 9, 2020 at 6:17 PM Nick Desaulniers <ndesaulniers@google.=
com> wrote:
> > > > I disabled loop unrolling and loop unswitching in LLVM when the loo=
p
> > > > contained asm goto in:
> > > > https://github.com/llvm/llvm-project/commit/c4f245b40aad7e8627b37a8=
bf1bdcdbcd541e665
> > > > I have a fix for loop unrolling in:
> > > > https://reviews.llvm.org/D64101
> > > > that I should dust off. I haven't looked into loop unswitching yet.
> > >
> > > c4f245b40aad7e8627b37a8bf1bdcdbcd541e665 is in the range between the
> > > broken compiler and the newer compiler that seems to work, so I would
> > > assume that that commit fixes this.
> > > We will get the final stamp from syzbot hopefully by tomorrow.
> >
> > How often do you refresh the build of Clang in syzbot? Is it manual? I
> > understand the tradeoffs of living on the tip of the spear, but
> > c4f245b40aad7e8627b37a8bf1bdcdbcd541e665 is 6 months old.  So upstream
> > LLVM could be regressing more often, and you wouldn't notice for 1/2 a
> > year or more. :-/
> KMSAN used to be the only user of Clang on syzbot, so I didn't bother too=
 often.
> Now that there are other users, we'll need a better strategy.
> Clang revisions I've been picking previously came from Chromium's
> Clang distributions. This is nice, because Chromium folks usually pick
> a revision that has been extensively tested at Google already, plus
> they make sure Chromium tests also pass.
> They don't roll the compiler often, however (typically once a month or
> two, but this time there were holidays, plus some nasty breakages).
> > --
> > Thanks,
> > ~Nick Desaulniers
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/kasan-dev/CAKwvOdkh8CV0pgqqHXknv8%2BgE2ovoKEV_m%2BqiEmWutmLnra3%3Dg%40m=
ail.gmail.com.
>
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/CAG_fn%3DUU0fuws59L8Bp8DEVhH%2BX6xRaanwuRrzy-HNdrVpqJmg%40mail.=
gmail.com.
