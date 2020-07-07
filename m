Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A732CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85845206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594162905;
	bh=4qJEKQQJcDJ7ghgfJoXN9/TcliJkC9rBFhJEq8AKAaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w+jTBEreuUvvAcOkantBicGojpMcGSP2rCjiRgJNzzQ779Vw76yehFKxhdmm5XAXI
	 7T1bcMu6BSXiGN5TTzG+4qu6Y0rJu5sNH4DqV39wl0rrP/TyXUH3Q0+dLBlC3JaPaV
	 MSamEjaShLjpFtK2FNnRMrsSE1b4OqD0gL4ex0Yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgGGXBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgGGXBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 19:01:30 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542E32075B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 23:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594162889;
        bh=4qJEKQQJcDJ7ghgfJoXN9/TcliJkC9rBFhJEq8AKAaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pid8eg/X7TWu5oQ8D71nKDtkDO8KtHQjV+IIyaY5BUtDBgetVYrRuZ9TlpnFwDDK+
         Wd2CW2uDvrIhRkC5CSjvo/bz4xcCA4p54ZKnG7J8XZdeBTen2XI63NHEI9flHq48W0
         Gn2Ct2XkGWr8+Kz54wmfV/L6UEuVdOgYCBktcIPA=
Received: by mail-ed1-f50.google.com with SMTP id d15so40111951edm.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 16:01:29 -0700 (PDT)
X-Gm-Message-State: AOAM531/sXrpivgNih3LpFmZpw8bRUTgI9om99+Wj8nOC3rrUVEYqB4I
        Y3UDFlU+LqogWPje53rjC7GMqVREQfuddrCeaA==
X-Google-Smtp-Source: ABdhPJwN63+iLNiej03gzID1NxPCPP+r0o1MDFI0VjDfCehdz0KEDSLVG+M6Dv9Ka1UwMaw0JXkczgR7RHvqXl9MfPE=
X-Received: by 2002:a05:6402:203c:: with SMTP id ay28mr54721396edb.271.1594162887967;
 Tue, 07 Jul 2020 16:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com> <1594136714-11650-10-git-send-email-dennis-yc.hsieh@mediatek.com>
In-Reply-To: <1594136714-11650-10-git-send-email-dennis-yc.hsieh@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 8 Jul 2020 07:01:17 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-BKW9jbGD5-Un=xagRWizOXaBrvvfdQV7TyzhYWuS8Ag@mail.gmail.com>
Message-ID: <CAAOTY_-BKW9jbGD5-Un=xagRWizOXaBrvvfdQV7TyzhYWuS8Ag@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] drm/mediatek: reduce clear event
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
> No need to clear event again since event always clear before wait.
> This fix depend on patch:
>   "soc: mediatek: cmdq: add clear option in cmdq_pkt_wfe api"

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Fixes: 2f965be7f9008 ("drm/mediatek: apply CMDQ control flow")
> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index c84e7a14d4a8..ba6cf956b239 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -490,7 +490,7 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_crt=
c *mtk_crtc)
>                 mbox_flush(mtk_crtc->cmdq_client->chan, 2000);
>                 cmdq_handle =3D cmdq_pkt_create(mtk_crtc->cmdq_client, PA=
GE_SIZE);
>                 cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
> -               cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, true);
> +               cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
>                 mtk_crtc_ddp_config(crtc, cmdq_handle);
>                 cmdq_pkt_finalize(cmdq_handle);
>                 cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_handl=
e);
> --
> 1.7.9.5
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
