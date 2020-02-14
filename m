Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE0FC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831412086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="njljDdO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgBNMSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 07:18:36 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58267 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgBNMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 07:18:36 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200214121834euoutp022c1f58be5ac9399693e13047e9d7902d~zRAxisoLu0505705057euoutp02V
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:18:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200214121834euoutp022c1f58be5ac9399693e13047e9d7902d~zRAxisoLu0505705057euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581682714;
        bh=F7E70VB/G+i7JLpig6UVNpiIP4NN/tSPjPLkLfbMuH0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=njljDdO+vTaDoM2amURp57FpDPgxAn8xdGHTl3IhfLDcsXIJbjAdfdNI95pWsKRhi
         /U8sKt0MVW0hPeyyNjhPlzjnA2B2UOJkAsWN3EEDxYI9EjLPsw3hlOG7/kaXYtOPUq
         aKs5jDgkVyuZIcAZcKoe74eD3zfA/r+aLWcgCK5I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200214121833eucas1p1ab729ef345043f3d5903b188c19aaf7f~zRAxGE1d72145921459eucas1p1G;
        Fri, 14 Feb 2020 12:18:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 45.A2.60679.910964E5; Fri, 14
        Feb 2020 12:18:33 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200214121833eucas1p2b0cf96d3be1527bc5201d4c8808c4fc3~zRAwvPNlw3135031350eucas1p2J;
        Fri, 14 Feb 2020 12:18:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200214121833eusmtrp23325a7f3d654066284aaa05b67396098~zRAwuchZR0255102551eusmtrp2W;
        Fri, 14 Feb 2020 12:18:33 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-07-5e469019a24d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6F.1C.07950.910964E5; Fri, 14
        Feb 2020 12:18:33 +0000 (GMT)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200214121832eusmtip186bee3e70f5c58977f969e021ea5516f~zRAv_c3I51994819948eusmtip1Z;
        Fri, 14 Feb 2020 12:18:32 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7688: Add anx7688 bridge driver
 support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>, drinkcat@chromium.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, Torsten Duwe <duwe@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>, hsinyi@chromium.org,
        matthias.bgg@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Collabora Kernel ML <kernel@collabora.com>,
        Icenowy Zheng <icenowy@aosc.io>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <6ed3c044-3573-35d4-ff17-7a40c83ac3af@samsung.com>
Date:   Fri, 14 Feb 2020 13:18:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213145416.890080-2-enric.balletbo@collabora.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRDNt992uzQWt0XTEVBCE2OUiLd+RiWeZOMP9QckqBEtugEih+kK
        3hFEFEGwoKgUDCAoBZtgqBzFxKNGERvqBVoFrRo0QUFjKN5WaRcj/97MvJl5bzIsVh9lAtnE
        lJ2CPkWXpGUUdNOd7/enTzBExs40/wgh+Y52imTfeYdI59AnhlzqNNHEUOumiLnbhoghuxmT
        wcqXFOn62odJe38XTSyO4zJyrLBaTh63ljHk0OE55Ow3DyK2go3E0lCMl6r4qu8eiv/kzJbz
        PY77DF+a8ZDmW15UI95qfCHnS3NKZPxdwyOK/+hwyPnmL69kvCuvjeJv5J+keYt9Hz/YMGmd
        /wbF4m1CUmK6oJ8RsUWRYD5RiHY4VuzuyDcxGejq/FzEssDNhc/P1+YiBavmTAiqzFmUFLgR
        9NedwlIwiMCR9wHlIj9fx7O3tSOsGgQ3vhTTUjCA4NWbp7SXFcBFQX2WS+bF47j1UHT0M/KS
        MFdGQ6/nLvYWGG4q/LY8Y7xYyUVAZkWlbwXNTYavx5yUF4/nYuB0swdJHBW0l/T6FvhxK+Ci
        p9s3B3MhkNVYOoI18Ly33CcPuBYWuu1OmaR7JVy7dWbEQwC8b7sil3Aw/LGWUxI+CC7TYSw1
        5yBovGzFUmER9Dh+MN6T4WHV9a0zpPQyuHd9iJEu6Q/OAZWkwR+Kms5gKa2EnCNqiR0Kro7G
        kYEauPBgiDEgrXGUM+MoN8ZRboz/91Ygug5phDQxOV4QZ6cIu8JFXbKYlhIfvjU1uQENv6fd
        0+ZuQa2/4myIY5F2jNIUFhmrlunSxT3JNgQs1o5T3godTim36fbsFfSpm/VpSYJoQ0EsrdUo
        55zv26Tm4nU7he2CsEPQ/6tSrF9gBoqhp2N7X2Ke+8C6iebVEQVdmM/MrIzuKeucnKpZ2LRg
        mco5z4aXZIsdUw1Juftvpo+JttxuDt5/YvnqhMLL4r3gsVXW7lkXwwINxq20Z+aTxqApa+xh
        IZEFNbdfnwu2RtWpCjMGtS/dna41q4r6r7ZHPYg9cKQirrVW8bMpUhnEa2kxQTdrGtaLur/l
        Yup9mgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsVy+t/xu7qSE9ziDO79ZrfoPXeSyaL12DNG
        iytf37NZrL6ygsViwsovTBZrbh9itJjQup3Z4vPCe0wWV7+/ZLY4+eYqi8Xmcz2sFp0Tl7Bb
        XN41h82iqcXYYsaPf4wWh/qiLTZvmsrsIOix+Oc/Jo/3N1rZPe6cO8/mMbvhIovHjrtLGD12
        zrrL7jG7Yyarx4kJl5g83p07x+6x/dsDVo/73ceZPA70Tmbx2Hy62uPzJrkAvig9m6L80pJU
        hYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jDX9ExkLzjlXnO1d
        wdbAuNusi5GTQ0LAROLm05VMXYxcHEICSxklpmybzgaREJfYPf8tM4QtLPHnWhdYXEjgNaPE
        hQeVILawQIjE+ub7rCC2iECkxLHNC9hBBjELzGGR2LrkNitEw3lGiVN/OEBsNgFNib+bb4IN
        4hWwk2hcsJARxGYRUJX43nmDCcQWFYiQeDyxnRGiRlDi5MwnLCA2p4CzxLJ/t8EOYhZQl/gz
        7xKULS/RvHU2lC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfm
        pesl5+duYgQmi23Hfm7Zwdj1LvgQowAHoxIPr0SfW5wQa2JZcWXuIUYJDmYlEd7DikAh3pTE
        yqrUovz4otKc1OJDjKZAz01klhJNzgcmsrySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp
        2ampBalFMH1MHJxSDYyO2sXNgrnLZB1eVIl5eNQ22bUrGPa5dDw/w2E/r2DH2vK+j8U/hRqa
        Ps/zrpxk8bNlnXr9TI6Yu44WP4vVbbWONOnJv+SSfvlqiv67d6I78r4dWBS23/9FeuTz+ym3
        3k6v6RF2yHRWXfD+Z84rUzmXwOcd/E/X5Si1N7qyCXXEWrC2blwwRYmlOCPRUIu5qDgRANlg
        Ts4sAwAA
X-CMS-MailID: 20200214121833eucas1p2b0cf96d3be1527bc5201d4c8808c4fc3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200214080840eucas1p223598941230d34cf33893c60dfa42ebc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200214080840eucas1p223598941230d34cf33893c60dfa42ebc
References: <20200213145416.890080-1-enric.balletbo@collabora.com>
        <CGME20200214080840eucas1p223598941230d34cf33893c60dfa42ebc@eucas1p2.samsung.com>
        <20200213145416.890080-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2020 15:54, Enric Balletbo i Serra wrote:
> From: Nicolas Boichat <drinkcat@chromium.org>
>
> ANX7688 is a HDMI to DP converter (as well as USB-C port controller),
> that has an internal microcontroller.
>
> The only reason a Linux kernel driver is necessary is to reject
> resolutions that require more bandwidth than what is available on
> the DP side. DP bandwidth and lane count are reported by the bridge
> via 2 registers on I2C.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v2:
> - Move driver to drivers/gpu/drm/bridge/analogix.
> - Make the driver OF only so we can reduce the ifdefs.
> - Update the Copyright to 2020.
> - Use probe_new so we can get rid of the i2c_device_id table.
>
>  drivers/gpu/drm/bridge/analogix/Kconfig       |  12 ++
>  drivers/gpu/drm/bridge/analogix/Makefile      |   1 +
>  .../drm/bridge/analogix/analogix-anx7688.c    | 188 ++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx7688.c
>
> diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
> index e1fa7d820373..af7c2939403c 100644
> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -11,6 +11,18 @@ config DRM_ANALOGIX_ANX6345
>  	  ANX6345 transforms the LVTTL RGB output of an
>  	  application processor to eDP or DisplayPort.
>  
> +config DRM_ANALOGIX_ANX7688
> +	tristate "Analogix ANX7688 bridge"
> +	depends on OF
> +	select DRM_KMS_HELPER
> +	select REGMAP_I2C
> +	help
> +	  ANX7688 is an ultra-low power 4k Ultra-HD (4096x2160p60)
> +	  mobile HD transmitter designed for portable devices. The
> +	  ANX7688 converts HDMI 2.0 to DisplayPort 1.3 Ultra-HD
> +	  including an intelligent crosspoint switch to support
> +	  USB Type-C.
> +
>  config DRM_ANALOGIX_ANX78XX
>  	tristate "Analogix ANX78XX bridge"
>  	select DRM_ANALOGIX_DP
> diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
> index 97669b374098..27cd73635c8c 100644
> --- a/drivers/gpu/drm/bridge/analogix/Makefile
> +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o analogix-i2c-dptx.o
>  obj-$(CONFIG_DRM_ANALOGIX_ANX6345) += analogix-anx6345.o
> +obj-$(CONFIG_DRM_ANALOGIX_ANX7688) += analogix-anx7688.o
>  obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx7688.c b/drivers/gpu/drm/bridge/analogix/analogix-anx7688.c
> new file mode 100644
> index 000000000000..10a7cd0f9126
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx7688.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ANX7688 HDMI->DP bridge driver
> + *
> + * Copyright 2020 Google LLC
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <drm/drm_bridge.h>
> +
> +/* Register addresses */
> +#define VENDOR_ID_REG 0x00
> +#define DEVICE_ID_REG 0x02
> +
> +#define FW_VERSION_REG 0x80
> +
> +#define DP_BANDWIDTH_REG 0x85
> +#define DP_LANE_COUNT_REG 0x86
> +
> +#define VENDOR_ID 0x1f29
> +#define DEVICE_ID 0x7688
> +
> +/* First supported firmware version (0.85) */
> +#define MINIMUM_FW_VERSION 0x0085
> +
> +struct anx7688 {
> +	struct drm_bridge bridge;
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +
> +	bool filter;
> +};
> +
> +static inline struct anx7688 *bridge_to_anx7688(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct anx7688, bridge);
> +}
> +
> +static bool anx7688_bridge_mode_fixup(struct drm_bridge *bridge,
> +				      const struct drm_display_mode *mode,
> +				      struct drm_display_mode *adjusted_mode)
> +{
> +	struct anx7688 *anx7688 = bridge_to_anx7688(bridge);
> +	int totalbw, requiredbw;
> +	u8 dpbw, lanecount;
> +	u8 regs[2];
> +	int ret;
> +
> +	if (!anx7688->filter)
> +		return true;
> +
> +	/* Read both regs 0x85 (bandwidth) and 0x86 (lane count). */
> +	ret = regmap_bulk_read(anx7688->regmap, DP_BANDWIDTH_REG, regs, 2);
> +	if (ret < 0) {
> +		dev_err(&anx7688->client->dev,
> +			"Failed to read bandwidth/lane count\n");
> +		return false;
> +	}
> +	dpbw = regs[0];
> +	lanecount = regs[1];


Are these values hw invariant? Or they are result of cable probe/training?

In 1st case this code should go rather to mode_valid.


> +
> +	/* Maximum 0x19 bandwidth (6.75 Gbps Turbo mode), 2 lanes */
> +	if (dpbw > 0x19 || lanecount > 2) {
> +		dev_err(&anx7688->client->dev,
> +			"Invalid bandwidth/lane count (%02x/%d)\n",
> +			dpbw, lanecount);
> +		return false;
> +	}
> +
> +	/* Compute available bandwidth (kHz) */
> +	totalbw = dpbw * lanecount * 270000 * 8 / 10;
> +
> +	/* Required bandwidth (8 bpc, kHz) */
> +	requiredbw = mode->clock * 8 * 3;
> +
> +	dev_dbg(&anx7688->client->dev,
> +		"DP bandwidth: %d kHz (%02x/%d); mode requires %d Khz\n",
> +		totalbw, dpbw, lanecount, requiredbw);
> +
> +	if (totalbw == 0) {
> +		dev_warn(&anx7688->client->dev,
> +			 "Bandwidth/lane count are 0, not rejecting modes\n");
> +		return true;
> +	}
> +
> +	return totalbw >= requiredbw;
> +}
> +
> +static const struct drm_bridge_funcs anx7688_bridge_funcs = {
> +	.mode_fixup = anx7688_bridge_mode_fixup,
> +};
> +
> +static const struct regmap_config anx7688_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int anx7688_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct anx7688 *anx7688;
> +	u16 vendor, device;
> +	u16 fwversion;
> +	u8 buffer[4];
> +	int ret;
> +
> +	anx7688 = devm_kzalloc(dev, sizeof(*anx7688), GFP_KERNEL);
> +	if (!anx7688)
> +		return -ENOMEM;
> +
> +	anx7688->bridge.of_node = dev->of_node;
> +	anx7688->client = client;
> +	i2c_set_clientdata(client, anx7688);
> +
> +	anx7688->regmap = devm_regmap_init_i2c(client, &anx7688_regmap_config);
> +
> +	/* Read both vendor and device id (4 bytes). */
> +	ret = regmap_bulk_read(anx7688->regmap, VENDOR_ID_REG, buffer, 4);
> +	if (ret) {
> +		dev_err(dev, "Failed to read chip vendor/device id\n");
> +		return ret;
> +	}
> +
> +	vendor = (u16)buffer[1] << 8 | buffer[0];
> +	device = (u16)buffer[3] << 8 | buffer[2];


Here we have little endian, and...


> +	if (vendor != VENDOR_ID || device != DEVICE_ID) {
> +		dev_err(dev, "Invalid vendor/device id %04x/%04x\n",
> +			vendor, device);
> +		return -ENODEV;
> +	}
> +
> +	ret = regmap_bulk_read(anx7688->regmap, FW_VERSION_REG, buffer, 2);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to read firmware version\n");
> +		return ret;
> +	}
> +
> +	fwversion = (u16)buffer[0] << 8 | buffer[1];


...here big endian.

Is it correct?


Overall driver looks OK.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


> +	dev_info(dev, "ANX7688 firwmare version %02x.%02x\n",
> +		 buffer[0], buffer[1]);
> +
> +	/* FW version >= 0.85 supports bandwidth/lane count registers */
> +	if (fwversion >= MINIMUM_FW_VERSION) {
> +		anx7688->filter = true;
> +	} else {
> +		/* Warn, but not fail, for backwards compatibility. */
> +		dev_warn(dev,
> +			 "Old ANX7688 FW version (%02x.%02x), not filtering\n",
> +			 buffer[0], buffer[1]);
> +	}
> +
> +	anx7688->bridge.funcs = &anx7688_bridge_funcs;
> +	drm_bridge_add(&anx7688->bridge);
> +
> +	return 0;
> +}
> +
> +static int anx7688_i2c_remove(struct i2c_client *client)
> +{
> +	struct anx7688 *anx7688 = i2c_get_clientdata(client);
> +
> +	drm_bridge_remove(&anx7688->bridge);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id anx7688_match_table[] = {
> +	{ .compatible = "analogix,anx7688", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, anx7688_match_table);
> +
> +static struct i2c_driver anx7688_driver = {
> +	.probe_new = anx7688_i2c_probe,
> +	.remove = anx7688_i2c_remove,
> +	.driver = {
> +		.name = "anx7688",
> +		.of_match_table = anx7688_match_table,
> +	},
> +};
> +
> +module_i2c_driver(anx7688_driver);
> +
> +MODULE_DESCRIPTION("ANX7688 HDMI->DP bridge driver");
> +MODULE_AUTHOR("Nicolas Boichat <drinkcat@chromium.org>");
> +MODULE_LICENSE("GPL");


