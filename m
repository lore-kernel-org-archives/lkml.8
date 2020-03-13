Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3327C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECF6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584126026;
	bh=3qCWzqWyuOHNhRzyEpiloypzkxroKjixOqkCJfXv3ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=okNd/bgQuBxSLBaY/FMQmeeL69U/NzSKx+MelffhhBF4WjoNpW5O0RSUX5Qzn6Qut
	 alBWA+Xdd4gcK92kUVd4Jgn9pjjHUubQXl9dnjH9hn8J4/7nhO2iiRFlq1SSCbzYUK
	 b/zrGbgECd/zhSq9s40QxYf2DEAAF7U2a9cxncKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCMTAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:00:25 -0400
Received: from foss.arm.com ([217.140.110.172]:34950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgCMTAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:00:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BED6E31B;
        Fri, 13 Mar 2020 12:00:24 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 427EB3F534;
        Fri, 13 Mar 2020 12:00:24 -0700 (PDT)
Date:   Fri, 13 Mar 2020 19:00:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] regulator: mp886x: add MP8867 support
Message-ID: <20200313190022.GA55551@sirena.org.uk>
References: <20200313224739.17b5ed70@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20200313224739.17b5ed70@xhacker>
X-Cookie: All celebrity voices impersonated.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 10:47:39PM +0800, Jisheng Zhang wrote:
> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>=20
> MP8867 is an I2C-controlled adjustable voltage regulator made by
> Monolithic Power Systems. The difference between MP8867 and MP8869
> are:

This doesn't apply against current code, please check and resend.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5r2EYACgkQJNaLcl1U
h9DnNQf/eKEzZuxb4Ue3z4VQzMjboPv6c1BAIsCW7SkFUWQUgZlowly7DLJEh+hW
7kCM3p+DOnYESLgpwX90Crz4Pc8XjxWMo06Uwy4/zsuirJyJ/geLNKMiL7O/GIsz
1vY3JWaVCZBlgOm2quR7+/LPcIpw9joaS6ID/mlB97gaezVBanW/vcHIezpvMEFu
5RVYttFf9j74UESE+a9566siJlt3gMCqpzqvEU3hAgzHxSTdZImGenTRT7NRHIhx
IaxOjVTsJt/0IKhRKCKewo1CTuAiDdv5h7mH8ngfsdx76mFAW3xKzpQrhgYQ9Z30
qxNbHvrHQRpf9WtpgBMTw9jPtrgElw==
=gKdg
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
