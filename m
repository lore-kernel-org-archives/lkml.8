Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00536C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C581C206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593534424;
	bh=PpAnJn1XJ0kKZXszzmeCK2//lTYa5JNojd5Sw6KrTkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZNzjWJIwB2QyNa0SAawguaTk2tFSrke5EliN8AIryWlmI7RX8GE08nCEmbZqRT1Q7
	 oxlQKn2Fpe6q62p8vdE/JuV0dRqbeTC2Istk3UZjslxzqcROlUqHfLbzt2+0G9sd5C
	 lQFtpNKsw4DtVbcy3gMeOpFOKSgGbdCgjsRMmueY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbgF3Q1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387434AbgF3Q1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:27:02 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7606D207FB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593534421;
        bh=PpAnJn1XJ0kKZXszzmeCK2//lTYa5JNojd5Sw6KrTkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gts96HYbjen9gTCki14zS8VQMLWdrTPAbFAKJ5yAbAf0efCkpK880dXgpwF1iUO3G
         Y15s9ff6tJA1bpsV2vkRwS8QnGGKc+xZvewQsqunGKS9nOrQ4Rqb4OQyQ604t3NJO4
         +nejn1DOtYixqD+xWpStdaTf7VpphBCXOWkIZ2OQ=
Received: by mail-ed1-f50.google.com with SMTP id by13so6933017edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:27:01 -0700 (PDT)
X-Gm-Message-State: AOAM533AVAJ0+VVEpuKbO2syhy0LiFhrknJMchPKuXy65X2TTK9qYtBQ
        MLI58PcWhPu+7P+DXaiognqqlDrHdNgtD6p3Ww==
X-Google-Smtp-Source: ABdhPJzzR0lmC6L/tSPZZNNP3p4O+oe/PeEBeNY5QR0PicjAWxxqEBWX6AKJHjWXCakLYt6gaZibUhu/HomQIBzuFzs=
X-Received: by 2002:a05:6402:1766:: with SMTP id da6mr23156696edb.48.1593534419986;
 Tue, 30 Jun 2020 09:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200615203108.786083-1-enric.balletbo@collabora.com>
 <20200620213302.GC74146@ravnborg.org> <593a4666-d6aa-7d16-f3a0-ba3713047d84@collabora.com>
In-Reply-To: <593a4666-d6aa-7d16-f3a0-ba3713047d84@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 1 Jul 2020 00:26:49 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9ZHemp0U76_oPjwy-XoTRXW108UMD_9JVnNXndNNsiTw@mail.gmail.com>
Message-ID: <CAAOTY_9ZHemp0U76_oPjwy-XoTRXW108UMD_9JVnNXndNNsiTw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/7] Convert mtk-dsi to drm_bridge API and get
 EDID for ps8640 bridge
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B46=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:34=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> Hi Sam, Chun-Kuan,
>
> On 20/6/20 23:33, Sam Ravnborg wrote:
> > Hi Enric
> >
> > On Mon, Jun 15, 2020 at 10:31:01PM +0200, Enric Balletbo i Serra wrote:
> >> (This resend is to fix some trivial conflicts due the merge window)
> >>
> >> The PS8640 dsi-to-eDP bridge driver is using the panel bridge API,
> >> however, not all the components in the chain have been ported to the
> >> drm_bridge API. Actually, when a panel is attached the default panel's=
 mode
> >> is used, but in some cases we can't get display up if mode getting fro=
m
> >> eDP control EDID is not chosen.
> >>
> >> This series address that problem, first implements the .get_edid()
> >> callback in the PS8640 driver (which is not used until the conversion =
is
> >> done) and then, converts the Mediatek DSI driver to use the drm_bridge
> >> API.
> >>
> >> As far as I know, we're the only users of the mediatek dsi driver in
> >> mainline, so should be safe to switch to the new chain of drm_bridge A=
PI
> >> unconditionally.
> >>
> >> The patches has been tested on a Acer Chromebook R13 (Elm) running a
> >> Chrome OS userspace and checking that the valid EDID mode reported by
> >> the bridge is selected.
> >>
> >> Changes in v4:
> >> - Remove double call to drm_encoder_init(). (Chun-Kuang Hu)
> >> - Cleanup the encoder in mtk_dsi_unbind(). (Chun-Kuang Hu)
> >>
> >> Changes in v3:
> >> - Replace s/bridge/next bridge/ for comment. (Laurent Pinchart)
> >> - Add the bridge.type. (Laurent Pinchart)
> >> - Use next_bridge field to store the panel bridge. (Laurent Pinchart)
> >> - Add the bridge.type field. (Laurent Pinchart)
> >> - This patch requires https://lkml.org/lkml/2020/4/16/2080 to work
> >>   properly.
> >> - Move the bridge.type line to the patch that adds drm_bridge support.=
 (Laurent Pinchart)
> >>
> >> Changes in v2:
> >> - Do not set connector_type for panel here. (Sam Ravnborg)
> >>
> >> Enric Balletbo i Serra (7):
> >>   drm/bridge: ps8640: Get the EDID from eDP control
> >>   drm/bridge_connector: Set default status connected for eDP connector=
s
> >>   drm/mediatek: mtk_dsi: Rename bridge to next_bridge
> >>   drm/mediatek: mtk_dsi: Convert to bridge driver
> >>   drm/mediatek: mtk_dsi: Use simple encoder
> >>   drm/mediatek: mtk_dsi: Use the drm_panel_bridge API
> >>   drm/mediatek: mtk_dsi: Create connector for bridges
> >
> > Patch seems ready to apply. Will they be applied to a mediatek tree
> > or to drm-misc-next?
> > Or shall we take the first two patches via drm-misc-next, and the
> > remaning via a mediatek tree? (I hope not)
> >
>
> I think the only concern is from Chun-Kuan regarding patch 7/7 "drm/media=
tek:
> mtk_dsi: Create connector for bridges" whether we should support the old =
API or
> not, but the discussion stalled.
>

I get more clear now. In patch 7/7,

ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
                                        DRM_BRIDGE_ATTACH_NO_CONNECTOR);

this would call into mtk_dsi_bridge_attach() first, and then call into
panel_bridge_attach() next. So panel_bridge_attach() would receive
DRM_BRIDGE_ATTACH_NO_CONNECTOR and it return immediately so it does
not call drm_panel_attach(). So where do you call drm_panel_attach()?

Regards,
Chun-Kuang.

> Thanks,
>  Enric
>
>
>
> >       Sam
> >
> >
> >>
> >>  drivers/gpu/drm/bridge/parade-ps8640.c |  12 ++
> >>  drivers/gpu/drm/drm_bridge_connector.c |   1 +
> >>  drivers/gpu/drm/mediatek/mtk_dsi.c     | 269 ++++++++----------------=
-
> >>  3 files changed, 97 insertions(+), 185 deletions(-)
> >>
> >> --
> >> 2.27.0
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
