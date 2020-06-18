Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C922C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E5A020706
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592494543;
	bh=hNrNhHrVllUbYtlOSfEaSAAeVtZGRqKbFWGjWZNCuCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WAhkdbwCbRvnT6QJquwPHJSFq9yBTd4V0q565veuahguPqtiEGQUZnc0pxqiebIKD
	 /ON8wXHsbz8IRXnUU68OKv7LL0bQyW7wa7x10Nj7MqJ+CSgoBVHs2FKFucLU8JxmIq
	 sgaYUEF/E2EMsZU4NBOKiga6kSILx8K44Uq1l+tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgFRPfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgFRPfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:35:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A287206FA;
        Thu, 18 Jun 2020 15:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592494541;
        bh=hNrNhHrVllUbYtlOSfEaSAAeVtZGRqKbFWGjWZNCuCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7fJ1wAnPHU/BBBZ1eI5v+5P8Kv7EeGDBMM8O6fDeUv/KesUWIga3yVv1AgvJbipg
         6c9ND0xZGv+YsCyR4jOM+CnDNJHiPKoXzAtnGKSfO0ZAvkTyNE9oNsUf48UZHqgK3g
         f8btPBO7vp/SV6FmfvxX0jxInWaDWJo2jgxTVqrs=
Date:   Thu, 18 Jun 2020 16:35:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH v2 0/6] add regmap & indirect access support
Message-ID: <20200618153539.GM5789@sirena.org.uk>
References: <1592493910-30473-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cqq5NadOW2RfLMJ/"
Content-Disposition: inline
In-Reply-To: <1592493910-30473-1-git-send-email-yilun.xu@intel.com>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cqq5NadOW2RfLMJ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 11:25:07PM +0800, Xu Yilun wrote:
> Updated the regmap & indirect access support for spi-altera.
>=20
> Patch #1, #2, #3 is already applied.

The numbering for patches within a series is there *only* to say what
order things need to go in in that posting, they don't have any
relevance from one posting to another.  Sending a series with some
numbers missing causes a lot of confusion since it's not clear which
patches even exist.

--Cqq5NadOW2RfLMJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7ricoACgkQJNaLcl1U
h9Diywf/RTvwSVdOas0TCcdZcXfOSBu/sfh3eL9Ky92zGtJuWtuYBgop+71pxaWE
fmrpS9mHf//BKwhF3nq3XZ9FQNO59YUCWhFKSUsbroE4D7/k1ey2ie5yZMxvcW2+
q6baV+sWOyvVCXJkwETbi+Q8jZBiSrn0tprK8vhSY8rtncoI9b5hJuR3CxunsW56
8RtIxtmQvqS95sJutqLhxZIxXnlCMDw3iDdfNgTkIFRTcmcK01UeBZJLNKtUNkyk
qzQPWvLFwEDS+JfFUlggRQexPAdRklNTznSsEMbN+KZNTrurY1wQzDgzo2zOMlQk
3/gIhI2cvAPiTrHEvu+BLvTSdPLl5g==
=/lFw
-----END PGP SIGNATURE-----

--Cqq5NadOW2RfLMJ/--
