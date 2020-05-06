Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5575C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC73020836
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0leiOl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgEFOnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgEFOnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:43:13 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8CFC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 07:43:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g14so1522620otg.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvA9cHX5N+iHo9A2XBvXohxr8Lc3MrTNE5akQA7NmRQ=;
        b=k0leiOl/iPansEp/r4YdtcNtYZzvaeDH1kAXKq7PUTLC6LkgzS0X5HjeWC2hs1XqGT
         dYulm0RZ3a5s7yz8aalNXMcVNqK4pwrqQ9Sn7MEoZlFjbtkm9fWRL/aJvBEcbCaT0kyg
         m7S7R0uW9VhiMJDqif/LgQe+awlb1dhYfgpDe7t6qjiYvVa6/e/4NdVW+/0GSk9FXMFk
         naC8AQwyIvfVDs8STy+hGtjpRhxBd41GHiprQLyerRjBEl0oSfZVuycBQGgLdJ1yOiI7
         Gzg2vBbgv4kEcnSjIVQV4HnpjXsYw7+pEp/07X2XmYiAJHWIa5BMffaQv61I+znv79NA
         Aohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvA9cHX5N+iHo9A2XBvXohxr8Lc3MrTNE5akQA7NmRQ=;
        b=EEXxJUnweLT97vpkSxVxNGCYFoMxJuDm2uq9fKilNncC+HKPqaZzcZq7LjIvG45dLn
         itSacUIqI5ykyKUy9XyeZ29DI8FJ5HlxSCN1StivP87C8ryYpmYRga9oOS6ijukxm3YO
         fgMj9IU7aWVjYSRLGmLgIAM4PfC3V9w2nGIIppQ+IkpqDu6cQNuFW6TYfEu3GYIjGa+/
         AVk/GGzUNg4Pj/bJT2lJspNvttetrPBfB4bj6PztXzQFtxSVs16KGpNp8l4ZBAFWC9rj
         48+eS+5QYszkSWDfxJOOKMUSCXdsMceGe1c47ntGbwM7NAyNyQ1ZdJE2n+YEuA5vQzXC
         Aoxg==
X-Gm-Message-State: AGi0PuYC25IKwFHuktk1Qw+0OmaUMhtbeKRyU9w1N+VhwMb04ZPB4QG6
        FfUvk6h49Aq6yjCokYY15p64V9VRVX9rBhhdV2KMfGz1jJ8=
X-Google-Smtp-Source: APiQypIR8jUChbBb07H8aYWpowxSna/XerSP6fj3rJka7RxqUd4wR9i/3bD2M5vYFscAy0+Y4ZLmc0FqDZ2BMX0NWso=
X-Received: by 2002:a05:6830:1d7:: with SMTP id r23mr6659207ota.68.1588776192480;
 Wed, 06 May 2020 07:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200505100129.104673-1-robert.foss@linaro.org>
 <20200505100129.104673-3-robert.foss@linaro.org> <20200505101602.GE18755@pengutronix.de>
In-Reply-To: <20200505101602.GE18755@pengutronix.de>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 6 May 2020 16:43:01 +0200
Message-ID: <CAG3jFyvm_CYad_7qFD1MbLLi=HdT7jQTZ=iqTO+excSpbyNvaQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] media: ov8856: Add devicetree support
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>, Ben Kao <ben.kao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 at 12:16, Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Robert,
>
> On 20-05-05 12:01, Robert Foss wrote:
> > Add match table, enable ov8856_probe() to support
> > both ACPI and DT modes.
> >
> > ACPI and DT modes are primarily distinguished from
> > by checking for ACPI mode and by having resource like
> > be NULL.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >
> > - Changes since v6:
> >   * Marco: Bail out of __ov8856_power_on earlier if ACPI mode
> >
> > - Changes since v5:
> >   * Maxime & Sakari: Replaced clock tolerance check with warning
> >
> > - Changes since v4:
> >   * Maxime & Sakari: Switch to clock-frequency
> >
> > - Changes since v3:
> >   * Remove redundant {}-brackets
> >   * Compare xvclk_rate to 5% tolerance
> >   * Andy: Use dev_fwnode()
> >   * Andy: Use %pe instead of %ld + PTR_ERR()
> >   * Andy: Invert reset_gpio logic
> >   * Andy: Remove dev_dbg() from failing reset_gpio setup
> >   * Andy: Use dev_err for logging for failures
> >   * Andy: Remove dev_warn from EDEFER/regulator error path
> >   * Andy & Sakari: Replaced GPIOD_OUT_XXX with 0/1
> >   * Maxime & Sakari: Verify clock frequency from DT
> >   * Sakari: Verify the 'xvclk_rate' is set correctly for ACPI/DT devices
> >   * Sakari: Remove duplicate ov8856->dev assignment
> >
> > - Changes since v2:
> >   * Added "struct device *dev" member to struct ov8856
> >   * Andy: Switch to optional version of devm_gpiod_get
> >   * Andy: Switch to optional version of devm_clk_get
> >   * Fabio: Add reset sleep period
> >   * Sakari: Unify defines for 19.2Mhz
> >   * Sakari: Remove 24Mhz clock, since it isn't needed for supported modes
> >   * Sakari: Replace dev_info() with dev_dbg()
> >   * Sakari: Switch induction variable type to unsigned
> >   * Sakari: Don't wait for reset_gpio when in ACPI mode
> >   * Sakari: Pull reset GPIO high on power on failure
> >   * Sakari: Add power on/off to resume/suspend
> >   * Sakari: Fix indentation
> >   * Sakari: Power off during ov8856_remove()
> >   * Sakari: Don't sleep during power-on in ACPI mode
> >   * Sakari: Switch to getting xvclk from clk_get_rate
> >
> > - Changes since v1:
> >   * Andy & Sakari: Make XVCLK optional since to not break ACPI
> >   * Fabio: Change n_shutdown_gpio name to reset_gpio
> >   * Fabio: Invert reset_gpio due to GPIO_ACTIVE_HIGH -> GPIO_ACTIVE_LOW change
> >   * Fabio: Remove empty line
> >   * Fabio: Remove real error from devm_gpiod_get() failures
> >   * Sakari: ARRAY_SIZE() directly instead of through OV8856_NUM_SUPPLIES
> >   * Sakari: Use XVCLK rate as provided by DT
> >
> >  drivers/media/i2c/ov8856.c | 137 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 123 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> > index 8655842af275..e6418a79801e 100644
> > --- a/drivers/media/i2c/ov8856.c
> > +++ b/drivers/media/i2c/ov8856.c
> > @@ -3,10 +3,13 @@
> >
> >  #include <asm/unaligned.h>
> >  #include <linux/acpi.h>
> > +#include <linux/clk.h>
> >  #include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <media/v4l2-ctrls.h>
> >  #include <media/v4l2-device.h>
> >  #include <media/v4l2-fwnode.h>
> > @@ -18,7 +21,7 @@
> >  #define OV8856_LINK_FREQ_360MHZ              360000000ULL
> >  #define OV8856_LINK_FREQ_180MHZ              180000000ULL
> >  #define OV8856_SCLK                  144000000ULL
> > -#define OV8856_MCLK                  19200000
> > +#define OV8856_XVCLK_19_2            19200000
> >  #define OV8856_DATA_LANES            4
> >  #define OV8856_RGB_DEPTH             10
> >
> > @@ -64,6 +67,12 @@
> >
> >  #define to_ov8856(_sd)                       container_of(_sd, struct ov8856, sd)
> >
> > +static const char * const ov8856_supply_names[] = {
> > +     "dovdd",        /* Digital I/O power */
> > +     "avdd",         /* Analog power */
> > +     "dvdd",         /* Digital core power */
> > +};
> > +
> >  enum {
> >       OV8856_LINK_FREQ_720MBPS,
> >       OV8856_LINK_FREQ_360MBPS,
> > @@ -566,6 +575,11 @@ struct ov8856 {
> >       struct media_pad pad;
> >       struct v4l2_ctrl_handler ctrl_handler;
> >
> > +     struct device           *dev;
>
> Why do we need this reference here? We already have all information we
> need to retrieve the device.

Ack, I'll remove it in the next revision.

>
> > +     struct clk              *xvclk;
> > +     struct gpio_desc        *reset_gpio;
> > +     struct regulator_bulk_data supplies[ARRAY_SIZE(ov8856_supply_names)];
> > +
> >       /* V4L2 Controls */
> >       struct v4l2_ctrl *link_freq;
> >       struct v4l2_ctrl *pixel_rate;
> > @@ -908,6 +922,52 @@ static int ov8856_set_stream(struct v4l2_subdev *sd, int enable)
> >       return ret;
> >  }
> >
> > +static int __ov8856_power_on(struct ov8856 *ov8856)
> > +{
> > +     struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
> > +     int ret;
> > +
> > +     if (is_acpi_node(dev_fwnode(ov8856->dev)))
> > +             return 0;
> > +
> > +     ret = clk_prepare_enable(ov8856->xvclk);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "failed to enable xvclk\n");
> > +             return ret;
> > +     }
> > +
> > +     if (ov8856->reset_gpio) {
> > +             gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
> > +             usleep_range(1000, 2000);
> > +     }
> > +
> > +     ret = regulator_bulk_enable(ARRAY_SIZE(ov8856_supply_names),
> > +                                 ov8856->supplies);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "failed to enable regulators\n");
> > +             goto disable_clk;
> > +     }
> > +
> > +     gpiod_set_value_cansleep(ov8856->reset_gpio, 0);
> > +     usleep_range(1500, 1800);
> > +
> > +     return 0;
> > +
> > +disable_clk:
> > +     gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
> > +     clk_disable_unprepare(ov8856->xvclk);
> > +
> > +     return ret;
> > +}
> > +
> > +static void __ov8856_power_off(struct ov8856 *ov8856)
> > +{
> > +     gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
> > +     regulator_bulk_disable(ARRAY_SIZE(ov8856_supply_names),
> > +                            ov8856->supplies);
>
> In case of ACPI this will still be a unbalanced regulator. Albeit it is a
> dummy_regulator it will produce warnings in the ACPI case. Therefore I
> said to add the check:
>
> if (is_acpi_node(dev_fwnode(ov8856->dev)))
>         return 0;
>
> here to at the begin of this function.

Ah, I thought the dummy regulators wouldn't generate an error. I'll
add the early escape for ACPI.

>
>
> > +     clk_disable_unprepare(ov8856->xvclk);
> > +}
> > +
> >  static int __maybe_unused ov8856_suspend(struct device *dev)
> >  {
> >       struct i2c_client *client = to_i2c_client(dev);
> > @@ -918,6 +978,7 @@ static int __maybe_unused ov8856_suspend(struct device *dev)
> >       if (ov8856->streaming)
> >               ov8856_stop_streaming(ov8856);
> >
> > +     __ov8856_power_off(ov8856);
> >       mutex_unlock(&ov8856->mutex);
> >
> >       return 0;
> > @@ -931,6 +992,8 @@ static int __maybe_unused ov8856_resume(struct device *dev)
> >       int ret;
> >
> >       mutex_lock(&ov8856->mutex);
> > +
> > +     __ov8856_power_on(ov8856);
> >       if (ov8856->streaming) {
> >               ret = ov8856_start_streaming(ov8856);
> >               if (ret) {
> > @@ -1092,29 +1155,54 @@ static int ov8856_identify_module(struct ov8856 *ov8856)
> >       return 0;
> >  }
> >
> > -static int ov8856_check_hwcfg(struct device *dev)
> > +static int ov8856_get_hwcfg(struct ov8856 *ov8856)
> >  {
> > +     struct device *dev = ov8856->dev;
> >       struct fwnode_handle *ep;
> >       struct fwnode_handle *fwnode = dev_fwnode(dev);
> >       struct v4l2_fwnode_endpoint bus_cfg = {
> >               .bus_type = V4L2_MBUS_CSI2_DPHY
> >       };
> > -     u32 mclk;
> > +     u32 xvclk_rate;
> >       int ret;
> >       unsigned int i, j;
> >
> >       if (!fwnode)
> >               return -ENXIO;
> >
> > -     ret = fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
> > +     ret = fwnode_property_read_u32(fwnode, "clock-frequency",
> > +             &xvclk_rate);
> >       if (ret)
> >               return ret;
> >
> > -     if (mclk != OV8856_MCLK) {
> > -             dev_err(dev, "external clock %d is not supported", mclk);
> > -             return -EINVAL;
> > +     if (!is_acpi_node(fwnode)) {
> > +             ov8856->xvclk = devm_clk_get(dev, "xvclk");
> > +             if (IS_ERR(ov8856->xvclk)) {
> > +                     dev_err(dev, "could not get xvclk clock (%pe)\n",
> > +                                     ov8856->xvclk);
>
> I tought I commented this to. Pls align it :)

Done!

>
> Regards,
>   Marco
>
