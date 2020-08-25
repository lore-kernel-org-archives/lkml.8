Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EED8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D3A2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="qIpyzpWq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qzOmkcJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHYPGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:06:16 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:57253 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgHYPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:06:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 275BE2CD;
        Tue, 25 Aug 2020 11:06:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 11:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=3I3j5EOU60U1Ry7H1RtmtTOIRsx
        0SMf4gLT/+JVsv3s=; b=qIpyzpWqvt49gOQjIw0P0YCE2o/ZjNok7k0l03cLlv+
        ZNuULsmpjgGUIgHy7RDdPRQ6tB30SnDfI67RXYZWdKMv5Bm8MggcpzKmHXkAv/Rh
        deoC3EWpwQGa991tom1omCJZuh1oMAUqOg3hIfGHEOXWNhDjfyngbihaqb9SKl/h
        a3qlD4IbkfRjq6zenklH3d43+CwRAEKcUDYe9h2lNBrKjiYf9vlatkMtz/98M0kp
        R06d/Arif3zzDdMXJbUn/zhOmTaXBQhwpmSqfUBFwpLoQQlSx3kY9RsxX54QOABL
        38OA7qovlZ/SQshAtEfv3qAZiTrvYF4Qzwb9vmb7U6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3I3j5E
        OU60U1Ry7H1RtmtTOIRsx0SMf4gLT/+JVsv3s=; b=qzOmkcJu5rhTpkZVcdNhea
        bN4ZfR5/9NMiAQfypTNM3a/2wYBmsuFeh+hAvANlrlhodAp6AJb+vBuJscM6LoaM
        8bRICOzMMOBrxLps3y8Lusrq8vCNl/ZnnXxghVld9K3kxIdb4b26454xnQpSW+Yv
        pACmmzRT/K7nrc0zemOoPQ7LgGW33mryry5kf15hPBFqnq7Wc1cUYx9/jcTYQA2I
        1ipQFOOTQ9WKZGM2sZ9LQ1UNMfBYb+iotUo/Is4vaKR1nbqMo0E0nikRdIF/uALW
        81DctUrFdzz7tZKnztYKE8FRuqt5ZaoxRVuvdNemrpn/TMF6qaHZEAk4HFC2ZUQw
        ==
X-ME-Sender: <xms:4ChFX0bSx9W0Znia52kwIwRyTGKvg5JNkn1Xqchou6x4CYpRS5VtTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:4ChFX_aHfWHINNwK6U-Fw35J35K8kmyiTo9Wr4mD8L0WZ2fWb7yElw>
    <xmx:4ChFX-8_wuzxIem1Ch830fXwF5JwhpY4fWY2sXBzEJ9tu22ZQ5ASNQ>
    <xmx:4ChFX-peXcuf1lTBpFTmkcOTpsnuQD8wkeVGkybIPEzAlyzlFimteA>
    <xmx:4ihFX7L70Inwhrj51vikWUZKeo623Hway8xr1A2iFuJ78Phb5-nCDgr7Pn4>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4B3AE3280067;
        Tue, 25 Aug 2020 11:06:08 -0400 (EDT)
Date:   Tue, 25 Aug 2020 17:06:06 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 29/78] drm/vc4: crtc: Add a delay after disabling the
 PixelValve output
Message-ID: <20200825150606.utlynhzo664bwksy@gilmour.lan>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <a1f22aadc60a2f32022831a6348c8bbd6e1954c3.1594230107.git-series.maxime@cerno.tech>
 <CAPY8ntBLWrfagZ5-kQz+5Mkw4_KaaTP63_L3D4owJAfA5kFpzw@mail.gmail.com>
 <20200729144251.us6a2pgkjjmm53ov@gilmour.lan>
 <ff6eca99-d98e-5b50-8b74-bba82928dda2@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gbp4s6jsz2sfula3"
Content-Disposition: inline
In-Reply-To: <ff6eca99-d98e-5b50-8b74-bba82928dda2@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gbp4s6jsz2sfula3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Wed, Jul 29, 2020 at 05:50:31PM +0200, Stefan Wahren wrote:
> Am 29.07.20 um 16:42 schrieb Maxime Ripard:
> > Hi,
> >
> > On Wed, Jul 29, 2020 at 03:09:21PM +0100, Dave Stevenson wrote:
> >> On Wed, 8 Jul 2020 at 18:43, Maxime Ripard <maxime@cerno.tech> wrote:
> >>> In order to avoid pixels getting stuck in the (unflushable) FIFO betw=
een
> >>> the HVS and the PV, we need to add some delay after disabling the PV =
output
> >>> and before disabling the HDMI controller. 20ms seems to be good enoug=
h so
> >>> let's use that.
> >>>
> >>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >>> ---
> >>>  drivers/gpu/drm/vc4/vc4_crtc.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4=
_crtc.c
> >>> index d0b326e1df0a..7b178d67187f 100644
> >>> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> >>> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> >>> @@ -403,6 +403,8 @@ static void vc4_crtc_atomic_disable(struct drm_cr=
tc *crtc,
> >>>         ret =3D wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDE=
N), 1);
> >>>         WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
> >>>
> >>> +       mdelay(20);
> >> mdelay for 20ms seems a touch unfriendly as it's a busy wait. Can we
> >> not msleep instead?
> > Since the timing was fairly critical, sleeping didn't seem like a good
> > solution since there's definitely some chance you overshoot and end up
> > with a higher time than the one you targeted.
>=20
> usleep_range(min, max) isn't a solution?

My understanding of usleep_range was that you can still overshoot, even
though it's backed by an HR timer so the resolution is not a jiffy. Are
we certain that we're going to be in that range?

Maxime

--gbp4s6jsz2sfula3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0Uo3gAKCRDj7w1vZxhR
xTjQAQCZiLqHqiPNSDq7T1euBsIbQ+XTGhdLmdnBZbUIO+1VPwEA1z/O7HFK3t4N
IhM8AxotumyFnRcchBjauHOWLcdL+Qo=
=am4A
-----END PGP SIGNATURE-----

--gbp4s6jsz2sfula3--
