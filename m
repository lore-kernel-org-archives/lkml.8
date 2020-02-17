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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A19C33FA2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918172070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McIHR4Hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgBQNaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:30:16 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41720 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgBQNaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:30:16 -0500
Received: by mail-il1-f193.google.com with SMTP id f10so14217437ils.8;
        Mon, 17 Feb 2020 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKZige4m/AoNTTthLZdSUaeHyHzQ4UT6ng0N8s0kzVk=;
        b=McIHR4HqYVgFbC6brytrdSkaOQ3tJKrEhWb45DEuUAYXqoA+IO8qwVbx2KpqFr9DUb
         o6njCVJFfIXDCRBfv711DuWgjJphYFThWmvOv9evpZ3TsdOV/Rk1ZPIqXxZLs6Sainmc
         S1zxOVLhQRiOwSH1GMfEcsuD2KtXgUMJrRMViVoq/UZL0HZt6ERELVgYoFml+6uggMFX
         cGLzk6Weomiv0gAG8h5grNeHOOHNF15TVuokP0GoIDIxVc+bnGX1DzNdMRar+5yqfEM3
         hAyOKF3b1iCXri88ClHayFeOvwp5Xp3aYia+cJ90T4xMdC1SDfrtBTehcKf/VtSEzeK+
         LQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKZige4m/AoNTTthLZdSUaeHyHzQ4UT6ng0N8s0kzVk=;
        b=oIZqnHx1fIU+6fY18zzifRFeJ/BZ68kZCa7SuKd3aZBWxmd4psvlmt72o+4cP3GmCT
         FWCNkAEPVpnDh/3ghoAfPceiBCay3iq6IaIMySMcJztQdNiaFWK+sB8l5bdpqwLsQ9+r
         A36EsXlEE8DU3w+x9yZE2tUkb3Q2eJ5KOk5vV/VBKMCjss60fciMzBx5pk/atwlBoVnz
         i1aXx6Q6QM3wZup0GnpSTM85mFytq6MgQTBlBK36Z69M67O4M3yXTgNyRo8bI6wyMFRm
         xeVVQ2+2dPmDZYyBq1dNR3rF+Jl11sqIG3aIbVYCYokR9LQUfjUZNdfZZeiw8ziV0brE
         d7Ww==
X-Gm-Message-State: APjAAAUifIlLy4phR3wlBwdvFy54gijNJXuX7y3COCU3sToiu8obnPPc
        UXhWxw4qJqRjlwDaKwYLaKb7rEl6F5OJ8t9ZFiI=
X-Google-Smtp-Source: APXvYqz/hD3abK5iZXSi3wPYlOwN8FrT1CFYkRgJTPJUClxe+fHEd7f1yn8unX05mzbhhqRWfk9p5Hb28CxRNQtgwpQ=
X-Received: by 2002:a92:85c1:: with SMTP id f184mr14075867ilh.221.1581946214224;
 Mon, 17 Feb 2020 05:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20200216173446.1823-1-linux.amoon@gmail.com> <20200216173446.1823-4-linux.amoon@gmail.com>
 <1jmu9hzlo2.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jmu9hzlo2.fsf@starbuckisacylon.baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 17 Feb 2020 19:00:04 +0530
Message-ID: <CANAwSgSaQgU=H3h0S9deT11HA8z9R=Fhy5Kawii9tSBxKf2Wgw@mail.gmail.com>
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

Hi Jeronme,

Thanks for your  review comments.
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
Sorry, I was really upset about my self.
I tried to improvise this commit message based on previous mails.
sorry about that.

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

Ok I check this code changes is not needed for this fix.

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
I would like core developers to handle this.
Sorry for the noise.

-Anand
>
> >       },
> >  };
>
