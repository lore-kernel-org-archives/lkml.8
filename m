Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5845C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E8B2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594901913;
	bh=0J7nQDSjZrTifeuADANONS1SeBEAquG208vMBg1R4N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ecr7GqWVifMqWatWCJK36SJQP7Ntf7btEsbDzfXBBpdqhc1PaXXqc7mdEIWL1Ue7K
	 lE+3+dKggU5aqcItKw3/ZQL3MUlK6NwJ2i8A0fWyswmqWCVHmcBtGsIQCKXsgvAwXe
	 I+TwKTvCbquHTCcLiDd65pONUgCSGxS25uSktFV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGPMSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgGPMSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:18:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC2420739;
        Thu, 16 Jul 2020 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594901911;
        bh=0J7nQDSjZrTifeuADANONS1SeBEAquG208vMBg1R4N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAp+CQ4EFF4rW33jqP8BQziIMOZ/7afSs977gdQHDbgBcHFXzCgySxSSTS33Y90QM
         UYEwh52tT1RepBptgcrdLs3VBXHhly+fbyLLWr7QhNVPoqhA+uZt6lbeGmIFQNFaU+
         xdo7RhZONkxj9Bj4fEwIZTbUxl7CH2KkVb8dSzWM=
Date:   Thu, 16 Jul 2020 13:18:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Message-ID: <20200716121821.GA5105@sirena.org.uk>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
 <20200702184226.GA23935@Asurada-Nvidia>
 <3f39a0bb-a766-f646-28b3-a51cf9983c6b@collabora.com>
 <3fea8912-63df-ff27-0c29-6284a85107ab@collabora.com>
 <20200714201544.GA10501@Asurada-Nvidia>
 <20200714202753.GM4900@sirena.org.uk>
 <20200714205050.GB10501@Asurada-Nvidia>
 <20200715140519.GH5431@sirena.org.uk>
 <20200715210308.GA14589@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20200715210308.GA14589@Asurada-Nvidia>
X-Cookie: This login session: $13.99
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2020 at 02:03:08PM -0700, Nicolin Chen wrote:
> On Wed, Jul 15, 2020 at 03:05:19PM +0100, Mark Brown wrote:
> > On Tue, Jul 14, 2020 at 01:50:50PM -0700, Nicolin Chen wrote:

> > > Thanks for the input. Fox i.MX6, I don't feel it would be that
> > > drastically different though. And both SSI1 and SSI2 can simply
> > > select the same root clock source to avoid that happen.

> > If you've got two radios that both need to sync to some radio derived
> > frequency it gets a bit more entertaining.

> I'm simply curious what could be a problem. Do you mind educating
> me a bit? And ASRC here isn't a radio but a sample rate converter
> working as a BE in DPCM setup, using radio-capture for example...

My understanding was that this application was using the ASRC to convert
between the sample rates of two different radios - the rates may be
nominaly the same but in practice different so the audio will glitch
after a while when the clocks drift far enough apart.

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8QRYwACgkQJNaLcl1U
h9CZ+Af+NYRxkfTtg8WBjZni+cWVj2UYcWJzvcO+/I8x9ezubUx7VFoudv4EL5Xg
p65R998zXaUDrzqN9gYMjrP0/vxiPyuzRgJox8+zdn+hWcVwotRQ0iTzy2zyg9Er
y2+7AniP0YI6RikrzgQ+ARmMPjZ6+TnTlasPHjWBBJ9m2A22LbJvgSBDsrNWQeA2
kt/6AMU3Y3Mo3SNUNCKujFH7+EH+byFOcwnro/+UErg+2Jh8sgTIEHoQfXKWh5I5
F/S0mB8aZONQ+6GcJelTkEOJl6t0h1EXi5YAEwyGj+BaqUUyykUAP0u02agGqKBI
iM4/4uGgIL5OTKvkmGfnol1KxHBXiQ==
=QiTi
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
