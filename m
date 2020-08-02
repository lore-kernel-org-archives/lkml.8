Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A638C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0A20789
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596326649;
	bh=JJ+DpM+KAOZuKVYWjZfkOfUQpF+6TNlEvjHz1UF+c00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lLD/lJqA0ix7JjnBnm0cSSe0PX99wu4x1/i4V6Yo9H1R41CNmEX8G/8/rwkIWSeAx
	 4aMUcK7htD1WPXYaplgsiDNooZ5/iCuQJNGswct82O1WU7nTZomVNzL98zlXTIgcTn
	 1UdiVO0NpmMzTMcYGByhfB7Fis/OuVLnOGj0087A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgHBAEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 20:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgHBAEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 20:04:07 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4819F208C7
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 00:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596326646;
        bh=JJ+DpM+KAOZuKVYWjZfkOfUQpF+6TNlEvjHz1UF+c00=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KTYn7N/GjGIhXtVvrzRre6FnCOR6YLmXeCDWsarEiAGq/DcFDmT4U05UhytKy1xU6
         N6lo4HsHLkn0WfX4/e07VGWV8UsNeanLkLnOsMBPk2xcoHvxGOsX38OYltJHo3GXSA
         5RNLGnOeffIEeNquBqLJqi+3UIjlrMXUCUeiKcNQ=
Received: by mail-ed1-f51.google.com with SMTP id n2so24810193edr.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 17:04:06 -0700 (PDT)
X-Gm-Message-State: AOAM532J7Nh7b5RRtyvVOJbXKlD+ll+KCa7tj5RSkdts9bUmiMdipdS/
        TPXBxP6BNfNsH+zjy6io0Zejxp3CqlTiJRHE/g==
X-Google-Smtp-Source: ABdhPJzEn4VLeJrbu0zAJ5dXYiNitDGHrGOIwRHpMThCcrej6wya5Z6fIJtz+Qiy0iNVZ4f24dBD2owi9j+C42hsxo4=
X-Received: by 2002:a50:ccd0:: with SMTP id b16mr9842462edj.148.1596326644838;
 Sat, 01 Aug 2020 17:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200728111800.77641-1-frank-w@public-files.de> <20200728111800.77641-2-frank-w@public-files.de>
In-Reply-To: <20200728111800.77641-2-frank-w@public-files.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 2 Aug 2020 08:03:53 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8nm0KDHFzOX9+qTTHOUd0Vik063J+rScu_y-hTBTkrCQ@mail.gmail.com>
Message-ID: <CAAOTY_8nm0KDHFzOX9+qTTHOUd0Vik063J+rScu_y-hTBTkrCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] drm/mediatek: config component output by device
 node port
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:18=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> From: Bibby Hsieh <bibby.hsieh@mediatek.com>
>
> We can select output component by decive node port.
> Main path default output component is DSI.
> External path default output component is DPI.
>
> without this Patch i get this warning:
>
> WARNING: CPU: 3 PID: 70 at drivers/gpu/drm/drm_mode_config.c:621 drm_mode=
_config_validate+0x1d8/0x258
>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
>
> added small fixes for warnings
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> ---

[snip]

>
> -static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] =3D {
> +static enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] =3D {
>         DDP_COMPONENT_OVL1,
>         DDP_COMPONENT_COLOR1,
>         DDP_COMPONENT_GAMMA,
> @@ -459,6 +466,7 @@ static int mtk_drm_probe(struct platform_device *pdev=
)
>
>         /* Iterate over sibling DISP function blocks */
>         for_each_child_of_node(phandle->parent, node) {
> +               struct device_node *port, *ep, *remote;
>                 const struct of_device_id *of_id;
>                 enum mtk_ddp_comp_type comp_type;
>                 int comp_id;
> @@ -522,6 +530,32 @@ static int mtk_drm_probe(struct platform_device *pde=
v)
>
>                         private->ddp_comp[comp_id] =3D comp;
>                 }
> +
> +               if (comp_type !=3D MTK_DSI && comp_type !=3D MTK_DPI) {
> +                       port =3D of_graph_get_port_by_id(node, 0);
> +                       if (!port)
> +                               continue;
> +                       ep =3D of_get_child_by_name(port, "endpoint");
> +                       of_node_put(port);
> +                       if (!ep)
> +                               continue;
> +                       remote =3D of_graph_get_remote_port_parent(ep);
> +                       of_node_put(ep);
> +                       if (!remote)
> +                               continue;
> +                       of_id =3D of_match_node(mtk_ddp_comp_dt_ids, remo=
te);
> +                       if (!of_id)
> +                               continue;
> +                       comp_type =3D (enum mtk_ddp_comp_type)of_id->data=
;
> +                       for (i =3D 0; i < private->data->main_len - 1; i+=
+)
> +                               if (private->data->main_path[i] =3D=3D co=
mp_id)
> +                                       private->data->main_path[i + 1] =
=3D
> +                                       mtk_ddp_comp_get_id(node, comp_ty=
pe);
> +                       for (i =3D 0; i < private->data->ext_len - 1; i++=
)
> +                               if (private->data->ext_path[i] =3D=3D com=
p_id)
> +                                       private->data->ext_path[i + 1] =
=3D
> +                                       mtk_ddp_comp_get_id(node, comp_ty=
pe);
> +               }

The port property is not defined in binding document [1], so define it
in binding document first.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt?h=3Dv=
5.8-rc7

Regards,
Chun-Kuang.

>         }
>
>         if (!private->mutex_node) {
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.h
> index b5be63e53176..7fcaab648bf1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -21,9 +21,9 @@ struct drm_property;
>  struct regmap;
>
>  struct mtk_mmsys_driver_data {
> -       const enum mtk_ddp_comp_id *main_path;
> +       enum mtk_ddp_comp_id *main_path;
>         unsigned int main_len;
> -       const enum mtk_ddp_comp_id *ext_path;
> +       enum mtk_ddp_comp_id *ext_path;
>         unsigned int ext_len;
>         const enum mtk_ddp_comp_id *third_path;
>         unsigned int third_len;
> --
> 2.25.1
>
