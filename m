Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01CDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CAE20792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596619422;
	bh=yzbI8DMCZjB2O/BAuietvfHV7T/GKvMZyEQSWDplvUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YHvZskEiv4XpcG1eNe0GlHlUMsAKxlEAXw9yCXl+uoj2ibOswuY/Qb8BlX9GMDfn+
	 yMUsRHnAVIBwdW4nCyw02IqfZ5/IAc0gKz9VsR8MLgGXio3/YMLeUapox+/4zmykU6
	 1y6RexIDYluKdARcwlRvZRNhws8+pcG+xa4jVQRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgHEJXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgHEJWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:22:25 -0400
Received: from localhost (router.4pisysteme.de [80.79.225.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C34420792;
        Wed,  5 Aug 2020 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596619345;
        bh=yzbI8DMCZjB2O/BAuietvfHV7T/GKvMZyEQSWDplvUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwHnmd4SPOVDRbKgPwdL8kOK1JcEay8gZYX8B1vo9QE7W6oamqYQcU9VDfRRH7FoS
         C40teKRK0BJ58G8MX3dk7yxpqa3a9vW+9q05+ZSJgUKkuBBWuo17R+AKwUufULGS35
         ceyTsGzcHr2az2VHjWLYaBSCO6VX8fHpHg8RgP1A=
Date:   Wed, 5 Aug 2020 11:22:23 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for v5.9] i2c: Replace HTTP links with HTTPS ones
Message-ID: <20200805092223.GJ1229@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200719193553.61319-1-grandmaster@al2klimov.de>
 <20200721115029.5669984b@endymion>
 <b7cfd6e3-ee79-b7e2-c7f9-a58e960c3a88@al2klimov.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Content-Disposition: inline
In-Reply-To: <b7cfd6e3-ee79-b7e2-c7f9-a58e960c3a88@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Yes, I've chosen "the easy way" of git commit --amend:
> Editing the patch file.
> I this a problem?

Usually, yes. It can easily create inconsitencies which make me as a
maintainer suspicious.


--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl8qek8ACgkQFA3kzBSg
Kba6fQ//b5DB5EV9/VBgY5pTkH5g9BcBngQVJf1CQdIEY2kuWySeWj2m87j0olxH
BucZ2cUBqZuN2LWgTS78iPx6c5Wus+jgOAqkfIoLw5Q+Rg9ynhoU2VlEyD0vllyl
ApKMcMFIYr+hpzRaLx6AA9kDuWMhviViEJI9rWhUKhTW1PSsNaekXY7MLInOU7u3
RA9urU1pQTBWum8dK8ck13JzEQxMQqxwc0gnXHrmLXsG1ytT/4DN7vIibAT6dRaf
6UySyleMiWkgf9MpRgEg/N4zRQkQAwuRK36HbjN+52BqK2oVuNDC1+jwFUE03uFM
6r8ea0SCiQMRZDwuIOH1kWbIK1R3sHstyHjm60UsV592tHD+8+zMdA+1b9jYgOmr
hsx4PtMsFQK8McfI27bK5P/4SkQW1TJA3TOS+2OjajbjgLPO3EIpKaZmZcIQ5xOl
BePZWaGZ5Ab/xqpVgLs3tBNPDWWReDy7mi3lFSFuTjXnYFbRtJnv6LIMxX/Iq+Us
Ooy8uwZM04d7RTAIL9Cpp2O7gLmtZK5X4vydWMur8lIqkkH/4xf6LNlqGkgim1qj
BJrt37mXtJz4J//LrxITkYCuaDVGeIy2aOpsZupSmpwnYeqhsLloI0o9urrv/Mbi
55NDv5mXI7MPl424ZCVwJh4rJxxQlMHiJ06rkx8HQ2nGbMgOcj0=
=VpnK
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
