Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69092C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3849921734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341807;
	bh=t3I9fr+Br9deQzx47peiqa6oU/XApLshMp7goz/axgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uYZKXHArmMu0UeXdIK8C6CDEfLFruMTgNKn7KwnpeVyaabHotf6slaDEzLJEUtgLA
	 hyzOQHASFf8FQYc0ZGhYyhdOA9GHfTroiFNRYdEPh0ErYJPeHeMplDegOjKimy/yFd
	 YENqDwJT0lUnaCM3H1jHvN0urSVxrjRrUjvy9+qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbgBJNgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:36:46 -0500
Received: from foss.arm.com ([217.140.110.172]:33856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729618AbgBJNgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:36:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAAE41FB;
        Mon, 10 Feb 2020 05:36:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FC653F68E;
        Mon, 10 Feb 2020 05:36:38 -0800 (PST)
Date:   Mon, 10 Feb 2020 13:36:36 +0000
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
Message-ID: <20200210133636.GJ7685@sirena.org.uk>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-9-adam@serbinski.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRtZRu2mMGBZ6YQ7"
Content-Disposition: inline
In-Reply-To: <20200209154748.3015-9-adam@serbinski.com>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRtZRu2mMGBZ6YQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 09, 2020 at 10:47:48AM -0500, Adam Serbinski wrote:
> This makes it possible for the backend sample rate to be
> set to 8000 or 16000 Hz, depending on the needs of the HFP
> call being set up.

This would seem like an excellent thing to put in the driver for the
baseband or bluetooth.

--wRtZRu2mMGBZ6YQ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BXGQACgkQJNaLcl1U
h9AaBgf/S2n2UV3JEObzW9MyD7j/N5w4SvGvTVxS91cgeKu1rLXmmHjuWYZSkaf3
F5GLSWxp+xnfPHW3I1PioBN+E7uXVrbl4yioIysIumaqNFaSEfLvtmGZwCqY0jsd
n8bC+RS7QHYba/2TIGEBgKM2EsXYq+wzmbkh3Yck0VsV6N1JdXtqppOkL9uaLfU1
QesTdj6bYw+Ul7pRm4/whPeJP+Qot4l/Yc0vM1waMQ4/YCgWzPwH4/+lbO1hoZou
fe6kJPWTXV0sCG71B7xIeGnUnsrI53fPAk0ojiFY4EOvEGdFN7yvgMnjsn8cSsBY
9IE7v0TTt++29YGCUuAYhGAFqAw/2Q==
=LG8v
-----END PGP SIGNATURE-----

--wRtZRu2mMGBZ6YQ7--
