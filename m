Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073BAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD22B20758
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597861402;
	bh=OwGoJNs0Ttl+Vu54pF8Ud5u5yVWd5WGKYMwDSRyuwTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U0tzcsCAk65lgM5EstWEiRUcULnlngelSC/+oc9F1dpqFw9KkooyHyL7BEDzD7kCB
	 1b5oymdIL8w8n/Lflr6HDgS8YRqCH42O5x2JYlt+UdrsWN7AkY0vwDumcC4XNHIn/8
	 81UlYaIpak8/xnL5hgBgbiypSED+hXCEnajn6UI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHSSXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHSSXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:23:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F95F20758;
        Wed, 19 Aug 2020 18:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597861397;
        bh=OwGoJNs0Ttl+Vu54pF8Ud5u5yVWd5WGKYMwDSRyuwTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wrfIdnAXHGlNYHqh2Mi5K5gD2GKzsLOxlqCgyVHYlblCLjdAn13+HE4CT0pYSLPZE
         /zc9qEl+GdLHveh5rW6KYUX/IOhxrH+UxdhJZYhcELYHIS+x5JDujMPidSZh0yCtoW
         6of3mL2pEIaat/HNp3aljTR+hSQtWYIAreXJXh1A=
Date:   Wed, 19 Aug 2020 19:22:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: add of_match_full_name boolean flag
Message-ID: <20200819182245.GE5441@sirena.org.uk>
References: <20200819140448.51373-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
In-Reply-To: <20200819140448.51373-1-cristian.marussi@arm.com>
X-Cookie: I wish you were a Scotch on the rocks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2020 at 03:04:48PM +0100, Cristian Marussi wrote:

> Property 'regulator-compatible' is now deprecated (even if still widely
> used in the code base), and the node-name fallback works fine only as long

I'm seeing a very small number of DTs using it, the majority of which
are pretty old - the arm64 ones are just mistakes on the part of
reviewers.

> as the nodes are named in an unique way; if it makes sense to use a common
> name and identifying them using an index through a 'reg' property the
> standard advices to use a naming in the form <common-name>@<unit>.

> In this case the above matching mechanism based on the simple (common) name
> will fail and the only viable alternative would be to properly define the
> deprecrated 'regulator-compatible' property equal to the full name
> <common-name>@<unit>.

This seems like a massive jump.  You appear to be saying that the reg
property is unusable which doesn't seem right to me?

> In order to address this case without using such deprecated property,
> define a new boolean flag .of_match_full_name in struct regulator_desc to
> force the core to match against the node full-name instead.

I can't tell from this description what this change is intended to do,
and I suspect it'd be difficult for anyone trying to figure out if they
should use this or not.  What is a full name and what should people put
in there?  What would one look like for example?  I have to look at the
code to see that this is changing to compare against the full_name field
in the node and there's no kerneldoc for struct device_node.

I'm also wondering why we can't just add this to the list of fallbacks
rather than requiring some custom per driver thing?

> -			name = child->name;
> +			name = !desc->of_match_full_name ?
> +				child->name : child->full_name;

Please write normal conditional statements for the benefits of people
who have to read this code, the extra ! in there isn't adding anything
here either.

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl89bfQACgkQJNaLcl1U
h9AuFgf9Hj7Oa33NEHJ3sPvuG8dP1aQ/1zqafnOMv54X3YZOtl2D34g0B3qPU8TX
pbvvRhVRiH7nPzp/bz24inYXVKITjDVkEpy2n2+szyj8TeqgSEkLKxAmCsbkwkYT
MmlgYN0HnyUhV83R96tZEzIJjmWrcmn0hZ8dxXBsSTJ2wtMIsrz44xkPW6YSDzG+
jbmbWPAuCHD7sXVLnogIsTpE/h9ZjoCAkaFZHpTeUVy69zEIaqSPNb8TQPxWpu3a
uv6c+ybD4StLq7+x4N1+qoya2u+DuJ9wMJSJTQah2OPGJgvIno1uOy77G8D0m54y
PFiOoPl9rEKlgzxtIJqrOMcIlTgbrQ==
=yaji
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
