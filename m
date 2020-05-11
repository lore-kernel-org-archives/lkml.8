Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69272C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED7B20722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589218430;
	bh=Mb6RDzi1I5+pxVNi9IB0d0jSTDxGRu/TLIydO2Q4lJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yg11WRobmlBWjpkU42NK/7LcbL8prodMvkkCMYI7mm3VOJo9jzPMdpOJpqhTm0QIQ
	 gpumugvHRf2oRxEIJrzP6gtSvwQHxFVxCqKb1ramZ4bRns9PlXsGesDghgIhI1a0wf
	 eyl3+xZQyaIRdFRpNirtFJL6CCKzxmXMb0szNmm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbgEKRdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730644AbgEKRdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:33:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 161032070B;
        Mon, 11 May 2020 17:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589218428;
        bh=Mb6RDzi1I5+pxVNi9IB0d0jSTDxGRu/TLIydO2Q4lJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/2eOuH5QCYOzoinKHiT/GQWdIeVf38zkWU5xBTf3KDBjnKPfklV1oUWcy30as3qf
         Pviqp0nqZrOuqtrbMPtFUUgucxqbKdgFAeG1qVlVT8dmkjDf3TVCajOZfhwqoSBKca
         9s7mID8UWsAf5Oc4BRkIiIrAu/PLyrYsmUxPWaXY=
Date:   Mon, 11 May 2020 18:33:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yongbo Zhang <giraffesnn123@gmail.com>, lgirdwood@gmail.com
Cc:     linux-renesas-soc@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Chen Li <licheng0822@thundersoft.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: rsnd: add interrupt support for SSI BUSIF buffer
Message-ID: <20200511173346.GK8216@sirena.org.uk>
References: <20200511100415.12502-1-giraffesnn123@gmail.com>
 <158921769452.22432.14661061075576126965.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Content-Disposition: inline
In-Reply-To: <158921769452.22432.14661061075576126965.b4-ty@kernel.org>
X-Cookie: TANSTAAFL
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 06:21:43PM +0100, Mark Brown wrote:
> On Mon, 11 May 2020 18:04:15 +0800, Yongbo Zhang wrote:
> > SSI BUSIF buffer is possible to overflow or underflow, especially in a
> > hypervisor environment. If there is no interrupt support, it will event=
ually
> > lead to errors in pcm data.
> > This patch adds overflow and underflow interrupt support for SSI BUSIF =
buffer.

> Applied to
>=20
>    local tree spi/for-5.7

No, it wasn't - sorry for the noise here.

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl65jHkACgkQJNaLcl1U
h9CwNwf+N4JBwIeoNbEiscFu6yuAq4jAIXqttETDDdGngT++PzvYroU5VF0sbXwp
nzT1SgBu+h9Qe1AymyhkL0Gy5GIsH3ITIyLqx18fZYrFf07pAAQO6VxpECK55XhX
Bz0rIcm0XXRBpwQkv+3XvKM7UXGLim9Cz2JbPNcVwuaWPHhEhSjozzU0x2B9UTmB
YZM3aArzBAlepcS2IO/whPKgCNXxe67o+VK4ykGRW1bCVHvaNJUWfv1uRQgHgOaS
KyUXRpZbXdxScJLDJvKkygQEAhf3FXgz233+U2MKU0fpSTdPzDtbJre0Q+7G1lms
4grrqYsVI1Sniiq9cpf5CZ/UqtIYYg==
=PJ7/
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--
