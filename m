Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B80DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06221206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="MxDynaNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHaArs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 20:47:48 -0400
Received: from crapouillou.net ([89.234.176.41]:60196 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgHaArs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598834865; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2ssJ1yv5aon1LfrE8cgekSZHIbaEmOxzv3PnSPTv9E=;
        b=MxDynaNYRTsDJmhtwqSq/jecLtv6XeyiCCfeD64BaiOnch1VFXIUBL2cJt2v12XOd7o3FJ
        G6xkoeu919cPdRBwOhD/3cvYHfLHXLftWf29X32Ez4immtVJEQKSaBq1K7OFABRzHUWYo5
        LqEJVAEzqkVEHYeiPpPjyntSuwfuEXQ=
Date:   Mon, 31 Aug 2020 02:47:34 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/2] drm/ingenic: Fix driver not probing when IPU port
 is missing
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        od@zcrc.me
Message-Id: <AVKWFQ.TNMR0WH83TFS2@crapouillou.net>
In-Reply-To: <CAAEAJfD9q-iB9iCgCBWdA0_77=T1zsk9DFh-qvVtLHWqEnOWbQ@mail.gmail.com>
References: <20200827114404.36748-1-paul@crapouillou.net>
        <20200827114404.36748-2-paul@crapouillou.net>
        <CAAEAJfD9q-iB9iCgCBWdA0_77=T1zsk9DFh-qvVtLHWqEnOWbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 30 ao=FBt 2020 =E0 21:21, Ezequiel Garcia=20
<ezequiel@vanguardiasur.com.ar> a =E9crit :
> Hi Paul,
>=20
> On Thu, 27 Aug 2020 at 09:04, Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Even if support for the IPU was compiled in, we may run on a device
>>  (e.g. the Qi LB60) where the IPU is not available, or simply with=20
>> an old
>>  devicetree without the IPU node. In that case the ingenic-drm=20
>> refused to
>>  probe.
>>=20
>>  Fix the driver so that it will probe even if the IPU node is not=20
>> present
>>  in devicetree (but then IPU support is disabled of course).
>>=20
>>  v2: Take a different approach
>>=20
>>  Fixes: fc1acf317b01 ("drm/ingenic: Add support for the IPU")
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 19 +++++++++++--------
>>   1 file changed, 11 insertions(+), 8 deletions(-)
>>=20
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c=20
>> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  index c1bcb93aed2d..b7074161ccf0 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  @@ -673,7 +673,7 @@ static void ingenic_drm_unbind_all(void *d)
>>          component_unbind_all(priv->dev, &priv->drm);
>>   }
>>=20
>>  -static int ingenic_drm_bind(struct device *dev)
>>  +static int ingenic_drm_bind(struct device *dev, bool=20
>> has_components)
>>   {
>>          struct platform_device *pdev =3D to_platform_device(dev);
>>          const struct jz_soc_info *soc_info;
>>  @@ -808,7 +808,7 @@ static int ingenic_drm_bind(struct device *dev)
>>                          return ret;
>>                  }
>>=20
>>  -               if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU)) {
>>  +               if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU) &&=20
>> has_components) {
>>                          ret =3D component_bind_all(dev, drm);
>>                          if (ret) {
>>                                  if (ret !=3D -EPROBE_DEFER)
>>  @@ -939,6 +939,11 @@ static int ingenic_drm_bind(struct device *dev)
>>          return ret;
>>   }
>>=20
>>  +static int ingenic_drm_bind_with_components(struct device *dev)
>>  +{
>>  +       return ingenic_drm_bind(dev, true);
>>  +}
>>  +
>>   static int compare_of(struct device *dev, void *data)
>>   {
>>          return dev->of_node =3D=3D data;
>>  @@ -957,7 +962,7 @@ static void ingenic_drm_unbind(struct device=20
>> *dev)
>>   }
>>=20
>>   static const struct component_master_ops ingenic_master_ops =3D {
>>  -       .bind =3D ingenic_drm_bind,
>>  +       .bind =3D ingenic_drm_bind_with_components,
>>          .unbind =3D ingenic_drm_unbind,
>>   };
>>=20
>>  @@ -968,14 +973,12 @@ static int ingenic_drm_probe(struct=20
>> platform_device *pdev)
>>          struct device_node *np;
>>=20
>>          if (!IS_ENABLED(CONFIG_DRM_INGENIC_IPU))
>>  -               return ingenic_drm_bind(dev);
>>  +               return ingenic_drm_bind(dev, false);
>>=20
>>          /* IPU is at port address 8 */
>>          np =3D of_graph_get_remote_node(dev->of_node, 8, 0);
>=20
> How about we get rid of this (seems a bit odd to rely on port=20
> address) ?
> Rockchip-drm driver has a nice approach, and I think we might need
> something like that going forward, to support dw-hdmi.

The rockchip-drm approach works because all the sub-drivers must probe.=20
In the case of ingenic-drm, even if the ingenic-drm driver was compiled=20
with the ipu and dw-hdmi sub-drivers, you can't rely on these probing,=20
as they are not present on e.g. the JZ4740.

Cheers,
-Paul


