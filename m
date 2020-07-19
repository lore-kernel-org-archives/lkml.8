Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CFBC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEAF92065F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Ux/db8/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgGSLIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 07:08:23 -0400
Received: from crapouillou.net ([89.234.176.41]:56260 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgGSLIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 07:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595156901; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qtrq8DWA1MSBvJzHIvwu9TgumC0NB4bv34kVPO/wg5Q=;
        b=Ux/db8/+KGuBoet3V7QqV/HszzxM1csvIdFcoldH2kBNTbKPOBkt2ZNmlKrCX3d/zNSRun
        S8dc3Q67mW7KnnLTqCJso0orUSrmJRq7hc9n6LqM0yQZmOcKY7B5dAyZjH3a4dQs8NtZlI
        DJaAotCQwaKQ65SULB5DFxMom33UlEw=
Date:   Sun, 19 Jul 2020 13:08:12 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] drm/ingenic: Silence uninitialized-variable warning
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-Id: <OXQPDQ.F020MLMIOEKM@crapouillou.net>
In-Reply-To: <20200719102354.GA20692@ravnborg.org>
References: <20200719093834.14084-1-paul@crapouillou.net>
        <20200719102354.GA20692@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Le dim. 19 juil. 2020 =E0 12:23, Sam Ravnborg <sam@ravnborg.org> a=20
=E9crit :
> Hi Paul.
>=20
> On Sun, Jul 19, 2020 at 11:38:34AM +0200, Paul Cercueil wrote:
>>  Silence compiler warning about used but uninitialized 'ipu_state'
>>  variable. In practice, the variable would never be used when
>>  uninitialized, but the compiler cannot know that 'priv->ipu_plane'=20
>> will
>>  always be NULL if CONFIG_INGENIC_IPU is disabled.
>>=20
>>  Silence the warning by initializing the value to NULL.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Patch looks good. Had to dig into the code to understand the
> change to the no_vblank flag.
> So:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>=20
> I expect you to commit the patch.

Pushed, thanks.

> Looking at the code I noticed that the return value of
> drm_atomic_get_plane_state() is not checked.
> Can you try to look into this.

Right. I'll fix it.

-Paul

> 	Sam
>=20
>>  ---
>>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c=20
>> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  index b6d946fbeaf5..ada990a7f911 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  @@ -198,7 +198,7 @@ static int ingenic_drm_crtc_atomic_check(struct=20
>> drm_crtc *crtc,
>>   					 struct drm_crtc_state *state)
>>   {
>>   	struct ingenic_drm *priv =3D drm_crtc_get_priv(crtc);
>>  -	struct drm_plane_state *f1_state, *f0_state, *ipu_state;
>>  +	struct drm_plane_state *f1_state, *f0_state, *ipu_state =3D NULL;
>>   	long rate;
>>=20
>>   	if (!drm_atomic_crtc_needs_modeset(state))
>>  @@ -229,7 +229,7 @@ static int ingenic_drm_crtc_atomic_check(struct=20
>> drm_crtc *crtc,
>>=20
>>   		/* If all the planes are disabled, we won't get a VBLANK IRQ */
>>   		priv->no_vblank =3D !f1_state->fb && !f0_state->fb &&
>>  -				  !(priv->ipu_plane && ipu_state->fb);
>>  +				  !(ipu_state && ipu_state->fb);
>>   	}
>>=20
>>   	return 0;
>>  --
>>  2.27.0


