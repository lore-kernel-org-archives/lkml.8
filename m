Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FC8C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF6820CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587462707;
	bh=IauNheB062Hx5TwDVP9QGchcfHWEIwmMV2csGlvp1Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bChl6SQ6DG2mGDBaFwBV5RoQg2OIMUSq0FvS+zEqoF9/2TcTj5qpq/HR7QF21pdzU
	 crBDTQStpvflKMLzQORfH2WFEzizcoTxBgMvUy6HKqRYH2j0PYf1Ls4xOwtpZ0q0tS
	 XdkU0Q36YBMkWfNAbKd0K8JuJrAJ5b7NxJSOqRjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgDUJvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgDUJvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:51:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0335A2087E;
        Tue, 21 Apr 2020 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587462703;
        bh=IauNheB062Hx5TwDVP9QGchcfHWEIwmMV2csGlvp1Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWYByTCOBPe9TYJ5N5O4IsoELB6F3vHA6O80HIcV8nnnmnt4k2pp52gP+/SHiQ274
         OqB8JJuS9/+69Dpn4TETGnXou7VQGAOpACqRHUnK5+CAXauoiJOul79OPfh5fCEUuC
         4xcWwon+SREvq5R5c8dKOQrmkudpJ9UixOjYUD38=
Date:   Tue, 21 Apr 2020 10:51:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_esai: Remove expensive print in irq handler
Message-ID: <20200421095139.GA4540@sirena.org.uk>
References: <1587458483-2166-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <1587458483-2166-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Non-sequiturs make me eat lampshades.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 04:41:23PM +0800, Shengjiu Wang wrote:
> Use dev_dbg instead of dev_err in irq handler, the dev_err
> is expensive, we don't need the message to be printed everytime,
> which is almost a debug option.

>  	if (esr & ESAI_ESR_RFF_MASK)
> -		dev_warn(&pdev->dev, "isr: Receiving overrun\n");
> +		dev_dbg(&pdev->dev, "isr: Receiving overrun\n");
> =20
>  	if (esr & ESAI_ESR_TFE_MASK)
> -		dev_warn(&pdev->dev, "isr: Transmission underrun\n");
> +		dev_dbg(&pdev->dev, "isr: Transmission underrun\n");

These are error messages which would suggest a problem that'd lead to
data corruption, it seems bad not to try to flag that to the user -
surely we've got bigger problems than performance if this happens?
Perhaps convert to a ratelimited print if the issue is that when errors
happen they happen a lot?

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6ewiMACgkQJNaLcl1U
h9CKwwf/Tpe5//zRDnlqtVpZt3Oxy35CTdjomxN1dhZTt7hBudQjOITkDCoiNst3
SEvHAoPl0m/Y5PyAiZGgZlxFxttzFt7kPUskvTeDXWhmWRWjErukhTFBAbsA/xZM
AlHWU436vHLDv7G769/c+foQJxQQAnfiCmS2BOK/4K18HIMLgz+C6e78zEXkFPsX
rkvU9CKIZYUwgNB/YJ00JHWTy99JeURMB9IhF5vz9u+rKO7fflOjF+o/XMsxHsVw
YHYxXyu35bWT21LslOL2gsB5NWI6MIzRXOirDJKY3wHhzspdL3NkMOg0QFb3pSs0
ZHl2Tbk2fhTu7Aebf9LPYn11mmwaWA==
=YObh
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
