Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D52C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30A320714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592222929;
	bh=dU1EhMnpItukH4io18hbBJjTZLSLgWizO2yYemyffVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CSB3cOrQFA0yilAwo6B7H0ZQpJXGhLlVNuX+7lxDJq8eDbjzSjAp0H5Qm+0BwGbU2
	 XpCovjZxPmOppAjx0gYn7Ob86nwPsOBpVP2ER5kCjV9dNu4TEolkfEepupf+cERveQ
	 kPA3YNqkUtCb07mte9GG8SybcsDTPURp2/aoPGdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgFOMIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgFOMIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:08:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 394C620679;
        Mon, 15 Jun 2020 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592222926;
        bh=dU1EhMnpItukH4io18hbBJjTZLSLgWizO2yYemyffVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vC9qjqL+NsM2GJ5hW7HNWuJw/I3uA3VmvCFi7PtC9/dbuRkOJrXOsvUELw9P9CogK
         JqbqO3cIi+nxmPX1T5hD/RxHxPSQricyoGREQeTiYfdUSCdhfgj9TNjuFl2Hco/7mT
         euVTTpGz3sN34v4wvY4EodSc5z8N/QEJuL/im7Zg=
Date:   Mon, 15 Jun 2020 13:08:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfram Sang <wsa@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/3] genirq: Do not test disabled IRQs with DEBUG_SHIRQ
Message-ID: <20200615120844.GL4447@sirena.org.uk>
References: <1592208439-17594-1-git-send-email-krzk@kernel.org>
 <1592208439-17594-3-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rVkomL2febZOZtGQ"
Content-Disposition: inline
In-Reply-To: <1592208439-17594-3-git-send-email-krzk@kernel.org>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rVkomL2febZOZtGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 10:07:19AM +0200, Krzysztof Kozlowski wrote:
> Testing events during freeing of disabled shared interrupts
> (CONFIG_DEBUG_SHIRQ) leads to false positives.  The driver disabled
> interrupts on purpose to be sure that they will not fire during device
> removal.

Surely the whole issue with shared IRQs that's being tested for here is
that when the interrupt is shared some other device connected to the
same interrupt line may trigger an interrupt regardless of what's going
on with this device?

--rVkomL2febZOZtGQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nZMsACgkQJNaLcl1U
h9CfnAgAgHtIT8NH7R+6WXILJMorpHWb0ggJOOsJrBr0ox3JSbcmbjKcHgH6VOnf
LgqLy8c8Gi9eG8dHh1pEcd6TobFq0GYuQfQBAtBWFgs1EccGmWHo+6+qdNshETPc
tTWe+pihBd8v1IAcVwz1e5gLDJvDYIUju+KykSgo+76Dh8rNEofRHl4hqURW3GIP
fvNx/UO17tCJLr9JQbvzdk6L+PSYxlu1HmKK7YLmrePgrxbXHmYxJNQRxIY2HAhC
WkKbCkxShVrHWocZUrWbBC/IDulNBYl83uYKhX2QtoZ6iL8DTcGsMkvQSWNMb8UB
9IFqCcP80fnmQnafcV3sZ93RH7zM2g==
=N/CA
-----END PGP SIGNATURE-----

--rVkomL2febZOZtGQ--
