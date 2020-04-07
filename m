Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF30C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7486020748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmLVHk5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgDGG62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:58:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35459 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDGG62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:58:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id c7so2710820edl.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTus1HhmAwjgtZusz47Cocd0rsgHoslXEjkAB1idN5Y=;
        b=LmLVHk5Rma0Nob96e5PCxTU6PBnIl0GKYt6IMfMuzeXl+Cn+IpD0cHqvZKFogzUDYb
         20M8qavHrZJ/oppK4Axr2ZxPsKYyRwS0c3r0ClLn+V3m9cUxz43hoiwh8Ht9t01HGuIl
         aTvN0D+uzaCS6c8K3uVAILkdncJrNCXRr0W8N/zyEbrU3KaZJ+VpZW9yxL+oCRJgW69+
         K11w5iz8ViJuSUUq72JQ5h3Pbs0q7pOUytT47Eg77EbM/Xa5HwkRuGX3Wk+6w7VR2E1a
         OLZfq1v08YKU5Ya3f3ks/YBeH3UN9VPl7oQ5xHXJ2252OPK+Wf2jSoIFIVdGG9EZ3nqd
         TiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTus1HhmAwjgtZusz47Cocd0rsgHoslXEjkAB1idN5Y=;
        b=dCkhjxcAZ7cMIICruaK5y1aANiX2GIsXh16GlHvuJWzi6g2lliASNKiUJ8w1ux5ohP
         VRJug2a7Sh9XYColqlhyiDLsnWa0eAwJNuSdq8H6xvKrel3yyTrMgWkQs/ajHqZ3CtRP
         nxED/2EaayF2OHxJlg89hN6BbHUiA0u7+TW7oW9E9c00cXhqanrZKbX6E1s8cNOOZJes
         uA4ZJfKU3F+Ro6btbOwjDZBLSLF3k925DWOa5HzjMnnwv9tx2wvDtpYmB9G4hNGXWzRE
         fPakqEtGLlUgXf7NyKRoq+wi/tHNJKGG3UUju1bdWUnxWVHn3sTrqUQDCug7lnHMSI89
         Bu+A==
X-Gm-Message-State: AGi0Pua0vsvDKSuOOse7W7kdDVERztNSbde+R4hoZq+CyTPSfmkDNAC6
        kEtvAWKRnLbojfyjCNmp7F7KrocQdhrt0dLqSBiDpKxsMsk=
X-Google-Smtp-Source: APiQypLmjti+xb31CgGzLznKFFYtZ/CxeWVSEz3Rp3EHyb3R54c8nNJYU4UbSOv1BVwI4hIJZ78v77nix3e9VQlpHQk=
X-Received: by 2002:a50:fa88:: with SMTP id w8mr617737edr.183.1586242705221;
 Mon, 06 Apr 2020 23:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <a809feb7d7153a92e323416f744f1565e995da01.1586180592.git.angelo.ribeiro@synopsys.com>
 <CAP-HsdQtdSeiSe3O8P6Pe587PYAqO48pGJLwf+Tvq20sY_nh=A@mail.gmail.com>
In-Reply-To: <CAP-HsdQtdSeiSe3O8P6Pe587PYAqO48pGJLwf+Tvq20sY_nh=A@mail.gmail.com>
From:   Adrian Pop <pop.adrian61@gmail.com>
Date:   Tue, 7 Apr 2020 09:58:14 +0300
Message-ID: <CAP-HsdRaSBrFHvVM1onwB1nj7P6k9Qwdpp547tNN9XZvXapqoQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: dw-mipi-dsi.c: Add VPG runtime config
 through debugfs
To:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
Cc:     yannick.fertre@st.com, philippe.cornu@st.com,
        benjamin.gaignard@st.com, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Adrian Pop <pop.adrian61@gmail.com>
Tested OK on STM32F769i-DISCO, DSI v1.30, on next-20200406.

On Mon, Apr 6, 2020 at 8:45 PM Adrian Pop <pop.adrian61@gmail.com> wrote:
>
> Hello Angelo,
>
> Tested OK on STM32F769i-DISCO, DSI v1.30, on next-20200406. I guess
> there is no horizontal for BER.
>
> Regards,
> Adrian
>
> On Mon, Apr 6, 2020 at 4:49 PM Angelo Ribeiro
> <Angelo.Ribeiro@synopsys.com> wrote:
> >
> > Add support for the video pattern generator (VPG) BER pattern mode and
> > configuration in runtime.
> >
> > This enables using the debugfs interface to manipulate the VPG after
> > the pipeline is set.
> > Also, enables the usage of the VPG BER pattern.
> >
> > Changes in v2:
> >   - Added VID_MODE_VPG_MODE
> >   - Solved incompatible return type on __get and __set
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Adrian Pop <pop.adrian61@gmail.com>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Joao Pinto <jpinto@synopsys.com>
> > Cc: Jose Abreu <jose.abreu@synopsys.com>
> > Signed-off-by: Angelo Ribeiro <angelo.ribeiro@synopsys.com>
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 98 ++++++++++++++++++++++++---
> >  1 file changed, 90 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > index b18351b..9de3645 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > @@ -91,6 +91,7 @@
> >  #define VID_MODE_TYPE_BURST                    0x2
> >  #define VID_MODE_TYPE_MASK                     0x3
> >  #define VID_MODE_VPG_ENABLE            BIT(16)
> > +#define VID_MODE_VPG_MODE              BIT(20)
> >  #define VID_MODE_VPG_HORIZONTAL                BIT(24)
> >
> >  #define DSI_VID_PKT_SIZE               0x3c
> > @@ -221,6 +222,21 @@
> >  #define PHY_STATUS_TIMEOUT_US          10000
> >  #define CMD_PKT_STATUS_TIMEOUT_US      20000
> >
> > +#ifdef CONFIG_DEBUG_FS
> > +#define VPG_DEFS(name, dsi) \
> > +       ((void __force *)&((*dsi).vpg_defs.name))
> > +
> > +#define REGISTER(name, mask, dsi) \
> > +       { #name, VPG_DEFS(name, dsi), mask, dsi }
> > +
> > +struct debugfs_entries {
> > +       const char                              *name;
> > +       bool                                    *reg;
> > +       u32                                     mask;
> > +       struct dw_mipi_dsi                      *dsi;
> > +};
> > +#endif /* CONFIG_DEBUG_FS */
> > +
> >  struct dw_mipi_dsi {
> >         struct drm_bridge bridge;
> >         struct mipi_dsi_host dsi_host;
> > @@ -238,9 +254,12 @@ struct dw_mipi_dsi {
> >
> >  #ifdef CONFIG_DEBUG_FS
> >         struct dentry *debugfs;
> > -
> > -       bool vpg;
> > -       bool vpg_horizontal;
> > +       struct debugfs_entries *debugfs_vpg;
> > +       struct {
> > +               bool vpg;
> > +               bool vpg_horizontal;
> > +               bool vpg_ber_pattern;
> > +       } vpg_defs;
> >  #endif /* CONFIG_DEBUG_FS */
> >
> >         struct dw_mipi_dsi *master; /* dual-dsi master ptr */
> > @@ -530,9 +549,11 @@ static void dw_mipi_dsi_video_mode_config(struct dw_mipi_dsi *dsi)
> >                 val |= VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
> >
> >  #ifdef CONFIG_DEBUG_FS
> > -       if (dsi->vpg) {
> > +       if (dsi->vpg_defs.vpg) {
> >                 val |= VID_MODE_VPG_ENABLE;
> > -               val |= dsi->vpg_horizontal ? VID_MODE_VPG_HORIZONTAL : 0;
> > +               val |= dsi->vpg_defs.vpg_horizontal ?
> > +                      VID_MODE_VPG_HORIZONTAL : 0;
> > +               val |= dsi->vpg_defs.vpg_ber_pattern ? VID_MODE_VPG_MODE : 0;
> >         }
> >  #endif /* CONFIG_DEBUG_FS */
> >
> > @@ -961,6 +982,68 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
> >
> >  #ifdef CONFIG_DEBUG_FS
> >
> > +int dw_mipi_dsi_debugfs_write(void *data, u64 val)
> > +{
> > +       struct debugfs_entries *vpg = data;
> > +       struct dw_mipi_dsi *dsi;
> > +       u32 mode_cfg;
> > +
> > +       if (!vpg)
> > +               return -ENODEV;
> > +
> > +       dsi = vpg->dsi;
> > +
> > +       *vpg->reg = (bool)val;
> > +
> > +       mode_cfg = dsi_read(dsi, DSI_VID_MODE_CFG);
> > +
> > +       if (*vpg->reg)
> > +               mode_cfg |= vpg->mask;
> > +       else
> > +               mode_cfg &= ~vpg->mask;
> > +
> > +       dsi_write(dsi, DSI_VID_MODE_CFG, mode_cfg);
> > +
> > +       return 0;
> > +}
> > +
> > +int dw_mipi_dsi_debugfs_show(void *data, u64 *val)
> > +{
> > +       struct debugfs_entries *vpg = data;
> > +
> > +       if (!vpg)
> > +               return -ENODEV;
> > +
> > +       *val = *vpg->reg;
> > +
> > +       return 0;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_mipi_dsi_debugfs_show,
> > +                        dw_mipi_dsi_debugfs_write, "%llu\n");
> > +
> > +static void debugfs_create_files(void *data)
> > +{
> > +       struct dw_mipi_dsi *dsi = data;
> > +       struct debugfs_entries debugfs[] = {
> > +               REGISTER(vpg, VID_MODE_VPG_ENABLE, dsi),
> > +               REGISTER(vpg_horizontal, VID_MODE_VPG_HORIZONTAL, dsi),
> > +               REGISTER(vpg_ber_pattern, VID_MODE_VPG_MODE, dsi),
> > +       };
> > +       int i;
> > +
> > +       dsi->debugfs_vpg = kmalloc(sizeof(debugfs), GFP_KERNEL);
> > +       if (!dsi->debugfs_vpg)
> > +               return;
> > +
> > +       memcpy(dsi->debugfs_vpg, debugfs, sizeof(debugfs));
> > +
> > +       for (i = 0; i < ARRAY_SIZE(debugfs); i++)
> > +               debugfs_create_file(dsi->debugfs_vpg[i].name, 0644,
> > +                                   dsi->debugfs, &dsi->debugfs_vpg[i],
> > +                                   &fops_x32);
> > +}
> > +
> >  static void dw_mipi_dsi_debugfs_init(struct dw_mipi_dsi *dsi)
> >  {
> >         dsi->debugfs = debugfs_create_dir(dev_name(dsi->dev), NULL);
> > @@ -969,14 +1052,13 @@ static void dw_mipi_dsi_debugfs_init(struct dw_mipi_dsi *dsi)
> >                 return;
> >         }
> >
> > -       debugfs_create_bool("vpg", 0660, dsi->debugfs, &dsi->vpg);
> > -       debugfs_create_bool("vpg_horizontal", 0660, dsi->debugfs,
> > -                           &dsi->vpg_horizontal);
> > +       debugfs_create_files(dsi);
> >  }
> >
> >  static void dw_mipi_dsi_debugfs_remove(struct dw_mipi_dsi *dsi)
> >  {
> >         debugfs_remove_recursive(dsi->debugfs);
> > +       kfree(dsi->debugfs_vpg);
> >  }
> >
> >  #else
> > --
> > 2.7.4
> >
