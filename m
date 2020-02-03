Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143C4C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0802087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YSoFqclO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBCTCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:02:42 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46193 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgBCTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:02:42 -0500
Received: by mail-vs1-f65.google.com with SMTP id t12so9638196vso.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 11:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H92Ceqpm5PG9xicOBj3pwciuaSxJbU1fy1wmWiFsutU=;
        b=YSoFqclOI7dib/E7gGqaXKXp2CnNGDGmj1obojZ3zyFNN+d1a8M5OGDVct9g5m+3Qc
         EVBG+5Oyeo8eOzC0EfMf7EgxD/qD79HxaUgerNMIkAWrzGB9FyIBvFUvs6a8ufMFh0mC
         01nYZLM4yzr5u23teE/ErNPhUeXbQgMLyoAMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H92Ceqpm5PG9xicOBj3pwciuaSxJbU1fy1wmWiFsutU=;
        b=JTCRoy0GS3WykUQ6ChfYcwY6FOZZUzujcj2C/Pf8QqrhjBmjm5s0LYmvY8zEYlPf+C
         IXTawY2MRiC1HYFDX8aaAe6+bSlZ7gVxgdPutvdpLuKSXJlTxVM8pMzzeUzh1vnFFtux
         vbo9lo5bmvuC8cySwC9JQpgWCjTPCSeEc0d79+206K2JjfYngcHqAO67bo7imS0236sh
         jkX2SBFvwkx2sl2yjOoj/f4s0fj+bwb1FRdbimlsW+wStogrreA3HzwwUhcctym03TkQ
         svILT8pUQhQgDew9ndkW0IpO4dZONvTEi5A57GGRPBUBEe94EkxROxX062B4peBGcX5I
         m5tA==
X-Gm-Message-State: APjAAAWP9BV4fwDahC12zNIg/rbzW0HqplijapzllchWYyqK+YO52T+i
        xOeLoT0BTzU7j80aR5o6MrKz5cSLNVY=
X-Google-Smtp-Source: APXvYqzOCLEY5867eOHecB5zAEebQZYACsIKjjQRbQsHgtoaumN60I1CpKkhP9GFw3kY0nztxMkpVg==
X-Received: by 2002:a05:6102:3235:: with SMTP id x21mr14977140vsf.8.1580756558476;
        Mon, 03 Feb 2020 11:02:38 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id l125sm2882854vke.24.2020.02.03.11.02.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 11:02:37 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id g15so9693432vsf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 11:02:37 -0800 (PST)
X-Received: by 2002:a67:fa1a:: with SMTP id i26mr15830765vsq.169.1580756556608;
 Mon, 03 Feb 2020 11:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20200121183748.68662-1-swboyd@chromium.org> <CACRpkdbgfNuJCgOWMBGwf1FoF+9cpQACnGH7Uon5Y6X+kN+x_w@mail.gmail.com>
 <5e29f186.1c69fb81.61d8.83b9@mx.google.com>
In-Reply-To: <5e29f186.1c69fb81.61d8.83b9@mx.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Feb 2020 11:02:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W=NjMf5UqpSaY-VZfE013Ut=qe2EgSY2UErXM3eqpsGQ@mail.gmail.com>
Message-ID: <CAD=FV=W=NjMf5UqpSaY-VZfE013Ut=qe2EgSY2UErXM3eqpsGQ@mail.gmail.com>
Subject: Re: [PATCH] spmi: pmic-arb: Set lockdep class for hierarchical irq domains
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>, Douglas Anderson
        <dianders@chromium.org>, Brian Masney <masneyb@onstation.org>, Lina Iyer
        <ilina@codeaurora.org>, Maulik Shah <mkshah@codeaurora.org>, Bjorn
        Andersson" <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 23, 2020 at 11:18 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Linus Walleij (2020-01-23 07:29:31)
> > On Tue, Jan 21, 2020 at 7:37 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >   kobj_attr_store+0x14/0x24
> > >   sysfs_kf_write+0x4c/0x64
> > >   kernfs_fop_write+0x15c/0x1fc
> > >   __vfs_write+0x54/0x18c
> > >   vfs_write+0xe4/0x1a4
> > >   ksys_write+0x7c/0xe4
> > >   __arm64_sys_write+0x20/0x2c
> > >   el0_svc_common+0xa8/0x160
> > >   el0_svc_handler+0x7c/0x98
> > >   el0_svc+0x8/0xc
> > >
> > > Set a lockdep class when we map the irq so that irq_set_wake() doesn't
> > > warn about a lockdep bug that doesn't exist.
> > >
> > > Fixes: 12a9eeaebba3 ("spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical IRQ chips")
> > > Cc: Douglas Anderson <dianders@chromium.org>
> > > Cc: Brian Masney <masneyb@onstation.org>
> > > Cc: Lina Iyer <ilina@codeaurora.org>
> > > Cc: Maulik Shah <mkshah@codeaurora.org>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >
> > LGTM
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks. I was hoping you would apply it given that the commit it's
> fixing was applied by you. I can send it to Gregkh or have some qcom
> person pick it up though if you prefer.

It appears that the commit this is Fixing is now in Linus's tree but
Stephen's fix is still nowhere to be found.  Any update on what the
plan is?

Thanks!

-Doug
