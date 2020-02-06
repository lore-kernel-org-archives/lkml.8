Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9804AC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1CA21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580997248;
	bh=GCzxJGLDhyzAc2+59nJJJlFFQZG+KekwiRcn/IX7tEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=12CHPnDwXbuVdplxcaW8K7VouWLnmM57hqUCyVE95COARv3dG6Hb+1caAE4OAWQxr
	 Vupd+YNL9//JVfBU/Gr8mmNthsXEtWCZ697+xKwWC3MlqJKNo98z5lfl1hLNVCi6GT
	 NlqMk+FeQiPJV7sNItrE/3I1O8oyHw4WdXdkIueI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBFNyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:54:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42910 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFNyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GCzxJGLDhyzAc2+59nJJJlFFQZG+KekwiRcn/IX7tEw=; b=OQWErEdDb/s7SaXS1CW0VBVGO
        zsh/6D9z+LcFFmHYN/TIyNXdiSVzPvzGz+DXiucYa9JFU5a8V1Zkk+deq/vRR4sMtgYiGw/r4IHnX
        2qg+E3luQg91bzTitvqbqjY1NeeTiz3KlQyKLAbRRBwiEFVETeqx3WX56J6iPCTo2IApw=;
Received: from fw-tnat-cam2.arm.com ([217.140.106.50] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1izhbY-0002Fm-Dn; Thu, 06 Feb 2020 13:54:04 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id E3403D01D7F; Thu,  6 Feb 2020 13:54:03 +0000 (GMT)
Date:   Thu, 6 Feb 2020 13:54:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-spi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH resend 1/2] spi: add driver for ar934x spi controller
Message-ID: <20200206135403.GP3897@sirena.org.uk>
References: <20200206084443.209719-1-gch981213@gmail.com>
 <20200206084443.209719-2-gch981213@gmail.com>
 <20200206113158.GK3897@sirena.org.uk>
 <CAJsYDVKnOv+4NT8V+9fFy_0KE7QSoeTL0jHTdq31Z=88vBzHgQ@mail.gmail.com>
 <CAJsYDV+C+-uqurM+yTS3XXXrEDe+G3XFrpYEAaZLvzECLNoF+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T6OnZCvW5HcnivXR"
Content-Disposition: inline
In-Reply-To: <CAJsYDV+C+-uqurM+yTS3XXXrEDe+G3XFrpYEAaZLvzECLNoF+A@mail.gmail.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T6OnZCvW5HcnivXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2020 at 08:33:33PM +0800, Chuanhong Guo wrote:
> On Thu, Feb 6, 2020 at 8:30 PM Chuanhong Guo <gch981213@gmail.com> wrote:

> > Chipselect is also handled during transfer. Controller asserts
> > corresponding chipselect in SHIFT_CTRL register, and if SHIFT_TERM bit
> > is set, controller will deassert chipselect after current transfer is
> > done. I need to know whether this is the last transfer and set
> > SHIFT_TERM accordingly.

> Oh, I remembered that I saw transfer_one function name somewhere and
> thought maybe I could shorten the function name a bit. I'll correct
> this back to ar934x_spi_transfer_one_message in v2.

OK, sounds good - I see the chip select handling now.

--T6OnZCvW5HcnivXR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl48GnkACgkQJNaLcl1U
h9Abxwf/bD6z7Zyx5ZcODXIHhsjroI14CG3xmml4eA/SkHeU5P02YglZOlXrAjQK
AxJfhBpbiDy+R/eKMrzK4bsFjEOWsVLBiJ9HItN0qnnUmTXwfm5hyyxgw5qeHejb
Uzu6XVVf5KmUS9XrOZ4p4JIIO5HWitOpmCtrfMQtvjp7hi+5NIjApdSw5nCMZYxb
edOMq+0DDhXeMdLytbsQOehx6Vflyi7nEZS9TNEeLYG1zQPotBJccAiHypEtU0P0
l/T1U624W5dSwFkSARM+Ko6HNSVgriPTMS1ZVqz4RHnfB+U3g3IsnjAdNgU1nUQP
okovYCXjjOzLRa1fubeUMcjxNrRaZg==
=fyFm
-----END PGP SIGNATURE-----

--T6OnZCvW5HcnivXR--
