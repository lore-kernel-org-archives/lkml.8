Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8339BC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C7B20708
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbgIHTKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:10:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56356 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbgIHTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:10:24 -0400
Received: from kevin (unknown [IPv6:2607:fea8:55f:a950::68f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 93A0B295E47;
        Tue,  8 Sep 2020 20:10:18 +0100 (BST)
Date:   Tue, 8 Sep 2020 15:10:10 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 4/5] drm/panfrost: add amlogic reset quirk callback
Message-ID: <20200908191010.GB10568@kevin>
References: <20200908151853.4837-1-narmstrong@baylibre.com>
 <20200908151853.4837-5-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20200908151853.4837-5-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Since the documentation of the GPU cores are not public, we do not know what does these
> values, but they permit having a fully functional GPU running with Panfrost.

Since this is Amlogic magic, not specifically GPU, I'd rephrase this as
"Since the Amlogic's integration of the GPU cores with the SoC is not
publicly documented..."

> +	/*
> +	 * The Amlogic integrated Mali-T820, Mali-G31 & Mali-G52 needs
> +	 * these undocumented bits to be set in order to operate
> +	 * correctly.
> +	 * These GPU_PWR registers contains:
> +	 * "device-specific power control value"
> +	 */

PWR_OVERRIDE1 is the Amlogic specific value.

Per the name, for PWR_KEY, I'd do add "#define GPU_PWR_KEY_UNLOCK
0x2968A819" in panfrost-gpu.h so it's clear which value is which.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl9X1woACgkQ/v5QWgr1
WA0XAg//c9nGGJntvueFe8c6qd2IaRIMN3EM6NDls15z8sc2USz064lxnb0x5o15
futnTLgG+9RPsMRDl3GmLwHyffyRWWIupoVPgMEu/RdWUai8d4yKyF76xVDpUOAD
RnPBzvstwXzN3Wggj47fB6ajEZFFOI2erWqEgAY8UZARPkw3jP+lUbHpagmKdMVF
SYrAuYXOZmOjdlHXeTM4jxAW1I76imu2iEnvm+/2bpgRUumypy3/K33/wICFL9W3
RVC1/2Gw6zRrhT9Je9eVBLID7xoeJk5jFHAFss9xd+OtshquOBlapVXwJVcfEm+p
gDFNrxG/pXgrJvkI6a8anp0cqyaixvIONfMt2fJwfTbqP5+K0QigQFVclGa6eXM3
iLkfjlbgrCn8iiywRBx7BunsMqMWgHEt5K78PGczw2JmU+Ahp1O1vq9Az0s2yYIt
X5nlp/iwUHRtPEnoNwqPFfasUnO3UAkObmax9oZVG3iBede/wMMWDOvm/J0Q8pEq
jI/liFrKDPa7Qnkwara3B1hxAeMedig7Qi+RAFuRTUFlNCoBuD4TfCcvBGqH1cDX
aupOBHrxmstHtZH5lnCcy7cXepJuCOmati2khQRvoOJolnRYI1HFyt2poZT3HQ+w
K8zkmWUzKZZk/QwJn31i7zX7emvAvma0aO3dGzdT4+F3OMeJRf0=
=eeWO
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
