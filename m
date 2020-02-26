Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE32C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D05F2467F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582716231;
	bh=hPQSI2mhEwSPq3W2NAxngWnT/c3bgReeK3fd/TfuSWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EJIUrmyCdzHTR1L3d5LgzD1PoCd6WqRwpnIGe43mZaDPFOZydNsQIfiSbhlaQoPnY
	 ItVRxQ8NWx7qIw0vErDKXTE5sMv5yK1qm4WyvoW0XPsrdPDyPfmHUlB2MzY8fLwbrz
	 YwDCM4FHg97Gq35TstLcAS3jTIHR4jk6GvC42XuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgBZLXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:23:50 -0500
Received: from foss.arm.com ([217.140.110.172]:34194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgBZLXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:23:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F10E51FB;
        Wed, 26 Feb 2020 03:23:48 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74E273FA00;
        Wed, 26 Feb 2020 03:23:48 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:23:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Agrawal, Akshu" <aagrawal2@amd.com>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ASoC: amd: Add machine driver for Raven based platform
Message-ID: <20200226112347.GB4136@sirena.org.uk>
References: <20200217050515.3847-1-akshu.agrawal@amd.com>
 <d436063d-098b-f49c-c387-abc13bf3b570@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <d436063d-098b-f49c-c387-abc13bf3b570@amd.com>
X-Cookie: May all your PUSHes be POPped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 12:52:08PM +0530, Agrawal, Akshu wrote:
> On 2/17/2020 10:35 AM, Akshu Agrawal wrote:
> > Add machine driver for Raven based platform using
> > RT5682 + MAX9836 + CROS_EC codecs
> >=20
> > Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> > ---
> > This patch is dependent on https://patchwork.kernel.org/patch/11381839/

> We can take this patch for review now as the patch it was dependent is
> merged.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5WVUIACgkQJNaLcl1U
h9Aiwgf+MwWFsDp/SpGestLnyB4u39j7wugEM/Vp/YFOYOJvAaI1oD6AilRN7dnB
VZbn+9+PEuFX8InCL2QjkHk6oYJHdbaDo81x2nmKB3W3vLu/Bf3hDfePKHihW9Iv
Ai+S+SAeGiSteLO7W37lNqIRZ1006XKQbISB+p3irPTqjeUTJYcA2QFtzZh/30zJ
Z9ufz1wEF8311klqfVYFFZqZGk6rSxDJDonJ0xSvlAMxk9j8F7PUtg2x/JpeNaCP
+RpLDHt5q5zLfY5W11ipPPYsjFxjHj+qV7mNV4vGJ/BCVXsSpa5PtC6NUv8DeBOW
ZtY/Crb7H0W0G6iKmFfET8XIn7NmFA==
=h+wH
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
