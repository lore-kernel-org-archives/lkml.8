Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADD4C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61DA2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587129001;
	bh=RRba6wPPTqjpsH0OjxHPYeFUfwOwgaWHcsijRhGcngs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YRAVemk1gjl9wpnT5U3uEfmEBHDEyJKzgMwLlymBA8pf6kUkKr1QbVMuVo524Uw+B
	 u4OAz9ACrblOq8lGnDPZpVSlvDMSnbB5QkVXf+sRQxloGdoU7ciIMj3qqub8Skb0hT
	 qR5nXIrpPue1qYmEwytwcH+RLFiskFhqQkJOo1mY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgDQNKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbgDQNKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:10:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40A3020776;
        Fri, 17 Apr 2020 13:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587128999;
        bh=RRba6wPPTqjpsH0OjxHPYeFUfwOwgaWHcsijRhGcngs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0SipEdYFywJX8vX1lGhp4UcOy7NWWetGIN1vCVYDam++YLGA0abuUUon8lmda9tE8
         pmwT0/tPOS8nmSRIoSSJL9Qa0Xvo5ShRJXNQY7eC6Ac/DFbHczHRMxPhYg/T0WnHoj
         m6TRHRM6MHCymSV9M+iLN2kLWmmwOyzDJs6/BUgU=
Date:   Fri, 17 Apr 2020 14:09:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH 0/2] ASoC: qdsp6: fix default FE dais and routings.
Message-ID: <20200417130957.GE5315@sirena.org.uk>
References: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
 <20200417112455.GA7558@gerhold.net>
 <03d0d14c-d52c-460b-0232-184156f62eb7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline
In-Reply-To: <03d0d14c-d52c-460b-0232-184156f62eb7@linaro.org>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2020 at 02:02:08PM +0100, Srinivas Kandagatla wrote:
> On 17/04/2020 12:24, Stephan Gerhold wrote:

> > but IMO the FE DAIs are a negligible overhead compared to the routing
> > matrix and the many BE DAIs that are really never going to be used
> > (because nothing is physically connected to the ports).

> Two things, one unnecessary mixers, second thing is we need to know how many
> FE dais are in the system, which should be derived from the number of dai
> child nodes. These can potentially be SoC specific or firmware specific.

You shouldn't be worrying about unused mixers, ideally we'd be walking
the DAPM graph and masking things - this isn't something that should be
open coded at individual driver levels.

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6ZqqQACgkQJNaLcl1U
h9Dx2wf+JNU4DCIuulhKdv9CWhaYh0GdbA2kVhxyPC/Nh8Dr+PCJgEhQJbG9Pb3l
7z5u2/jJJndtNN0b0eL/mDe3NHHDlVk+yMxHpMQtQo0jKOx6T1H5sqbf1VKzUxsx
eVZbUx83uWue5jFIw/NaXReWU7Kj7nxTflD3ZsPtjNaziBKdLngMEw9LR3codEdv
pGi7O37Hq/x8M9RxaAyHMl24A004IQEJIHrovNYXh+0jkfM+F1Qa8dw+8396taVl
W9TusTxBN67tzIz0SEm/ygj2HXNDUIp4zW6MMPA9Udu0y7VntNWTs1qZ2Qs5M94/
QQUxJjIdhB5BllEj4JfxRxn3aZudAw==
=vbwg
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
