Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14D5C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD062082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585314481;
	bh=4tgPnzm9ftZJBZ/ykZmmOBuwECzQEXcmCGbcxgf01l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gAB7f1Ah94zoj5jf41+ijG2Me1+0mMe9ugnPduHaLeUcmU0dmyx+CHSiRcJFUpsyf
	 5denVUZsOzV1/fxisy4V/3DRKU21p3P0HOf9liN757BJLn1/P/pTijzAh9KfZ/ATXm
	 /deiKGE1XkBAiQVML+GpLnZuPpvtsB5NsWhRkATE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgC0NIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:08:00 -0400
Received: from foss.arm.com ([217.140.110.172]:44442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgC0NIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:08:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA6981FB;
        Fri, 27 Mar 2020 06:07:59 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CBD53F71F;
        Fri, 27 Mar 2020 06:07:59 -0700 (PDT)
Date:   Fri, 27 Mar 2020 13:07:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matt Flax <flatmax@flatmax.org>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        alsa-devel@alsa-project.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Takashi Iwai <tiwai@suse.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: bcm2835-i2s: substream alignment now independent
 in hwparams
Message-ID: <20200327130758.GB4437@sirena.org.uk>
References: <20200324090823.20754-1-flatmax@flatmax.org>
 <d0684926-3f7a-0b97-a298-4088925442a4@flatmax.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <d0684926-3f7a-0b97-a298-4088925442a4@flatmax.org>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2020 at 10:56:50AM +1100, Matt Flax wrote:
>=20
> Should this patch be handled through the ALSA team the R. Pi team or the =
BCM
> team ?

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

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl59+q0ACgkQJNaLcl1U
h9AFaAf8Db5emY6EIgD03k5HjtM3kTn5ueFcW3VvYyJOfS7/qgx6q8JE7eDFaqgr
/61tuP3BmQ08KYkA8TZtvHwOLc+3wjJi/Q/HDpwApmbcfy6LuA34oepLk+wKI5ik
Os9ZiKsPjYKVKZZ9wVxrXHuVNaveCinKAqz7EU69s48kFbX054Ios83q6poKazm/
KFnesj0pCLINvrFrXboSoKmhIzLHV6kxMAgO9qmd9mjJictyenNGoNnmk7fsdiM9
QW/Pjs2YYg58/IOanTmz7OoxAgce3k3/TJRNnS7gRtyktNCcrC85CJkANzHtOst7
cvwcNrA0SRrKj0A5IfwNhv1BSK2+/A==
=NOmu
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
