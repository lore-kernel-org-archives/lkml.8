Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCF8C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1872076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588254004;
	bh=VhqX0HsQbZfOc9fdwlGXtb1kKBdlKfnsyMsYsZ5tC1Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=JKRJgCpt3JQrpoOlcjEo0qkLW8FdsS4xOAu8GTPNil+RXRm4cKccNb73yIqJMnB/4
	 zx7sd584MPtRruduUHCFC5g+wfEszhaJ7do8EpQJOnmx1ERB+nn7Y6oOPO+FhFfZPf
	 849TSAtW2nehJHjqUlOeqdECZcTcSMkknSgr+KSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgD3NkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgD3NkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:40:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EEA72074A;
        Thu, 30 Apr 2020 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254002;
        bh=VhqX0HsQbZfOc9fdwlGXtb1kKBdlKfnsyMsYsZ5tC1Q=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=vEyNwKh17sc1MGjKVDP/VBDZCx5SjPCctcZsgiAdAqZRhzpx12dE85noRGTwn2fs+
         NloayhqvlqTgdwY9v1uEOL44vVIaqaW+qmNgAN8y2TNDU2kds55Zx6GkuIuYniqLlE
         ekZgSwQeqMuERtODKsbrkA50qcXA40F0fTTyQ+Bs=
Date:   Thu, 30 Apr 2020 14:40:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        alsa-devel@alsa-project.org, Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org,
        YueHaibing <yuehaibing@huawei.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20200428212752.2901778-1-arnd@arndb.de>
References: <20200428212752.2901778-1-arnd@arndb.de>
Subject: Re: [PATCH] ASoC: SOF: sort out Kconfig, again
Message-Id: <158825399444.18388.10906948463767019815.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 23:27:36 +0200, Arnd Bergmann wrote:
> The imx8 config keeps causing issues:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_SOF_IMX8M
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_IMX_TOPLEVEL [=y] && IMX_DSP [=n]
>   Selected by [m]:
>   - SND_SOC_SOF_IMX_OF [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_IMX_TOPLEVEL [=y] && SND_SOC_SOF_IMX8M_SUPPORT [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: SOF: sort out Kconfig, again
      commit: f9dfa8f25462a2b9bb47dcb563688d616e21ee83

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
