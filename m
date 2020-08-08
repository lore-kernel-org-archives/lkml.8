Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4301C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 17:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C346520719
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 17:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5zmyG2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgHHRNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHHRNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 13:13:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA417C061756;
        Sat,  8 Aug 2020 10:13:18 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id w12so4971921iom.4;
        Sat, 08 Aug 2020 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=10CvMVkFP5s0ogDLDyQLYDDtzvGA2GFASeeImWfNvUk=;
        b=V5zmyG2WJuuFRtXQWYNAehEPBSYzwi8qVw7YmJ9J92ZGxTUI3Tj3VA5ZAXaOo5E7dX
         jW1jq+SfY6CsA9PNjUeGHqd4HxfznppRMyHO1Ny4OvIpxpEfp7kg2chqEQR/fw2d/txO
         l+S+yq8d2X/KRIoBmR4WVsYIWi5Jg7OuIlpSXqu+FVDL2sHDoRL9yhZpLmaMc9PiyKOp
         ijCw2OapJAkYJut0Qf7mVS/5Ngs3I4a9M45wN1OvyUirQD1D8aYlYnFK8CEvIS0R34Br
         aCwcrLJdAvGPoRoHU778k01OI+CZg5kJbehPUkdprZUJ7OaLz6cw/VU1hOeMkjE9kuNv
         MorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=10CvMVkFP5s0ogDLDyQLYDDtzvGA2GFASeeImWfNvUk=;
        b=WZQBwAGBTuyDJbfgfLvpx03D+uACpAzmZY/rIn6O4elef036wITx5cC9sCgoWuv/Bj
         KCgts0RgK3wh0D6l4jqaVWwiLYTZ2HFJ/2YMfsIps8IAPWbgoflctUjOZy2ej9oIBQrX
         bhtqsrIUFg09N+SLOySE5XoEttOtba0bUBoVBphjt6CQCpW6zTS2MvDb8rfGvAZL0IEk
         rfcn2Xo4yVoZwyQL31viMLz7o9x3wDq6+WTqymdGeN9EfwDvUnnpN1snSO95NbY+LLDg
         sHLjoB1IVygFCqRHaLdo1zoq9LNQnh/7MiB9F20+fwULXMBDgs0UjWmQIorf7WZoZPa4
         XNKQ==
X-Gm-Message-State: AOAM533+C7896IFeqb4vCUhNrpzYDKHYIz2tV2AmqW73fl8evOUt5D43
        Ndf73PQDfMdXPBx+cOgT0ooFeSV66pT76dy+qU8=
X-Google-Smtp-Source: ABdhPJyX64YtKJWSqwizyrJNygwkrIk1NowT0wwl2BNXq6x0fsRJt7GgJsT1h3wjxw22Xa+W7TBt26KkFZ2Np3csNIc=
X-Received: by 2002:a6b:b888:: with SMTP id i130mr9996946iof.182.1596906797218;
 Sat, 08 Aug 2020 10:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f@eucas1p2.samsung.com>
 <20200806160646.1997-1-s.nawrocki@samsung.com> <CA+Ln22HGSj4gFRmw1rSLaTvw3TiPC9jaM6JB4Z1fbxpwsWNZWw@mail.gmail.com>
 <d980e369-73ef-89a8-6669-f7e9c5dd3243@samsung.com>
In-Reply-To: <d980e369-73ef-89a8-6669-f7e9c5dd3243@samsung.com>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Sat, 8 Aug 2020 19:13:05 +0200
Message-ID: <CA+Ln22EY1HDMLKpSsfj+9UyON-51_b-pkPgd3MCyArQSAjKYSw@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: Prevent potential endless loop in the PLL
 set_rate ops
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=E5=B9=B48=E6=9C=887=E6=97=A5(=E9=87=91) 19:06 Sylwester Nawrocki <s.na=
wrocki@samsung.com>:
>
> Hi Tomasz,
>
> On 8/6/20 18:11, Tomasz Figa wrote:
> >> --- a/drivers/clk/samsung/clk-pll.c
> >> +++ b/drivers/clk/samsung/clk-pll.c
> >> @@ -63,6 +63,27 @@ static long samsung_pll_round_rate(struct clk_hw *h=
w,
> >>         return rate_table[i - 1].rate;
> >>  }
> >>
> >> +static int samsung_pll_lock_wait(struct samsung_clk_pll *pll,
> >> +                                unsigned int reg_mask)
> >> +{
> >> +       ktime_t timeout;
> >> +
> >> +       /* Wait until the PLL is in steady locked state */
> >> +       timeout =3D ktime_add_ms(ktime_get(), PLL_TIMEOUT_MS);
> >> +
> >> +       while (!(readl_relaxed(pll->con_reg) & reg_mask)) {
> >> +               if (ktime_after(ktime_get(), timeout)) {
> >> +                       pr_err("%s: Could not lock PLL %s\n",
> >> +                               __func__, clk_hw_get_name(&pll->hw));
> >> +                       return -EFAULT;
> >> +               }
> >> +
> >> +               cpu_relax();
> >> +       }
>
> > Thanks for the patch! Good to have this consolidated. How about going
> > one step further and using the generic
> > readl_relaxed_poll_timeout_atomic() helper?
>
> Might be a good suggestion, I was considering those helpers but ended
> up not using them in the patch. The cpu_relax() call might also not be
> really needed now, when there is the ktime code within the loop.
> Having multiple occurrences of readl_relaxed_poll_timeout_atomic() could
> increase the code size due to inlining. How about keeping the
> samsung_pll_lock_wait() function and just changing its implementation?

Sounds good to me, thanks!

Best regards,
Tomasz
