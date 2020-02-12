Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFB1C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3595D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581509736;
	bh=G2c//amWs0gGWevx3DizZqfKpbmKbuj5TCTpWPImDsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A94/jBFD9LIHDRJ+gHF35KKixT3Zpk5BxEjNMzQ8+VsGpoY2F4+F2FymXQcTHcX7e
	 kQpg8qbpc1CeA+RYxagyc+fD7A3aZJV1m/q1TWOA2+pT5AARLn9O8aHZflZWb+Rc0k
	 NBhknE/68HQxKXJ02borKCSRhkTbSznuGzvrW5s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBLMPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:15:35 -0500
Received: from foss.arm.com ([217.140.110.172]:60412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLMPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:15:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AE0C30E;
        Wed, 12 Feb 2020 04:15:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF2993F6CF;
        Wed, 12 Feb 2020 04:15:33 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:15:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     alsa-devel@alsa-project.org, cychiang@chromium.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, helen.koike@collabora.com,
        ezequiel@collabora.com, kernel@collabora.com, dafna3@gmail.com,
        devicetree@vger.kernel.org, groeck@chromium.org,
        enric.balletbo@collabora.com, lgirdwood@gmail.com,
        bleung@chromium.org
Subject: Re: [PATCH] dt-bindings: Convert the binding file
 google,cros-ec-codec.txt to yaml format.
Message-ID: <20200212121532.GG4028@sirena.org.uk>
References: <20200127091806.11403-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline
In-Reply-To: <20200127091806.11403-1-dafna.hirschfeld@collabora.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2020 at 10:18:06AM +0100, Dafna Hirschfeld wrote:
> This was tested and verified with:
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5D7GMACgkQJNaLcl1U
h9D4SAf6AjL0TX0sVgucqWJPIx7KXl9BR5SqhCtnhvVTCrO9gBGH1rDgqrceW9mr
rNnvjv/icmNV+WzKIK3YT5VCuA4zI0JfH2qKTSNIkmdwm1bWcKhN8kCHtRidRdUE
zBn1wZFT98tB9kgZy9tE/LWgy4olgLrOlMJLHJwGwLL7dSnmSpOrmmeRD10y6Sz1
9RFMa5kkyP9+dvtw9mbVlQu0gFIN2frqZQvItoEAKhhbplyvAkLhtSc1MPwcZxGS
8nKtAXcFuS0hF4di6QYp0luIzzA+c97yD/ZFWBQ0jlRs2MW97ULQSGwnbxeKczk4
tGO4KAFmg1JSGYaQ7ziiVc9xJau0LQ==
=qBkG
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
