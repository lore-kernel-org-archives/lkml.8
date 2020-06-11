Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B43C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BEAD2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591881679;
	bh=I5ENpceYxIWNF/3WX7IIhHeshmGtz9rRT5nBSTNeWec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BSzJ2hSSKLmyXqVkgewlVP+7cQjtaLog6YmMbOxfvpI9nxrvSZo5WQ/6/5Ot7yU2W
	 O0usMLkul9KpHiBai7htG0WVytt0/s7ADEk3zR8MrLGSlDSGzfsB/hLlskiQ5fv5x9
	 zLYImNZvsHGyP5uO2if7vSQrtLjzCxdw6XT9YEto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgFKNVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgFKNVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:21:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A69620747;
        Thu, 11 Jun 2020 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591881677;
        bh=I5ENpceYxIWNF/3WX7IIhHeshmGtz9rRT5nBSTNeWec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xx0gTELZP6mEKcRPnP4fyvM/iuxpVI1IBpgikLaX7CxIrqYt8sQ7frkk0f4bCtYMs
         m6s3o72B3/Se4uq6LbatOlRZHKZPkdq1SadpQSyuMrWTD2slqNjFNfl2C6LunVhqJD
         zk7A+boMeItv9ELSmDSfqAV7UYcTcbczQzAS59PI=
Date:   Thu, 11 Jun 2020 14:21:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Yicheng Li <yichengli@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] regulator: Add driver for cros-ec-regulator
Message-ID: <20200611132114.GF4671@sirena.org.uk>
References: <20200611082542.219516-1-pihsun@chromium.org>
 <20200611082542.219516-3-pihsun@chromium.org>
 <e0a04440-bb15-921d-16e3-1b7ebd76b652@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <e0a04440-bb15-921d-16e3-1b7ebd76b652@collabora.com>
X-Cookie: I like your SNOOPY POSTER!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2020 at 01:44:42PM +0200, Enric Balletbo i Serra wrote:
> On 11/6/20 10:25, Pi-Hsun Shih wrote:
> > Add driver for cros-ec-regulator, representing a voltage regulator that
> > is connected and controlled by ChromeOS EC, and is controlled by kernel
> > with EC host commands.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7iL8kACgkQJNaLcl1U
h9C3MAf8DIvLY3fzotpeSPZ8iHWNIScgd5XL7q7SclE+gNlygeQzSlVQIXO2SQwr
fFHO3DOmnAvYhY0CL1/qBrmaINol6yY0hkon+jxD3O2+JzNR1gq5WlEJPpwsxN38
ornsBdSy7drV4lAMU24RKrqf6fXsKEeyHAZ0buOMaeerK0vJmMIAKgd3P3BB4J3r
FkiQ/B71GGEsMGmtK1t9oaa3ZGP2kNH2UA5SrcxYN8jxMUtd3m4CX3fvbRs8HDbV
i44H0u1fvuDlhI0j5qDBn0zAPuaeIwiD+VBUhxBIWXjmlkLp35kACjYbOu7nU1KT
ugNiEk6lWeyEa8d/WvXM0jj9NDQC3Q==
=FNEx
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--
