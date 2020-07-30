Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6CBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F4B20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9YaxADt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgG3JdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgG3JdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:33:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF77AC061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:33:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s16so12921048ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYxJoTE2jxDp3y/CrFjanvXbnIWCrDFo6s2oL1qbNcI=;
        b=P9YaxADta+fBNrEYnvrbiPji+LRWUB9XBiJqjtD7ZD93Kb0FlpG9YuR69iS2C3Z5lV
         1ZFLzFrSkvurSx8jqhc1e4feHW9TiPRSOA/7B8cPXRYRsCKT8ujvB775EQlXypegUcrq
         IGncOb1i5A6lhvlCAG9YyJSEYsDMGaVvjZIODNmrv5Y7WXp5xPkJ+QJx5q5i6uNjgjeU
         4NgjLxYt67UM3yd6+rYJrzUm8NmwJG56wzD9OjBg+vvwqR+XpraEzM2uNTLiJkRqK0m3
         4t1xREN2mh9CLmzkief4me9CCvHpWGD5YS+T3D/Kv2XcA75cD/jdbgYbUMtnjZ/L1OTV
         VaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYxJoTE2jxDp3y/CrFjanvXbnIWCrDFo6s2oL1qbNcI=;
        b=HDI0jukNO82gPBE6VOHREecUyqG2c1K/ENKuQIn5USYhuqqnfrgYPJ2jARnpsziPb8
         qixqP6360AeJCmA5vIrt6XpKDCIVLYjeNir1RCF0b+t6hHHK1xcw8leZhn9rqsXCd3rF
         SRQZ9r1snvFh9gTE8yOBDJAkvSUO/45KyVR/1bgKDCqJCXq5UznFHzioj5Cazzd8YE3D
         E8h6dBWu0Uov/moHwMl4xaCTSChr26Q1Bu2MKyOFBC0niDLXyDzPimQnwKXFJJscG6I4
         4+5vIH8hwTUcv8N2daMtXxDyQwiRKPtWupmGImVmupK41vzVD1Mo3Vo6p/NDi4U2YwBF
         WdKQ==
X-Gm-Message-State: AOAM533RCYG4xZGanj9UExc3NCU5P3WUq5IkzaobgXE1WdATSHR4IqiT
        TjSb+Op3uQL36BimMhq0Js2KS3srb2++f8k0Kb8ySnZFvhI=
X-Google-Smtp-Source: ABdhPJxBfIdQENZSBmBjHEbEKqlZTEaUjkkdyLRlYLTelpng81AOwjnPntuXe/AhU3ON07S0c3Wp7NHhC3vKEZn7WEE=
X-Received: by 2002:a2e:9d4a:: with SMTP id y10mr1088338ljj.104.1596101592293;
 Thu, 30 Jul 2020 02:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200504091018.GA24897@afzalpc> <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc> <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc> <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc> <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514162535.GP1551@shell.armlinux.org.uk> <CAK8P3a2KR+O5Ua5hsNgzLQV5-V1pat6JH_WM10Es-oUhXO2OgA@mail.gmail.com>
 <20200514234013.GQ1551@shell.armlinux.org.uk> <CAK8P3a1d-9B86uXxkZnDGf7u-2Vf9fCrUgWQ9HGNEcf3--Yg5w@mail.gmail.com>
In-Reply-To: <CAK8P3a1d-9B86uXxkZnDGf7u-2Vf9fCrUgWQ9HGNEcf3--Yg5w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Jul 2020 11:33:01 +0200
Message-ID: <CACRpkdZ0YT7JoBdYHSb1bbZUv_ovjkBg7yx7gHbG5VjEDV8vhQ@mail.gmail.com>
Subject: Re: ARM: static kernel in vmalloc space
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:41 PM Arnd Bergmann <arnd@arndb.de> wrote:

[Russell]
> > There are some aliasing VIPT implementations on ARMv6, but I don't
> > remember how common.
>
> I thought it was only realview-pb and omap2, but it seems there
> are more, at least ast2500 is an important example.
>
> I could not find information about integrator-cp and picoxcell.
(...)
>   integrator CM1136JF-S core module: arm1136r?, 16kb non-aliasing VIPT
> ? integrator CTB36 core tile: arm1136r?, ???

These do exist, the Integrators have pluggable CPU core modules.
What you do is populate the core module slot on the Integrator CP
with a CM1136.

That said, I think I am the only user of the Integrator/CP actual
hardware. And I don't have this core module. So I think it will be
safe to drop support for that specific VIPT implementation by the
token that if a tree falls in the forest and noone
is there to hear it, it does not make a sound.

As for physically existing VIPT 1136/1176 systems the Ambarella
legacy SoCs that are not upstream is the big consumer of these.

Ambarella's main customer is GoPro cameras and similar
products. I have no idea if they ever upgrade kernels on these
things though, I think not, but it would be great if someone knows
them and can ask whether this is a concern for them. (They
should be working with the community IMO, but is one of those
companies that for some reason do not.)

Yours,
Linus Walleij
