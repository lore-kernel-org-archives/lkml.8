Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C97BC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541E220725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FykBzbYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgBQIvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:51:42 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39678 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgBQIvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:51:41 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so17582228ioh.6;
        Mon, 17 Feb 2020 00:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHHGohWk9p+/nxk2GPpS7E9E1pqxMJMjyjsNhyVbaiU=;
        b=FykBzbYJMaN5c0YR2MF11eN63iW/0xfMqkMCO+S5HgLkR7Obiw/ot8yvZ0h49GIxZL
         S2+l6ayaFj2+5LRym2fXDwxpcqjaElQsUS/UwVeCnhxxXm8EUvPBt6YOb/PtxvOtG0Ny
         kD0XSHCBlYjcdIV+RbJcHbc6cEEgyGr/F4IZxKK1SNSk0PaWVCtgUP+EUXvPSgFYlTnC
         Zj30ph73zv2TbaGG1B2sygm90a1s0C5lJlJoNhibYSHoPJSkbE0Xi9OGa13S6xfzY87b
         HUOk4REAF/Nrz6QKXPhgktczj9FXPVYlo+bSXu/p3aohZPrYogUJznmim5SX21H6LjMm
         kn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHHGohWk9p+/nxk2GPpS7E9E1pqxMJMjyjsNhyVbaiU=;
        b=ZOkJPxZFKE83ZyGiuRoQPlHaqryz3TIWVKcVqBphPtLIKYF8ubisHoBN+d1qaW9rpC
         g76//XJ8vvHqikkwQxAbMtbDVsts5Ecibp9b9fAXgeSl3xbLZtwD7OPPstS+s/qFDi5P
         I0KoS1sCjPqmqTaj3mDqKZjm+YdCE2cMCqBk/I6UXwtXI9Xs80VrweSBnrFp6zFJyzwy
         DxPEG7ZGPxKO7hxVa2XOT/C6ddnZCH3DPUymJvknsicGEIs3kMLu+5xJsmWKXOvixcKE
         lI/1P/huP99xyMsS+AL3zwfH4lv6OY06i7O8CU9XCdOkFkR4feFtcdpO9noDpaFg5pvr
         XjGA==
X-Gm-Message-State: APjAAAUgY1Cvo5ogopojFesFrduXcnEpRcRWaYRhwzGNkePMK5J1P6ms
        EPFuV5jWVz1XEzlKEB7dq9u4ZSLZwnoHNJKlilA=
X-Google-Smtp-Source: APXvYqy5Ao2fzvMvprdx/tvfqqCXbZoPO8C3N/gOUkzZph4zPWsllY1/gyAqJmaFDd+k4b6XjT7ZZp9Nv1LrIGgjhzQ=
X-Received: by 2002:a5e:aa18:: with SMTP id s24mr10775126ioe.221.1581929499729;
 Mon, 17 Feb 2020 00:51:39 -0800 (PST)
MIME-Version: 1.0
References: <20200216173446.1823-1-linux.amoon@gmail.com> <20200216173446.1823-4-linux.amoon@gmail.com>
 <1jmu9hzlo2.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jmu9hzlo2.fsf@starbuckisacylon.baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 17 Feb 2020 14:21:29 +0530
Message-ID: <CANAwSgRurj6Mfkqq6OfW_ZORCj_UhQN24kx-tj+sUWfuqn_uoQ@mail.gmail.com>
Subject: Re: [PATCHv1 3/3] clk: meson: g12a: set cpu clock divider flags too CLK_IS_CRITICAL
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

Thanks for your review comments.

On Mon, 17 Feb 2020 at 13:32, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Sun 16 Feb 2020 at 18:34, Anand Moon <linux.amoon@gmail.com> wrote:
>
> > Odroid N2 would fail to boot using microSD unless we set
> > cpu freq clk divider flags to CLK_IS_CRITICAL to avoid stalling of
> > cpu when booting, most likely because of PWM module linked to
>
> Where did you see a PWM ?
>
> > the CPU for DVFS is getting disabled in between the late_init call,
>
> between the late_init call and what ?
>
> > so gaiting the clock source shuts down the power to the codes.
>
> what code ?
>
> > Setting clk divider flags to CLK_IS_CRITICAL help resolve the issue.
> >
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >
> > Following Neil's suggestion, I have prepared this patch.
> > https://patchwork.kernel.org/patch/11177441/#22964889
> > ---
> >  drivers/clk/meson/g12a.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> > index d2760a021301..accae3695fe5 100644
> > --- a/drivers/clk/meson/g12a.c
> > +++ b/drivers/clk/meson/g12a.c
> > @@ -283,6 +283,7 @@ static struct clk_fixed_factor g12a_fclk_div2_div = {
> >               .ops = &clk_fixed_factor_ops,
> >               .parent_hws = (const struct clk_hw *[]) { &g12a_fixed_pll.hw },
> >               .num_parents = 1,
> > +             .flags = CLK_IS_CRITICAL,
>
> This makes no sense for because:
> * This clock cannot gate and none of its parents can either. IOW, the
> output of this clock is never disabled.
> * I cannot guess the relation between fdiv2 and the commit description
>
> >       },
> >  };
> >
> > @@ -681,7 +682,7 @@ static struct clk_regmap g12b_cpub_clk = {
> >                       &g12a_sys_pll.hw
> >               },
> >               .num_parents = 2,
> > -             .flags = CLK_SET_RATE_PARENT,
> > +             .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>
> Why not. Neil what do you think of this ?
> If nothing is claiming this clock and enabling it then I suppose it
> could make sense.
>
>
> >       },
> >  };
>

Sorry for the noise, I should not have send this patch in first place.

-Anand
