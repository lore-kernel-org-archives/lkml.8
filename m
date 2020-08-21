Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1744C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918A720732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598003879;
	bh=dWI2a7PDA/idr+i5N+8t74lwOiD4O7oGsjPEewaLymI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xr2j7CLRR+6n0GMd7FCtMzRH9FPvtY48EbBnvxa0g/uGEzOgRceNNVysttx/av6pJ
	 oiKIrWFjowV/X6E5DqU9SFIqd4RHrHaWAVKLXCK7e1TRwDXa9q6EQJF2F8iQiPoJLw
	 Os2H6mhuOlHYlmsWLf+1nGxX75rinMS2rSMztZmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgHUJ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgHUJ56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:57:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3B4420732;
        Fri, 21 Aug 2020 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598003877;
        bh=dWI2a7PDA/idr+i5N+8t74lwOiD4O7oGsjPEewaLymI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTbP/CiZ3LtTB+OzxEptC2eHtTbOfsJ2FjyIQsq2/Gvn9i8ZQ7LizcL2YDst7kYsA
         JtpBz6dBPRziVhbXXdzJpTG3lRWuoNFZNARyGTuhaZYN9I2l0GNpxVk5XiQDSh9kBA
         98bvlftlZHiOTVi2iQw03awiCSQq97qHeR167EcI=
Date:   Fri, 21 Aug 2020 10:57:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] regulator: mp886x: implement set_ramp_delay
Message-ID: <20200821095724.GA4870@sirena.org.uk>
References: <20200820171020.5df4683b@xhacker.debian>
 <20200820171051.55a238e8@xhacker.debian>
 <20200820210513.GA41191@sirena.org.uk>
 <20200821101729.76f1951b@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20200821101729.76f1951b@xhacker.debian>
X-Cookie: divorce, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 21, 2020 at 10:17:29AM +0800, Jisheng Zhang wrote:

> I found the reason, the three patches in v2 were applied to for-next tree.
> Should I renew patches based on for-next? Since the "mps,switch-frequency"
> binding isn't released and used, I think I can send new patches to convert
> mps,switch-frequency to mps,switch-frequency-hz.

Yes, please - for-next is best for anything that isn't a bug fix.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8/moMACgkQJNaLcl1U
h9DOLQf+JY4OH5CtLLpCMhjPhpz6MwFD8HLR9eEjxgKO5k5ThcKPyekM/nMPmXkB
pw9TaIAB5WX1su+yUtIgCyDANcpwG/ST2zLsVcZK0EXyP3cxuR4xSy7iky6dBcPk
cIPTZMiGMSAOqZMrq8TxEv+emszCbp2hlzQaV5/YQJjtBlSwAQONcI7yi4WXBkQt
G8d1egfMLBeKKFgy+rI7XyuHQsPTj0LZno/Eouk0U8pVNTtb1G/g/3NTA7bSjkJK
awwGEnzWJm+ltjV/0MkZv91A530UIiMTGGN4A7832fywr5rr+pBez2VnblWwoasT
P80pu+wGRpyIt0yhG/1Yl0ifB5GQtQ==
=dKT8
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
