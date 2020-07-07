Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B63FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB87C20773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594131436;
	bh=xiM86TEWnTbnoRN62OKAZLkyZO3l0Gu01472tfcVo2k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=XoY5AQS0BpCBkg7utnd8bJKGPElE8LgvqjkBh4q31NIVPj8pr0Q1W6zvc9bc+r+l6
	 qJk5Nd03uVp7TlEBpL3dp2jhh3GZADU7a/9G6QXX9lozfmxOK+GYE1G10hK76s8H2D
	 EUDuc87+eAPT5LzvNN02ayZ9lg5/Hu/ZrgAP2yFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgGGORP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgGGORO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:17:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7EA8207FB;
        Tue,  7 Jul 2020 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594131434;
        bh=xiM86TEWnTbnoRN62OKAZLkyZO3l0Gu01472tfcVo2k=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nA/5MTV4XAh3mSK0N8pd2YHm4Fc1Mw3kmvhCpNX8++J57fjyWRx2FCWXekcpEehwP
         V8u/sf6EoJ0yd5Iqw1tuazCyX6cCYd0e8drP0B+RbzLw4ove40SNlsEaOG1Cw+A+wG
         TYTV1SaxD4kB0WqEvxIUXDdtGb49T/dDvfjD46PE=
Date:   Tue, 07 Jul 2020 15:17:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20200707074237.287171-1-maxime@cerno.tech>
References: <20200707074237.287171-1-maxime@cerno.tech>
Subject: Re: [PATCH] ASoC: core: Remove only the registered component in devm functions
Message-Id: <159413142466.34737.6407676326055176145.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 09:42:37 +0200, Maxime Ripard wrote:
> The ASoC devm_ functions that register a component
> (devm_snd_soc_register_component and devm_snd_dmaengine_pcm_register) will
> clean their component by running snd_soc_unregister_component.
> 
> snd_soc_unregister_component will then remove all the components for the
> device that was used to register the component in the first place.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: core: Remove only the registered component in devm functions
      commit: 58f30150ffd6d95efa524ff05bbcee4e95bfa870

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
