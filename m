Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EC5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE7F20738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hE19nQIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgHULOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:14:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:49297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgHULOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598008382;
        bh=3hICDB8bk52dFVQc3BFBE3kOtnHrBZBdOB6EMWbL2iU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hE19nQIKsQiQl/Bzl7LQ4OEg0BX321SpOmsxPONZ3+/OGmWIDrJtEzACdx/bwvqrn
         1V3QJtWMg6r/CAXLpCapgK4tvJpc3QUE0t4adpbQOMjV93iFKYylD4IAyd9a79X7+H
         Sf9g/+pS6ckCNG4Z+JXdJhgG90PS4/ApiohlOoP0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.76.97.101] ([185.76.97.101]) by web-mail.gmx.net
 (3c-app-gmx-bs37.server.lan [172.19.170.89]) (via HTTP); Fri, 21 Aug 2020
 13:13:02 +0200
MIME-Version: 1.0
Message-ID: <trinity-299eba1b-59af-4257-83e6-7387e9fcf865-1598008382125@3c-app-gmx-bs37>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     frank-w@public-files.de
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        chunhui dai <chunhui.dai@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re: [PATCH v5 3/7] drm/mediatek: disable tmds on mt2701
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 21 Aug 2020 13:13:02 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <0E911554-482A-47C2-B2C6-136486C5ACB5@public-files.de>
References: <20200819081752.4805-1-linux@fw-web.de>
 <20200819081752.4805-4-linux@fw-web.de>
 <f68cf4c2-6c79-fe46-b7b4-bcc49e0b6b69@gmail.com>
 <0E911554-482A-47C2-B2C6-136486C5ACB5@public-files.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:qQ4/QXcY7aHug4GJ2xC3UHeSxq5y48c2pvLvlG6DRO/NMKGYWoyQwtVQ37sT6Iw2tCo9j
 WCKmpdZA+cTKW69yQWXhnYpUZUmALV8zop6WyiuuqnOlgKYjp5SDOuFI4iXNCwt0xaMW577Qsf4d
 GPoF68X2Ms6m4c7uyd8zyf3lCvsTyHOwKsTRThS9n78XKRGZpOuXSHdczxiiomx7Cb1MK4H/5baj
 nrYfg8g1zE46ft9EsWJp9+YZy4LaebVzAcJAxu6PPD9DeHN3zUo3QGl95pZbpvqgABWDEm8OI5H6
 Pc=
X-UI-Out-Filterresults: notjunk:1;V03:K0:YCk7Kw/svWM=:R2+qY8dmS+nNu0rNZbnzI5
 zHruvXFt1cp3+5drBm1BUX5H1Bn386hNGlWqkArpNzOQJOUffN0vC0HyeDbmd2r4MwsgB1Yy4
 /ucUHi9FUNCGk8qIEokq9vhX0sdKl6ILinIcwT+eZqr1vckoWitNw0WqS3XAnqHfSNf7oUmby
 xR7KXqgG50c5SjxSuBxybmExGF7grmzVIDeCySvALaE+Vcn5a3Pi6OkIpCyvu/Z1DBguvOHRV
 wAGhnUMGM31uiFSWEUdyhrIS7gh0cXM8U7e10y+1Ab5QvJ6fUPWveNxlGsFeXcB1V2xzIflkj
 ThtoiT6G8AEQYr3fLiYgC61i0POskwZyUtXfvpgCMlX7XxwejwnPiP0scWiCdfUgGXgd11jYb
 7OUDvTQh5bElHROUdD99eQD5Ip98xnaDMqQC4nUcqsJO+Z8SrLAFUad6rhdqDhoFa9xSYbnpc
 CsClqD7bocnA8qYJ1+UUsV6qve52+8hecyizFEMdod3Zpab0J6QNLh/svJvy3yw1Zpz2QttDu
 3+/jr9QRjPD/jlNify6PeqPMpbBVitnf2EJHyvzAZnbR8Jxgu/u2pGYDoy3Cq21Wye/lS+iIe
 5ZNBjTZKhtgyT0dqjLTpD5jVLQ8UclEJHtK4rhef13kRuW2ziFiwzga0LK/LS7CdkAqJz3nbU
 qWHTQkQULFrybDoWZB5kL3N7zBhgbne3CizYJ7YHnjIV4J1NEiljG4kDa5/KH96QvdYo=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Mittwoch, 19. August 2020 um 21:04 Uhr
> Von: "Frank Wunderlich" <frank-w@public-files.de>
> Another way to fix it maybe not enabling it (use the flag in mtk_hdmi_ph=
y_power_on) there instead of disabling after enabling it.
>
> Maybe this is less hacky than current way (as ck hu pointed in v2).

seems my last mail is not send right (did not got it from mailinglist and =
it's not mapped in patchwork).

i tried this approach, but this does not work, with checking the new flag =
in mtk_hdmi_phy_power_on and only enabling tmds if this flag is not set re=
sults in same behaviour like without the Patch (horizontally distorted ima=
ge flickering on 1280x1024)

- hdmi_phy->conf->hdmi_phy_enable_tmds(hdmi_phy);
+ if (!hdmi_phy->conf->pll_default_off)
+ hdmi_phy->conf->hdmi_phy_enable_tmds(hdmi_phy);

seems like tmds needs to be initially enabled and can only disabled later

regards Frank
