Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538BCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2316F2075A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596649413;
	bh=E48uURU/e4C3y5TjlfnNrUSBQnpVCadc+z+Vd9h/kdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C5nDb1AnXWz6RKPaDnvpuyIeqzuoKhVe/ySVo/WmX7qDWSkq76F9dclyRBnvO4/sy
	 AjoUGKdzuB6BrAH36aZrV3gFWojwZUPtPF8BqwSn6oPT1j7LVixXHYPRKaYzT5S9gv
	 hIyNyzFe25+mPQMrrdj4Toq99W6snzWDyhrGFTUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgHERnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbgHERkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:40:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1020622CAE;
        Wed,  5 Aug 2020 11:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596625308;
        bh=E48uURU/e4C3y5TjlfnNrUSBQnpVCadc+z+Vd9h/kdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vjiEPe14+OtcSgTUe6IvKe9v7YtFnMHcqLyu1+yzJV2lHJlinrgdZttz+o/8wF2Pn
         kjWCfnTxkN2Yt08lbE1MOKOyiYlxVVYDwGj7fNWqJoh2bRTgpr9ZnCA1QsL5FJRKXD
         2Qe0hIMyvTa1JtLSs+tAhtngoaoynx1LzvqEakcg=
Date:   Wed, 5 Aug 2020 12:01:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     amelie.delaunay@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 12/18] spi: stm32: move spi disable out of irq handler
Message-ID: <20200805110125.GG5556@sirena.org.uk>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
 <1596610933-32599-13-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline
In-Reply-To: <1596610933-32599-13-git-send-email-alain.volmat@st.com>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 09:02:07AM +0200, Alain Volmat wrote:
> From: Antonio Borneo <antonio.borneo@st.com>
>=20
> The spi disable could potentially require some time to finish.
> It has to be executed at the end of a transfer, but there is
> no reason to call it in the irq handler.
>=20
> Simplify the irq handler by moving out the spi disable. The
> synchronization through xfer_completion is used to defer the
> execution of spi disable.

Should this be an unprepare_transfer_hardware() operation?  That would
allow the framework to take care of scheduling this in an appropriate
context with the added advantage of not needing to do it when there's
another message scheduled immediately.

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8qkYUACgkQJNaLcl1U
h9Amcwf/Z9jbsoaJGZe0lTnEB+ZN1x7Xo629kRG1It/WXDUx01vXa/0BIFFomSB8
5z4skhqGXkfncS+6lCZzBW1dJjVMTxJTXztD4zCbb45cYbGA+rjWIn2JPMvHLLxO
swSm5Poy0PDGddU6aVh9PrZgMJXe6z5+hogGuIfxuPIdDi0gudqZ6mxH1N7emcQh
52kzLDjvPtfeYESQYhtaCyD/MDbrAvSPC/946BHXzIcDWpWeHJIsdNUQCghTUHHg
D3dpBhZhYrJfaE8Iv81hlGdlEbzrRDsmdJLi918xEECHBPWEoKItosC0DRKFVo2q
/gSifjQBt0a6jA65RbRP4i8WXRUTNA==
=6vOj
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--
