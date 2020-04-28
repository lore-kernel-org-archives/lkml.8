Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06C2C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB382075A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588088484;
	bh=BKDKvSn8LUzBEdgCRA0cYEIBFBCWglHXGBbtNkpxGq8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=M81m3xXuCvaW82vNKKbZaVdh4J2rGm/zTlNQm2oEELVc/rjdQJNrddQb4cvNue174
	 w8KIizu4x8LT6VbXp0Umre/z/pNM4MD5DV2CGhnO2Quxi82n+Hj9RDfBEeIXMW8x3p
	 l1A0LMCxbHWbWwztVXCvzbuGcmModoJwCpa6rZY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgD1PlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbgD1PlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:41:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5196D20746;
        Tue, 28 Apr 2020 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588088482;
        bh=BKDKvSn8LUzBEdgCRA0cYEIBFBCWglHXGBbtNkpxGq8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=aapNIP/EMASZ2QIesqJaqb1QgQeGZ9IFVIohyszfgsnkCN2v1/oXbhMOlNOPW3tgJ
         jZ0C81LjMBuvEIOz6NBAMs4PMlLGRh9Fe4SWx0a5PyCcyqMhRX1mLWOEIGGMerOicg
         vN+3/pHkBMtuApknJSHk8ZPsCTEUvQhI5ua/4b9M=
Date:   Tue, 28 Apr 2020 16:41:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Ben Zhang <benzh@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mac Chiang <mac.chiang@intel.com>
In-Reply-To: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
References: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
Subject: Re: [PATCH v2 0/3] add channel constraint for BDW machine drivers
Message-Id: <158808847385.38342.17676813183484650913.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 01:13:31 +0800, Brent Lu wrote:
> The machine driver bdw-rt5650 (for Google buddy) supports 2 or 4-channel
> recording while other two drivers support only 2-channel recording. HW
> constraints are implemented to reflect the hardware limitation on BDW
> platform.
> 
> Changes since v1:
> - Change the patch title.
> - Remove the DUAL_CHANNEL and QUAD_CHANNEL macros which are too obvious.
> - Follow the naming convertion, using 'bdw_rt5650_' and 'bdw_rt5677_' to
>   name startup functions.
> - Refine the comments in startup functions.
> - Redesign the bdw_rt5650_fe_startup() function for readability.
> - Add an assignment to initialize runtime->hw.channels_max variable.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/3] ASoC: bdw-rt5677: add channel constraint
      commit: e241f8e77958de2b7708e72d7159952d2bd1f0fe
[2/3] ASoC: bdw-rt5650: add channel constraint
      commit: 08d6713a4056cab5b29eb135eecb2e97492fc8d8
[3/3] ASoC: broadwell: add channel constraint
      commit: ad18763f46835b768714ac6de6dcf42384a261ca

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
