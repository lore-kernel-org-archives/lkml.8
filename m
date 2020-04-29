Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2877C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF59520B80
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588161916;
	bh=BHx6Adc582HX/EI7gEWPQT8miSuzlW266b32vPCYeME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h/qSFA2iErhPfDOO5CwJhrEfBOZ9+E5hPuc6PuIdTsaNCYzhbtug5RDwKoc4TQvQ/
	 2ijWHcW5ZOxTNGu7S6P+mLgFmuQFMWpE2aY4UmWHZKLZzzd733WDDXQJutVjozdHPy
	 ZNaMb8MTHycZ56Jgi+V2WV1cWsdGkxGgH8tDcwIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgD2MFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgD2MFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:05:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F8B208FE;
        Wed, 29 Apr 2020 12:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588161914;
        bh=BHx6Adc582HX/EI7gEWPQT8miSuzlW266b32vPCYeME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StwkJngH70s5roDZrk0Vd0cSxaoWgkq9/v/SdRm0VsfveIt/PScZ4eGrr0cCqV5Yi
         bgXyOwH5HMG8tiQL2kbbdS1mALhVuxn6iUOzJd9DzIKPw4LwXeyZ8XdAOiDFocEt5O
         rfDMpk4aRr6mied40vjSshkkuH1tA5VSghN9ckWA=
Date:   Wed, 29 Apr 2020 13:05:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Marcus Cooper <codekipper@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] Re: Audio sound card name [was [PATCH 4/7] arm64:
 dts: allwinner: a64: Add HDMI audio]
Message-ID: <20200429120511.GG4201@sirena.org.uk>
References: <20200426120442.11560-1-peron.clem@gmail.com>
 <20200426120442.11560-5-peron.clem@gmail.com>
 <20200428080020.35qcuylwq2ylmubu@gilmour.lan>
 <CAJiuCcc2LQ4L36KSfO8iLVFBUO6k+zsZFX+_Ovm_10PoWO4AsA@mail.gmail.com>
 <20200428160417.6q5oab2guaumhhwi@gilmour.lan>
 <CAJiuCccFFUJJzXwygLQbDK4fGJ61p72Hv7vj3WVP-=z=J1Yj0Q@mail.gmail.com>
 <031ee5d3-8a30-82ee-76db-c0e8a1073046@arm.com>
 <CAGb2v65rRbRpUTdkTF3hd5LnLQQt19YVOyVzM5te5XNVhQQH=A@mail.gmail.com>
 <20200429081729.qa3gqtl5sof2jhem@gilmour.lan>
 <f9b701d9-0c4e-6e41-1ce8-52adf0f59a2a@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline
In-Reply-To: <f9b701d9-0c4e-6e41-1ce8-52adf0f59a2a@arm.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2020 at 11:43:06AM +0100, Robin Murphy wrote:
> On 2020-04-29 9:17 am, Maxime Ripard wrote:
> > On Wed, Apr 29, 2020 at 02:24:00PM +0800, Chen-Yu Tsai wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > If we also end up with "HDMI" as our card name, then the userspace has no way to
> > tell anymore if it's running from an rk3328 or an allwinner SoC, or something
> > else entirely. And therefore it cannot really configure anything to work out of
> > the box anymore.

> OK, you're a userspace audio application - enlighten me as to what exact
> chip you're running on here, and why you need to know:

> card 0: HDMI [HDA ATI HDMI]

> or how about here?

> card 0: Intel [HDA Intel]

In the case of HDMI for embedded platforms since there is generally no
control in the audio path it is unlikely to make a *huge* difference,
though if there are expansion buses or multiple HDMI ports it can be
useful to help people identify which particular HDMI port it is.  For
other cards the names are part of userspace working out which config
file to apply to the card so deduplication can help, and also the
plastics tend to matter.

> With simple-audio-card we're talking about trivial interfaces that often
> don't expose any controls at all, so there's unlikely to be much
> 'configuration' for userspace to do beyond choosing which card to output to.

This is a reasonable assumption for HDMI but it is not at all a
reasonable assumption for simple-audio-card in general - just because
the links between the SoC and the external components are simple that
doesn't mean that any of those components are simple, and even if the
hardware is simple that does not mean that configuration is unimportant
- the difference between full scale output and appropriate headphone
volumes is for example *extremely* important.

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6pbXcACgkQJNaLcl1U
h9Bzugf/c28iLtVw25sffS7FxnwHu5kFpEMA6AESU/nbib3pIGkMPZg+yn69tK3S
bdnoVTnaJl2n84nFz/STXBtafZ0xebeAN+eZu0Gd7vtygVQlVGBP0QqPBo04u2Ko
xSfYbaycfHROmTbbL5xIoJ0XaxNOgnZd0epZRpcvNDkDZJ8YvlwoR5Ooi8C/SR9E
xqmpX9gmh59QtZf3NS5mQ+4PIHwxw35rxIgA1P6mIFRaseuz6njlFAlpKpCfWHy8
ZOYQ79RmdZDUSkqlOtUToBxkOrVCPHHmr5YoblVd3P3olP4ZBcmpnRuB4+QkxifA
7T5xU5H+PZPzUMBmDu6Mtx6P+4INhA==
=xohR
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--
