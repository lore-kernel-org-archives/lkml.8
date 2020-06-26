Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC7EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A900E20781
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593178512;
	bh=G36wtne1Zo8Ja31PffK9s9OOn/gCW2OVDTm9y6YEtYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kHAhAfFAJu+X0LU2Vzq2WIvswTImw2zpQCVegDNIngdwvqwchIk5tcAFLubBf0s2Z
	 n3fzUkbKVNliMA7WbEblLXGSIdzYkutERgs0HKfXDfDqqok/fGiGR8ZKOkC0sNVgyK
	 YZUPDQIKt3bqvHPaYj4vEACv8w+9CWssvtK7woZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgFZNfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgFZNfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:35:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2300820781;
        Fri, 26 Jun 2020 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593178509;
        bh=G36wtne1Zo8Ja31PffK9s9OOn/gCW2OVDTm9y6YEtYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wjxVzEoE45yK1k8NC2iytdd+uoQ5lsU86UJHIgsidR1wXWjABU6upcqhBu4etOcnl
         i7YssOthU8enkkNRezkHiOGLcXegQ4pdwP9ZcvD/pJ1dsbwRzUmPg2gQbzt08bcPoD
         voZzwkVtTXu2sMuHY3qxzJOxyEB54rEW45LG47kg=
Date:   Fri, 26 Jun 2020 14:35:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND 00/10] Fix a bunch of W=1 warnings in Regulator
Message-ID: <20200626133507.GC5289@sirena.org.uk>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
 <20200625194813.GI5686@sirena.org.uk>
 <20200626093623.GZ954398@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20200626093623.GZ954398@dell>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 26, 2020 at 10:36:23AM +0100, Lee Jones wrote:
> On Thu, 25 Jun 2020, Mark Brown wrote:
> > On Thu, Jun 25, 2020 at 08:16:58PM +0100, Lee Jones wrote:

> > > Resent to include patch contributors/maintainers/MLs.

> > Is this an actual resend or did you fix the issues I raised?

> They're fixed.

OK, then it's not a resend - please don't tag things as resends if
there's changes, it just causes confusion.

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl71+YoACgkQJNaLcl1U
h9DS0wf9GraCMAmqy2Q/D9W429Tw8QvhU3YBdO2VdV7uOKQi7G22HDeYp8yfQi4S
ixagWxzu8wc/r/fb13hDzN1Lwi732PEKF6dqqsv/2kFPocAGEoCjLXnL84NVPUNq
yQfGv6RRbfiY0KqU9cv3oDEioXAKVZO9U0kVjWHhfJkyHJzAGSDECvopA8bMZZAL
X5kiY7XyQAThBVnDkDsPys+UcS6JCMBmB0oyGxFE15+k8G1AhAwjzpvF9iJAdDlU
aLvEapvJBX4q+cEK42Hqo5kiS45c1Am9PAk7kJhehpPRJ3zZbpmbvOuqmTRd6Wfz
8bDQz5qt1pRGS+hGSRaK/sb7Z3YWLQ==
=6ZO7
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
