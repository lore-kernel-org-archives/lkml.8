Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8BDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813F9207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qowwlTqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgHJPdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgHJPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:33:00 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52686C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 08:33:00 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b22so9256190oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=6nWnusMx7VYj6npwy9hzfcojaVvhQSF860hcZfXHJuc=;
        b=qowwlTqqtpQPdsz335qPkHLwZzS9RyvI+jUO8qyqEXeBLtzdgIsgEeEXXnELLhyYjb
         wW0H6lF16SqQd8Tm8pk+zOGs6LnLUturnyJEWKv1DG/UEePFiMmGRQuzP47SrHJH/Bkq
         drfi1ID9Q5n7yLiUSlZINF23KXoO0bmaCjKRbPy+LsGXIYGP0bx8WqH5FEh8mZBYI1Rv
         kGSJGEByZPjqcdo8Ar5dkXMEOkKu5VaYP+Q/mAYPLV2JorirraEYuA9yeNUdkk7enxte
         jqXLcHZv/k0yS+XZI3F0UNJjg79XMPe1FarOhbs09bFMGNt0nvcCkmUsRsgFyF2+wGka
         76eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=6nWnusMx7VYj6npwy9hzfcojaVvhQSF860hcZfXHJuc=;
        b=ZDzoJmeaLyxK9gwIAipqpo+KeqMPOMpbu3FDMP1VZIKDFxhn4V8tHHNReEsw4zrxse
         rsljvn2JsDbo2ETa6+bsCKOIq9jHiU1byBndIxhUyBDtBxq4IMVmXE8MkvdsfDLcYkzW
         hUR2tgLN/KoTURDsH82oCrkA6ePAGq8/Hav+N6QbSchDgpAGdjSS7KZQzu6XyinbCI6+
         8hHGtAJ7ifYloRRrszDSWjF0QJU8SOCVpIYT5Gj8MqPukEhKb4XPT0ivEujupkWH0gSv
         Z+NE7XDzYE+CQ91u76GFlCdPWKfhqmU+tjHDRuqEg4EXw1ULXyvNsRRvUKMg4+ht0b/G
         TZRA==
X-Gm-Message-State: AOAM530kgdLJbXnHaWKU8F8aqEsK6Tii7/4p3s7bmbEcGG3aI+N1V4wf
        F01FF9QoYzUFxIjvc1IqhYV0Tq8tJ5zZbe/LLKjwEDH6
X-Google-Smtp-Source: ABdhPJykudFnRHn8ZvPQmKTYzkICVw4yG4j+GsfE5VmUqwavZTQTQF6DSPrwR+SM4FyGx83Nx2QrxVz25F0MrUbUYmI=
X-Received: by 2002:aca:4e92:: with SMTP id c140mr1106251oib.70.1597073579757;
 Mon, 10 Aug 2020 08:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUGO0__SEZ7YvuQzfSdaWfTnCHW=73-3W4X=Vz51wHd+w@mail.gmail.com>
 <CAHk-=wiR+uHUyp3=Nf1aiNjmg0ZekaQJupLRguFNZ=MreuGhfg@mail.gmail.com>
 <CA+icZUXRjrX+1NAZy4As_ficD4aHRAZWHRj5hrE+D6E5zEKXHw@mail.gmail.com> <CAMuHMdU-XugrkfM-9tQLrOJ_E1Of1Zf-DJZeSXJwkhw0Q9YoPA@mail.gmail.com>
In-Reply-To: <CAMuHMdU-XugrkfM-9tQLrOJ_E1Of1Zf-DJZeSXJwkhw0Q9YoPA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 10 Aug 2020 17:32:48 +0200
Message-ID: <CA+icZUVzwPcVbFLaGvLvowAkHU2kwkPhe7QRTYxVAbwvZisuww@mail.gmail.com>
Subject: Re: Linux 5.8-rc6
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 5:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Sedat,
>
> On Tue, Jul 21, 2020 at 10:19 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > You happen to know if I can configure in my ~/.gitconfig to pull
> > linux-git stuff from two repositories - check first git.kernel.org
> > then GitHub.
> >
> > Some days ago GitHub had some maintenance issues and I was not able to pull.
> > Means I trust more the security and integrity concept of git.kernel.org.
> >
> > To pull from GitHub - saved 15-16mins of my life-time - meant
> > 15-16mins go earlier to sleep - as said I started my build 01:02a.m.
> > (German local-time).
>
> Assumed your cloned from kernel.org:
>
>     git remote add github https://github.com/torvalds/linux
>
> After that:
>   1. "git remote update" will fetch data from both origin and github,
>   2. "git merge $(git tag | grep -v rc | sort -n | tail -1)" will
>      merge in the latest release, if you don't have it merged already.
>

Thanks Geert - you saved 15min of my sleeping-/bed-time :-).

- Sedat -
