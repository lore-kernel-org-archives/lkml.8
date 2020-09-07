Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B473C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34B82166E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="dNxrjvgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgIGM6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:58:49 -0400
Received: from crapouillou.net ([89.234.176.41]:60784 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbgIGM5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599483438; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jv34PMyafvqRYOIcsfEyVpPHXi6oXDIBS9cXlCM12DI=;
        b=dNxrjvgiCGZ2gDpsrGny8IkriyroogU0LN2ugAdia9D6rBT75fSeRrRQ6h8ILkRXy5WZ9L
        k1TgVslPkWd81T72BVzX8znnxX6jHaNq+HJci+CHW1hpeel+glfSE/SUPR3/NVLZiTwoK2
        Udm00u02wXwIkL8d/OO+MAbT0oyoI+A=
Date:   Mon, 07 Sep 2020 14:57:05 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: =?UTF-8?B?562U5aSNOg==?= [PATCH v2 6/6] drm/panel: Add Ilitek
 ILI9341 DBI panel driver
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?b?5L2V5bCP6b6Z?= <Leon.He@unisoc.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf Tronnes <noralf@tronnes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-Id: <5BHAGQ.KGFJ0K3OLEAO3@crapouillou.net>
In-Reply-To: <20200830202822.GA950472@ravnborg.org>
References: <20200822163250.63664-1-paul@crapouillou.net>
        <20200822163250.63664-7-paul@crapouillou.net>
        <edf38d68214247f486db3cc1f81ec404@shmbx04.spreadtrum.com>
        <COYVFQ.2IA7KFB6BF4C3@crapouillou.net>
        <20200830191133.GB6043@pendragon.ideasonboard.com>
        <20200830202822.GA950472@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 30 ao=FBt 2020 =E0 22:28, Sam Ravnborg <sam@ravnborg.org> a=20
=E9crit :
> Hi Laurent.
>=20
>>  >
>>  > Please read the cover letter, it explains why it's done this way.=20
>> The
>>  > whole point of this patchset is to merge DSI and DBI frameworks=20
>> in a
>>  > way that can be maintained.
>>=20
>>  I think this proves the point that the proposed naming is=20
>> confusing. At
>>  least a rename would be required.
>=20
> Do you have any inputs on the amount of rename we are looking into.
> Is this a simple s/struct mipi_dsi_device/struct mipi_dxi_device/
> or something more?
>=20
> We should script the rename as it will tocuh a lot of files,
> and without a script we would chase this. But once it is scripted
> it would be trivial to perform.
>=20
> I did not look at this enough, but I had an idea that we
> would have do to a s/dsi/dxi/ in a lot of places.
>=20
> (dxi is my best proposal at the moment for something covering both dsi
> and dbi).

dcs?

Since DBI and DSI panels generally all use DCS commands.

-Paul


