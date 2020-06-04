Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88181C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 01:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D28D20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591232903;
	bh=9F8xSey40KLIeBf4ebRlWdcOose6FvNWuocvkvhZ4Ac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vlYVZdgRrLOc3KqAixOPlvdLOuAyoo2sM00wpUxYtXGH8qtqNFOgAeJvbtPuYROni
	 5++STDJNKLkg1R2aC2tvwCI43EdA/n6D39Xklw60AGKul/DnInA9fG3cYQqde4jCqV
	 WekWQOrKM6OIDf7pJseJEnUJZ+OBzEIsjQzEbPEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFDBIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 21:08:21 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:54085 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFDBIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 21:08:21 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 054186RS030408
        for <linux-kernel@vger.kernel.org>; Thu, 4 Jun 2020 10:08:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 054186RS030408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591232887;
        bh=bLUoWeC/HMd6TVBBN77lrqngZcxjikvtaTQJilz/QFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WtseokXhFXXu8TyT8OuDqEUkqDYWnfpDAq+COVc2ZdBKQCgupNWzIiKQAhvtoOEMJ
         D9t9gt/umx/QcxacEKWaZmApRhIQoaN8OKn0JOWUJSr/qzATp6xDYVgWmM0U+6uT55
         i1vVqEFYyempxyWx0VzjqsC1EFZXn/wGyfGH6GJNoy5OyVWeov0gorZ+PbAJXjAeRp
         WarDS6YsMJDLLY/fCBWqI4Krohq4dns/8wcUT0otW9h6zPePqJP5JDFhoyeT8ahbX4
         tmOW/DuQlzK8ON5TjUsmSXcWl1Lr495tGkPo8e8nWm/IY0p0aSpRSbWACLPgQ/yrw9
         gerLGWS8A2zBw==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id a10so1503620uan.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 18:08:07 -0700 (PDT)
X-Gm-Message-State: AOAM532kXrTYiOcYSzFnzmJJFsDF1qc9DdztOohdH6enzLYc/DsylDol
        2YnEcNjFQX85h5l3o/InOnkYQhiYjESryjbqndM=
X-Google-Smtp-Source: ABdhPJwL52eDyBlsSWmyh7Ni+YlmWRChhtwNIoHZW7rX98LM96u/HYGIlFojpLHp9kglMPzrki+pmQXcqg5OY7a32WU=
X-Received: by 2002:ab0:3ae:: with SMTP id 43mr2050774uau.25.1591232885980;
 Wed, 03 Jun 2020 18:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <4627b565-0a5c-080e-726a-01b773c985e8@landley.net>
 <20200603170357.GG1079@brightrain.aerifal.cx> <CAK8P3a2QYkZ9StDssxeZ3_zR5OH_P3v-D1iZp7=1E+2EaqoNcQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2QYkZ9StDssxeZ3_zR5OH_P3v-D1iZp7=1E+2EaqoNcQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 4 Jun 2020 10:07:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNATDg=5U=GjwN9+gfW+kxJ3gN25wGrr7odiqsf7HBsb73w@mail.gmail.com>
Message-ID: <CAK7LNATDg=5U=GjwN9+gfW+kxJ3gN25wGrr7odiqsf7HBsb73w@mail.gmail.com>
Subject: Re: headers_install builds break on a lot of targets?
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rich Felker <dalias@libc.org>, Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 2:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jun 3, 2020 at 7:04 PM Rich Felker <dalias@libc.org> wrote:
> > On Wed, Jun 03, 2020 at 08:49:54AM -0500, Rob Landley wrote:
> > >     make ARCH=3D$i distclean defconfig headers_install \
> > >
> > > On the bright side, the resulting fruitbasket.tar.xz is 1.5 megabytes=
. The
> > > downside is I have no idea how broken the resulting header files are =
after this
> > > error-fest:
> > >
> > > alpha
> > > arc
> > > gcc: error: unrecognized command line option =E2=80=98-mmedium-calls=
=E2=80=99
> > > gcc: error: unrecognized command line option =E2=80=98-mno-sdata=E2=
=80=99; did you mean
> > > =E2=80=98-fno-stats=E2=80=99?
> > > gcc: error: unrecognized command line option =E2=80=98-mmedium-calls=
=E2=80=99
> > > gcc: error: unrecognized command line option =E2=80=98-mno-sdata=E2=
=80=99; did you mean
> > > =E2=80=98-fno-stats=E2=80=99?
> > > [...]
> >
> > Uhg. Surely there should be some fix for whatever mistaken dep is
> > behind this? Headers shouldn't actually depend on any config/compiler
> > output, should they??
>
> The first one of the two comes from "make defconfig", which definitely ne=
eds
> a working $TARGET compiler, but isn't actually needed before
> "make headers_install" as I just checked.
>
> > Or is that machinery somehow involved in
> > generating the syscall lists and similar?
>
> The syscall list for ARC is still not generated (that's on my todo list),=
 but
> something does call it even for "make headers_install".
>
> What it does is to set Makefile variables such as
>
> CC_VERSION_TEXT =3D $(shell $(CC) --version 2>/dev/null | head -n 1)
> and trying out all kinds of gcc options that may or may not be supported
> such as  "$(call cc-option,-fno-tree-loop-im)".
>
> Setting CC=3D: avoids this, like
>
> make -s CC=3D: ARCH=3D$i headers_install  INSTALL_HDR_PATH=3D"$PWD/fruitb=
asket/$i"
>
>       Arnd



You can do headers_install without the .config file.
'make defconfig' is unneeded.

headers_install should be independent of $(CC) too.


linux-next has some progress about this.

You can get clean headers_install without CROSS_COMPILE
for parisc, h8300, hexagon.


You still get warnings for ia64 and arc.
Our goal is to not require $(CC) for non-dot-config target
like 'make headers_install', 'make help', etc.


--
Best Regards
Masahiro Yamada
