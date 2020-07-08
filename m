Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE8AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE94F20772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594212535;
	bh=/jnnyU8D3NLl5TYYZJ9HC6L8tLLdlL2Sz5qSIo0i1wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fpo2DATO+qgmRGKgFkv/DgNRa4m5DkIxTdcRJ0rztLHDQty3SzpX6DvaMdqOlJ2DT
	 l7FeH1S7kICOFPqQ6AjTVXGgGR2NXUNziNlfFonZPYC4+blg8WJcayAYZfsJLZXyCZ
	 ZwrPh/Knsp/eYvGSRk/BZ7/hLlsFhcS3XUe04V3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgGHMsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgGHMsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:48:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9510420772;
        Wed,  8 Jul 2020 12:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594212532;
        bh=/jnnyU8D3NLl5TYYZJ9HC6L8tLLdlL2Sz5qSIo0i1wI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0kJX2Mxi9pa6bOW9BEMHE++CLn8jVHa0EQJKS7F95aqJt2KF3W/OBcXJYUd+xcug
         3N7QvDq3cyVMkhyoHo7AiP5xZEiNdBCBmeMKYObdEuL4WIcQRu3Ww7B6RqyPkzh3cY
         dOZNeBcQUKPH/poJxEa0uxSfbmL4yB1mNrMFNkkc=
Date:   Wed, 8 Jul 2020 13:48:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        akashast@codeaurora.org, linux-arm-msm@vger.kernel.org,
        mkshah@codeaurora.org, swboyd@chromium.org,
        georgi.djakov@linaro.org, ctheegal@codeaurora.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Avoid clock setting if not needed
Message-ID: <20200708124846.GM4655@sirena.org.uk>
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q6mBvMCt6oafMx9a"
Content-Disposition: inline
In-Reply-To: <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q6mBvMCt6oafMx9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2020 at 05:45:07PM -0700, Douglas Anderson wrote:
> Every SPI transfer could have a different clock rate.  The
> spi-geni-qcom controller code to deal with this was never very well
> optimized and has always had a lot of code plus some calls into the

Acked-by: Mark Brown <broonie@kernel.org>

--q6mBvMCt6oafMx9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8FwK4ACgkQJNaLcl1U
h9BO7gf/RR+sLx+pPedSbsBRu3N+bW3kG80otDHhQGSD/U38fHBDO9ipsxNg/x0J
Ct2BS7PyYbYMxoMFvL30MFbQuWAeQUCX9P+T/BxdNTXubGBMDYXoxRQ5j8XaESqy
kffWGAP2pq8u8BtotwOOws5/C/596QgOqkhPGsceRwknd+zt4S7dhZLQ6zBz3Fzr
+9L03QszBQHW+9YeevsGSuvr5nsnT6MQ/pX8ROZOLsWClA5A7qptIbnTLWDPVxIU
bNLEQkq0M2R58mQ/EbZASxe4Zg6bkoXqDTIVUYS14Xr8VI+yjQXOMfjJadNcdppt
2bDWh7pI+N5fCKGJGjadM+Sp+5LV3Q==
=Efai
-----END PGP SIGNATURE-----

--q6mBvMCt6oafMx9a--
