Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89702C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD02206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593184483;
	bh=Psqi5bn5py0i717gp542/UjcXi/G0DX9P/wZT7/CeTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p9mJ6L8n619a07nJ1DDzv+dvnUrvREuhSkMXIABl99KmoRQfq9KY7TCUbxhysoTKV
	 A2Yh/Nk25icswzy72Rx/oUuTNwmTgLytnoShnVmrwZVbbKDzLFv9+BkZ36TKOLX2bJ
	 cKz6DlERvj3fcbzeQ+d2l8bhfOkyByXU8ic0kBV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgFZPOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgFZPOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:14:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A9E7206E9;
        Fri, 26 Jun 2020 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593184479;
        bh=Psqi5bn5py0i717gp542/UjcXi/G0DX9P/wZT7/CeTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HmKq07AHob5FgujoKkEFqJ26nnVVLgk59i0LhA/13OY4oB7CEWkw96ZVE3Lu4Uwym
         H7c5M5BryM0/CapxXClqDStphQCxgGNnhHQiiLFTrvH8q1SqbUNXGtwdEJX0cN/4vp
         i2odYHrER2bDbz1yPk3u2pV2cIJ8ZylurPUQYWuU=
Date:   Fri, 26 Jun 2020 16:14:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regulator: devres: Standardise on function
 documentation headers
Message-ID: <20200626151436.GA1269@sirena.org.uk>
References: <20200625205053.4191910-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20200625205053.4191910-1-lee.jones@linaro.org>
X-Cookie: So you're back... about time...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2020 at 09:50:53PM +0100, Lee Jones wrote:
> Line up descriptions, start description with a lower-case character and
> omit old definitions such as quoting the old argument "consumer".

This doesn't apply against current code, please check and resend.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl72ENwACgkQJNaLcl1U
h9BKuwf/f/ZQxEsaFBawvyakmXTNrp/E/HhCR4Umd/dv8tG46eu4S2IqEY2hpluj
FlwNHP0QHNGa8HdxfbsKNB/HlTk7klifjTlhKjBMYDwr8PI5f0FBsxYJgjr7Wv77
vdhj8FEt0x+oWYqCz72A5mmfy12EMNGUMLkVt9vtD88nOAf4X0iaOaLacjqPM8sl
ENvCgXEd+dawKNSXlDXPAxoqPk7aXN9dX+YVgJ6WfmdsalSxZaYscfjdwm8PTqUn
yOY+ld+AebtKOcpOtWFKohzuk70TwJrRgQ67uVz9EE3wb9ZNXUc35IcyNj/Ix+Y/
qC/RAG+LFoGpzhHR39A65h6+aBYpVw==
=vKiB
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
