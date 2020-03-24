Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D67FC54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5768D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK2S9+6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgCXTfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:35:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46366 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgCXTfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:35:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id v16so12877539ljk.13;
        Tue, 24 Mar 2020 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e0wTObJ08RVlnsiArj9gwShr2d4p9qtkVTHwSjLAzow=;
        b=DK2S9+6j9KGtB+U8ylYOlNV2DVU70arttAXObYJ0oTXa6BOrLf9+gbnyj/PqN3X0mt
         RjjtcailfvOx5tUiFPKTJUGP7rWdHY24ZVQqaamiy/JF82tIAI/V71JtbY//N2BlJNP4
         OZpyzlmPdfcfisxOkGgJc0m+yfqTvbEuaAp7ZPXu+Ygs63V+tBXgi7mp8CeuH8RxaBVs
         eNHas9j3FuVOFysmaI3aTA2xkFi8t3ksU3AXqi5DSpRz/NoeEfiJjrxrlSXkZ5nq3Fwx
         KGLl6ThOEcQOg/Tm1LKmg+GfIx0KsT/WFnzvyf3ofAgXBNSzV9js8J/VPiK3JWh1VUDv
         CNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e0wTObJ08RVlnsiArj9gwShr2d4p9qtkVTHwSjLAzow=;
        b=Za17Kd5clrxdhweKFMF8Ecr7MGeNwqsbo0hZbtnLfu2ktrz83hRo12ja9GyrlROhMn
         WJape7k2/X0AwVMFmAUga96GOGG5QBGJTQBFavcJZ0TnUnH7YyZ00Zry86mSYnPwsJIa
         MiPYnDP63xeDoNsiBxYIfXtjipTnvCIO89MOFG9GgPneD9R3OMypf84++v9C6ukqzxW3
         BRzo+7RjbF/zixMtQRRFZvJ3XAIK33MW1hQrj9S1PH1UyuHyY+B3aYePtKxULcj2Xhjo
         HQizqNTXo1w411UGq+Bh12Lh51AVfqdrEgz81q5F7BWaDxUE+Ydogiyq6q38I0Vb1Rxs
         MwCw==
X-Gm-Message-State: ANhLgQ3GNeVs4NCq3/Me7hnjOzERW75hEDroqj4fgTi7wUuWTMR1VPoO
        lu0RvqNJEITBS22GuhMGBi/uIUa+UTEJp+B/plw=
X-Google-Smtp-Source: ADFU+vtR0T6QWse42XxH9cPngbBhP7L+wmNFP2DjiGQUffZhWB/3y876D0GfC4X3TViS4JAgfxSBjxgnaT5p6bewcwk=
X-Received: by 2002:a05:651c:30b:: with SMTP id a11mr7059917ljp.164.1585078502370;
 Tue, 24 Mar 2020 12:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584730033.git.agx@sigxcpu.org> <22f34fb7cf7ee4262cf63372aee90bc8e5ae3f35.1584730033.git.agx@sigxcpu.org>
In-Reply-To: <22f34fb7cf7ee4262cf63372aee90bc8e5ae3f35.1584730033.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 24 Mar 2020 16:34:53 -0300
Message-ID: <CAOMZO5Du-ZP7Wxm2eh8WaFoCk_kWomgH57ayJrBB0PzhuAA+mw@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] drm/bridge: Add NWL MIPI DSI host controller support
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
> This adds initial support for the NWL MIPI DSI Host controller found on
> i.MX8 SoCs.
>
> It adds support for the i.MX8MQ but the same IP can be found on
> e.g. the i.MX8QXP.
>
> It has been tested on the Librem 5 devkit using mxsfb.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Co-developed-by: Robert Chiras <robert.chiras@nxp.com>
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> Tested-by: Robert Chiras <robert.chiras@nxp.com>
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
