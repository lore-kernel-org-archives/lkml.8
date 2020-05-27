Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431CAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC7C207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590578274;
	bh=5z9xtdi52FskRYXJfdwKFMi6uEuh2+knbFiPB1z1Od8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bhiDC4nsrReq+oXK4PCN11ghxUYegZAtAzP+NykeNcAwlhXUwY4mGgDBJCdqHn9N3
	 oziUaI7xpCT8pqfjtLN7n8A0JHtuZo9dFcYJ8cMqhx875yPAtgMP1DfRSJqmzJ/CaA
	 liwEsmdodlLgUga+/7pMoOKK7CAvwgRVfpGq2+GE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbgE0LRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387397AbgE0LRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:17:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C222207CB;
        Wed, 27 May 2020 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590578272;
        bh=5z9xtdi52FskRYXJfdwKFMi6uEuh2+knbFiPB1z1Od8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M477cvlPVQMNDFXWmqezt5D0ambD+4fGVQNXF4WFsTitXDzCulZDkV36wz45rx+0W
         vIowVuc5yg27js77yPSsK8eXAzhKABjEv4meOc7a0r0RzCo9cvSK6BC7xo9gH0u++B
         RyNNgfb+nNvIKGS/9MnbkDciO5E/XAZggjl44JjI=
Date:   Wed, 27 May 2020 12:17:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regulator: Add support for sync_state() callbacks
Message-ID: <20200527111750.GB5308@sirena.org.uk>
References: <20200527074057.246606-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20200527074057.246606-1-saravanak@google.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2020 at 12:40:56AM -0700, Saravana Kannan wrote:

> When a regulator is left on by the bootloader or anything else before
> the kernel starts (let's call this a "boot on" regulator), we need to
> keep it on till all the consumers of the regulator have probed. This is

No, we don't.  As ever we have no idea if there ever will be consumers -
we don't know what drivers the system is going to load, we don't know
what the intentions of the OS and system integration are and we have
zero idea why the system is in the state it's in.

> This commit adds a regulator_sync_state() helper function that takes
> care of all the "boot on" regulator clean up for any regulator driver.
> All one needs to do is add the following line to the driver struct.

None of the issues around this have *anything* to do with individual
drivers, all this is doing is forcing us to go through and add this to
every single driver which doesn't accomplish anything.  Regulator
drivers have no role in this, they don't set policy, so there is no
reason why they should be aware of any of this.

Please go and look at the previous discussions of this topic, this needs
to work for other users as well.

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7OTF0ACgkQJNaLcl1U
h9Av1wf5AWMYXcj3te9Nw7oD+uN5sFblIyhNUmw6KUiEoMvFHDgezM4ClRYeGFpW
JPAKZG9DFS+jcfcDykDF3vdjcJElqlym4VXK9pZXwTc9EPX1aC+Iiio5PVXLRnQ4
FWxWD86/H3KWqnuC+vAhvuXGe4aOY3iAyFmppAPdjoLK9hcisBw7fAGfI47QzVv8
J1fLJ9DBlCIcL9OOAIxjCkLVLDywRqqBg3cGI2NQm/kBBirfHgfTQ5u06UoANxhH
ovE0bHaUZYNIGT/MRjNiNVmzUZRZd6IzZ5z0pI05EXfF5mIgf089SJdYFV5UJ3p/
jVie+AkcjnD6CZGK1wE1sYQwPRYNoA==
=VM8y
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
