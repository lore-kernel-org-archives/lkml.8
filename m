Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F59C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C001206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgG2Iez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:34:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:40406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2Iey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:34:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60645AEA1;
        Wed, 29 Jul 2020 08:35:04 +0000 (UTC)
Subject: Re: [PATCH v3] drm/hisilicon: Fixed the warning: Assignment of 0/1 to
 bool variable
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1595940907-17874-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <e8035faa-8f0f-4269-ef20-24408baa6f7a@suse.de>
Date:   Wed, 29 Jul 2020 10:34:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595940907-17874-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uO4l2ZdX9DuIrwFrhS5RI4YN8UM86dXAl"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uO4l2ZdX9DuIrwFrhS5RI4YN8UM86dXAl
Content-Type: multipart/mixed; boundary="J1iwjIBgda0yhT6h7FIQFKZJLCl5pVTaO";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <e8035faa-8f0f-4269-ef20-24408baa6f7a@suse.de>
Subject: Re: [PATCH v3] drm/hisilicon: Fixed the warning: Assignment of 0/1 to
 bool variable
References: <1595940907-17874-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1595940907-17874-1-git-send-email-tiantao6@hisilicon.com>

--J1iwjIBgda0yhT6h7FIQFKZJLCl5pVTaO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 28.07.20 um 14:55 schrieb Tian Tao:
> fixed the following warning:
> hibmc_drm_drv.c:296:1-18:WARNING: Assignment of 0/1 to bool variable.
> hibmc_drm_drv.c:301:2-19: WARNING: Assignment of 0/1 to bool variable.
>=20
> v2:
> using the pci_dev.msi_enabled instead of priv->msi_enabled.
>=20
> v3:
> just call pci_enable_msi() and pci_disable_msi(), it's no need to
> set dev->pdev->msi_enabled again.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Thanks. Added to drm-misc-next

Best regards
Thomas

> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 5 +----
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h | 1 -
>  2 files changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 249c298..b8d839a 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -254,9 +254,8 @@ static int hibmc_unload(struct drm_device *dev)
> =20
>  	if (dev->irq_enabled)
>  		drm_irq_uninstall(dev);
> -	if (priv->msi_enabled)
> -		pci_disable_msi(dev->pdev);
> =20
> +	pci_disable_msi(dev->pdev);
>  	hibmc_kms_fini(priv);
>  	hibmc_mm_fini(priv);
>  	dev->dev_private =3D NULL;
> @@ -294,12 +293,10 @@ static int hibmc_load(struct drm_device *dev)
>  		goto err;
>  	}
> =20
> -	priv->msi_enabled =3D 0;
>  	ret =3D pci_enable_msi(dev->pdev);
>  	if (ret) {
>  		DRM_WARN("enabling MSI failed: %d\n", ret);
>  	} else {
> -		priv->msi_enabled =3D 1;
>  		ret =3D drm_irq_install(dev, dev->pdev->irq);
>  		if (ret)
>  			DRM_WARN("install irq failed: %d\n", ret);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index 6097687..a683763 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -25,7 +25,6 @@ struct hibmc_drm_private {
>  	void __iomem   *fb_map;
>  	unsigned long  fb_base;
>  	unsigned long  fb_size;
> -	bool msi_enabled;
> =20
>  	/* drm */
>  	struct drm_device  *dev;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--J1iwjIBgda0yhT6h7FIQFKZJLCl5pVTaO--

--uO4l2ZdX9DuIrwFrhS5RI4YN8UM86dXAl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl8hNKsUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiPvjQf/YVEYHrNufhJAIt4F//Q0Kbi5U4JY
LmIiNMkjVj8ktC52Oa5u+eCBABL6FerwSskbJhDN79GXThz/Fihdr499ge8BGmap
Gpfe6rgPH+gBhhgRVnrTSaA/IrglAcpylj/X8LM/mO7inSNQqvBf7VncRSKe9Oqs
DRCPo+VuRRfSJV+bUdkKIadc6kH462j462rk2yDG7nlmMC0XhOuEuyLNulIq5f34
n+msj7uAD95JYqE/TLq2cWt7E8vdgeh7FlUhHI00NTBvKMn/8LZoRjOnWR+jKWNC
PARENle50uRKpTijm6wZ5n//J2N0LsqRBMtUlebFqw84gHLWrk+ed9qvHg==
=q/81
-----END PGP SIGNATURE-----

--uO4l2ZdX9DuIrwFrhS5RI4YN8UM86dXAl--
