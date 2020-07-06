Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3439C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB45B206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594079187;
	bh=lYWewh87S6iH9k7zGUREHZUS5ol9uho3JTnBeQHhE58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D2N/vaYfhDSGc3iw/UsGJqXCd5MFn/kCQDBA21vJ2z+2PqedOdLK+pFZLZ0WtZZEr
	 YMXFXeLkJe8TIHdiZU8wJC4OLV9skNP76KBebkVC7JTtddUSysu5QlinggHlb3NCgA
	 oKGbFePmXhx3WQMOos0uS5kbS6CLxYPtcr0zUh2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGFXq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgGFXqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:46:25 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9842620760
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 23:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594079184;
        bh=lYWewh87S6iH9k7zGUREHZUS5ol9uho3JTnBeQHhE58=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NARFzwOm3YVKZH09KaLqpfEeS2eC8rMGgFftP3bgk+g3SBS8iHhqEHgHLVxVUyuMJ
         wfI50V4h8I1RJzuggmkSLZjm5n26cZ3XfQoy8KFkCqaZVNinHHaspgFXigDN86xrKP
         TOom6C9OqO6tSK2hdgUtTFhfiBf4kkbTOgGTn19c=
Received: by mail-ej1-f54.google.com with SMTP id w6so44702337ejq.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 16:46:24 -0700 (PDT)
X-Gm-Message-State: AOAM531im4dTTdL8NBm6wreQ3IDPHlwSZDRn7pDQ0asa7+uT9kikhend
        HAvsta0bDh4VpR54v2aVUtUd/JvmfaxxtAfgxA==
X-Google-Smtp-Source: ABdhPJyY/xIkGPmPXd57FlHxva/9PVuURne2hf7iyK2dKHds7uxq2Q26oYLqSaBaS7NAKp66WlYlOteC/nvWbHayRsg=
X-Received: by 2002:a17:906:404e:: with SMTP id y14mr44259469ejj.260.1594079183128;
 Mon, 06 Jul 2020 16:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <1593931715-32761-1-git-send-email-dennis-yc.hsieh@mediatek.com> <1593931715-32761-9-git-send-email-dennis-yc.hsieh@mediatek.com>
In-Reply-To: <1593931715-32761-9-git-send-email-dennis-yc.hsieh@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 7 Jul 2020 07:46:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-5um+X=cS3rkuN7YHycK2AyJsovumCQ4t+dbwXw62uAQ@mail.gmail.com>
Message-ID: <CAAOTY_-5um+X=cS3rkuN7YHycK2AyJsovumCQ4t+dbwXw62uAQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] soc: mediatek: cmdq: add clear option in
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
=9C=886=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:20=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> Add clear parameter to let client decide if
> event should be clear to 0 after GCE receive it.
>
> Fixes: 2f965be7f9008 ("drm/mediatek: apply CMDQ control flow")

I think this patch include two things, one is bug fix, another is
changing interface.
below is the bug fix part.

-#define CMDQ_WFE_OPTION                        (CMDQ_WFE_UPDATE |
CMDQ_WFE_WAIT | \
-                                       CMDQ_WFE_WAIT_VALUE)
+#define CMDQ_WFE_OPTION                        (CMDQ_WFE_WAIT |
CMDQ_WFE_WAIT_VALUE)

the other is changing interface part. So this patch should be broken
into two patches.

Regards,
Chun-Kuang.

> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |    2 +-
>  drivers/soc/mediatek/mtk-cmdq-helper.c   |    5 +++--
>  include/linux/mailbox/mtk-cmdq-mailbox.h |    3 +--
>  include/linux/soc/mediatek/mtk-cmdq.h    |    5 +++--
>  4 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index ec6c9ffbf35e..ba6cf956b239 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -490,7 +490,7 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_crt=
c *mtk_crtc)
>                 mbox_flush(mtk_crtc->cmdq_client->chan, 2000);
>                 cmdq_handle =3D cmdq_pkt_create(mtk_crtc->cmdq_client, PA=
GE_SIZE);
>                 cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
> -               cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event);
> +               cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
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
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
