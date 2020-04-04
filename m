Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B639C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 10:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F99206F5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 10:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yww78VAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDDK40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 06:56:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41047 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgDDK4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 06:56:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id v1so12477156edq.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 03:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S5LRbjaBzwgm2Bw+4kytwllkzAVVFFIjueHCZ7wjG1s=;
        b=Yww78VAiDL77AaN5cYqIRNsvvUV8nwXUoefxnxGstSo0m2fVatHUqOZhP9JOSVIjuH
         8i1VdNgrp8dTxbow0ryzOu2X7IyMQcGKJmoK69WqlKDM2icO54QBLFhFPWbIBFTR9RDJ
         wuXUFfAkRuHQCX7m1C58H7OAMNnzS6CFYrcq4HBbxdJTPJppKHzkKAEOs9FQc4FBUVvm
         58sph/1Nc9sdbsORfS+1XqcVy+NGjnTS4cYf47ggDEuLgNRuyzuC8GowLEo2jGX2G5H/
         FeBx55crRc8G3Bqo9pbiFfhupkdYHch2sNlaZMN/gODyihX5grzmE4hOpJsnLYfFHSg1
         hfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S5LRbjaBzwgm2Bw+4kytwllkzAVVFFIjueHCZ7wjG1s=;
        b=JZkXAPNa/ngkfvxcpLpgLEllAb94FC/qEUHWvAK4zwlyQMz8WR73v4HwTuECU4tnvV
         HkBPn2omx7r4exCq0tw1NwqJHAssgwgsYe025tj5MEFjjb8WN0YLO7DypH/qOSLgZit8
         D1HgoJlkyhfXglzaoaZ2CrwGYfRaHlD87/VEn71T+2m2Lpvd0xzSLnEZsXdEsqXVGAyM
         3wReipP31+fCzbHqpfPnx/iukC22rRAsC77TAtnJS0o+UAhSMLOjsq6Tfh4u9yWOLp84
         SD+irX6PstqwITNw0NrW2tYgLXfiZHxxJqC1jje67J6YVXEDNZ2qz5MiL5mLQ/R/mKPl
         GADA==
X-Gm-Message-State: AGi0PubaqgWk/CAc87UWI1/zy/3+CE5hAgk/g/dh9U0dzQlAz81OKspq
        DecFCj3PiAi+iLFc1dChpsXTYrXNPhcbCoGIf5hnhIicmnc=
X-Google-Smtp-Source: APiQypKj5GKI+9i8bsRx4M0EERlfHWLSCALPhiuqVUvjby+E3w7SdQwuY9XfI9pACWF4KdnltYUDlxgPCmnFBVJy9Co=
X-Received: by 2002:a17:906:1603:: with SMTP id m3mr12822766ejd.205.1585997783064;
 Sat, 04 Apr 2020 03:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <a5aa527c2cd66b55b4246b9c122c702a279b37f0.1585928032.git.angelo.ribeiro@synopsys.com>
In-Reply-To: <a5aa527c2cd66b55b4246b9c122c702a279b37f0.1585928032.git.angelo.ribeiro@synopsys.com>
From:   Adrian Pop <pop.adrian61@gmail.com>
Date:   Sat, 4 Apr 2020 13:56:11 +0300
Message-ID: <CAP-HsdSKR8SB2UY2W33Xn8157Via30cD8wntXrvV0LEVmxgpRg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi.c: Add VPG runtime config through debugfs
To:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
Cc:     yannick.fertre@st.com, philippe.cornu@st.com,
        benjamin.gaignard@st.com, airlied@linux.ie, daniel@ffwll.ch,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Angelo,

I get a compile error: error: =E2=80=98VID_MODE_VPG_MODE=E2=80=99 undeclare=
d. I am
quite new to the mailing list, maybe I misapplied the patch.

Regards,
Adrian


On Fri, Apr 3, 2020 at 6:37 PM Angelo Ribeiro
<Angelo.Ribeiro@synopsys.com> wrote:
>
> Add support for the video pattern generator (VPG) BER pattern mode and
> configuration in runtime.
>
> This enables using the debugfs interface to manipulate the VPG after
> the pipeline is set.
> Also, enables the usage of the VPG BER pattern.
>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: Jose Abreu <jose.abreu@synopsys.com>
> Signed-off-by: Angelo Ribeiro <angelo.ribeiro@synopsys.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 97 +++++++++++++++++++++=
+++---
>  1 file changed, 89 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/=
drm/bridge/synopsys/dw-mipi-dsi.c
> index b18351b..512c922 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -221,6 +221,21 @@
>  #define PHY_STATUS_TIMEOUT_US          10000
>  #define CMD_PKT_STATUS_TIMEOUT_US      20000
>
> +#ifdef CONFIG_DEBUG_FS
> +#define VPG_DEFS(name, dsi) \
> +       ((void __force *)&((*dsi).vpg_defs.name))
> +
> +#define REGISTER(name, mask, dsi) \
> +       { #name, VPG_DEFS(name, dsi), mask, dsi }
> +
> +struct debugfs_entries {
> +       const char                              *name;
> +       bool                                    *reg;
> +       u32                                     mask;
> +       struct dw_mipi_dsi                      *dsi;
> +};
> +#endif /* CONFIG_DEBUG_FS */
> +
>  struct dw_mipi_dsi {
>         struct drm_bridge bridge;
>         struct mipi_dsi_host dsi_host;
> @@ -238,9 +253,12 @@ struct dw_mipi_dsi {
>
>  #ifdef CONFIG_DEBUG_FS
>         struct dentry *debugfs;
> -
> -       bool vpg;
> -       bool vpg_horizontal;
> +       struct debugfs_entries *debugfs_vpg;
> +       struct {
> +               bool vpg;
> +               bool vpg_horizontal;
> +               bool vpg_ber_pattern;
> +       } vpg_defs;
>  #endif /* CONFIG_DEBUG_FS */
>
>         struct dw_mipi_dsi *master; /* dual-dsi master ptr */
> @@ -530,9 +548,11 @@ static void dw_mipi_dsi_video_mode_config(struct dw_=
mipi_dsi *dsi)
>                 val |=3D VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
>
>  #ifdef CONFIG_DEBUG_FS
> -       if (dsi->vpg) {
> +       if (dsi->vpg_defs.vpg) {
>                 val |=3D VID_MODE_VPG_ENABLE;
> -               val |=3D dsi->vpg_horizontal ? VID_MODE_VPG_HORIZONTAL : =
0;
> +               val |=3D dsi->vpg_defs.vpg_horizontal ?
> +                      VID_MODE_VPG_HORIZONTAL : 0;
> +               val |=3D dsi->vpg_defs.vpg_ber_pattern ? VID_MODE_VPG_MOD=
E : 0;
>         }
>  #endif /* CONFIG_DEBUG_FS */
>
> @@ -961,6 +981,68 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bri=
dge_funcs =3D {
>
>  #ifdef CONFIG_DEBUG_FS
>
> +ssize_t dw_mipi_dsi_debugfs_write(void *data, u64 val)
> +{
> +       struct debugfs_entries *vpg =3D data;
> +       struct dw_mipi_dsi *dsi;
> +       u32 mode_cfg;
> +
> +       if (!vpg)
> +               return -ENODEV;
> +
> +       dsi =3D vpg->dsi;
> +
> +       *vpg->reg =3D (bool)val;
> +
> +       mode_cfg =3D dsi_read(dsi, DSI_VID_MODE_CFG);
> +
> +       if (*vpg->reg)
> +               mode_cfg |=3D vpg->mask;
> +       else
> +               mode_cfg &=3D ~vpg->mask;
> +
> +       dsi_write(dsi, DSI_VID_MODE_CFG, mode_cfg);
> +
> +       return 0;
> +}
> +
> +ssize_t dw_mipi_dsi_debugfs_show(void *data, u64 *val)
> +{
> +       struct debugfs_entries *vpg =3D data;
> +
> +       if (!vpg)
> +               return -ENODEV;
> +
> +       *val =3D *vpg->reg;
> +
> +       return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_mipi_dsi_debugfs_show,
> +                        dw_mipi_dsi_debugfs_write, "%llu\n");
> +
> +static void debugfs_create_files(void *data)
> +{
> +       struct dw_mipi_dsi *dsi =3D data;
> +       struct debugfs_entries debugfs[] =3D {
> +               REGISTER(vpg, VID_MODE_VPG_ENABLE, dsi),
> +               REGISTER(vpg_horizontal, VID_MODE_VPG_HORIZONTAL, dsi),
> +               REGISTER(vpg_ber_pattern, VID_MODE_VPG_MODE, dsi),
> +       };
> +       int i;
> +
> +       dsi->debugfs_vpg =3D kmalloc(sizeof(debugfs), GFP_KERNEL);
> +       if (!dsi->debugfs_vpg)
> +               return;
> +
> +       memcpy(dsi->debugfs_vpg, debugfs, sizeof(debugfs));
> +
> +       for (i =3D 0; i < ARRAY_SIZE(debugfs); i++)
> +               debugfs_create_file(dsi->debugfs_vpg[i].name, 0644,
> +                                   dsi->debugfs, &dsi->debugfs_vpg[i],
> +                                   &fops_x32);
> +}
> +
>  static void dw_mipi_dsi_debugfs_init(struct dw_mipi_dsi *dsi)
>  {
>         dsi->debugfs =3D debugfs_create_dir(dev_name(dsi->dev), NULL);
> @@ -969,14 +1051,13 @@ static void dw_mipi_dsi_debugfs_init(struct dw_mip=
i_dsi *dsi)
>                 return;
>         }
>
> -       debugfs_create_bool("vpg", 0660, dsi->debugfs, &dsi->vpg);
> -       debugfs_create_bool("vpg_horizontal", 0660, dsi->debugfs,
> -                           &dsi->vpg_horizontal);
> +       debugfs_create_files(dsi);
>  }
>
>  static void dw_mipi_dsi_debugfs_remove(struct dw_mipi_dsi *dsi)
>  {
>         debugfs_remove_recursive(dsi->debugfs);
> +       kfree(dsi->debugfs_vpg);
>  }
>
>  #else
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
