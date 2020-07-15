Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC65C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865F82064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obRDuUAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGORDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgGORDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:03:01 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038D8C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:03:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ls15so3372012pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHGDqDpJQH4YoOfT6AcOSJnWTTovtZLnMGH7dmTa0Ck=;
        b=obRDuUAdaMmGPgvDxY4WMBIgCaUylyDUXQ8rQLlL9e9rgO61u4EuZXp0bo4/7tygXi
         c3snM96+gdf2cigjK+jL9gVfupvnkb0bht0jZny6Zk/XDrFd2w4yEPn4L/045ANV8CNP
         e2q+KpXCKg8K03+nsiDVwNo3vU5g4cz9dhfT0JYS2Ouj0L50bFmEAz88//5CDbgJpDwW
         JrsC3aL2z3XyCAXf0r6cdp3ZHX1T/pUscINoaAy93TxSDVPDk/ISdDdz5pAFStvdQPxG
         T2sxh3ER7U45hQGxKOia2ShlQydm481qPmbDTgpWwtWNULbPIteFbugPPCIzkYLvIw32
         DYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHGDqDpJQH4YoOfT6AcOSJnWTTovtZLnMGH7dmTa0Ck=;
        b=fRNhMwILwAuQLnVuKKaf528JjENdbu3fjRNPFvril5jX4mfOxQZuMM1tcnP3/bzrWm
         HKPpTcIkNv6ihLkGTrvCAG3vgZw/MCPs9DH9EvTTWq5nLG/gCZefYyvaBiUrTbVJvS1O
         rHYb6KIfxQKP8z6CCb54N3TlsqfXRyzde24GT3BI29db5Z0P12gGR24pyPtNC/eG4iXu
         2xBy6nis8ShXbD2S4D9QNYVSYgXStVr0e/V+GNKzWf4b2JiWYEeRJcGZ8kh3b8BouAdt
         E42QJZ+MI1yU85iHZ43Mq5yt5HthJuKc98FNe9m/7thExqMwN1JIRaELqNe4zhyIF7Mz
         6www==
X-Gm-Message-State: AOAM5320HiBJATdRoguVCUA1O4GzCvS9d2+BeXkUa5z9J2Ss2k9HE2Cl
        spsyYWd6n+EzdLD8l2z5qh/TVROXtX3ZBI+N6fmGMw==
X-Google-Smtp-Source: ABdhPJwyGjUpfY+rpN8FySCcoP5Xxs6lC4Ir9qWwMIpCHB+/hlC3QOGjQEtXEPaWQqebmMgg4nthk9jPapMr4ZPmElU=
X-Received: by 2002:a17:90a:d306:: with SMTP id p6mr541629pju.25.1594832580277;
 Wed, 15 Jul 2020 10:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200715142631.GA3721@mritunjay-Lenovo-Yoga-S740-14IIL>
In-Reply-To: <20200715142631.GA3721@mritunjay-Lenovo-Yoga-S740-14IIL>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 15 Jul 2020 10:02:53 -0700
Message-ID: <CAKwvOdnTfOgxroWTOJ3RMf9wt8+CsxYCp_e+T7rfh5Y0_1RrDg@mail.gmail.com>
Subject: Re: [PATCH] Modified Makefile to print -eudyptula in the version string
To:     Mritunjay Sharma <mritunjaysharma394@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 7:26 AM Mritunjay Sharma
<mritunjaysharma394@gmail.com> wrote:
>
> Signed-off-by: Mritunjay Sharma <mritunjaysharma394@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 0b5f8538bde5..d7897ce5ab23 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2,7 +2,7 @@
>  VERSION = 5
>  PATCHLEVEL = 8
>  SUBLEVEL = 0
> -EXTRAVERSION = -rc5
> +EXTRAVERSION = -rc5-eudyptula

oh man, I love the Eudyptula challenge. I remember running through it
not too long ago.  I don't think you're actually supposed to send this
change though.  Anyways, good job, looks like you found the right
reviewers if this is a change we'd actually want to commit.

It's usually expected to have more in the body than just the online
summary and your signoff.  A comment review comment is "-ENOCOMMITMSG"
which I think is its own meme.

>  NAME = Kleptomaniac Octopus
>
>  # *DOCUMENTATION*
> --


-- 
Thanks,
~Nick Desaulniers
