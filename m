Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F1FC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E601820870
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmR2kEdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgGPNnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGPNnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:43:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B1C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:43:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f5so7167579ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSdpqyKC3gU7HK+9E03a7CScexDYHzh+ksCNoWfCR3M=;
        b=TmR2kEdj5feWCpZQI1gaRcvgArGlYmVhzyd6Kco6rwUwfpUgdTwuC1fMYHtRw2vN37
         oCA01u7xVey1DrBlphmj1wpCinrIOKNBmka3GP8PA1HDnaEZdshE+ebwX49GmmCeEGba
         DzW7GagSdce3Cy4ZZuAYD+ZFFFcY4417Kd5dvOCD1n9hEf5FeF5amArqHwQg7wH17U6t
         V/wJCunTcNsUh28lKsN6Vls98terLGCb4+VCx3Yfd0yr+7pyEucXmQVNytKXulDJuuCt
         tzbgu+2jebt9Zsf0Pz/j9R880G3wnh6RotF/IPOuXlR7Df/6wgggk57oP9pC/8O6XEim
         Fdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSdpqyKC3gU7HK+9E03a7CScexDYHzh+ksCNoWfCR3M=;
        b=oxdVwFxYbUR1XYSituinZdIwZ8CCaGsQOE1ni2o6x9uW2knT90iwg7sT7fTgIQ7Tze
         N6uqgdVgTkNTmMshJ77MfRZfJEtJA3dETx5BTHV4IXWVpUjjmyrusvAr9e6KbeIDT4aD
         z0KxT7+WWPYaEI59G6nDqNJF1t86JTL+Pt5SPBljTjV6v2Fl4BhaxfgjKm1p7QW0Xymk
         kolPPgEnm5KytMrfazkI8oX6uar3FKINfKf1EBbbZBom3Zxw4K+OPNg5kWmjTSkZyUI7
         vTWl/UpmSttFF8E2Ifaq9hlOocGB6gwxNoUCkx49EMgDhiFYyZjuGmGrcLYH+7QtT1ha
         k5iA==
X-Gm-Message-State: AOAM530SFWs+BrSGlh6noNmi3agx1SWbktg2rIqv+HOCRyE9xDAUgVid
        3S2Us1pA3iSWp4W4Cdud9lii1H8KLFR2Pcc1OpXRsg==
X-Google-Smtp-Source: ABdhPJyycizJaTyGRQvemP54CC+/u/p6XCLupUUyMz8dqOWA0tbWNpXkKfxzSf0YeMs1AGCqSYJvARH6xLY2qSwy+tE=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr1997049ljc.104.1594906985707;
 Thu, 16 Jul 2020 06:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200714080254.v3.1.Ie0d730120b232a86a4eac1e2909bcbec844d1766@changeid>
In-Reply-To: <20200714080254.v3.1.Ie0d730120b232a86a4eac1e2909bcbec844d1766@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 15:42:54 +0200
Message-ID: <CACRpkdasjuPXuooQj2fk=G097QR4oSSsoA-_d+vaH9aAKMgHeg@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: qcom: Handle broken/missing PDC dual edge
 IRQs on sc7180
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 5:04 PM Douglas Anderson <dianders@chromium.org> wrote:

> Depending on how you look at it, you can either say that:
> a) There is a PDC hardware issue (with the specific IP rev that exists
>    on sc7180) that causes the PDC not to work properly when configured
>    to handle dual edges.
> b) The dual edge feature of the PDC hardware was only added in later
>    HW revisions and thus isn't in all hardware.
>
> Regardless of how you look at it, let's work around the lack of dual
> edge support by only ever letting our parent see requests for single
> edge interrupts on affected hardware.
>
> NOTE: it's possible that a driver requesting a dual edge interrupt
> might get several edges coalesced into a single IRQ.  For instance if
> a line starts low and then goes high and low again, the driver that
> requested the IRQ is not guaranteed to be called twice.  However, it
> is guaranteed that once the driver's interrupt handler starts running
> its first instruction that any new edges coming in will cause the
> interrupt to fire again.  This is relatively commonplace for dual-edge
> gpio interrupts (many gpio controllers require software to emulate
> dual edge with single edge) so client drivers should be setup to
> handle it.
>
> Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> As far as I can tell everything here should work and the limited
> testing I'm able to give it shows that, in fact, I can detect both
> edges.
>
> I specifically left off Reviewed-by and Tested-by tags from v2 becuase
> I felt that the implementation had changed just enough to invalidate
> previous reviews / testing.  Hopefully it's not too much of a hassle
> for folks to re-review and re-test.
>
> Changes in v3:
> - Rate limit the warning.

Tentatively applied this to the fixes branch in the pinctrl tree
so we get some linux-next coverage.

Would be nice to get Bjorn's ACK on it as well!

Yours,
Linus Walleij
