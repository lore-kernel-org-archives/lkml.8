Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26F9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A9C20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aD0MZqxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgFVPcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgFVPcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:32:32 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F379AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:32:31 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t8so16292866ilm.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVOaPuKG0WedL7m6XG4ePzXgp0WJooLMXgeknREAmGE=;
        b=aD0MZqxcuG8wLlczv4aauaJmYLYPjjKyOvYUTKoDM8y2jTXwSEaKraPuu//1jWa0Yt
         n4RDREofpThN03Ue0aESzvfzdMnC2QeD3Uv3m/43lF+HgMfTvR8b3k38eMHUyc0EaKZ2
         ntjL1GEYrh9r8iB4BLpJE5+AiY0Zk0Ph1cPE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVOaPuKG0WedL7m6XG4ePzXgp0WJooLMXgeknREAmGE=;
        b=X7KkZEwa2rweeDe8GvSFsLsQzOIRNjKgYriibrlBJK9pRlgiW3hGDGTr5xSq9DF1Ve
         ZTmVzwCWvmbbl1DDNqK9QwXbfpzlW6IQoe4I3Uj/SVuite50sDwuWGy7/zdKsGOJhHZv
         Bx073JA7OgnbV4hT4v3Sp+sAAAYTS7FajJCJGgRKAFHHlidNRy79F8lRH4uavk7DkIyb
         s+AZRQcjjwDQMieeODY6MMQnlKoGyyMcHkxvagGA/OZ4xDIRVYk3H7jVGj5kI6HIwd78
         SQ3H2C8v4H3YRh/LB9tK1pIVR7ELqpVNkOqk3S+5IALptbd93TsSWkJ+6VjJzhHtXi4O
         +TvA==
X-Gm-Message-State: AOAM532ONjyIEH8fD7kcUAvf6ChtrPaE0dEhjhwdwXNWTObrO3uMMmtz
        BPQd5X4HxQNyrMdLv0S9PVc2f/1SDQ7uwGrVl+t7LA==
X-Google-Smtp-Source: ABdhPJyTqIDXVzE4w4P2apwayVscDjgB37tlXDW3/iCEMtbHjWEftO/iuEoA0KoUfM8LI18JEWWyrodeH1OAQfAbAW8=
X-Received: by 2002:a92:d0cc:: with SMTP id y12mr17275492ila.308.1592839951224;
 Mon, 22 Jun 2020 08:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200622150109.91205-1-hsinyi@chromium.org> <20200622152014.GA260716@chromium.org>
In-Reply-To: <20200622152014.GA260716@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 22 Jun 2020 23:32:05 +0800
Message-ID: <CAJMQK-gpxG_vj-9hOBT-Pw6H9KAOEKJ6r+MJfa0ND_9839rQ9w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: check plane visibility in atomic_update
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:20 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Hsin-Yi,
>
> On Mon, Jun 22, 2020 at 11:01:09PM +0800, Hsin-Yi Wang wrote:
> > Disable the plane if it's not visible. Otherwise mtk_ovl_layer_config()
> > would proceed with invalid plane and we may see vblank timeout.
> >
> > Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> > v2: Add fixes tag
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> >
>
> Thank you for the patch. Please see my comments inline.
>
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > index c2bd683a87c8..74dc71c7f3b6 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > @@ -164,6 +164,16 @@ static int mtk_plane_atomic_check(struct drm_plane *plane,
> >                                                  true, true);
> >  }
> >
> > +static void mtk_plane_atomic_disable(struct drm_plane *plane,
> > +                                  struct drm_plane_state *old_state)
> > +{
> > +     struct mtk_plane_state *state = to_mtk_plane_state(plane->state);
> > +
> > +     state->pending.enable = false;
> > +     wmb(); /* Make sure the above parameter is set before update */
> > +     state->pending.dirty = true;
> > +}
> > +
> >  static void mtk_plane_atomic_update(struct drm_plane *plane,
> >                                   struct drm_plane_state *old_state)
> >  {
> > @@ -178,6 +188,9 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
> >       if (!crtc || WARN_ON(!fb))
> >               return;
> >
> > +     if (!plane->state->visible)
> > +             return mtk_plane_atomic_disable(plane, old_state);
>
> nit: Both this function and mtk_plane_atomic_disable() have the void return
> type. Perhaps we should rather move the return, without a value, to a
> separate statement?
Updated in v3, thanks.

>
> Best regards,
> Tomasz
