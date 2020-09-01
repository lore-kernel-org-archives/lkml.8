Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DB7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB642206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="dygodJFo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UB1kD/0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIAJ6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:58:34 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:35269 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgIAJ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:58:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E92ADEBD;
        Tue,  1 Sep 2020 05:58:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Sep 2020 05:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=+iAh4aljY3pCe+asolVpEIJfMGI
        jY9QIjsrE3sOKCtE=; b=dygodJFonFvm51AMycgBuf+IRqbIhNDlFi5LBR92pIB
        pVf+mHYo2ZKNjyYdDFll1x9jCyaT2pe3VsrUxuRqb1C8ETRGa0LNpehxt/dL/tu/
        4IPEq5iOi4mGDZ2rYLFQHI8FiZyiyhC5uaZmGflY2+qRvwdpezZuRQ9+hmqqYBkm
        3/zwPrqgN7HW3RiEPOvo4RIIQIgahfVRFjbNNDj942dzXkagMAItjM/l3Ezq7Zh+
        Vkke+1RzqaaaNh/yZP9fWlX+rE3aVAMgNA5oNTGnzPUxELfszvvpRLjHd1o5oH2u
        HeNirwY17E9e52j13hitbMAszN8Q9/nmwhcg4lUaGTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+iAh4a
        ljY3pCe+asolVpEIJfMGIjY9QIjsrE3sOKCtE=; b=UB1kD/0uql71evFTo8AJRF
        vouAnnP2gdCeXifw2lVkkHPiWXuOsn0QpWIn1LHe0Ap5zQmJ95ivAirb0aLwboGI
        rPbuVjjfGBBvq7vZKu4amHkqOJKtycLNiDdvfMSiC71XlLctZsO7GCySmGT7H6PI
        j5tA6x6ux2o9NV84i9skBK9tWygQgCvZOftCqcBpV8kU8iRIHqNWpfm8/E/VAXZj
        tQbConwxmbO16sV78/aS5ggQV1Ezav8REmWTA5AgCHTQpgDWreXU8Pc7AZr2+uuz
        h4LrVQ6qXXhVr+LebLzRYR9WGYb5eM00dq/eZEV7I1/8AGdju2bsVEONpL+lCLlA
        ==
X-ME-Sender: <xms:RhtOX71WUJL189J-f_m1mERckl3Dbssbiy2WdmG27XbGtBzipZH05g>
    <xme:RhtOX6HYVJ7vUIfSr97Z0oUSerXk8Hb4hUdiB00MmuIfVnf3yyMoRz-PnMYw3456x
    KRZFYQJZ-IUCVwobao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:RhtOX746je543HZECkowYPmQYUgKO7AnCbYke1c5_eV03pF2c_IS9w>
    <xmx:RhtOXw0j9KThQUUQJ9RwP75CK_0IFMagFZtzJeS6RQIT4ZMkuTgj5w>
    <xmx:RhtOX-FesGUDjyb4ff7C5bQCm66AwhIJReHMNH7X3y5qtyLCYLj4qQ>
    <xmx:RxtOX8ZOGMLGFTKuzEzm7oVJkGcBHYbCsrYHJoWTsm8O_MMduKzr4awF-tE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 583D93280060;
        Tue,  1 Sep 2020 05:58:30 -0400 (EDT)
Date:   Tue, 1 Sep 2020 11:58:29 +0200
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
Message-ID: <20200901095829.64a5hjghf3mlsyvo@gilmour.lan>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <a1f22aadc60a2f32022831a6348c8bbd6e1954c3.1594230107.git-series.maxime@cerno.tech>
 <CAPY8ntBLWrfagZ5-kQz+5Mkw4_KaaTP63_L3D4owJAfA5kFpzw@mail.gmail.com>
 <20200729144251.us6a2pgkjjmm53ov@gilmour.lan>
 <ff6eca99-d98e-5b50-8b74-bba82928dda2@i2se.com>
 <20200825150606.utlynhzo664bwksy@gilmour.lan>
 <b41b066a-2d23-8ac3-be0a-c686f3954284@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gko6mttywam5g2hb"
Content-Disposition: inline
In-Reply-To: <b41b066a-2d23-8ac3-be0a-c686f3954284@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gko6mttywam5g2hb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan

On Tue, Aug 25, 2020 at 11:30:58PM +0200, Stefan Wahren wrote:
> Am 25.08.20 um 17:06 schrieb Maxime Ripard:
> > Hi Stefan,
> >
> > On Wed, Jul 29, 2020 at 05:50:31PM +0200, Stefan Wahren wrote:
> >> Am 29.07.20 um 16:42 schrieb Maxime Ripard:
> >>> Hi,
> >>>
> >>> On Wed, Jul 29, 2020 at 03:09:21PM +0100, Dave Stevenson wrote:
> >>>> On Wed, 8 Jul 2020 at 18:43, Maxime Ripard <maxime@cerno.tech> wrote:
> >>>>> In order to avoid pixels getting stuck in the (unflushable) FIFO be=
tween
> >>>>> the HVS and the PV, we need to add some delay after disabling the P=
V output
> >>>>> and before disabling the HDMI controller. 20ms seems to be good eno=
ugh so
> >>>>> let's use that.
> >>>>>
> >>>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >>>>> ---
> >>>>>  drivers/gpu/drm/vc4/vc4_crtc.c | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/v=
c4_crtc.c
> >>>>> index d0b326e1df0a..7b178d67187f 100644
> >>>>> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> >>>>> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> >>>>> @@ -403,6 +403,8 @@ static void vc4_crtc_atomic_disable(struct drm_=
crtc *crtc,
> >>>>>         ret =3D wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VI=
DEN), 1);
> >>>>>         WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
> >>>>>
> >>>>> +       mdelay(20);
> >>>> mdelay for 20ms seems a touch unfriendly as it's a busy wait. Can we
> >>>> not msleep instead?
> >>> Since the timing was fairly critical, sleeping didn't seem like a good
> >>> solution since there's definitely some chance you overshoot and end up
> >>> with a higher time than the one you targeted.
> >> usleep_range(min, max) isn't a solution?
> > My understanding of usleep_range was that you can still overshoot, even
> > though it's backed by an HR timer so the resolution is not a jiffy. Are
> > we certain that we're going to be in that range?
>=20
> you are right there is no guarantee about the upper wake up time.
>=20
> And it's not worth the effort to poll the FIFO state until its empty
> (using 20 ms as timeout)?

I know this isn't really a great argument there, but getting this to
work has been quite painful, and the timing is very sensitive. If we
fail to wait for enough time, there's going to be a pixel shift that we
can't get rid of unless we reboot, which is pretty bad (and would fail
any CI test that checks for the output integrity).

I know busy-looping for 20ms isn't ideal, but it's not really in a
hot-path (it's only done when changing a mode), with the sync time of
the display likely to be much more than that, and if it can avoid having
to look into it ever again or avoid random failures, I'd say it's worth
it.

Maxime

--gko6mttywam5g2hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX04bRQAKCRDj7w1vZxhR
xW3HAP49wZn0aa04HikR94/0ojilhpDXd01fDhWp5vQNPKerGwEAjBoqFGrVZZ3e
UhBx+aeqO0CmnV+unyE9Fc/YCfCx0gc=
=2JLx
-----END PGP SIGNATURE-----

--gko6mttywam5g2hb--
