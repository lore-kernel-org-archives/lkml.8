Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B5DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC18C207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593513521;
	bh=sWaT5wPlCVsv4sYdI+rs+JPWv5UbHcVTbh4ff8ENRtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vu13ZatV2cncM6hWW5OsKtm1avaIxlTAk+Rfa7a9OJ3jl6JEgK7ffiCSqEPstaqz4
	 pBaEuAnZUTT/Jg1DmgiHpmQ32mOuIFv+DwhdkxM4NZGjLOAYYeNHr4DTFT3qVKikvx
	 9Mg9HSxqOxFZ4Q6i97hf7QjwcLTufKT+rvWuz1wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbgF3Kij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732238AbgF3Kih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:38:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FEF220780;
        Tue, 30 Jun 2020 10:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593513517;
        bh=sWaT5wPlCVsv4sYdI+rs+JPWv5UbHcVTbh4ff8ENRtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gTRvgLn3AmW/Hwb+XzbdricsNdY/flLuaw+gfiwC6UhXH13Q7P1JRpfjplQ25rXmc
         CwwL7n5ZTqY4ZKww2QsjGQNBQ0z8gYSFV4N1rzpS3HvuXK3vIJFIO+gJ3Z/NbSlDA3
         F+lVpx+BmEA8d83inTWYYUNdfkW75NvcFh+ftm1Y=
Date:   Tue, 30 Jun 2020 11:38:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anand K Mistry <amistry@google.com>
Cc:     linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        hsin-hsiung.wang@mediatek.com, Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: mt6397: Implement of_map_mode regulator_desc
 function
Message-ID: <20200630103834.GC5272@sirena.org.uk>
References: <20200630111047.1.I05d781ac794389337a4adc2f6402f673117e2937@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <20200630111047.1.I05d781ac794389337a4adc2f6402f673117e2937@changeid>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2020 at 11:10:51AM +1000, Anand K Mistry wrote:
> Without a of_map_mode implementation, the regulator-allowed-modes
> devicetree field is skipped, and attempting to change the regulator mode
> results in an error:
> [    1.439165] vpca15: mode operation not allowed

The modes aren't documented in the binding document, any new device tree
property needs to be added to the binding document.

> +static unsigned int mt6397_map_mode(unsigned int mode)
> +{
> +	return mode == MT6397_BUCK_MODE_AUTO ?
> +		REGULATOR_MODE_NORMAL : REGULATOR_MODE_FAST;
> +}
> +

Please write normal conditional statements to improve legibility, the
ternery operator has uses but they're pretty specialist.

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl77FikACgkQJNaLcl1U
h9Ax/wf+IVPdecbkSUG4tbn+t4jejFDFIdL/5bQ6kkAjjxdv0pUGsaqzGjzb39hF
lJRPbQqM9XhCfRalxlLtmF+YHlxQ8LwzhfrpKi9eL+5PXRW+fUWS3EluvZ6/UPWh
bqne9EAunUUadAoM0Ra7rmSpDIQ7il/jm/ThdO/9EDIisUZGX8S3vUKSjlX9cafa
Gz5A5k3pdQtQGhFh0QkzxVLXO5CNi6rzWxkBvfmRsSYeoUmgwrbjEdnLC51aPkbN
IjgjTjohlzrU0V5zsC9OUOAneWZFqw5VJnCVC1Liczn/aYywJrcdTMoKzKMLsFJn
IKQneeidUfec36uzhtIqKaBbS6EVrw==
=kQiW
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
