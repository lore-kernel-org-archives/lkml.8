Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A788C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EAA24676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579005215;
	bh=GNo7GoNGEwHDf9hL6DaV/TE/xXi0XLmG1ZXEKYk5VPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZMMK/kNw2kYA/NrmyBT0n/y6X3pzZ/1Yds/GpnLzQZHXLenEi17Ey7xmYpgp4iaj2
	 Y7aqvCFXMmst6xBuXIyOCWoCkHGoy7xHo3MbTuW4Q/NDufJQ3RHQepTVjkkYZM850Y
	 HeZX8UXuQrKFcOIHCggP0I9Pvi72OZFX19H3V/ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgANMdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:33:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41290 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgANMde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kd9ZO/CCEhqZWiHfuv2KB8A8I9ZY16copGuRmlFuYrU=; b=g8vgAnzdJRO4gINqS6LTdF/Vr
        WxFo4qzT/9UTGg3hBLNNgvbLPAVGRbzAgwxyeDm/TLu09HhXpKh60OfLZetVFJYJrmzR/aEP0cwQM
        OLjnSr/K6cQGwJ9Pa/LXjik8KToL7OedT11aRkFhkR0YcbH2pkUNP/oYB5OOSIsXin088=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irLNs-000846-Pc; Tue, 14 Jan 2020 12:33:24 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 7A89AD01965; Tue, 14 Jan 2020 12:33:24 +0000 (GMT)
Date:   Tue, 14 Jan 2020 12:33:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] dt-bindings: regulator: add document bindings for
 mpq7920
Message-ID: <20200114123324.GS3897@sirena.org.uk>
References: <20200109112548.23914-1-sravanhome@gmail.com>
 <20200109112548.23914-3-sravanhome@gmail.com>
 <CAL_JsqJ4vTzyfAG2UWzzkhVkBSLDRPjdyDUFZJ9LrDmsFsQ1gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="foM9DbudB2CcldhH"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ4vTzyfAG2UWzzkhVkBSLDRPjdyDUFZJ9LrDmsFsQ1gA@mail.gmail.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--foM9DbudB2CcldhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2020 at 10:56:55AM -0600, Rob Herring wrote:
> On Thu, Jan 9, 2020 at 5:26 AM Saravanan Sekar <sravanhome@gmail.com> wrote:

> > Add device tree binding information for mpq7920 regulator driver.
> > Example bindings for mpq7920 are added.

> Mark, Please revert this. Not even close to valid schema and my
> questions on v4 are unanswered.

OK...  I didn't see any comments on V5.

> > +      mps,switch-freq:

> As I asked on v4, shouldn't this be a common property? Switching
> frequency is a common property for switching regulators, right?

It's not very common and where it's offered the valid values are
generally highly constrained so I'm not sure it makes sense to do
that, any device that does have this feature will want to specify
the valid values for that particular device.

--foM9DbudB2CcldhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4dtRMACgkQJNaLcl1U
h9CAuAf/bAfTT3rYtCh0iL5pJ5AemEgO/3RbG+Zke1dFVUaYwpEDpyfsxSysbSqm
LIc4dsM+NPfiQ7LxzMfXNfzydbdj+1Ts+pVnlnJkbE7daQvZY008yEQghcswTD3M
9qZWmJNCHZtH0knhDN2Zekoei9nWqHvLoYAC/X24QT/okiNFTRjIepKKYLobx3mm
RkdwNumjL86O9EuYVgznLyFfr0BvmvqagpDhBV5KHdBQNUgHvr0JjQAKoVUR4N+A
qoJSp3OTaBtLvHGUv1BhqLbITn4eRLlP3uKw+H5EgmMQKW75U6dGwmh6a+nswI7E
Xp7ZiwxEKfBN252W1sexbJOmhkm+7A==
=qm5x
-----END PGP SIGNATURE-----

--foM9DbudB2CcldhH--
