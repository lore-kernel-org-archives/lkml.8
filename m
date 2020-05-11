Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A0DC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4029206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589194166;
	bh=15islGkeDrYc/THLIgzaeQ3iuhszhWj2T2ccvUjSv+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FZSZbWIfRSuBlSqK4V86RAEVeWnVzqKfO+nVkouC8kHzqbxDAnTiT9Kq4VESrIMr8
	 noMB/M4NITZGKDVra5z7EA5I/mscvzPjEeLrLCo0xjGNDXO5SDZ1QSGPZZHYX4iQdp
	 s4Uy1022HhKOGk1JgbwAys6JxthuV0aByXn8oRs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgEKKt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgEKKtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:49:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A621F206D5;
        Mon, 11 May 2020 10:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589194165;
        bh=15islGkeDrYc/THLIgzaeQ3iuhszhWj2T2ccvUjSv+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zf0CyIb35SsbLV8ORJUAwSCDMQY+UUxtoEUkcW8pZXArWQWhPNKat6tarU4oD/il1
         KqX/CtZ66hNsE3k8Xi6oZRL4J2Zw2gBm3vf/CfdsmOxs0pCkpuSlSDHztYqOmZbZ/K
         3c1g0EHonSsBJxXDY6m7m5MkbnnX9Fl6mC93Tbfc=
Date:   Mon, 11 May 2020 11:49:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, nishakumari@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        rnayak@codeaurora.org
Subject: Re: [v2 4/4] regulator: qcom: labibb: Add SC interrupt handling
Message-ID: <20200511104922.GD8216@sirena.org.uk>
References: <20200508204200.13481-1-sumit.semwal@linaro.org>
 <20200508204200.13481-5-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <20200508204200.13481-5-sumit.semwal@linaro.org>
X-Cookie: TANSTAAFL
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 09, 2020 at 02:12:00AM +0530, Sumit Semwal wrote:

> +static irqreturn_t labibb_sc_err_handler(int irq, void *_reg)
> +{
> +	int ret, count;
> +	u16 reg;
> +	u8 sc_err_mask;
> +	unsigned int val;
> +	struct labibb_regulator *labibb_reg = (struct labibb_regulator *)_reg;
> +	bool in_sc_err, reg_en, scp_done = false;
> +
> +	if (irq == labibb_reg->sc_irq)
> +		reg = labibb_reg->base + REG_LABIBB_STATUS1;
> +	else
> +		return IRQ_HANDLED;

Why would we be registering the interrupt handler when it's not valid?

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl65LbEACgkQJNaLcl1U
h9A8Wgf+NWKmlAAltMsGck9iS25HVb+wWUuXPnOZWCe13+DjXCuc7QDmqpRwjzLy
aYXbTXmU+6GCZHfZbazTY7bZzsq8NG8DhZ2Gzwuoh2PcUuKwBvFNuhX8rwAB5W4a
d73uCvaIxfFjxbB0Xgkjw1QF89ijTK8N+uemNHs7wtLW8LxoPKO/37ajwTLWYqNf
aDg44Y1e7PkhfGoGB2IiIZq/srn6TOYJmcK3FojllvVQEBi/Xsu2K40HSK+r2L8S
xlHe++6Hf7byPabmH7VBLAU+YvhtxRBSfW6TrMFnCFNlczK+sIJhKJhmA4EJ+3Zc
ixVK6i/oJptEZkUH0OVtgFd/UQe6ig==
=FTe5
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
