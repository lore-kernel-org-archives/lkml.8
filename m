Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DC920716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597145841;
	bh=pabIEVAMTF/3OKJcoU8QXk8F1wPRUPXAtuWQ7FyMlY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E8eUbxCLVCB8X1vDUHIuQi+n0IfQBtR3cf4OtAcL5gyp2zEdqDuRN0xCIERUjgXy2
	 hOi/L+y9lalyjJPD/dvj42J3K3A7tlAPnwdn6I65FQDYxrirHffZw/7wzpQTvNaZPC
	 zEdGXsdgJdhE7oklp6d9HzQeIasWO07xiSz9if9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgHKLhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgHKLhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:37:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0784720658;
        Tue, 11 Aug 2020 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597145838;
        bh=pabIEVAMTF/3OKJcoU8QXk8F1wPRUPXAtuWQ7FyMlY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPtG/27mwTyMjiqB6Ix66kBFsmfWoGXluzFcB8mTVpqz5Z8gB59a2rR0yApTfPJvv
         QgkETSj4IHiCIAUrMUDn4DagymABY5ve3lhhIELlNp3dTaz70bKFbpqyJkdz+gY/oM
         svOQ4bj5BNgRg9T2/epEqhIy9shMFwpzi43vafgc=
Date:   Tue, 11 Aug 2020 12:36:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, john.stultz@linaro.org
Subject: Re: [PATCH 1/2] ASoC: q6afe-dai: add dummy register read function
Message-ID: <20200811113650.GE6967@sirena.org.uk>
References: <20200811102552.26975-1-srinivas.kandagatla@linaro.org>
 <20200811110409.GA1481@gerhold.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <20200811110409.GA1481@gerhold.net>
X-Cookie: Gravity is a myth, the Earth sucks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 11, 2020 at 01:04:09PM +0200, Stephan Gerhold wrote:

> Actually q6afe-dai does not seem to make use of the register number.
> The DAPM widgets all look like

>   SND_SOC_DAPM_AIF_IN("HDMI_RX",  NULL,   0,    0,     0,      0),
>                   /* (wname,    stname, wchan, wreg, wshift, winvert)

> Wouldn't it be better to replace wreg = 0 with SND_SOC_NOPM in this case
> so the read/write won't happen at all?

Yes, if they are not used at all then that's what _NOPM is for.

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ygtIACgkQJNaLcl1U
h9C1+Qf/Zi3SBLYwM5XlNdV0qZrjHIdl874SJUA3RStfvXzku/zmsSZvClLF6V0o
9i+L+UmiKOKzpz9H0rBrLfTn/6edzmlnpmAL9RdrREPxEsSCgxvTb2by+6IZ5VNr
caaeQAy+5cJrZi7zieISKvHvgLBRWdvYyMKsYdHFORrWVYoUhDofotCxyPh3kWpJ
xAU9K9pzOp1rZFDW97OBAiutpPUOHF2HebdGXBZywpCoEmLmsZTb3IDl9eUlVV39
5szE2ERrU3B+iCHObbBTqvN7oz9IfzNMSJ51tmrUSjNxBXNStPO6FVJGrTkkb01o
DbxYaWhpMEbjBgsaJcyFKOKTC2V4hg==
=3ufd
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
