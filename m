Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1803BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D413920678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579698713;
	bh=mZc0NGPAXZJkVTI/bbC5WVbWXROtKNEPpGlUFTsNwFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GLxd1HRUSDBKgaerj8UPfuGsFJkqKzCQcB1sqY22QiE8EisBbuLRGgBRs1b07qj+u
	 hGaP5MNaRvSTuIdbUi4A/YzY+gO6vYHzzdXpvAzRWuPnThLugPinNSmPmH2s9IsbQg
	 JsORsE+RguVwKSLFoqu8b4HzsvJM2nVyQYd6Xvtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAVNLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:11:53 -0500
Received: from foss.arm.com ([217.140.110.172]:56150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgAVNLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:11:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02BF5328;
        Wed, 22 Jan 2020 05:11:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 753053F52E;
        Wed, 22 Jan 2020 05:11:51 -0800 (PST)
Date:   Wed, 22 Jan 2020 13:11:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND 1/2] regulator: arizona-ldo1: Improve handling of
 regulator unbinding
Message-ID: <20200122131149.GE3833@sirena.org.uk>
References: <20200122110842.10702-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <20200122110842.10702-1-ckeepax@opensource.cirrus.com>
X-Cookie: Sorry.  Nice try.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2020 at 11:08:41AM +0000, Charles Keepax wrote:

> The current unbinding process for Madera has some issues. The trouble
> is runtime PM is disabled as the first step of the process, but

Why not just leave runtime PM active until all the subdevices are gone?
This is a really bad hack and it's going to be fragile.

> +static int madera_ldo1_remove(struct platform_device *pdev)
> +{
> +	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
> +
> +	if (madera->internal_dcvdd) {
> +		regulator_disable(madera->dcvdd);
> +		regulator_put(madera->dcvdd);
> +	}

This is going to break bisection since it will result in double
disables, it'd be fine to do the MFD change first since that'd just
leak a reference to enable on a regulator which is about to be discarded
entirely anyway but this reordering (and whatever other changes you've
done since v1) means you add a double free.

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4oShUACgkQJNaLcl1U
h9CRBQf+Ijrft01UkH7p9btVXS1AKfXkd5ggu68R37BbucUWTIqSN6lVCWzodHCJ
g7SWU1KfNIypcFQKb6AN03jTYgeJJeT0JdTgalYcw9wFcIRqWkiiqJGPAIp0k+K3
aGTM+KVt69FqwZxsfMqEQllViB0pMu9OU8kPWmv9dzYnnVzbEzY1qawwjqclW4Fy
X/GHdpG46obSpswt6y+AQYm1rYAY64OxWTV5SvFW6ocTQzNgj8QWo6dwE5YA8a/B
DRk6PDVCp2bZTlvB0QsMLNs65xEW7U1o+hImyDVmFxyzbr3Yx2Et+WLZs3cAdwjb
J6bEwkJK24RNMxXPBtfJW0P7fio/Sg==
=K55M
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
