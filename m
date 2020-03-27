Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A96EC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DFB206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0Lq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:46:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:52324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0Lq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:46:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2F94DABE9;
        Fri, 27 Mar 2020 11:46:53 +0000 (UTC)
Message-ID: <65a2d18ec2b901c6a89acc091cf9573a98fda75f.camel@suse.de>
Subject: Re: [PATCH] drm/vc4: Fix HDMI mode validation
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     maxime@cerno.tech, linux-rpi-kernel@lists.infradead.org,
        f.fainelli@gmail.com, Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Mar 2020 12:46:52 +0100
In-Reply-To: <20200326122001.22215-1-nsaenzjulienne@suse.de>
References: <20200326122001.22215-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-iTT4P/76bH6ldtNpzKaw"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iTT4P/76bH6ldtNpzKaw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, 2020-03-26 at 13:20 +0100, Nicolas Saenz Julienne wrote:
> Current mode validation impedes setting up some video modes which should
> be supported otherwise. Namely 1920x1200@60Hz.
>=20
> Fix this by lowering the minimum HDMI state machine clock to pixel clock
> ratio allowed.
>=20
> Fixes: 32e823c63e90 ("drm/vc4: Reject HDMI modes with too high of clocks"=
)
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Would it be possible for you to take this in for v5.7 (or as a fix for v5.6=
,
but it seems a little late)?

A device-tree patch I have to channel trough the SoC tree depends on this t=
o
avoid regressions.

Regards,
Nicolas


--=-iTT4P/76bH6ldtNpzKaw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5956wACgkQlfZmHno8
x/71DAf7B3ekZLOCXw9+R/a+ahSyPrsNHq1P6dzIGD6ifYIhw0z2o9RynjiWrVXR
NDEjE8EYZXkiY3su8sXVNooI6/UsMGdkt4uxl4RXt6nic8561/HvS4B0g0ZXgQNm
HfLymT4h/x9ccphfxHTOkusKgHtF+Bb80qkD1Nb0LWpLkni63WiN5G22hTLWJLxx
+8vcUD5Dt5HYl7rGMCdcPQ/Wgs6KS/Gfit8jYWrTFvbAqzEwSDTWSJoE2Sp8aqnf
Gn2yEbFF63bX3/1/HMOaL8oFPpRZIx7ztmdwSuRLx0PaqQF2D0HpvXun/7mbnhSi
5DnAf/YNQZpZHCuWOA5JhUrzzox61Q==
=IHbT
-----END PGP SIGNATURE-----

--=-iTT4P/76bH6ldtNpzKaw--

