Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FADC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 05:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C3720661
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 05:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580534209;
	bh=VrIBCannUklO+YGSqcXRs5mHB+euFkfbZKHwVkl6ed0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Qwg8BZhHp+nmMUB2WgPQMCuBEMVhpFeiprFL4UXPa5Mh3oPUEDP4Ao2+PtQ3okO7y
	 ipmS2KCoq3PZ7rr3Jy1kg5xYQB9gBhqbKkCqgJS141Js1Ow0WtB9wK1WCNNJxKFcXH
	 Gi5WWNVgtxy+fhXCMZP7S+TN+s8+tP9P8uHJnI+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgBAFQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 00:16:48 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:26548 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgBAFQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 00:16:48 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0115GSwg014871;
        Sat, 1 Feb 2020 14:16:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0115GSwg014871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580534189;
        bh=EOo269sVB5Uni2uD53XMCBzvrOWKyeudbnpYYN1nMiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ml66T7N9A7y6yKylZyhluyiveOEoNz52By1g85g4qvkSDFxTzFjNb7GFWdEN+9C0j
         rJPnld7g112VEjr/qD2RgcdzPLrSe7O2/dErafv/owgMKyIMzzMa5L3H2afcIDsCzD
         /l0PqNB8USff1oa9Q+UuLHIDdqMyNgoE4qmp8bA969A2WvQVWRaZbNoy6RI5x+28cj
         esBbk0FlM5HfsJA1maOV9B1sKizcmblgmRiy8y1n1w5dfFo7v/XPwnrv613Fh87VoK
         kwzs1CMKopsuPAV2/0powBnGxjA5TYcS7kn6lB8YkrQdhYL3y0QYXJq86wyRNNW35x
         Wb8szQ8NZ8mHA==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id n27so5792846vsa.0;
        Fri, 31 Jan 2020 21:16:29 -0800 (PST)
X-Gm-Message-State: APjAAAVWkLxjmdIVM9T1jSV0AL8CrYU7xAqTXIrnM05DElYg0dmBtdWL
        KU0XRy7X3aE5DKbPcmohJcEUtkAbwwL/iQ1DspA=
X-Google-Smtp-Source: APXvYqzWBNOWLNT7IOC7dssAF7uFRcUhn9ZP9sT1WohMsnJL+AQDdF4pundz9bFCRTrV7s24L6v8dOvZVdygGP9g8W8=
X-Received: by 2002:a05:6102:1174:: with SMTP id k20mr6520889vsg.155.1580534187978;
 Fri, 31 Jan 2020 21:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20200122100344.50751-1-vincenzo.frascino@arm.com> <CAK7LNATxbGWGW19N9H-HAiSY0AL0iFs8D_H0DEKmEfTGTT88iA@mail.gmail.com>
In-Reply-To: <CAK7LNATxbGWGW19N9H-HAiSY0AL0iFs8D_H0DEKmEfTGTT88iA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 1 Feb 2020 14:15:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmVaxdMrJqeNEZ0cNHYXrL06Va7v2hFzEY=j1i=gGCdw@mail.gmail.com>
Message-ID: <CAK7LNATmVaxdMrJqeNEZ0cNHYXrL06Va7v2hFzEY=j1i=gGCdw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Sanitize make randconfig generated .config
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 1, 2020 at 12:12 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi.
>
>
> On Wed, Jan 22, 2020 at 7:03 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> >
> > "make randconfig" calculates the probability of a tristate option (yes,
> > mod, no) based on srand()/rand() and can be fed with a seed.
> > At the last step of randconfig some option are chosen randomly and their
> > tristate set based on similar mechanism.
> > After this passage the resulting .config is not sanitized, hence it
> > might result in an inconsistent set of options being selected.
> >
> > This was noticed on arm64 using KCONFIG_SEED=0x40C5E904. During
> > randomize_choice_values() CONFIG_BIG_ENDIAN is enabled. Since CONFIG_EFI
> > was enabled at a previous step, and depends on !CONFIG_BIG_ENDIAN the
> > resulting .config is inconsistent.
> >
> > Fix the issue making sure that randconfig sanitizes the generated
> > .config as a last step.
> >
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> >  scripts/kconfig/conf.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> > index 1f89bf1558ce..c0fcaa4e9762 100644
> > --- a/scripts/kconfig/conf.c
> > +++ b/scripts/kconfig/conf.c
> > @@ -654,6 +654,11 @@ int main(int ac, char **av)
> >         case randconfig:
> >                 /* Really nothing to do in this loop */
> >                 while (conf_set_all_new_symbols(def_random)) ;
> > +               /*
> > +                * .config at this point might contain
> > +                * incompatible options. Sanitize it.
> > +                */
> > +               sym_clear_all_valid();
>
> Thanks for the report, but clearing
> all the valid flags is a big hammer.
> I do not think it is a proper fix.
>
>
> I checked the code, and I noticed the root cause of
> this bug.
>
> I will send a different patch later.


I think this is a more correct fix-up:
https://patchwork.kernel.org/patch/11360945/


-- 
Best Regards
Masahiro Yamada
