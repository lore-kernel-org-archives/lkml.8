Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF32CC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B836020708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVnVRn4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgEFQgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729789AbgEFQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:36:49 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB4C0610D5
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:36:49 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id b14so694731vkk.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEp/F3SbsRoDv1jpNGzhOxbfis7J4KDcT9P9z6XWkHg=;
        b=eVnVRn4S8Hb7sl1mAhlDpCkwg2p7TvzKWg0qVVe/dWs+kNzu0dkUnF12cuHSLRfxJA
         k1JsPhNHp6gpFvg3metDV/hPplaRlu3pQXHecw2lhBu91JqE8L0mSdp5Zmc9jNhUWqIB
         1xGIHjkcCR9gqoJXy85LS+19SdMWYi5+Ih9W8LUXfrQqUUPxnoOEUhmxOrI+MLwWHhr+
         E9RKn25uZiu4s/nZwk/EVD7PaM11znkaVIxenvyVhmirLDphTRgJue6k6ZZ0J3TwDTz6
         0ZY1n1k1WDVUIhczz4M4qBDev1+txdlb4jFvLkVck7EDsXiBjF4LLHsLj3SpxlVGryrw
         tIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEp/F3SbsRoDv1jpNGzhOxbfis7J4KDcT9P9z6XWkHg=;
        b=R864htuUURutF030D/bprwyY3atIm/dSFy86sVvU6GRVVqfdLeWTBESL2hhYHp744j
         DYpDO2oP66yxYiGPnzx9Jf6W0DiQ0Uv4i2AIy9/fn7h/57ki256YIMUBFVs4Wadl4Lq+
         E8SCPFKGcONl8asTvV+ApvU3PXYLH2ZNtYjajC88CIGGIo3XkBlhEVQ5vZWM2NeNKg+q
         p/ghalMwKhBUhresuBKtGQLReI0EyHoGm8yVm2OVhERG7kwG9ueRxgQdD14F9SoF8fdO
         KjApzgpPosk8IINkmU61gGHru9qsNv5/1tz2tDnxRI7hVpJFQ2hq5omBZB4aE4Q7lwJk
         ow7A==
X-Gm-Message-State: AGi0PuYAS2hBfPCes1k5H0F4mKXFTvTnGu4uk8MgZb1D/N6fW3RUZ6sg
        ekgmnuyJ5Jbx+xtShuOU2Arazfxd6QpzO8itJjml4w==
X-Google-Smtp-Source: APiQypLm9f0btuKktuvMb+D03IME6dlX6dRX4NRiQ4NXE3O3t6sARzsGX6NfhfAe3VIx+4GZEIKh+9FQbLrJ4BJaBxM=
X-Received: by 2002:a1f:8ccf:: with SMTP id o198mr8122974vkd.53.1588783008587;
 Wed, 06 May 2020 09:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <1588031768-23677-1-git-send-email-chun-hung.wu@mediatek.com>
 <1588031768-23677-2-git-send-email-chun-hung.wu@mediatek.com> <9bc2454f-0b42-e256-7927-2564b56f369f@codeaurora.org>
In-Reply-To: <9bc2454f-0b42-e256-7927-2564b56f369f@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 May 2020 18:36:12 +0200
Message-ID: <CAPDyKFq7ffHeWg-S41tLvScg_BXCUULig=G=EzD_to1TG0NhVg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] mmc: core: Extend mmc_of_parse() to parse CQE bindings
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, wsd_upstream@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 at 15:01, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
>
> On 4/28/2020 5:26 AM, Chun-Hung Wu wrote:
> > Parse CQE bindings "supports-cqe" and "disable-cqe-dcmd"
> > in mmc_of_parse().
> >
> > Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> > ---
> >   drivers/mmc/core/host.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index c876872..47521c6 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -302,6 +302,11 @@ int mmc_of_parse(struct mmc_host *host)
> >               host->caps2 |= MMC_CAP2_NO_SD;
> >       if (device_property_read_bool(dev, "no-mmc"))
> >               host->caps2 |= MMC_CAP2_NO_MMC;
> > +     if (device_property_read_bool(dev, "supports-cqe"))
> > +             host->caps2 |= MMC_CAP2_CQE;
>
> This change is breaking emmc driver on qcom platforms where this dt
> property is defined.
>
> [    1.543453]  cqhci_deactivate+0xc/0x38
> [    1.545627]  sdhci_msm_reset+0x40/0x58
> [    1.549447]  sdhci_do_reset+0x48/0x7c
> [    1.553180]  __sdhci_read_caps+0x7c/0x214
> [    1.556913]  sdhci_setup_host+0x58/0xce8
> [    1.560905]  sdhci_msm_probe+0x588/0x8a4
> [    1.564900]  platform_drv_probe+0x4c/0xb0
>
> So, we cant have this flag defined before sdhci_setup_host().
>
> I will have to clear this cap and re-enable it in our initialization.

Thanks for reporting! I have dropped all the four patches from
Chun-Hung, so we can figure out how to fix this.

Please help to review the next version of the series.

>
> > +     if (!device_property_read_bool(dev, "disable-cqe-dcmd")) {
> > +             host->caps2 |= MMC_CAP2_CQE_DCMD;
> > +     }
> >
> >       /* Must be after "non-removable" check */
> >       if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {

Kind regards
Uffe
