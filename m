Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE9C35241
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 04:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBA32071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 04:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579925187;
	bh=76mXnFSu/yea3Wkuv7JMraraP/0MqZCzTPGrLvRmiJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q8OL5upAaggRhfFAtqnZf3Xhdn+Glue4jCMaiB7aKYvXEXaP72pCyjLZ6NaHUtkIF
	 gcx6uYAqbsyY0Cd0pyCyh+SObnOkWnRzrjjfKE/DjGwq5Yqv8o6W4ZOUGssURksN4n
	 ikfOK8V0+Gb66BSYtrW8n0bmhKyl3kT+IKA6mIao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAYEG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 23:06:26 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:38538 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgAYEG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 23:06:26 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 00P465BF018935;
        Sat, 25 Jan 2020 13:06:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 00P465BF018935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579925166;
        bh=eGpcqbmih5kZxicSNdfArIzaE8bVOZLitMYHalTL4mY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vEmC/hDeI8/Q+sreQ5DuFODKkQM1xmVRug5tpjQBRhe9c8vl56TXyrWdTm3HnrXzI
         xmo0HuLx4Vul1yYNf1Nz9XP0mQkKqaGQe/u9DZIXl0hUhV5n+1P7dprsb4Jiyij6CS
         3XK1hoX/KKPRRQCfFxgiyLYnZigjeIlr6Vu8oXs3pwWuMZUryPKLqLY7C7DuQGPFOt
         vYpBS1+y0AIyb5SY73tW6U3vJ7UWZbA+hH20W/zuBJy/3eh3ATlNVsaj84X1Xqmhag
         kxnaG7rKMkSbb5uuuqs7nF8bcKTqy3FIKikHLezTwEkHU+R0l8Iy5E7BsdST/28G0G
         ax+rHs2lTM42g==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id x123so2578635vsc.2;
        Fri, 24 Jan 2020 20:06:05 -0800 (PST)
X-Gm-Message-State: APjAAAX2JGHzanpdtTDqveAOsWTtazz+u4lPuxThp+HQG6amO+VanV76
        RNFGvcaIpgwPaeBghCqOU+vC8mb88ue3yOrBk0s=
X-Google-Smtp-Source: APXvYqwv1fZ5L0C0PFrVlTZlYa0udBGpWqCCKy3BYBt1Q9lg8bK00C+pFTibP53AUjy/8zQ+3MiEWSAWtEzFXTScH/0=
X-Received: by 2002:a05:6102:190:: with SMTP id r16mr4254678vsq.215.1579925164899;
 Fri, 24 Jan 2020 20:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20200115162529.11089-1-masahiroy@kernel.org> <20200115162529.11089-4-masahiroy@kernel.org>
 <cea3ceee6be7c9554f139db6e96c99f2a5b93be2.camel@decadent.org.uk>
In-Reply-To: <cea3ceee6be7c9554f139db6e96c99f2a5b93be2.camel@decadent.org.uk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 25 Jan 2020 13:05:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNATDRakOYQKLjCDkLz=SY3jPG8OSY5KZCvreKC+JfDW0yA@mail.gmail.com>
Message-ID: <CAK7LNATDRakOYQKLjCDkLz=SY3jPG8OSY5KZCvreKC+JfDW0yA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] builddeb: avoid invoking sub-shells where possible
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Riku Voipio <riku.voipio@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Wed, Jan 22, 2020 at 4:21 AM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Thu, 2020-01-16 at 01:25 +0900, Masahiro Yamada wrote:
> > The commands surrounded by ( ... ) is run in a sub-shell, but you do
> > not have to spawn a sub-shell for every single line.
> >
> > Use just one ( ... ) for creating debian/hdrsrcfiles.
> >
> > For tar, use -C option instead.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >  - fix misconversion pointed out by Ben
> >
> >  scripts/package/builddeb | 39 ++++++++++++++++++++++++++-------------
> >  1 file changed, 26 insertions(+), 13 deletions(-)
> >
> > diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> > index 9b92745bf13a..7d7e0abe62b6 100755
> > --- a/scripts/package/builddeb
> > +++ b/scripts/package/builddeb
> > @@ -165,21 +165,34 @@ EOF
> >  done
> >
> >  # Build kernel header package
> > -(cd $srctree; find . arch/$SRCARCH -maxdepth 1 -name Makefile\*) > debian/hdrsrcfiles
> > -(cd $srctree; find include scripts -type f -o -type l) >> debian/hdrsrcfiles
> > -(cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> debian/hdrsrcfiles
> > -(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> debian/hdrsrcfiles
> > -if is_enabled CONFIG_STACK_VALIDATION; then
> > -     echo tools/objtool/objtool >> debian/hdrobjfiles
> > -fi
> > -find arch/$SRCARCH/include Module.symvers include scripts -type f >> debian/hdrobjfiles
> > -if is_enabled CONFIG_GCC_PLUGINS; then
> > -     find scripts/gcc-plugins -name \*.so >> debian/hdrobjfiles
> > -fi
> > +(
> > +     cd $srctree
> > +     find . arch/$SRCARCH -maxdepth 1 -name Makefile\*
> > +     find include scripts -type f -o -type l
> > +     find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform
> > +     find arch/$SRCARCH/include -type f
> [...]
>
> This last command is still wrong as I commented on v1.  I think it
> should be:
>
>         find $(find arch/$SRCARCH -name include -type d) -type f
>
> Ben.


Sorry, I missed your comment in v1.

I will keep the original code here.



-- 
Best Regards
Masahiro Yamada
