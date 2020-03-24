Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E267C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCE520714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djAXMRGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCXTeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:34:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45602 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgCXTeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:34:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id v4so10587115lfo.12;
        Tue, 24 Mar 2020 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BuW1pgtMi1nFDluniTHUYAMhP+ECNJICP5kvAttrp90=;
        b=djAXMRGpfX/uYnxHJ3wl2qCQUySXiH6H9DG4JMMCYNMq+CNKLKGF43SapUWG/r/Sf4
         9jJQY9v5nX2vWjGcBkQV6PJN0djRJL8yL7kzP7wOERKNka2dR1DI6/7IZ1iDLorQSymH
         g4ha+k4Hg7vSp7GajygnZJtjf2DJuxcohHO4EZ6207TwbQg2DpmeWx425DGGClfDKQds
         9pl/yqXmqdStvtaXrMDpMHP/+g3ZF+mlT1jkDlTJN5lZ3clkfzHhb5YCor7FDdD7Q5R5
         ogEIx2Fuiom+0hLoUv/fY2iD3A3SXawE2a/bd3OenLkmaq6gxfuSXqBlTV1Hoxo5m1au
         dc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BuW1pgtMi1nFDluniTHUYAMhP+ECNJICP5kvAttrp90=;
        b=pTFJtmhBmky5JCLfCL0x6HJIG54oFw70qWIOccmM619f2A7+czr6X+AlbbyciRvr0R
         wwN/EUdgJ3/88C2R3VjYkUxqdRWjchBSXcZ0JiF7m/QET0Nf6go39GN30l8a4IVqULBS
         qMV4d6WlQkYWWxVPIMWyWzii6l7lEI5MWfcoMddBMhwFhI9Ep03KId7tH1WVgQhWcoet
         0pptcAH6r6QgpiRKSvUDUnGNBrlBwNjIij56kYc3gnzm8JBTwZqH9wkEIDKtLd8MrP8c
         ytJ48jQBjplFvfJiqmafNNoSfpTHD2+nq5vRfnZoMqx7DRrbZzVFrcKlt/31rE/cBssG
         wK/Q==
X-Gm-Message-State: ANhLgQ3p3SdykDZMx21Xx6pVo7FQIvRP4AA7XAsv+BEHY0nVobIUoLp3
        mzJ9nIHgjgPr+2qiZt/vHBzpJdyZyo1ApfKGjDk=
X-Google-Smtp-Source: ADFU+vtCUdIkmuQsY4QzJUMqNYV6lYZDkx1LNuGCgcfEy8vGbUSEMIGt5lO92LiWyGxs7J1Z7ulaFxz0Vq1YTqoUtYA=
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr1260787lfp.66.1585078462025;
 Tue, 24 Mar 2020 12:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584730033.git.agx@sigxcpu.org> <c7fd138e00608a108dae3651ab10d583a60040fc.1584730033.git.agx@sigxcpu.org>
In-Reply-To: <c7fd138e00608a108dae3651ab10d583a60040fc.1584730033.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 24 Mar 2020 16:34:13 -0300
Message-ID: <CAOMZO5Dhy7ahcR-S=QG=pumxXa8HnQoWpg0TdFyeu_Levdh9_Q@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: display/bridge: Add binding for NWL
 mipi dsi host controller
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 3:49 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Tested-by: Robert Chiras <robert.chiras@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
