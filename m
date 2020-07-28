Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3C1C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4A22177B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgG1H4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:56:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:58470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbgG1H4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:56:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C64EB0BF;
        Tue, 28 Jul 2020 07:56:47 +0000 (UTC)
Subject: Re: [PATCH v2] drm/hisilicon: Fixed the warning: Assignment of 0/1 to
 bool variable
To:     Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
        airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
        alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1594090701-45741-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <194e751e-cb16-4452-2da6-6b2aedc85e36@suse.de>
Date:   Tue, 28 Jul 2020 09:56:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594090701-45741-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eAQhCconB9NfLxVvDygvYacHUTyQ8swq5"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eAQhCconB9NfLxVvDygvYacHUTyQ8swq5
Content-Type: multipart/mixed; boundary="UBBn2HpU0PRPRbVDldfZtByP6AjrBLxZK";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
 airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
 alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <194e751e-cb16-4452-2da6-6b2aedc85e36@suse.de>
Subject: Re: [PATCH v2] drm/hisilicon: Fixed the warning: Assignment of 0/1 to
 bool variable
References: <1594090701-45741-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1594090701-45741-1-git-send-email-tiantao6@hisilicon.com>

--UBBn2HpU0PRPRbVDldfZtByP6AjrBLxZK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 07.07.20 um 04:58 schrieb Tian Tao:
> fixed the following warning:
> hibmc_drm_drv.c:296:1-18:WARNING: Assignment of 0/1 to bool variable.
> hibmc_drm_drv.c:301:2-19: WARNING: Assignment of 0/1 to bool variable.
>=20
> v2:
> using the pci_dev.msi_enabled instead of priv->msi_enabled.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 6 +++---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h | 1 -
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 249c298..83c7bb5 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -254,7 +254,7 @@ static int hibmc_unload(struct drm_device *dev)
> =20
>  	if (dev->irq_enabled)
>  		drm_irq_uninstall(dev);
> -	if (priv->msi_enabled)
> +	if (dev->pdev->msi_enabled)

You don't need these tests and you don't have to set
dev->pdev->msi_enabled by yourself. Just call pci_enable_msi() and
pci_disable_msi() and they should do the right thing.

Best regards
Thomas

>  		pci_disable_msi(dev->pdev);
> =20
>  	hibmc_kms_fini(priv);
> @@ -294,12 +294,12 @@ static int hibmc_load(struct drm_device *dev)
>  		goto err;
>  	}
> =20
> -	priv->msi_enabled =3D 0;
> +	dev->pdev->msi_enabled =3D 0;
>  	ret =3D pci_enable_msi(dev->pdev);
>  	if (ret) {
>  		DRM_WARN("enabling MSI failed: %d\n", ret);
>  	} else {
> -		priv->msi_enabled =3D 1;
> +		dev->pdev->msi_enabled =3D 1;
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


--UBBn2HpU0PRPRbVDldfZtByP6AjrBLxZK--

--eAQhCconB9NfLxVvDygvYacHUTyQ8swq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl8f2jMUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiPEFgf/c8zukRGHTyczn9vPaWKkrgfxe/92
CgrnzikvcyU3LzYRIgq0P9K76kYdDE2EfEclfbADXF3k9cib4J97T7IknNN0QH53
PJB2sMHri2GtQmD1bAnEs0Mb53AVhbfsap1ODDcmA4kuOQXFEU2kFbGERMDAlnGW
Sr5La9vXdMZrQiDYsPf0vIKa+BA1TCcLEaK401d5bp+hRGQLs9QpY2Bcb+5P6QU7
ZLBT29GO10hAe7r79CtB0Okgat2OPFKC4NeY6IoxDMeOA/+cDSRVt5rAMz4PsHMa
3vRipUMvrhAFzYRykCN4bgFvOH+waDKEI71hue+IrSZDuIDEko/MSDGr2g==
=JmGA
-----END PGP SIGNATURE-----

--eAQhCconB9NfLxVvDygvYacHUTyQ8swq5--
