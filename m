Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5F1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F008204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458330;
	bh=CqDYfczcR1q266t02Vom+AVTSJNakCMLYWVNuU1vHTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HcHAcM2kYLfffZCrlofz8gPBxZfD7chk0bA/xXyyP4ce6XzKgCDtTns/FFk219uc2
	 HTMPfL8+gPPpvqBnwVnktTRr0XDsMRWiWBguv03ReFgXKCqVhKIO3ADY0dszNx0QKr
	 OWyiaAMQxG/+F8g5zUdYpqa9yV12DazriHgYdWg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgHCMiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbgHCMeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:34:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D8F2054F;
        Mon,  3 Aug 2020 12:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596458062;
        bh=CqDYfczcR1q266t02Vom+AVTSJNakCMLYWVNuU1vHTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DoQrCL+oQCXUMv4UKHkiv7SrlmHJFp7bkkGYydn8kgA9zmNHwN+3sCaNhxM/mtaQn
         kycP4nEREMBGCXRKiZeLqQkpcU8pqkNmy89F9WtkczF2OcXF7oHOXwc7UD9BPnzDTq
         xQuDosOGp5YEGSCOttpZaFhbnomb7SYiDcPX76lY=
Date:   Mon, 3 Aug 2020 13:34:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     skhan@linuxfoundation.org, ltp@lists.linux.it,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: vdso: hash entry size on alpha,s390x is 8
 bytes
Message-ID: <20200803123400.GE4502@sirena.org.uk>
References: <9927ed18c642db002e43afe5e36fb9c18c4f9495.1594811090.git.jstancek@redhat.com>
 <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline
In-Reply-To: <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com>
X-Cookie: They just buzzed and buzzed...buzzed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2020 at 08:18:22AM -0400, Jan Stancek wrote:

> > Do similar check in parse_vdso.c and treat hash entries as double word.

> Ping, any thoughts about the issue or patch?

I'd suggest contacting the authors of that code.

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8oBDgACgkQJNaLcl1U
h9CCPwf+NIw+rcyLIhnRorwowwqEVgX/nqjDNZIycdnQe86dOazM/FkHhE8xFP8X
ehM0B/EoDmMfXz/AxXWt9hwAH8O5jZyjpLg6M3onsS6uzfwoJloTsAtyahtjidQG
7jDlMXEwhomOQRr7N+KQe+4LArk5Td2AMpA7luEpE/WMtNXjE6slnQJke+GIBeSc
SVOz6ID/cv1n1O+c+LV++2xvsupajfPhINLHp9tmholkiy9k+02zkph6SXra0tSv
cfg3Q+IdGq+yr9KAYpj6+yFcG10X5gQmgQjhbe6ZiLdGOV2IouQc5q1n3+ceSHTl
AVY1i+c9WXnihPbxDrKB72Uqdb7MWQ==
=7zqN
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
