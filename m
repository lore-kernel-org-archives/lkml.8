Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56822C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1872B217A0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594737931;
	bh=2HMwBWKfuibfivhw2EEUQyPibobh2jV2edHTtMRWpi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gJXPSgmf5NTkIx5FLowDNnuib7ApRL559irZJmMzm+9dcBYmZs3VscDPBxNodQmuT
	 xuu/8HSmBFh6uCN44SAN+OrXZ2FlhN41Q5dCreHK1tW0dhlo448FHSd6JTI++rDJnb
	 8kSvu4GmxX1gEQSZL0yKrsnLYLJVcm39i1+ZbVWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgGNOp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbgGNOp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:45:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C3C42082F;
        Tue, 14 Jul 2020 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737926;
        bh=2HMwBWKfuibfivhw2EEUQyPibobh2jV2edHTtMRWpi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5V+WwDPUEuUkdqEsN9NzyYu3TWmKLZnUCKxVKQquFPPzDfiFie7GzFbvI5NAFpGh
         r7yckDYP6Yfaben+GiUh78V7tlFtgFp0+GSpMpaRxHjDg/ZU2wqGBb9pQS9BO+dIvH
         jdOV2K9VTQOF+e8DvfTJTY2nVMElE2TnX8l7V5KM=
Date:   Tue, 14 Jul 2020 15:45:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     xingxing qiao <mnlife@foxmail.com>
Cc:     lgirdwood <lgirdwood@gmail.com>, perex <perex@perex.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] When snd_soc_card_jack_new is not called or the call
 fails, calling this function causes a null pointer access
Message-ID: <20200714144517.GF4900@sirena.org.uk>
References: <tencent_AA2F5D7A5EDC40E7E806D0CA5877CE8AB308@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bGR76rFJjkSxVeRa"
Content-Disposition: inline
In-Reply-To: <tencent_AA2F5D7A5EDC40E7E806D0CA5877CE8AB308@qq.com>
X-Cookie: Your password is pitifully obvious.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bGR76rFJjkSxVeRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2020 at 10:30:36PM +0800, xingxing qiao wrote:

> &nbsp;unsigned int sync = 0;
> &nbsp;int enable;
> &nbsp;
> -if (!jack)

This is actually worse than your previous posting - it's got HTML all
through it :(  git send-email is typically the easiest way to send
things.

Also please note my comment about needing a subject line in a similar
style to those in existing commits you can see in git.

--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8NxPwACgkQJNaLcl1U
h9AM4Qf/daXJ1X3aWCVvpubYHVhttn9yFHKfs4sRxrKLLl40i4ysYQWZB5P7doEk
1sohzwXmgJxxDz4j8MIoKtTClsCG2uH5aGj060gGwkhN1++b5lW4jpF+mKUWvwim
wraN7JLZUr8yW8nHlVxscbXimUXHlb1apb3/KjvS3fL5EgPLpZ3cLRCQepJEorno
EW/9+hJrKewpM1oCT9E0Fwsurv6BakMAEdsa7+557T20xOv+OFpFObZjz0E8fmtx
hv7VM838yUwuPrwdA/WUj96Sa+pHVbIyX/mKqIPOj7ppLNHwiKdMS0v5BookoPfc
u8i9TV4N4MuBuVrk7R70fqvPTmvBnw==
=pZ+i
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--
