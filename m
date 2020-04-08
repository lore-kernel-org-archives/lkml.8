Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C7C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EB720747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QYg3ozUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgDHKMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:12:38 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:44498 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDHKMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586340756; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHrGg1kJSJbVqULtFtoJ40tkSeQG6c2tAyLWZHr7Y9s=;
        b=QYg3ozUG1fuyCrM29sl/nZlbn3oH7p7oZtVxLZ1+yJZoycw5Ca/jO6fB6DbneZ5+ohlmIc
        y2QHAkweKrAICcYYMWXlFQcN4ul64o6cWE09OyVWbdqPPvDF9CM7CL/RIP9w5HwRnR47Gl
        X2fpx/pMTuMLH9tSzdudeouogOqEV6g=
Date:   Wed, 08 Apr 2020 12:12:26 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] drm/panel: NT39016: Add support for multiple modes
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <QCSG8Q.N40UK3F20OVT2@crapouillou.net>
In-Reply-To: <20200408100452.GA20795@ravnborg.org>
References: <20200408095830.8131-1-paul@crapouillou.net>
        <20200408100452.GA20795@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,


Le mer. 8 avril 2020 =E0 12:04, Sam Ravnborg <sam@ravnborg.org> a =E9crit=20
:
> Hi Paul.
>=20
> On Wed, Apr 08, 2020 at 11:58:29AM +0200, Paul Cercueil wrote:
>>  Add support for multiple drm_display_mode entries. This will allow=20
>> to
>>  add a 50 Hz mode later.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Patch looks good.
>=20
> Could we please use lower case in the $subject?

You mean 's/Add/add/' or the panel name as well?

-Paul

> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>=20
> I asume you will apply yourself.
>=20
> 	Sam
>=20
>>  ---
>>   drivers/gpu/drm/panel/panel-novatek-nt39016.c | 33=20
>> +++++++++++++------
>>   1 file changed, 23 insertions(+), 10 deletions(-)
>>=20
>>  diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c=20
>> b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
>>  index a470810f7dbe..f1286cf6528b 100644
>>  --- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
>>  +++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
>>  @@ -49,7 +49,8 @@ enum nt39016_regs {
>>   #define NT39016_SYSTEM_STANDBY	BIT(1)
>>=20
>>   struct nt39016_panel_info {
>>  -	struct drm_display_mode display_mode;
>>  +	const struct drm_display_mode *display_modes;
>>  +	unsigned int num_modes;
>>   	u16 width_mm, height_mm;
>>   	u32 bus_format, bus_flags;
>>   };
>>  @@ -212,15 +213,22 @@ static int nt39016_get_modes(struct drm_panel=20
>> *drm_panel,
>>   	struct nt39016 *panel =3D to_nt39016(drm_panel);
>>   	const struct nt39016_panel_info *panel_info =3D panel->panel_info;
>>   	struct drm_display_mode *mode;
>>  +	unsigned int i;
>>=20
>>  -	mode =3D drm_mode_duplicate(connector->dev,=20
>> &panel_info->display_mode);
>>  -	if (!mode)
>>  -		return -ENOMEM;
>>  +	for (i =3D 0; i < panel_info->num_modes; i++) {
>>  +		mode =3D drm_mode_duplicate(connector->dev,
>>  +					  &panel_info->display_modes[i]);
>>  +		if (!mode)
>>  +			return -ENOMEM;
>>  +
>>  +		drm_mode_set_name(mode);
>>=20
>>  -	drm_mode_set_name(mode);
>>  +		mode->type =3D DRM_MODE_TYPE_DRIVER;
>>  +		if (panel_info->num_modes =3D=3D 1)
>>  +			mode->type |=3D DRM_MODE_TYPE_PREFERRED;
>>=20
>>  -	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
>>  -	drm_mode_probed_add(connector, mode);
>>  +		drm_mode_probed_add(connector, mode);
>>  +	}
>>=20
>>   	connector->display_info.bpc =3D 8;
>>   	connector->display_info.width_mm =3D panel_info->width_mm;
>>  @@ -230,7 +238,7 @@ static int nt39016_get_modes(struct drm_panel=20
>> *drm_panel,
>>   					 &panel_info->bus_format, 1);
>>   	connector->display_info.bus_flags =3D panel_info->bus_flags;
>>=20
>>  -	return 1;
>>  +	return panel_info->num_modes;
>>   }
>>=20
>>   static const struct drm_panel_funcs nt39016_funcs =3D {
>>  @@ -316,8 +324,8 @@ static int nt39016_remove(struct spi_device=20
>> *spi)
>>   	return 0;
>>   }
>>=20
>>  -static const struct nt39016_panel_info kd035g6_info =3D {
>>  -	.display_mode =3D {
>>  +static const struct drm_display_mode kd035g6_display_modes[] =3D {
>>  +	{
>>   		.clock =3D 6000,
>>   		.hdisplay =3D 320,
>>   		.hsync_start =3D 320 + 10,
>>  @@ -330,6 +338,11 @@ static const struct nt39016_panel_info=20
>> kd035g6_info =3D {
>>   		.vrefresh =3D 60,
>>   		.flags =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>>   	},
>>  +};
>>  +
>>  +static const struct nt39016_panel_info kd035g6_info =3D {
>>  +	.display_modes =3D kd035g6_display_modes,
>>  +	.num_modes =3D ARRAY_SIZE(kd035g6_display_modes),
>>   	.width_mm =3D 71,
>>   	.height_mm =3D 53,
>>   	.bus_format =3D MEDIA_BUS_FMT_RGB888_1X24,
>>  --
>>  2.25.1


