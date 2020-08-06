Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9FFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7BB3221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DyT6FG8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgHFR06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgHFRBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:01:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2568CC00214F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 08:54:06 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l6so45358146qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UsHAX7esgjtVzNUCEqqvqu86wCp66quILvQY7iEL8g=;
        b=DyT6FG8ChV01l/RE876rDNuC6j5DZJjP1C4cM04Su+qQP/+5Fv7Ee/cT/IS1nBx360
         Pv5BJ+oxTlFo/nboo9WeCzc9ezk3F9gAj3slg5OXaDJWKtg8l5CEVDSnTnJ9QvdXVnN6
         CoPWeXdDnTCkJXuSjv/FC7NntuHtLLFNd9taIhYEFs+8Ice71Sv/a4WJ62TJNP+AEcD2
         CCuGrbnxz0ywxNZylEFrKVP5V/KajDbma/cMnWfiLLuInEgosYYRmNviv9apqXpN/QnZ
         7qsJyIt0ydS6C4ytPStPVKjRrHh7ed7LPCduQgkT0aUJKGY2nLeKYN6B703T1+qSmADU
         LRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UsHAX7esgjtVzNUCEqqvqu86wCp66quILvQY7iEL8g=;
        b=pjtNvlsEz4pjOfMIOWGhKGfrWt9NH9eek3ttEPNQkVu6Gr7zEbAJer8qulSsX/4//q
         g0leiyOcR5bxgYJ1b8gbCU221Sm3dkjEGJ2eSZUWnZ/Y1CTxqI9Yt+Hf0G7Iyc3PE1LL
         MMdHYG/YaZkmnT6hFN813AWKNpNYxhRz424JCNN5np/JKkbc/tDcCDrXigqDLDd884du
         Jhy8W1JJfFnWysBmh3z1yrMhlJ72S5lZatb1M3YUomjNbi2QBUV9/pbM5Hrd6o8PYi0l
         hCcP8V1ypLXODltpsCDo+t3nD/viFczTTLO4o7Db1Q/8I5e6FBanurtRwro7EIGMdSKA
         ieug==
X-Gm-Message-State: AOAM5329FtWZUVIiCTiGcEk8MmX42LpuJcWHukA58t95P7d7zVL1rKXa
        Jz5MhXDEyaXDPmQDlGUyK8m2f9Lxid5B6SNwql/qcA==
X-Google-Smtp-Source: ABdhPJzbBj8BOLmvjWfD0JzRDsoVdCv0FKrvWOOJLr1shEyMS3Imf50S97xGa6pPDYHYJAHuGq+9AddRZGrZu80kcLg=
X-Received: by 2002:a37:a495:: with SMTP id n143mr9203612qke.330.1596729244782;
 Thu, 06 Aug 2020 08:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200725041955.9985-1-warthog618@gmail.com> <20200725041955.9985-3-warthog618@gmail.com>
 <CAMpxmJXocdDTvC7_76UwZ9FONn86p0MjZtorRKTR5bxN7PJy6g@mail.gmail.com>
 <20200805051853.GA122005@sol> <20200806011513.GC11890@sol>
In-Reply-To: <20200806011513.GC11890@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 6 Aug 2020 17:53:54 +0200
Message-ID: <CAMpxmJXk42efa5PoK=BuwHeU-9T_886uEXK8AworQ__334aU5Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] gpio: uapi: define uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 3:15 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Wed, Aug 05, 2020 at 01:18:53PM +0800, Kent Gibson wrote:
> > On Tue, Aug 04, 2020 at 07:42:34PM +0200, Bartosz Golaszewski wrote:
> > > On Sat, Jul 25, 2020 at 6:20 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> [snip]
>
> > > > config, info, info_changed and event structs receive updated versions,
> > > > and the first three new ioctls.
> > > >
> > > > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > > > ---
> > >
> > > Hi Kent,
> > >
> > > Thanks a lot for your work on this. Please see comments below.
> > >
> > > One thing I'd change globally for better readability is to have all
> > > new symbols marked as v2 - even if they have no counterparts in v1. I
> > > know libgpiod will wrap it all anyway but I think it's still a good
> > > way to make our work in user-space easier.
> > >
> >
> > Fair enough.  Oh joy.
> >
>
> Given that the intent is to highlight that the symbols are related to the
> v2 of the GPIO uAPI, and not the second version of a particular type, it
> makes more sense to me that the v2 is placed adjacent to the GPIO in the
> name.  e.g. gpioline_flag_v2 would become gpiov2line_flag.
>
> Does that work for you?
>

Yes, except that gpiov2line is a terrible prefix. Perhaps we should
make that into gpiov2_line_flag and same for all others? Maybe even
gpio_v2_line_flag if that doesn't make the symbols too long/too hard
to read.

Bartosz
