Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6CEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E22F20787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590403745;
	bh=JaNm1pxHcdFTHEfcWnLgCfYCRUWqjIyOO1ppdiFyTcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fDNdFfWXfhQ952QX7yTGcl5Kd6/8bNUjuS/9njwYdO/Of3W0HeLn9LKjmwtrpv2MO
	 o6ry/wuw4leKTcyAVGOBwl7OPrUktve1BTrly1WJh+71kMKSjT5XOV6SjneN75Fl2H
	 LhBXoUT4mkWn++UT+QY2AIO4uAKJWLBhhYRDY1Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbgEYKtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbgEYKtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:49:04 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D6FA2087D;
        Mon, 25 May 2020 10:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590403743;
        bh=JaNm1pxHcdFTHEfcWnLgCfYCRUWqjIyOO1ppdiFyTcA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lPYWdXoLsZG8rS3hIOZGmFgN40dC3sskIRuwGuzRZthWRpNI6st0UPWSlK9kMkicN
         v9ZNg7b0bafIScMH6Vf6ViHNKByDfS96dxewxy+ITnMODvLvUTRYf1ja+gV8wsMPDs
         YR9m4QMnLJy5Xvjj4wl1TqwuqvKYVccljxeL4Ygo=
Received: by mail-ej1-f43.google.com with SMTP id d7so20042238eja.7;
        Mon, 25 May 2020 03:49:03 -0700 (PDT)
X-Gm-Message-State: AOAM5328kPdpPPHG6dEgfDUBJTNdo5JWZY0K4b9anpZUg8H96pn7AGX2
        yKizKGdohMG+dbgVHKXgZfIUWxQkxjpKvtAF5A==
X-Google-Smtp-Source: ABdhPJxruJfSdjdvgfbq0nfw9fuqGwWMLe3x9BYxE4feLX7uZnfvhAYbXa68e6qGZv8T6tfI5vi5EEB4k5vA7CV2VBE=
X-Received: by 2002:a17:906:bcf8:: with SMTP id op24mr17996305ejb.260.1590403741530;
 Mon, 25 May 2020 03:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
 <1583664775-19382-11-git-send-email-dennis-yc.hsieh@mediatek.com>
 <5d6b61b2-23c9-647f-fa22-73e779010bd8@gmail.com> <CAAOTY___HNcRPr8Jq-wNPO_G9pLVjf2D7ezbpPcGbXVNYy1_nA@mail.gmail.com>
 <e487573a-2252-cd52-3a3d-c271f67fcb9a@gmail.com>
In-Reply-To: <e487573a-2252-cd52-3a3d-c271f67fcb9a@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 25 May 2020 18:48:49 +0800
X-Gmail-Original-Message-ID: <CAAOTY__LHZZc2kuifGQzdjPJLguj2C1F179poupHTr6HR-ub5w@mail.gmail.com>
Message-ID: <CAAOTY__LHZZc2kuifGQzdjPJLguj2C1F179poupHTr6HR-ub5w@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] soc: mediatek: cmdq: export finalize function
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        HS Liao <hs.liao@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2020=E5=B9=B45=E6=9C=88=
25=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:38=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 25/05/2020 02:23, Chun-Kuang Hu wrote:
> > Hi, Matthias:
> >
> > Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2020=E5=B9=B45=E6=
=9C=8817=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=882:22=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >>
> >>
> >>
> >> On 08/03/2020 11:52, Dennis YC Hsieh wrote:
> >>> Export finalize function to client which helps append eoc and jump
> >>> command to pkt. Let client decide call finalize or not.
> >>>
> >>> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
> >>> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> >>> ---
> >>>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 1 +
> >>>  drivers/soc/mediatek/mtk-cmdq-helper.c  | 7 ++-----
> >>>  include/linux/soc/mediatek/mtk-cmdq.h   | 8 ++++++++
> >>>  3 files changed, 11 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_crtc.c
> >>> index 0dfcd1787e65..7daaabc26eb1 100644
> >>> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> >>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> >>> @@ -490,6 +490,7 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm=
_crtc *mtk_crtc)
> >>>               cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event)=
;
> >>>               cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event);
> >>>               mtk_crtc_ddp_config(crtc, cmdq_handle);
> >>> +             cmdq_pkt_finalize(cmdq_handle);
> >>>               cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_han=
dle);
> >>>       }
> >>>  #endif
> >>
> >> This should be a independent patch.
> >> Other then that patch looks good.
> >
> > Apply only drm part or only cmdq helpr part, it would be abnormal.
>
> Right it would break DRM driver (if only applied to cmdq) or compilation =
if only
> applied to DRM.
>
> > Shall we seperate this patch?
>
> After thinking twice, I think we can leave it as it is. If you provide yo=
ur
> Acked-by I can take it thorugh my tree, if that's OK for you.

This is OK for me, so

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Regards,
> Matthias
>
> > Or seperate it but make sure these two patches be in the same tree?
> >
> > Regards,
> > Chun-Kuang.
> >
> >>
> >>> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/med=
iatek/mtk-cmdq-helper.c
> >>> index a9ebbabb7439..59bc1164b411 100644
> >>> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> >>> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> >>> @@ -372,7 +372,7 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg=
_idx, u32 value)
> >>>  }
> >>>  EXPORT_SYMBOL(cmdq_pkt_assign);
> >>>
> >>> -static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> >>> +int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> >>>  {
> >>>       struct cmdq_instruction inst =3D { {0} };
> >>>       int err;
> >>> @@ -392,6 +392,7 @@ static int cmdq_pkt_finalize(struct cmdq_pkt *pkt=
)
> >>>
> >>>       return err;
> >>>  }
> >>> +EXPORT_SYMBOL(cmdq_pkt_finalize);
> >>>
> >>>  static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
> >>>  {
> >>> @@ -426,10 +427,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, c=
mdq_async_flush_cb cb,
> >>>       unsigned long flags =3D 0;
> >>>       struct cmdq_client *client =3D (struct cmdq_client *)pkt->cl;
> >>>
> >>> -     err =3D cmdq_pkt_finalize(pkt);
> >>> -     if (err < 0)
> >>> -             return err;
> >>> -
> >>>       pkt->cb.cb =3D cb;
> >>>       pkt->cb.data =3D data;
> >>>       pkt->async_cb.cb =3D cmdq_pkt_flush_async_cb;
> >>> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/so=
c/mediatek/mtk-cmdq.h
> >>> index fec292aac83c..99e77155f967 100644
> >>> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> >>> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> >>> @@ -213,6 +213,14 @@ int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 =
subsys,
> >>>   */
> >>>  int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value);
> >>>
> >>> +/**
> >>> + * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
> >>> + * @pkt:     the CMDQ packet
> >>> + *
> >>> + * Return: 0 for success; else the error code is returned
> >>> + */
> >>> +int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
> >>> +
> >>>  /**
> >>>   * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute t=
he CMDQ
> >>>   *                          packet and call back at the end of done =
packet
> >>>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
