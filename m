Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31E1C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8304124672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579002848;
	bh=5gv4rqr+ETxodMdG9qR822Ir48yIcBhQ3RsyKU/B3Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tgzrgKikRxFDqlPr/+aOHRNuduO0Opqt+EiuqsKcCEFYjAB5aCogfYjB6z8tOiLq9
	 vqGsw72c2cRv0EGBL8mvLKV9eEltWcDXLrZuY3WT2bL1Ty8UvrFR3fYc6sv9FDQ05D
	 MjJF6T348kEpP/I7jAu+ucHJeXvsOKJ1i8zdwd/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgANLyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:54:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59688 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgANLyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lB6MZA50PMhE5+NlRK8xpuUi9p3Jd9Uo2guWBBEMUek=; b=Sxnje9gvx//7SQF2ycC46I8Z4
        1z83g2m36A0efOCsgus46fAoDUDcMqopd+8gWFeIIJnMiOOpgI9XScTrMZHw9zroEofLrf3ZcMfJR
        jNv8mBgiCZJx+9RtoQrDsMYzGEeWOrZhlm8MpkUFXklEdNVqFmduj5FEWt8a2uM9EY3Eo=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irKlg-0007fv-8p; Tue, 14 Jan 2020 11:53:56 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A61B1D01965; Tue, 14 Jan 2020 11:53:55 +0000 (GMT)
Date:   Tue, 14 Jan 2020 11:53:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/4] dt-bindings: Add an entry for Monolithic Power
 System, MPS
Message-ID: <20200114115355.GR3897@sirena.org.uk>
References: <20200109112548.23914-1-sravanhome@gmail.com>
 <20200109112548.23914-2-sravanhome@gmail.com>
 <CAL_Jsq+jyVzSfXr1txMUm7VTk-LFunaukQQ-LoQj4OMHgyzRHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A7FgPGrDEcSmmdo/"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+jyVzSfXr1txMUm7VTk-LFunaukQQ-LoQj4OMHgyzRHQ@mail.gmail.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A7FgPGrDEcSmmdo/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2020 at 11:14:39AM -0600, Rob Herring wrote:
> On Thu, Jan 9, 2020 at 5:25 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
> >
> > Add an entry for Monolithic Power System, MPS
> >
> > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > Acked-by: Rob Herring <robh@kernel.org>

> Mark, And revert this too. It's a duplicate of what I already have in
> my tree and this one is not alphabetized correctly.

OK...  I'm very surprised that you're asking me to revert a patch
that you've acked though.

--A7FgPGrDEcSmmdo/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4dq9IACgkQJNaLcl1U
h9DYmwf/XQmHGqavvYH49xk8K7JAEHtmllFR3shlMUPwgFy7xmOmcyihfeC4P7ze
9d4F/5qJyr+NKHwSxCqXvZ6tVJe9MmiDKfdGGjVNKXGL7MzYnXKH2hXQPlkjSfb8
snzswHCDQG/foE+ELH3QMTv8Idi6Vph9A/avf4eEGRbFB8AWvSwcVZief9ZOtbP4
TsXT9wv7TLyGevADxxbtlaGvErhQmPwRDgkZ+vPZs6hJfZGaL2rXagX86UbaF9en
PR3I8zzxjWUUQYBURnsygvdLHpsARHLwLXUpS1HQVw31aHv7clCpeUYw2q44F7XD
7DFMbh9xme5M781gk6nfNeRCDCQUuQ==
=A9Lt
-----END PGP SIGNATURE-----

--A7FgPGrDEcSmmdo/--
