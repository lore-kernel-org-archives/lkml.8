Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98807C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 11:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C28320757
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585479887;
	bh=dUIEOyJONUaR+45S70CouhsPK9huOlt2aN8AWvs42pk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SISe7Y2cfqv4EY64ALxCNYEZdKfqEa4481WCBuxlKGrefYJNTi0pCouHaVuCIQFaj
	 9w2ixQFV6cCqGn0FqTwoDwYKlGP88zx9g8tCxhMWqbw4K2+pUK437uIldpdBwsb753
	 Jyms6ZnyBNZoHQA4vMyfbnrI1a/vnr5uSfypS1qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgC2LEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 07:04:45 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:28448 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgC2LEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 07:04:45 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 02TB4Fl4022592;
        Sun, 29 Mar 2020 20:04:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 02TB4Fl4022592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585479856;
        bh=EU2108wCRxym6ou+uSsn9nTW9F9rhQ/CqadQn7+lTn0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xhfH7CHYqsdYqHY+K2ou0pYdKqtz/s7Yswet3nSTTST4DylHzT9jazYgl060yBj/H
         fCwTbEaFfUnpgq5BLUR5tw7iMoYoqBj4sSf3P7LQxqWVrFLVUqditPZnLrXtOrWBHg
         oPTji28Ko9Yc/Jrik8iRLDhYFpTUEUZj+EIDCsluXhXBv7vRbL/uOFmc3sK6zdFXZe
         X3j95YwMKmpUdYcYQXum+EqOseOJC6CXBKJZsjHNm4G29rl6UE7BvUVsYG53ug9xwP
         89YLfroPUx7pTN9Grg1fuvnLDTxPhzWqu/aP97XhXg7U7v1kMPN5VJdU1lJKZyTmU7
         fUdK7OGKIIDYw==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id e20so3884104vke.9;
        Sun, 29 Mar 2020 04:04:16 -0700 (PDT)
X-Gm-Message-State: AGi0Puaj8kVoJv2HyjBoKtO6yxUPaql/6HP6GhE3fc0baQpTrD8Jwm3f
        c3WOCSZItos3o07jBGX6gmcdsNpZ4BBblvTn6zo=
X-Google-Smtp-Source: APiQypImfB6tagTqcvE4vgOZ5u6yx/ne3N54JbAO22wwBI1pcsS8aliSJz9f7hjsjn6h7riXl4m5AvPEkKA/id8MjPw=
X-Received: by 2002:a1f:1786:: with SMTP id 128mr4298073vkx.26.1585479855039;
 Sun, 29 Mar 2020 04:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200325031433.28223-1-masahiroy@kernel.org> <202003251905.6D43E64@keescook>
In-Reply-To: <202003251905.6D43E64@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 29 Mar 2020 20:03:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATWkXiWtR+=eWxqxewsJjy_nvSmcByCR-ZehO95yN-c+A@mail.gmail.com>
Message-ID: <CAK7LNATWkXiWtR+=eWxqxewsJjy_nvSmcByCR-ZehO95yN-c+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: remove unused variable in qconf.cc
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 11:06 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Mar 25, 2020 at 12:14:31PM +0900, Masahiro Yamada wrote:
> > If this file were compiled with -Wall, the following warning would be
> > reported:
> >
> > scripts/kconfig/qconf.cc:312:6: warning: unused variable =E2=80=98i=E2=
=80=99 [-Wunused-variable]
> >   int i;
> >       ^
> >
> > The commit prepares to turn on -Wall for C++ host programs.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>

Applied to linux-kbuild.



> -Kees
>
> > ---
> >
> >  scripts/kconfig/qconf.cc | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
> > index 82773cc35d35..50a5245d87bb 100644
> > --- a/scripts/kconfig/qconf.cc
> > +++ b/scripts/kconfig/qconf.cc
> > @@ -309,8 +309,6 @@ ConfigList::ConfigList(ConfigView* p, const char *n=
ame)
> >         showName(false), showRange(false), showData(false), mode(single=
Mode), optMode(normalOpt),
> >         rootEntry(0), headerPopup(0)
> >  {
> > -     int i;
> > -
> >       setObjectName(name);
> >       setSortingEnabled(false);
> >       setRootIsDecorated(true);
> > --
> > 2.17.1
> >
>
> --
> Kees Cook



--=20
Best Regards
Masahiro Yamada
