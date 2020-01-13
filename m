Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8C7C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B712A20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578931019;
	bh=Wb+5o0VAibT8RIGzJcLvqwU+sBA02juzlGWUCSTLqEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P+81oNRKsSWRnMRW7mg/QN3y+JDFzar7NZ3WK2hAbBTxySzNW7Pgh/MBZEzRFzI8w
	 YMzcal6KSnzXWG1Wf8QsA5cLZXlTWlrtcHqb3o5rMzLNmS+fLd5lD38P0sMz8hIYsh
	 MddwcYfGncY9wA9La5V7zo63KNc6Mg7RVbk2UXAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMP46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:56:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgAMP46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wb+5o0VAibT8RIGzJcLvqwU+sBA02juzlGWUCSTLqEk=; b=AecbiTv04mJIZKXSQTGNfQ1wG
        GuOrdGMzE6woBYBWJ6S+YTOJVE0iCp1xQuXd7j+BDr9bpyRsZU/fKmCklilJIsDvy7Ng9rG3sHGjm
        LDe5pLgjZd65z6Bq7Bha8xqTlADz+n814i5xmzVhiqeMaM11BRdyDz2Kqyf/yHD8nuiOY=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ir258-0003cm-DU; Mon, 13 Jan 2020 15:56:46 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 22AFED01965; Mon, 13 Jan 2020 15:56:46 +0000 (GMT)
Date:   Mon, 13 Jan 2020 15:56:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] ASoC: atmel: fix build error with
 CONFIG_SND_ATMEL_SOC_DMA=m
Message-ID: <20200113155646.GP3897@sirena.org.uk>
References: <20200113133242.144550-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nljfjKcp9HDtPSOP"
Content-Disposition: inline
In-Reply-To: <20200113133242.144550-1-chenzhou10@huawei.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nljfjKcp9HDtPSOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 09:32:42PM +0800, Chen Zhou wrote:
> If CONFIG_SND_ATMEL_SOC_DMA=3Dm, build error:
>=20
> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
> (.text+0x7cd): undefined reference to `atmel_pcm_dma_platform_register'

You should make sure to CC maintainers on patches, that includes
driver-specific maintainers (as is the case for this one), it's
fine in this case so no need to resend but please bear this in
mind in future.

--nljfjKcp9HDtPSOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4ckz0ACgkQJNaLcl1U
h9CJtgf7BRzwod5SoQJG/xXoshI5hh4nT+fvaNUhu6bfC3ny27AJn/pOH/xia1CN
MeJz/qJeD0lo8SI4CnuCb6eQrL2ltUBgNYgObWEQTOPT26QurhTPu2K2SmE2UY8O
UTtflc0wceIznxaUVn0s8Q0AIqhaJk1lwLlMh4oeAqYLAkPqNDEqwwUl/CUGoS7x
Q7XrpipGkiEOkwrsQY2GorzH6ZKr75VBrHLmFQfyM9hJqbtLvZLyCpbpD0J27BVb
Q9ZDU2Bkvq1/H6rCTXCe9HzAfj1YmlIzbg4SQinh736GzCr+Nk5Mu2oH6DAhNm8C
tigu/F9oeo+KwEiSQ3Ax0/hAnRk6zA==
=g/j3
-----END PGP SIGNATURE-----

--nljfjKcp9HDtPSOP--
