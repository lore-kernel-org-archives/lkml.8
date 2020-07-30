Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA03C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1983222B42
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596127748;
	bh=Wi7LMVSqES6xakVzVVsnmHXkISayOsW7D4YJWLJCn3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I6TP8Wq5lyHyVE3YkS/3Qwizs9Gjgu4couS38aFalCOS4sX8Cm3xdXwkkBe+hT+lk
	 ryA9Nhpcr67Uy1kmh6Kf5uyAuKt6qIOILgK4VKTplJmZRyXSXwS/hhIlLzHdaL5c1h
	 /8eOKFSyhmjbQ78hYEvr4ND1/7zl6v5EOGAl9UAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgG3QtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3QtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:49:05 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD733207F5;
        Thu, 30 Jul 2020 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596127745;
        bh=Wi7LMVSqES6xakVzVVsnmHXkISayOsW7D4YJWLJCn3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zmb7afjLpegOR3tGn/JpIIN/p+wE91ap2d1ddBb7IMI4D29F2LSRidnRC4T9hgdRw
         EGR6eiQ12u4hN1uU/fWn95U09rp862CWnpbcBnWPiH/a91DqtXmUFdEl8L3BpclCcu
         9iOiwe/u77goaNG9p4qTuNVuJKIZUWiBYh2kO0Oc=
Date:   Thu, 30 Jul 2020 17:48:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v9 0/4] driver core: add probe error check helper
Message-ID: <20200730164845.GE5055@sirena.org.uk>
References: <CGME20200713144331eucas1p25911c4ffa9315f632d8f6dd833588981@eucas1p2.samsung.com>
 <20200713144324.23654-1-a.hajda@samsung.com>
 <e55a23bf-59bb-43c6-f7d7-467c282b8648@samsung.com>
 <20200730070832.GA4045592@kroah.com>
 <CAKdAkRTKjHg2y8yTFgxr4yY98M8D2noutDBfB1mh7wwLLQrYbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline
In-Reply-To: <CAKdAkRTKjHg2y8yTFgxr4yY98M8D2noutDBfB1mh7wwLLQrYbw@mail.gmail.com>
X-Cookie: Alex Haley was adopted!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 30, 2020 at 09:18:30AM -0700, Dmitry Torokhov wrote:

> I believe it still has not been answered why this can't be pushed into
> resource providers (clock, regulators, gpio, interrupts, etc),
> especially for devm APIs where we know exactly what device we are
> requesting a resource for, so that individual drivers do not need to
> change anything.

The error messages are frequently in the caller rather than the
frameworks, it's often helpful for the comprehensibility of the error
messages especially in cases where things may be legitimately absent.

>                  We can mark the device as being probed so that probe
> deferral is only handled when we actually execute probe() (and for the
> bonus points scream loudly if someone tries to return -EPROBE_DEFER
> outside of probe path).

Is this a big issue?

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8i+ewACgkQJNaLcl1U
h9DueQf/QkO4v81CMD7SEApOvQjNBQ1RWfJ8Q/NBYJFxm8NmmOowBWYnNXFzRu1O
oCF+JukJ6znqRqsocboI/8sUkUQ7hWLi9S53VaUkYdArscPZ0myQ8/lb9nqKXqqi
NlCnEGNxEUprZBxyD1T/qOnoi1hFGko+shXG59pLoYD9SCA0sODJwONb4ktVuJ7J
7kG2/jF6y5Qs2tMNcDHklnrXZg9yWPIdD9ppl4K2soYw17TyIiF+UZdunZSlWFZ5
M3Sz+fbK3xPZodecRz6tqaDm48bAsqe51dFa5DbIt6/DPLBo/+cLzpSONZTCUxxs
hqEsIHEG2ZQ+9cGRQtCPFGruqG5tvA==
=SqHC
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
