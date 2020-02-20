Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DAAC11D1B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081C2206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582227985;
	bh=UmTOehUYik3GEC/kCFIcKCrKniVLy5goVYP5EfoTz5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xeg8K7QN7M9hDDvGlJDJFqequ4BgJnprOUAKyrYPMUnG1edqb5iV3qY3oH8G/JSPd
	 bcqk8CGCKAlbRwr4EQftXE/o5ftkn45Lxd1+/PALhbfOeUu9qAFDym0uGsgTXsD2Jv
	 eRnIsH0Jc02leI7NbPhvxKkVWFgnlowrf3IS9XIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgBTTqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:46:23 -0500
Received: from foss.arm.com ([217.140.110.172]:50368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgBTTqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:46:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22FF830E;
        Thu, 20 Feb 2020 11:46:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E3C23F68F;
        Thu, 20 Feb 2020 11:46:22 -0800 (PST)
Date:   Thu, 20 Feb 2020 19:46:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: renesas,rsnd: switch to yaml base
 Documentation
Message-ID: <20200220194620.GK3926@sirena.org.uk>
References: <87d0ahzr9d.wl-kuninori.morimoto.gx@renesas.com>
 <20200219161732.GB25095@bogus>
 <874kvmt355.wl-kuninori.morimoto.gx@renesas.com>
 <CAL_Jsq+VEQj9Nkyo_85RM3Ku1-D73_ot5BTAjidnJzJv7r1_Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZQs1kEQY307C4ut"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+VEQj9Nkyo_85RM3Ku1-D73_ot5BTAjidnJzJv7r1_Sw@mail.gmail.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZQs1kEQY307C4ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 01:33:56PM -0600, Rob Herring wrote:
> On Wed, Feb 19, 2020 at 8:16 PM Kuninori Morimoto

> > > > +  clock-frequency:
> > > > +    description: for audio_clkout0/1/2/3
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array

> > > This already has a common definition and this conflicts with that.
> > > 'clock-frequency' is a single uint32 or uint64.

> > This needs clock array. Like this

> >         clock-frequency = <12288000 11289600>;

> Sorry, but the type is already defined in the spec. You'll still get
> warnings from the common schema and you can't override that here.

> Not sure what to suggest. Leave it with a fixme or move to
> assigned-clocks-rates instead?

Given that this is an existing schema we should really try to keep
compatibility :/

--YZQs1kEQY307C4ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O4gwACgkQJNaLcl1U
h9DpNgf/T3NsUyExFf1KBDaf9LwB98JuIJZnPVN3szC+niqpV7pWTCL40vzSBGiV
SSlCDGxnMV1mmFT1H6Mv+NWj/E9qf5ech4MVE/LdO6oeRfJ6vlJOhtRVGw9gZz9l
0Jr+r4FrM/F4s+SiCJRpB9bpdBra89Rqy6hMftuOTYORGm4+F+gLM2wMiO0qS7Ro
zVUinC0Toc+WXk2AVK8G2UrErAI9FdZRMXZYXyAYrWk/5cDQXVkWaifVwelDTyy8
INeT1Y0DBOZ1t1In/sJAiw2OL/C+PDxoUE4znyjw53rNB48C0NSVt1XQOyjcXX0o
d5yXeMAnmkXID2NzRS4q3H3OmyN3/w==
=dMJr
-----END PGP SIGNATURE-----

--YZQs1kEQY307C4ut--
