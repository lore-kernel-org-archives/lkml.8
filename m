Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0B8C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F5120719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYlq9hh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgCYXcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:32:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45475 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgCYXcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:32:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id t17so4446342ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 16:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pz27N0s4bGqH38nVVinTBm250zTTCRPj61s65LyetcI=;
        b=oYlq9hh8/Gm/GSnuSQ/qhFMJzCvCTbM2E8LCW7ECvEPoGwPzJEaEPEZTfFFOti0HIo
         iixVNgOlh+cRVQY4Btmg658tF7b3EvFUF4NFLZO+TEJIedkrMJn4ESbkJ6C6buL0HvAB
         p7/R6klzpdVBtLs3Hq32KTzADXqpD7GxgRRSmDMRg4xhD/8YuqcnGo0yJPyt2c/8pn4V
         oPikUzntwzEJf5PYkdQk4bzMkVqaGuNH8B2zsejRqZZhQzBuf5ZwCZwoBrgHfM6A0h8m
         3Hhp3mDku8/QWsVgHZ7TYX29HS3vStwruDnPZzDvwL/444YpcDwXgwYZBgObnNh7lsUP
         NqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pz27N0s4bGqH38nVVinTBm250zTTCRPj61s65LyetcI=;
        b=qmxIDLPJvw4f91qWOcGyZYaoPOsY9l8L2wANLH4u9boKCAfvVikZV8TAQCaLczZOht
         sqoIMlmTKmZDwPSLiYtt0aRkromvNW2lVFvHp3svdKk0yPDyYDagSckNadCnMC4rlbPA
         i8sLWfmKQMoPqxDn10upJqZW+QLge5itdiiAKTDz6qwUfgFTdJ4jFJ61A5usEccvg1iL
         t7tf7u7LeInapDiJgadOKEVfD8lcQnUIQT/r8LZU0MQB/UoO/loaOMT7wFcGp4OH5LAC
         nw3AfI3Z1nBKUzjTMzkgBZU/7IEDEL5MYC/Hj1L72HSEODD6INGnblUkoZy8H89jHvxj
         DJsQ==
X-Gm-Message-State: AGi0PuaR1lzdha7TQjCIeVEKEFUXRPpt37paAsD4sAi5tBSu/n9eCz8k
        0NE3kduvKf3D/cmVLfywGrMR7LfH9VLssWYYTOlqOA==
X-Google-Smtp-Source: ADFU+vvXIlLAfb8Xes354yKGGFdqP+RtXwv/3ffUwqUHgps7GAEJ4AW0bT2D5wlGkKjN1zULPZwmyJMihIfPrh93b3M=
X-Received: by 2002:a05:651c:1026:: with SMTP id w6mr3350282ljm.168.1585179128988;
 Wed, 25 Mar 2020 16:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200313191513.11365-1-ansuelsmth@gmail.com>
In-Reply-To: <20200313191513.11365-1-ansuelsmth@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Mar 2020 00:31:57 +0100
Message-ID: <CACRpkdYvCHB_1FkHft3875iNZm9cGizFVLQQR56Lr95tEB_kwg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: use scm_call to route GPIO irq to Apps
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Ajay Kishore <akisho@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 8:15 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:

> For IPQ806x targets, TZ protects the registers that are used to
> configure the routing of interrupts to a target processor.
> To resolve this, this patch uses scm call to route GPIO interrupts
> to application processor. Also the scm call interface is changed.
>
> Signed-off-by: Ajay Kishore <akisho@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

That's advanced. I'd really like Bjorn's review on this.

> +       ret = of_device_is_compatible(pctrl->dev->of_node,
> +                                       "qcom,ipq8064-pinctrl");
>         /* Route interrupts to application cpu */
> -       val = msm_readl_intr_target(pctrl, g);
> -       val &= ~(7 << g->intr_target_bit);
> -       val |= g->intr_target_kpss_val << g->intr_target_bit;
> -       msm_writel_intr_target(val, pctrl, g);
> +       if (!ret) {

Can't you just:

if (!of_device_is_compatible(pctrl->dev->of_node, "qcom,ipq8064-pinctrl")) {

OK maybe nitpicky.

> +               val = msm_readl_intr_target(pctrl, g);
> +               val &= ~(7 << g->intr_target_bit);
> +               val |= g->intr_target_kpss_val << g->intr_target_bit;
> +               msm_writel_intr_target(val, pctrl, g);
> +       } else {
> +               const __be32 *reg = of_get_property(pctrl->dev->of_node,
> +                                                   "reg", NULL);
> +
> +               if (reg) {
> +                       u32 addr = be32_to_cpup(reg) + g->intr_target_reg;
> +
> +                       qcom_scm_io_readl(addr, &val);
> +                       __iormb();
> +
> +                       val &= ~(7 << g->intr_target_bit);
> +                       val |= g->intr_target_kpss_val << g->intr_target_bit;
> +
> +                       __iowmb();
> +                       ret = qcom_scm_io_writel(addr, val);
> +                       if (ret)
> +                               pr_err("\n Routing interrupts to Apps proc failed");
> +               }

Can we at least put a little comment on top here and explain what is
going on?

Yours,
Linus Walleij
