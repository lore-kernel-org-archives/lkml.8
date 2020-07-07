Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B67C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A996D207CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594123994;
	bh=bgHVi+z3SEszCd7DWPLvG9vOrvhldDXiJezUwjnQ8Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KC+LKXOEHuiOvClcrNE2XWtpQ73NH0tB1vSTcbMOERz8xJO7+q6/WCGxQrU1g3gqj
	 TZm2OS1KkDrKwtZUxdlOU7jLiEzvS/2uQ8F1ioHLY13W1swWhyDR+nC3p50muoX9Ov
	 41tf2qhSb+xrh/zULtFa35Uy9ExmgmKrzqnxpqPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGGMNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgGGMNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:13:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00522206F6;
        Tue,  7 Jul 2020 12:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594123991;
        bh=bgHVi+z3SEszCd7DWPLvG9vOrvhldDXiJezUwjnQ8Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Odszq1f0AQN11s2Vj6EMQHr6D21AgvgNaOAg1M/r2DMqFUpBK4WQvhFJyxMYcwGS/
         JLGI8R12SdmGsIJxtABJXrTy7HVNwQ0xGSdXbA8E3eRf/QtvpPmitnzOH5+BWoPFiv
         RFJnDvAx+g/rT8blMVmZ39138JnWupJTzHEbZ1yI=
Date:   Tue, 7 Jul 2020 13:13:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Harrosh, Boaz" <Boaz.Harrosh@netapp.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200707121306.GI4870@sirena.org.uk>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
 <202007062234.A90F922DF@keescook>
 <DM6PR06MB3836FBAD65096AF63ACD3DB3EE660@DM6PR06MB3836.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <DM6PR06MB3836FBAD65096AF63ACD3DB3EE660@DM6PR06MB3836.namprd06.prod.outlook.com>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2020 at 06:56:53AM +0000, Harrosh, Boaz wrote:
> Kees Cook wrote:

> > I have struggled with this as well. The parts of speech change, and my
> > grammar senses go weird. whitelist = adjective noun. allow-list = verb
> > noun. verbing the adj/noun combo feels okay, but verbing a verb/noun is
> > weird.

> But why. In English many times a verb when it comes before the noun means an adjective, or an adjective like, describing some traits of the noun.

I fear that if you are looking for logic or reason in English grammar
you are on a path to disappointment.  FWIW I share Kees' "that looks
off" instinct with some of the usage of allow/deny.

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8EZtEACgkQJNaLcl1U
h9BtcQf8DnXZch2/ywcuhz7I9Tu5LbyspRZ0gAwO+nQPloYT4CqwHyqsxqUL97ZL
Ff1Zf27D1qNrNlAKDUlsy8FaTlQJrtAQ9eXVQAaMONZRmbRoQYwZikz8kEFpPODp
EZN7rd6LGwCis+cUkBblC3SXMuhnXFsCpm3EsgXwNLLlfSwIC1dEvHZuUvmgJmy7
XEBFg/7o89PeQ+x3EYGcWw4S0tzGYu0fKFBaVQq4TsPO0mtsvoh6MikMyilf4fvT
XW4k4x80jaTCRIh2e69MVVu0M3AK0QQeKn6OKLIn2sRMsoxy+szZiNrUh15ILNgR
+sSfpyq9xREm8vI2uX5OKUSDC7gGvw==
=h6Eg
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
