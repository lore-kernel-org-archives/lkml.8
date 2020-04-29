Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7A1C83008
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D182073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgD2ICq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:02:46 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgD2ICm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:02:42 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MplsZ-1iop1226mL-00q6z3 for <linux-kernel@vger.kernel.org>; Wed, 29 Apr
 2020 10:02:41 +0200
Received: by mail-qk1-f176.google.com with SMTP id b188so1081187qkd.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 01:02:41 -0700 (PDT)
X-Gm-Message-State: AGi0PuYUzxkjSCGf7zSNdyF6QHdRSjaweXexQUIvf8xSIqOEjBGVgRlu
        7fseAFSswIMRdu44s1vPJ88KvUaf30d2HmK9n5k=
X-Google-Smtp-Source: APiQypIb7rbzxVNgizgliUE9cuI6uHb2puyxpFpWzxm5GRei060dQZgRQpS434PhF854JL+xI5SHvYYGPatYF2vesJk=
X-Received: by 2002:ae9:f712:: with SMTP id s18mr15249636qkg.394.1588147360437;
 Wed, 29 Apr 2020 01:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200428215408.4111675-1-arnd@arndb.de> <22ee464b-f59a-69a3-b669-f821d567fbf5@ti.com>
In-Reply-To: <22ee464b-f59a-69a3-b669-f821d567fbf5@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Apr 2020 10:02:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2YAe0KPQYQi_PhFvaYeA_4jHM8Y0qOR8oy-A07y-zeEQ@mail.gmail.com>
Message-ID: <CAK8P3a2YAe0KPQYQi_PhFvaYeA_4jHM8Y0qOR8oy-A07y-zeEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: fix stack usage warning on old gcc
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Kc7ExT19m2I7yRzQqPmBHzvy9Fwd+WE8NYR5jX3/ZmZPeP+ycZE
 oI77cS2vUJj+SVjV1t+MACKwHFihuWlk4/xItDbQM3fGyV8qtatC+lXkxe+ojRMtsyioaII
 nQ9P6P1DdMVm/tICZisDQZ6AX01/DONmc3JBb/Q7HvyjEkigoskD67sqjV+PaBRo1+yBjdD
 iu9HXB3zM61TbDdbdn2ZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UuZTpsjqqO4=:2VAiJ2G4MkIz0cpx11v4+F
 wuWmATlsgNv2qUx4fPOhYFjD41SbeCaew8NGfGoX3VdiQicj/kPRa+Bi3TUJJ+OBXCXtBD5ds
 wOOF+YzPqZzV8cB5TpDmYTkHKQSEt91Br6KC8ieJ16IwMDNd38i8BxjRt6QoFuZ2sFh6k3M08
 lTQJpYnxfoikbbX04qdl4NK7tshZfOzugT2GZe/7mLiL+Pph9BvgAHcHBysDNlCEd5HEX7qv1
 K4mbOOYnAggwUGfnsKBBN2gX4L14Wr0RM5a3EyFslJN/Sow/HGzsCzdWHRxLoroWP8rG237BJ
 /bQIX0fCBzcZ66j99o6ke+4bqWaxYW+LvaSMG5bsSkZBWPcRwtaqsjIE37XOfnGr3n1WBTm6i
 iD+52oD8QhIhIWns2Ie0PQciSS9O5Jo3ODYJQXOBP2ITa9nKbch2UZplC9x4mjmBuYJvTGRKw
 ykO5MzGqpJWeC0mWeJuYAL0ZAcBzHVdG2Hdc708PHWd74hNXzD+88YjQCjAiBeuIMexcuEB8S
 L/Qg+hP+zUsp7N6f+7LpY+jr/1dpMFM9hNj9x2vc9mP9V1fLMuplooKU0iD3BfwivVtzgjyNH
 hBPDKKAbcq7irnAqEP8UbjMI036rWBXTNTFeHeZCybYQQfuTu6mipkpwy0imfwpDdKimqpPr3
 ypB/629zxuAoodzddgb4rrdpGcByOLLY6TX0/C7vX13eRf06W6YKceRKDwom/lUplbjD5DEaj
 pjOQXC/L9bFkB8mQpt2Vk110fYGIBO0AK1EqIMdIkXM3pEEA7bnoXOc6mA/eAKjagBLCrSXNd
 aJ7xWmmuadhUkoJYxbo379dihpHr0XSEw9wSdZxKCLpX+A3PBQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 9:56 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> > index 1b39e8d37834..6650fe4cfc20 100644
> > --- a/drivers/gpu/drm/bridge/tc358768.c
> > +++ b/drivers/gpu/drm/bridge/tc358768.c
> > @@ -178,6 +178,8 @@ static int tc358768_clear_error(struct tc358768_priv *priv)
> >
> >   static void tc358768_write(struct tc358768_priv *priv, u32 reg, u32 val)
> >   {
> > +     /* work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
> > +     int tmpval = val;

>
> tc358768_write is not inline. What is the inline function here? Or is tc358768_write optimized to
> inline by the compiler?

I missed the lack of an explicit inline tag when looking at the bug. gcc
usually decides which functions to inline on its own, so there is little
difference in practice. Let me know if I should clarify the changelog and
resend it.

      Arnd
