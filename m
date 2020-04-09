Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355B3C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C4C20769
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586453398;
	bh=gwCMVgI55oBxZeA/ZAEGuRvjk4DQBHRco/poNeClq98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OtA2bMTYEiTZ2DnNTN1oix96TfUeUwmyxJdmxNetdtsk63BMOVuUDFYCHYtqSLCSy
	 hK49sYxoC48xrWScvlShWGz8pzPfdjvW83xAnWc+SfPNssTblOKnjtGHPdbPuUgVrG
	 50Q4ggqhpUEpVuxegJpbb57PRHcjgt7u4AYI2SK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDIR34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgDIR3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:29:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22FD20753;
        Thu,  9 Apr 2020 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586453395;
        bh=gwCMVgI55oBxZeA/ZAEGuRvjk4DQBHRco/poNeClq98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkdOASzNiq2YKxftkzZx9j78sH3gxPhCTlGpCnRqbkDC13mBU2Wnc5AOSeCbBXjVE
         7IOD/AJ4lvMVE8hNnDGwhMQP7kTdPfD24CW8SDOik2z8gjk/LHklzeYFuIVod9MGyx
         g6J/6HB0KqtvYhAPRiiSsLoG9WpNJRliUCZE0hXI=
Date:   Thu, 9 Apr 2020 18:29:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Stephen Warren <swarren@wwwdotorg.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Support headset on Tegra boards that use WM8903
Message-ID: <20200409172952.GG5399@sirena.org.uk>
References: <20200330204011.18465-1-digetx@gmail.com>
 <5c9c995a-a571-e543-e680-30739cb1561c@gmail.com>
 <848cc6c5-e8e4-2796-3ee1-3e12a3e92c54@wwwdotorg.org>
 <a7159a8e-4987-0c08-ce3a-fa82d926218e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OFj+1YLvsEfSXdCH"
Content-Disposition: inline
In-Reply-To: <a7159a8e-4987-0c08-ce3a-fa82d926218e@gmail.com>
X-Cookie: HUGH BEAUMONT died in 1982!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2020 at 08:13:54PM +0300, Dmitry Osipenko wrote:

> The code change doesn't affect any of the old users, so it should be
> safe anyways.

> I understand that you don't feel comfortable to give an ACK if you're
> unsure, but I assume that Jon is in the same position, and thus, I'm not
> sure how to move forward.

> Mark, could you please help with reviewing this series?

It is currently the merge window.  Nothing other than bug fixes is going
to get applied until the merge window is over, probably Sunday or Monday.

--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6PW5AACgkQJNaLcl1U
h9Aipwf+N3qaJUOkv/KorzxIyIDYSsyZPSVUq0X/6TbEkyjM6GDU3cnm2Q1KI4PI
hVwyBmoXuz87lGD9Xr46fpZ6J/Z0KX/wih9fsA/IEfas15FlfHG5Ps0wUPdgCFJV
3k39OnaYCVcvr+9mTfqNDmZiaOUu/6S6NS3c6NQ19ZeIXDCJORE7Mu2jhw8QJFSe
YRIYQUC3ftEKoKvJKca7dQdgwlmCt3QDml3vn3E6k3WqL2zeRciJ9lq+do/re+OR
zUCxHfY8vcJwDhPPOx8SCAf98O3XbgRddqQNXVZ2hVW/gWX+RnD3so6MK6jfyeUW
olmfljKWY4JZP+Uf/9LHZn5VEdGyyg==
=U7om
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--
