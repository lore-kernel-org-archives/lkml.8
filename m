Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6A0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCAE207CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590366210;
	bh=3fQWdb2Uv3qePojZmO+4tSxfnjltQG0nFeUsHQam6o4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0TFDXU0OymHB2UBTIYDMAyq6+ul9ov9bJCZNhQ+9adIH/7HynMSI4ELy2KwPlAJcn
	 DSY1AGHe60JdpAu6VjRcJYzI/m6TPOMVN0JA6KvM5JYvk4LK9Mz04qM9ScYpiGm+0W
	 7snFmWRX5e1C4MmlXPeQG+jaGGukFQ36ju7tB1tU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbgEYAXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 20:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388300AbgEYAX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 20:23:28 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6BBA208A7;
        Mon, 25 May 2020 00:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590366207;
        bh=3fQWdb2Uv3qePojZmO+4tSxfnjltQG0nFeUsHQam6o4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SSsZhLY9EfC5qU/BYZB5juZ2bjSbJoVAyMNtCB7kiCirQUkaYGHR55KJ0c1fF7/Ef
         VbIV+wO8v8USBpPo7WhacJSxyY2972LW49K4/yNGsQd4kX8QkJ8G82crzuzRp9LtTq
         tAeBF9wRdr/GFOIc6eBUm4nZKEJx0SEgWEXwPRpQ=
Received: by mail-ej1-f50.google.com with SMTP id a2so18816543ejb.10;
        Sun, 24 May 2020 17:23:26 -0700 (PDT)
X-Gm-Message-State: AOAM530S26jD8Jr8H/JpKR5g8LM3hmU2WPPknN709idSyIpM0dG2A4p0
        AUrN7kwYg33mzU3mLZEey2lI130fXxGH/RyjHQ==
X-Google-Smtp-Source: ABdhPJwUQS45aN6Ho1zx5rWy7SPdbMvS7/nnetQcqChrnsfFeME43g1GOq9VgR+o2PMTCTxZRcZhBKuPj3a+20kllCw=
X-Received: by 2002:a17:906:3041:: with SMTP id d1mr17295243ejd.7.1590366205137;
 Sun, 24 May 2020 17:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
 <1583664775-19382-11-git-send-email-dennis-yc.hsieh@mediatek.com> <5d6b61b2-23c9-647f-fa22-73e779010bd8@gmail.com>
In-Reply-To: <5d6b61b2-23c9-647f-fa22-73e779010bd8@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 25 May 2020 08:23:13 +0800
X-Gmail-Original-Message-ID: <CAAOTY___HNcRPr8Jq-wNPO_G9pLVjf2D7ezbpPcGbXVNYy1_nA@mail.gmail.com>
Message-ID: <CAAOTY___HNcRPr8Jq-wNPO_G9pLVjf2D7ezbpPcGbXVNYy1_nA@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] soc: mediatek: cmdq: export finalize function
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
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
17=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=882:22=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 08/03/2020 11:52, Dennis YC Hsieh wrote:
> > Export finalize function to client which helps append eoc and jump
> > command to pkt. Let client decide call finalize or not.
> >
> > Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 1 +
> >  drivers/soc/mediatek/mtk-cmdq-helper.c  | 7 ++-----
> >  include/linux/soc/mediatek/mtk-cmdq.h   | 8 ++++++++
> >  3 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/=
mediatek/mtk_drm_crtc.c
> > index 0dfcd1787e65..7daaabc26eb1 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -490,6 +490,7 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_c=
rtc *mtk_crtc)
> >               cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
> >               cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event);
> >               mtk_crtc_ddp_config(crtc, cmdq_handle);
> > +             cmdq_pkt_finalize(cmdq_handle);
> >               cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_handl=
e);
> >       }
> >  #endif
>
> This should be a independent patch.
> Other then that patch looks good.

Apply only drm part or only cmdq helpr part, it would be abnormal.
Shall we seperate this patch?
Or seperate it but make sure these two patches be in the same tree?

Regards,
Chun-Kuang.

>
> > diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/media=
tek/mtk-cmdq-helper.c
> > index a9ebbabb7439..59bc1164b411 100644
> > --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> > +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > @@ -372,7 +372,7 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_i=
dx, u32 value)
> >  }
> >  EXPORT_SYMBOL(cmdq_pkt_assign);
> >
> > -static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> > +int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> >  {
> >       struct cmdq_instruction inst =3D { {0} };
> >       int err;
> > @@ -392,6 +392,7 @@ static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> >
> >       return err;
> >  }
> > +EXPORT_SYMBOL(cmdq_pkt_finalize);
> >
> >  static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
> >  {
> > @@ -426,10 +427,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmd=
q_async_flush_cb cb,
> >       unsigned long flags =3D 0;
> >       struct cmdq_client *client =3D (struct cmdq_client *)pkt->cl;
> >
> > -     err =3D cmdq_pkt_finalize(pkt);
> > -     if (err < 0)
> > -             return err;
> > -
> >       pkt->cb.cb =3D cb;
> >       pkt->cb.data =3D data;
> >       pkt->async_cb.cb =3D cmdq_pkt_flush_async_cb;
> > diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/=
mediatek/mtk-cmdq.h
> > index fec292aac83c..99e77155f967 100644
> > --- a/include/linux/soc/mediatek/mtk-cmdq.h
> > +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> > @@ -213,6 +213,14 @@ int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 su=
bsys,
> >   */
> >  int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value);
> >
> > +/**
> > + * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
> > + * @pkt:     the CMDQ packet
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + */
> > +int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
> > +
> >  /**
> >   * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the=
 CMDQ
> >   *                          packet and call back at the end of done pa=
cket
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
