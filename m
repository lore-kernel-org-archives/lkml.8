Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7B4C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7588D20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587745150;
	bh=XC6Ikptp/j90rDzmT0AdDVcCY/PmJVvlWpB8FsmM8ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X33ZUQQ2MtiXErzkTxzdHco3vwPY+8m5wzMnUeQCexTOZ4iNhz5YnJhfSPRQTr3op
	 VMfieR5MA5V49RKG/eS2pzzxBIwbAjOyFVnqmf+1lbQte2LoCRxBoAS135PbfhyjxJ
	 rjQzsFyj5i1EXR3KM5u8Z7Oq2gYu08A/efvcbpiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgDXQTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgDXQTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:19:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5D8320700;
        Fri, 24 Apr 2020 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587745149;
        bh=XC6Ikptp/j90rDzmT0AdDVcCY/PmJVvlWpB8FsmM8ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OszDirxaqR4GL4LFB7lBkGGZ7x18CoArfCPqa5pPT1h1D+S0EH8pTIs1SmIBkyMU7
         eRUk7TMIlaxNwJrt7LXIrBY1GMUPpahnAGDldaHWHf/wH8hmRAkzBn6wkEuGGJsHnE
         IfvnWXAZuJ4FShQjM3wBJfWe65QWAq2H7lroGTPs=
Date:   Fri, 24 Apr 2020 17:19:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix erroneous 'additionalProperties'
Message-ID: <20200424161906.GH5850@sirena.org.uk>
References: <20200424161708.2906-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aF3LVLvitz/VQU3c"
Content-Disposition: inline
In-Reply-To: <20200424161708.2906-1-robh@kernel.org>
X-Cookie: Information is the inverse of entropy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aF3LVLvitz/VQU3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2020 at 11:17:07AM -0500, Rob Herring wrote:
> There's several cases of json-schema 'additionalProperties' at the wrong
> indentation level which has the effect of making them DT properties. This
> is harmless, but let's fix them so a meta-schema check for this can be
> added.

Acked-by: Mark Brown <broonie@kernel.org>

--aF3LVLvitz/VQU3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6jEXkACgkQJNaLcl1U
h9C1pgf+LT9c6g8ooZoHyIWS50LZc8nTH+4gz7Leye3PVox1vVdw9oox8JjxqBYi
X/b+xIeiwEUwMb91Z1Mb50fgIlwgqJBb71DPwS3jzpkproGGgdyqJq3dixepSRDW
iAuxK6gV/L99g2oFH9wwqbAyV+Yyk00pNNvMFC6+BjCcRFJqaU/mBVQgwLguxarp
9L8Ui2aYkaBNanPQWusM2Tlxo/hv09LqqQEJEwLyx25/IeIHRaPzwXMUg/VV8L+K
YPaFOXRdhuOaQ5AzHqm2uYFDK6CIGqZTx2chKjUTx28jxio8v7scyRi5ViEbln2j
GqCJa7ttpbOh1kQHWQoDaWUqZ7InUA==
=Rz/c
-----END PGP SIGNATURE-----

--aF3LVLvitz/VQU3c--
