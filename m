Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82242C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 490522054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TexsUcZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgHTQhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:37:15 -0400
Received: from crapouillou.net ([89.234.176.41]:35090 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgHTQhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597941431; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Na0xzDfd/uDMnlsu4QBaVN1Vj7lsvYAbVxxdwdvXK7M=;
        b=TexsUcZY5iCszseErJKhI2ki7tmwPMmQwbgQzSDcSoTR4eRBoLeB87RhNA2PxYJNUTIoEE
        wm/rJuE3Z0Thb75uR89TLEEt3RH9Lpr0l4z0Sj6hYPNnMBVlMrEB0hWJ3lhXbHXUgHBd2t
        HhRdLlyNuF5p1R87iwEHfNXPKhqIXpI=
Date:   Thu, 20 Aug 2020 18:37:01 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/2] drm/panel: novatek,nt39016: Reorder calls in probe
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <PHFDFQ.XMQO5QM3591V@crapouillou.net>
In-Reply-To: <20200820155302.GA194134@ravnborg.org>
References: <20200820121256.32037-1-paul@crapouillou.net>
        <20200820121256.32037-2-paul@crapouillou.net>
        <20200820155302.GA194134@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Le jeu. 20 ao=FBt 2020 =E0 17:53, Sam Ravnborg <sam@ravnborg.org> a=20
=E9crit :
> On Thu, Aug 20, 2020 at 02:12:55PM +0200, Paul Cercueil wrote:
>>  The drm_panel_of_backlight() function must be called after
>>  drm_panel_init(), according to the function's documentation;=20
>> otherwise
>>  the backlight won't be properly initialized.
>>=20
>>  v2: New patch
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Patchset pushed to drm-misc-next.

Thanks!
-Paul

>>  ---
>>   drivers/gpu/drm/panel/panel-novatek-nt39016.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>>  diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c=20
>> b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
>>  index 39f7be679da5..daa583030246 100644
>>  --- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
>>  +++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
>>  @@ -285,6 +285,9 @@ static int nt39016_probe(struct spi_device *spi)
>>   		return PTR_ERR(panel->map);
>>   	}
>>=20
>>  +	drm_panel_init(&panel->drm_panel, dev, &nt39016_funcs,
>>  +		       DRM_MODE_CONNECTOR_DPI);
>>  +
>>   	err =3D drm_panel_of_backlight(&panel->drm_panel);
>>   	if (err) {
>>   		if (err !=3D -EPROBE_DEFER)
>>  @@ -292,9 +295,6 @@ static int nt39016_probe(struct spi_device *spi)
>>   		return err;
>>   	}
>>=20
>>  -	drm_panel_init(&panel->drm_panel, dev, &nt39016_funcs,
>>  -		       DRM_MODE_CONNECTOR_DPI);
>>  -
>>   	drm_panel_add(&panel->drm_panel);
>>=20
>>   	return 0;
>>  --
>>  2.28.0


