Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EAFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2287922482
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595333984;
	bh=tYiFt9K0KgLaJqfcIjAbyvfdUGbdTgTCD4rZc3DjcYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UDDGNgrTP7qaKorY3QQGmSNvoRajGjZjmzZMK8nhn+ZV/i2Knl7rRYY7ssL4okSlU
	 4R/LfT7G8ojL3ytp1K9wcmP/x4yr58fE3mdmuwPS6jTbEMTp/x39Cw71awnfJ4LH80
	 CSPwJiWcXldAxymW8JXW1lN+ydOG9x5w0hnzuwZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgGUMTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgGUMTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:19:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4270921702;
        Tue, 21 Jul 2020 12:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595333981;
        bh=tYiFt9K0KgLaJqfcIjAbyvfdUGbdTgTCD4rZc3DjcYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0gBks7Fved2h4ynjBOKZV1EWo/pc3D5lNhYOqvqEF1cdh67WnU3bXnN5ZCzEsyuBL
         U/0Q0BFevG1Y211wv1SiNjrSbtpaEv7ZQAuHM8sxXEII5xkLdZYJQNf4+DZfBA/GKK
         beed3Mjc3l7zNlDp/h6AeG8lcAbxhFXop8+DcKUU=
Date:   Tue, 21 Jul 2020 13:19:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3 4/4] regulator: core: Add voltage support for
 sync_state() callbacks
Message-ID: <20200721121928.GC4845@sirena.org.uk>
References: <20200716042053.1927676-1-saravanak@google.com>
 <20200716042053.1927676-5-saravanak@google.com>
 <20200720143533.GG4601@sirena.org.uk>
 <CAGETcx89xBoLiqe2392_vFuoMytKMxbeM5n0vdL9dJvAF25+Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <CAGETcx89xBoLiqe2392_vFuoMytKMxbeM5n0vdL9dJvAF25+Qg@mail.gmail.com>
X-Cookie: I'm also against BODY-SURFING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 20, 2020 at 08:24:59PM -0700, Saravana Kannan wrote:

> Btw, going a tangent, why is regulator_set_voltage() not dependent on
> a consumer's regulator enable request? If they don't care if the
> regulator goes off, do they really care if the voltage goes lower?
> What's the reason behind not tying voltage request with the enable
> request?

The most important thing is being able to control the conditions at
power on and power off, the period while the power is off is not so
important.

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8W3U8ACgkQJNaLcl1U
h9CAhQf/ftgm8KcIBAgxoW/cPvbNxLl6Nz+pM5nmTnjmmY47Ll9Dj1e3pTDg9tst
C0B/DBN2tFM/u0ltuKWG15BF2TSU3axy05nTUDLvEvnEZkW0TuWtlyU4cizAabcV
mMTWaBazJDTRctAAVfRE8yLb0f4quQoOty8Dds5c9QR8Qp5Vr/0UtonJunN/s0JY
gkbisQzTcrwxsmpM1NVSLHGjsmRxD3Nbrw+Pq9muqD8Vu4zxwX0ERqdWTuaYRW/S
4HlGb+2AWPGyGHfwaoubV2PxDEkcihErWgToX7WPqCAF7IErBVKb9SYwN9pb8JRL
/AD4UaLcKWcHdjl1MGMMjjY4dUckEg==
=6YfP
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
