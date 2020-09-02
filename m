Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DBDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE39207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="SrtOi2z2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N1VBIZ8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgIBPJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:09:20 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:46063 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727999AbgIBPIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:08:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 7C661D60;
        Wed,  2 Sep 2020 11:08:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 11:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=4N199FQkobK337JX6NaJjdNJ1Tw
        KdtxIk6GC3btyUAo=; b=SrtOi2z2ChvWDa5tfPeHqVKrp4mbVQpRikdJdgBfpOz
        o0YaLxKUyDs1BIzNFBguzce7mRb94WVHA1yC/MZ3LsaxstPiOr89MogRkE/s3DOs
        vkTSgdxq/RrP/2H3N4EEGFl4SqAG6PxC7oHkdepfrl8rEkS6Y4cGZfBotCPIwFzM
        EHGILdmS5wl7H/a75BVLRLUuEqRMdL9+iCltpqDdqVuxkJalXizEsX18siL4aoxk
        o5xXZkSLPBpoHZ3M8u9gGhRPRhUeeg2bfehXJE6ay6r0sZJcEbS8WeFyTVkNhkEO
        hO9QsnheUtvinvBx1w1FN77YreldZTmsJ2ek0QF05Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4N199F
        QkobK337JX6NaJjdNJ1TwKdtxIk6GC3btyUAo=; b=N1VBIZ8P6SLnobJU5o2z+L
        /gBzJFAGdFyxD8WbjLE47L5YubPdoEGOMccvcUDsCEqb/6sZOdhrOqbdbdE8lEIk
        gvNPqygOfMGKrIXSoDC1dCvcjj9Gc4/jAGbeyYwjDrJ5D0tLfEbdkJE3UzbYz4vE
        ODCiOUPgFied2mUnwMpa8sRhf6jg9zgq47CUw5S2Om7F6Ftqe98spSNwnOzuld6f
        Ebrzo+QMFGYzHeTeNH3vCXZSVlmF7FHtoMJxnFxiXd36EQqKLi8mqC83bksMSlWc
        7RlJhw168GIEQNtavO/sN5rFX/68GpCylawSRY2e+hmZi1PqUELicQKDsgooU54Q
        ==
X-ME-Sender: <xms:YbVPX0tn4g273BTUULQRHkn4ufmZ9zN1ANfhUmNPzGbbe3GRgExqaQ>
    <xme:YbVPXxd5Td1Ed0ywekAPmQC60Lj17zbgphkyEimtk37fQRx-YFy4RQkcpZSXkp9ym
    iUo_-fWi1UbAsFswo8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:YbVPX_yQW1-15_0K8tyEzjx330qF6-uu8ZvJFugV1yLpSVGk1reRJw>
    <xmx:YbVPX3OPclOrPEhqAFU-I3rm-fyZO944RbCYAS2pucHfuq-s75GgjQ>
    <xmx:YbVPX08q8Kg0jZpFQN7eUVBz2o5SKVfjZMoFISVu9BOt99fB0Pjl4A>
    <xmx:YrVPX4SwQFfQ9HT7BLtIKCd5cCJDGeVb91P3GWNky8hHM3UkPwfNoFsOF_8>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC828328005E;
        Wed,  2 Sep 2020 11:08:16 -0400 (EDT)
Date:   Wed, 2 Sep 2020 17:08:15 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 29/78] drm/vc4: crtc: Add a delay after disabling the
 PixelValve output
Message-ID: <20200902150815.kw3nynnlvgrrcygc@gilmour.lan>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <a1f22aadc60a2f32022831a6348c8bbd6e1954c3.1594230107.git-series.maxime@cerno.tech>
 <CAPY8ntBLWrfagZ5-kQz+5Mkw4_KaaTP63_L3D4owJAfA5kFpzw@mail.gmail.com>
 <20200729144251.us6a2pgkjjmm53ov@gilmour.lan>
 <ff6eca99-d98e-5b50-8b74-bba82928dda2@i2se.com>
 <20200825150606.utlynhzo664bwksy@gilmour.lan>
 <b41b066a-2d23-8ac3-be0a-c686f3954284@i2se.com>
 <20200901095829.64a5hjghf3mlsyvo@gilmour.lan>
 <27a549fe-e38d-f9a2-2677-ae5b5dc1aa45@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cdchspgt6i3o3s2q"
Content-Disposition: inline
In-Reply-To: <27a549fe-e38d-f9a2-2677-ae5b5dc1aa45@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cdchspgt6i3o3s2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 06:31:07PM +0200, Stefan Wahren wrote:
> Hi Maxime,
>=20
> Am 01.09.20 um 11:58 schrieb Maxime Ripard:
> > Hi Stefan
> >
> > On Tue, Aug 25, 2020 at 11:30:58PM +0200, Stefan Wahren wrote:
> >> Am 25.08.20 um 17:06 schrieb Maxime Ripard:
> >>> Hi Stefan,
> >>>
> >>> On Wed, Jul 29, 2020 at 05:50:31PM +0200, Stefan Wahren wrote:
> >>>> Am 29.07.20 um 16:42 schrieb Maxime Ripard:
> >>>>> Hi,
> >>>>>
> >>>>> On Wed, Jul 29, 2020 at 03:09:21PM +0100, Dave Stevenson wrote:
> >>>>>> On Wed, 8 Jul 2020 at 18:43, Maxime Ripard <maxime@cerno.tech> wro=
te:
> >>>>>>> In order to avoid pixels getting stuck in the (unflushable) FIFO =
between
> >>>>>>> the HVS and the PV, we need to add some delay after disabling the=
 PV output
> >>>>>>> and before disabling the HDMI controller. 20ms seems to be good e=
nough so
> >>>>>>> let's use that.
> >>>>>>>
> >>>>>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >>>>>>> ---
> >>>>>>>  drivers/gpu/drm/vc4/vc4_crtc.c | 2 ++
> >>>>>>>  1 file changed, 2 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4=
/vc4_crtc.c
> >>>>>>> index d0b326e1df0a..7b178d67187f 100644
> >>>>>>> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> >>>>>>> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> >>>>>>> @@ -403,6 +403,8 @@ static void vc4_crtc_atomic_disable(struct dr=
m_crtc *crtc,
> >>>>>>>         ret =3D wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_=
VIDEN), 1);
> >>>>>>>         WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n"=
);
> >>>>>>>
> >>>>>>> +       mdelay(20);
> >>>>>> mdelay for 20ms seems a touch unfriendly as it's a busy wait. Can =
we
> >>>>>> not msleep instead?
> >>>>> Since the timing was fairly critical, sleeping didn't seem like a g=
ood
> >>>>> solution since there's definitely some chance you overshoot and end=
 up
> >>>>> with a higher time than the one you targeted.
> >>>> usleep_range(min, max) isn't a solution?
> >>> My understanding of usleep_range was that you can still overshoot, ev=
en
> >>> though it's backed by an HR timer so the resolution is not a jiffy. A=
re
> >>> we certain that we're going to be in that range?
> >> you are right there is no guarantee about the upper wake up time.
> >>
> >> And it's not worth the effort to poll the FIFO state until its empty
> >> (using 20 ms as timeout)?
> > I know this isn't really a great argument there, but getting this to
> > work has been quite painful, and the timing is very sensitive. If we
> > fail to wait for enough time, there's going to be a pixel shift that we
> > can't get rid of unless we reboot, which is pretty bad (and would fail
> > any CI test that checks for the output integrity).
> >
> > I know busy-looping for 20ms isn't ideal, but it's not really in a
> > hot-path (it's only done when changing a mode), with the sync time of
> > the display likely to be much more than that, and if it can avoid having
> > to look into it ever again or avoid random failures, I'd say it's worth
> > it.
>=20
> i don't want to delay this series.
>=20
> Could you please add a small comment to the delay to clarify the timing
> is very sensitive?

I will, thanks!
Maxime

--cdchspgt6i3o3s2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0+1XwAKCRDj7w1vZxhR
xTExAQDs1BYdGeS/lvk546x1sgn6AifEwOlrVxDSeMO/QWhu3wD/RfIhHhh1s1j1
DfqNBjaatkPCQAZkursDakHjOFFOYQI=
=bDzq
-----END PGP SIGNATURE-----

--cdchspgt6i3o3s2q--
