Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB95C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E552087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="mFUwSTt/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XColh7e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgIBOs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:48:57 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:50575 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728067AbgIBOst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:48:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 4205EA32;
        Wed,  2 Sep 2020 10:48:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 10:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=+G3nbi5B6jFaWrY/cB8uCRGjt6D
        lWYVRkm6qWyt7TBA=; b=mFUwSTt//pDZi9BrpQ3mF3MVVo33cVUnDi8Syqiyb4y
        iQoLyQIiorx4U1vGvvjwRpNBw6UcyujE8ipRVzL4CKz4uPOfOJ45ndRdU9NAwEZn
        qKj7ba/zTOtL02x17Ffqz/Okzio46PaY4Gpuv8Fy1XsHwTG96OgndfgonLizds8h
        h6cgzVNA7jjy64bKMHJONqVaFx2y7Xx2OnQ8nGiGSf4d6Ms8DZrIQT7s/qor2/oV
        UfddLUqul1KMtSyw9/bDHpS0POPiyn/9STuSyGUdvgF9jjPWpfvja4gx0ZhWGDl1
        nPu0I1/pus364SYezK8BFSemGnwTGypZ6i21Nq2SsqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+G3nbi
        5B6jFaWrY/cB8uCRGjt6DlWYVRkm6qWyt7TBA=; b=XColh7e5maJhOmEYrJ1jXs
        pH8JpNl6qmK0pUZ2UjHbQHSopas8M5/CFa78yaWEZq6TkeqRQ03k93SMpNYGrugz
        6G89mQdNeFFzNt3vOBtln15CZE5oI0ObvF3HbHdVKiW/jlQNU+tlU5CSiwSNMtLW
        CcxMK2ZPEXhtWwEiuldeyTi97Zp+6TMS7ndvGhP4VKaIVeih2jFExRTn5cFjBHql
        81nfDMYH9B1Sdjaq+pOJgr0Z5//Q4VRSiz61nOVv4jXTFDBkRy4ydo4aEbBjnm4p
        3eCNWw96dPzJ6aDK8UfKlXRfrr+GOGjihuA1lItcp0J/Q33Sm9IVRi7zh2WSrRJA
        ==
X-ME-Sender: <xms:zbBPX0Fw_YppuVYx8HMoISbqJK3-7PPEqQRazG3NblSwM5N0j8ai_w>
    <xme:zbBPX9VNpQJGkxLHzhy3tSq4fkgOMs4sPIQ0_Dv2a6PNULUG7MGBphsO_gSLsrK7n
    SAzDpGKS-PfCxmV-KM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:zrBPX-LZCxILOK66scs3oPjvnnLxiouWDsvoCjBFha53AfjPdFv60A>
    <xmx:zrBPX2E9CHK6WGpGBJ4gvSwnsWqW45nheIs__uknJfXoejb7jqzs2Q>
    <xmx:zrBPX6UMV-QNrYOPrSsQT1a2gA0LO3_4I1-7F5riwCp9fjv6GHPqzw>
    <xmx:zrBPX-r-zF5ex2hhPw2WpEglLaTpLxO4A81TIGVpMVQyoEbnZBZVOBU8HhE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF354328005D;
        Wed,  2 Sep 2020 10:48:45 -0400 (EDT)
Date:   Wed, 2 Sep 2020 16:48:43 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v4 03/78] drm/vc4: hvs: Boost the core clock during
 modeset
Message-ID: <20200902144843.fuvgtu62wdrnd4on@gilmour.lan>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <CGME20200708174243epcas1p2b5646e3d45e412d1cd1286d90cb9cc37@epcas1p2.samsung.com>
 <b04341887fb1acb9ed4adc28d109f9e21f146c7d.1594230107.git-series.maxime@cerno.tech>
 <a4f6ea62-441a-8e5b-5383-13d7f2b1a920@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oo64qjpa7isnxgnm"
Content-Disposition: inline
In-Reply-To: <a4f6ea62-441a-8e5b-5383-13d7f2b1a920@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oo64qjpa7isnxgnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 01, 2020 at 08:21:36PM +0900, Chanwoo Choi wrote:
> Hi Maxime,
>=20
> On 7/9/20 2:41 AM, Maxime Ripard wrote:
> > In order to prevent timeouts and stalls in the pipeline, the core clock
> > needs to be maxed at 500MHz during a modeset on the BCM2711.
> >=20
> > Reviewed-by: Eric Anholt <eric@anholt.net>
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  drivers/gpu/drm/vc4/vc4_drv.h |  2 ++
> >  drivers/gpu/drm/vc4/vc4_hvs.c |  9 +++++++++
> >  drivers/gpu/drm/vc4/vc4_kms.c |  9 +++++++++
> >  3 files changed, 20 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_dr=
v.h
> > index e4cde1f9224b..6358f6ca8d56 100644
> > --- a/drivers/gpu/drm/vc4/vc4_drv.h
> > +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> > @@ -320,6 +320,8 @@ struct vc4_hvs {
> >  	void __iomem *regs;
> >  	u32 __iomem *dlist;
> > =20
> > +	struct clk *core_clk;
> > +
> >  	/* Memory manager for CRTCs to allocate space in the display
> >  	 * list.  Units are dwords.
> >  	 */
> > diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hv=
s.c
> > index 836d8799d79e..091fdf4908aa 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> > @@ -19,6 +19,7 @@
> >   * each CRTC.
> >   */
> > =20
> > +#include <linux/clk.h>
> >  #include <linux/component.h>
> >  #include <linux/platform_device.h>
> > =20
> > @@ -540,6 +541,14 @@ static int vc4_hvs_bind(struct device *dev, struct=
 device *master, void *data)
> >  	hvs->regset.regs =3D hvs_regs;
> >  	hvs->regset.nregs =3D ARRAY_SIZE(hvs_regs);
> > =20
> > +	if (hvs->hvs5) {
> > +		hvs->core_clk =3D devm_clk_get(&pdev->dev, NULL);
> > +		if (IS_ERR(hvs->core_clk)) {
> > +			dev_err(&pdev->dev, "Couldn't get core clock\n");
> > +			return PTR_ERR(hvs->core_clk);
> > +		}
> > +	}
> > +
> >  	if (!hvs->hvs5)
> >  		hvs->dlist =3D hvs->regs + SCALER_DLIST_START;
> >  	else
> > diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_km=
s.c
> > index 08318e69061b..210cc2408087 100644
> > --- a/drivers/gpu/drm/vc4/vc4_kms.c
> > +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> > @@ -11,6 +11,8 @@
> >   * crtc, HDMI encoder).
> >   */
> > =20
> > +#include <linux/clk.h>
> > +
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > @@ -149,6 +151,7 @@ vc4_atomic_complete_commit(struct drm_atomic_state =
*state)
> >  {
> >  	struct drm_device *dev =3D state->dev;
> >  	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> > +	struct vc4_hvs *hvs =3D vc4->hvs;
> >  	struct vc4_crtc *vc4_crtc;
> >  	int i;
> > =20
> > @@ -160,6 +163,9 @@ vc4_atomic_complete_commit(struct drm_atomic_state =
*state)
> >  		vc4_hvs_mask_underrun(dev, vc4_crtc->channel);
> >  	}
> > =20
> > +	if (vc4->hvs->hvs5)
> > +		clk_set_min_rate(hvs->core_clk, 500000000);
> > +
> >  	drm_atomic_helper_wait_for_fences(dev, state, false);
> > =20
> >  	drm_atomic_helper_wait_for_dependencies(state);
> > @@ -182,6 +188,9 @@ vc4_atomic_complete_commit(struct drm_atomic_state =
*state)
> > =20
> >  	drm_atomic_helper_commit_cleanup_done(state);
> > =20
> > +	if (vc4->hvs->hvs5)
> > +		clk_set_min_rate(hvs->core_clk, 0);
> > +
> >  	drm_atomic_state_put(state);
> > =20
> >  	up(&vc4->async_modeset);
> >=20
>=20
> This patch doesn't control the enable/disable of core_clk.
> So, I think that it need to handle the clock as following:
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 4ef88c0b51ab..355d67fd8beb 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -588,6 +588,12 @@ static int vc4_hvs_bind(struct device *dev, struct d=
evice *master, void *data)
>                         dev_err(&pdev->dev, "Couldn't get core clock\n");
>                         return PTR_ERR(hvs->core_clk);
>                 }
> +
> +               ret =3D clk_prepare_enable(hvs->core_clk);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Couldn't enable core clock\n=
");
> +                       return ret;
> +               }
>         }
> =20
>         if (!hvs->hvs5)
> @@ -681,6 +687,8 @@ static void vc4_hvs_unbind(struct device *dev, struct=
 device *master,
>         drm_mm_takedown(&vc4->hvs->dlist_mm);
>         drm_mm_takedown(&vc4->hvs->lbm_mm);
> =20
> +       clk_prepare_enable(vc4->hvs->core_clk);
> +
>         vc4->hvs =3D NULL;
>  }

Good catch, thanks!
Maxime

--oo64qjpa7isnxgnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0+wywAKCRDj7w1vZxhR
xWO1AQDeDuT9LC5OJjJCw0wJbII/glIroNJaR6BYRKSfUw2EVAEAg87EDHY2jhPJ
nlutA8am7X/slgA6UtdYLqOm5hJ6Lgo=
=gbvn
-----END PGP SIGNATURE-----

--oo64qjpa7isnxgnm--
