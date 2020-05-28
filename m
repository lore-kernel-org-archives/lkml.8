Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42C420888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590666169;
	bh=dtzMfsSfVshidYNHSmPWv2FMnmJz2lCkiMLmmsPTSXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pioS60J1gYjD9jvGkWLZDNZxWPWmdpg3PwdzD6LbmPgvaFTRWay8DIk1WiA8ho2j2
	 OJahvLhE3U9PZ+z71qsxQ0cdwfBEdIs6A/MhclDlP8N1puPRzPlefFBGNUZPTxC0AZ
	 QHq5TWZjY3bhvZFO2zUv43slnfWjZPFovE6c5/YQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbgE1Lmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388427AbgE1Lms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:42:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 634702088E;
        Thu, 28 May 2020 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590666167;
        bh=dtzMfsSfVshidYNHSmPWv2FMnmJz2lCkiMLmmsPTSXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1pHwIIn+7acJF4bQkizS5XEuTFfBr+LTUJEdErBiDqFlMp8zl1ncg9FX6AcbrKhp
         i7dXLLYiaSQ4B8pQsG3si4DEJAxH/LiqwT6LLkrID1UvfYt/qPUER8U4wMEKH0jW2+
         y2AxN3BvotPcF3rj6Qt7XBsqJP0lGxo3ug8zjKW4=
Date:   Thu, 28 May 2020 12:42:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     yuhsuan@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [v2] ASoC: AMD: Use mixer control to switch between DMICs
Message-ID: <20200528114245.GA3606@sirena.org.uk>
References: <20200528060242.24945-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20200528060242.24945-1-akshu.agrawal@amd.com>
X-Cookie: Small is beautiful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2020 at 11:32:30AM +0530, Akshu Agrawal wrote:

> @@ -307,6 +295,7 @@ static const struct snd_kcontrol_new acp3x_mc_controls[] = {
>  	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
>  	SOC_DAPM_PIN_SWITCH("Spk"),
>  	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> +	SOC_SINGLE_BOOL_EXT("DMIC Switch", 0, dmic_get, dmic_set),

This now looks like a mute for the DMIC which is not accurate.  I really
do think this would be better as a mux, rather than labelling it with
positions on the case you could follow what other drivers do and label
it with the connections on the device.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Po7QACgkQJNaLcl1U
h9COAgf+PoJVGILg2JFoP6A3vbP+3kX5PehTYV31b0PiK7XzhhNGQdb02C6Z597f
Caqhjgofozl7LyHsEetlNs0bxxrs6YMzmQqnKd+jQ4Fx8DfMvb2XwrWsIG+OluM6
7dQx832oXpfVcMre8toqfNk5//M8/AlVXl5a9jtgl3LZJ4MXg/jxUF153L/csVMN
Hch+BBKkgEW99XSrq9/WPGSIfHTLk0ZtBiqfk31oipkS5Gko2MKAiSNb2pwSMHsD
VcxnUB/XU0zWDDrQRYny6fRbBVvCvdDbNlggYDUMVlv1bbxqg7ubpzpgT6ifzHWt
Q5UsdEeMzVdFisKthaxyyPA4iEslrA==
=KuLc
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
