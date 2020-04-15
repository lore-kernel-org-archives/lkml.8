Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9F9C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54026208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlQG9cCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414940AbgDOPxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1414921AbgDOPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:53:34 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4BCC061A0C;
        Wed, 15 Apr 2020 08:53:34 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id da9so281796qvb.3;
        Wed, 15 Apr 2020 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fgMvpPCQJWFCosyE7dZRbMhEbQ67Lc7QAxyc+/m5qdY=;
        b=VlQG9cCtz6EXkYbq2dBLs+dgaDVmuO94Gj59uScBaYRtMGr5sGV2vGbygVtLMH6n8d
         arPfw2cWby5Ve+F4tL7gxyMrbqlp+yoQyHy0jTOs4TL8Cxuvpqldr1IrVLkV7fFI0vy7
         0jUaSi12XleYxSJYFzZobXnHQyxPu8IBt4R4Eo07YcRJhxOts7WxOiPtsBdRFUmNYPj9
         iVu7CvY03PtmN4MbKk851Br/SGy8vhSXm5uDCzPDJI4YkiDI/gtdbSRARbPxDNu95YyA
         H6c5kvjj10btqP655/Y7pRy94EYteLQX2AfjB5PcprqBKMRyXTuDAumFDxfhB+WqEZlI
         matg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fgMvpPCQJWFCosyE7dZRbMhEbQ67Lc7QAxyc+/m5qdY=;
        b=ow7BIqNaBqmBBsJ/uFsCn2tlLW9aK28sr4yal+8f1RRNFLNprIFm9UDMe8hf9AoeTO
         mW1QChGQcKFJmD+poysr+qCOuk2QGPSmzAp6kERRcOuujqoQ3EyKD0hNaK32C6Z4IVLH
         Vh2/QRhftquhSfdrSX+rGzpBJzb8amJGX2yPcvo9Y55LZoIB4L44MhJ3k90/JFOlny7T
         jLicu6WgW9NFF/W5nFRnMvleKvgXKDu6L4+1USlnngLy9eVr4nSeuzcaiLxUa4Is1p3H
         bIO4Yr49fXLcffZdyZl5eiJYrAhgC5JeOvfQgSKbYiKsSRO7Ipz80+BwTtwkJ9s1rBGa
         G6XQ==
X-Gm-Message-State: AGi0PubfOR4NqCmLmrj/zBiYq8q2deH+U2lEgI4dSskdfsXdohCfFVc0
        C4WURSHxwjGxx+utThNd+Fj+5wk9N7D8ixC02kJHk0pV
X-Google-Smtp-Source: APiQypLYNSAsouX1ooyiUh71xZmQBD0ngaPXDC3Is79NyyLy7NbA/Z9439MDOkUeQwjgEdx1/+UuYAVhywTMmH0NWwU=
X-Received: by 2002:a0c:f748:: with SMTP id e8mr5544910qvo.237.1586966013181;
 Wed, 15 Apr 2020 08:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200414151955.311949-1-adrian.ratiu@collabora.com> <20200414151955.311949-2-adrian.ratiu@collabora.com>
In-Reply-To: <20200414151955.311949-2-adrian.ratiu@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 15 Apr 2020 17:53:22 +0200
Message-ID: <CAFqH_52eKB4jtmn5e4HQubv8ijOPqDqncp1dRGahhU3NOorJMQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] drm: bridge: dw_mipi_dsi: add initial regmap infrastructure
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
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

Some few comments/nits below,

Missatge de Adrian Ratiu <adrian.ratiu@collabora.com> del dia dt., 14
d=E2=80=99abr. 2020 a les 17:19:
>
> In order to support multiple versions of the Synopsis MIPI DSI host
> controller, which have different register layouts but almost identical
> HW protocols, we add a regmap infrastructure which can abstract away
> register accesses for platform drivers using the bridge.
>
> The controller HW revision is detected during bridge probe which will
> be used in future commits to load the relevant register layout which
> the bridge will use transparently to the platform drivers.
>
> Suggested-by: Ezequiel Garcia <ezequiel@collabora.com>
> Tested-by: Adrian Pop <pop.adrian61@gmail.com>
> Tested-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> New in v5.
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 208 ++++++++++--------
>  1 file changed, 117 insertions(+), 91 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/=
drm/bridge/synopsys/dw-mipi-dsi.c
> index 5ef0f154aa7b..6d9e2f21c9cc 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>

Should Kconfig select REGMAP for this driver?

>  #include <linux/reset.h>
>
>  #include <video/mipi_display.h>
> @@ -227,6 +228,7 @@ struct dw_mipi_dsi {
>         struct drm_bridge *panel_bridge;
>         struct device *dev;
>         void __iomem *base;
> +       struct regmap *regs;
>
>         struct clk *pclk;
>
> @@ -235,6 +237,7 @@ struct dw_mipi_dsi {
>         u32 lanes;
>         u32 format;
>         unsigned long mode_flags;
> +       u32 hw_version;
>
>  #ifdef CONFIG_DEBUG_FS
>         struct dentry *debugfs;
> @@ -249,6 +252,13 @@ struct dw_mipi_dsi {
>         const struct dw_mipi_dsi_plat_data *plat_data;
>  };
>
> +static const struct regmap_config dw_mipi_dsi_regmap_cfg =3D {
> +       .reg_bits =3D 32,
> +       .val_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .name =3D "dw-mipi-dsi",
> +};
> +
>  /*
>   * Check if either a link to a master or slave is present
>   */
> @@ -280,16 +290,6 @@ static inline struct dw_mipi_dsi *bridge_to_dsi(stru=
ct drm_bridge *bridge)
>         return container_of(bridge, struct dw_mipi_dsi, bridge);
>  }
>
> -static inline void dsi_write(struct dw_mipi_dsi *dsi, u32 reg, u32 val)
> -{
> -       writel(val, dsi->base + reg);
> -}
> -
> -static inline u32 dsi_read(struct dw_mipi_dsi *dsi, u32 reg)
> -{
> -       return readl(dsi->base + reg);
> -}
> -
>  static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
>                                    struct mipi_dsi_device *device)
>  {
> @@ -366,29 +366,29 @@ static void dw_mipi_message_config(struct dw_mipi_d=
si *dsi,
>         if (lpm)
>                 val |=3D CMD_MODE_ALL_LP;
>
> -       dsi_write(dsi, DSI_LPCLK_CTRL, lpm ? 0 : PHY_TXREQUESTCLKHS);
> -       dsi_write(dsi, DSI_CMD_MODE_CFG, val);
> +       regmap_write(dsi->regs, DSI_LPCLK_CTRL, lpm ? 0 : PHY_TXREQUESTCL=
KHS);
> +       regmap_write(dsi->regs, DSI_CMD_MODE_CFG, val);
>  }
>
>  static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hd=
r_val)
>  {
>         int ret;
> -       u32 val, mask;
> +       u32 val =3D 0, mask;
>

I think that this change is not needed, `val` is an input variable
that will be overwritten inside the regmap_read_poll_timeout.
Initialize here is not needed.

> -       ret =3D readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
> -                                val, !(val & GEN_CMD_FULL), 1000,
> -                                CMD_PKT_STATUS_TIMEOUT_US);
> +       ret =3D regmap_read_poll_timeout(dsi->regs, DSI_CMD_PKT_STATUS,
> +                                      val, !(val & GEN_CMD_FULL), 1000,
> +                                      CMD_PKT_STATUS_TIMEOUT_US);
>         if (ret) {
>                 dev_err(dsi->dev, "failed to get available command FIFO\n=
");
>                 return ret;
>         }
>
> -       dsi_write(dsi, DSI_GEN_HDR, hdr_val);
> +       regmap_write(dsi->regs, DSI_GEN_HDR, hdr_val);
>
>         mask =3D GEN_CMD_EMPTY | GEN_PLD_W_EMPTY;
> -       ret =3D readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
> -                                val, (val & mask) =3D=3D mask,
> -                                1000, CMD_PKT_STATUS_TIMEOUT_US);
> +       ret =3D regmap_read_poll_timeout(dsi->regs, DSI_CMD_PKT_STATUS,
> +                                      val, (val & mask) =3D=3D mask,
> +                                      1000, CMD_PKT_STATUS_TIMEOUT_US);
>         if (ret) {
>                 dev_err(dsi->dev, "failed to write command FIFO\n");
>                 return ret;
> @@ -403,24 +403,26 @@ static int dw_mipi_dsi_write(struct dw_mipi_dsi *ds=
i,
>         const u8 *tx_buf =3D packet->payload;
>         int len =3D packet->payload_length, pld_data_bytes =3D sizeof(u32=
), ret;
>         __le32 word;
> -       u32 val;
> +       u32 val =3D 0;
>

The same here, 'val' is used for the regmap_read_poll_timeout and will
be overwritten, no need to initialize.

>         while (len) {
>                 if (len < pld_data_bytes) {
>                         word =3D 0;
>                         memcpy(&word, tx_buf, len);
> -                       dsi_write(dsi, DSI_GEN_PLD_DATA, le32_to_cpu(word=
));
> +                       regmap_write(dsi->regs, DSI_GEN_PLD_DATA,
> +                                    le32_to_cpu(word));
>                         len =3D 0;
>                 } else {
>                         memcpy(&word, tx_buf, pld_data_bytes);
> -                       dsi_write(dsi, DSI_GEN_PLD_DATA, le32_to_cpu(word=
));
> +                       regmap_write(dsi->regs, DSI_GEN_PLD_DATA,
> +                                    le32_to_cpu(word));
>                         tx_buf +=3D pld_data_bytes;
>                         len -=3D pld_data_bytes;
>                 }
>
> -               ret =3D readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS=
,
> -                                        val, !(val & GEN_PLD_W_FULL), 10=
00,
> -                                        CMD_PKT_STATUS_TIMEOUT_US);
> +               ret =3D regmap_read_poll_timeout(dsi->regs, DSI_CMD_PKT_S=
TATUS,
> +                                              val, !(val & GEN_PLD_W_FUL=
L),
> +                                              1000, CMD_PKT_STATUS_TIMEO=
UT_US);
>                 if (ret) {
>                         dev_err(dsi->dev,
>                                 "failed to get available write payload FI=
FO\n");
> @@ -438,12 +440,12 @@ static int dw_mipi_dsi_read(struct dw_mipi_dsi *dsi=
,
>  {
>         int i, j, ret, len =3D msg->rx_len;
>         u8 *buf =3D msg->rx_buf;
> -       u32 val;
> +       u32 val =3D 0;
>

ditto

>         /* Wait end of the read operation */
> -       ret =3D readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
> -                                val, !(val & GEN_RD_CMD_BUSY),
> -                                1000, CMD_PKT_STATUS_TIMEOUT_US);
> +       ret =3D regmap_read_poll_timeout(dsi->regs, DSI_CMD_PKT_STATUS,
> +                                      val, !(val & GEN_RD_CMD_BUSY),
> +                                      1000, CMD_PKT_STATUS_TIMEOUT_US);
>         if (ret) {
>                 dev_err(dsi->dev, "Timeout during read operation\n");
>                 return ret;
> @@ -451,15 +453,15 @@ static int dw_mipi_dsi_read(struct dw_mipi_dsi *dsi=
,
>
>         for (i =3D 0; i < len; i +=3D 4) {
>                 /* Read fifo must not be empty before all bytes are read =
*/
> -               ret =3D readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS=
,
> -                                        val, !(val & GEN_PLD_R_EMPTY),
> -                                        1000, CMD_PKT_STATUS_TIMEOUT_US)=
;
> +               ret =3D regmap_read_poll_timeout(dsi->regs, DSI_CMD_PKT_S=
TATUS,
> +                                              val, !(val & GEN_PLD_R_EMP=
TY),
> +                                              1000, CMD_PKT_STATUS_TIMEO=
UT_US);
>                 if (ret) {
>                         dev_err(dsi->dev, "Read payload FIFO is empty\n")=
;
>                         return ret;
>                 }
>
> -               val =3D dsi_read(dsi, DSI_GEN_PLD_DATA);
> +               regmap_read(dsi->regs, DSI_GEN_PLD_DATA, &val);
>                 for (j =3D 0; j < 4 && j + i < len; j++)
>                         buf[i + j] =3D val >> (8 * j);
>         }
> @@ -536,29 +538,29 @@ static void dw_mipi_dsi_video_mode_config(struct dw=
_mipi_dsi *dsi)
>         }
>  #endif /* CONFIG_DEBUG_FS */
>
> -       dsi_write(dsi, DSI_VID_MODE_CFG, val);
> +       regmap_write(dsi->regs, DSI_VID_MODE_CFG, val);
>  }
>
>  static void dw_mipi_dsi_set_mode(struct dw_mipi_dsi *dsi,
>                                  unsigned long mode_flags)
>  {
> -       dsi_write(dsi, DSI_PWR_UP, RESET);
> +       regmap_write(dsi->regs, DSI_PWR_UP, RESET);
>
>         if (mode_flags & MIPI_DSI_MODE_VIDEO) {
> -               dsi_write(dsi, DSI_MODE_CFG, ENABLE_VIDEO_MODE);
> +               regmap_write(dsi->regs, DSI_MODE_CFG, ENABLE_VIDEO_MODE);
>                 dw_mipi_dsi_video_mode_config(dsi);
> -               dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
> +               regmap_write(dsi->regs, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKH=
S);
>         } else {
> -               dsi_write(dsi, DSI_MODE_CFG, ENABLE_CMD_MODE);
> +               regmap_write(dsi->regs, DSI_MODE_CFG, ENABLE_CMD_MODE);
>         }
>
> -       dsi_write(dsi, DSI_PWR_UP, POWERUP);
> +       regmap_write(dsi->regs, DSI_PWR_UP, POWERUP);
>  }
>
>  static void dw_mipi_dsi_disable(struct dw_mipi_dsi *dsi)
>  {
> -       dsi_write(dsi, DSI_PWR_UP, RESET);
> -       dsi_write(dsi, DSI_PHY_RSTZ, PHY_RSTZ);
> +       regmap_write(dsi->regs, DSI_PWR_UP, RESET);
> +       regmap_write(dsi->regs, DSI_PHY_RSTZ, PHY_RSTZ);
>  }
>
>  static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
> @@ -573,14 +575,14 @@ static void dw_mipi_dsi_init(struct dw_mipi_dsi *ds=
i)
>          */
>         u32 esc_clk_division =3D (dsi->lane_mbps >> 3) / 20 + 1;
>
> -       dsi_write(dsi, DSI_PWR_UP, RESET);
> +       regmap_write(dsi->regs, DSI_PWR_UP, RESET);
>
>         /*
>          * TODO dw drv improvements
>          * timeout clock division should be computed with the
>          * high speed transmission counter timeout and byte lane...
>          */
> -       dsi_write(dsi, DSI_CLKMGR_CFG, TO_CLK_DIVISION(10) |
> +       regmap_write(dsi->regs, DSI_CLKMGR_CFG, TO_CLK_DIVISION(10) |
>                   TX_ESC_CLK_DIVISION(esc_clk_division));
>  }
>
> @@ -609,22 +611,22 @@ static void dw_mipi_dsi_dpi_config(struct dw_mipi_d=
si *dsi,
>         if (mode->flags & DRM_MODE_FLAG_NHSYNC)
>                 val |=3D HSYNC_ACTIVE_LOW;
>
> -       dsi_write(dsi, DSI_DPI_VCID, DPI_VCID(dsi->channel));
> -       dsi_write(dsi, DSI_DPI_COLOR_CODING, color);
> -       dsi_write(dsi, DSI_DPI_CFG_POL, val);
> +       regmap_write(dsi->regs, DSI_DPI_VCID, DPI_VCID(dsi->channel));
> +       regmap_write(dsi->regs, DSI_DPI_COLOR_CODING, color);
> +       regmap_write(dsi->regs, DSI_DPI_CFG_POL, val);
>         /*
>          * TODO dw drv improvements
>          * largest packet sizes during hfp or during vsa/vpb/vfp
>          * should be computed according to byte lane, lane number and onl=
y
>          * if sending lp cmds in high speed is enable (PHY_TXREQUESTCLKHS=
)
>          */
> -       dsi_write(dsi, DSI_DPI_LP_CMD_TIM, OUTVACT_LPCMD_TIME(4)
> +       regmap_write(dsi->regs, DSI_DPI_LP_CMD_TIM, OUTVACT_LPCMD_TIME(4)
>                   | INVACT_LPCMD_TIME(4));
>  }
>
>  static void dw_mipi_dsi_packet_handler_config(struct dw_mipi_dsi *dsi)
>  {
> -       dsi_write(dsi, DSI_PCKHDL_CFG, CRC_RX_EN | ECC_RX_EN | BTA_EN);
> +       regmap_write(dsi->regs, DSI_PCKHDL_CFG, CRC_RX_EN | ECC_RX_EN | B=
TA_EN);
>  }
>
>  static void dw_mipi_dsi_video_packet_config(struct dw_mipi_dsi *dsi,
> @@ -638,7 +640,7 @@ static void dw_mipi_dsi_video_packet_config(struct dw=
_mipi_dsi *dsi,
>          * non-burst video modes, see dw_mipi_dsi_video_mode_config()...
>          */
>
> -       dsi_write(dsi, DSI_VID_PKT_SIZE,
> +       regmap_write(dsi->regs, DSI_VID_PKT_SIZE,
>                        dw_mipi_is_dual_mode(dsi) ?
>                                 VID_PKT_SIZE(mode->hdisplay / 2) :
>                                 VID_PKT_SIZE(mode->hdisplay));
> @@ -651,14 +653,15 @@ static void dw_mipi_dsi_command_mode_config(struct =
dw_mipi_dsi *dsi)
>          * compute high speed transmission counter timeout according
>          * to the timeout clock division (TO_CLK_DIVISION) and byte lane.=
..
>          */
> -       dsi_write(dsi, DSI_TO_CNT_CFG, HSTX_TO_CNT(1000) | LPRX_TO_CNT(10=
00));
> +       regmap_write(dsi->regs, DSI_TO_CNT_CFG,
> +                    HSTX_TO_CNT(1000) | LPRX_TO_CNT(1000));
>         /*
>          * TODO dw drv improvements
>          * the Bus-Turn-Around Timeout Counter should be computed
>          * according to byte lane...
>          */
> -       dsi_write(dsi, DSI_BTA_TO_CNT, 0xd00);
> -       dsi_write(dsi, DSI_MODE_CFG, ENABLE_CMD_MODE);
> +       regmap_write(dsi->regs, DSI_BTA_TO_CNT, 0xd00);
> +       regmap_write(dsi->regs, DSI_MODE_CFG, ENABLE_CMD_MODE);
>  }
>
>  /* Get lane byte clock cycles. */
> @@ -692,13 +695,13 @@ static void dw_mipi_dsi_line_timer_config(struct dw=
_mipi_dsi *dsi,
>          * computations below may be improved...
>          */
>         lbcc =3D dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, htotal);
> -       dsi_write(dsi, DSI_VID_HLINE_TIME, lbcc);
> +       regmap_write(dsi->regs, DSI_VID_HLINE_TIME, lbcc);
>
>         lbcc =3D dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, hsa);
> -       dsi_write(dsi, DSI_VID_HSA_TIME, lbcc);
> +       regmap_write(dsi->regs, DSI_VID_HSA_TIME, lbcc);
>
>         lbcc =3D dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, hbp);
> -       dsi_write(dsi, DSI_VID_HBP_TIME, lbcc);
> +       regmap_write(dsi->regs, DSI_VID_HBP_TIME, lbcc);
>  }
>
>  static void dw_mipi_dsi_vertical_timing_config(struct dw_mipi_dsi *dsi,
> @@ -711,10 +714,10 @@ static void dw_mipi_dsi_vertical_timing_config(stru=
ct dw_mipi_dsi *dsi,
>         vfp =3D mode->vsync_start - mode->vdisplay;
>         vbp =3D mode->vtotal - mode->vsync_end;
>
> -       dsi_write(dsi, DSI_VID_VACTIVE_LINES, vactive);
> -       dsi_write(dsi, DSI_VID_VSA_LINES, vsa);
> -       dsi_write(dsi, DSI_VID_VFP_LINES, vfp);
> -       dsi_write(dsi, DSI_VID_VBP_LINES, vbp);
> +       regmap_write(dsi->regs, DSI_VID_VACTIVE_LINES, vactive);
> +       regmap_write(dsi->regs, DSI_VID_VSA_LINES, vsa);
> +       regmap_write(dsi->regs, DSI_VID_VFP_LINES, vfp);
> +       regmap_write(dsi->regs, DSI_VID_VBP_LINES, vbp);
>  }
>
>  static void dw_mipi_dsi_dphy_timing_config(struct dw_mipi_dsi *dsi)
> @@ -737,23 +740,25 @@ static void dw_mipi_dsi_dphy_timing_config(struct d=
w_mipi_dsi *dsi)
>          * DSI_CMD_MODE_CFG.MAX_RD_PKT_SIZE_LP (see CMD_MODE_ALL_LP)
>          */
>
> -       hw_version =3D dsi_read(dsi, DSI_VERSION) & VERSION;
> +       regmap_read(dsi->regs, DSI_VERSION, &hw_version);
> +       hw_version &=3D VERSION;

If I am not wrong, you already introduced a function to get the
hardware version and is stored in dsi->hw_version. Maybe you could you
use that variable and remove that code.

>
>         if (hw_version >=3D HWVER_131) {
> -               dsi_write(dsi, DSI_PHY_TMR_CFG,
> -                         PHY_HS2LP_TIME_V131(timing.data_hs2lp) |
> -                         PHY_LP2HS_TIME_V131(timing.data_lp2hs));
> -               dsi_write(dsi, DSI_PHY_TMR_RD_CFG, MAX_RD_TIME_V131(10000=
));
> +               regmap_write(dsi->regs, DSI_PHY_TMR_CFG,
> +                            PHY_HS2LP_TIME_V131(timing.data_hs2lp) |
> +                            PHY_LP2HS_TIME_V131(timing.data_lp2hs));
> +               regmap_write(dsi->regs, DSI_PHY_TMR_RD_CFG,
> +                            MAX_RD_TIME_V131(10000));
>         } else {
> -               dsi_write(dsi, DSI_PHY_TMR_CFG,
> -                         PHY_HS2LP_TIME(timing.data_hs2lp) |
> -                         PHY_LP2HS_TIME(timing.data_lp2hs) |
> -                         MAX_RD_TIME(10000));
> +               regmap_write(dsi->regs, DSI_PHY_TMR_CFG,
> +                            PHY_HS2LP_TIME(timing.data_hs2lp) |
> +                            PHY_LP2HS_TIME(timing.data_lp2hs) |
> +                            MAX_RD_TIME(10000));
>         }
>
> -       dsi_write(dsi, DSI_PHY_TMR_LPCLK_CFG,
> -                 PHY_CLKHS2LP_TIME(timing.clk_hs2lp) |
> -                 PHY_CLKLP2HS_TIME(timing.clk_lp2hs));
> +       regmap_write(dsi->regs, DSI_PHY_TMR_LPCLK_CFG,
> +                    PHY_CLKHS2LP_TIME(timing.clk_hs2lp) |
> +                    PHY_CLKLP2HS_TIME(timing.clk_lp2hs));
>  }
>
>  static void dw_mipi_dsi_dphy_interface_config(struct dw_mipi_dsi *dsi)
> @@ -763,46 +768,49 @@ static void dw_mipi_dsi_dphy_interface_config(struc=
t dw_mipi_dsi *dsi)
>          * stop wait time should be the maximum between host dsi
>          * and panel stop wait times
>          */
> -       dsi_write(dsi, DSI_PHY_IF_CFG, PHY_STOP_WAIT_TIME(0x20) |
> -                 N_LANES(dsi->lanes));
> +       regmap_write(dsi->regs, DSI_PHY_IF_CFG,
> +                    PHY_STOP_WAIT_TIME(0x20) | N_LANES(dsi->lanes));
>  }
>
>  static void dw_mipi_dsi_dphy_init(struct dw_mipi_dsi *dsi)
>  {
>         /* Clear PHY state */
> -       dsi_write(dsi, DSI_PHY_RSTZ, PHY_DISFORCEPLL | PHY_DISABLECLK
> -                 | PHY_RSTZ | PHY_SHUTDOWNZ);
> -       dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
> -       dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLR);
> -       dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
> +       regmap_write(dsi->regs, DSI_PHY_RSTZ, PHY_DISFORCEPLL | PHY_DISAB=
LECLK
> +                    | PHY_RSTZ | PHY_SHUTDOWNZ);
> +       regmap_write(dsi->regs, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
> +       regmap_write(dsi->regs, DSI_PHY_TST_CTRL0, PHY_TESTCLR);
> +       regmap_write(dsi->regs, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
>  }
>
>  static void dw_mipi_dsi_dphy_enable(struct dw_mipi_dsi *dsi)
>  {
> -       u32 val;
> +       u32 val =3D 0;

ditto

>         int ret;
>
> -       dsi_write(dsi, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLECLK |
> -                 PHY_UNRSTZ | PHY_UNSHUTDOWNZ);
> +       regmap_write(dsi->regs, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLE=
CLK |
> +                    PHY_UNRSTZ | PHY_UNSHUTDOWNZ);
>
> -       ret =3D readl_poll_timeout(dsi->base + DSI_PHY_STATUS, val,
> -                                val & PHY_LOCK, 1000, PHY_STATUS_TIMEOUT=
_US);
> +       ret =3D regmap_read_poll_timeout(dsi->regs, DSI_PHY_STATUS,
> +                                      val, val & PHY_LOCK,
> +                                      1000, PHY_STATUS_TIMEOUT_US);
>         if (ret)
>                 DRM_DEBUG_DRIVER("failed to wait phy lock state\n");
>
> -       ret =3D readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
> -                                val, val & PHY_STOP_STATE_CLK_LANE, 1000=
,
> -                                PHY_STATUS_TIMEOUT_US);
> +       ret =3D regmap_read_poll_timeout(dsi->regs, DSI_PHY_STATUS,
> +                                      val, val & PHY_STOP_STATE_CLK_LANE=
, 1000,
> +                                      PHY_STATUS_TIMEOUT_US);
>         if (ret)
>                 DRM_DEBUG_DRIVER("failed to wait phy clk lane stop state\=
n");
>  }
>
>  static void dw_mipi_dsi_clear_err(struct dw_mipi_dsi *dsi)
>  {
> -       dsi_read(dsi, DSI_INT_ST0);
> -       dsi_read(dsi, DSI_INT_ST1);
> -       dsi_write(dsi, DSI_INT_MSK0, 0);
> -       dsi_write(dsi, DSI_INT_MSK1, 0);
> +       u32 val;
> +
> +       regmap_read(dsi->regs, DSI_INT_ST0, &val);
> +       regmap_read(dsi->regs, DSI_INT_ST1, &val);
> +       regmap_write(dsi->regs, DSI_INT_MSK0, 0);
> +       regmap_write(dsi->regs, DSI_INT_MSK1, 0);
>  }
>
>  static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
> @@ -989,6 +997,14 @@ static void dw_mipi_dsi_debugfs_remove(struct dw_mip=
i_dsi *dsi) { }
>
>  #endif /* CONFIG_DEBUG_FS */
>
> +static void dw_mipi_dsi_get_hw_version(struct dw_mipi_dsi *dsi)
> +{
> +       regmap_read(dsi->regs, DSI_VERSION, &dsi->hw_version);
> +       dsi->hw_version &=3D VERSION;
> +       if (!dsi->hw_version)
> +               dev_err(dsi->dev, "Failed to read DSI hw version register=
\n");

Is this an error that should be ignored? If you can't get the HW
version, probably, there is something wrong with your hardware so,
don't you need to return an error?


> +}
> +
>  static struct dw_mipi_dsi *
>  __dw_mipi_dsi_probe(struct platform_device *pdev,
>                     const struct dw_mipi_dsi_plat_data *plat_data)
> @@ -1020,6 +1036,14 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>                 dsi->base =3D plat_data->base;
>         }
>
> +       dsi->regs =3D devm_regmap_init_mmio(dev, dsi->base,
> +                                         &dw_mipi_dsi_regmap_cfg);
> +       if (IS_ERR(dsi->regs)) {
> +               ret =3D PTR_ERR(dsi->regs);
> +               DRM_ERROR("Failed to create DW MIPI DSI regmap: %d\n", re=
t);
> +               return ERR_PTR(ret);
> +       }
> +
>         dsi->pclk =3D devm_clk_get(dev, "pclk");
>         if (IS_ERR(dsi->pclk)) {
>                 ret =3D PTR_ERR(dsi->pclk);
> @@ -1055,6 +1079,8 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>                 clk_disable_unprepare(dsi->pclk);
>         }
>
> +       dw_mipi_dsi_get_hw_version(dsi);
> +
>         dw_mipi_dsi_debugfs_init(dsi);
>         pm_runtime_enable(dev);
>
> --
> 2.26.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
