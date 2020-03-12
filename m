Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEB0C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCFA2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584013635;
	bh=frQiG3n+9QNzN/3cQwhvWbSpwfgoh9eohMbICSQxpqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c5m06waIHF7Ahrzt4myLVm9c7AhmPIS0BoLHnZs2iXSL+tuEGjJVnW6Sq/Pbtbp8Y
	 5HgMw7smvFDtNzRmK36qFeal4bfYEebtY4jQS4ons3emPTEJBvlEOv7wZya+a97Eq6
	 vv2QVq1BCZnVeQoWpfj0o1pqk7mozZU4bac8kIms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCLLrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:47:14 -0400
Received: from foss.arm.com ([217.140.110.172]:32768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgCLLrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:47:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 093EB31B;
        Thu, 12 Mar 2020 04:47:14 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DD743F67D;
        Thu, 12 Mar 2020 04:47:13 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:47:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Message-ID: <20200312114712.GA4038@sirena.org.uk>
References: <20200312103804.24174-1-peter.chen@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20200312103804.24174-1-peter.chen@nxp.com>
X-Cookie: Security check:  =?ISO-8859-1?Q?=20=07=07=07INTRUDER?= ALERT!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2020 at 06:38:04PM +0800, Peter Chen wrote:
> At some systems, the pinctrl setting will be lost and needs to
> set as "sleep" state to save power consumption after system
> enters suspend. So, we need to configure pinctrl as "sleep" state
> when system enters suspend, and set it as "default" state after
> system resume. In this way, the pinctrl value can be recovered
> as "default" state after resuming.

Which pins exactly is this controlling?  I would not expect a fixed
voltage regulator to have pinctrl support, this feels like it's papering
over some other issue.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5qIToACgkQJNaLcl1U
h9BcLAf9FUIFL9LRfO6s041/3TgyubaeNqbTj9t/WjdTxJHdccmnH20PnQzzBfGs
HC2kn+IBW1FEQ0W+2+n0eM7JUbHx/Ykd004lPmKTltysmS3NA28T8VwHM34uATaI
FP8mN6L1RocPm/o+gWKALo65Bw1tzWvFmTFwBhNM3m1V17PqZyITlJGsm5glqcTl
ujnc9IHLhb+bu64lAknvESsBzjb+PqkgP/wHQZKD3SmqSuiExjK7zG/LhUukNdr8
YqLsopwoKVKsZiricWFz7RLUicGHHTxppPJiTXzQgF8UrlMNiMK5YEqbqEfR6qNy
pqUX/CPX4d8kikr+bLJEqYr4dQeTGQ==
=EglE
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
