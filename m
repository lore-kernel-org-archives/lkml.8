Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F361C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306AB2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588598456;
	bh=TmTThPPzqPGpxwdSnGjDCaspiEw5yMD7Er/gNQKbhp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ak9jlhGO1o++ulH+lydpj7EmHCanYxgTzs+R/8NXX7qJ6NeoUbtd6D+naDtChObnz
	 ydBL+8Box2XX3x7r9vDZe0S4ntqTfxgURb3g0DljsOIJP5Zt5Bo4e7126j7KeAll1R
	 xnb0YTT9UHC8VlodLKDXgu/HDBSsfIjYTZo+trLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgEDNUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgEDNUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:20:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8F62073B;
        Mon,  4 May 2020 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588598454;
        bh=TmTThPPzqPGpxwdSnGjDCaspiEw5yMD7Er/gNQKbhp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXJJaX2Vl0YL18pOKUF/1VGP2I3cbrVG1ibTCHHfOpha8wJ2sSBP2awNOEPaJvX/a
         wVU5G/vDymXuIlJXDylvcakC9l59ISiMvHTaC9cPnEqAWRYbM5HZHHI+Yxe3UiV6el
         /Hc7p/Xd6+JT7sefJghKkObs2GrBARPiYcbsCFGM=
Date:   Mon, 4 May 2020 14:20:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org, perex@perex.cz,
        alsa-devel@alsa-project.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: Remove the unnecessary cast
Message-ID: <20200504132052.GA20675@sirena.org.uk>
References: <20200504073558.2340-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20200504073558.2340-1-tangbin@cmss.chinamobile.com>
X-Cookie: YOU PICKED KARL MALDEN'S NOSE!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2020 at 03:35:58PM +0800, Tang Bin wrote:
> It's not necessary to specify 'void const __force *' casting
> for 'drvdata->lpaif'.

This doesn't apply against current code, please check and resend.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6wFrMACgkQJNaLcl1U
h9CERwf/XWEzr0Iyb/54nGEKIkr/672FzoBds5lVOpbHkmXe6MUiIble9RCFzH1y
bwy40nhuE7TJajc4Fc0jI+a5ZP6SgeVPXVdjhU3Wk33sBDLYD4XJtTzRXjiNsB0g
YoOy6jHJ6+ruWZZ83fRj3t2peQ9KTJWDJxL4h7FxeC7jXFCECipkG8FOUTtZ8xIU
YKz1q4C0Notu2IlqnwktxTY7TnRuaUxnrGIq8AsO4hWD8VTEAySGdFkKI5Wa8Qbc
+qfwlo8jCARWb+DRm3Mnxn3yZwvmivfe72PoI7uBZiY0DihpiJGoN3KI7MSrwMHa
0rK9gsO6USmtGAS/z9FY3p85R1mC0A==
=4D65
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
