Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A696C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8F32176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgBSIPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:15:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:56954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgBSIPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:15:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B156BAC77;
        Wed, 19 Feb 2020 08:15:49 +0000 (UTC)
Subject: Re: [PATCH] drm/hisilicon: Fixed pcie resource conflict between drm
 and firmware
To:     Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
        airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
        alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1582099028-11898-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 mQENBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAG0J1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPokBVAQTAQgAPhYh
 BHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsDBQkDwmcABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEGgNwR1TC3ojR80H/jH+vYavwQ+TvO8ksXL9JQWc3IFSiGpuSVXLCdg62AmR
 irxW+qCwNncNQyb9rd30gzdectSkPWL3KSqEResBe24IbA5/jSkPweJasgXtfhuyoeCJ6PXo
 clQQGKIoFIAEv1s8l0ggPZswvCinegl1diyJXUXmdEJRTWYAtxn/atut1o6Giv6D2qmYbXN7
 mneMC5MzlLaJKUtoH7U/IjVw1sx2qtxAZGKVm4RZxPnMCp9E1MAr5t4dP5gJCIiqsdrVqI6i
 KupZstMxstPU//azmz7ZWWxT0JzgJqZSvPYx/SATeexTYBP47YFyri4jnsty2ErS91E6H8os
 Bv6pnSn7eAq5AQ0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRH
 UE9eosYbT6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgT
 RjP+qbU63Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+R
 dhgATnWWGKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zb
 ehDda8lvhFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r
 12+lqdsAEQEAAYkBPAQYAQgAJhYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsMBQkD
 wmcAAAoJEGgNwR1TC3ojpfcIAInwP5OlcEKokTnHCiDTz4Ony4GnHRP2fXATQZCKxmu4AJY2
 h9ifw9Nf2TjCZ6AMvC3thAN0rFDj55N9l4s1CpaDo4J+0fkrHuyNacnT206CeJV1E7NYntxU
 n+LSiRrOdywn6erjxRi9EYTVLCHcDhBEjKmFZfg4AM4GZMWX1lg0+eHbd5oL1as28WvvI/uI
 aMyV8RbyXot1r/8QLlWldU3NrTF5p7TMU2y3ZH2mf5suSKHAMtbE4jKJ8ZHFOo3GhLgjVrBW
 HE9JXO08xKkgD+w6v83+nomsEuf6C6LYrqY/tsZvyEX6zN8CtirPdPWu/VXNRYAl/lat7lSI
 3H26qrE=
Message-ID: <ba544720-3089-75f0-5e0f-32b231c14f11@suse.de>
Date:   Wed, 19 Feb 2020 09:15:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582099028-11898-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2TCicCorfrob0WIHJP1kYN0Mbg5J7q3gq"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2TCicCorfrob0WIHJP1kYN0Mbg5J7q3gq
Content-Type: multipart/mixed; boundary="7FeCYlLoLepIv4tveMASgztSRpcpIUxb1";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
 airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
 alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <ba544720-3089-75f0-5e0f-32b231c14f11@suse.de>
Subject: Re: [PATCH] drm/hisilicon: Fixed pcie resource conflict between drm
 and firmware
References: <1582099028-11898-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1582099028-11898-1-git-send-email-tiantao6@hisilicon.com>

--7FeCYlLoLepIv4tveMASgztSRpcpIUxb1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 19.02.20 um 08:57 schrieb Tian Tao:
> remove the framebuffer initialized by fireware/bootloader,which will us=
e
> hibmc's pcie resource, and may cause conflict.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Signed-off-by: Gong junjie <gongjunjie2@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 18 +++++++++++++++++=
+
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 5f612f6..7ebe831 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -47,6 +47,22 @@ static irqreturn_t hibmc_drm_interrupt(int irq, void=
 *arg)
>  	return IRQ_HANDLED;
>  }
> =20
> +static void hibmc_remove_framebuffers(struct pci_dev *pdev)
> +{
> +	struct apertures_struct *ap;
> +
> +	ap =3D alloc_apertures(1);
> +	if (!ap)
> +		return;
> +
> +	ap->ranges[0].base =3D pci_resource_start(pdev, 0);
> +	ap->ranges[0].size =3D pci_resource_len(pdev, 0);
> +
> +	drm_fb_helper_remove_conflicting_framebuffers(ap, "hibmcdrmfb", false=
);
> +
> +	kfree(ap);
> +}
> +
>  static struct drm_driver hibmc_driver =3D {
>  	.driver_features	=3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>  	.fops			=3D &hibmc_fops,
> @@ -327,6 +343,8 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>  	struct drm_device *dev;
>  	int ret;
> =20
> +	hibmc_remove_framebuffers(pdev);

Instead of rolling your own, you should try
drm_fb_helper_remove_conflicting_pci_framebuffers(). It releases any I/O
memory resource of the device.

Best regards
Thomas

> +
>  	dev =3D drm_dev_alloc(&hibmc_driver, &pdev->dev);
>  	if (IS_ERR(dev)) {
>  		DRM_ERROR("failed to allocate drm_device\n");
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--7FeCYlLoLepIv4tveMASgztSRpcpIUxb1--

--2TCicCorfrob0WIHJP1kYN0Mbg5J7q3gq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl5M7rAACgkQaA3BHVML
eiOFygf/XtAbLO8y9AboCrN7iwvg4K6NMpmYYaK2XuoPB7skvflM1IH+unp8utMc
ihNeWnjT6x2yMfP5UPk32kI8LYNBIUepzLTQkSWMV+t7HV0sC/fYnKMV521jDxq/
s0KGECISBrGOGp/ZwYWodY3Gor4zuSF+6/qqIIB8Watb+ly/0cSjnH4SahZCUd1l
r7+RLW3vsUWhpG2hkh+Tx8g8J2jRKU2+rAoEPOUOtnZrmk3thWocYdJ8X9uP8BRN
4aG4cTpRYWgnZiS/dLsm2BFL/zJciUUnbPMgMYr2sMzZ5k1hItZzFXupyS3cH659
aOWtpbyn4iJreiuiNqxhGQHI6IWxtA==
=wpyX
-----END PGP SIGNATURE-----

--2TCicCorfrob0WIHJP1kYN0Mbg5J7q3gq--
