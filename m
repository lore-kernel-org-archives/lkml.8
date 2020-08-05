Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5DCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0F72245C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7KCWZiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHEHoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHEHof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:44:35 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76880C061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 00:44:35 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id x6so1863448ooe.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 00:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XB0gKQyc9CsSKqZ7GgGJ8tPycXtrwiQ0rJYnNLbYnE=;
        b=O7KCWZiyayJrpPKe4Qo2MFaMV++l507OxnySpg4nllQ/4WIyMRp2lmiAvGqQ++lZ/i
         vurTpoVPRWh2eWqVPdl+snBzEx6FwPldWsWqTBgZM4xOyUZWUxAZjdRAQgCtgP67MK04
         ee7GreNHGoW00bOF3cl/JYbZUFiin8xF3OX6uD5776b0ZZdreRjtCydX/Uhays9SI/tB
         axIiLXzrWS9a6MiU3AOIocYrZgEHqZi5bWdtWeWMCkuKFVa95uev5y5FAL8m4mBOG7+s
         LFMYnNqvJyhxpqiIzSINRZJQdQ1ASAJHx/N/N+MNsK+WGBTlWFQJ9NeScR/DbhGCCnT0
         6c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XB0gKQyc9CsSKqZ7GgGJ8tPycXtrwiQ0rJYnNLbYnE=;
        b=RWKY2WhGHOK87xjqIOR2BLvYnGmtwH5tOGOjXUwc25Szhs5lyMoES5FUDA3LPFS0qr
         ftn/wgprO41+ATkcP6vFdgI0jLsXvKYFy6QjSe46vyj90kTdPv7UQcev8cgJShXAUczx
         folZxSqRyeOgEtvFKoeohATBHYKYmCR6SND3Biy/mgZXj9Sr3eTRQwMa5qLHBoTv+nxz
         JeiCNQ2dWEukqSIfTS4r89yE1E0QjuswJeWUTSri2yqGlN24hbw6NM/tj7mJZfRkFbBX
         jT4lTsiBNevk6jt3Po6gGy9YaiB/HEf+/Pwn4RGdt/p0KNVkc9/4yoLuar2trCVPY7Jx
         I6Rg==
X-Gm-Message-State: AOAM533E8HVdyZTUw0rQd12IRYDcriY5DyE3/qoWwiV0YHHLrUKG8RzS
        9ukompW66Roe7zylAknmF1j/DH2xpcAVzNYDf9jVFA==
X-Google-Smtp-Source: ABdhPJyTnc5GAirwQ3qZDK4WN0lqH19fI2aSlix6R6R+dyBypcI5OYPshiJlUl3SHM0DH8s2OgrXhfwvSl++QvmT16w=
X-Received: by 2002:a4a:a648:: with SMTP id j8mr1634862oom.36.1596613472779;
 Wed, 05 Aug 2020 00:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com> <20200718000637.3632841-3-saravanak@google.com>
In-Reply-To: <20200718000637.3632841-3-saravanak@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 5 Aug 2020 00:44:21 -0700
Message-ID: <CALAqxLVZ+rFE+hM9OtQ46NqpTHeLu6oKLNWKstLv1U5zbwyq7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] irqchip/qcom-pdc: Switch to using
 IRQCHIP_PLATFORM_DRIVER helper macros
To:     Saravana Kannan <saravanak@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 5:06 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Switch the driver to use the helper macros. In addition to reducing the
> number of lines, this also adds module unload protection (if the driver
> is compiled as a module) by switching from module_platform_driver to
> builtin_platform_driver.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/irqchip/qcom-pdc.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index 5b624e3295e4..c1c5dfad57cc 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -432,28 +432,8 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>         return ret;
>  }
>
> -static int qcom_pdc_probe(struct platform_device *pdev)
> -{
> -       struct device_node *np = pdev->dev.of_node;
> -       struct device_node *parent = of_irq_find_parent(np);
> -
> -       return qcom_pdc_init(np, parent);
> -}
> -
> -static const struct of_device_id qcom_pdc_match_table[] = {
> -       { .compatible = "qcom,pdc" },
> -       {}
> -};
> -MODULE_DEVICE_TABLE(of, qcom_pdc_match_table);
> -
> -static struct platform_driver qcom_pdc_driver = {
> -       .probe = qcom_pdc_probe,
> -       .driver = {
> -               .name = "qcom-pdc",
> -               .of_match_table = qcom_pdc_match_table,
> -               .suppress_bind_attrs = true,
> -       },
> -};
> -module_platform_driver(qcom_pdc_driver);
> +IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_pdc)
> +IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
> +IRQCHIP_PLATFORM_DRIVER_END(qcom_pdc)
>  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
>  MODULE_LICENSE("GPL v2");

<sigh>
So this is where I bashfully admit I didn't get a chance to try this
patch series out, as I had success with a much older version of
Saravana's macro magic.

But unfortunately, now that this has landed in mainline, I'm seeing
boot regressions on db845c. :( This is in the non-modular case,
building the driver in.

I managed to bisect it down to this patch, and reverting it avoids the
issue. I don't see what is wrong right off, but I really need to get
to bed, so I'll dig further tomorrow.

Saravana: Apologies for not getting around to testing this beforehand!

thanks
-john
