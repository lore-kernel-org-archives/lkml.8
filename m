Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C026BC35242
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D81207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eDz6EtZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgBOAhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:37:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46534 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgBOAhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:37:07 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so10477200qkh.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 16:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNqzNsYBObkPu26R6KqP7XQHFYhpGFZJn1cuLGdWhwg=;
        b=eDz6EtZTckk2zBi7DZEvllZg04Ijo7vrgl6nuuviTrftl9c6HnXNZLIcNc1r1pGrDA
         gdGVDkDJO4NTb3y3gNM9ORlaaofxkfxMJlEjWBez3vIxrM1lYZiZsg/XhS3OjLmu0/wz
         zg9frRAmXO+ZsrCQ9OFbfvlKkxTeIGU/xnslg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNqzNsYBObkPu26R6KqP7XQHFYhpGFZJn1cuLGdWhwg=;
        b=B3eSA7dInexLXw3rC+FSmDkHpcW41I0kBNnrdr+w+ImasBrNXAiKO3x6YpEZZkLHni
         J17d+9buscNoPfM7nqWA282JEwbc/bV69GT1Hy7qwaBboBdRTPJjJ2Qx/GZoOcbIC/g8
         Azbg8UXeiyfEboy2bJfsguEwpm+F+qCZ1be71okziTwVa7cfaTcdSASL9Cx8MD9SHf9p
         6HZFFarFzUyt0mXnUdnjlSi+DOEyOVDbYnxcQ9wuNCVuqvmZxZiYETp2us9D3okLtEo1
         iU7avZY9QF/t69Gm4uj6P0haIO05DX7KbzVyyp2xmZP6peV9ngryYKevesHFBPF/tov9
         xQZA==
X-Gm-Message-State: APjAAAWYkKp2XF2VAvwa4Ourj57nay9XZGUzn1YwJ0CWNIjYcxfDHRUR
        uotVgsq8tP3G5+d35DJc3DuwL7YJXK0HbzFJoCAhAw==
X-Google-Smtp-Source: APXvYqxEsIGpb+9Jpu5RzxhbrZt0zgwIBGZIMTGHaHyJJ69QnzLiMSS95NHe3IO1I/tAkU4ZM6chBjbhKYkZAoviPWU=
X-Received: by 2002:a37:6717:: with SMTP id b23mr5207538qkc.353.1581727025976;
 Fri, 14 Feb 2020 16:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20200213145416.890080-1-enric.balletbo@collabora.com>
 <CGME20200214080840eucas1p223598941230d34cf33893c60dfa42ebc@eucas1p2.samsung.com>
 <20200213145416.890080-2-enric.balletbo@collabora.com> <6ed3c044-3573-35d4-ff17-7a40c83ac3af@samsung.com>
In-Reply-To: <6ed3c044-3573-35d4-ff17-7a40c83ac3af@samsung.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 15 Feb 2020 08:36:54 +0800
Message-ID: <CANMq1KD3Q+YqYBUtZMAz29K04MbpON0BDL3fRy5Bd4Xnnc1PBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7688: Add anx7688 bridge driver support
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, Torsten Duwe <duwe@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Collabora Kernel ML <kernel@collabora.com>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 8:18 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 13.02.2020 15:54, Enric Balletbo i Serra wrote:
> > From: Nicolas Boichat <drinkcat@chromium.org>
> >
> > ANX7688 is a HDMI to DP converter (as well as USB-C port controller),
> > that has an internal microcontroller.
> >
> > The only reason a Linux kernel driver is necessary is to reject
> > resolutions that require more bandwidth than what is available on
> > the DP side. DP bandwidth and lane count are reported by the bridge
> > via 2 registers on I2C.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> > Changes in v2:
> > - Move driver to drivers/gpu/drm/bridge/analogix.
> > - Make the driver OF only so we can reduce the ifdefs.
> > - Update the Copyright to 2020.
> > - Use probe_new so we can get rid of the i2c_device_id table.
> >
> >  drivers/gpu/drm/bridge/analogix/Kconfig       |  12 ++
> >  drivers/gpu/drm/bridge/analogix/Makefile      |   1 +
> >  .../drm/bridge/analogix/analogix-anx7688.c    | 188 ++++++++++++++++++
> >  3 files changed, 201 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx7688.c
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
> > index e1fa7d820373..af7c2939403c 100644
> > --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> > +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> > @@ -11,6 +11,18 @@ config DRM_ANALOGIX_ANX6345
> >         ANX6345 transforms the LVTTL RGB output of an
> >         application processor to eDP or DisplayPort.
> >
> > +config DRM_ANALOGIX_ANX7688
> > +     tristate "Analogix ANX7688 bridge"
> > +     depends on OF
> > +     select DRM_KMS_HELPER
> > +     select REGMAP_I2C
> > +     help
> > +       ANX7688 is an ultra-low power 4k Ultra-HD (4096x2160p60)
> > +       mobile HD transmitter designed for portable devices. The
> > +       ANX7688 converts HDMI 2.0 to DisplayPort 1.3 Ultra-HD
> > +       including an intelligent crosspoint switch to support
> > +       USB Type-C.
> > +
> >  config DRM_ANALOGIX_ANX78XX
> >       tristate "Analogix ANX78XX bridge"
> >       select DRM_ANALOGIX_DP
> > diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
> > index 97669b374098..27cd73635c8c 100644
> > --- a/drivers/gpu/drm/bridge/analogix/Makefile
> > +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o analogix-i2c-dptx.o
> >  obj-$(CONFIG_DRM_ANALOGIX_ANX6345) += analogix-anx6345.o
> > +obj-$(CONFIG_DRM_ANALOGIX_ANX7688) += analogix-anx7688.o
> >  obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
> >  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx7688.c b/drivers/gpu/drm/bridge/analogix/analogix-anx7688.c
> > new file mode 100644
> > index 000000000000..10a7cd0f9126
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx7688.c
> > @@ -0,0 +1,188 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ANX7688 HDMI->DP bridge driver
> > + *
> > + * Copyright 2020 Google LLC
> > + */
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <drm/drm_bridge.h>
> > +
> > +/* Register addresses */
> > +#define VENDOR_ID_REG 0x00
> > +#define DEVICE_ID_REG 0x02
> > +
> > +#define FW_VERSION_REG 0x80
> > +
> > +#define DP_BANDWIDTH_REG 0x85
> > +#define DP_LANE_COUNT_REG 0x86
> > +
> > +#define VENDOR_ID 0x1f29
> > +#define DEVICE_ID 0x7688
> > +
> > +/* First supported firmware version (0.85) */
> > +#define MINIMUM_FW_VERSION 0x0085
> > +
> > +struct anx7688 {
> > +     struct drm_bridge bridge;
> > +     struct i2c_client *client;
> > +     struct regmap *regmap;
> > +
> > +     bool filter;
> > +};
> > +
> > +static inline struct anx7688 *bridge_to_anx7688(struct drm_bridge *bridge)
> > +{
> > +     return container_of(bridge, struct anx7688, bridge);
> > +}
> > +
> > +static bool anx7688_bridge_mode_fixup(struct drm_bridge *bridge,
> > +                                   const struct drm_display_mode *mode,
> > +                                   struct drm_display_mode *adjusted_mode)
> > +{
> > +     struct anx7688 *anx7688 = bridge_to_anx7688(bridge);
> > +     int totalbw, requiredbw;
> > +     u8 dpbw, lanecount;
> > +     u8 regs[2];
> > +     int ret;
> > +
> > +     if (!anx7688->filter)
> > +             return true;
> > +
> > +     /* Read both regs 0x85 (bandwidth) and 0x86 (lane count). */
> > +     ret = regmap_bulk_read(anx7688->regmap, DP_BANDWIDTH_REG, regs, 2);
> > +     if (ret < 0) {
> > +             dev_err(&anx7688->client->dev,
> > +                     "Failed to read bandwidth/lane count\n");
> > +             return false;
> > +     }
> > +     dpbw = regs[0];
> > +     lanecount = regs[1];
>
>
> Are these values hw invariant? Or they are result of cable probe/training?
>
> In 1st case this code should go rather to mode_valid.
>
>
> > +
> > +     /* Maximum 0x19 bandwidth (6.75 Gbps Turbo mode), 2 lanes */
> > +     if (dpbw > 0x19 || lanecount > 2) {
> > +             dev_err(&anx7688->client->dev,
> > +                     "Invalid bandwidth/lane count (%02x/%d)\n",
> > +                     dpbw, lanecount);
> > +             return false;
> > +     }
> > +
> > +     /* Compute available bandwidth (kHz) */
> > +     totalbw = dpbw * lanecount * 270000 * 8 / 10;
> > +
> > +     /* Required bandwidth (8 bpc, kHz) */
> > +     requiredbw = mode->clock * 8 * 3;
> > +
> > +     dev_dbg(&anx7688->client->dev,
> > +             "DP bandwidth: %d kHz (%02x/%d); mode requires %d Khz\n",
> > +             totalbw, dpbw, lanecount, requiredbw);
> > +
> > +     if (totalbw == 0) {
> > +             dev_warn(&anx7688->client->dev,
> > +                      "Bandwidth/lane count are 0, not rejecting modes\n");
> > +             return true;
> > +     }
> > +
> > +     return totalbw >= requiredbw;
> > +}
> > +
> > +static const struct drm_bridge_funcs anx7688_bridge_funcs = {
> > +     .mode_fixup = anx7688_bridge_mode_fixup,
> > +};
> > +
> > +static const struct regmap_config anx7688_regmap_config = {
> > +     .reg_bits = 8,
> > +     .val_bits = 8,
> > +};
> > +
> > +static int anx7688_i2c_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev = &client->dev;
> > +     struct anx7688 *anx7688;
> > +     u16 vendor, device;
> > +     u16 fwversion;
> > +     u8 buffer[4];
> > +     int ret;
> > +
> > +     anx7688 = devm_kzalloc(dev, sizeof(*anx7688), GFP_KERNEL);
> > +     if (!anx7688)
> > +             return -ENOMEM;
> > +
> > +     anx7688->bridge.of_node = dev->of_node;
> > +     anx7688->client = client;
> > +     i2c_set_clientdata(client, anx7688);
> > +
> > +     anx7688->regmap = devm_regmap_init_i2c(client, &anx7688_regmap_config);
> > +
> > +     /* Read both vendor and device id (4 bytes). */
> > +     ret = regmap_bulk_read(anx7688->regmap, VENDOR_ID_REG, buffer, 4);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to read chip vendor/device id\n");
> > +             return ret;
> > +     }
> > +
> > +     vendor = (u16)buffer[1] << 8 | buffer[0];
> > +     device = (u16)buffer[3] << 8 | buffer[2];
>
>
> Here we have little endian, and...
>
>
> > +     if (vendor != VENDOR_ID || device != DEVICE_ID) {
> > +             dev_err(dev, "Invalid vendor/device id %04x/%04x\n",
> > +                     vendor, device);
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret = regmap_bulk_read(anx7688->regmap, FW_VERSION_REG, buffer, 2);
> > +     if (ret) {
> > +             dev_err(&client->dev, "Failed to read firmware version\n");
> > +             return ret;
> > +     }
> > +
> > +     fwversion = (u16)buffer[0] << 8 | buffer[1];
>
>
> ...here big endian.
>
> Is it correct?

(since I'm looking at the datasheet, answering that one too)

This is some kind of BCD style encoding. Bits 15..8 are the minor
version, and 7..0 are the major version.

Yes it's weird, but it seems to be the way this is ,-)

>
> Overall driver looks OK.
>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>
>  --
> Regards
> Andrzej
>
>
> > +     dev_info(dev, "ANX7688 firwmare version %02x.%02x\n",
> > +              buffer[0], buffer[1]);
> > +
> > +     /* FW version >= 0.85 supports bandwidth/lane count registers */
> > +     if (fwversion >= MINIMUM_FW_VERSION) {
> > +             anx7688->filter = true;
> > +     } else {
> > +             /* Warn, but not fail, for backwards compatibility. */
> > +             dev_warn(dev,
> > +                      "Old ANX7688 FW version (%02x.%02x), not filtering\n",
> > +                      buffer[0], buffer[1]);
> > +     }
> > +
> > +     anx7688->bridge.funcs = &anx7688_bridge_funcs;
> > +     drm_bridge_add(&anx7688->bridge);
> > +
> > +     return 0;
> > +}
> > +
> > +static int anx7688_i2c_remove(struct i2c_client *client)
> > +{
> > +     struct anx7688 *anx7688 = i2c_get_clientdata(client);
> > +
> > +     drm_bridge_remove(&anx7688->bridge);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id anx7688_match_table[] = {
> > +     { .compatible = "analogix,anx7688", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, anx7688_match_table);
> > +
> > +static struct i2c_driver anx7688_driver = {
> > +     .probe_new = anx7688_i2c_probe,
> > +     .remove = anx7688_i2c_remove,
> > +     .driver = {
> > +             .name = "anx7688",
> > +             .of_match_table = anx7688_match_table,
> > +     },
> > +};
> > +
> > +module_i2c_driver(anx7688_driver);
> > +
> > +MODULE_DESCRIPTION("ANX7688 HDMI->DP bridge driver");
> > +MODULE_AUTHOR("Nicolas Boichat <drinkcat@chromium.org>");
> > +MODULE_LICENSE("GPL");
>
>
