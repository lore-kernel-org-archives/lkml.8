Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C246EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 12:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E6620727
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 12:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="vG/oYm1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgEQMUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 08:20:09 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45694 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgEQMUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 08:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589718006; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lAqsVvAIASjKFbEhPDBxhbFVPKcLMddVhVPAD4MtNs=;
        b=vG/oYm1r0CrhRofO/eXELE3n5/czRaZ1Mk0pnntlYvJyV4JqsSm+HtaxMXipIy2tzyGoYL
        s8Ob0J1DuXgXhwqeMWHTJGIt3Y6zzy7vUxrwt9qBFhCqAtz6wHeQ7Nj9rivo8NPUWvYWnq
        YAtndBgSbClCsZJN0j+Vcwm4HxmvV/w=
Date:   Sun, 17 May 2020 14:19:54 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 05/12] gpu/drm: Ingenic: Fix opaque pointer casted to
 wrong type
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, od@zcrc.me, dri-devel@lists.freedesktop.org
Message-Id: <696HAQ.LSNC2851KFSC@crapouillou.net>
In-Reply-To: <20200517062105.GD609600@ravnborg.org>
References: <20200516215057.392609-1-paul@crapouillou.net>
        <20200516215057.392609-5-paul@crapouillou.net>
        <20200517062105.GD609600@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Le dim. 17 mai 2020 =E0 8:21, Sam Ravnborg <sam@ravnborg.org> a =E9crit :
> On Sat, May 16, 2020 at 11:50:50PM +0200, Paul Cercueil wrote:
>>  The opaque pointer passed to the IRQ handler is a pointer to the
>>  drm_device, not a pointer to our ingenic_drm structure.
>>=20
>>  It still worked, because our ingenic_drm structure contains the
>>  drm_device as its first field, so the pointer received had the same
>>  value, but this was not semantically correct.
>>=20
>>  Cc: stable@vger.kernel.org # v5.3
>>  Fixes: 90b86fcc47b4 ("DRM: Add KMS driver for the Ingenic JZ47xx=20
>> SoCs")
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Pushed to drm-misc-fixes, thanks for the review.

-Paul

>>  ---
>>   drivers/gpu/drm/ingenic/ingenic-drm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c=20
>> b/drivers/gpu/drm/ingenic/ingenic-drm.c
>>  index 0c472382a08b..97244462599b 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
>>  @@ -476,7 +476,7 @@ static int=20
>> ingenic_drm_encoder_atomic_check(struct drm_encoder *encoder,
>>=20
>>   static irqreturn_t ingenic_drm_irq_handler(int irq, void *arg)
>>   {
>>  -	struct ingenic_drm *priv =3D arg;
>>  +	struct ingenic_drm *priv =3D drm_device_get_priv(arg);
>>   	unsigned int state;
>>=20
>>   	regmap_read(priv->map, JZ_REG_LCD_STATE, &state);
>>  --
>>  2.26.2
>>=20
>>  _______________________________________________
>>  dri-devel mailing list
>>  dri-devel@lists.freedesktop.org
>>  https://lists.freedesktop.org/mailman/listinfo/dri-devel


