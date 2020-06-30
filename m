Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062ABC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D098C20771
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593558162;
	bh=QkyR9JiwolvElGEGF/cV1+0xBBGtnLf0/3SbL34qgpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kKarK2oju0xdZhi7AWv5WvfTDoInZWmgCD9P3YCD3sF00qa+CHRoytgDN8CSTLQBF
	 +vtwL1enDm7GivGyEYXlZ3KNqrl3q/ZmxFn+v2VxvDrHzqOxKLhfn4grl1SHx2qdFM
	 Hbg41vCY0zl/R7wPbKBLAFVTPo8CxeJi+hGi5tfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgF3XCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgF3XCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:02:40 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D92B2078B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593558159;
        bh=QkyR9JiwolvElGEGF/cV1+0xBBGtnLf0/3SbL34qgpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bsZzqAs/CQsUje3SYIxEeJr3nJwN9lvEK2Iun7NjgBPNamVd8XFpfPejuEpSIMq3t
         vfgKg02hOmdYFmlosepYDy8AGJY4hWVus/w4WzEMGu+Sc2qy2GtyGpQwlr76Hck1tN
         NnBOtgNtnFVYnjmr0VSn4OsE6HJRVzE+hhaCrlok=
Received: by mail-ed1-f43.google.com with SMTP id by13so7968022edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:02:39 -0700 (PDT)
X-Gm-Message-State: AOAM5324fI5m3yPCAiN/yQvOEzhiLh0JBNXGHwX/d/H4TOS1tZwt+1WF
        Q1pqEadcNP+9wSKlu7cR43+tlCesSOAK0TpMKQ==
X-Google-Smtp-Source: ABdhPJyd7wUB7S5V0t31ySZM0YeWDlaeEMvY3ludSAy+MeqYX3ItuaiYsdmmkpUrY0ZQ3WoSwWDazpYXnVgFsZwNSzI=
X-Received: by 2002:a05:6402:203c:: with SMTP id ay28mr15041128edb.271.1593558158062;
 Tue, 30 Jun 2020 16:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200615203108.786083-1-enric.balletbo@collabora.com>
 <20200620213302.GC74146@ravnborg.org> <593a4666-d6aa-7d16-f3a0-ba3713047d84@collabora.com>
 <CAAOTY_9ZHemp0U76_oPjwy-XoTRXW108UMD_9JVnNXndNNsiTw@mail.gmail.com> <43e5b273-d156-beea-bcfb-cc61b190a671@collabora.com>
In-Reply-To: <43e5b273-d156-beea-bcfb-cc61b190a671@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 1 Jul 2020 07:02:27 +0800
X-Gmail-Original-Message-ID: <CAAOTY__633cG2ki088ozN3f_seLBv9MkRSSsGudCWgP2GBKGmg@mail.gmail.com>
Message-ID: <CAAOTY__633cG2ki088ozN3f_seLBv9MkRSSsGudCWgP2GBKGmg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/7] Convert mtk-dsi to drm_bridge API and get
 EDID for ps8640 bridge
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
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
=B47=E6=9C=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:02=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On 30/6/20 18:26, Chun-Kuang Hu wrote:
> > Hi, Enric:
> >
> > Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=
=B9=B46=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:34=E5=
=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> Hi Sam, Chun-Kuan,
> >>
> >> On 20/6/20 23:33, Sam Ravnborg wrote:
> >>> Hi Enric
> >>>
> >>> On Mon, Jun 15, 2020 at 10:31:01PM +0200, Enric Balletbo i Serra wrot=
e:
> >>>> (This resend is to fix some trivial conflicts due the merge window)
> >>>>
> >>>> The PS8640 dsi-to-eDP bridge driver is using the panel bridge API,
> >>>> however, not all the components in the chain have been ported to the
> >>>> drm_bridge API. Actually, when a panel is attached the default panel=
's mode
> >>>> is used, but in some cases we can't get display up if mode getting f=
rom
> >>>> eDP control EDID is not chosen.
> >>>>
> >>>> This series address that problem, first implements the .get_edid()
> >>>> callback in the PS8640 driver (which is not used until the conversio=
n is
> >>>> done) and then, converts the Mediatek DSI driver to use the drm_brid=
ge
> >>>> API.
> >>>>
> >>>> As far as I know, we're the only users of the mediatek dsi driver in
> >>>> mainline, so should be safe to switch to the new chain of drm_bridge=
 API
> >>>> unconditionally.
> >>>>
> >>>> The patches has been tested on a Acer Chromebook R13 (Elm) running a
> >>>> Chrome OS userspace and checking that the valid EDID mode reported b=
y
> >>>> the bridge is selected.
> >>>>
> >>>> Changes in v4:
> >>>> - Remove double call to drm_encoder_init(). (Chun-Kuang Hu)
> >>>> - Cleanup the encoder in mtk_dsi_unbind(). (Chun-Kuang Hu)
> >>>>
> >>>> Changes in v3:
> >>>> - Replace s/bridge/next bridge/ for comment. (Laurent Pinchart)
> >>>> - Add the bridge.type. (Laurent Pinchart)
> >>>> - Use next_bridge field to store the panel bridge. (Laurent Pinchart=
)
> >>>> - Add the bridge.type field. (Laurent Pinchart)
> >>>> - This patch requires https://lkml.org/lkml/2020/4/16/2080 to work
> >>>>   properly.
> >>>> - Move the bridge.type line to the patch that adds drm_bridge suppor=
t. (Laurent Pinchart)
> >>>>
> >>>> Changes in v2:
> >>>> - Do not set connector_type for panel here. (Sam Ravnborg)
> >>>>
> >>>> Enric Balletbo i Serra (7):
> >>>>   drm/bridge: ps8640: Get the EDID from eDP control
> >>>>   drm/bridge_connector: Set default status connected for eDP connect=
ors
> >>>>   drm/mediatek: mtk_dsi: Rename bridge to next_bridge
> >>>>   drm/mediatek: mtk_dsi: Convert to bridge driver
> >>>>   drm/mediatek: mtk_dsi: Use simple encoder
> >>>>   drm/mediatek: mtk_dsi: Use the drm_panel_bridge API
> >>>>   drm/mediatek: mtk_dsi: Create connector for bridges
> >>>
> >>> Patch seems ready to apply. Will they be applied to a mediatek tree
> >>> or to drm-misc-next?
> >>> Or shall we take the first two patches via drm-misc-next, and the
> >>> remaning via a mediatek tree? (I hope not)
> >>>
> >>
> >> I think the only concern is from Chun-Kuan regarding patch 7/7 "drm/me=
diatek:
> >> mtk_dsi: Create connector for bridges" whether we should support the o=
ld API or
> >> not, but the discussion stalled.
> >>
> >
> > I get more clear now. In patch 7/7,
> >
> > ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
> >                                         DRM_BRIDGE_ATTACH_NO_CONNECTOR)=
;
> >
> > this would call into mtk_dsi_bridge_attach() first, and then call into
> > panel_bridge_attach() next. So panel_bridge_attach() would receive
> > DRM_BRIDGE_ATTACH_NO_CONNECTOR and it return immediately so it does
> > not call drm_panel_attach(). So where do you call drm_panel_attach()?
> >
>
> Why I need to call drm_panel_attach?
>
> I believe drm_panel_attach() was to attach a panel to a connector, but we=
 don't
> need to do this with the new API as the connector is already created and
> attached to the "dummy" encoder.
>
> Makes that sense to you? What do you think will not work if I don't call
> drm_panel_attach?
>
> [1]
> https://elixir.bootlin.com/linux/v5.8-rc3/source/drivers/gpu/drm/drm_pane=
l.c#L101
>

Sorry, I do not notice this. So for patch 7/7,

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

and I would take this series into my tree later, thanks.

Regards,
Chun-Kuang.

> Regards,
>  Enric
>
>
> > Regards,
> > Chun-Kuang.
> >
> >> Thanks,
> >>  Enric
> >>
> >>
> >>
> >>>       Sam
> >>>
> >>>
> >>>>
> >>>>  drivers/gpu/drm/bridge/parade-ps8640.c |  12 ++
> >>>>  drivers/gpu/drm/drm_bridge_connector.c |   1 +
> >>>>  drivers/gpu/drm/mediatek/mtk_dsi.c     | 269 ++++++++--------------=
---
> >>>>  3 files changed, 97 insertions(+), 185 deletions(-)
> >>>>
> >>>> --
> >>>> 2.27.0
> >>>>
> >>>> _______________________________________________
> >>>> dri-devel mailing list
> >>>> dri-devel@lists.freedesktop.org
> >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>>
> >
