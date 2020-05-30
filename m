Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5FDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D05B2072A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590883115;
	bh=VUz6nHZXjZ/r4lCM+WBxybE+t4xw4kvQcisbJmoT/Dg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FnP54iPXm/cAvY8OK07P0Rkpv/6tNYudr9YNIpvrxq7FOOr3EscQVK5HsrpCa0zYx
	 SNoLlFQjPJBIr9fIqJ4jAvpOQta5XlYgpTAptFjKONeWr/P4YoFCIGmF/HzikEcANE
	 an9Hkag0SgOEtg9wbFa//NfRUVnApTqc5itKYQLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgE3X6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729385AbgE3X6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:58:34 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E85EB207BB;
        Sat, 30 May 2020 23:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590883113;
        bh=VUz6nHZXjZ/r4lCM+WBxybE+t4xw4kvQcisbJmoT/Dg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=18ho/PhYFDtcVEFFwa9kL4XMLHSHS3voxfTSEgSRGbxy+wrWU2KJ6VYRzamYa2M4c
         oODZBCidDXttGIIH56KairuG4hGqUTBS3F5Tbg/TAihKM+8KqipnLdYGHacHH++erf
         65sfhOv3W5JIIaGJXkt4EyX7DeBPsLOlDH0XR1Q8=
Received: by mail-lj1-f175.google.com with SMTP id z13so3717104ljn.7;
        Sat, 30 May 2020 16:58:32 -0700 (PDT)
X-Gm-Message-State: AOAM532U2bpNgOUpzoMYijQNozyoIH9L4ivKsaIKZEfxFtBnKuCDnanG
        WZGUleUzqJBgBquD8QU9C1V43lEFxTOoqhsnR8g=
X-Google-Smtp-Source: ABdhPJzgSmF0+p11oPO+AZBR8CytQW5O5N8qZczqfnM6nRVQcCxJIot76Q2X9ANKtvk8r/cwbxtdchn2Ly+QLKlKomk=
X-Received: by 2002:a05:651c:105a:: with SMTP id x26mr7446493ljm.159.1590883111232;
 Sat, 30 May 2020 16:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200529163225eucas1p1cfb2233c869dcc3dab84b754bbce17b6@eucas1p1.samsung.com>
 <20200529163200.18031-1-s.nawrocki@samsung.com> <20200529163200.18031-4-s.nawrocki@samsung.com>
In-Reply-To: <20200529163200.18031-4-s.nawrocki@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sun, 31 May 2020 08:57:54 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1KC=jpQ5GXNtEf1cn7+WqXJdqbbVKmpxr8Snh4GEy8bA@mail.gmail.com>
Message-ID: <CAGTfZH1KC=jpQ5GXNtEf1cn7+WqXJdqbbVKmpxr8Snh4GEy8bA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/6] PM / devfreq: exynos-bus: Add registration of
 interconnect child device
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On Sat, May 30, 2020 at 1:33 AM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> This patch adds registration of a child platform device for the exynos
> interconnect driver. It is assumed that the interconnect provider will
> only be needed when #interconnect-cells property is present in the bus
> DT node, hence the child device will be created only when such a property
> is present.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> Changes for v5:
>  - new patch.
> ---
>  drivers/devfreq/exynos-bus.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 8fa8eb5..856e37d 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -24,6 +24,7 @@
>
>  struct exynos_bus {
>         struct device *dev;
> +       struct platform_device *icc_pdev;
>
>         struct devfreq *devfreq;
>         struct devfreq_event_dev **edev;
> @@ -156,6 +157,8 @@ static void exynos_bus_exit(struct device *dev)
>         if (ret < 0)
>                 dev_warn(dev, "failed to disable the devfreq-event devices\n");
>
> +       platform_device_unregister(bus->icc_pdev);
> +
>         dev_pm_opp_of_remove_table(dev);
>         clk_disable_unprepare(bus->clk);
>         if (bus->opp_table) {
> @@ -168,6 +171,8 @@ static void exynos_bus_passive_exit(struct device *dev)
>  {
>         struct exynos_bus *bus = dev_get_drvdata(dev);
>
> +       platform_device_unregister(bus->icc_pdev);
> +
>         dev_pm_opp_of_remove_table(dev);
>         clk_disable_unprepare(bus->clk);
>  }
> @@ -431,6 +436,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 goto err;
>
> +       /* Create child platform device for the interconnect provider */
> +       if (of_get_property(dev->of_node, "#interconnect-cells", NULL)) {
> +                   bus->icc_pdev = platform_device_register_data(
> +                                               dev, "exynos-generic-icc",
> +                                               PLATFORM_DEVID_AUTO, NULL, 0);
> +
> +                   if (IS_ERR(bus->icc_pdev)) {
> +                           ret = PTR_ERR(bus->icc_pdev);
> +                           goto err;
> +                   }
> +       }
> +
>         max_state = bus->devfreq->profile->max_state;
>         min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
>         max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> --
> 2.7.4
>

It looks like very similar like the registering the interconnect
device of imx-bus.c
and I already reviewed and agreed this approach.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

nitpick: IMHO, I think that 'exynos-icc' is proper and simple without
'generic' word.
If we need to add new icc compatible int the future, we will add
'exynosXXXX-icc' new compatible.
But, I'm not forcing it. just opinion. Anyway, I agree this approach.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
