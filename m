Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BFDC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902C820663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584023847;
	bh=MmOOMjqsvLam7G/akGVSSkqB1DkUt/z82nMZQLu7stw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l1NMqx9OmU+ZOKi8V2nk8loaLpRL4lq0pXD7cmoU2pQZz2xYOCLUybtlxkQwLhOts
	 /5hHbHn3pJF/whE0hNL3QBGKu1VT22Pxc7pAE29dFH7udQurY/YuXhz/YloscmuyTc
	 39bVUhA71W9vYCOATUfgYuCeV13BNemtUNv/Bigo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCLOh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:37:26 -0400
Received: from foss.arm.com ([217.140.110.172]:36008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgCLOh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:37:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9B3D30E;
        Thu, 12 Mar 2020 07:37:25 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E8553F534;
        Thu, 12 Mar 2020 07:37:25 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:37:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Message-ID: <20200312143723.GF4038@sirena.org.uk>
References: <20200312103804.24174-1-peter.chen@nxp.com>
 <20200312114712.GA4038@sirena.org.uk>
 <20200312130037.GG14625@b29397-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <20200312130037.GG14625@b29397-desktop>
X-Cookie: Security check:  =?ISO-8859-1?Q?=20=07=07=07INTRUDER?= ALERT!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2020 at 01:00:33PM +0000, Peter Chen wrote:
> On 20-03-12 11:47:12, Mark Brown wrote:

> > Which pins exactly is this controlling?  I would not expect a fixed
> > voltage regulator to have pinctrl support, this feels like it's papering
> > over some other issue.

> Sorry, I forget sending dts patch. We use fixed gpio regulator to control
> USB VBus.

Surely it's the GPIO controller that needs pinctrl support then?

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5qSSIACgkQJNaLcl1U
h9CbXwf5ARB0Y8aFHjOrTN1l2RTW1H0LLNID3S3ytrszCstjm9doLeGbGO66rVw8
TbK4AvkNzjOKMj96PddwIBcR+Qg74nNeWm/3+oetgAkhhcATT/jbdFfoYgDNQ7ej
m9nVTIID6L50xYqv4uIxKamyn1+q3k/NiR/zN2oZUxKwbNm/vg8CmK613BLskMUK
P2B56gDMPFNCzKewrRyQaEc4NaMFBXoE6ZPYPWwvz0vDSJiOcZm7yKazPKxVpobt
AOU67LR16JYRfi1amY2geV4ZsY5d8fgu0+iN5hrNXxG2KGe9Klq7ANfVKZ5zgQfn
V8xxJUmd+Iv1EspBy2cEMCZ5ffF1DQ==
=ekt7
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--
