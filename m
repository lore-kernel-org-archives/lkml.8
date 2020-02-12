Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28254C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59A420661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OQE3DuQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgBLItU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:49:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38902 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgBLItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:49:19 -0500
Received: by mail-qt1-f194.google.com with SMTP id f3so918765qtc.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPMiAB16vFeuTny9mUeuPkgcErc/c1u/+DPFpZpBO4k=;
        b=OQE3DuQq8CSnmuvX45YQR0RHiYLUGWs9u/r3JwctxlV8TEpNMLx/YMPZIei1Z67SOj
         0gEvNwWN+/xeYQZkOHf+6kBok3+slMsYBUX9OkzK4tjvEd0pZDfxbvlMjSBD0n8hDoTF
         BWP+0WkA8vvCdMDpt2dOH1ibDeLpIIZe+axss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPMiAB16vFeuTny9mUeuPkgcErc/c1u/+DPFpZpBO4k=;
        b=Jjyqu5WF5O6LIePk+KiqfYni4wU25BGErxlWycuT3SX+mkNMgs66XFnYt4aj3hPeIN
         v2fstiVPi3QGvs3L2R5b8DczrdxJDWycjTiucEgTjKdr0bBDwJ1TtNs+lXr73U3eJmEs
         QE6y6B43AkXA6CiVKjSVX1YwleZDFp220JUM6K1FFGu8AyhZl6fKdiQ4/xyZAoTMznbt
         J7TaoTAh3SZnyqxquSMFymL8MNFrK8tq+AwE3+3rYCCKTbOoAM0JasNkyChEYI1qYM/5
         Ki3u95c5JprWXJkoBnUrJPyQHfUjPnvJgea9ZuA8087qk/bZNnomOlcXmDff9U50Hij1
         1DcQ==
X-Gm-Message-State: APjAAAWmnfngz+TTQDH5hr4ZTZQoUE00LWoxV6QiY8BdlYgXamlpd/rJ
        IJaQjGSe9BV1viODVY3jO86SF9JhidcshSi7UV/3zg==
X-Google-Smtp-Source: APXvYqzmVKHpUTNXqrbIKC3EqSdbu2muveQewCve0sKVxzWsWtlKrXbYUc3Qqq6GrpJeSuO++OcFsP8+K90kFIcIFgk=
X-Received: by 2002:ac8:4446:: with SMTP id m6mr6253965qtn.159.1581497358305;
 Wed, 12 Feb 2020 00:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org> <20200207052627.130118-8-drinkcat@chromium.org>
In-Reply-To: <20200207052627.130118-8-drinkcat@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 12 Feb 2020 16:49:07 +0800
Message-ID: <CANMq1KBL-S2DVKbCB2h_XNpfUro+pZ96-C5ft0p-8GX_tbXELQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] RFC: drm/panfrost: devfreq: Add support for 2 regulators
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Viresh Kumar +Stephen Boyd for clock advice.

On Fri, Feb 7, 2020 at 1:27 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> The Bifrost GPU on MT8183 uses 2 regulators (core and SRAM) for
> devfreq, and provides OPP table with 2 sets of voltages.
>
> TODO: This is incomplete as we'll need add support for setting
> a pair of voltages as well.

So all we need for this to work (at least apparently, that is, I can
change frequency) is this:
https://lore.kernel.org/patchwork/patch/1192945/
(ah well, Viresh just replied, so, probably not, I'll check that out
and use the correct API)

But then there's a slight problem: panfrost_devfreq uses a bunch of
clk_get_rate calls, and the clock PLLs (at least on MTK platform) are
never fully precise, so we get back 299999955 for 300 Mhz and
799999878 for 800 Mhz. That means that the kernel is unable to keep
devfreq stats as neither of these values are in the table:
[ 4802.470952] devfreq devfreq1: Couldn't update frequency transition
information.
The kbase driver fixes this by remembering the last set frequency, and
reporting that to devfreq. Should we do that as well or is there a
better fix?

Another thing that I'm not implementing is the dance that Mediatek
does in their kbase driver when changing the clock (described in patch
2/7):
""
The binding we use with out-of-tree Mali drivers includes more
clocks, this is used for devfreq: the out-of-tree driver switches
clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
switches clk_mux back to clk_main_parent:
(see https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#423)
clocks =
        <&topckgen CLK_TOP_MFGPLL_CK>,
        <&topckgen CLK_TOP_MUX_MFG>,
        <&clk26m>,
        <&mfgcfg CLK_MFG_BG3D>;
clock-names =
        "clk_main_parent",
        "clk_mux",
        "clk_sub_parent",
        "subsys_mfg_cg";
""
Is there a clean/simple way to implement this in the clock
framework/device tree? Or should we implement something in the
panfrost driver?

Thanks!



>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 17 +++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 413987038fbfccb..9c0987a3d71c597 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -79,6 +79,21 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>         struct devfreq *devfreq;
>         struct thermal_cooling_device *cooling;
>
> +       /* If we have 2 regulator, we need an OPP table with 2 voltages. */
> +       if (pfdev->comp->num_supplies > 1) {
> +               pfdev->devfreq.dev_opp_table =
> +                       dev_pm_opp_set_regulators(dev,
> +                                       pfdev->comp->supply_names,
> +                                       pfdev->comp->num_supplies);
> +               if (IS_ERR(pfdev->devfreq.dev_opp_table)) {
> +                       ret = PTR_ERR(pfdev->devfreq.dev_opp_table);
> +                       pfdev->devfreq.dev_opp_table = NULL;
> +                       dev_err(dev,
> +                               "Failed to init devfreq opp table: %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
>         ret = dev_pm_opp_of_add_table(dev);
>         if (ret == -ENODEV) /* Optional, continue without devfreq */
>                 return 0;
> @@ -119,6 +134,8 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
>         if (pfdev->devfreq.cooling)
>                 devfreq_cooling_unregister(pfdev->devfreq.cooling);
>         dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
> +       if (pfdev->devfreq.dev_opp_table)
> +               dev_pm_opp_put_regulators(pfdev->devfreq.dev_opp_table);
>  }
>
>  void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index c30c719a805940a..5009a8b7c853ea1 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -110,6 +110,7 @@ struct panfrost_device {
>         struct {
>                 struct devfreq *devfreq;
>                 struct thermal_cooling_device *cooling;
> +               struct opp_table *dev_opp_table;
>                 ktime_t busy_time;
>                 ktime_t idle_time;
>                 ktime_t time_last_update;
> --
> 2.25.0.341.g760bfbb309-goog
>
