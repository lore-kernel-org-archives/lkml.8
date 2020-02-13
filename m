Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D047DC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF162168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoSPPLB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgBMOBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:01:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44362 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbgBMOBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:01:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id v195so5683258qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 06:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwvJtBvLYgXHz2Xkjo28kGnQcGUFvmoCc8Tq+skqxFM=;
        b=WoSPPLB6quBGtBpRywwrlPUN/efg7Ughe/HaH3khTmKhm8TtRvn1omHwpi/Uje11Nc
         pJJ434RD5vc6K56AF1flgXq7rGgQL4eIbgy0vNQWX3Ilo6r1XlrPGVcQUkzDZJVdNAqL
         CQWRmZ6MDJKjdXiViv85LIZth9OYzoQf4NKp2R4S9uMoWLn4jAzJvRHErhw/tberXn1U
         afxPCPN8yIbn8R73x0dy1qStRMFKKk0TU7EJIVtQo9A5/go6CKtMqKAybDD7f1leMzbr
         RkHP02AhsZ8v09CuFrX1byfuhGihLXF2U77kvpA2MNTc/JMV0yrMCE7PJN/PnIDh9OCX
         EVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwvJtBvLYgXHz2Xkjo28kGnQcGUFvmoCc8Tq+skqxFM=;
        b=fKKFwfSsDflt2/E4MEl9M/z7OTpAt0nPJGQVqJ1mdFjAFwJXCErO/DzgFO/JeaWfUY
         t+TdXxlChcjILpxosFBWGzy4BfrMcOovjdTdHcLJ5YApS6gPmrCnmLpcH0QESHkaOhca
         TwO+/RHXFnIqIuxUwwcwbwzgxiGMEILJY8937EVMnxS6B5lOcPl1drlefrqKglXNuzRC
         2PtK4A6VVcofyili/ycUsQulXF7lCGBvg9XKexuuOxhIsoXO6r4H7wcJOHMuMyuJ3FQr
         huXJ90AcTImgbIRbbAxD/tfrwiPLb5ECtXdJRyzu+nQxkd1h0GLv0Q7Jn+S8jifLdH5V
         5UWQ==
X-Gm-Message-State: APjAAAWBbIZHXckkTFTBlLzknXqPm1wupSstMBQu/Wlx958pHb0bROgg
        S+NKfCtXxiM2rJoN8fDSiFhKwoF8nlJAQqAf+jk=
X-Google-Smtp-Source: APXvYqyjD4OX/YI4q5ugfE3GeGjRdg6xfub/ylaaIdK2920TyQEJp7ys7DWIVv34YSpAoPAjOFPsF7u/zxzxnLNIOJE=
X-Received: by 2002:a37:a642:: with SMTP id p63mr16214664qke.85.1581602456914;
 Thu, 13 Feb 2020 06:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20200213012353.26815-1-bibby.hsieh@mediatek.com>
 <20200213012353.26815-2-bibby.hsieh@mediatek.com> <1581566763.12071.1.camel@mtksdaap41>
In-Reply-To: <1581566763.12071.1.camel@mtksdaap41>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 13 Feb 2020 15:00:45 +0100
Message-ID: <CAFqH_51r8CvBz3J-TffYaMsZQwX=hdDVjEz9+BmBeC=QurP7Ug@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/mediatek: add fb swap in async_update
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missatge de CK Hu <ck.hu@mediatek.com> del dia dj., 13 de febr. 2020 a les 5:06:
>
> Hi, Bibby:
>
> On Thu, 2020-02-13 at 09:23 +0800, Bibby Hsieh wrote:
> > Besides x, y position, width and height,
> > fb also need updating in async update.
> >
>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
>
> > Fixes: 920fffcc8912 ("drm/mediatek: update cursors by using async atomic update")
> >
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---

This patch actually fixes two issues as explained in [1], I send the
patch without seeing that another one was already sent. Both do the
same thing. So,

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

[1] https://lkml.org/lkml/2020/2/13/286

> >  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > index d32b494ff1de..e084c36fdd8a 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > @@ -122,6 +122,7 @@ static void mtk_plane_atomic_async_update(struct drm_plane *plane,
> >       plane->state->src_y = new_state->src_y;
> >       plane->state->src_h = new_state->src_h;
> >       plane->state->src_w = new_state->src_w;
> > +     swap(plane->state->fb, new_state->fb);
> >       state->pending.async_dirty = true;
> >
> >       mtk_drm_crtc_async_update(new_state->crtc, plane, new_state);
>
> --
> CK Hu <ck.hu@mediatek.com>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
