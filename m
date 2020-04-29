Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26159C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0291F2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588177577;
	bh=33oKVqnVVSWcPuaIyCjKz2vV+qGee0QU5lzC5qxpjZ0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=yIFoDECBRGGmZPwkS5zZhQGQErSOthMF7rVIhvZSj+mdWU6EkGVT4xrepQZxJTvKm
	 fGR9XNeM3JGkf5sDknwt/cJU4G15uIKjQTqlOO/AC86JAyGWuCiiohZdWeuLMKc0OF
	 ARlrcbyBvphQIENI+BzqraKbLkLG2hinkdyJi0wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgD2Q0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2Q0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:26:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 992892076B;
        Wed, 29 Apr 2020 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588177575;
        bh=33oKVqnVVSWcPuaIyCjKz2vV+qGee0QU5lzC5qxpjZ0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sCVPwvP0tWgHHy/E27fudChYtQK4UQQxo9v1bQYKiAgPGsOHKXUWRpwM6CJO59Kdk
         16QPw4Vi5mL13byrj32MHTVDjSq16dmvs+AAZ2OKZpKL3a4q9tlvz/vyW0VCaAbDog
         vjcozreqTCK2o0RkTC8u/UYzi8l2ADJJlohaPxNM=
Date:   Wed, 29 Apr 2020 17:26:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Timur Tabi <timur@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20200428212847.2926376-1-arnd@arndb.de>
References: <20200428212847.2926376-1-arnd@arndb.de>
Subject: Re: [PATCH] ASoC: fsl_easrc: mark PM functions __maybe_unused
Message-Id: <158817756638.27768.13822948104457299760.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 23:28:08 +0200, Arnd Bergmann wrote:
> ifdefs are hard, and in this driver the suspend/resume functions are
> the only callers of some other helpers that trigger a harmless warning
> when CONFIG_PM is disabled:
> 
> sound/soc/fsl/fsl_easrc.c:1807:12: warning: 'fsl_easrc_get_firmware' defined but not used [-Wunused-function]
>  1807 | static int fsl_easrc_get_firmware(struct fsl_asrc *easrc)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> sound/soc/fsl/fsl_easrc.c:303:12: warning: 'fsl_easrc_resampler_config' defined but not used [-Wunused-function]
>   303 | static int fsl_easrc_resampler_config(struct fsl_asrc *easrc)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: fsl_easrc: mark PM functions __maybe_unused
      commit: 087e3900a060cfc8516e02ea83fe6122da490d23

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
