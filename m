Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1A8C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7652D2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585057488;
	bh=eS0o/kRjog1FzGHzsXv70k3r6k3VzZc77nna9n1P+I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rH06F1MNxjdLt9CnLQN8g9W0dZ9VmiJdvwNhzkyqymIEAQmS7VL4UCz/dPGJFCfrA
	 CGQ9woUW1JUIpC0MvIUXXCWDr/uHu7xeps3O414Jh8NlqCSP6I60XOdktSfVmjZfiI
	 Tz/xCAC748BuCva/jBM04382G7vhidnLXRd5AWZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgCXNoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:44:46 -0400
Received: from foss.arm.com ([217.140.110.172]:35388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgCXNom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:44:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 547291FB;
        Tue, 24 Mar 2020 06:44:42 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD68E3F52E;
        Tue, 24 Mar 2020 06:44:41 -0700 (PDT)
Date:   Tue, 24 Mar 2020 13:44:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Johan Jonker <jbx6244@gmail.com>, lgirdwood@gmail.com,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: convert rockchip spdif
 bindings to yaml
Message-ID: <20200324134440.GD7039@sirena.org.uk>
References: <20200324123155.11858-1-jbx6244@gmail.com>
 <20200324133506.GC7039@sirena.org.uk>
 <2135168.SEOWuCda4h@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <2135168.SEOWuCda4h@diego>
X-Cookie: I feel ... JUGULAR ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2020 at 02:39:56PM +0100, Heiko St=FCbner wrote:
> Am Dienstag, 24. M=E4rz 2020, 14:35:06 CET schrieb Mark Brown:

> > This is the second v2 you've sent of this today

> hmm at least when looking at my inbox ... I got one series for
> spdif in v2 (this one) and one for i2s in v2. And yes they do look
> somewhat identical in what they do but of course handle binding
> changes for different controllers.

Ah, this is one reason why I complain about subject lines - the
extra dt-bindings at the front hides the difference in subject lines for
me.

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl56DscACgkQJNaLcl1U
h9AX1gf/aMYAaXz2aq59CMWwQKWFUEAhfQ7OLuhs5LSFsPlUBZXUMot13HRqsiKz
uwZgsBhO7MErfMs6l85z52J7uQ56RYXkIdfdm0m0PUVVyZsUxDHMKmV6xnS3NpHm
f1COnrZDwRLRrP4qWCipkWJFRTF/9PynetTfYX456+g6aeBI7mNlO+OdY+EWis3v
lMI5+/zO0RCkIgKb3qYp4gknlqYz+1HtIgu8RBy3JaDQk1BGNP85KFxRmGPyOe2U
8H+Tu1uO9iIGgP7XAMJFsusQTC2QmPfhGH2GG9S/R2k+gZEjELOhcGtlfOl9+S+E
gpQaRpbPjoAKtCy9IPoiy6watAt2ZA==
=WwdV
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
