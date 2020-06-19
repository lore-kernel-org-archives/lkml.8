Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B29FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14106207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592573338;
	bh=LesmmGjwNyruZz2lXKjFL5SydTkXOhMREE472owY8hw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=ZactOs7dwTB9v/5/G0B9D4qBvMiIAnESxqL1rjNjO1yTmYuRYKAC0KCTl5eYMJvK3
	 e/POjm7H/qRjWUb3LLHcoG6Eh64GpBPQcH5pFjpCIXavmzyCGT6c//oyxkl0bxxnTM
	 oF6WslYxEi1pJBM1xQSt8gMnIgixgc6SMjpe8P04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbgFSN2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731398AbgFSN1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:27:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11E0C20771;
        Fri, 19 Jun 2020 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592573257;
        bh=LesmmGjwNyruZz2lXKjFL5SydTkXOhMREE472owY8hw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=cE5Y6mgFKG9RWrq/3D58egK36HL8+Y2NKAaAwB0w3Q1SX+jbwm+U4wWqVDOwWGfMe
         wHJenbY0Intxm+EYD6ydqu5QPxjiAh1nHlCCojps/BhKVr6CkOA33m6YnjFZ/HzMiG
         LcEtR4fd61D1SOP5b+kZZH97duXCK/H9NTjsrMZM=
Date:   Fri, 19 Jun 2020 14:27:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Banajit Goswami <bgoswami@codeaurora.org>
In-Reply-To: <20200619031407.116140-1-john.stultz@linaro.org>
References: <20200619031407.116140-1-john.stultz@linaro.org>
Subject: Re: [PATCH v3] ASoC: qcom: Kconfig: Tweak dependencies on SND_SOC_SDM845
Message-Id: <159257325526.5735.5370337418723229662.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 03:14:07 +0000, John Stultz wrote:
> CROS_EC isn't strictly required for audio to work
> on other SDM845 platforms (like the Dragonboard 845c).
> 
> So lets remove the dependency and select the related
> CROS_EC options via imply.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Kconfig: Tweak dependencies on SND_SOC_SDM845
      commit: 3bd057c8219d4006f2b436cea2ae5ac723067a51

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
