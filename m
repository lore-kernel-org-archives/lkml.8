Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10155C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB3824697
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jffKj9+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgFTVEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:04:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39207 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgFTVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:04:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id a9so15251707ljn.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMfSif8lYt33+r64QbIMr/6xvgq88zcecC3Y2xRHieQ=;
        b=jffKj9+P2dPJBSyOULJuAU6eBWKCl+2gQgwHtfsz6jmfHRR3WF40mhzxBPXFR+c3j1
         WE/4fe7XbkzFwaLQNUN0FbFefWCE6THJpVVFMNdhcYMiwViokPGEMmID+bZikNxuHXfy
         +FrnK1/DCpoDSqn+e0cr4SlLZE5JfYqb2yt4GxQoWoUbpMxbJ9EYEPouYmIhFEdxWLGr
         QtTEoyudLU2HEq0axhatbGdFhwPmk8e8NND7hb2DldelRIjj0fcsJGsrRPMH85DaNjnq
         66NAjB0c7ggwbnzd++elcTCWFgqTcsmzKaytPVhCfhST2MlsbPqCIngKn0hlvWeW60fG
         /Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMfSif8lYt33+r64QbIMr/6xvgq88zcecC3Y2xRHieQ=;
        b=haxcHlYrErM97G2pYNi0U9fekPtLNlFK9f9PjuK8yZZtufprSj3LQVN5ww5fzkTnFd
         B2/IgpQzV8e6soiwnp93x/b6Cm77i7oRZ8+9yhd8DpVyaIEERXTrfVOWJfjECah1LPSM
         SCoADydehsLygVPlBuiRJi34cHolJ5oarqnrqK+HWRR0U9CVI+mZ8BuaZKbv+Rb3CGMi
         RtBKf9tcC3JieoLoFfE8O6SjRFuBFqXkySMcZ//nK1uqGuTNNQWqs6Aov1dE1m/SWhoL
         bpt1cXVY5BAeJxUTAdw9QDpAtP8bQlCA8jauYr/1L04214JMDjy5TPHN+xv/6E79EFN6
         1oSQ==
X-Gm-Message-State: AOAM532qRzjv2oq8QQEYJojON0Pdvdq197I0eX9upCKVXwEpNuqGbVw6
        3tSNkIbv4nmuF0TXKtjA9bXz0dvuSlR8LbZ28W3zKA==
X-Google-Smtp-Source: ABdhPJw5SuKxJji2VfElAtYt42a0GP5lNrUCmrE3LEQtLbJKkZXvQKMkGNPhUVtMQZEJummq20kBonA8zp4n1tWKaUE=
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr5259398ljn.286.1592686995948;
 Sat, 20 Jun 2020 14:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <1592224927-28576-1-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1592224927-28576-1-git-send-email-rnayak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 23:03:05 +0200
Message-ID: <CACRpkdaNSw3jfYFY21LcrnV+40=VBSiaCsZeHDmscb0pkRuybg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sc7180: Make gpio28 non wakeup capable
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 2:42 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:

> It would have been nice to be able to do this only for the particular
> board with this design, however this change of removing gpio28 from the
> pinctrl SoC file means we end up with one less wakeup capable gpio for
> the entire SoC.

Yeah but what about only removing it for this board in the driver then?

> @@ -1122,7 +1122,7 @@ static const struct msm_pingroup sc7180_groups[] = {
>  static const struct msm_gpio_wakeirq_map sc7180_pdc_map[] = {
>         {0, 40}, {3, 50}, {4, 42}, {5, 70}, {6, 41}, {9, 35},
>         {10, 80}, {11, 51}, {16, 20}, {21, 55}, {22, 90}, {23, 21},
> -       {24, 61}, {26, 52}, {28, 36}, {30, 100}, {31, 33}, {32, 81},
> +       {24, 61}, {26, 52}, {30, 100}, {31, 33}, {32, 81},
>         {33, 62}, {34, 43}, {36, 91}, {37, 53}, {38, 63}, {39, 72},
>         {41, 101}, {42, 7}, {43, 34}, {45, 73}, {47, 82}, {49, 17},
>         {52, 109}, {53, 102}, {55, 92}, {56, 56}, {57, 57}, {58, 83},

Make a copy of this tuple-array and in sc7180_pinctrl_probe()
set sc7180_pinctrl.wakeirq_map and .nwakeirq_map to something
board specific like that:

if (of_machine_is_compatible("my,board")) {
    sc7180_pinctrl..wakeirq_map = ... ;
}

Yours,
Linus Walleij
