Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B14EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D56F207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590757762;
	bh=WVNaQgrBuW8xSyrTk5uLxPHCK2TRYribBU0LjW0spnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DpgXHqRXm7LYim4+cyNdjxy4LeZ05d7o+Oq2yMg5NIAKW2DzwqsmcfS3221K59Hqp
	 1MBvhF+3d/vJhL2eX+ok9Q6pm4rArX/etajb8pfz6/IA+xNVWSCYqYGgy6hkeuMsjy
	 g9Za5WUaN+fb9cfK40TjV2a2t0tOrLTa0wUlAPno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgE2NJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgE2NJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:09:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1C60206B6;
        Fri, 29 May 2020 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590757760;
        bh=WVNaQgrBuW8xSyrTk5uLxPHCK2TRYribBU0LjW0spnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMPW1sYJhgVDgcKmnynvA9sVxosTyYE/98PyLzdGhIB0i0/pSAth5FqDaJFyNhCP6
         J9I6oJQxBfKHJOUD0AnNLXnjkX/AjZ1Y2Rznl+d6voTTZ5R1m/bQ5BpWN/+ODVJh18
         p6Fv426iel/u3fjn40e05c5dI1lM3vJVOOKDKgG4=
Date:   Fri, 29 May 2020 14:09:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 0/2] regulator_sync_state() support
Message-ID: <20200529130917.GM4610@sirena.org.uk>
References: <20200528190610.179984-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
Content-Disposition: inline
In-Reply-To: <20200528190610.179984-1-saravanak@google.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Aaj1jBvBEV7KRjLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2020 at 12:06:08PM -0700, Saravana Kannan wrote:

> The simplified explanation of the problem is, for regulators left on by
> the bootloader, we want to keep them on until all the consumers are
> probed. This is because we need to protect consumer-A from turning off a
> shared regulator used by consumer-B. Once consumer-B (and all the other
> consumers come up), they can do it themselves and the regulator
> framework no longer needs to keep the regulator on.

> So, this is not just about module or device probe ordering between
> suppliers and consumers. Even if we get the probe order prefectly right,
> it still won't solve this problem.

This logic seems to be circular - can you be concrete please?

> We can eventually extend this to also cover voltage and other
> properties, but in this patch series I want to get this right for
> "enabled/disabled" first.

I'm quite worried about the extension to voltage changes.

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RCXwACgkQJNaLcl1U
h9DTVAf/cyo3Pdnub/fGisKcVmt+/TfgiIBfnUq0evlcTwZ4viGLuJMGaxIhNZlt
1Kl/iUbWkCqY9UWCbQhWBm4Xhvf/iJzxrdDJa7Hs9rRhG7f5ghwGtXjY1nXAZXV5
G/b+tJw8EV+RoA1ZuSKlp39uTB3OThbdXS/KxL8FLvACoW1J+UIhOEuf2gflbAz5
67evFohcnVvsqafBfOWnw2BLzABLVmGPL6CoWd4SFHe/Vri0sFEQdpKO/jQnFzdr
fG2nfcmkgVv/WxqHLOWcYgwy7u0+flOR4ZuCPBwhT+DYCK0aPI2pNA9/44HZK6t4
v7bmdXgD+VNixIln4y2AWuS78t+nsQ==
=ISsk
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--
