Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68488C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450E42068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587481171;
	bh=uyT1aLMoqiSFZASoifttJFHl8XFalhQXY/HRvDYt9gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FHlg5v6JxHZBS+E2EiKy88jj17y7KsIofICjq9bIKjB0J2kw8t8/4Ar6T6USnZ0wk
	 XSH5vOgv3LqXaYVps2wI5JFBEFQXgrRwQgi2fPdbwFMeSu+UUVn4IDeK5GLJ0Nwmbx
	 RSRPkOf00NdRVHOwGvLhLGPRj+IPH8MaL3xfI3qQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgDUO7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUO7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:59:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DDEA2068F;
        Tue, 21 Apr 2020 14:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587481170;
        bh=uyT1aLMoqiSFZASoifttJFHl8XFalhQXY/HRvDYt9gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZ5b54x6PEBvfk2CBXWUWG1lbn6HZK0vUI5a4z0vypnlk6sWBXWgn3ZuQKQsRGbq0
         +M5Sdc0840AwBZEuvNWohj71sChwj+1M/0FZUeH7QY3c2chy6Lf+YucZKkTWhvoI7D
         MCzYar525Ub0F3xcQzu/jVBbux6X8HKc+dgPhf+E=
Date:   Tue, 21 Apr 2020 15:59:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists
 only on legacy controllers
Message-ID: <20200421145927.GC4540@sirena.org.uk>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
 <20200420190853.45614-10-kdasu.kdev@gmail.com>
 <20200421125025.GB4540@sirena.org.uk>
 <CAC=U0a35yfnuXN1CXV7YnHCff-Ba+7UZ2dd0rFVFSNuA=O98VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <CAC=U0a35yfnuXN1CXV7YnHCff-Ba+7UZ2dd0rFVFSNuA=O98VQ@mail.gmail.com>
X-Cookie: Non-sequiturs make me eat lampshades.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2020 at 10:53:57AM -0400, Kamal Dasu wrote:
> On Tue, Apr 21, 2020 at 8:50 AM Mark Brown <broonie@kernel.org> wrote:

> > If this is a fix it should have been near the start of the series before
> > any new features to make sure that it can be applied cleanly as a fix.

> Yes it could can be after [Patch v3 3/9] spi: bcm-qspi: Handle lack of
> MSPI_REV offset

That's not a fix though, that's adding support for new devices?

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6fCk4ACgkQJNaLcl1U
h9AViQf/bQFHPo9FjLFZTBCau3RztJGYN74b26UHdDWiIMJ+X5YamwmzXtgO/f+S
T0WrmGDL4ursd0B2KhmoEguH2wLCNO5GtIeo+Wrat8QDl+6t10veayzpdVB8GJ8G
HNsEBoELbsZ65vmw2isZAtdx6ADSgRkDSfZkIjzip9+5EALsxbGkUTEqh6Kg8tRe
CyOZlYj0QfqUE8gNIXj0rJlHCP1stMaTiU7RRAxiSzfXNXdh+diFFUXTu/KjSFQW
fC2QPMQitnNBoZPw+A7DyIPaGO94iJDD4YzSzzLVz1HEdjwMPSlijtEhPQWjkWsg
hsqoUs0b34snt53dUAGyYBr2lldUlg==
=Bw/m
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
