Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9C3C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5AD20679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584371604;
	bh=jzaKcrjBVVgXu4gQbm8RO2NC8KMRRW29Vaj/zvBoqKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cPpevKTu12K4NK18JeNtKzkpv/AoxHw1NI7UTuup32slVwymQRYOr/gdTd2rbtKN6
	 zPSPTtoVsud5DbaDQFpWQWbCmccPdPm6rkABztMCMMMw3OnwDGwpRH/C7KfAmiLlAn
	 SwgeFlrCWqT/Cz/478eGO7Htnd1re5fOCoD6424k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbgCPPNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:13:23 -0400
Received: from foss.arm.com ([217.140.110.172]:50390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729964AbgCPPNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:13:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 911181FB;
        Mon, 16 Mar 2020 08:13:22 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13E253F534;
        Mon, 16 Mar 2020 08:13:21 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:13:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fix cs_change for last transfer
Message-ID: <20200316151320.GI5010@sirena.org.uk>
References: <45912ba25c34a63b8098f471c3c8ebf8857a4716.1584292056.git.mirq-linux@rere.qmqm.pl>
 <20200316121750.GD5010@sirena.org.uk>
 <20200316143455.GA19141@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Content-Disposition: inline
In-Reply-To: <20200316143455.GA19141@qmqm.qmqm.pl>
X-Cookie: I thought YOU silenced the guard!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 03:34:55PM +0100, Micha=C5=82 Miros=C5=82aw wrote:
> On Mon, Mar 16, 2020 at 12:17:50PM +0000, Mark Brown wrote:

> > This is the opposite of the intended behaviour - we want to deassert
> > chip select at the end of the message unless cs_change is set on the
> > last transfer.  If this were broken I would expect to see widespread
> > problems being reported.

> This is unfortunate naming I suppose. I reread the spi.h comments
> a few more times and it seems indeed, that .cs_change =3D=3D 1 on last
> transfer means to a driver: "you may leave CS unchanged" - quite the
> reverse compared to non-last transfers.

cs_change also means that we should add an extra chip select transition
on transfers other than the last.

> Please drop this patch then.

OK.

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5vl48ACgkQJNaLcl1U
h9DeXgf+Msgq0Fm5YFrl6BpPbINtM7Fs6PHQdsIBzUMHwaUxzJ476+0jR9ILxEvu
oCl/v/BLaAw/KY/8ThuxaxG4H6S4s2U81tyOzDDJGINf+DIkbsTytxcHzC8fHlmC
cCX7v80+PGdLbNklVqd34sNgTPPiG0GgLUBbFJu4J9ALVA158w4RBYQMVRACaOi7
iqxBkcb2LoZA3d4Ack098jTiyFEbV3yUJGWb3mkOzlvEsoZEbZOG5hU+1YH10roJ
rXsen2GpoQ01/kt0T0qoPSMBPyVSYHcbs3mc+I3JroIo0my4bVTOxvMip+G33jwe
ftkmcl8XS3KCBDNLs08TsBWjugPd0w==
=4bFZ
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
