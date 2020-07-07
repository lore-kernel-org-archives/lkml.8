Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283B7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19B62065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594163060;
	bh=EhWbqaZmzsXrJaeaaTa9oa/wuFRN2GqSFupG2BL65vs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yXZPBAgSJcFYh4X4dWvNzh+gRslj+E9k57hqt3yl0CjLhZtEyUrwnyKmsR7RgWJiR
	 fXo4jN6BuECWFdzhdcM0prfpTYvtVH7Xkk7VteJeSC7C/UJubXuPzhIKnKcUpoWQco
	 P8lNvESOx0Y89knWjLmE4DJmdU3z7iFl+QwYdJJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgGGXES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729196AbgGGXEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 19:04:16 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 708442065D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 23:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594163055;
        bh=EhWbqaZmzsXrJaeaaTa9oa/wuFRN2GqSFupG2BL65vs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2j+WigMMCy0EWqbFXaQS29d/sonlcCSlyGxpLyno0CWRcGuMipY0rCR1Kixv7oH2t
         bSDyDvtpPtPVj5EN4VFaMODBJWpLVaGePDfo2A77wxILRxwsNOGZGkWvAxLdl1avBg
         KtywLJOY3k3TBpwNgjqCcYtYWoo/VLYSRIHTAFCo=
Received: by mail-ej1-f47.google.com with SMTP id dr13so48464113ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 16:04:15 -0700 (PDT)
X-Gm-Message-State: AOAM533taLOfLxc38yOXhn4Tk/6E87BkI6zBN+oJrkDFJdGSpL+5XtF8
        j0ahajmTvduPY21Zu83pi+cP6eXNu9tJxgSLOA==
X-Google-Smtp-Source: ABdhPJxprTd+dID67KymjoMlkTb45ievUJV+INwGOVc0ao2/LY+zUwpER680dwt517Xc1x3bJeVEYifxQKbqdDNuaaU=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr48868098ejb.124.1594163054098;
 Tue, 07 Jul 2020 16:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com> <1594136714-11650-9-git-send-email-dennis-yc.hsieh@mediatek.com>
In-Reply-To: <1594136714-11650-9-git-send-email-dennis-yc.hsieh@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 8 Jul 2020 07:04:03 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Dj3WjYsLYhP8FfdTfCv0ddv73HmUcT=8x6bT1qP=ADA@mail.gmail.com>
Message-ID: <CAAOTY_9Dj3WjYsLYhP8FfdTfCv0ddv73HmUcT=8x6bT1qP=ADA@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] soc: mediatek: cmdq: add clear option in
 cmdq_pkt_wfe api
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        HS Liao <hs.liao@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dennis:

Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=
=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:47=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> Add clear parameter to let client decide if
> event should be clear to 0 after GCE receive it.

For DRM part,

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Change since v2:
> - Keep behavior in drm crtc driver and
>   separate bug fix code into another patch.
>
> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |    2 +-
>  drivers/soc/mediatek/mtk-cmdq-helper.c   |    5 +++--
>  include/linux/mailbox/mtk-cmdq-mailbox.h |    3 +--
>  include/linux/soc/mediatek/mtk-cmdq.h    |    5 +++--
>  4 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index ec6c9ffbf35e..c84e7a14d4a8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -490,7 +490,7 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_crt=
c *mtk_crtc)
>                 mbox_flush(mtk_crtc->cmdq_client->chan, 2000);
>                 cmdq_handle =3D cmdq_pkt_create(mtk_crtc->cmdq_client, PA=
GE_SIZE);
>                 cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
> -               cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event);
> +               cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, true);
>                 mtk_crtc_ddp_config(crtc, cmdq_handle);
>                 cmdq_pkt_finalize(cmdq_handle);
>                 cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_handl=
e);
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediate=
k/mtk-cmdq-helper.c
> index d55dc3296105..505651b0d715 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -316,15 +316,16 @@ int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pk=
t, u8 high_addr_reg_idx,
>  }
>  EXPORT_SYMBOL(cmdq_pkt_write_s_mask_value);
>
> -int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event)
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
>  {
>         struct cmdq_instruction inst =3D { {0} };
> +       u32 clear_option =3D clear ? CMDQ_WFE_UPDATE : 0;
>
>         if (event >=3D CMDQ_MAX_EVENT)
>                 return -EINVAL;
>
>         inst.op =3D CMDQ_CODE_WFE;
> -       inst.value =3D CMDQ_WFE_OPTION;
> +       inst.value =3D CMDQ_WFE_OPTION | clear_option;
>         inst.event =3D event;
>
>         return cmdq_pkt_append_command(pkt, inst);
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mai=
lbox/mtk-cmdq-mailbox.h
> index efbd8a9eb2d1..d5a983d65f05 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -28,8 +28,7 @@
>   * bit 16-27: update value
>   * bit 31: 1 - update, 0 - no update
>   */
> -#define CMDQ_WFE_OPTION                        (CMDQ_WFE_UPDATE | CMDQ_W=
FE_WAIT | \
> -                                       CMDQ_WFE_WAIT_VALUE)
> +#define CMDQ_WFE_OPTION                        (CMDQ_WFE_WAIT | CMDQ_WFE=
_WAIT_VALUE)
>
>  /** cmdq event maximum */
>  #define CMDQ_MAX_EVENT                 0x3ff
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/me=
diatek/mtk-cmdq.h
> index 34354e952f60..960704d75994 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -182,11 +182,12 @@ int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pk=
t, u8 high_addr_reg_idx,
>  /**
>   * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
>   * @pkt:       the CMDQ packet
> - * @event:     the desired event type to "wait and CLEAR"
> + * @event:     the desired event type to wait
> + * @clear:     clear event or not after event arrive
>   *
>   * Return: 0 for success; else the error code is returned
>   */
> -int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event);
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear);
>
>  /**
>   * cmdq_pkt_clear_event() - append clear event command to the CMDQ packe=
t
> --
> 1.7.9.5
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
