Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF38C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013B52074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AI26J2ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgD2KUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgD2KTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:19:52 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69368C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:19:50 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id r66so1324295oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySw1JY1pUEmGxd3VKb4dOahnkparolrY7LxLxmHjsxQ=;
        b=AI26J2eputUhny34KK4c7nSnnxIjryDf3Ty/h6zFRGVmbIF51p9Y9yQwt59mv/ekw3
         fUFeu5YqA0HJE7xIYJ4OY1gXBAEyr+64HagBmGKGQIPtA43KxzuseSy36Amqt7p+WeUk
         t6BolG5l0IGQiGYqyxguo63zs0hM6Pi3fmOCzNtEbYFTtl4NdYM6mjhpen4oyaFiwBdT
         myCjJ/X7O6TYJft6csJST0r5ZUDxlw0Nq8JgO39ClHXW7LrdDJXucjjN0FBlZ2iQ3pOd
         xtzSdc8v1GWyXhPrUxekIIswg2LVm/PLtb2/1HQAuN6BGm1r+WYBOlIYXHCkjtlw5Zen
         XkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySw1JY1pUEmGxd3VKb4dOahnkparolrY7LxLxmHjsxQ=;
        b=C5UL6bR2RzTBsvd7HQvWLSYeePnoppuqkMHsBMyj+Qc+SZB9OWBmb2TwUE7EIqNqMZ
         Doz6QByE8NYIO7OQpQvgIYDZIjOzgUEYjKA9ajliQ0A82OqXeApusTtNg7PyaM3/oC53
         qSjjiPH5v16To56rszQ41+qvnPCifLVl/AW2Wv63F6NC4ubQ4u8Zz/jhofi+9djIENkO
         z3+Iebx7z1IUtWnrs8K7a3Xxkk6jUJ1dW4K8+a+7CiFYYl8Ex9TU81vmf+1HyUU3Q/q6
         9pBkxPKuJfq8zvjCpbvl35mQ5reg6aqowTGf5xnquQujW/EZ9Jvo4IV4BEiGd+onyAU7
         lx8A==
X-Gm-Message-State: AGi0PuY0jO957xhF2y9DBdYpZ5wvb7jhPMHRZ+C6K8DCqSakQAO++vxK
        tSKdfYtO4Yz+k2MP8qi53IuMLv89eDgU7VfecpccyQ==
X-Google-Smtp-Source: APiQypKvohcP7ZVI9yC1TSomAWF3be4k8n2tkZf0ZBfetHCkCcgSQx24p/4rt/0tq616Edrtb6ONPrahLEAxtucqwl4=
X-Received: by 2002:aca:f3d6:: with SMTP id r205mr1177033oih.26.1588155589705;
 Wed, 29 Apr 2020 03:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200428180718.1609826-1-robert.foss@linaro.org>
 <20200428180718.1609826-2-robert.foss@linaro.org> <20200429090012.vhhwatojkncjquwd@gilmour.lan>
In-Reply-To: <20200429090012.vhhwatojkncjquwd@gilmour.lan>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 29 Apr 2020 12:19:38 +0200
Message-ID: <CAG3jFyvcgqi_rm-Enf3gTyHowbgX6iBe3coDPu91p9EBTxS2XA@mail.gmail.com>
Subject: Re: [PATCH v5 v5 2/3] media: ov8856: Add devicetree support
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 at 11:00, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Tue, Apr 28, 2020 at 08:07:17PM +0200, Robert Foss wrote:
> > Add match table, enable ov8856_probe() to support
> > both ACPI and DT modes.
> >
> > ACPI and DT modes are primarily distinguished from
> > each other by relying on devm_XXX_get_optional()
> > will return NULL instead of a reference for the
> > desired managed resource.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
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
> >  drivers/media/i2c/ov8856.c | 139 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 126 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> > index 8655842af275..48b02b8d205f 100644
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
> > +     ret = clk_prepare_enable(ov8856->xvclk);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "failed to enable xvclk\n");
> > +             return ret;
> > +     }
> > +
> > +     if (is_acpi_node(dev_fwnode(ov8856->dev)))
> > +             return 0;
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
> > @@ -1092,29 +1155,58 @@ static int ov8856_identify_module(struct ov8856 *ov8856)
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
> > +     if (!is_acpi_node(fwnode)) {
> > +             ov8856->xvclk = devm_clk_get(dev, "xvclk");
> > +             if (IS_ERR(ov8856->xvclk)) {
> > +                     dev_err(dev, "could not get xvclk clock (%pe)\n",
> > +                                     ov8856->xvclk);
> > +                     return PTR_ERR(ov8856->xvclk);
> > +             }
> > +
> > +             clk_set_rate(ov8856->xvclk, xvclk_rate);
> > +             xvclk_rate = clk_get_rate(ov8856->xvclk);
> > +     }
> > +
> > +     /* external clock must be 19.2MHz, allow 5% tolerance */
>
> Where is that 5% tolerance coming from? Experimentations, datasheets, something
> that looks good enough? Either way, this should be in the comment.

I don't have access to the full datasheet unfortunately. A 24Mhz rate
is as far as I understand it supported and required for higher
bandwidth count modes.
It was suggested to me that adding a tolerance is the best practice,
the ov5645 driver uses a 1% tolerance, which may be more appropriate.

The closest frequency to 19.2Mhz * 1.05 I'm able to generate is 24Mhz,
which works. But unfortunately my testing platform sdm845-db845c is
not able to generate lower frequencies than 19.2Mhz.

This all adds up to a pretty unclear picture of what is supported, if
anyone has access to the full documentation I would like to make the
tolerances and comments reflect that.

>
> Maxime
