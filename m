Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB582C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7956C20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aZboL+Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGPV6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgGPV6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:58:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3681CC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:58:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m22so5535756pgv.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFUIFCXr3un/HX1xYqaCN4hY8qd5k3HqOlsX9/aIkxY=;
        b=aZboL+LsskojMwhKfws0MypsgvhoeSdNzBTb6nbV7rFUWA1OjhM0tB0bFLqeCYvxcM
         md8ZX1gK2WhbNKLzpoCoUz88zRHNFKOFWNoTsKQ+K/qTFLx/uRzsAMKf9ntuuWDUU1pK
         1N0RuHNnce6o4GYPaOB6Rw/30LvSNgrc7ztS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFUIFCXr3un/HX1xYqaCN4hY8qd5k3HqOlsX9/aIkxY=;
        b=G4jlr9A9/UxPj2bntAgFk3eSy0dlwCaTirEkhW1PYO3dRMjA89dSN5TuIFOZ6fHYEf
         EP8eayOticNHQfKKu8DRMufbTBxC7qAhnd67QTvjNIXTMqAEeqG5dM7mKiBWzMrY+2M1
         udD1enjoCNWNtL82cWT5+O60qfCp7bgI6kPlt5/ywyM8C9jqrdY7L7LD1Q920llZi0iw
         Qz5pq2+NHdWll7L0HoPR6wP+kFbpFdzZidbieOvO3J+tVCKQjAANJ1/EWDzSeQCiWym/
         b9SKfKmtaczx4kSCukhQHcBxE52YWJXED7oDAYksFasqebLVeVCdp8rGn1u6AzDSlj3b
         oFZQ==
X-Gm-Message-State: AOAM533o5pjPsp14bZRcAzkp1VcK3jsdF1jd7bZaALLP8MDPvONhOsw9
        l/RzpmNek2mBHSSkEhxqU0EaK3Z84X8=
X-Google-Smtp-Source: ABdhPJxl1Eu1rdF0kLBdh+x1CqAHyD8/aVY+62VpKPCfoBx1DwJJDO++90eIUBjS3eDY8RRI/CZFGw==
X-Received: by 2002:a63:3c2:: with SMTP id 185mr6172121pgd.46.1594936703403;
        Thu, 16 Jul 2020 14:58:23 -0700 (PDT)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com. [209.85.210.179])
        by smtp.gmail.com with ESMTPSA id g10sm843436pjs.20.2020.07.16.14.58.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 14:58:23 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id j20so4329987pfe.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:58:23 -0700 (PDT)
X-Received: by 2002:a1f:61c2:: with SMTP id v185mr5122193vkb.42.1594936298466;
 Thu, 16 Jul 2020 14:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <1592818308-23001-1-git-send-email-mkshah@codeaurora.org>
 <1592818308-23001-4-git-send-email-mkshah@codeaurora.org> <CACRpkdb-3Tf4s5=Gxjhy62GX=HUYkLOcPKZ6JWaLTQipz-0r6A@mail.gmail.com>
In-Reply-To: <CACRpkdb-3Tf4s5=Gxjhy62GX=HUYkLOcPKZ6JWaLTQipz-0r6A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Jul 2020 14:51:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vpz9k1k0JYW45D4V+a5+YnRmVzOVRXZudYZzjHugJZMw@mail.gmail.com>
Message-ID: <CAD=FV=Vpz9k1k0JYW45D4V+a5+YnRmVzOVRXZudYZzjHugJZMw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] pinctrl: qcom: Use return value from irq_set_wake call
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        =?UTF-8?Q?open_list=3AGPIO_SUBSYSTEM_=3Clinux=2Dgpio=40vger=2Ekernel=2Eorg=3E=2C_Andy_?=
         =?UTF-8?Q?Gross_=3Cagross=40kernel=2Eorg=3E=2C_Thomas_Gleixner_=3Ctglx=40linutronix=2E?=
         =?UTF-8?Q?de=3E=2C_Jason_Cooper_=3Cjason=40lakedaemon=2Enet=3E=2C_Doug_Anderson_=3Cdia?=
         =?UTF-8?Q?nders=40chromium=2Eorg=3E=2C_Rajendra_Nayak_=3Crnayak=40codeaurora=2Eorg=3E=2C?=
         =?UTF-8?Q?_Lina_Iyer_=3Cilina=40codeaurora=2Eorg=3E=2C?= 
        <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 16, 2020 at 6:19 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Jun 22, 2020 at 11:32 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> > msmgpio irqchip is not using return value of irq_set_wake call.
> > Start using it.
> >
> > Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> > Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>
> Is this something that's causing regressions so I should apply it for
> fixes, or is it fine to keep this with the rest of the series for v5.9?

I would let Maulik comment more, but as far as I can tell the function
has been ignoring the return value of irq_set_irq_wake() for much
longer.  Presumably one could logically say:

Fixes: 6aced33f4974 ("pinctrl: msm: drop wake_irqs bitmap")

...though when you get past the commit that Maulik tagged you need a
backport rather than a straight cherry-pick.

That would make me believe that there is no real hurry to land the fix here.


-Doug
