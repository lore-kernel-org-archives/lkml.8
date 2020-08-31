Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1752C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE15B207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="UekIRHPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgHaLj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:39:26 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:10950 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgHaLjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:39:23 -0400
Date:   Mon, 31 Aug 2020 11:39:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1598873960;
        bh=jR//Y3Z0pAZURnrw2Jxzg9pdJ+m1iQvesaUWWeCTY4M=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=UekIRHPTa/7jem9cbDC/HwBO8KucEskeXTb8yABX7QRhpmLiBllgeR+x+Lq7qOf5j
         R3Bc3S8aYch9rVGo83pGsmkNsjAOMJ+ouhp3wIFsbSWcEZJYc2t86TiJ07Mn/j33hh
         SLYuzIA7RFb+A93gtgrsro+5j/cAQQlmA4Dm74N9FH8LKdBATinc3mzeZyGfoko1ez
         7+CmpeuErep4xDhYxia/KzwvkihDpR6czC+SRLz4qkmPSZREQkPEdrTWhfU0kQXZal
         +H1Qku2xN4EG32ZnM1A/vKTPIM4LKKeLN+Eq8jwTbqZ8wp4du01d09Y1IYVuVN63jo
         QZD4z5LerLmNA==
To:     Sidong Yang <realwakka@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Melissa Wen <melissa.srw@gmail.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/vkms: add support for gamma_set interface
Message-ID: <UeJwFKvmNgKdZY_icN0-nrFly9R1vbzaMZ-TiyxIIPBcdl278uZsK6YdTTdRl6rFukBAmN-eyCFpnfsIB-El9QpyYiutdcpgJg64n4tsRRc=@emersion.fr>
In-Reply-To: <20200829140647.7626-1-realwakka@gmail.com>
References: <20200829140647.7626-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 29, 2020 4:06 PM, Sidong Yang <realwakka@gmail.com> wro=
te:

> Currently vkms module doesn't support gamma function for userspace. so ig=
t
> subtests in kms_plane(pixel-format-pipe-A-plan) failed for calling
> drmModeCrtcSetGamma().

It doesn't seem like this IGT test's goal is to exercise support for
gamma LUTs. Does the test just tries to reset the gamma LUT to linear?
If so, I think the IGT test should be fixed to ignore "I don't support
gamma" errors.

> This patch set gamma_set interface in vkms_crtc_funcs for
> support gamma function. With initializing crtc, added calls for setting g=
amma
> size. it pass the test after this patch.
>
> Cc: Daniel Vetter<daniel@ffwll.ch>
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms=
_crtc.c
> index ac85e17428f8..643435fb2ee6 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -160,6 +160,7 @@ static const struct drm_crtc_funcs vkms_crtc_funcs =
=3D {
>  =09.get_crc_sources=09=3D vkms_get_crc_sources,
>  =09.set_crc_source=09=09=3D vkms_set_crc_source,
>  =09.verify_crc_source=09=3D vkms_verify_crc_source,
> +=09.gamma_set=09=09=3D drm_atomic_helper_legacy_gamma_set,

Why does VKMS need to use a legacy helper?

It seems like this patch just advertises support for gamma LUTs, but
ignores any value set by user-space. If VKMS advertises support for
gamma LUTs, it needs to take the LUT into account when blending planes.

>  };
>
>  static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
> @@ -275,6 +276,13 @@ int vkms_crtc_init(struct drm_device *dev, struct dr=
m_crtc *crtc,
>  =09=09return ret;
>  =09}
>
> +=09ret =3D drm_mode_crtc_set_gamma_size(crtc, 256);
> +=09if (ret) {
> +=09=09DRM_ERROR("Failed to set gamma size\n");
> +=09=09return ret;
> +=09}
> +=09drm_crtc_enable_color_mgmt(crtc, 0, false, 256);
> +
>  =09drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
>
>  =09spin_lock_init(&vkms_out->lock);
> --
> 2.17.1

