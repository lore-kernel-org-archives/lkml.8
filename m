Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E89EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E6A2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592332405;
	bh=T5lT9kWL1+5XoYspMvqDXRAJi69PKCHG+eu2XIHeo8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N5C7kaTCQt6INCZIDzDcT1ObohAhIRsnmzJGYU4VizVlPrj01EcpHvMvfkRFhOWEh
	 VvOeEV7Jxb5g97TOQQ93B5JfITSZ7d1UWWm6P+AwYiC7tTYP8vLa/FDCk2AX56Unly
	 +M1Mi8nQz3+U2oJnmp7XfaDk8jcQc+eMuIYBk7fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgFPSdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgFPSdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:33:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD8F9208D5;
        Tue, 16 Jun 2020 18:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592332401;
        bh=T5lT9kWL1+5XoYspMvqDXRAJi69PKCHG+eu2XIHeo8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klCom9v2icWhWrWU1Ztb6psrEGGQw4kopyXhtC5s/KeJzERv6F6cx//cxW4b8MTQM
         oRfr/ikNKd8Nso8qlmmU5PILvp5o8tEzVeTn/4rj8gMoIR3nZDwbkw39ttb/RgC/RM
         aZu3fvLVxyCLrAmF11j7GrYv2ayDSXR8wBgy64Vg=
Date:   Tue, 16 Jun 2020 19:33:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [RESENDx2][PATCH] sound: qcom: Kconfig: Tweak dependencies on
 SND_SOC_SDM845
Message-ID: <20200616183318.GW4447@sirena.org.uk>
References: <20200616063417.110263-1-john.stultz@linaro.org>
 <8f7f563b-fae7-e25e-33f2-18c608c338e6@linaro.org>
 <CALAqxLXnijNBB4HBqLG4k679FRcHT8hjSLMnpjE_+0UkqU7Y0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oDAD4Gb5rN9RYJiP"
Content-Disposition: inline
In-Reply-To: <CALAqxLXnijNBB4HBqLG4k679FRcHT8hjSLMnpjE_+0UkqU7Y0w@mail.gmail.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oDAD4Gb5rN9RYJiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 11:01:02AM -0700, John Stultz wrote:
> On Tue, Jun 16, 2020 at 1:25 AM Srinivas Kandagatla

> > > +     select SND_SOC_CROS_EC_CODEC if CROS_EC

> > Isn't "imply SND_SOC_CROS_EC_CODEC" better option here?

> I've honestly not gotten my head around "imply", so I'll have to take
> a closer look.
> What I have in this patch least is easier to compare and match with
> the existing code. :)

It's a conditional select which enables a Kconfig symbol if its
dependencies are enabled rather than forcing it on regardless of them,
avoiding most of the errors that select tends to introduce with missing
dependencies.

--oDAD4Gb5rN9RYJiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7pEG4ACgkQJNaLcl1U
h9A83gf/Wj+ilOQgoTPb2UGpwDK580vgreUDhkyI/tLuWCYjrCNHUE8QVY9gKbvz
WV1cDOsr+wHc5cv7kja0mYMyRfvuu+coZkSVv73R8SWXyFYu8sX5WGK74GobfsJB
1MxXEDMBz/WvXhdGITWeCzI0VgTWBUc7frTbx/EluN+nJOp1v+ogdpAjtO887vSP
JoiUfYiPXNUMMOxGEa1JTkRpirVFOr+FvH8JV8EvYF61RHJTZq/t3+7VIPYV7Zao
cdsNhNpvQm6tnfzaTrJA+nVEdr1vltAAT6tebOsGhrsXWQTfsQcif/jH7Me9h5EU
D+li1k5pHnpAfeHhp3rzPVpAhUjXVg==
=Xj+F
-----END PGP SIGNATURE-----

--oDAD4Gb5rN9RYJiP--
