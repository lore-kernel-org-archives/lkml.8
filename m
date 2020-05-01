Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7032EC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496B82184D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588332449;
	bh=UH6cTiMh0sv5Uy7J2+m2eO6ibhJIWZOkBT9Uo7gNtjE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=VVVue6fgfPafZWcanJFm6NmAQRHFHdLMPVa610SldzSkBkI5PC4JkhbUi6dWGXRlK
	 JUFJ9bZINNJO9owdcUtGBIJMsI8HjdIvdWsfLL+3xO7eW1QwLQRSsJji/rqOjKzjMA
	 jCZJBiQiNvLLkzbDZ9p3mO8VbyVMToOwwRI+K0ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgEAL12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 07:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgEAL11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:27:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A167120787;
        Fri,  1 May 2020 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588332447;
        bh=UH6cTiMh0sv5Uy7J2+m2eO6ibhJIWZOkBT9Uo7gNtjE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=elpgVYOXj6j3U2dToXz5PGIE7ixbJugnDAw13DbcaZMBI/kD8DsbeurAAFxgyu9eU
         YKyW7NlKD+rX/Mw9nMAt5n8nIsgXxfh3Sv/v9yU26hx80y+JsXJ/Rk+YGG4VyzuUVY
         mv5ej7bWO0eJUo/RUJ/bjJSNYOzloYCBrGUrFhY4=
Date:   Fri, 01 May 2020 12:27:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
        daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ranjani.sridharan@linux.intel.com
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
        Jaska Uimonen <jaska.uimonen@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE SOF DRIVERS" 
        <sound-open-firmware@alsa-project.org>
In-Reply-To: <20200430091139.7003-1-kai.heng.feng@canonical.com>
References: <20200430091139.7003-1-kai.heng.feng@canonical.com>
Subject: Re: [PATCH] ASoC: SOF: Update correct LED status at the first time usage of update_mute_led()
Message-Id: <158833244366.11565.11159142364410757346.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 17:11:39 +0800, Kai-Heng Feng wrote:
> At the first time update_mute_led() gets called, if channels are already
> muted, the temp value equals to led_value as 0, skipping the following
> LED setting.
> 
> So set led_value to -1 as an uninitialized state, to update the correct
> LED status at first time usage.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: SOF: Update correct LED status at the first time usage of update_mute_led()
      commit: 49c22696348d6e7c8a2ecfd7e60fddfe188ded82

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
