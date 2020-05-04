Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB537C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A9B208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UrbW2A4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgEDKP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:15:56 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49592 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgEDKPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1588587350; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAMvD4AOFiyNiGQjo6JeJKVv4xAdRKZUMhJN2Epwr2k=;
        b=UrbW2A4nwL1bFKGDFE1I1i8N7cLMa7po2zmhqGrh0gIeffRnKbjGtVeMJmKGb/NmfJ+iJR
        JaOk7J0E7m/0i5m17hU6vN2i85jZ+UR098T6tDTNZjhyWsLsPV0gtREwOhptja2SFD343R
        xnlaraBEZl2T9l0nQSa5Q+voSBByMvI=
Date:   Mon, 04 May 2020 12:15:37 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] drm: ingenic-drm: add MODULE_DEVICE_TABLE
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Boddie <paul@boddie.org.uk>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, stable@vger.kernel.org
Message-Id: <1UXS9Q.L3SJ8WOQ2MPT1@crapouillou.net>
In-Reply-To: <1694a29b7a3449b6b662cec33d1b33f2ee0b174a.1588574111.git.hns@goldelico.com>
References: <1694a29b7a3449b6b662cec33d1b33f2ee0b174a.1588574111.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,


Le lun. 4 mai 2020 =E0 8:35, H. Nikolaus Schaller <hns@goldelico.com> a=20
=E9crit :
> so that the driver can load by matching the device tree
> if compiled as module.
>=20
> Cc: stable@vger.kernel.org # v5.3+
> Fixes: 90b86fcc47b4 ("DRM: Add KMS driver for the Ingenic JZ47xx=20
> SoCs")
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applied, thanks.

-Paul

> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c=20
> b/drivers/gpu/drm/ingenic/ingenic-drm.c
> index 9dfe7cb530e11..1754c05470690 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -843,6 +843,7 @@ static const struct of_device_id=20
> ingenic_drm_of_match[] =3D {
>  	{ .compatible =3D "ingenic,jz4770-lcd", .data =3D &jz4770_soc_info },
>  	{ /* sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(of, ingenic_drm_of_match);
>=20
>  static struct platform_driver ingenic_drm_driver =3D {
>  	.driver =3D {
> --
> 2.26.2
>=20


