Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CC420781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593114320;
	bh=yU+UL9zYRPi6Neuu+kQq45oljX32HftopAQqcqjjsKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yQt0lLIIhHtjAQ547GCmAD56IC8WtgVORpFm2iGzdVthK/BUMn63kMVBCfHrmjDAn
	 wTgmtgE8efpUui1DR8+T231bJ4H96c4plmpuguqbMqHYhOcZ5HUqI8dMcy5/krvSei
	 tukLX6Z98KqmhLbe0bDCVRYngA+r1xWqgYZWayIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406733AbgFYTpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406069AbgFYTpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:45:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D64D2076E;
        Thu, 25 Jun 2020 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593114318;
        bh=yU+UL9zYRPi6Neuu+kQq45oljX32HftopAQqcqjjsKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNqa7Cc4RNwdrAnGojFu2d71TIpnrdl5zw8DD2dYoQcF5cxK+QMRe0GHmlkDSWVKa
         P+ph+li86wAkS0LAAs2LmjLDUi+91C2dNeNv4an+4vZFwIpz8SrI5v9bQ6NTihbZAc
         5QOrROAPajVCPTs5uXbDV7SEjhpARP+RyBmp7kOg=
Date:   Thu, 25 Jun 2020 20:45:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 003/206] ASoC: tegra: tegra_wm8903: Support nvidia,
 headset property
Message-ID: <20200625194516.GH5686@sirena.org.uk>
References: <20200623195316.864547658@linuxfoundation.org>
 <20200623195317.089299546@linuxfoundation.org>
 <20200625190119.GA5531@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Content-Disposition: inline
In-Reply-To: <20200625190119.GA5531@duo.ucw.cz>
X-Cookie: One organism, one vote.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2020 at 09:01:19PM +0200, Pavel Machek wrote:

> This property is not properly documented, not it is used anywhere.

The documentation is an issue (and another thing that probably ought to
block stable backports...) but the lack of usage is totally fine, there
is zero requirement that DTs be upstream - this is a stable ABI.

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl70/ssACgkQJNaLcl1U
h9DEEQf/Y3WE9anfajDZQGLRoWzZl7Q33Mv/MP9JBQE9PXqSZEKLbi7G2GJ6YHns
6X/pwDxWA512FoOAiHNP626StSZj7MZyFzA2wWC98RD/NGE7vqyiIRRu3ttwnVHu
/9xyjCY7wB0v67K859elevrlbnD6I1Ojhq2+jOLc48mBDN2byy8b6nfEJd34x/f4
Ji3AIO1SHQHcu2fJIRlwZMYD8yIrX7Wp2uhFjUeegj5Ew3l8masXfGrUranJcbZk
TJ1raLnfiUx24EuUjUOkua1/+CCq4WLNl/QUhEVJUuyVF7jO6RPoRZsPKm0ub1xW
btqGSjZ1gV5YS0JrTv59Xl60/ZRLRQ==
=PRwb
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
