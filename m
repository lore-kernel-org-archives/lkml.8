Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3664CC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0754B20842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581421380;
	bh=2VkS/4wvT5SEgArGFq9wfNHLH54BccDXdeJQLd7wKoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z9kH5C+Sl150QjqIbAsToTUPxZXBIgmunnooFzNHJAIcBOpGVgaIa1Q7ozAsWHRZV
	 xYEzd/sJzQHvnTicq29sTzGicNtqwFENvb27sbn/RXruAAnE/0x+0M1hGdAngRzUI4
	 1j6BIKsZrCWXMnS0vSs4Hca/vS+IM9Fi3fq4sFCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgBKLm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:42:59 -0500
Received: from foss.arm.com ([217.140.110.172]:44432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbgBKLm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:42:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F48231B;
        Tue, 11 Feb 2020 03:42:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C78C33F6CF;
        Tue, 11 Feb 2020 03:42:57 -0800 (PST)
Date:   Tue, 11 Feb 2020 11:42:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Serbinski <adam@serbinski.com>
Cc:     Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] ASoC: qcom: apq8096: add kcontrols to set PCM rate
Message-ID: <20200211114256.GC4543@sirena.org.uk>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-9-adam@serbinski.com>
 <20200210133636.GJ7685@sirena.org.uk>
 <18057b47c76d350f8380f277713e0936@serbinski.com>
 <20200210182609.GA14166@sirena.org.uk>
 <f88d21773f47f5a543a17ad07d66f9b7@serbinski.com>
 <20200210200839.GG14166@sirena.org.uk>
 <7c57801d8f671c40d4c6094e5ce89681@serbinski.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <7c57801d8f671c40d4c6094e5ce89681@serbinski.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2020 at 04:13:52PM -0500, Adam Serbinski wrote:

> I am not aware of how this could be done for bluetooth, since the value
> still has to originate from userspace. The driver you referred to supports
> only a single sample rate, whereas for bluetooth, 2 sample rates are
> required, and nothing in the kernel is aware of the appropriate rate, at
> least in the case of the qca6174a I'm working with right now, or for that
> matter, TI Wilink 8, which I've also worked with.

There's generic support in the CODEC<->CODEC link code for setting the
DAI configuration from userspace.

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Ckz8ACgkQJNaLcl1U
h9ALGQf/Ss3ZIdJmQ7t1NLJpgkPvfgCHptgk+NO5wYCwd0pQJbzaflRdG45mcDPG
bQRKfEaZEqvPWxASdTQTiFdmJg6zLqlvkQYPcor4DCPcB1bCkPS9hkeOSUxXSsOa
ICLmJPQyoUqNyb6pHa6ghgfdVRPIr+GWPn0Zob/QpwybzWKBA7VHKmTEnxGDIq0z
pLzYVaV03fmVkJUowVTUdZ40LP8mjTWVcXnk/NzM1qEs3T39Q6DmAUyR7IemHBBf
wJr/MPk4Nr/9nPsmtD+5eJIG6m68tUximFPFeYIfid+WrHlY68RVcpgOBUG4LuvT
ENG+UsqfuA8Olmmq+tnZG3Imx6tmzg==
=pysG
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
