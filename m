Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EF8C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787E7206F7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ln3IEtjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgDELt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 07:49:28 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47790 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgDELt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586087364; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxJphrR8Liumkzi00BHwWA0qkPnbC0I71+WAOZAMF6s=;
        b=ln3IEtjNoRgLzEi6pZ1kp6yOmkVIMpiSZPxZoU13fGkr410lYTDQEZFtYNJYOXMJ8+VoDl
        CMW/KWaMsmw+RLLc9wS/NyjbCvGW2LoWAbeU3oX8hXjL3xoMkj/7Z3ONaxYg5ya+2erEcD
        kG3WpPTjR8GqGpulik1Ahn3+Mct04Ik=
Date:   Sun, 05 Apr 2020 13:49:12 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] gpu/drm: ingenic: Delete an error message in
 ingenic_drm_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Message-Id: <1UCB8Q.TC6CW4K2D9X72@crapouillou.net>
In-Reply-To: <e03e7106-0f22-99c4-ad21-b288e8990b5a@web.de>
References: <e03e7106-0f22-99c4-ad21-b288e8990b5a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le dim. 5 avril 2020 =C3=A0 11:30, Markus Elfring <Markus.Elfring@web.de> a=
=20
=C3=A9crit :
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 5 Apr 2020 11:25:30 +0200
>=20
> The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
> Thus omit a redundant message for the exception handling in the
> calling function.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c=20
> b/drivers/gpu/drm/ingenic/ingenic-drm.c
> index 9dfe7cb530e1..06ca752b76ee 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -661,10 +661,8 @@ static int ingenic_drm_probe(struct=20
> platform_device *pdev)
>  	}
>=20
>  	irq =3D platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "Failed to get platform irq");
> +	if (irq < 0)
>  		return irq;
> -	}
>=20
>  	if (soc_info->needs_dev_clk) {
>  		priv->lcd_clk =3D devm_clk_get(dev, "lcd");
> --
> 2.26.0
>=20


