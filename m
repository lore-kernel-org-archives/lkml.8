Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B9C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1CA21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587029770;
	bh=8AFD3plu+KjEQrKRRIW/WPjAt6mrEDHJMoiYPlXMdsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dP708Iz0GHop6ZTtMCjbFz7nrkGH83DbknRgPhtYZE8bWN/nTd/0dq5CbDTQ47yxV
	 9WJg5aTCTVM3i3I58Okr8OSP8NZs5ACtOyqNR/NCyDCMN2b1knDxSeoV80HLagQEfQ
	 EQhQRIySUK/4H/MNyeyA+hgi/MOkw43gJ53Ys9HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503884AbgDPJgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503499AbgDPJf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:35:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7AD621BE5;
        Thu, 16 Apr 2020 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587029759;
        bh=8AFD3plu+KjEQrKRRIW/WPjAt6mrEDHJMoiYPlXMdsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0IjzBIGZOxVe1GHgJjUAzkRmKA0r5kDh8Nr7oICMwcdzUH7YneNHH72cx7RASZiS
         j3cuL/YvRXpslmP88sumAU/EOcBQ+Ljt5i3GBS1uOisUHO3WwjkEPmqyL8Z8NloauQ
         jMwFF3ysBTPYnXZ6lXlXh7A25hhFFc5TxTaJZ0ZU=
Date:   Thu, 16 Apr 2020 10:35:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takahide Higuchi <takahidehiguchi@gmail.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-cpu: support full duplex operation
Message-ID: <20200416093556.GB5354@sirena.org.uk>
References: <20200306130147.27452-1-srinivas.kandagatla@linaro.org>
 <841cb73b-82d3-9fb9-0ed3-547882872085@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <841cb73b-82d3-9fb9-0ed3-547882872085@linaro.org>
X-Cookie: Tempt me with a spoon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 09:05:55AM +0100, Srinivas Kandagatla wrote:

> Looks like this patch was missed in last cycle, Should I resend this one =
or
> are you okay to apply this. This patch is required to get full duplex on
> msm8916 based platforms.

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

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6YJvsACgkQJNaLcl1U
h9BgUAf+P5xci/XZM3xcqCLxrOBiDlbEAw2QYHpY+orX/gMgPJIya4k0/3KNlPsQ
Vr/987zEpqJApIrM6F3CYgwslsTcnLZzRvTJp/QxO4FR94Jb0guaZ6l031is7wHa
N5rNI9lO7hXE9zoOoHGF8E+7Us0cW4xfZOgpJq19Tos9vVOzn+rFVowK5E5BIcoA
k0oJ1MLNiUOq0lFIkwETNmvab9OVT9VJU+FpIvMqSmTh5CmaKtSx4W+HQGPbeWko
0UmjJlrJBgfMYZGEnLiy98dUjlod1OclUMLbj0TZZdxT3kAaqNP/agjZNUXBfNM5
FXtoMFWLdN+eJCtmhr1ABez71lygpQ==
=BL6m
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
