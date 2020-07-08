Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF76FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE7F20774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594213996;
	bh=5rANE8QL9bujIGIKTFmNAOGIjpnD1tbUYUW9Yy2zXf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XoFFuqKhjTV8d33PLUiHPnHctN5cReGo/6FsxDxdVog70IkBopCkHJoeDmxNAql1X
	 GKmbCZaLQNO3pAdG1OZwBi6NuyhQ2QJuUifGDCRHn97V5v22Mdo2CBJfdjMwrvCkEJ
	 eQg35lX/r5D+oQd556EMHWMuUZg8AApu24PoCiz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgGHNNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:13:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbgGHNNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:13:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C5A20578;
        Wed,  8 Jul 2020 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594213993;
        bh=5rANE8QL9bujIGIKTFmNAOGIjpnD1tbUYUW9Yy2zXf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w4+SEDGLAoFA3Xs7h9v8fQ6kjHFgBMCaiT3W0AjRftyEAUzxY8jqwpkxq5zhH9xZt
         wtYwhEmYsxu46SnGP6wBSLJYjIGLURiBDW2NRIhmUssF2btzHI8xyypEtSGbpr+ssm
         cCvfO9iv4r43IHJhMNurq3k02mT6Si6QyK7oN968=
Date:   Wed, 8 Jul 2020 14:13:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Subject: Re: [PATCH 03/11] ASoC: q6asm: make commands specific to streams
Message-ID: <20200708131307.GO4655@sirena.org.uk>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-4-srinivas.kandagatla@linaro.org>
 <9ff595b4-1093-36c8-f27f-f097e24657a0@linux.intel.com>
 <4eedae20-903f-77c6-c6e9-fbf3db209bcf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GoZzJvFfKjxI3RhA"
Content-Disposition: inline
In-Reply-To: <4eedae20-903f-77c6-c6e9-fbf3db209bcf@linaro.org>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GoZzJvFfKjxI3RhA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 10:44:19AM +0100, Srinivas Kandagatla wrote:
> On 07/07/2020 17:52, Pierre-Louis Bossart wrote:

> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (substream->stream =3D=3D SNDRV_PCM_ST=
REAM_PLAYBACK)
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 q6asm_write_async(prtd->audio_clie=
nt,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 prtd->pcm_cou=
nt, 0, 0, NO_TIMESTAMP);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 q6asm_write_async(prtd->audio_clie=
nt, prtd->stream_id,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 prtd->pcm_cou=
nt, 0, 0, 0);

> > sound/soc/qcom/qdsp6/q6asm.h:#define NO_TIMESTAMP=A0=A0=A0 0xFF00

> > is the change on the previous line intentional?

> May be not!

> Plan is that the users of these apis will send flags directly instead of
> boiler plating this!

> This change should go as part of next patch("[PATCH 04/11] ASoC: q6asm: u=
se
> flags directly from asm-dai") which would make it much clear!

It should be in here.

Please be also consistent in your use of ASM, especially given that asm
is a widely used name in the kernel.

--GoZzJvFfKjxI3RhA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8FxmMACgkQJNaLcl1U
h9CkaAf9EYS1y3Rx8LG8HM3oH1Htsox8HmKMN+MFhUgtH+3ent6wb2eaYtZ+FcET
qwwYx6Vrs4F5lBh6UyKGFhUyznHP01JY2qGjtUfgEP+NRJc1IcSnSuAiD1Bu77Wl
0HSBK7HpF/feGrZZcUxov527kh7O1TCBEAu3/PNCLZ45SXwbNP/6rDMc2PQM1JlQ
/rjNJpWokFP+CnUaY4Yy653Jlh6s+7UTJyi0bKzXpejJyYhDICBq5XS8PmGA/EE2
8wU3ez4ZBwlr9ujK67WuSRuOFeGpnU+HtRdo1KTNs4msmNQZdjSlcjEYgWo5T883
EhcHgBqaHAPIPKdv77XiRIygaJm1GA==
=8rYY
-----END PGP SIGNATURE-----

--GoZzJvFfKjxI3RhA--
