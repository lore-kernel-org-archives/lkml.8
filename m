Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1246DC38A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D883320784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X989IdLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410982AbgDOR0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410972AbgDOR0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:26:15 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C8CC061A0C;
        Wed, 15 Apr 2020 10:26:15 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c63so18171966qke.2;
        Wed, 15 Apr 2020 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1gTjhp6jB669sanSP3EkZI1VEjL3ZRaLoaZHBI+be1Q=;
        b=X989IdLZ4FvwYWxriM67dgE8sWP5g+L3Mx8YfB/AbsMGdhmfZAs8cWkcziJ6DWrc8D
         0bmsVDL9vZCuRTuXgGbJAJGQ3EL6EqYV3olDRPY9XO5sysMyH8fZSruZ9sVmy7CNCEMj
         MDv3oqup6j40/asoHudfrWeBdG8FLh4V/Uxza16BznkyhHE7w45W/aDPcqYd92jU1YEv
         sNV4CoadTMFq02JDFJQImZYVPcaLtu99XRCoNDT1Y4YJraqUr4AAKLHg0LlIp3/H45rE
         52wD+d4WmR+PJwmbMy6IH7UKhC/eM5bt1MvY7xyW2pbb3amkAx3Z58/ukdCfsYenW4s5
         hzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1gTjhp6jB669sanSP3EkZI1VEjL3ZRaLoaZHBI+be1Q=;
        b=X2aWW2JkgsevBPEG74jkB7WC2BhQ/d1RCXwQMZmjOtcK9lmwxkV/DnfNFO4Si9fvlP
         VZuxg+0VKLdrMXW+Pk4IxaK9mNuweDsgh2OfXTJnw0fYhAiaFk1E+lgKFDwiGNUpReqo
         bLU8A3cAe4jSqliFfhulLpARqNqabe1K0rrqirDUMhx2ehlUqDIJVDQX8g9a6Rlg617f
         JJsE8hPnPYmP7fHMIBbJqxPXgnKVdit7iETwS2Ff9b5KDudZuh6g0ki2rKEDHLk2wNbM
         7ZyhT6dBRPaXz0r3NFwhf2SZT0ok1BOqNe2dmhEvJQwS4hTy/LHz3zUzVs7EqX00RA38
         OTXg==
X-Gm-Message-State: AGi0PuZUOspkNWhiDzvvcMLfbJlftUUz5PtOH3GNq+VoAQP9F4dqfkkA
        P41Q0w6dME7NInGqNihVWOv21A6iAcXyCyVnFQLaGpNEdXt8tw==
X-Google-Smtp-Source: APiQypIeR3SIWBiXtjK1sxoe8Am6f/Mkt17HkM2SKMQO+CtMe2dlJ+X6m8nHvnwEX8fSJXc2oW9zeYFUekOQqVuZ6UM=
X-Received: by 2002:a37:68c5:: with SMTP id d188mr26286333qkc.85.1586971574525;
 Wed, 15 Apr 2020 10:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200414151955.311949-1-adrian.ratiu@collabora.com> <20200414151955.311949-5-adrian.ratiu@collabora.com>
In-Reply-To: <20200414151955.311949-5-adrian.ratiu@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 15 Apr 2020 19:26:02 +0200
Message-ID: <CAFqH_51ZZTd6iK+G1QdqfBedxyG-A=HwPjY1kdOuWTqd7niTHQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] drm: imx: Add i.MX 6 MIPI DSI host platform driver
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Martyn Welch <martyn.welch@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Thank you for your patch.

Missatge de Adrian Ratiu <adrian.ratiu@collabora.com> del dia dt., 14
d=E2=80=99abr. 2020 a les 17:19:
>
> This adds support for the Synopsis DesignWare MIPI DSI v1.01 host
> controller which is embedded in i.MX 6 SoCs.
>
> Based on following patches, but updated/extended to work with existing
> support found in the kernel:
>
> - drm: imx: Support Synopsys DesignWare MIPI DSI host controller
>   Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>
> Cc: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> Tested-by: Adrian Pop <pop.adrian61@gmail.com>
> Tested-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Changes since v5:
>   - Reword to remove unrelated device tree patch mention (Fabio)
>   - Move pllref_clk enable/disable to bind/unbind (Ezequiel)
>   - Fix freescale.com -> nxp.com email addresses (Fabio)
>   - Also added myself as module author (Fabio)
>   - Use DRM_DEV_* macros for consistency, print more error msg
>
> Changes since v4:
>   - Split off driver-specific configuration of phy timings due
>   to new upstream API.
>   - Move regmap infrastructure logic to separate commit (Ezequiel)
>   - Move dsi v1.01 layout addition to a separate commit (Ezequiel)
>   - Minor warnings and driver name fixes
>
> Changes since v3:
>   - Renamed platform driver to reflect it's i.MX6 only. (Fabio)
>
> Changes since v2:
>   - Fixed commit tags. (Emil)
>
> Changes since v1:
>   - Moved register definitions & regmap initialization into bridge
>   module. Platform drivers get the regmap via plat_data after
>   calling the bridge probe. (Emil)
> ---
>  drivers/gpu/drm/imx/Kconfig            |   7 +
>  drivers/gpu/drm/imx/Makefile           |   1 +
>  drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c | 409 +++++++++++++++++++++++++
>  3 files changed, 417 insertions(+)
>  create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c
>
> diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
> index 207bf7409dfb..b49e70e7f0fd 100644
> --- a/drivers/gpu/drm/imx/Kconfig
> +++ b/drivers/gpu/drm/imx/Kconfig
> @@ -39,3 +39,10 @@ config DRM_IMX_HDMI
>         depends on DRM_IMX
>         help
>           Choose this if you want to use HDMI on i.MX6.
> +
> +config DRM_IMX6_MIPI_DSI
> +       tristate "Freescale i.MX6 DRM MIPI DSI"
> +       select DRM_DW_MIPI_DSI
> +       depends on DRM_IMX

Should it depend on CONFIG_OF too? I suspect you'll get build errors
if OF is not selected

> +       help
> +         Choose this if you want to use MIPI DSI on i.MX6.
> diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
> index 21cdcc2faabc..9a7843c59347 100644
> --- a/drivers/gpu/drm/imx/Makefile
> +++ b/drivers/gpu/drm/imx/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_DRM_IMX_TVE) +=3D imx-tve.o
>  obj-$(CONFIG_DRM_IMX_LDB) +=3D imx-ldb.o
>
>  obj-$(CONFIG_DRM_IMX_HDMI) +=3D dw_hdmi-imx.o
> +obj-$(CONFIG_DRM_IMX6_MIPI_DSI) +=3D dw_mipi_dsi-imx6.o
> diff --git a/drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c b/drivers/gpu/drm/imx=
/dw_mipi_dsi-imx6.c
> new file mode 100644
> index 000000000000..6914db8ce8cb
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * i.MX6 drm driver - MIPI DSI Host Controller
> + *
> + * Copyright (C) 2011-2015 Freescale Semiconductor, Inc.
> + * Copyright (C) 2019-2020 Collabora, Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/videodev2.h>
> +#include <drm/bridge/dw_mipi_dsi.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_print.h>
> +
> +#include "imx-drm.h"
> +
> +#define DSI_PWR_UP                     0x04
> +#define RESET                          0
> +#define POWERUP                                BIT(0)
> +
> +#define DSI_PHY_IF_CTRL                        0x5c
> +#define PHY_IF_CTRL_RESET              0x0
> +
> +#define DSI_PHY_TST_CTRL0              0x64
> +#define PHY_TESTCLK                    BIT(1)
> +#define PHY_UNTESTCLK                  0
> +#define PHY_TESTCLR                    BIT(0)
> +#define PHY_UNTESTCLR                  0
> +
> +#define DSI_PHY_TST_CTRL1              0x68
> +#define PHY_TESTEN                     BIT(16)
> +#define PHY_UNTESTEN                   0
> +#define PHY_TESTDOUT(n)                        (((n) & 0xff) << 8)
> +#define PHY_TESTDIN(n)                 (((n) & 0xff) << 0)
> +
> +struct imx_mipi_dsi {
> +       struct drm_encoder encoder;
> +       struct device *dev;
> +       struct regmap *mux_sel;
> +       struct dw_mipi_dsi *mipi_dsi;
> +       struct clk *pllref_clk;
> +
> +       void __iomem *base;
> +       unsigned int lane_mbps;
> +};
> +
> +struct dphy_pll_testdin_map {
> +       unsigned int max_mbps;
> +       u8 testdin;
> +};
> +
> +/* The table is based on 27MHz DPHY pll reference clock. */
> +static const struct dphy_pll_testdin_map dptdin_map[] =3D {
> +       {160, 0x04}, {180, 0x24}, {200, 0x44}, {210, 0x06},
> +       {240, 0x26}, {250, 0x46}, {270, 0x08}, {300, 0x28},
> +       {330, 0x48}, {360, 0x2a}, {400, 0x4a}, {450, 0x0c},
> +       {500, 0x2c}, {550, 0x0e}, {600, 0x2e}, {650, 0x10},
> +       {700, 0x30}, {750, 0x12}, {800, 0x32}, {850, 0x14},
> +       {900, 0x34}, {950, 0x54}, {1000, 0x74}
> +};
> +
> +static inline struct imx_mipi_dsi *enc_to_dsi(struct drm_encoder *enc)
> +{
> +       return container_of(enc, struct imx_mipi_dsi, encoder);
> +}
> +
> +static void imx_mipi_dsi_set_ipu_di_mux(struct imx_mipi_dsi *dsi, int ip=
u_di)
> +{
> +       regmap_update_bits(dsi->mux_sel, IOMUXC_GPR3,
> +                          IMX6Q_GPR3_MIPI_MUX_CTL_MASK,
> +                          ipu_di << IMX6Q_GPR3_MIPI_MUX_CTL_SHIFT);
> +}
> +
> +static const struct drm_encoder_funcs imx_mipi_dsi_encoder_funcs =3D {
> +       .destroy =3D imx_drm_encoder_destroy,
> +};
> +
> +static bool imx_mipi_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
> +                                           const struct drm_display_mode=
 *mode,
> +                                           struct drm_display_mode *adj_=
mode)
> +{
> +       return true;
> +}
> +
> +static int imx_mipi_dsi_encoder_atomic_check(struct drm_encoder *encoder=
,
> +                                            struct drm_crtc_state *crtc_=
state,
> +                                            struct drm_connector_state *=
conn)
> +{
> +       struct imx_crtc_state *imx_crtc_state =3D to_imx_crtc_state(crtc_=
state);
> +
> +       /* The following values are taken from dw_hdmi_imx_atomic_check *=
/
> +       imx_crtc_state->bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
> +       imx_crtc_state->di_hsync_pin =3D 2;
> +       imx_crtc_state->di_vsync_pin =3D 3;
> +
> +       return 0;
> +}
> +
> +static void imx_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
> +{
> +       struct imx_mipi_dsi *dsi =3D enc_to_dsi(encoder);
> +       int mux =3D drm_of_encoder_active_port_id(dsi->dev->of_node, enco=
der);
> +
> +       imx_mipi_dsi_set_ipu_di_mux(dsi, mux);
> +}
> +
> +static void imx_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
> +{
> +}
> +
> +static const struct drm_encoder_helper_funcs imx_mipi_dsi_encoder_helper=
s =3D {

AFAIK (or at least this is the feedback I received) drm_encoder is
kind of deprecated, and nowadays all is migrated to drm_bridge
(encoders, bridges and panels). Of course, a drm_encoder is needed, as
the DRM core expects one, but should just be a dummy object that you
can probably create with just calling  drm_simple_encoder_init(). DRM
maintainers, please shout if I am wrong.

> +       .mode_fixup =3D imx_mipi_dsi_encoder_mode_fixup,
> +       .commit =3D imx_mipi_dsi_encoder_commit,
> +       .disable =3D imx_mipi_dsi_encoder_disable,
> +       .atomic_check =3D imx_mipi_dsi_encoder_atomic_check,
> +};
> +
> +static int imx_mipi_dsi_register(struct drm_device *drm,
> +                                struct imx_mipi_dsi *dsi)
> +{
> +       int ret;
> +
> +       ret =3D imx_drm_encoder_parse_of(drm, &dsi->encoder, dsi->dev->of=
_node);
> +       if (ret)
> +               return ret;
> +
> +       drm_encoder_helper_add(&dsi->encoder,
> +                              &imx_mipi_dsi_encoder_helpers);
> +       drm_encoder_init(drm, &dsi->encoder, &imx_mipi_dsi_encoder_funcs,
> +                        DRM_MODE_ENCODER_DSI, NULL);
> +       return 0;
> +}
> +
> +static enum drm_mode_status imx_mipi_dsi_mode_valid(void *priv_data,
> +                                       const struct drm_display_mode *mo=
de)
> +{
> +       /*
> +        * The VID_PKT_SIZE field in the DSI_VID_PKT_CFG
> +        * register is 11-bit.
> +        */
> +       if (mode->hdisplay > 0x7ff)
> +               return MODE_BAD_HVALUE;
> +
> +       /*
> +        * The V_ACTIVE_LINES field in the DSI_VTIMING_CFG
> +        * register is 11-bit.
> +        */
> +       if (mode->vdisplay > 0x7ff)
> +               return MODE_BAD_VVALUE;
> +
> +       return MODE_OK;
> +}
> +
> +
> +static unsigned int max_mbps_to_testdin(unsigned int max_mbps)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(dptdin_map); i++)
> +               if (dptdin_map[i].max_mbps =3D=3D max_mbps)
> +                       return dptdin_map[i].testdin;
> +
> +       return -EINVAL;
> +}
> +
> +static inline void dsi_write(struct imx_mipi_dsi *dsi, u32 reg, u32 val)
> +{
> +       writel(val, dsi->base + reg);
> +}
> +
> +static int imx_mipi_dsi_phy_init(void *priv_data)
> +{
> +       struct imx_mipi_dsi *dsi =3D priv_data;
> +       int testdin;
> +
> +       testdin =3D max_mbps_to_testdin(dsi->lane_mbps);
> +       if (testdin < 0) {
> +               DRM_DEV_ERROR(dsi->dev,
> +                             "failed to get testdin for %dmbps lane cloc=
k\n",
> +                             dsi->lane_mbps);
> +               return testdin;
> +       }
> +
> +       dsi_write(dsi, DSI_PHY_IF_CTRL, PHY_IF_CTRL_RESET);
> +       dsi_write(dsi, DSI_PWR_UP, POWERUP);
> +
> +       dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLK | PHY_UNTESTCLR);
> +       dsi_write(dsi, DSI_PHY_TST_CTRL1, PHY_TESTEN | PHY_TESTDOUT(0) |
> +                 PHY_TESTDIN(0x44));
> +       dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLK | PHY_UNTESTCLR);
> +       dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLK | PHY_UNTESTCLR);
> +       dsi_write(dsi, DSI_PHY_TST_CTRL1, PHY_UNTESTEN | PHY_TESTDOUT(0) =
|
> +                 PHY_TESTDIN(testdin));
> +       dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLK | PHY_UNTESTCLR);
> +       dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLK | PHY_UNTESTCLR);
> +
> +       return 0;
> +}
> +
> +static int imx_mipi_dsi_get_lane_mbps(void *priv_data,
> +                                     const struct drm_display_mode *mode=
,
> +                                     unsigned long mode_flags, u32 lanes=
,
> +                                     u32 format, unsigned int *lane_mbps=
)
> +{
> +       struct imx_mipi_dsi *dsi =3D priv_data;
> +       int bpp;
> +       unsigned int i, target_mbps, mpclk;
> +       unsigned long pllref;
> +
> +       bpp =3D mipi_dsi_pixel_format_to_bpp(format);
> +       if (bpp < 0) {
> +               DRM_DEV_ERROR(dsi->dev, "failed to get bpp for format %d:=
 %d\n",
> +                             format, bpp);
> +               return bpp;
> +       }
> +
> +       pllref =3D clk_get_rate(dsi->pllref_clk);
> +       if (pllref !=3D 27000000)
> +               DRM_WARN("DSI pllref_clk not set to 27Mhz\n");
> +
> +       mpclk =3D DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
> +       if (mpclk) {
> +               /* take 1/0.7 blanking overhead into consideration */
> +               target_mbps =3D (mpclk * (bpp / lanes) * 10) / 7;
> +       } else {
> +               DRM_DEV_ERROR(dsi->dev, "use default 1Gbps DPHY pll clock=
\n");
> +               target_mbps =3D 1000;
> +       }
> +
> +       DRM_DEV_DEBUG(dsi->dev, "target pllref_clk frequency is %uMbps\n"=
,
> +                     target_mbps);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(dptdin_map); i++) {
> +               if (target_mbps < dptdin_map[i].max_mbps) {
> +                       *lane_mbps =3D dptdin_map[i].max_mbps;
> +                       dsi->lane_mbps =3D *lane_mbps;
> +                       DRM_DEV_DEBUG(dsi->dev,
> +                                     "real pllref_clk frequency is %uMbp=
s\n",
> +                                     *lane_mbps);
> +                       return 0;
> +               }
> +       }
> +
> +       DRM_DEV_ERROR(dsi->dev, "DPHY clock frequency %uMbps is out of ra=
nge\n",
> +                     target_mbps);
> +
> +       return -EINVAL;
> +}
> +
> +static int
> +dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
> +                          struct dw_mipi_dsi_dphy_timing *timing)
> +{
> +       timing->clk_hs2lp =3D 0x40;
> +       timing->clk_lp2hs =3D 0x40;
> +       timing->data_hs2lp =3D 0x40;
> +       timing->data_lp2hs =3D 0x40;
> +
> +       return 0;
> +}
> +
> +static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_imx6_phy_ops =3D {
> +       .init =3D imx_mipi_dsi_phy_init,
> +       .get_lane_mbps =3D imx_mipi_dsi_get_lane_mbps,
> +       .get_timing =3D dw_mipi_dsi_phy_get_timing,
> +};
> +
> +static struct dw_mipi_dsi_plat_data imx6q_mipi_dsi_drv_data =3D {
> +       .max_data_lanes =3D 2,
> +       .mode_valid =3D imx_mipi_dsi_mode_valid,
> +       .phy_ops =3D &dw_mipi_dsi_imx6_phy_ops,
> +};
> +
> +static const struct of_device_id imx_dsi_dt_ids[] =3D {
> +       {
> +               .compatible =3D "fsl,imx6q-mipi-dsi",
> +               .data =3D &imx6q_mipi_dsi_drv_data,
> +       },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_dsi_dt_ids);
> +
> +static int imx_mipi_dsi_bind(struct device *dev, struct device *master,
> +                            void *data)
> +{
> +       struct imx_mipi_dsi *dsi =3D dev_get_drvdata(dev);
> +       struct drm_device *drm =3D data;
> +       int ret;
> +
> +       ret =3D clk_prepare_enable(dsi->pllref_clk);
> +       if (ret) {
> +               DRM_DEV_ERROR(dev, "Failed to enable pllref_clk: %d\n", r=
et);
> +               return ret;
> +       }
> +
> +       ret =3D imx_mipi_dsi_register(drm, dsi);
> +       if (ret) {
> +               DRM_DEV_ERROR(dev, "Failed to register: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D dw_mipi_dsi_bind(dsi->mipi_dsi, &dsi->encoder);
> +       if (ret) {
> +               DRM_DEV_ERROR(dev, "Failed to bind: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void imx_mipi_dsi_unbind(struct device *dev, struct device *maste=
r,
> +                               void *data)
> +{
> +       struct imx_mipi_dsi *dsi =3D dev_get_drvdata(dev);
> +
> +       dw_mipi_dsi_unbind(dsi->mipi_dsi);
> +
> +       clk_disable_unprepare(dsi->pllref_clk);
> +}
> +
> +static const struct component_ops imx_mipi_dsi_ops =3D {
> +       .bind   =3D imx_mipi_dsi_bind,
> +       .unbind =3D imx_mipi_dsi_unbind,
> +};
> +
> +static int imx_mipi_dsi_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       const struct of_device_id *of_id =3D of_match_device(imx_dsi_dt_i=
ds, dev);
> +       struct dw_mipi_dsi_plat_data *pdata =3D (struct dw_mipi_dsi_plat_=
data *) of_id->data;
> +       struct imx_mipi_dsi *dsi;
> +       struct resource *res;
> +       int ret;
> +
> +       dsi =3D devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
> +       if (!dsi)
> +               return -ENOMEM;
> +
> +       dsi->dev =3D dev;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       dsi->base =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(dsi->base)) {
> +               ret =3D PTR_ERR(dsi->base);
> +               DRM_DEV_ERROR(dev, "Unable to get dsi registers: %d\n", r=
et);
> +               return ret;
> +       }
> +
> +       dsi->pllref_clk =3D devm_clk_get(dev, "ref");
> +       if (IS_ERR(dsi->pllref_clk)) {
> +               ret =3D PTR_ERR(dsi->pllref_clk);
> +               DRM_DEV_ERROR(dev, "Unable to get pllref_clk: %d\n", ret)=
;
> +               return ret;
> +       }
> +
> +       dsi->mux_sel =3D syscon_regmap_lookup_by_phandle(dev->of_node, "f=
sl,gpr");
> +       if (IS_ERR(dsi->mux_sel)) {
> +               ret =3D PTR_ERR(dsi->mux_sel);
> +               DRM_DEV_ERROR(dev, "Failed to get GPR regmap: %d\n", ret)=
;
> +               return ret;
> +       }
> +
> +       dev_set_drvdata(dev, dsi);
> +
> +       imx6q_mipi_dsi_drv_data.base =3D dsi->base;
> +       imx6q_mipi_dsi_drv_data.priv_data =3D dsi;
> +
> +       dsi->mipi_dsi =3D dw_mipi_dsi_probe(pdev, pdata);
> +       if (IS_ERR(dsi->mipi_dsi)) {
> +               ret =3D PTR_ERR(dsi->mipi_dsi);
> +               DRM_DEV_ERROR(dev, "Failed to probe DW DSI host: %d\n", r=
et);
> +               goto err_clkdisable;
> +       }
> +
> +       return component_add(&pdev->dev, &imx_mipi_dsi_ops);
> +
> +err_clkdisable:
> +       clk_disable_unprepare(dsi->pllref_clk);
> +       return ret;
> +}
> +
> +static int imx_mipi_dsi_remove(struct platform_device *pdev)
> +{
> +       component_del(&pdev->dev, &imx_mipi_dsi_ops);
> +       return 0;
> +}
> +
> +static struct platform_driver imx_mipi_dsi_driver =3D {
> +       .probe          =3D imx_mipi_dsi_probe,
> +       .remove         =3D imx_mipi_dsi_remove,
> +       .driver         =3D {
> +               .of_match_table =3D imx_dsi_dt_ids,
> +               .name   =3D "dw-mipi-dsi-imx6",
> +       },
> +};
> +module_platform_driver(imx_mipi_dsi_driver);
> +
> +MODULE_DESCRIPTION("i.MX6 MIPI DSI host controller driver");
> +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
> +MODULE_AUTHOR("Adrian Ratiu <adrian.ratiu@collabora.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.26.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
